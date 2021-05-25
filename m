Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E2C4707F
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914466128B
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhEYPCc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 11:02:32 -0400
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:62400
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234177AbhEYPC1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 11:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+sg+u+jBR+uqvPjtl0A2gq2B5jKEr16jD63yOBTiqEcpN0LolfACqcyqSPNXJHtDB8UTiOKI8Hf4Xl6liDb9rAv0q+ILNPmBQrw2w6W5rqPBqVVi4iPFg53nrhiKLI6uKKJXNWmgjqw2zINbKvuUaR/QcPGCLYhE7sdQEcC17Pf3nwhe41K+sHIHR3zBalinRPjFP15SwZwrZ1/PcIcKAhFNFqm+he8x3dCYNEfYNiYf1431UD/q/Li0kPx9hrgqGwPqIO/OTr4SXCVaU6zC7wshNk9Jk4llJXdcqpduvJI1kAXspFUkBVwkMBgr0eaHOVXFDaIkjrCmHh/bw6+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CBUHXdPulBvUixBwdDTpw5wjk3VqHx2TdtKe9MQRuY=;
 b=USrhnMdZkTsb8IiIh4REjGZAVq6+i8p9qTF1LT+GKltvNq0CVYbPSQpP2zx8BOWhINeG90cVPOzxhcmxrgpg+7Bo81/tmOdg+kT4LuEs2gII4b46simfyY1iloU4hiWCr+gqBicgU/f+1gLBpwEfFOpptyRm3ovF/hWcXCZ+vsnmJ4E+1SFtKCNPkk/ecaGT609jHm32IX44BWwB/+UhiyDyy95L7Ud8trYQ3uicHp2cGyHcORJYrYvoxmfYJdmM1KEuQun3YISW3tbGpxmlVhdZsFLPbDPYQhcp9sa8yHC8W1EaaWRUyINeimsuBNPIkpk8an8Jz1GYqGug7HjMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CBUHXdPulBvUixBwdDTpw5wjk3VqHx2TdtKe9MQRuY=;
 b=MoxzquGx+ZTuDmy/V544hY6/cIeBfcm0aJ5T9TZPw7wU4pIg3XS87MVSHxrbMByAbs85pv0pL6/n4wsVWVGsyV/Ng4JEqdfmIVkmb3VjngT4cmRksKwFSD55yrGmkbZxeQcHaZfY2JXgR+4tqOsNuKZSZMLn6NRSMoEYOfepXF6/PrLht5TKTDh0sfNYrjF9Xe3o57ItTTXZDgf1vG5clc/yLIvpYNq5OQ455e5Zo1/23FAbvmA39EdyNIJe8yGtOj6K0L4SgBqvRzLhUNLfrLvmOGSU/8xjBEUiQLJHe81lsBaKtFp2UJdgejsiq1Au47IOJGncJc3k5oH74JXXDw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 15:00:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 15:00:55 +0000
Date:   Tue, 25 May 2021 12:00:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210525150054.GA1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <20210523225746.GF1002214@nvidia.com>
 <ac5cfe4a-a61b-2226-58aa-a5ea761180be@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5cfe4a-a61b-2226-58aa-a5ea761180be@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:610:75::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:610:75::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 15:00:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llYYA-00EOvu-AV; Tue, 25 May 2021 12:00:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 337a5b33-a9f8-41dd-336c-08d91f8de5ca
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111D428EC032B45D32DCA7FC2259@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oy14i5zeGMR8+Nzu2E/6TW7NGJJPP4Cj8bQPHd1JdMfuXEXSQ4M9NkKsoGivr4S3BYXPbhmptE4uIluUcEh8M9MTx2s/jHMsqA7EAUyDcOoCbraskjEv7EmB5LMF76oa+d9gErT0/qMOxR8SBl4XejW0055JA6GXQl41OigwS58JgnHCLcdcbl5OhaBL4tXcZ+EPKmc3LxLchXbYyQrM8DLPr3lyMCa/Ya9bWFhqLt5/ZdU7j52BQ3U/0c/8fx357A/vC+ZpHiGeCzjBb61Px8V+0h5m4BxNBRcqMRkfEG1wSr3ygAltCPDeiGu8rtKeni6p1yMhrW2gD9iLnp5j6O1yJ8Y0AstbNhhqK/67SdJ24Wr6eML0T9+Id9TSS0hoNrzcHGmXlkNYH+uDlnWy4C+p9l2HiZclgM+MAbqMSOxDzWIvfUDcQjpWERX5xdrzV+e5cB0PAEJr8jdpckmbrXR9UpCq8x9W5vCwe1kPZMIj3mYKk/O4voWhMQDNOVysfURkBI8rOk031Lj1nz1dKY25qgTm6lO4m4wSc7ab0y59nnMWOl7Ya3TUoi3wpMr9qZ0ir5ahEr2hDxps8ZPia2G4nVKVwZVkG5fZ9H7oWq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(4326008)(33656002)(478600001)(86362001)(2906002)(7416002)(316002)(66476007)(5660300002)(9746002)(186003)(66556008)(66946007)(6916009)(83380400001)(38100700002)(2616005)(4744005)(9786002)(426003)(8676002)(1076003)(36756003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I2xhhES7YxghLiCSQKKQO1Saz7xu37GxQqetnzsuuQWIfoSF4nfQypTRqzis?=
 =?us-ascii?Q?iqG3kFupbh0d6hunqA+0RG2XXpO0NIlqV3PwmF5F8Upkg3pqzvWwvR7DU8Rr?=
 =?us-ascii?Q?uxwlmBNI0XpfEXXKIIq+iXTDgsUyDYbFg8vmsa1GBUsVoi2ER46LVi58JJTu?=
 =?us-ascii?Q?OLn+q7Dl5op/KoIBDYwuBIRAbZH9/wTm2KXS0FsPsEKXJHWo+evnDbzxvMvM?=
 =?us-ascii?Q?rc9YSQ4RT/Ct14x5/EUBpasg+RNDlAQ6aRusxuONVasI52y/VM17fnuAe1It?=
 =?us-ascii?Q?kgzBsFZy96cwC58tACdZRueTU4d8JJl+X2i117dkdh/tsTtz/nSCm7yDCp/O?=
 =?us-ascii?Q?1O/sNSpmynMfyvzTHPCRdtxHAXJ4XZJUOs1DTMMsF53Bar2baURoiE7P+XZm?=
 =?us-ascii?Q?e89iUbkOeuQbIhIeqRHORIc+knOn4qOasZjxK9/4R264RZyJ9CWDw8NmjurT?=
 =?us-ascii?Q?c8QRjwwEgSxVAaPbSIsElFUIcGihVmvgy6CBGUL3GbWU9c7oTBD+ZC1MFfSF?=
 =?us-ascii?Q?4AMTqZGuUGMn8pyNysqwg4Fr66fmx7LEzp8DiDEUox31+vp5Rj0T2IRXibSO?=
 =?us-ascii?Q?SMdCpyD4yWEHKdrBYQZxV0EnZ7+E/Ok61abaEURvKTMoW6NWkHt9lpxrBOL8?=
 =?us-ascii?Q?baW4v9Y5BGJE1mZVfxyurXok5rS7FxZ7lLbuoXHQM8bEQOzpEEbspN1upzbn?=
 =?us-ascii?Q?6aK8sbTb4LpCZesHZoKQ5ZJuiryO1t4JMlPTeqcZZUCgmzfJ0uWE2JvRoliO?=
 =?us-ascii?Q?6C5huXyfsB338LD8OFzMcfbH7BepmygJ6ixdt25uDcLy17nbfVIX3XlCA/Qf?=
 =?us-ascii?Q?JhhTVwf/fMi1S0EzXleGN9qW97W++8GYANcrjyxOzvJIpG9vMberhBeyiZbJ?=
 =?us-ascii?Q?cHrxIQgQiCvOG3aK/2W5hKrtWabK9zR4MrhiuY9+A5OccemgC4yx/rgHbHTh?=
 =?us-ascii?Q?qXZvmXHc/WxRX342Vjn+a8IYHMXaNOtQBTqTqjxNtOjjSHzhMX+xMwwYXmGd?=
 =?us-ascii?Q?3xqAZTn4B0PanzhDrEaXuGeUPil0XxOwmPkipwJzsZxVq+hwZGOZJKtWYoy7?=
 =?us-ascii?Q?YkHql3dXmybvdR1QcC7EbUSK5QsK2CYfP9nqQ4ExTNzfIfsSxR35AeuaHalC?=
 =?us-ascii?Q?a8oES/Loxbat3Ho3JhoWw3u5/laVyLOiu7TlR4/xdao3VXl2VqzagMsx9PEt?=
 =?us-ascii?Q?C1HiUB331uLCo8M5PGe0cg1pFfwYqDQO21SC2ZfHMkCgFY+UskcYH3Sh0UoG?=
 =?us-ascii?Q?azz1NyArh/HKo1wMlH1bzsY1Gj71sx1oHdMQtKgdp0+6znP2KkXcZnkiX3FE?=
 =?us-ascii?Q?p5JKGMVJ4o0Zu8AONixifTtx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337a5b33-a9f8-41dd-336c-08d91f8de5ca
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 15:00:55.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FWc5Ojy7te1XEivFp6guqVLLxLu6VvrpltsOH+FmwdtM4Ff90ZZAxirskcZjjtD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 10:59:25AM -0400, Tony Krowiak wrote:
> > But this is alot of complicated and unused code to solve a lock
> > ordering problem..
> 
> If you have a better solution, I'm all ears. I've been down this
> road a couple of times now and solving lock ordering for
> multiple asynchronous processes is not trivial. This seems like
> a reasonable solution and provides for flexibility for including
> additional hooks to handle interception of other AP instructions.

Lock ordering is very trivial. In this case you have to always hold
the hook lock before obtaining the matrix_dev lock. From what I
remember there was only one error on the set path where they were
ordered wrong

Jason
