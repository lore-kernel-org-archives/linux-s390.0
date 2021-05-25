Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262ABC2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC366141C
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 16:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhEYQbA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 12:31:00 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:4768
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231689AbhEYQa7 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 12:30:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULc12R95VYJvxTmF+zI+l3oUZXnF1C6+8Zev+PpSprlb1COR2blsfQW0PQmS23Vdtxf6jiRn/ix4IXjewKF+kMSZlLgQ69GL4GVmrEJ70B6ElVCHLfTxg4X0+DSmvnDWhWuXdaCgoULfVWB1RWCYT0PMq09vVOUldzyYbCoGCx1LDizKxvc0BJjISsQScVqwul7J9ABrk/3y+BeLDdL2cHPLCxV/tM2SJpMCave5SxKtP5rJfhpDuIy9JApmUSPGgfwPRFMvGjITXYR2Y0NvvvF6DrGff+Y3+3VbmHkkQkK9sO/i4D3W9S6G3UVLFSdjAvOpbQPpXrVb8y48zipjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZaHXWY51844qmmlDlq7gQjmaZg5F0r77Ks4Zz8V47g=;
 b=XCfraXt4+TTW9HYF2B0N2+56gJJvLYe4K+IxHt6AVrZpRjd27g0c9Jqo0OC+9B2CJf/kud9AR5Hob+g21PXT9aJGIWihm6zGXz46KEm4LIuBK5c+6uN65ANOWr7MaqAjIKJhhVj1bHpsPNJXAxWEYQArJRUAqZmUcLcNkHYTw1P+JXvz7VF2lcOM227XRbLs2U991iVYoi9noFVhC+zkD6L/Phvd/6lXpccl2O7gnWHOFFX7ItBInissvFYV9T1HxDiP7VSiDlRNp9S7H0WyVjulPXGj2XNifZuXnBCND5xheba4h3bpAAHveGxhZUc8VX2DRnKscpF/JtPwc3tYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZaHXWY51844qmmlDlq7gQjmaZg5F0r77Ks4Zz8V47g=;
 b=iOwA2bq+YQ/CDbGO2aqnvpabR+1i5AjjAO4qeUlbKXnzw+vw3o8U3lwTztSXSnsC8xcz8EnZ8aULNiQLsEnVlryxVKJ+1thaT96oChMHCT55z3a1ofwYXVJOBPY1hyiwtLoAgq1PB/6JjEH4RO386pFoUvieHRcNe5jKYNhWFfVNrOgtVlqxCX5fhfk4fSpK+YxMVRGC2rtxiYXHzadx95X9oPkBgaroISEDGqu/SseflVJwg1eXStSvfTQC9pi7H6J5D4uid8603+gbus4unUI5I79ocFMpSxl/jy0cuEJ7nA1zNVJIi7W/OMgrEoOkp4o+JipeIn6xm5PqpI4CfA==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 16:29:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 16:29:28 +0000
Date:   Tue, 25 May 2021 13:29:27 -0300
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
Message-ID: <20210525162927.GC1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
 <20210525131912.GW1002214@nvidia.com>
 <c54ef522-f348-df16-a99f-1e31feb1b0bd@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54ef522-f348-df16-a99f-1e31feb1b0bd@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:610:74::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 16:29:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llZvr-00ERIi-6a; Tue, 25 May 2021 13:29:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42379ec1-d90f-4d26-0503-08d91f9a4487
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5141F43638E81193C703994FC2259@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imshn2pPCmOEprQPv1ScemweDDDq6B8+3pPHWLWWaX49Ld2ziKV75gPUSVQD1q/lL8xGnLX3E2Wqw2tlFAW/9utIGcQp5n3aIog/SUb6pYo843jYdDB86jaGFrpG0L+hivBFcQgUtU6Eq7ho9CxMjKvbflGxemJUs8/FEq+jcJqBs75yfcUXxC0kiznJDLxNsYJ9Kbsai6xp65NS4bukCRsTvJykTUUtMtasQ6c5FoXCegs9aIkyOMfaM6sqd8FLgu356050tHa43WtoCEM5v8LNKz0eXbSoksZ8j2ANRJ0oXiozsOBPg1UTotK0G1WmLdr6Tt6sxwCFkY9/xCMwBOAekXWwVcPrvM4O0PgrIlUhibRUS3VTRYePOicVH0OJMl/t4Oyy6ERyEjsbiQCimZxjHdZPhjhQ1peIwlBknbVLPQSAO0ruFHMXAp+vWFHStLAdRjEdTDQx3dyDCtbW+u6u/mWDqCKWz9ZSmc65AQ8uIKig1GTh7g3KWuxMixR/fhdm9XPFPI6bU+5gE//dk7Zilyxr3LkQS+EFA9WwMmwxrTgtbUjiGJj44KtBKXtep1aIRVzX4cN42yXhU4JIjIfzVWDH92tAo/qYUQOs9sM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(366004)(136003)(2906002)(86362001)(83380400001)(1076003)(38100700002)(5660300002)(33656002)(4326008)(316002)(36756003)(8676002)(426003)(66946007)(7416002)(9746002)(9786002)(26005)(66556008)(478600001)(186003)(66476007)(6916009)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gm/G8E2nDSdKgWFpXJdzG8fXdbT74CsJ9eHDbwgu+JUbnhq4LhLjlXd7F69D?=
 =?us-ascii?Q?E/ZnV6YZz7wPdzKjyZHMIOP1ApYMznI63tTeM4lrEi648QNQ6g05ufJGxsUQ?=
 =?us-ascii?Q?MZjG+zM6Cf7RTjjdKchPQ5h7RCc6vUurBJnXNxh5sINQEwrDpmmU6q/aRrO/?=
 =?us-ascii?Q?iv4oz96J17In9S9uJT3hJmelGExmxebFy2P+LFxErSts+W42u4aK0/ugAczG?=
 =?us-ascii?Q?GPNMSkPUmfegNxrK16eEoqnweh+rIWzsL+nKWYj1WS+QcmLbu1NDk8ADnh+u?=
 =?us-ascii?Q?YMuG47C3rBH5Eisp9EyvotRnF/oEbkHSWD4h+wnCaqytf8p2rz6SIdmN316e?=
 =?us-ascii?Q?beu36Ojnm/gaG4ChJC9BG3m3AkPXzNVtlT0ZC6UMbrwsti9z2MHXdtRnPuyQ?=
 =?us-ascii?Q?mCETmleggREAQqJ6HA8DbvzzvuxiVkcR5nfl45zlFCI6XYhX+xhacGQ59TFy?=
 =?us-ascii?Q?CPq3YlLPhpp7vSRvIHXF6P55aIVS7IyYfn3hGn8dhXGq2ZOiru2ZfbZvuLPz?=
 =?us-ascii?Q?gU0SQUdX4QICtwJcsndfPhhphmYxESCU9D3V5s9efPIzdzR9VkG9ZlMdP8j2?=
 =?us-ascii?Q?ME7y0d3Ka9JHkUQZIazOgjEA4cRxl5AksrypTY9yDKSMeO1JzOh0mLoNwcpS?=
 =?us-ascii?Q?q+lxT7itcURElGAZufh8wyYjP7u0uX/80TzbUe9pbToAQw/L/ac4uOaQLf+k?=
 =?us-ascii?Q?N6LStBVjcYYlr5SnbR6+VUlCuty4mVkabPuY65YhGh42BJuduOJOJBbF1pXk?=
 =?us-ascii?Q?OdRdr3n8/gnLJb3PNJhGIxeWWEWOaw3jXaADBCuLNf1WU5coavtWm5BPmiG5?=
 =?us-ascii?Q?LdiBNTu9jMlQKMFN3yU8+EgFKQgmULaYf+CsWHoBCjAMHHXw8RVzb3sxf/v6?=
 =?us-ascii?Q?hYKxqtsL0SDI4eNIkypPmX+P1tMOSb8bl1yY1K7tweoaN0doS2U3u0JreuhM?=
 =?us-ascii?Q?cgmpr3mNWnYBG6XuBpbRy4qpErGAEgS7inLJeQJTNWCYa8PD8Qd7zECdVdd8?=
 =?us-ascii?Q?AoDCGiek3omBTC6CmE/RPP7PAE57twAHLMeFng0QrZqU2CPalWpwOmoQ1Tkp?=
 =?us-ascii?Q?rKQc4ouR4EbdJGDBu0u0alkokZwYM7gLayAi51smCRUcJwDcm2gYSnPiHYml?=
 =?us-ascii?Q?FMfdr8dw9srxkPWVusnA4Cx5pxLpyRDGivFdIfKCQbtldvUIk36ScM2QUUCc?=
 =?us-ascii?Q?80U/UvGIpB5DP2r5Z/fkGgayH6ggD55gAzoJbvER03tTrM6hFfZxNhMZRIR5?=
 =?us-ascii?Q?gCzS0hU2nML69BPqav97L9NHZK1zGbzTmBSaxgH4eskJG/BNdJnD9AzSWMLf?=
 =?us-ascii?Q?IPRieUKYfkrst6d74h9lfd8R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42379ec1-d90f-4d26-0503-08d91f9a4487
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 16:29:28.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ3MdFtVwW0L0Nk1t8GqpqpjyI0zJjeZge8XDWG4ynA1NJ8Dzt/LNml4vPPPogJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 11:56:50AM -0400, Tony Krowiak wrote:

> The vfio_ap_mdev_unset_kvm() function, however, is called both by
> the group notifier when the KVM pointer has been cleared or when the
> mdev is being removed. In both cases, the only way to get the KVM
> pointer - which is needed to unplug the AP resources from the guest
> - is from the matrix_mdev which contains it.

Okay, but that isn't a problem, the matrix dev holds a ref on the kvm
pointer so we can just copy it outside the lock after we prevent it
from changing by unregistering the notifier:

@@ -1362,14 +1365,19 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 {
        struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-       mutex_lock(&matrix_dev->lock);
-       vfio_ap_mdev_unset_kvm(matrix_mdev);
-       mutex_unlock(&matrix_dev->lock);
-
        vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
                                 &matrix_mdev->iommu_notifier);
        vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
                                 &matrix_mdev->group_notifier);
+
+       mutex_lock(&matrix_dev->lock);
+       /* matrix_dev->kvm cannot be changed now since we removed the notifiers */
+       kvm = matrix_mdev->kvm;
+       matrix_mdev->kvm = NULL;
+       mutex_unlock(&matrix_dev->lock);
+
+       vfio_ap_mdev_unset_kvm(matrix_mdev, kvm);
+
        module_put(THIS_MODULE);

Note the above misordering is an existing bug too

And reoganize unset_kvm so it uses internal locking and gets the kvm
from the argument.

Also the kvm_busy should be replaced by a proper rwsem, don't try to
open code locks like that - it just defeats lockdep analysis.

Finally, since the only way the ->kvm can be become non-NULL is if the
notifier is registered, release above removes the notifier, and remove
can't be called unless release has been completed, it looks to me like
this the remove check is just dead code, delete it, or leave it as a
WARN_ON:

@@ -366,16 +366,6 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
        struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);

        mutex_lock(&matrix_dev->lock);
-
-       /*
-        * If the KVM pointer is in flux or the guest is running, disallow
-        * un-assignment of control domain.
-        */
-       if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-               mutex_unlock(&matrix_dev->lock);
-               return -EBUSY;
-       }

Jason
