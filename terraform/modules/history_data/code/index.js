const AWS = require('aws-sdk');
const s3 = new AWS.S3()
//const bucket = "tt-dev-s3-history-data-bucket"
const bucket = process.env.BUCKET_NAME;


exports.handler = async (event, context) => {

    let data;
    if (event["Records"]) {
        data = JSON.parse(event["Records"][0]["body"]);
        let approximateReceiveCount = event["Records"][0]["attributes"]["ApproximateReceiveCount"];
        if (approximateReceiveCount > 10) {
            console.info("IGNORE: \n" + JSON.stringify(data));
            return;
        }
    } else {
        data = event;
    }
    let fileBaseKey = null;
    let fileData = null;
    let metaData = null;
    if (data) {
        if (data['TriggerType'] === 'channels') {
            fileBaseKey = data['MemberId'] + "/" + "channels" + "/" + data['ChannelId'] + ".json";
            console.info("AWS-S3-DATA: file key : " + fileBaseKey)
            fileData = JSON.stringify(data['ChannelData'])
            console.info("AWS-S3-DATA: file data : " + fileData)
            metaData = {
                "ChannelId": data['ChannelData']['ChannelId'],
                "Description": data['ChannelData']['Description'],
                "IsPublic": data['ChannelData']['IsPublic'],
                "Origin": data['ChannelData']['Origin'],
                "Score": data['ChannelData']['Score'],
                "Title": data['ChannelData']['Title'],
                "Deleted": data['ChannelData']['Deleted'],
                "MemberId": data['ChannelData']['MemberId'],
                "Active": data['ChannelData']['Active'],
                "ChannelPermission": data['ChannelData']['ChannelPermission'],
            }
        } else if (data['TriggerType'] === 'channel-filter') {
            fileBaseKey = data['MemberId'] + "/" + "channels" + "/channel-filters-" + data['ChannelId'] + "/" + data['ChannelFilterData']['FilterId'] + ".json";
            console.info("AWS-S3-DATA: file key : " + fileBaseKey)
            fileData = JSON.stringify(data['ChannelFilterData'])
            console.info("AWS-S3-DATA: file data : " + fileData)
            metaData = {
                "ChannelId": data['ChannelId'],
                "FilterId": data['ChannelFilterData']['FilterId'],
                "Filter": data['ChannelFilterData']['Filter'],
                "Deleted": data['ChannelFilterData']['Deleted'],
                "Origin": data['ChannelFilterData']['Origin'],
            }
        } else if (data['TriggerType'] === 'member-notification') {
            fileBaseKey = data['MemberId'] + "/" + "communication-preferences" + "/" + data['CommunicationPreferences']['TemplateId'] + ".json";
            console.info("AWS-S3-DATA: file key : " + fileBaseKey)
            fileData = JSON.stringify(data['CommunicationPreferences'])
            console.info("AWS-S3-DATA: file data : " + fileData)
            metaData = {
                "NotificationId": data['CommunicationPreferences']['NotificationId'],
                "Description": data['CommunicationPreferences']['Description'],
                "Name": data['CommunicationPreferences']['Name'],
                "MemberId": data['CommunicationPreferences']['MemberId'],
                "TemplateId": data['CommunicationPreferences']['TemplateId'],
                "OctMemberId": data['CommunicationPreferences']['MemberNotification']['OctMemberId'],
            }
        } else if (data['TriggerType'] === 'linked-account') {
            fileBaseKey = data['MemberId'] + "/" + "linked-accounts" + "/" + data['Platform'].toLowerCase() + "/" + data['LinkedAccountData']['LinkedAccountId'] + ".json";
            console.info("AWS-S3-DATA: file key : " + fileBaseKey)
            fileData = JSON.stringify(data['LinkedAccountData'])
            console.info("AWS-S3-DATA: file data : " + fileData)
            metaData = {
                "LinkedAccountId": data['LinkedAccountData']['LinkedAccountId'],
                "CreatedBy": data['LinkedAccountData']['CreatedBy'],
                "Deleted": data['LinkedAccountData']['Deleted'],
                "LastModifiedBy": data['LinkedAccountData']['LastModifiedBy'],
                "UserName": data['LinkedAccountData']['UserName'],
            }
        } else {
            console.warn("ERROR: Invalid type provided." + JSON.stringify(data))
        }

        if (fileBaseKey && fileData && metaData) {
            const uploadParams = {
                Bucket: bucket,
                Key: fileBaseKey,
                Body: fileData,
                Metadata: metaData
            };
            await s3.upload(uploadParams).promise().then(function (res) {
                console.info("S3: File successfully uploaded." + res)
            }, function (err) {
                console.warn("ERROR: Error in uploading file on s3 due to " + err)
            });
        }
    }
};
