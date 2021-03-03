Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F479C433DB
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 22:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEDC64EF9
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 22:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhCCW3g (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:29:36 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com ([40.107.8.118]:20389
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1839533AbhCCIKf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 3 Mar 2021 03:10:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI4SAZ6yqWkwRRerAn9F118P/NjEVkUKDxI1eAMC8VVzkBnRg4ZMt/uy5mC+gpUbcKAIQtZpyYHzgRfeH1P/q6Q1X1Zb8f4jO9r3tmYljLaQrEPZxWU5PX+MzYH5m/9MQEF/3bxvUahXqej+mcde6Y6KKAmDznHsBd2e3ac758ZPmwMJy6BmnK49/c7H9rOBBMYJniv+7ds6Wfvd/22YX/vQKvowGZPZXYpukfKRTW7Xk8Kzac2PVCQKEwZHkAjySbuViv4EeaFsHMcCHFeEhkWx3Pw8+w/WwuEa3Fb52E6mr3iY9enpbpU0mNnrNesEsg6DUA39c1OmhLNXe9fA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE7uPPei3pDKYvFuD2and2YbYh4wb+vRfmPRdlXkWng=;
 b=Jv1l66ZHYUqfLpnRhsQb4AopjOm5TkZs/+0h8HyVQohxqq0aOzREBIDjJpFZvqsGcquV1cYnU1BharvDgFUSDBzSO2s1UiYpD1o4SIiEC+Zjve+8bj3vX/KntvSPzPpEOmtojb3SsrmcmL+lTLUlcBYWvRBiTA1W3CtYRooN+Az1zo5+biJZ+U9VIwJYOMm59FgQOdRzdLAouG9MixFP0QBZzkHB9uuDpRH1xvikbBq/ZbLFh2ncx6oRx0fuBep++1zmOQ4L1KhXN3ZyJGFEsA1TLnVnZyxshgx3uXCPw+VMkHiuk6vs7B8Bg7pSVzU4JYeN7wA+j+qmzsJXnyaZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE7uPPei3pDKYvFuD2and2YbYh4wb+vRfmPRdlXkWng=;
 b=YKVw0rmMIWw/Pea2mYQ2XQBC3jtBKFhJlCGQ6Pt4z+YknoJieh9N9iVI+ddWbtQVJoXZ+NLxuoB3QlObql6H5sQWv1C+DqlOZ30trgAHkxJ90GgxHozYowwwtDl7nyzBY0XUTxJgjmxNlZtflMKoR5FGUqDAGFrzemzmyXEt4SQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM8PR10MB4193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 07:50:21 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 07:50:21 +0000
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-s390@vger.kernel.org, smatch@vger.kernel.org
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: smatch and copy_{to,from}_user return values
Message-ID: <b57b4f40-d67c-d57c-c5b2-077b623ed4ed@prevas.dk>
Date:   Wed, 3 Mar 2021 08:50:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.141]
X-ClientProxiedBy: AM7PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::19) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.141) by AM7PR04CA0009.eurprd04.prod.outlook.com (2603:10a6:20b:110::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28 via Frontend Transport; Wed, 3 Mar 2021 07:50:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4639db7b-4449-4a12-fa67-08d8de18fecc
X-MS-TrafficTypeDiagnostic: AM8PR10MB4193:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4193EDBA4D4948282D271BDE93989@AM8PR10MB4193.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLS70v+aawb+Hx0w0Qaq0nlOvzlrsMAgFtrrVnwaUZ9WELAYbtkscTnlggK8SPAKiZ7F+tEtVsQDhzNMwt93huklw98+6Htiz4Keh/cOXv4OCvOCbj6YXWufPxRH7bA+3hBy/iRzP9eYPMTmDMAhTDMqNJRTj6oJlmPrtgkrE9aFojfBt/NnLNuXUjWk5G0XBzSOLkODvP87ijYL6Xnb6tqYyd90IIUQBn3tQFk8O4O+ICoyd1VQn7tJgclt+cE9i486Afwvcd4KeGaPp8a8EhG3kzVkDLdNKBftkZlw0/oBi0PYxC/XUXlrH8AFrZUSr4VFDtBKEl78Mk0dNJRu9LFcld0lExJHmONO9XeiZravRjj2hCxV4Fvm0v4hnpiNORdHud7brMGKUEef15Xmr9iUUuLrKz/54ws/wn0IBaqfMEBxdqyPIeUE/w1T3dNg4veUNk+B+k7fv/hA+0MG2DJY/8kN/c0CtA2LXihXP0OmwqSK/xT1h1WW5cf+CRGq1EEPcNDQdt3PIipGvX4Z34DsJSgXvDXpe4rB3sqNMxiaNv6mT8YDl6nzZveDR/tPJt9RYL9SLY+/Ts36EmAIB0ZNutif+qgZ7R7BkSyNe/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(52116002)(8676002)(31696002)(36756003)(6916009)(83380400001)(86362001)(4326008)(8936002)(498600001)(2906002)(2616005)(956004)(8976002)(66946007)(6486002)(16526019)(186003)(26005)(66476007)(16576012)(31686004)(5660300002)(66556008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?e1KNHyYmojZVKY2mFv1j7tNzx4Kc65YRv0P59c6SMJrGHgmLb2OV9nei?=
 =?Windows-1252?Q?qdlUAdJ1QqNSEJA8E/sMydUNCJ8+GxY75WkORR58MAyvPfQ4s8XO1wZE?=
 =?Windows-1252?Q?ZFS1S59yDXpzWkgYfm9zKW0ricsgd8goXbqwHL6NKC0g8sZVRsnVVVVw?=
 =?Windows-1252?Q?8oUH2O6LPkZztbfgYaD7phTQ06uxzRAE9MHVTtCNK7LQgGTMZSyPAyr3?=
 =?Windows-1252?Q?FLEoNO2lcvclmYBjSfmBRbaOcAsglpaWW3t7WhrbL+JIoadJb+9FItL8?=
 =?Windows-1252?Q?TooDN+AnHWSLf1k7gzk25PDSTS4IsijHCRR2PIWpyLHbwGmtfNAMlNmS?=
 =?Windows-1252?Q?LBVIX8MasyiCRS5ysiSbrbpkrQQbhAyCHrt5TbOxSUgAhiIdqQsI95TY?=
 =?Windows-1252?Q?/mIAuwfIAG4WOCZeO0oxMwC04MvXpHSB1qBu+TSnOwOP1F1rC398AM+c?=
 =?Windows-1252?Q?JUx9Dv4Td3K7cyYWFFSxRvl/i7lW7u7CmDZJMM/pTCu4obdIZdWnPD8n?=
 =?Windows-1252?Q?KUpqgJKrYk+GWJestl0J4NxvU5/fXAaerURK3PBlmuXei/3ci0mqVnpf?=
 =?Windows-1252?Q?4UbR5Vr3xbG3md6DozdC5c2dOI1sMp2dUEaKaXF06rYfWoTrPTr89vcN?=
 =?Windows-1252?Q?5z6eSg9D8S6KNkmq0JqzBVv9SqKoCyAiQwl5JdkpGo4PpW0fBs6xSV+J?=
 =?Windows-1252?Q?qo4wXiuzJFb5MQ9sGc55KV90nGiv/dZI6OIWcrpedrNpOeemSp0Z+zJc?=
 =?Windows-1252?Q?/UfP1NXAh4egIht8oDs7vacWI4nHM1xlj1QgROrQXtVDeVTEnoNkFzb1?=
 =?Windows-1252?Q?olnQTG9m+IcewEMKnouQ1ez8M1JjYU08gBLxmUvJrXcCrEfImCuMLHyH?=
 =?Windows-1252?Q?ouklcsRFvKRxDy6yXjFJhm1Ynyn41qHjQPHN+cXtPXQUjPZtHO+6SS5r?=
 =?Windows-1252?Q?2+Hj/fUSc4I2WSaFAp+LKyw9FBCEUuNWzKehYike3guTnMHYjEKg3KHp?=
 =?Windows-1252?Q?eLEp/Beh3fhRkLRuTHN1qTi+T9sr3mh0M0O1SrW2obIJshRWAAZ/WIRv?=
 =?Windows-1252?Q?CXJfjA41KAyY9l3sbjPEQs4Ww9vjkUvtmKYSK/u3gyb6nskh10AYWZPB?=
 =?Windows-1252?Q?qHwja0sV85TjmcmxAsXlJb+CKWYzpmUKKGEFiY4NIBGAv4JO1GhdaCeC?=
 =?Windows-1252?Q?U7vo9at4sgYHLwdRFNB8sAGH3ZCHQnOhSWIbSNzr9W3jaQa4QrDg48Uc?=
 =?Windows-1252?Q?+ttgdsJhohNylpynbUzs77f6IrEIECvQUwKUHxv1AKEboYc1FXxQvneE?=
 =?Windows-1252?Q?mGHAEi8G6cnz0GmePxlNgs9ek8nUJnUb4DwyNfgGP7XsfFFa+wUplOz2?=
 =?Windows-1252?Q?xkmAvGAskljoIyX694YxzwxWTj7TImxaiHr5rigjrMJi/FLs0RhQt9Gq?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4639db7b-4449-4a12-fa67-08d8de18fecc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 07:50:21.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77vjpWL6ILWQj3m1UM83BgfXbUsiEsymd8eTzcCqAfPH6uQrWxt5eWsnxVK0auhEaoNnBZ008qOc55EwNj5vuMStzqAzTcASl5UMUMabieQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4193
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Dan

If you look at vfio_ccw_mdev_ioctl() in drivers/s390/cio/vfio_ccw_ops.c,
and vfio_ap_mdev_get_device_info() in drivers/s390/crypto/vfio_ap_ops.c,
there are examples of functions that can both return -Esomething as well
as may return the return value of a copy_{to,from}_user directly (i.e.,
in case of error some positive number).

[Those "return copy_to_user();" should probably all be changed to
"return copy_to_user() ? -EFAULT : 0;" - cc'ing the s390 list in case
the maintainers want to do that.]

Can smatch detect such cases? I seem to recall it has some concept of
tagging a function as "returning -Efoo or 0", so it would also need to
know that copy_{to,from}_user does not return -Efoo. And it also needs
to follow the control flow, so

 ret = copy_to_user();
 if (ret)
    return -EIO;
 something_else;
 return ret; /* this is 0 */

doesn't trigger. And there's gonna be some false positives around signal
frame setup, which do a lot of "err |= foo(); err |= bar()" where foo()
report errors as -Exxx and bar can be a copy_to_user(), but in the end
err is only checked against 0.

Rasmus
