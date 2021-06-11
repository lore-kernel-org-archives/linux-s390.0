Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1EEC48BD1
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7E3613C3
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFKQvL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:51:11 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:24288
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230417AbhFKQu4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Jun 2021 12:50:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRUrrrXy9hgU2Cngl4HheuaqSBJLddpipciWvWQUgGPMiBHTIBspIMAa8MNY7T3m4uOR+5dDLVtZn1WVjIv5RP2tZ3iscqLEZjlvOfVu8QdV6UXL1fSZs6u91AvqScGGd1RPYj3W5DiH6+oWqYQggP2ZZJFWQArPGbOXdfPITAuoifum0jNYM92Z3GYet0OCuLrE7W5qaQwwytUeg9ncWqwFr4QAwtlDS2E5ssbEwshEoPZWaryAERnFlo76FwHzqVGdMSGAK/8k7chuTAfzF+4gsYj2G/f79mCYCfL/o2FincxzhSgOHESHNVToKeiNNRY+eBFOlQV+PMA3wHu2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QUi7hlji+D1W9qeGFmzbKaf6mkNcOQhU56Ry1shZQo=;
 b=ObeykhqQSrFmUwpbqX2KjcK+vM8aJqbJp9LU9Sfe9qi2qnRF2fa3okUnJAK5vjfef5p7aIBfan9b7Jmf/o9bVm4iwkwyjewwciT+ysEnT230cQsThFfOA6pFxl3eM4xwDpW4J9Y305d9f2tDgx6KOJJYMsT5YXlW1e9gGdEqSoTQM2VZNH5Jj0fUJGL13I3I9H5t0zzCiN94ZoEgYOYu1lAz9mbo0qsIDabTt69LYTeT4t21Hmw2LOjFMZ2TGBhZQyFNr4dQa231San1N3wBBo0at811irsw0Q9VmwOzQIYDLTMr1DU/HHLKQls6p7/JA5/Lkp9dQzNEY4qjK4qDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QUi7hlji+D1W9qeGFmzbKaf6mkNcOQhU56Ry1shZQo=;
 b=EFzT/K7coK1IJhao+jXX+Oc7R7so1cqK7nK6BXftBS6K7+4/nbAbuCPWqPnsnbt4MmRfjqKgdxrYebhwXLYxVTcwZXz8E7ReBWy8Vg4E0Zyk8dcTSYyIksdFNg76NBo6UBS9cGQ9CURYnY/n8PjlSNIFaa+NlRwbawIGWIWXhn1TFpBfEQRWMHLKT2/508oKIv8C2sxe1q9wAKzTHnlF9Pfatq1GU9lmy1v/AbyFYk6dYmqym4viTCsYSLkhxjx8xWpgmQ9tS//Vd25jy7PzAoXolsT/JQdgLPvfrnbJcr3QNS+W0plQzfsGgto7rmBet7RbKZwbXFn7EoOIj4VNFQ==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 11 Jun
 2021 16:48:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 16:48:56 +0000
Date:   Fri, 11 Jun 2021 13:48:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 1/3] s390/vfio-ap: clean up mdev resources when remove
 callback invoked
Message-ID: <20210611164854.GT1002214@nvidia.com>
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609224634.575156-2-akrowiak@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:208:e8::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:208:e8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 16:48:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrkL0-005gha-QH; Fri, 11 Jun 2021 13:48:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6bc47ad-f664-4dd5-d16d-08d92cf8cd64
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555419D5755D1103EC08096DC2349@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdb2NidruRQ1/Vul2rr7vC405Sd520/hOIqXIxWRxfOpI+RBCR0mtNU7ojcCnnMiMon4/3riKHDLEbDbqHAWYsEuB1IZ7bXNuLF7zpTBm5Jjl6+5PkfcnaMVGNvd31RMnwfZhrUK+tZrq5p+Ntdy0xf957FgkigRXhaP0hfDiOD7TkynxcoSVnK3NLVUurNFXdXGchKK2+P4bxb2Zyx07fKFhHuIldfqzVBFt1Dj30MQGyvYuK6HNAqaTSOHRc2C4qHrl+6RZbkm7zN10Yi8h+7Q+LNTZpA0XZ4rQ+diFXvQsakABh2W1VYpXM3jbmYpjeKgfFnnutg+zQRw34tQBwY5KePl/SOx5S4tR1WiprXhvWf7HzD6kyxjzXM5tc/NeiGadCxqfNFC7zSQ9Mkf1OC17dQDYi4lZog2AEk1lpgu5y94qgcG+gTn12wSmMBCd2wdc4trwXrkwa5Ag/ybSlR/OSmzT3p9Opx6Uweh8ocFZDmvZ8E+qPBmNdOLTzOJeZ72Eto8WDqU/XpU5pRFSQPZFjYdW7ZE45ggpjzqOtqTkgx9HT/ESvkMNoSrJe/+k8t6VDRiVHZmgzwDMxkdwJ71u32fE56zaKKXh2C2G3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(66476007)(66556008)(66946007)(86362001)(478600001)(33656002)(8676002)(1076003)(426003)(9746002)(5660300002)(2906002)(9786002)(2616005)(7416002)(316002)(36756003)(38100700002)(6916009)(8936002)(26005)(83380400001)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfM1BXujFK5VrC3hl2koOFQArHKsjfR8/kbvryvwIz2bHppJlwpDGc4Y383N?=
 =?us-ascii?Q?ZGIhoygrPHDwEgmS6SHOBxKu2QXX5xoLJDATvR5QXBLUE6FmsiXioqIPW7nS?=
 =?us-ascii?Q?bIhHRAOKIi6T3ccV3wbZhLHSGypIuJJfkDn5YN/yVj0vEcOAE6vXGf1BPChK?=
 =?us-ascii?Q?VFat4NOKwOvqecCQCWY94xGiqiV+xQy7wKRgFHMxQU6qC7L1U3AQCoziOhKk?=
 =?us-ascii?Q?NqD9ByRXKYPDrMgvtOFrEdqGyelHx22prVlOn10b++IY1L7N6QNvHkPZ7XWq?=
 =?us-ascii?Q?HhJyknLZu345n0TExLCNMB310mVF1zylhtCWWR8BFLu7/+ayFYelpRHOY+Ii?=
 =?us-ascii?Q?jrjzAtREStlhX+Rvh1hpxM4wRqmDTBtdZ3CjMOF8KjmBxS+BAyxFoQrgwm5Q?=
 =?us-ascii?Q?5pAdEauZpg0+UNbYoRr6nziXFAxyvFdin5gfloSLFTDuWMwUiMT7ygR5fM2d?=
 =?us-ascii?Q?ThxDSp7XARVo6n6cFRF0GFGKo8T2Q8FxmWB354xGqsAGXjHAx8umRQ2+AeAK?=
 =?us-ascii?Q?g7NMpA9aegIUlejMDydHgHf2CDlstfwYH/hXhOw3PweHDCkmJcGOG/Nsmb+h?=
 =?us-ascii?Q?K5wCQns53x7xIS1DAQa/qkco1liuZI2ptkthokVheTIpboDG14Ww3ZT67DDa?=
 =?us-ascii?Q?1fVdeS3zZz6FhGzo5fSjpgaMCF6Dgk754QB+jt9mSj/tmvgkPfjiqj2RpAwW?=
 =?us-ascii?Q?emKJLg3s1YcWt4nPzaSCt+6ijRGJUI4HU1dve5kvCT/OzJUIr9RkDFt4Rc1x?=
 =?us-ascii?Q?MWD5N/C9IKGSN2VBe9PuBKQcoQ0xdtPUs2xGHiHqnomvvviMUXE4t1Imj6FQ?=
 =?us-ascii?Q?2sqBHxXp7OpzpkqHjZnZirk21eSImv+gqiSpHY20GKUtOWcduTRdKBQ5eHbM?=
 =?us-ascii?Q?C3oPlRECQXRUpbKLoy/IrOFgr61rL+HNcIaF0dBhjdXnNgJnLlljEKkKCM6t?=
 =?us-ascii?Q?SyKwmLEzENyE29T5GH7ioJuSFergx3007ybqu+OxNj6bezNt6tCOMyQDIWgV?=
 =?us-ascii?Q?WSNDnibrALVjSV9Kd6QmQPeNoQwHg0YfrpQzETj0yZw0oBosXHaHSkpTji10?=
 =?us-ascii?Q?/P9LU0vtEW07BW71l9OuCwJXgpZJ6p1c8YvHlX856OhD4IWoeuxEnNHxwUnf?=
 =?us-ascii?Q?UP+x5OXjEavzfAUjt/mRaUZNre6F6uzZzqGe08N1ag5Cj5fkI3eyXU/U31xi?=
 =?us-ascii?Q?7Tc3Ro/oHkDYSFATdIcGf7xVz6ePcjIUpB1hFVCwBcAPwGqK057lI2uyoepq?=
 =?us-ascii?Q?bseA7Bm0svvH1TZehKz6pCYJQsiwxDlFGdwA0h+uaraqlDI4GAZBcP8MhpA3?=
 =?us-ascii?Q?dc+rkN91gIVga9glmTG/JWp3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bc47ad-f664-4dd5-d16d-08d92cf8cd64
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 16:48:56.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSMjBUlLPsv0Rnw1Na+jfwbd4swLcsAtZz33C9u8wGDVZENhzt3nVgCZvSfm7kE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 09, 2021 at 06:46:32PM -0400, Tony Krowiak wrote:
> The mdev remove callback for the vfio_ap device driver bails out with
> -EBUSY if the mdev is in use by a KVM guest (i.e., the KVM pointer in the
> struct ap_matrix_mdev is not NULL). The intended purpose was
> to prevent the mdev from being removed while in use. There are two
> problems with this scenario:
> 
> 1. Returning a non-zero return code from the remove callback does not
>    prevent the removal of the mdev.
> 
> 2. The KVM pointer in the struct ap_matrix_mdev will always be NULL because
>    the remove callback will not get invoked until the mdev fd is closed.
>    When the mdev fd is closed, the mdev release callback is invoked and
>    clears the KVM pointer from the struct ap_matrix_mdev.
> 
> Let's go ahead and remove the check for KVM in the remove callback and
> allow the cleanup of mdev resources to proceed.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
