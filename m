Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4740FC4743C
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3012F6109E
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 17:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhFUR3d (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:29:33 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:37889
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230239AbhFUR3c (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 13:29:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beCRsHuf6si3QTXspPO5Zvbn/7cWzGcrtzR+TYvzYm6jPIvoGnhZoMb9uTCgQlAAJ6xuJv4PY1lEXDqs4e4OZ/OsCudLnK4RcKS3rv2jvMEllWexB55HVnJy39EGlL+4TSLq7x00/S3DVDl4Lexf2rv+J5xCNE3b3tNzyd4Ui15hl8eO1MMWrcrgAyLqYEOp6sifz4M5QNLQkAEuHAmaOhoH9NbIt5Y5f9rui6jAPVvL1P61iB4+R8VyPoYymggSKh90ywauMZU2rkaE573QrK/HYydJ5AgUQR2jVzbwA9Q+ParySZyXORvHvDz4bit5umDYS6tJygzrYzDAX+ryJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMPIDy3Vs/Qqf4vwGtcizxdK89fYbrLHsl5mYj/ZV2c=;
 b=AVO/RwbBCvlhX+7VMNAY5uzgpF7dxC4k59e30eoA2dbNorw/YsN2pwm8o27qBj6PF3x1TaJr2L5fXmUJBAcyro+qcVSOWRnYoe9NTbaPgCceQtE84HayaQUl6Gar7buBuYl0FBS8dVajOSrM1ZYfLWgYoxQVkdvG+DQuP+c+5XjzSAmMkPCS0PID+kAEbjseo8+HNfG5nTXj9c9atI/SQZFyBJUvHCEImJ2uwhZLK5OT1w53q6uXz32pHLdfeWBwJ54DYzZWfbISeqBZaDgRm/4k7eShyeyD/qM4VbGDXspsf3mQn8/YcCgPOij0SxGXQTASeL5rjyLgCD4AsoWtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMPIDy3Vs/Qqf4vwGtcizxdK89fYbrLHsl5mYj/ZV2c=;
 b=RGiI06zjDfQtLq+UyktUaMCVgnynVF/gCr2wKhDx6goPDJT/v+V2ao6C7fUmrdvmYvP6rHbYU1dn9eGyoCs0DphX0OX2ThGgOILGpZ8wPE1vqm+sBFIW1/qMv4LYbXDMrq2CqjX7zCwSixseeBAFRNT1cLuHVrftr3+pIJtLiuFOu7sdi5luHV1gYOWdxz7CMosp2JsPvFwzMriBTmUT9eSVr6fMy37GRIK7XKifv+hYSz6bnggNZ6Kt9yJSXy7Hl+yY7zHoJWhCaCZJ6rG1HKYty/X/qR25oLjU2+1gSFuwDc6Wrl/CcIbAcqe2yEdU0dhzqVS5vMz2DnzfdylYBA==
Authentication-Results: de.ibm.com; dkim=none (message not signed)
 header.d=none;de.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 17:27:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:27:16 +0000
Date:   Mon, 21 Jun 2021 14:27:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] s390/vfio-ap: clean up mdev resources when remove
 callback invoked
Message-ID: <20210621172714.GS1002214@nvidia.com>
References: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
 <20210621155714.1198545-2-akrowiak@linux.ibm.com>
 <e809be5b-0b24-34dc-1eae-82b58dc54545@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e809be5b-0b24-34dc-1eae-82b58dc54545@de.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 17:27:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvNha-009kD8-L2; Mon, 21 Jun 2021 14:27:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bbdb480-3d1f-4303-b4e4-08d934d9d096
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539C63AF9AAA5F18F20CE60C20A9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGT1khjMNrQki38nogeyfBXAfwQoUCK//NoGyvP9C5H8+mHXXF5hzf+njMPokG0vECJROKtOY7yykHmVgZq6YRgXFhb1KXqMEAQWf5Trovu6Y+Lm4LZtCV8G0IaDZ5JBGgny9IIpCn2h23cLeSddG8U1g20Gvph77pyIITifD/VepdLN/SBYrr/jfFYYvyfkUJhkwHDEFKrGUNd1Ee5IQ0TH1MNWPx5CMC0n+Oo74ykTW3IElzrTIpMDJjuzCq7CjaNbYFR8xD/kHLXvY1Z6e+GchpXbVkuoOxUlJ+4AR0Lt4t5gbNKxiQcR/Equcxn4Uo2dKxbJTR88VaIfjgdUqynhMOWDoUExoYPxemeQnnKdPZsgL+A74sGsGQy+d4bM7T3q57ZLJRk/yYqscfGC647JUgmyMfZriiJDsZjqW0irlWlHgazSYkC/k8aDiMMkEeeTbQVukvqhtWhktuPLa8oddmFNoh71q2owLtX4QG/50nJIqAqLO2FTmS3d3fD+i8o2SxLZ0Lk+uNKHOhdFO2MDbGkf6weTuGMfePSAAvvw6s09T93n9Bzzz+d7pNkmC8vKISJMox3dVe6VEoRxhuTE1MSJ9x4MD/1N4zt3aijb407uoVFlNRdhDvzzzzOhJIX/QwNehBcWxapvYZk4P1qQzmN08iAUNx/oWWNZ1Lbdb4Rqu3VZ+eJjPfIwGLxb4sYG81nmOIv7I6nSyjKDGTr+OotEd5vCkLBgUvDsqcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(8936002)(2616005)(54906003)(86362001)(966005)(7416002)(33656002)(5660300002)(316002)(186003)(53546011)(4326008)(83380400001)(8676002)(478600001)(1076003)(66946007)(6916009)(66556008)(26005)(9746002)(426003)(2906002)(9786002)(38100700002)(36756003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmZhHyVsD49Fhj2nzDSYsUK1YpNlxG4AZ/LMVAvBMGejOYjwt5uw0COWPXOI?=
 =?us-ascii?Q?XfIY4/Ib3OWY4bkr4EMGGUnUAloDKubySY8/QLmjQBBxUL/hHuu/9SA0Kzts?=
 =?us-ascii?Q?x+UljE51ohlqYE+4fD2KR9wMdS/qgsbkuCkH7dBsW61YCCfMqvo/BIC6/jzQ?=
 =?us-ascii?Q?xEFFs/f25GBylxp2x4Rx59gYk6gBc1BhW+n/y0gJdPqCEgRfSJ/4xZnOBNHM?=
 =?us-ascii?Q?c4qM1rrHj/5lOdrKVODlOWM7887bRbOlfVpVYIHTIl+fSEt9fqw0+el1xUKY?=
 =?us-ascii?Q?nXT10kDcfqsORPYBVKbauEXDBbIryLKYrPaKHRNcr6w24SNYoWIfFVRRIF4j?=
 =?us-ascii?Q?9/oJdaRPDcrYWS0n6vfRE/ZtkdubZNCzeE546T9ZkfmZLWLe2WDYx6V1aAMn?=
 =?us-ascii?Q?Nrgi5KrBMKg8hpFV6zsYR/JAo3NQJ8hQGdLkVxXedT2Taq7c/q4k9qdSf1M7?=
 =?us-ascii?Q?f7Qg8/yU7Rd2SoEr8jac9VlLYwR2C4EAZI8fR/lensJBWvnVQHxwlq2i3bI7?=
 =?us-ascii?Q?cJUv7Vu0AouoihnB3cg2ggN9UlKO4XL1s2E7VApzrfwsQPn4DprxkY76Qtz0?=
 =?us-ascii?Q?e30ftTg+FVFNTqBFWZd+WLST7owdUV1J71PjVdPsVPMeZLSfoluZkMn1LVSc?=
 =?us-ascii?Q?UQ72PA7j+K2nLLrhM7pUxUO2vlh4DQcejlJfhqZyULCOFRP9ZSWL+c6z85/Y?=
 =?us-ascii?Q?WyZ8b6kKWDjxLBhxkMd2zPh2xVcqYvDzfvZEAZBz2ncnAhkUBSLm5Gt++vzf?=
 =?us-ascii?Q?jVqAUwydx4A/GKEL80itzTOPO9e94bbOa/iZaPpBRz2hPQRPO7Gxh891TsQG?=
 =?us-ascii?Q?h6PaIIJ8uYjNMFBJCb4JUWKoPvtUyitIVcWsuI5UYZ3XKy0GdnKJyPBkWze7?=
 =?us-ascii?Q?MggW3YNmWDO67daoj0Xo2dYvwQaNmpFSrT3fXtZ+IJOwGLcY/wVNMWDXzezI?=
 =?us-ascii?Q?Ylc2aji/L7vNmG30r0A0hDjm25ne+UXHiiIKnYgkj2g8PUHqWkofEyrqbsES?=
 =?us-ascii?Q?c6LaZmzHV1vsrq0UerZOc5BCQ1sNl/3I5Ry/5Mwi7szbVsyJUckTyuz9WWgi?=
 =?us-ascii?Q?MuYEfCcobUrVRM/Y6VYTv/b/FceFsQj9ZjLyp+7sK62xs9vPv0Ypo5RSOmLJ?=
 =?us-ascii?Q?6867TC3lAwXwGSV0jbzg7Sf0ZzhSOV0dg3feSGh2LPjbOtPtSOnjlDk6KGzo?=
 =?us-ascii?Q?+2cvdFcSbxVCa50Dt+ohUdKXPrCCFEMMlZelVZXeM0RkwfkKiqdNDReEOdgv?=
 =?us-ascii?Q?Mn6Wn29a1OBzPhzS1rGnKqqGKlo9M8YbN61MNcNNnQQptf3FoaQJIIF2ycp/?=
 =?us-ascii?Q?6uYtgCTd7KO5oUdxI82swSCp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbdb480-3d1f-4303-b4e4-08d934d9d096
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:27:16.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQt1Ws3fUktRWKteGSP599lLl6OcKk/I2xL4/ZdrGMmgfcT0msiF2oqOew71C6SP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 21, 2021 at 06:04:54PM +0200, Christian Borntraeger wrote:
> 
> 
> On 21.06.21 17:57, Tony Krowiak wrote:
> > The mdev remove callback for the vfio_ap device driver bails out with
> > -EBUSY if the mdev is in use by a KVM guest (i.e., the KVM pointer in the
> > struct ap_matrix_mdev is not NULL). The intended purpose was
> > to prevent the mdev from being removed while in use. There are two
> > problems with this scenario:
> > 
> > 1. Returning a non-zero return code from the remove callback does not
> >     prevent the removal of the mdev.
> > 
> > 2. The KVM pointer in the struct ap_matrix_mdev will always be NULL because
> >     the remove callback will not get invoked until the mdev fd is closed.
> >     When the mdev fd is closed, the mdev release callback is invoked and
> >     clears the KVM pointer from the struct ap_matrix_mdev.
> > 
> > Let's go ahead and remove the check for KVM in the remove callback and
> > allow the cleanup of mdev resources to proceed.
> > 
> > Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: stable@vger.kernel.org
> 
> This one is already queued on
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
> 
> Jason. Do you want this in stable? Then we should write a mail after
> merging.

It is fine as is, we are already at rc7, so long as it goes to some
tree for this merge window

Jason
