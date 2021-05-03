Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7874C433ED
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 20:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775B1611C9
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 20:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECUeR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 16:34:17 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:27617
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhECUeR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 3 May 2021 16:34:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHbh1eeSHM7yGp2TfS2feHKA8kduXtoE5r2OEKINdW7KI+6W77pRfuK4BZ9GcbP0W34rIYNzMYnuK3X0FDwRWF6PwqoiPSNXtmUO/WAZgQMYJf9cFNS+V4x458/r337nH77LEaYpQxM427G4OH0g7LwS5kgM906oQLbuzZCn1CrEtGFtaVFf6UcV3R5cceoaV2uRowwl48xle1G7pgrJtI2EW74gdMgehmyBI4edKTYAQvkbrqP2fhmQntzPDLlHK66XxxV+9tmQ5vgwVEorue4Eghe/XJePOOEsuGhjT3bHpdwDa2tM4WXLu+nP1Nmt4pzzhenyCN9klG189AG/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehsQSA1pNBGIWVvQuf7NspQbmRUYDK9WNjY0Gfv6MqE=;
 b=BwEhMzr00Q9KgdbBDdZ02EQhI4cRNQ/gVgauUAS7Wuz2Z3n0Qm/yF2lqAJB9nkA2XKN6PmHSmYKh+ZYC3hnN4G8EB9cXOaOFRpJz2Oxc8mbLldFL7HEhCmpHeGfOYgr7phE4UwJs+m1qBgFlE+xI6ruN4a8wAuPMt/wXglL1vqg4r3mLwlMBzCL0zVRiGzWLddrNI1bEcfHmdcK8OVE5eAfo5r4GCUCkrAQ/L88eArx9aE1ohFvy77StdV2X7sOvQYYQL2o8sL82JSRM+iaEqt/zeKVLs5mK+YY5iK5NfL2rgOOhpHCA0EEa/pztyVcObTcS+DkdjPwCI8yKHVkmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehsQSA1pNBGIWVvQuf7NspQbmRUYDK9WNjY0Gfv6MqE=;
 b=HvGUsJbJGtxlRCL68yaqB869PeVhqodw+pJH5APKQS18/dXbVggeDmGNSTTkCi++8wPMIYxx5dPRHV9ngUwgtuQq/IM97TKLqCfZ6Ci7s11dPzTt0IDGozdLOCA7bAPRfQrVFmQWD54L4GWJL46ZDyWnTY4UaVhl0uK8JzN63Ahpj6cYd4SAlEDVOOfTTotR/Gq24UKOMjauL3xbvgIC2ul/CZv0wDallWiCdsx1hNnqDPRt8b51v1tXygYNRe1teLzwApoD1HD4RgfOFCeDBY7jLDzAEGVR+Ekg35wmhAFDx5ZKyL1oJOu3cJIuPqjqse6MpRAkQFAtWLxPyijMbw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.40; Mon, 3 May 2021 20:33:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 20:33:21 +0000
Date:   Mon, 3 May 2021 17:33:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>,
        "Jason J . Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210503203319.GP1370958@nvidia.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <20210426194859.1665730d.cohuck@redhat.com>
 <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend Transport; Mon, 3 May 2021 20:33:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldfFn-00H1OM-Cd; Mon, 03 May 2021 17:33:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c43a382-efb3-47b1-1301-08d90e72b10f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1515C841DD70EB7BAC62D016C25B9@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3h7sHaorFnU0nPKaYrAFAgFE23pwChuGaTXIk6JWK9ydEwq9FUAS65FgMRaXNB1ouQx9LlF3IG3U4yt5FIb3BCQfN20TcMRWGsbzum350NRc/u9zJebiXIRMq5wsAY0rF8x6CN4bTkpkYlByE8E6mmyfEuU/IEMuz0VzwOAx8qWXBuW1IKiWuEMQnvj9Zq2+xYTBl21JNkdNVLX9IKAVm1kSfnHurFrGHWli7vjA/2lphL7gYr3ypbTEc+iQLN3uhwKs8TE2goKe9R3KnM9Fj878XFuk+Qa/BxY6weUzbA0uOBoFvTBvHBiodoUnJo0P6vePp82yYVPwgO467n1y51INGJSe47mJQakJKgGus8mizqjjkhrI9s6IERTFPNSsvDwalnlNBWXEJyfPu5NOuLQqpez5USe2AyA6unFwbwgPAYSBL9G6Ok0Vj3gk/9Nc9CNl4q6VEs4erV98eZra8rrBJtmcpVkb+1EChMiPMywG4QM1MixoyyctTwXSqbmvEU6Da09cSs7NNy+vk/zH4TcSfJrsyNdk+OgIMyo6teiqpk0VwDdU4tPolc19kdO4flREiUsC5Kf+Ep7WmqLAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(2906002)(186003)(7416002)(8936002)(26005)(8676002)(33656002)(478600001)(66556008)(66476007)(426003)(38100700002)(4744005)(9746002)(86362001)(9786002)(4326008)(1076003)(2616005)(54906003)(6916009)(5660300002)(36756003)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LUPy3/f5rvT116lTpiV06MmF5EAXa03maXvfmtTEppS4oKMRF74tU7wM2WBd?=
 =?us-ascii?Q?U9JmMvBapHKdSkvi14cx48fNVnaEWXXObrIuPNCH74KL6dNyMYu6XwifGKdw?=
 =?us-ascii?Q?ygkR6wWrI8v+MGmFeMCoBrBzJgdzDcRXzGSr8/TSUfwmRJjO1xzfg8k6/W1e?=
 =?us-ascii?Q?DhDOzk5p/Y7uEh+qgNdawkO+KKYnd7fk97xOYYU0wlD0QB1XG+Cxli/s3h+/?=
 =?us-ascii?Q?qogH/Df7Wqf7EVWabH6sjEM3ZfcoQeSgxVsxagruvJqQpCNxOtiHPlkd/4FS?=
 =?us-ascii?Q?Hm22J4ex1k+W5NlnvqudySLxEy2xVLLXAPn/XX2Esv/VIl3T1MRxKSHMMFDk?=
 =?us-ascii?Q?lT67F2fMWcgqlJ+Pf6AlWeGNdDVGrXztyUTF+xSO97SUm6HxAKNdi/dJKsTS?=
 =?us-ascii?Q?569rNc+FadS3icGxj+rWRUIKaCsB8Qx8Ykq8RYYfhpl50KaXlNZwkYvomG7H?=
 =?us-ascii?Q?ckyEp/9J6tyqDgUkvIbrwJ9KZ9aYI3/7TFQ+TjEH77kaXkPSmuckn+NSUtHG?=
 =?us-ascii?Q?aHGF7w596UQAGGYI2+QwUV2CLJ2yVO/jyNvSnNbG6ctXGsmjFj36vjS/NB2R?=
 =?us-ascii?Q?SMYiYpTMfuFZjMLzLq5dfRMwVBK5Q2oyNvb2WvAw2/eDwOixNLwtzsUD+Gxs?=
 =?us-ascii?Q?lVEUyS+tEvuXiKbG6IxeUt4O8lKBPqq79NvBrOdPjaoFOfsIllq1nS0/KnQP?=
 =?us-ascii?Q?Qv12afyR5OxFvrO/ptXyOIiR6UNb4i2XBwGH2ufzDCAsNIMPE9TELRpy7sPT?=
 =?us-ascii?Q?4/56paLTuYjjZJ7u+WfF2kKCtgOQR3P1iysgTfpP/2LheZyJyoVHYG2oT9b5?=
 =?us-ascii?Q?QxhUdTJ+aoYp7iF1zmINRccEbcndQWmLTyxubWIBCvX5ZzjTcL/P87YJBPeu?=
 =?us-ascii?Q?S0PstBfC4x+EsOad1N7rcMMJmaOfY8hit5jk/D0duQ+B37NyhvlnpOf4Akh2?=
 =?us-ascii?Q?iae7ExEL3BP+qrHrJmPPvpxSGADn/ZAZfwONsOzWeCwB8YWCX4g8mxF4zXbJ?=
 =?us-ascii?Q?LcCRacsnrvBN3bApz7n5NTz4cAptQZu4G0batbDt3KK0lhJFwXeB/9iaVW5v?=
 =?us-ascii?Q?4RvPBWZPPe6wARF7XsHl7GHQPfaucSCVlxKW0KS17EGfGu5z4P8Ru7p+x+1W?=
 =?us-ascii?Q?6/Os+SGPbMq3naGQbdWG+JjqLPGj/hb+i4Mtw/0K2BGqZPVNZ8ODBqQk8mPT?=
 =?us-ascii?Q?QJcoAS26CqsGFxk0wexCvR+/etm4qPRFIoUz0DsGg0nxB09eFiY327JByzdM?=
 =?us-ascii?Q?7kKu6ZLqU/vSVVPlk0hU9l766MOJST9INH91atqisWXY8SZ8zrK+bbJ/4I6Y?=
 =?us-ascii?Q?1bfmUaOaEv6eW7YwmG1OChc5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c43a382-efb3-47b1-1301-08d90e72b10f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 20:33:21.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyhFG+dm9QIShaZu6CMc4jQNSgCuxrZLBhTQqBanur/cuwyI34Ifp+I5YTtZ+DvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 03, 2021 at 04:14:43PM -0400, Tony Krowiak wrote:

> This case will occur whenever a user removes the mdev
> by echoing a '1' into the mdev's sysfs 'remove' attribute
> file. I'm not sure it can be considered graceful to take away
> all of the crypto devices from a guest while it is running,
> but there is a way to process the remove callback without
> leaving things in a "weird, half-dead state".

It is acceptable to just sleep here until whatever user controlled
condition is resolved.

Jason
