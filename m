Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC4EC4707F
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB99F61358
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 11:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhE0L0K (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 May 2021 07:26:10 -0400
Received: from mail-dm6nam08on2089.outbound.protection.outlook.com ([40.107.102.89]:17472
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhE0L0K (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 May 2021 07:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyIzTy0eAzsB0htBrqIRq2slitk3cp2IUCJ2ZgBMHTxKXvx6NSvEweJGrFo/FUETdrAcGbjqdBzmbcaer40Q63ogfSworVl+i+joZA5GTcJONyZCpAG1emL532nfi9EHRXhCChw9PH5g0KVclxHliYOau3hf/InjaCP2NKAOiJZ+Pe9AiJgkmlawmXrkXtO3iowVCWb5JOdz2SYmtEIHEuHfSh1dv9EUE8Cnhye1V851Bk1PvAYtvU//BFbC606mpfZ+ICWHQbVl4DgtV46DW2Il6Ih/wscC1U+g1iyeR4G4Pi+vCRb5PTAlKkvSfb0J0PJZeXCwQXT0VGxEnc89eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+GLlbyavN2s4LlXhC05paHiRoLrZ64ztRX12w67Qs8=;
 b=UOfRmGAAjvTEfhcQ5LuZYDh/hRHEAnUdOnFZgsyR0XUtz4xIbyaqLftuJ+JEbLhHsvbHM8OJPBE9/T8+cdV+uCHzlCoYwtugMczNNP9D82A1FJThlrtbWIe43TAhJbpToGtuIWV+MTXeRzKYNQcfMCMPdgwpaXUlJtKN/VqDb60toKE7dfTBCFkqknMtTLQe+WtUuD11fZPS3/w30PpqOBhNkPLVYX2mgHgDhozn2e2ON0SsB4hrzmsJqlLeDVBBurAPkmgesRpe3oWt5iFie4jhlyKl6yN/Ppggp0vZ675M5xpbKV+4H5DWw/13qtCLlXCsooJh1D/w7pz+ca0ZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+GLlbyavN2s4LlXhC05paHiRoLrZ64ztRX12w67Qs8=;
 b=iu6mWV6lPLcENYc847UpOBycMc8gcK8O9vUmDFF+pqoLte2G+WQYMXFoOcJND6Ux7Frn2Kr5C/IM9oX37rR8mhrOI/djhe87uxx1PSazBfwn/OpdRr/Rnw+k84DxNPoTEDnFLx+Mu+res9uMSv3rl3wJR/eqTC3YT2Fh+z7O7sj+ywHkxKXHfkKW2hlvf2U8whcrJcAgALBrFDen0WDeafyjbCAESv/xFwF9/kRP01Xrb9yYr8cXuUvflXel14xkQ2g2aRylBwRj1+HIqmsdkT0xDDFO+yLiZvUTkUSrpCLA/k6E+1zbVSB3gP2sd0xuhaRGDSR7OiE9jklXI3GGLQ==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 11:24:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Thu, 27 May 2021
 11:24:36 +0000
Date:   Thu, 27 May 2021 08:24:33 -0300
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
Message-ID: <20210527112433.GX1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
 <20210525131912.GW1002214@nvidia.com>
 <c54ef522-f348-df16-a99f-1e31feb1b0bd@linux.ibm.com>
 <20210525162927.GC1002214@nvidia.com>
 <966142da-779f-d604-c6f6-e58cec128e5d@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966142da-779f-d604-c6f6-e58cec128e5d@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Thu, 27 May 2021 11:24:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmE7t-00FXJ3-SK; Thu, 27 May 2021 08:24:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bce5b8be-498f-4705-3dc8-08d921020237
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555673A4B43E694886772653C2239@BL0PR12MB5556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Fyqh+IM8RZKzZtBithyk3tZ/Zjrx5ZM4EK9jqMC28lvd5WRA/41/j55fUy52C2Y78TuDntdpLN4CfCJdUW4d+r0rpoRLYMiHEH/GJIB2ybuixpP23OVaXYfNCvusrrYOkzzd3GxCN3Yv1NQ0Y9+t8h9AcdcUDhU+Nyb25MoEaI2XVEHhJOMeyBtxQqZ/2Zu0XBu3qDUQBRJaC6Fm6/YrjjpEAymTTLxwe///NLO2Nniyc/F4vy2aVM+8qFNOohqQc8dqiTNpuwtGARJEO6DfL69Yn5955qVjSFtReeCFiPV3NRSVByO+JztF2snVgsbOV2dEYpqX4PH0MJeuG9+JSgpxQKewPCnzw07HgavPe16MkrtEKk5ysad9ljE9kvRhP9+VCYyvpGtBJyMQ4UGcm9xuobgQ/ug8JBScHfmVfjMvrg/4dXwYQx2YStIOGhcPtF1a1p6UW0bpQf3JUfMbgKyftL4Qt1QHrIsrCsSGBqDP5Dr9cte/y+KMHppRwjdbfS/QRc6cZ3qR1vyHjwk0l9DjNZwSIlsxzMCFYw4CLP2RNAJZnT2vMtsScwyqmQUgHbwJjBqzYdwiUOH7IUmQpkrB/5dH/zchBz+wzipTHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(83380400001)(478600001)(8936002)(7416002)(8676002)(38100700002)(5660300002)(426003)(33656002)(53546011)(86362001)(6916009)(1076003)(66556008)(316002)(66476007)(2906002)(26005)(9786002)(9746002)(36756003)(4326008)(186003)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YHP2NGJFEhHYLbxMcpSQgK7pqbWSZIZSTWt6hFeA7YaSQKw+JSx7rnJXE7oO?=
 =?us-ascii?Q?oUI+PA+dMsiCj3dDs9Kr9pqXcC3qD53Qh7lC2qYY0fZDFc5LLfAvBwSWFHAB?=
 =?us-ascii?Q?Yh3b8FbugtwsVCWU+3mw1NBYXAkJ09mM7Nx5y4W5kHdr9GkoAVbyXlrpPbHp?=
 =?us-ascii?Q?L1rYrOivXVOvnP6MOuANicTR8Z2wM2pzCRG2d0vUx2mOIuPxf5Dpxj1Wc6J6?=
 =?us-ascii?Q?WKamYLCt20eC2ENe8s8EP2obXn6Vt9CIwqr3nhmrL8/v3J8uPs9Hnrps/JRo?=
 =?us-ascii?Q?oQnD6U9Ok2SbkMfQi1uKBEfWl5JsLIeAK1n6Yvn1yqjICgSZBgyj/ALeDggL?=
 =?us-ascii?Q?wLeucvvDJyOVKt4T/c6cO2bz7E9Vhd6+nRhSpjGefBRYfEDVOuCxrcsQN3h/?=
 =?us-ascii?Q?CGSyl9ZFqXEUaW67pEJLHPd7YdsqTdZOtYreH5dq2q7TQMs56YD82b4e6+yj?=
 =?us-ascii?Q?Pn0AEoeYUqy90wlSffOnWtGyPdP97kjPYRLVjzEBDPQI9bYGQNWxsZfDR59v?=
 =?us-ascii?Q?rmS9c/GCgrtdRJ7M7fR49Q5vav+GPYuID2kvMzGBSUZRao9urAKxqrH421CI?=
 =?us-ascii?Q?tRMxh3vrGoc9y1S2admI2ItWA8gcdugyb2ekZ7qQV/eEHSnx+tLyEnYaqbyU?=
 =?us-ascii?Q?tzqjEVGw/MzpeTcRGNIfmJeKIRIbA1zh19sweKrbM5wEsuh8Zc7LdRvPCVNF?=
 =?us-ascii?Q?Yzv1zIEVVihWPXiMM3441J/epNFWQrKAIahzqrIyElmZT0z69Q+mY9nZgSBc?=
 =?us-ascii?Q?D5NPoqg4o+8COmiNEH2iCtp+H8eMotDd6JTkBLuMef6THUcIvAv5ZSKrhTuu?=
 =?us-ascii?Q?FhVsuLVbfBN//sdPZzP+mcbHOYWR4E0bjwLkXL7OwsiuDWssDO59eoY7pmW7?=
 =?us-ascii?Q?ZObovA4+uRQMGzZ2eO6rYP+eWI+t/aQHoDrhQclkFJsK5SI4LVWiCUQPU5x0?=
 =?us-ascii?Q?uyKH+VJrBUUkaiZueQJJYIg7jYM3Co/AEQRcrvUuhoBzkywOXpQMFcoBiJew?=
 =?us-ascii?Q?ji0ly3dofyUqAjzVccobPfqm6JF+tLHhl/pDA2JpxchTSAgnFu96oaZFtZFx?=
 =?us-ascii?Q?hTV4UW7DUZDi5UISP6pZeJo2LUhDkKaD1DreXW5Kso9VXu4KpbsY0Pbadres?=
 =?us-ascii?Q?H+McgTnmT2wYVTS5fTJF955NA0kTLuYT+8PeHOg3pYN5f3QyC9q+7WZqrXh8?=
 =?us-ascii?Q?b15VXofKkdmQdQF8s+XeyKgQY9DOKH/wTvOYSo8xgH+YRWBweDdqldUaiKd1?=
 =?us-ascii?Q?MCbMPFcW7sAHsGfkOgw+k+AQipaAuAH0hZCXlsXXAHD6Gu5+YRgFRUeQJ8Vj?=
 =?us-ascii?Q?oqtQpGG4u2l/1hkgPPBTRjNc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce5b8be-498f-4705-3dc8-08d921020237
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:24:36.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/b71o+qYYJaq1rrLE0qAcC9EdJJS7S0ZX9GSCPp6bROoUXZ9IkwZVeJytZm6Rrx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 26, 2021 at 10:28:29PM -0400, Tony Krowiak wrote:
> 
> 
> On 5/25/21 12:29 PM, Jason Gunthorpe wrote:
> > On Tue, May 25, 2021 at 11:56:50AM -0400, Tony Krowiak wrote:
> > 
> > > The vfio_ap_mdev_unset_kvm() function, however, is called both by
> > > the group notifier when the KVM pointer has been cleared or when the
> > > mdev is being removed. In both cases, the only way to get the KVM
> > > pointer - which is needed to unplug the AP resources from the guest
> > > - is from the matrix_mdev which contains it.
> > Okay, but that isn't a problem, the matrix dev holds a ref on the kvm
> > pointer so we can just copy it outside the lock after we prevent it
> > from changing by unregistering the notifier:
> > 
> > @@ -1362,14 +1365,19 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
> >   {
> >          struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> > -       mutex_lock(&matrix_dev->lock);
> > -       vfio_ap_mdev_unset_kvm(matrix_mdev);
> > -       mutex_unlock(&matrix_dev->lock);
> > -
> >          vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> >                                   &matrix_mdev->iommu_notifier);
> >          vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> >                                   &matrix_mdev->group_notifier);
> > +
> > +       mutex_lock(&matrix_dev->lock);
> > +       /* matrix_dev->kvm cannot be changed now since we removed the notifiers */
> > +       kvm = matrix_mdev->kvm;
> > +       matrix_mdev->kvm = NULL;
> > +       mutex_unlock(&matrix_dev->lock);
> > +
> > +       vfio_ap_mdev_unset_kvm(matrix_mdev, kvm);
> > +
> >          module_put(THIS_MODULE);
> > 
> > Note the above misordering is an existing bug too
> > 
> > And reoganize unset_kvm so it uses internal locking and gets the kvm
> > from the argument.
> 
> As I told you in a previous email, this is not a trivial exercise.

Well, it is not a 5 line patch, but it looks like 10 mins work and
some testing to me, tracking down all the uses of matrx_mdev->kvm
under the vfio_ap_mdev_unset_kvm() call does not seem difficult nor do
there seem to be so many.

> vfio_ap_free_aqic_resources() function. In order to unregister the
> the guest's ISC, the matrix_mdev->kvm pointer must still
> be set, however, you cleared it above.

Which is why I said unset_kvm needs to be reorganized to use the kvm
argument, not the matrixt_mdev->kvm

> Another thing you're overlooking is the fact that all of the
> assignment/unassignment functions associated with the
> corresponding syfs attributes of the mdev change the
> content of the matrix_mdev->matrix and
> matrix_mdev->shadow_apcb structures. In particular,
> the matrix_mdev->matrix contains the APQNs of the
> queues that must be reset. These sysfs attributes can
> be accessed at any time including when the
> vfio_ap_mdev_unset_kvm() function is executing,
> so that is something that must also be taken into
> consideration.

I checked and thought they already had a lock?
 
> > Also the kvm_busy should be replaced by a proper rwsem, don't try to
> > open code locks like that - it just defeats lockdep analysis.
> 
> I've had no luck trying to refactor this using rwsem. I always
> run into lockdep problems between the matrix_dev->lock
> and matrix_mdev->rwsem, even if the locking order is maintained.

Usually when people start open coding locks it is often because
lockdep complained.

Open coding a lock makes lockdep stop because the lockdep code is
removed, but it doesn't fix anything.

> Clearly, I am lacking in understanding of how these locks
> interact. Any clues here?

I'd have to see the lockdep reports and look at it quite a lot
more. 

Jason
