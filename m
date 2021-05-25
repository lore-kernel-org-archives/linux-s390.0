Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F07C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D36600EF
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhEYOSZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 10:18:25 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:38241
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233886AbhEYOSV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 10:18:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhBan8245yqARjDzXpod3B5l8JPuu3i5yhmAxsztcZqzkqIyzd70Ya4F9FOPvCCPqjQ+3ZvfFeAJGOske/7ASOmXxwUllPWz1/9aH0beXaAxN1H1CgHol0qpKqTgO66Xf+ua2aYolmeOsn0YvaYf+9e5b0ZlzRB2lQAUuWhWg8Q+Q1TXUiGw6PVCOrtX635AjqSNFS29niig6tdnga5iML25VJCCOhvZtGG0cIfJqNOsDXOXavPNyllhS5jb8LRm6Gd7WRhnGL9o0rXqS4618jj/OBC8fYcipCK2Fmm0Co1xsanxjkN/3W+A3QCeSi+04TgJ+mPrFNy1542p17B8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU2iAr/29393Wl9ZxzoOlun1anMTvEtGdn1FAusIGOY=;
 b=nmXYAZ+Idgc784NvTPawIY8GnKQW2nYZUNfzfXaokUaVIOULZ3NuKcE5muvuW7hs9lRGncAA1ixKUWQdovz0fWKQ/OUtuanXxTwzGyBmvaTGksInJhvQpSvz+gmw2s/PplMzV1Amh/FZw8VRPorZpRZLPRkmsiun6u75f/0ge9VhjAAVAcrcFOJxwxiURZ4QvMAcQcz2hl4+EawPSJoRTaY267okWXEWd192MLDY/8kl2YzyM9hSLa+Txz4o88BrcQY2yFxh6ioSBFXRLqtwtrphjsjUsxRDrKz6Vu74R8DY3uLqEr38+a6ETXfbkLAfHa7p7utXh8YKNAHm8Nau1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU2iAr/29393Wl9ZxzoOlun1anMTvEtGdn1FAusIGOY=;
 b=oaXuekYw8eslcbgSNbI11NVNRyjIfiDNTviur3BeJyjsLIdl9OkK/0ZeD4/sgfdfJ+YEqCEH+VckcNrRGnVEJTUJh6tZ+fPZqcW7vIciaP+YGYf/p5fmZqOGhCVvlTg+cacPZvdWkbRiMyPfy8+8Un03n7p5QjGel8JJiqeWZhL4eZF7RbRScZqDQ4Tz3UZ/mv71XzmLpc/CHF2Wx2YmoQ++9bEtzWFpGyPEgTTri3HZ2vb4eQ7VuARpYdnQgPMPrE8YZLgXSrstgZAqhmck3oUUXgZlDYlY0jFHKPl4yd18qCTEn100twiXDDqfZ40RuLyeQLVV+ouSgGSVicNqzw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 14:16:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 14:16:48 +0000
Date:   Tue, 25 May 2021 11:16:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Jason J. Herne" <jjherne@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210525141646.GY1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <20df4cd0-7859-4727-42bd-9ef419455039@linux.ibm.com>
 <20210525132628.GX1002214@nvidia.com>
 <e80fcdb4-202b-f339-87c9-987a5b5e6fe3@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80fcdb4-202b-f339-87c9-987a5b5e6fe3@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:610:b2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 14:16:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llXrS-00EFov-QT; Tue, 25 May 2021 11:16:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2983b1b-f792-428f-603d-08d91f87bba9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53362CDED4CB5023B223CCBAC2259@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcOSaIvMA5TfJFi9QGNcIpgDWKFIgP/N+HlhMSU0sg5VRWqG0ORTD1nUqlD/HWza7znI1Vzzj+ZPWz0r/0+2IEgdkCLGJ9/d0o8zwV3yAPVE08mAO1OP89eb+A0JGiCWXNqejnwgIG9rmOfmDHguxJmqIjb9nHdye4GpRipTDCllIa/Ad9+7GhNFFzS/9iXZIoJytB+Bk7IGxr2kNSir0S5rA3b6Kq1NCqmeXfh3bQ0UZZ+3VE0zh/5C45riOUxCA9nJV4Yb4/XxV77PPeHIGQSswljpvbTiiSGuEo2txSaHgRpELhkOznNUjow39pKbiD3/ZpSUo8lHAXpyXKPVVnaQrY+jvTm+KPjnD4jQw3ybB6jE/+lYLK8+1mKc8lCOKFriU0dev77K4cLyVFTeAUWuLE+jxRgBaMpqgQVlTfNzM3dbYYPLGx5yw7LS5ZyD8eSWBDA0b8dTQXVhZxMWKLoPIxty3ApwekuBoLKzOIjQZknZxXa4/lTaePLWJItS1/DJusYsIIfS7zMkDUsdhluq3WiOYwYIPoZz58Z67TrF5biEuLpGzvjISZt/VUomMo9Uwy+E2iHX8Zo/O0hEFPFoBTxlkll9RC1eRul8c/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(7416002)(38100700002)(8936002)(66476007)(186003)(2616005)(53546011)(426003)(86362001)(6916009)(66556008)(1076003)(33656002)(26005)(9786002)(9746002)(478600001)(4326008)(36756003)(8676002)(66946007)(316002)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cBZ4hFkzMH6ojwcBi5U931qCW4Mp/xa+uE86zMCj0RGse+alp2C9K7Kf98T0?=
 =?us-ascii?Q?hzAtEbxEJ0A/aJlIq9pmnCd6EfbwJO9yRQcwhJedZ2YVrIrGhCUExeLtTuDK?=
 =?us-ascii?Q?oiCa+7KyJBE8lb3avihYu+qaNQ34p04/Rm+bWFq1pgOHL57VJHzEpBxf2ZPo?=
 =?us-ascii?Q?OeZU0DKoGz5MxKOeEMjZuMa89HR+3lKRAwLp8+PamUUk8yEBQl4QpV6EZtEX?=
 =?us-ascii?Q?FIjyi82XrMnlQic+bEn9rqL8DY+nsSRt6Df418ywVL1bcIBR4ngGKpIa1Zes?=
 =?us-ascii?Q?ebayufSep90191DAPTl87QwakadAIHua25oN4Hm9iFmxacjePwmbNPoxT78z?=
 =?us-ascii?Q?+3jL7rHJ3LhE8Y8Ou5L0yauNCzsLDjaTP+CUX6n72o+cFBsYCdWWaTDo56CM?=
 =?us-ascii?Q?KSrxDPRghsMhsqr2HOOixQGOKNGEYOSmEVaCBj6uhTQCUDfWSmp0szS1R6iy?=
 =?us-ascii?Q?VcVwcq+EITYj9cG0ndhldzzpmQXi1VdsKwOZl1pmuS8kXeFFd38/8yB1YNaX?=
 =?us-ascii?Q?yQsbhKuaJTo1NdO9jroJ1KqOQhkcITORaz0EEMfGInJ51Nh1l0TthN3tOwuz?=
 =?us-ascii?Q?V1/KUyyzAsgDEYkl5OOXFFGhNmT7AJA+SqK8XVfh3rOHfmPfPaiBHEtzCKLn?=
 =?us-ascii?Q?eC3Z5Phfz0exMtY9lxUA0Wl0idmWfa95vUXMxfzVTeL2sladf5uRKdrxaSvj?=
 =?us-ascii?Q?JcmNPsG+Z7USR9rTKCvN5ug7iBrDLt15vYONHoEyP4TKgE3ESh3qDtAtPbU+?=
 =?us-ascii?Q?0I8bPYHi9IWpH0A4aQUtotUcsd7TGPLQhA75IEybkJhVMWRJD9hAF2o533iW?=
 =?us-ascii?Q?6YQrfuIm3J2Sd0/bCMMi/vY0hGkJG06CeR/MR8zP1E+6p575jv5JyuemVndC?=
 =?us-ascii?Q?CZgiTuUq1F4XoXsLVJiHAEEURIE2cKUhS2dmf04EraK9HBPm1Yjr/VjHUr5D?=
 =?us-ascii?Q?RLPJFXlnnbbq0wNi9l92c9TRBekVaAR+rEueWtxD6Be+k6f3tlBNW9z6Q9VF?=
 =?us-ascii?Q?shHamFbp951fzgzvUoE0MzIUl6enUXFN5xiqoKer9lZHGrBXw909EFrwphCN?=
 =?us-ascii?Q?YYRshpmt1tR0YyG2EsQKE2ETmWVWIt3cfnCr2A4Qfq8oIeunJ9k42DqvxzSo?=
 =?us-ascii?Q?KSyN/8PPrwxSC7T/EKfYyMJ1bwdv+DumW4PAwYvk0JDhqG7cPxmeafccNJa0?=
 =?us-ascii?Q?XF/1AUjESnzfa6uUDoW45XQ27SxnwUZsjaOw3wABdR7B2TbJwAL4A1NaNMJI?=
 =?us-ascii?Q?OiXPfVssjV9dzyGH+w6RgNv07H4eyDzCP9kT2BGdzsHslyiZIVHUVnv9Epsa?=
 =?us-ascii?Q?DajHl1aKYLn8rSg5yYKXDTeU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2983b1b-f792-428f-603d-08d91f87bba9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:16:48.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVid5Qrurc1zqS924CUfQUcZZo4Njl+3eSfAnli1zbeALhybkSVMyU0BosmVLgsD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 10:07:46AM -0400, Jason J. Herne wrote:
> On 5/25/21 9:26 AM, Jason Gunthorpe wrote:
> > On Tue, May 25, 2021 at 09:24:59AM -0400, Jason J. Herne wrote:
> > > change the function pointer to point to vfio_ap_ops:handle_pqap(). When we
> > > unload the module we change the function pointer back to the stub.  The
> > > updates should be atomic operations so no lock needed, right?
> > 
> > No
> > 
> > Jason
> > 
> 
> Okay... Would you be willing to elaborate, please? A counter argument, or a
> simple explanation would be appreciated. A simple "no" does not really do
> much to advance the discussion :).

Go back and review the earlier thread, the issue was never the
atomicity of the function pointer but the locking of the data that
function is accessing.

> I'm fairly sure that a 64-bit pointer would be updated atomically. A reader
> of this value is either going to see value A or value B, not the high half
> of A and the low half of B. Maybe we also need a memory barrier to prevent
> stale values from being seen on another core?

You need to use special macros in Linux to follow this memory model

Jason
