Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753D2C11F64
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4D161C81
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 18:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhF1SZY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Jun 2021 14:25:24 -0400
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:27368
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232489AbhF1SZR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Jun 2021 14:25:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF1NegJJartTIBkaa4IoIKUk/rwCfrtbAStZkFP3BJXrnwHIDqB7CvxaRWGYe+XJxvbNKi8lrHhUXZn7DLy+m63jxDBPfaSvCMj79d96IZnmEF1f3zX/3I+JQZtYasDRb/2VOdk1qrj0AwjpBWtOtL11oDzlQhTKcwH5U2A2vxQLj+XJ4F2hTH0T4Jeuky/B2H9Yv1eosnH8MMSgELAgj83TejO5ePeC9Fn8C12Lpp9XsJBSRpLkmXze/m7/AbptV+0B4RwKAIGSJDE8DhpVsVPM6UTPbjcvOBHbmshKzEnLCfb+S3eQ9NIbD9IoZJJdhAWyKIaMRzRyrEXXDCB8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtnkicBx5EbN66RV1b1LnG6xy/24sKK+DXlkRxolNKo=;
 b=B9bnC4zrjMOSQ18YXNab/AwTZi/uN4pfh9mBvksOJFXOWHmOgqOGjLLt6B8OQe+u9ehVbuRsXM2mvoMOOVAgjpTG2rKtQivpI3zWkR20wOYmnE9lu/rTwloa5TrxO1rKkIrJn96SK1ktpCxsfGMTtpEIoYHN61/OAiQ6pVnEzS2OaxolOLK/50B3AzPxpkpLJu7O0i66FCS+gUlLbnBghmU9REPA8kixf8IQtkY2rqk9HD4i+0TpmBDDsPwxdno03PUyBeZ0fpGCt/A2dxgIN/Sw9T1nNEgVd/k0/ao976cLxn7FDquaAJxt3j2TFlhT9UuOCgde7tAmdlK054Zrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtnkicBx5EbN66RV1b1LnG6xy/24sKK+DXlkRxolNKo=;
 b=AhAUYcxR9RXzrDWzHs7G7QeMe2lYgkhnBiQXsnuMK+B3ZwgB4uLLoljTQGhiJM06XhN/4aIFayIgsr60yPyeyFOeH3dPvnbz2nQwnXrMz5QFFn4PKqnFSScd5KYRR8YVv9iSlkzSbisNYUcyfnvQh/lwqve4mF32khCBvOjX9nQI4r9sy9iJyifOnOyd8QSVyeQZr/8QXwqIplUCsTf1oF6pyx7pgqt8d6L2nQZxM6I3U+wtgAqbvxRDw1T42CNsMIlwn83AzS7R3UihnyZlFM1NlFHOxrvkI0tTd3Y8JUyyaH56DY26BOfsD9vU23rM+XggCzPvWnVlj/GHw3ANBw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 18:22:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 18:22:49 +0000
Date:   Mon, 28 Jun 2021 15:22:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210628182248.GH4459@nvidia.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <20210628173448.GG4459@nvidia.com>
 <cc14f238-ba11-e388-06ec-027912fc313c@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc14f238-ba11-e388-06ec-027912fc313c@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 18:22:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lxvuC-000huE-Uc; Mon, 28 Jun 2021 15:22:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da944bb1-1ebd-462c-cb6f-08d93a61bc6c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206B05AFE89AF94D58ADDBDC2039@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sp4+rLL63dzeDTmPY0mnOA/TmeKUW7zDYh/FGnTYwi0bIvkSwOxxfvejeJwAtnfk0U54BYPaao8Sy9kscX18+bXSndQQQfFAzjmX6VSSnWkGAyIkQN3IM4zfwySgW5yftynU9VAh2OqEaWySkhMaxO2K/nSi5m7xgmo0BVPMxX9svAm1R9+jAvNp+6nV89YmYca6l2QT8w+i2cUHuOIEy4Sd+JBHKWp/nToyrxhpHEkJVA1O/ReiTDVbMA7Qp1V7XmlrDS5SThEGAD8x7mBhxvfsxlKE2ucc5/mJFCSFGIiCb9UutGYGwFjMv8n4iNL/GH7wTmpuXTs2Y5J27+me2MYPp++ho+6uWc3Jh97F3MmrglxTTVBIUFVbUFoJX6H5f8J/ywl9LZgg6ryPEQp8rdsAh4TyoEYB7qmFdGxkk+TNd++b5uEegK6kQG+IIP7zGQyeoMoY+QqOFmALJOeSYr5iCP1Eql2Wx9VWbBl2p5Reb2ecpIM9jrGI/39cjGLJq168KCBSsRTZFtWT+3b4YsOp3te9R3/WqAZpk3+BScQdB6ZA3OJpnnFTl8av/LzJR/jPQOB1Uo43zOcGAXSS2MDO6NGHwbFZ4rJqSEgqWGfWg5TiKVxuNvex3Hlvkj6lVHOJ4plwq2V365fkSo2mNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66476007)(66946007)(86362001)(36756003)(2906002)(1076003)(38100700002)(33656002)(8936002)(186003)(66556008)(53546011)(7416002)(26005)(83380400001)(9786002)(9746002)(5660300002)(426003)(8676002)(498600001)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZ8Q+vV2hifDl9jyswEYwXTe8nXfdEMqBGH98rspCsd6e4AhXmDvyZjRnbhd?=
 =?us-ascii?Q?4+Q9JBy5ZCMSh2jPerfd+xF7S1ozZeMiGSpKLD/xbON8788R2zC80YjJLrFs?=
 =?us-ascii?Q?cnM/zWZrRvKplbFbWhR+59A00uKWrGdg1MzLBHG/bCeXSaJAde6q5fxukkh4?=
 =?us-ascii?Q?byFRrVRx83qw9B0zobEwGbLv6n7khN0gYf3swtVSnWsbcYFZdSLb66LGIc6R?=
 =?us-ascii?Q?4BAj7A01Z7cL57fBuBEN3Faf6pS4vQCszXxnepb+fOw+nD7ZghYVuaVNZVCT?=
 =?us-ascii?Q?7TzL/HJU2QIkNqeb9cZSrO3LxcAYNOyba8x1qWmIBNmGxZ88S/lvQNxQAiQv?=
 =?us-ascii?Q?3BNirEiAXdW8qLxFGlF8Q754IVSZKNZmi01QAaN88hkTgnK+WDzihpPZxGMA?=
 =?us-ascii?Q?L+IX0CTjcCnUJ/2Q+l+GSXrjGDzRVe3rO5Yl4Ut2omFsvRW2Lr79Ae6Nkz/R?=
 =?us-ascii?Q?IAVwz48YFPkc80ngUoS66TvwGL+VK9qAN+bG9mnDp4tpJT978YmpGK2l573Z?=
 =?us-ascii?Q?l7hSE6yHMl9cd3xy7MyU59bZaZBVi4uWvweRLcOxQqExuspkDAe1ogpnX8//?=
 =?us-ascii?Q?stmkIzhLEq+RmQw6/+UKCIahNZerCDlM5nkEZH8RGo3qnIBN4vq1n+t1BKNM?=
 =?us-ascii?Q?0IV0UeH8vhRwf4T3I51ZCJi81oOpJZ2cSH4JsdzXAXR3siZtGbdkJTOxkohO?=
 =?us-ascii?Q?pU/EwyVkRVq9PkZ/0NefZBngcyLFoKwETsdrNo6/B6lOX77umE1HaC56R0zk?=
 =?us-ascii?Q?8b6n8b6WDMtG5luZa6cpGiCLbxrukfXXGNnkZ79/Rbj7XJwg1ZRB3Ko9MOhA?=
 =?us-ascii?Q?NLRPl5oXDhFxYYhcUToPoUAOHSjp0Zi77DpFNUM5DRhiWi+K6+CiEQHIXTMp?=
 =?us-ascii?Q?5f/hYf2x1+XdFqWEILJFemVRXNkNuGkB3XPfBPNq0tODf9c93ses2Ter8tRM?=
 =?us-ascii?Q?NTVIOEsi88mOiPspnhT0eIQkHqtgIVndXIFXP7SF2AnHOYZ/fLYLUC59O86f?=
 =?us-ascii?Q?qpqPflGD8gkx8goVF11d3QR3KiiEfANJspipKKy7u1Yl9mgyDoYLxLymIi79?=
 =?us-ascii?Q?UG9Qv5sRN8ib+ATAk5mbiHGEhXmxx69bvho+5wRWoZw9a3ywv4YyO59ozvUC?=
 =?us-ascii?Q?bDKa+G4r1EA6FMeZ4FZZ5mqwBA5iwK+LflrD36L3QO5CNlqTUKL3xB9Ids3x?=
 =?us-ascii?Q?kD/l7T0MeuIF1QdYtc9B3aElUFKrWA6VseZeRtW1n4IgGVs8jHcFNGcMJ6dD?=
 =?us-ascii?Q?jiQoO17+XT1mx3CH43tme5y5YxPVeMbyCx6swuayqLMdAIJsHcHbMxN27ugi?=
 =?us-ascii?Q?DGZnsHE8siEobMpps+vrxy20?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da944bb1-1ebd-462c-cb6f-08d93a61bc6c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 18:22:49.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7gKtokRD5zKLS+2U9ZnniktVyb5hD1hGmgR+4f0F6SnMneJ8W0MW48v5Saaq+yx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 28, 2021 at 02:20:55PM -0400, Tony Krowiak wrote:
> 
> 
> On 6/28/21 1:34 PM, Jason Gunthorpe wrote:
> > On Fri, Jun 25, 2021 at 06:07:58PM -0400, Tony Krowiak wrote:
> > >   static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
> > >   {
> > > +	mutex_lock(&matrix_dev->lock);
> > > +	if ((matrix_mdev->kvm) && (matrix_mdev->kvm->arch.crypto.crycbd)) {
> > >   		mutex_unlock(&matrix_dev->lock);
> > > +		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> > > +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> > > +		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> > > +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> > >   		mutex_lock(&matrix_dev->lock);
> > >   		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> > >   		kvm_put_kvm(matrix_mdev->kvm);
> > >   		matrix_mdev->kvm = NULL;
> > > +		mutex_unlock(&matrix_dev->lock);
> > >   	}
> > Doesn't a flow exit the function with matrix_dev->lock held he
> 
> How can that happen? What flow?

When the if isn't taken

> > Write it with 'success oriented flow'
> 
> I'm not sure what you mean, can you clarify this statement?

Basically, don't write the bulk of the function under an if statement

mutex_lock(&matrix_dev->lock);
if (!matrix_mdev->kvm || !matrix_mdev->kvm->arch.crypto.crycbd) {
    mutex_unlock(&matrix_dev->lock);
    return;
}

Jason

