Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198A8C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 23:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE7F611AD
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 23:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhESXX0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 19:23:26 -0400
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:50656
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhESXXZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 19:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsvI6EB2uspGlmYjNA4bX3EdWZAv/UC5k4IqLqvG+KSCsMwLQzgiWVmt6WYhmlQZ3cBLk7fsnEiweYfNUZVrtf2+ht3clAXhmrLJ399c56exJFt/7tWY8ZYSOoNPtzf8sMIptpH1fRvZKHseVmL7vLO8fRz73xJwHmTenr8n+mw7ZBTK5IsWbCLKYp6W+EIkeK+L1aFR2iw5UxihDF32YhHVROdiADdpjgt+8SBAV4akUoUy93UymsOrPsHol8FY0qiDclLq2Ha335ciEZkRV/tC34rtaXPZKBbkKS6KrYu210hiv8QxoYnIBWtgOLGESSJsbu8tdreSaM+0w5CUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u71ZEnmhnuYQn4EFFDmHYZgKvcHospb9myN8pykxvY=;
 b=PzL81Lt73zvYH0Set5XXYj6vkrvPZ+Zj4CqiRGnnNXGVt/MqJYdd7I/kt8IB3X7cWypV8Q10rdkxoSJH4uUXtbVE5ze/W36vPmI1mx1+6feolKomX8Sf+o8KhQgMDZitCkRhXR+ozW2ndVroYqSCEDCH5+KpKr81zquQJUxV3nad1IMe/uSSQbLHDEzMMV0SQFfC7CdHtZ133ScFl9t09IN533V3Cbff5x4gYFTBov+Tprj6MfHgWUgFv0dgIcW/x5PtqTxbZyIfOacpP0RO1yekFOmgCCphqSkBIaXYmoBRSjB+Z3JyNSf4wLKlbCmwuKcIGS5dmbl+S6RRYRx3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u71ZEnmhnuYQn4EFFDmHYZgKvcHospb9myN8pykxvY=;
 b=C0uZaCY/3kZFDQ1n//Ehv0uGB5pRBdwh2QNOknK4r3ldeFUZHs3EN5u3kZruSVReXYAYfBKSvrMuS2zQaYXU8nXkdO9KiSRIWaFo/9Ch34PQN5AcC1l5xVl7GuxGFKvj/+7YKEqBnU+uRRONLGjdACb2xT93cqHGfkIRTqsq7P2kY2viTUFs3IyA+CCarF7hDJybOI59T+Q02Z10ru5Zn08dDf5kHh/venujp4MlPkB4e+jKmtCRdqtuuhH0z07xKb11UUTc9VduzXl3MTYD39mzeLyUxO/f6pF01cfdoy15IHZBmexW8GaP4KVK6wvT7lJ/WeQdlqqZcZVh+FxI0w==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 23:22:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 23:22:04 +0000
Date:   Wed, 19 May 2021 20:22:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210519232202.GV1002214@nvidia.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
 <20210519161610.GO1002214@nvidia.com>
 <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:207:3c::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:207:3c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 23:22:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljVVq-00AxLF-R5; Wed, 19 May 2021 20:22:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ff8a12-e5f8-46d4-6713-08d91b1ce99d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4973C9171C0110E389304AB3C22B9@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OA3Z9dI8dUDuUVhB5+AEPSFtTrT08z1VMsbD/i8q2gKe85x7J38LfD5ar3MUpvp7ocRjvVN+u3ow+AwtfHxQ0ZWsB6FTrUTh5LSgSdv+bDeaXuE22nzbVn7Yz9zUi0BgUj2DisrCFgQ/Fc4eR8JCQkIYGK0uLwA72vcZ7YVu6LjfJJtr9x2Ui0WSaS0GqBzHl40Dx3DaFultd+0AbBsD1ntTcGTDuAKsGJ+Ehcfx8AfFfWCYpgcUXXiA5q34zn/ayKhktHXzY01QBEto2NeX6Ts0CHiwvrkRU3sxILKXlCdtN8taFWakp2WLWH+TSTb2e8nX3IlF17wHNUX+1/nd55JbveoXEZ0S+BLIae2hCM2E16+nKduACzroJQcSGK/nOPv+107hy4/e+es0CLAhwGjzN75duBDCWNlmxJrA9LwrrXXJJ17Or2H+PLhIS/E79s28Rp4WXIOvBpdBBt84napDTBceZ5e/gVyboFycAYUt92nWdoBhh4Uzv6BHA4jjd56Ecrte5EG+FBkbl0TByPoQPcn2UrVytJd023hjgm9tfQ6lKRoVsIAfonaGKt5EBdmWLCAdiqvqJe0r1+RHS0g7eudf+/2EBaFizyMkwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(66476007)(66556008)(8936002)(9746002)(66946007)(316002)(8676002)(478600001)(33656002)(86362001)(1076003)(4326008)(107886003)(186003)(36756003)(426003)(53546011)(26005)(2616005)(2906002)(5660300002)(9786002)(38100700002)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1CUHhNA/s5O2T1kfhqanOnGNQD3SHlD8rHjwMyDGfXRlPwYVTlcsu4S9fOiq?=
 =?us-ascii?Q?MoDUBwYpaEmEbiqJWtGlP2cGTrZ2vEv6ck9oHzHe39WBDeDlaBlL+coHmQOs?=
 =?us-ascii?Q?8SHVsjHeGKTcFw4XGsiP15FwRNirInd+f/IeMfyKzWsHcaxUs111jYN9Kp4J?=
 =?us-ascii?Q?4vcr/YaMuut1TL4ohRi53FfxZiiicDk5IQkwWx+PxzGWkukFcmMgTwdtdDiH?=
 =?us-ascii?Q?lVjVxR7BOnFRNqDD550hI2/4oJObmbsJfE2B1KKhvYYpOqCBSV99eJglD6w2?=
 =?us-ascii?Q?xhr4rpT3isdp4QHzWNzy4KwS4kua528Qc80PiQ9aXGL7FsgRZ4OEoyW7JCfl?=
 =?us-ascii?Q?uxkJKyR21fJYxH8TFyOaeXtc+K7PZ6KyAjqtFb9SopYws9uyE37OlIAk73bK?=
 =?us-ascii?Q?EnQL2uUYrDKX/sDtAjoMUrtQ8IolT4QRwGJpED4oTHyzsWsEMVdU4X6rTdlq?=
 =?us-ascii?Q?PTLUeLreEKDO0YrPMY5ct2FB/wCCIq61A41jRnBqmful8tw7GKE3jvTbW+Je?=
 =?us-ascii?Q?kjKA+LX9D0LCRKezOTuVMcZt1lorT+qmia7POsr+vBIW+VJADEf5U9xlhres?=
 =?us-ascii?Q?QUZ9k8iMFhxWSbpg9Qn3EXjDd0ud+mB+7RE3/PB723Gd611+AvpQiBNUXy0L?=
 =?us-ascii?Q?fxr7dn1vu3bj8XzXiZ4f2Eoi7r7esl1fUCj4jNIYeN+oV4T9c2O1n82CJ8TY?=
 =?us-ascii?Q?byrBNHekLteDs3gvDqiLV4G1QeVGW/34OslGn4jSu2rKAdILZUFuYBNwimPk?=
 =?us-ascii?Q?vQOJbNFzi4XMvFuYGxiRR8BTAtuq1iY7lUL/FQ3oIgFSIDZv351bC8yoAULC?=
 =?us-ascii?Q?U8L9mDN0qQ/iHaoLYBzHzFMnHZetQYexeuqqVFFuzsEr+JZUUccmzWfARlWx?=
 =?us-ascii?Q?4ByZxV2w1iDLG/CQ0sfvS/jXStJoI6SnN4o8UUhjdA1Cg09DliWe87rcF+Z/?=
 =?us-ascii?Q?p/j9bNZ4afhOVStbOVdYJ8yr8ncYUmQohxApM7qiOv2MTG6JPM/Tq2C/7eJ/?=
 =?us-ascii?Q?eD04egD9cAbf15rZDBT6i1o1F/PfUHBmiCbL/gmgsRKigfoPEwacKyzRRNcr?=
 =?us-ascii?Q?oB9StvhRhYhE0ZM/0+PiiBOMnIRpVFeF1LucL11GXxRM1fCRRYyF7kUyZsPl?=
 =?us-ascii?Q?Wm4qZXJvclxugd/X1af6CgRZo01J+4Yide8alBrrK6XgSDuBi72eCWWdGrZX?=
 =?us-ascii?Q?zbiBP1IVW3/42l3UYywXy3Nc5DekYSBWgVC56jxQ1FM2o4HBsg0jWhBER+nq?=
 =?us-ascii?Q?a3qh+lDe/BgKYT0snoiqEDqgmgc0chK4110oZ9DQFk/BAwr8TlhSFlIq3POU?=
 =?us-ascii?Q?3L+qAU0baOd3RM1+6m0uaqmH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ff8a12-e5f8-46d4-6713-08d91b1ce99d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 23:22:04.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5Y5UqaAFVTjIOYV9x4ye/1vj42Th3PmQC2e6NV63KtplvnQXVEu0ruw6H5zabXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 19, 2021 at 07:04:46PM -0400, Tony Krowiak wrote:
> 
> 
> On 5/19/21 12:16 PM, Jason Gunthorpe wrote:
> > On Wed, May 19, 2021 at 11:39:21AM -0400, Tony Krowiak wrote:
> > 
> > > @@ -287,13 +289,17 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
> > >   	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
> > >   		return -EOPNOTSUPP;
> > > -	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> > > -	mutex_lock(&matrix_dev->lock);
> > > +	rcu_read_lock();
> > > +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
> > > +	if (!pqap_module_hook) {
> > > +		rcu_read_unlock();
> > > +		goto set_status;
> > > +	}
> > > -	if (!vcpu->kvm->arch.crypto.pqap_hook)
> > > -		goto out_unlock;
> > > -	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
> > > -				   struct ap_matrix_mdev, pqap_hook);
> > > +	matrix_mdev = pqap_module_hook->data;
> > > +	rcu_read_unlock();
> > > +	mutex_lock(&matrix_dev->lock);
> > The matrix_mdev pointer was extracted from the pqap_module_hook,
> > but now there is nothing protecting it since the rcu was dropped and
> > it gets freed in vfio_ap_mdev_remove.
> 
> Therein lies the rub. We can't hold the rcu_read_lock across the
> entire time that the interception is being processed because of
> wait conditions in the interception handler. Regardless of whether
> the pointer to the matrix_mdev is retrieved as the container of
> or extracted from the pqap_hook, there is nothing protecting it
> and there appears to be no way to do so using RCU.

RCU is a lock that should only be used for highly performance
sensitive read work loads. It eliminates one atomic from a lock, but
if you go on to immediately do something like try_module_get, which
has an atomic inside, the whole thing is pointless (assuming
try_module_get was even the right thing to do)

Use a simple sleepable rwsem around the whole thing and forget about
the module_get. Hold the write side when NULL'ing the pointer.

> > And, again, module locking doesn't prevent vfio_ap_mdev_remove() from
> > being called. None of these patches should be combining module locking
> > with RCU.
> 
> Is there any other way besides user interaction with the mdev's
> sysfs remove interface for the remove callback to get invoked?

There are more options after my re-organizing series.

But I'm not sure why you ask in response to my point about module
locking? Module locking is not really related to sysfs.

> If I try to remove the mdev using the sysfs interface while the
> mdev fd is still open by the guest, the remove hangs until the
> fd is closed.

Yes, it will wait when the vfio_device is being destroyed.

> That being the case, the mdev release callback will get invoked
> prior to the remove callback being invoked which renders this whole
> debate moot. What am I missing here?

AFAICT the control flow is such that release can immediately move on
to remove on the same CPU without an additional synchronization. So
the kfree can still race with the above.

But the more I look at this the wonkier it is.. The real issue is not
the matrix_mdev, it is the whole vcpu->kvm->arch.crypto.pqap_hook

This is nonesense too:

	if (vcpu->kvm->arch.crypto.pqap_hook) {
		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
			return -EOPNOTSUPP;
		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);

It should have a lock around it of some kind, not a
try_module_get. module_get is not la lock.

And that lock should interact with loading the hook in the first
place:
		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;

And of course NULLin'g the hooke should be synchronous with the lock.

There should be no owner for something like this. unregistering the
function pointer should fully fence all access.

The simple solution in sketch is just this:

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9928f785c6773a..f70386452367dd 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -657,13 +657,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * Verify that the hook callback is registered, lock the owner
 	 * and call the hook.
 	 */
-	if (vcpu->kvm->arch.crypto.pqap_hook) {
-		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
-			return -EOPNOTSUPP;
+	if (down_read_trylock(&vcpu->kvm->arch.crypto.rwsem) &&
+	    vcpu->kvm->arch.crypto.pqap_hook) {
 		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
-		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
 		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
 			kvm_s390_set_psw_cc(vcpu, 3);
+		up_read(&vcpu->kv->arch.crypto.rwsem);
 		return ret;
 	}
 	/*
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b2c7e10dfdcdcf..64c89f6a711e94 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -352,8 +352,7 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
 	mdev_set_drvdata(mdev, matrix_mdev);
-	matrix_mdev->pqap_hook.hook = handle_pqap;
-	matrix_mdev->pqap_hook.owner = THIS_MODULE;
+	down_write(&&vcpu->kvm->arch.crypto.rwsem);
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
@@ -1132,7 +1131,9 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 					  matrix_mdev->matrix.aqm,
 					  matrix_mdev->matrix.adm);
 		mutex_lock(&matrix_dev->lock);
+		down_write(&kvm->arch.crypto.rwsem);
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
+		up_write(&kvm->arch.crypto.rwsem);
 		matrix_mdev->kvm = kvm;
 		matrix_mdev->kvm_busy = false;
 		wake_up_all(&matrix_mdev->wait_for_kvm);
@@ -1202,7 +1203,9 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 		mutex_lock(&matrix_dev->lock);
 		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+		down_write(&matrix_mdev->kvm->arch.crypto.rwsem);
 		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+		up_write(&matrix_mdev->kvm->arch.crypto.rwsem);
 		kvm_put_kvm(matrix_mdev->kvm);
 		matrix_mdev->kvm = NULL;
 		matrix_mdev->kvm_busy = false;


Jason
