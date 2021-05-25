Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995EC47085
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C63061249
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhEYPMu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 11:12:50 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:26880
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229898AbhEYPMu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 11:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqRpoy+iAXJQ5oMzswwv1MLNYrktNvLGLW3B/pzL8QTp4OkXxWNPCRd/OSRWe/fKmzk/sGCMq9FqqC9ZTglY5xHk+LbrocSj8VYDnPopsVaUcToIWsHU2I4eNJmVq02wxAMgg+FoNXDClcsL9ijcSbQbhRXJMWPpKM3BNbVZzI7W6W7NwBSbIGdTc7TGgHThExvfijRbYPXdySfv9aZDTjWBtn+OYRz95sLCpeLCjX+VRekBRgeYZqMd0p0jOpPp+l0d1/Vv/K6yS3ii9t2rn6tUxO7Bp+OFgiK5GZl5zNruM0zAUVyJ7xXmkCY2uJjeJk72wuVXFNysEFHHL80cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3fDXP2unGF5S1kJyoL8C7MJhWoJsCqJ/3WpuFST8Eg=;
 b=Ii2wW6vz+f6On/DzAgOI3MG8owvx6FPFenPkn7lpRUlbzJqncqiMG1Nft5WigLATxn7HJumu3yztkdkwGXnJss4vbiubEHHm+dK61027ekQssI7uhfFztXzkxmt66VPikL+VWKDmf/YnxK40RTm5PsX0fxS3TmRVvMwqRZ9jMrIFtECbSHG/9qaLXzwe1ow0wCu8aEof4bPYgJWqbB6uO+Djq3onBX2d+zrC6fYm8Qv3szTgGdZV8fiZxKlLCHCzWeKGV/j/8AigpDovupdUmMPhtCr4ESCZkzTE+ziHZqYGhOQ8lzzEgLpoQDlTQQ4xsDVmOJBWm1/WPIUpE+kGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3fDXP2unGF5S1kJyoL8C7MJhWoJsCqJ/3WpuFST8Eg=;
 b=Ba7msVAv/9AhTzNqW1LsAVh1bf6997iPd7mZMPk0GCLcBPelsUxUN8yzBA5Aq6wAwsOkacZvYKjV5Ta9NYlda3d0iz5M4XFc0+uONFiojgBc2up1+D9wjMspPYLq8oZ8PsQ31YGWEb6CDiMjtuVJMGQX54hPw/E07ohjuw14F5ptdgvw97GLFm4oJ6/AWr1ZVqTX1Lol95syq1UjJnvhsZCUuklFHVAl5f8d1dRcCUNlk/feyI2/fsD7/BHa+V9x0/mQ8tPCU7yRBkUjgmm6TD86ot9A9Pry4WZK7JOAPLe3rL+RIAgVRDEKG4XOT8IzmGXVx5s1TOrAXINcojcRXQ==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 15:11:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 15:11:19 +0000
Date:   Tue, 25 May 2021 12:11:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210525151117.GB1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
 <20210525131912.GW1002214@nvidia.com>
 <6542986f-b20e-3f41-b96c-70f0ce42af2d@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6542986f-b20e-3f41-b96c-70f0ce42af2d@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 15:11:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llYiD-00EPDU-VH; Tue, 25 May 2021 12:11:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d91a269-64dd-4bfe-b181-08d91f8f59a0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111F883913EE1CD79498512C2259@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqHIjm1ByvFqwnUX2ERv0Njb9hocthJQraMrNYw5rzn04wd5kkqT5/f75xCzBxBmWyz95aNLp53V/TdHw35QHyJgcxgC+corCwANwGr7zkdeDpAaoboNDYYpI3wffbDPucy11jzXYOBs2/1swJhQUNg5XCSGS80auuybGL76vcZ4d+hZpRumkeb2W7vgHYcin/Ekc4nbLCavMNUEb4R+WxTk7Kn0Q7QHZTVRwfciicc3sOuvkGO6NqWNSJUN9oWoHGErPJyJUsq8ah23KEjR+/jYC3HjCam1hqBcxHMSS+4e13EqbYBnml1rbRGbRGIg3prnDzHVDOpOu+b89MZdUpeAsUsPbckbsp5VIGTYWYIgS4niInhYTOVloYzeQdHqJQYvYr5adfrob4kQpizlNlLkqMZ0Kb0Wr0r84CQZkEJIuI6H3ivRmtkv9FuKfWtlCoY6RF2SyhY0ofJC7gQM5ivHmdBDMyJOZfJmTBa/5Emgaj0U1XYASxR2D3JQQvgGtxDhSN3fo0SgfoDaNTg7YBIzviDrzPR1zNeED0kx0YjQJiUYURSmwOKv/uqjhj9jVWM26tTz5VvL2Zg4M9f17BmQyou4s/HQdpmcgVxVvE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(4326008)(33656002)(478600001)(86362001)(2906002)(7416002)(316002)(66476007)(5660300002)(9746002)(186003)(66556008)(66946007)(6916009)(83380400001)(38100700002)(2616005)(9786002)(426003)(8676002)(1076003)(36756003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2OIzPyT8u9LuwYWoqeRsV8K3R2qyMsy3nVBYOW21L0IN8Qtk1LnN3EDMFVJc?=
 =?us-ascii?Q?voQQ9qdKdD20nf/nmRizbdlgmarZhhutYF9NTVJQPKFFnwsTz6JEbwtWmQC1?=
 =?us-ascii?Q?bS5dRX0yi29FE7Ok4QX7TtYGBD4ewvwBfpf7+ZdXEpbWRKNw+RScurITT6b8?=
 =?us-ascii?Q?2G/fgXj/V4s8MqeB4GlSs77v667u+UyAyFERqnS7XORFxdk/h1rWlrQaTZUS?=
 =?us-ascii?Q?q/0tXTkxwhg7AZ5zeF1Eku4cTrck23eATlEV9gDE0+eXfjHMvPZpZVD8t9/u?=
 =?us-ascii?Q?qA8Q1JCWtvwOKfPlvKlRym9jGzEW6v/Xq83BMxJHdslojnGlXokhybfuKCMe?=
 =?us-ascii?Q?ytqItfrzzbGBLuA//tqYzvZl3JQhnPBsRFn1oP6ppIJcA5rufaavq4d1WbV6?=
 =?us-ascii?Q?ri4eUmCn86iAeWywrJ9nlZolpVXDwNo1+yHFGnD74WDCZKxwErYpWDTB/Dmu?=
 =?us-ascii?Q?HJiR3AU4iSX329tfEKXVFq/pxX7uiCDviOmaRRwBh2gj2J4LOxntkAIsGLCJ?=
 =?us-ascii?Q?34UqO+ezNjSHBE2025tJRgRtRvuydp/xZDIQSduqjZmersI7L0kvEi02z/RT?=
 =?us-ascii?Q?RVZlh5PfHqsu2C1O7mipQlwANaXMRG8LLqwWnEfVAJ3fOfHQ6qcQxXTiKetK?=
 =?us-ascii?Q?hZ9DvwrEUmQzyUyynDDaqaQ1sS8nYxklXGcCHK2LJqrLyVE3NjWcZlxOWPvf?=
 =?us-ascii?Q?dZACpI7icuVeUzthJphs1SonylpGaA+p/GWhJS+CdxSDxJYdUVlbI2Ko9zQp?=
 =?us-ascii?Q?NHOdJpZE05eyM5IBfJhYvNLZgj+Fprjeh/+FVDtYhPIgShV9SE+eaVU016aq?=
 =?us-ascii?Q?cPRS7CUw7p9FCECx9mtQ9kdJFuVm1tC65xWHCRwQXWvSTnq4g2DD+qLgbJa9?=
 =?us-ascii?Q?bsrwWNjmedjV96W8a5Z9GcZ9q8BDsCLE2npp7INEyGAY7/pXPdMbEALM4IR5?=
 =?us-ascii?Q?2cSdshSqqWbqBslBrn9aFtJ6JgMwI7uFqS7s6X21nyUkN0VIzElx6F1k9Eit?=
 =?us-ascii?Q?/lat1m5H2YZ8Ea/NI+Ex93ojSwgrn518cuWmjLRNHGs+Pz8BtfuILu3usu4O?=
 =?us-ascii?Q?5TnGROvwyAR+tznSnr3zEWT245tRdlk6rY8SDUI3yt+PJKbTgEwcyssn3ObJ?=
 =?us-ascii?Q?Q+gnKi76m7wywszQMjhFhqP2KATtFJIXhlwFvnLVYDwt4LhOmfm+6wL/BCGZ?=
 =?us-ascii?Q?MzUjt8GFGYDgCXYxEwlKmczaXMabshIjopgHz9jIjom+Sa/0P27jqieVUg4+?=
 =?us-ascii?Q?Q78qSMg2RMJxGHws2wyn6cw/CGVM4jkWngZFiqHRNvJYoP5wg8t9phHYtvqe?=
 =?us-ascii?Q?mpJQHfrBKGvN1euNxMxyS1ns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d91a269-64dd-4bfe-b181-08d91f8f59a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 15:11:19.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwAMsVBOl1RsABrWREtnuIj5jgCEZEA3jdnb4UuKkQWnxy9soCHmC2cpjhByuN5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 11:08:22AM -0400, Tony Krowiak wrote:

> > Why can't you put the locks in the right order? It looked trivial, I'm confused.
> 
> Because the handle_pqap() function in priv.c does not have access to the
> matrix_dev lock.

Based on the sketch  made the handle_pqap() should only handle the
arch.crypto.rwsem.

When it calls the hook it gets the matrix dev

This sets the lock order as always: rwsem then matrix_dev

Of the other two places:

@@ -352,8 +352,7 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
+       down_write(&&vcpu->kvm->arch.crypto.rwsem);
        mutex_lock(&matrix_dev->lock);

Obviously correct

@@ -1202,7 +1203,9 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
                mutex_lock(&matrix_dev->lock);
                vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+               down_write(&matrix_mdev->kvm->arch.crypto.rwsem);
                matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+               up_write(&matrix_mdev->kvm->arch.crypto.rwsem);

This is inverted

Just move the down_write up two lines

What is missing?

Jason
