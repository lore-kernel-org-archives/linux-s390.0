Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB4CC4338F
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jul 2021 22:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C2160F37
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jul 2021 22:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhGZVXD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:23:03 -0400
Received: from mail-sn1anam02on2058.outbound.protection.outlook.com ([40.107.96.58]:28142
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233365AbhGZVWx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Jul 2021 17:22:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAMLb4IZxZM3a0zl+KmwPbcyfpMpA+GkkJ7QdqcmZD6I6sV4a050Ql7GK6/cIU5jLaVGf7h+CYjlvIyUfFT8KvdefE2z679Y8koKghnlmOIsl7Hjo6FYpofJrSFNtTUg2gbdGocjRk6KsltGlWAVjEMc3zxI0AmEhwDSrjNzWtvwORIsx5qW4Xr7DEtZLjmGZh4Umjd+iEErX5kMc+lJ8vVGxscWWkbFDRzOdy2wFotX9r/bKkr6DYj+wiKN2LQi5VlR0JyYnNwsP7Nz//JerXxH1aphcszEkO3V50i8KzdOV3baXcd40YapSGygLT+RTpA3oXZDtX36RQlcMAqqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/2Az1GE+ThOm42UMXZQvEq4ET56GIB4lAp2ZCtT2g=;
 b=EJdkVdo2DzZvC7K2n+fW4STnOemS7Bum5RTUCUo7/tj7l++pcXdrUrmNFXWqw07jRaDGEsAaemEiLltVYhRioVO5xGeP3Z2lsFymGOc6MBNcKqCEq/Vjn8prNJbePAiplrCGo2NFHVUWjbEfbTgTmaM97ftSsJyqz7dcs0pcE/SG5jvXrsdmx2e2VR6T9kRtgJi/HUvCUWOpkE50vAQ2oTQuVx41zE2kOT0vzjBgLGUHUNyDGl3xCiais05IeDFSI0dQAmoPkMyOjLAhj/x1CvWobNiwC6HTFeumLnHNmXdHfGey+ACMKFehbwbbUzQaI9Q+8sa/5iBFZfa0Z3B82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/2Az1GE+ThOm42UMXZQvEq4ET56GIB4lAp2ZCtT2g=;
 b=pLtABB3za+xlT7Y2PDfF3tqbvzpRsV9ojNxubrFunJeFkLwjQa6ldalBCd1Ieygb0okMxtkUKquGrSs5C/9DhFFjfUDZ4vmSdtMbknFXdTq1Xf+gGdOkL1SJzntS1cBTJ5Lp/cTZvXydckgfzWdecx3C2LXnAS23UeNraD444ClUKlgGWknT/cZquWeoCJbNN6yW5j44IuAYHrDAMY+CY/oyS5Yi3TZ5ZhK2JsZCKXuKWTy1LMCamyqpj3O5myoG8q7hQGmCqmXNAkNiTPRUOGNKfFUFfmm1ZrDa60vMypa8DiHz2Adtm8PYDkzgEbG5ccjZvHFHV4W8VmFVvDJA0g==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 22:03:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 22:03:20 +0000
Date:   Mon, 26 Jul 2021 19:03:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210726220317.GA1721383@nvidia.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-3-akrowiak@linux.ibm.com>
 <20210721164550.5402fe1c.pasic@linux.ibm.com>
 <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
 <20210723162625.59cead27.pasic@linux.ibm.com>
 <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
 <20210726223628.4d7759bf.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726223628.4d7759bf.pasic@linux.ibm.com>
X-ClientProxiedBy: MN2PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:208:237::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0062.namprd15.prod.outlook.com (2603:10b6:208:237::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 22:03:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m88gv-008pgE-B0; Mon, 26 Jul 2021 19:03:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c34db67-a77c-4d6c-2026-08d950812d28
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50472C6AFB3C119505A0D07BC2E89@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7y+hYUdvgGBc4XvSu5Y1E0x7QYoFCzA9LU1LqkX5GPdkyKw8eq6bi7vCESBRjcRJjrm8Fu9aYu+cJKtEbq56rGqlDght09iR9urodVFvlLSXWDTrAUWRCEh4MR3k256BRtMfZczAmTeSa3PaDZGz7PKo0ZHZNHP33XzRWvGAdBEp/M7lXO6x/9RGbtJtXwfh52borcTk1aRE6vudlFPwKxb55QxJy1q5D4x8Qm3ltjhsPVnEflxZxP3JHDd8SSyO1pgPKp6tlS3FxnjQrGegw9hoGHF+bgGqGwTbGL00MSbhPy59bCsQGTpLTfQ8KW5tYzuwPxE0lFuBrLfqjkmMLb3oxciQoDi32GcWhhFZw6cqu2LPqROvJTFhxg89w6BjPbLKj+3YDStYNDMcof9Fz8HPih1dlA3iffiKtHVAG0iwHJLmSdrijtveal3VTNLuO0cqfMmyN1PeWdBI31qY5/qkFZKAyAMmL2jS8SxJUdQDU0mRF8lWf1y/o+lux1bCG1p5q/zFvY5AtqaxTlX9XK2ifdMyomAe0+9BUNhRdLHnL652cVbZLq6xl0LTH/1+I9uClRsrcGwHodjXjPOnTP/RyXu4ga4QS4BlJCoRzhaG8DL60M7u4g2xf0Mqg65GS7YLWvIfDLRFksjAmTHo8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(4744005)(4326008)(2616005)(7416002)(478600001)(8676002)(8936002)(5660300002)(86362001)(316002)(9746002)(1076003)(426003)(38100700002)(83380400001)(66476007)(66556008)(9786002)(66946007)(2906002)(26005)(6916009)(33656002)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8yD8bbFhqNIwmUE/db9j+yqye2Ht07RHV8icixVYhpWy7wnPyp4tb3dIUO7?=
 =?us-ascii?Q?xREbSaif5GXq7wzpauRmZ0q7/uYgstu41LKJ/NtCg73wLwq55Hpz99PAuKAr?=
 =?us-ascii?Q?hMaz/2wMUH/pYShyE8BH/yg4ZeLjM1l+cwm5lwT8+wrFxeKzQYRK4aXrkYnb?=
 =?us-ascii?Q?ZZoWBCPvWljev5Vvkt7YXoM5ltz2QKYrIU83XAcQaClGJ0nJO75PkEkMc4EV?=
 =?us-ascii?Q?nlgWZGFBQCHgYs9VYhTtb6GLnd4ZY1baW5Heooa0fVpxVK1rSDDSAqeYTfoh?=
 =?us-ascii?Q?NrgiV++8CtHuxcMq7RBg4wJT1ELqxWs6yD3T1KwgYQgqgrxIbtwwZsInCH+h?=
 =?us-ascii?Q?pTcuDZlx7uxP1Ta3KV7XLrfFMvrBR76+DXWvMydzLjxwse5jYQM0+dHq3fLI?=
 =?us-ascii?Q?Soyr5jBjxDC7AewIjsFeU0HS3SNje+buYHGHysFiisGTNGHN4RQ/5pwodzyX?=
 =?us-ascii?Q?ogF/Ql3Cyq8Zw/TrWrirtlwPr1kQE5UJuLdMLLUfptgpz0QLQHrzBEO4qE+f?=
 =?us-ascii?Q?/1fdl83WdurgyHl5egJvx7PSOSNhDklTjyqc5gWKQN+ZU5CdBZ7otSqNwF9C?=
 =?us-ascii?Q?qKMxad/zXUy/s/ZTB02S/he83JREYjTp7+o1wUzEhmErsqbz6Ut1sy6JTDxb?=
 =?us-ascii?Q?wObIeaXLvnAhnaBRw1gHpTuhE5tGBrYiz4C4C036hhO6Y3fIbwWnB3QgfKz5?=
 =?us-ascii?Q?ZrfpCTNiXWlNDJJEvj4U2m6yKDoKIUtK9tfisRUSeo/V1DxiyY56b4AmDfM3?=
 =?us-ascii?Q?1uG/+1v7w/BR3oDdhaAm7faUPKecZG/eKLk2LbYI00LASrPSCbsn/1GmDl1R?=
 =?us-ascii?Q?FdWwIZMS5SGDM1r1tCl/44skAQI6a8LqkRycuGzwFFl0/is6lyStyTUj5QXu?=
 =?us-ascii?Q?WhKuN4ragnpkO4S6FuWgplzN0nE37weDSBe03IlZXORGzO33xqV1nM1w7EBC?=
 =?us-ascii?Q?HmfCExrLCbtAvBVsfdnGq9SlIYsb200Gtlr6ZABr83ereGW6QRW55QYcAHQT?=
 =?us-ascii?Q?v6srIZKnwcWIit/wdYiaRNuSKNAKqiFj4sHHNJDf1FDSaSVD3QleaWCo7zGZ?=
 =?us-ascii?Q?ZhYokqqvliAUXwlnnnXj1RDBnhq5eGow03/wbdEXLSOrrhhqU4LnDsoNhNns?=
 =?us-ascii?Q?BB/b4SBJ6Tl+sFOfJoEvO4+FmBFxLKqP93RmJfWTJ4SAZpzRw4rkfDV1wkC/?=
 =?us-ascii?Q?Bt75UfSaf007jhLKYHYY3FEMwEkejxjh7kVGmUPwDNyl3I4Uc5CGD82NDtqb?=
 =?us-ascii?Q?aJroSYAfVqHE9WAXU7YM/raO5H/KoihNC0s+I4YlpOWCyWrlYrKJ6JBpBiAl?=
 =?us-ascii?Q?gu/UmLpc23NZAtSIqkXX2PjF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c34db67-a77c-4d6c-2026-08d950812d28
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 22:03:19.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRNbGH3oDa1anxGHtv9tSYWlITlMdPv7xMQfy8LNJGNKvY+x1rOr8ejJAWPIPHbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 26, 2021 at 10:36:28PM +0200, Halil Pasic wrote:

> You may end up with open and close running interleaved. What I'
> trying to say is, to my best knowledge, normally there is no
> you have to close it before you open it again rule for files.

This is an existing bug in this driver, I've fixed in the reflck series.

open_device/close_device will not run concurrently, or out of order,
afer it is fixed.

Jason
