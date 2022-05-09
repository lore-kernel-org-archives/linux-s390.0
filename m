Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618ACC433FE
	for <linux-s390@archiver.kernel.org>; Mon,  9 May 2022 23:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiEIXsE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 May 2022 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiEIXqV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 May 2022 19:46:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE94722706A
        for <linux-s390@vger.kernel.org>; Mon,  9 May 2022 16:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTsDAxs5CMsTAn5uzJRuLhX5aDgXTN+mfANI8ao37m//36QzJWt4T64V/PA7wckr/IFHqd36zFEdfviiuX5Tt3GX19WTblQ7tN6NL5FfcVhRIRtLdJ6e5jwo7nzsCt4ypp+h+ZrQuEJvCpJ3KLS4IUwInk3CX5i+JNZvcBH5yIDQl+xCFaXmtWJ6er8i9jK1sMYxQK6Qw6HZlbJzmc1BuVvU80vjRH8B9OmuqqExnHLOJCu9t/6BBNDUiGGP/8x3Uui90IzZL1oem4RyutTBJ+Y3PS/KhS5zO2PXwr5CDwCk+sWBANqxpDKQ5NZtvVXUNfVaBzcHjhclF5GeCykaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yD/mpj97L2o4hDneWaV3vRDs+nN6M3Y9dXrv/RHqIc=;
 b=lSnazV6LdfKCLwsQLOB9DSsMa7qpzecw82wuxvtV9InFH0ZYVDMmmoDBvMJC86OOJfX0I4SUv+bQ09ZtTAYLqVVzavsZLs177e6cJljKAENCqv/Q0dRIq4Ayq79Dk9KVCKzv2JXnC1utIvg2c3HN9WxpeW0AoBBhCL5hvl2nMDvIrPCOGA9uBdWbCzM2KMHBTL2V7MYuvuT0mjriFquA/kDO1dEh4vMZYJdxZSnB4O/Ous3I1C/uh0C4G7T2ldyUGm4RRFKme8HljMSv3dUUMoGY8AyTBvzUGVEXel7jsPjQ3Bv6zU7b0/e8gYI8ykcsQzVKtHeDx7eGy+VYH3Ooeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yD/mpj97L2o4hDneWaV3vRDs+nN6M3Y9dXrv/RHqIc=;
 b=fhDgyh5+tG9sGgjZn6diiNjXmdWRSQKv6UpyWXXDe8NRY7luBoegoJ6rSDgMY9p8N9vZXglCf+LotDKqJO0c36yoVFMkmkAMy1oh8vZTEq62lxEK3zMqf1X+w7ZlnWeBaKSTLdwhz5OdAtSDlfump04UOrMGpJxHO+w2BDqUt0Rmt9nte65kGEjqYILINtva0Ka66GjDlWsmalvoxTr/M9Qso04a6EkOYb7Am0LB5MVt1IdZKGVq/abYRFuIs9X+X2TXWKyhkJzuEMX34NOoFqTf7onMkBxmjjCfOmIvYFV0xx2n+L5a5khCV5DiK0ycvi2/2SHrvbzBIXWQQ03yDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 23:35:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 23:35:54 +0000
Date:   Mon, 9 May 2022 20:35:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>
Subject: s390-iommu.c default domain conversion
Message-ID: <20220509233552.GT49344@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa98ae9-1d89-4436-0b88-08da3214a8be
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24880739C5CC31A970D4FBD5C2C69@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzXZengfn3ozzYia5pY4zyhUeuRmTWpDAUHdZDXty2Vt2CU4GPaPNT3QBbpNq4reyqv22fgbKJF8YDWPZacqyEwLW67WQ04zoG115YjhIpttSqzUv6HVXis/wvhN6Ug3Cw6220/HzEKZBxKbZXAanHGgVaERMKCULgOS3ShKbIHFrV7h6R8EBNErJWxmxo2sJHKuVr1VY5t0lSgl32mrpCg1SX0wqWJCTJECsFwVSx2tcezQSZFpzhYqivaVtKEb0DzZ/Hq49iKlZ97fIS11cg6697DeYbrH6x5XU5PZIyRTHYqEirvOmOVDepPqUN8pc68SDxgGXE/sH5aXjspr9j4mk4P9d0C+REq1BkJgJU82Z+Sq8WnvKh3PwTq8Br35RTdVoZqxA0tqf5E81qpr/nJ0gVraJuW6G7IoBPMQQ3bJzdhFV01COgG0jZZ12BWX0DT+qbgZoN0rGYvrI0eAAo9ldxxNL67vYep+tPl4EbtCW6nK6Hl5fT972uaFHzAjn2I+uyZ2iQ6jG8gabn/P3Eyk3ypBf7zti62QlkRiXg44E1nOIarh7wJZajHDEesA2mDmXbRzrwEKWZqmgplEAhMZd1zRX0wiTtNtbd+o24ST0rFNESVgq3c23jDXRrElDOGF0sQNm7GyWmc3A3MssA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(26005)(2616005)(1076003)(186003)(33656002)(316002)(8676002)(66476007)(8936002)(66946007)(66556008)(4326008)(4744005)(36756003)(5660300002)(7416002)(2906002)(508600001)(6916009)(6486002)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jpqenay1gv7tXSP6kCFck/j780Mu/FQp6E/ylvUz0McN1fxed36JxzMC2Yb?=
 =?us-ascii?Q?E+OJFdcuvftsd3YlLcmnyCUF6cIAWcDglRTd0jAM8Aak24kIhzHvCBJkYZcU?=
 =?us-ascii?Q?g54aNzCNWgxavHg3yMQ1yyLegFZ+jbRERlwfznpQMmha6zR+lesFrWpP49Lb?=
 =?us-ascii?Q?I5tYnSnwdI/koiMGj5SSlDLoJRTFm2crFJVE0eCiowtbYig9VQTBnOfuaWzO?=
 =?us-ascii?Q?SL4vbJaUpMgzn6luMKVfO0nPlOshPMlwi9Ea3WZU8yTGuHsw5h3zKNgKfIZf?=
 =?us-ascii?Q?I86KOREh53d2EpRLmBWJhZ5L7czMUScPrcGtmMwTukmzItndWppuHYpPbIM8?=
 =?us-ascii?Q?MBx/Qs+d/qpvFTIbS514phWTwwagZ2OBrK6dRjy+KruuM5j2ija8t9bsPFNQ?=
 =?us-ascii?Q?xcs6c39BHGswMa0IiD8qmoEQRku8XOp3cVA/4zNHLGFJHXIU/jD1emB7Sgsj?=
 =?us-ascii?Q?7RO7FZiyxbdodxiLYNCUNeblPc129L5g9Ii4pNw1WBR7cvuasjRpF9rW7Zrz?=
 =?us-ascii?Q?L/Q+lgkOAus/FIw1OHJ3lqnePqB5Fxo4zJFYhWMSICd+QxI9xuKa5X6JFpHv?=
 =?us-ascii?Q?jA+2f/01kJhu59eTUTiZWzgR9BfZYAOf3aPLTm+1KypmFd8rmZEWUpCNiTn9?=
 =?us-ascii?Q?u+Sc4quanayr+YXDK8zDZCTiJ2XSc89tPlpt2v3tj+YmNBNQqoHV5PIXXPtD?=
 =?us-ascii?Q?qyzv5VGC5IvtqqwyG5mjhU8RypUJQrvIKI7ETZ/7Ka5nzcz4WHmSE5zMh1Fh?=
 =?us-ascii?Q?YOXhXRrjsqAO6pWzXMp7jGWsbJlwYadqajcxKH0LR0xorQS8uCZsPJqGV9+x?=
 =?us-ascii?Q?YtA+gfDTPY0WqVYX98VFM5ykj2lAuq2bl3uFcFUXsrMZ0zT3SdCn9q3u4rAw?=
 =?us-ascii?Q?fFGgAloFHv/hKN5nJhqpYvwL+F6PUJJ6vQR5+9wm6DczkNadW+JN0I7aeUiM?=
 =?us-ascii?Q?KNE6YTDX+bE/zCrrmmOceVD9FWtLNfdaOFCz0aUNQm93uhVAgeHRZcqXTgPg?=
 =?us-ascii?Q?K6cnj61DMEW8WzrVxT0cr7K1QpGula/MSuJ2ko+L3V3sxNGxZCBAca6xRNUP?=
 =?us-ascii?Q?mJyHIqcJ1PIt5OPmbmJGxDBFF8ocUwVwILiHaMPP99a1HDx55JgGqsgibTe8?=
 =?us-ascii?Q?5fQlIn56aNNXJ1jJwemvnFZv3y0UdggKudXooRm58COnNoNfQn7Itq7a3nee?=
 =?us-ascii?Q?BGRqcDfz3q+gYj6Tkfb96QdN1yzKgqkwZgF+eoLXqWz/q1w/twXsUFGiafV7?=
 =?us-ascii?Q?g9SBBsnHOxGPMS/pPQQjuclLbdlt5UWNbOYs0lzAWGAyXKPsC9z7MWk60dkV?=
 =?us-ascii?Q?83BsNNtoRbp+EPaVTy0Rrqg0fyavVol6/OofV2pTYvfMFf8TBi3sr0dB2O1z?=
 =?us-ascii?Q?q9aHf0MSOaM4viP6EnptFvOnQSesMBRlLu3yIZW/Bir+Zvuc9blLjugH2VZK?=
 =?us-ascii?Q?Uq/+WlEmSuqtBum4boL+kZlQ1U+U/brkQfk0y7WFZ47RYsQh84KkmZLwv75Y?=
 =?us-ascii?Q?ex3BEc/Fl/5HFA32w0BtAi9QUjA8Y/nPDVwQJbTuOwNUN3fiObRpnaaRdQje?=
 =?us-ascii?Q?wtlWx4RZRn07T0ZmsbQMSu9GJxz7uwCWHHBVgQpib16x+j2TrAeyNjQjRXrv?=
 =?us-ascii?Q?ziMHVoZU/+QHz9FZwwtwJw8BoXNXVQmNWLRPm3CewRFBao/lXqF6ZwS7g7/q?=
 =?us-ascii?Q?oEoFm9yK6TJ2uifWysmqh83M5iDUIisJZbB0tLVbvvLVqfYpZG/R/NXUpED2?=
 =?us-ascii?Q?hSwTSnHXJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa98ae9-1d89-4436-0b88-08da3214a8be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 23:35:53.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdxwmr4Qbz5J898dKbiVmMOMDZfacJGtucEX9xDAFjuiq2RtlCaNmIJN39TkunAz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi s390 folks/Matthew

Since everyone is looking at iommu support for the nested domains,
could we also tackle the default domain conversion please? s390 is one
of the last 4 drivers that need it.

From what I can see it looks like when detach_dev() is called it
expects the platform's dma_ops to work in arch/s390/pci/pci_dma.c ?

Has anyone thought about converting the dma_ops to use the normal DMA
API iommu support and run it through the iommu driver instead of
through the dma_ops?

Alternatively perhaps we can keep the dma_ops with some iommu
side-change.

Thanks,
Jason
