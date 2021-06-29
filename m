Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA5C11F66
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7053261D3A
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 13:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhF2NZF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:25:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232487AbhF2NZE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Jun 2021 09:25:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TD4XE6157173;
        Tue, 29 Jun 2021 09:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject :
 reply-to : to : cc : references : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=typfn8cyL4ndq724YUiH//CBGh7Mu9eFum4VQM3/62o=;
 b=HBBM0SxuqfPE3ubN2K3Qx4t5pJgsjAMD0IJuABXD8wG9a8tcVzn1omrAObHiIvcUCFZK
 fTIz0DrGqUS2N++w75pzkqrxIhA2X3vn2MNiuumQj525jCbKulVOQE4PfyXSZD4RxI2F
 /7Wn2++FahIUBWbwpSc0wtikL/nZpElgx1SH6+7l7szI/4Nrms0F5+dbz+Ip1gyR+f/D
 ujp8T5AZTWWmqfXhFI5vsTDKhFXJHPb5EqnCdBqeEFRcGyjaUGma2YfOxNfugNWZZoZ8
 kZoD+OAv+DUcwRTep5KeG4h56WDo+FsONYXAKJFZvkBJlnd7EVdtmZQszeoE1sG/rIM1 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g33yach6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 09:22:35 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15TD5KWw165306;
        Tue, 29 Jun 2021 09:22:35 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g33yacgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 09:22:35 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TDDLQm003422;
        Tue, 29 Jun 2021 13:22:34 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 39duvcq8fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 13:22:34 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TDLWO823134680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 13:21:32 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09C48124510;
        Tue, 29 Jun 2021 13:21:32 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84EA312453E;
        Tue, 29 Jun 2021 13:21:31 +0000 (GMT)
Received: from [9.85.182.170] (unknown [9.85.182.170])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 13:21:31 +0000 (GMT)
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
Reply-To: jjherne@linux.ibm.com
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
Organization: IBM
Message-ID: <a37d2816-47fc-ef6b-eb59-c5782e13ca12@linux.ibm.com>
Date:   Tue, 29 Jun 2021 09:21:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20210625220758.80365-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: whLCZ5Kvr18j1zno54zT_srwVuBJpF7y
X-Proofpoint-GUID: bAyszJ9f7yxRDHm_KaVZlJ2f2WQwpNaC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 6/25/21 6:07 PM, Tony Krowiak wrote:
> The fix to resolve a lockdep splat while handling the
> VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
> the vfio_ap device driver is busy setting or unsetting the KVM pointer.
> A wait queue was employed to allow functions requiring access to the KVM
> pointer to wait for the kvm_busy flag to be cleared. For the duration of
> the wait period, the mdev lock was unlocked then acquired again after the
> kvm_busy flag was cleared. This got rid of the lockdep report, but didn't
> really resolve the problem.
> 
> This patch removes the the kvm_busy flag and wait queue as they are not
> necessary to resolve the lockdep splat problem. The wait queue was
> introduced to prevent changes to the matrix used to update the guest's
> AP configuration. The idea was that whenever an adapter, domain or control
> domain was being assigned to or unassigned from the matrix, the function
> would wait until the group notifier function was no longer busy with the
> KVM pointer.
> 
> The thing is, the KVM pointer value (matrix_mdev->kvm) is always set and
> cleared while holding the matrix_dev->lock mutex. The assignment and
> unassignment interfaces also lock the matrix_dev->lock mutex prior to
> checking whether the matrix_mdev->kvm pointer is set and if so, returns
> the -EBUSY error from the function. Consequently, there is no chance for
> an update to the matrix to occur while the guest's AP configuration is
> being updated.
> 
> Fixes: 0cc00c8d4050 ("s390/vfio-ap: fix circular lockdep when setting/clearing crypto masks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 77 +++++++--------------------
>   drivers/s390/crypto/vfio_ap_private.h |  2 -
>   2 files changed, 20 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 742277bc8d1c..99a58f54c076 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -294,15 +294,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
>   				   struct ap_matrix_mdev, pqap_hook);
>   
> -	/*
> -	 * If the KVM pointer is in the process of being set, wait until the
> -	 * process has completed.
> -	 */
> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> -		       !matrix_mdev->kvm_busy,
> -		       mutex_unlock(&matrix_dev->lock),
> -		       mutex_lock(&matrix_dev->lock));
> -
>   	/* If the there is no guest using the mdev, there is nothing to do */
>   	if (!matrix_mdev->kvm)
>   		goto out_unlock;
> @@ -350,7 +341,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>   
>   	matrix_mdev->mdev = mdev;
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
> -	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>   	mdev_set_drvdata(mdev, matrix_mdev);
>   	matrix_mdev->pqap_hook = handle_pqap;
>   	mutex_lock(&matrix_dev->lock);
> @@ -623,7 +613,7 @@ static ssize_t assign_adapter_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of adapter
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -696,7 +686,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of adapter
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -786,7 +776,7 @@ static ssize_t assign_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * assignment of domain
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -854,7 +844,7 @@ static ssize_t unassign_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of domain
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -908,7 +898,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * assignment of control domain.
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -967,7 +957,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of control domain.
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -1108,14 +1098,17 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   	struct ap_matrix_mdev *m;
>   
>   	if (kvm->arch.crypto.crycbd) {
> +		mutex_lock(&matrix_dev->lock);
> +
>   		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> -			if (m != matrix_mdev && m->kvm == kvm)
> +			if (m != matrix_mdev && m->kvm == kvm) {
> +				mutex_unlock(&matrix_dev->lock);
>   				return -EPERM;
> +			}
>   		}
>   
>   		kvm_get_kvm(kvm);
>   		matrix_mdev->kvm = kvm;
> -		matrix_mdev->kvm_busy = true;
>   		mutex_unlock(&matrix_dev->lock);
>   
>   		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> @@ -1126,10 +1119,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   					  matrix_mdev->matrix.apm,
>   					  matrix_mdev->matrix.aqm,
>   					  matrix_mdev->matrix.adm);
> -
> -		mutex_lock(&matrix_dev->lock);
> -		matrix_mdev->kvm_busy = false;
> -		wake_up_all(&matrix_mdev->wait_for_kvm);
>   	}
>   
>   	return 0;
> @@ -1181,33 +1170,21 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>    */
>   static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   {
> -	/*
> -	 * If the KVM pointer is in the process of being set, wait until the
> -	 * process has completed.
> -	 */
> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> -		       !matrix_mdev->kvm_busy,
> -		       mutex_unlock(&matrix_dev->lock),
> -		       mutex_lock(&matrix_dev->lock));
> +	mutex_lock(&matrix_dev->lock);
>   
> -	if (matrix_mdev->kvm) {
> -		matrix_mdev->kvm_busy = true;
> +	if ((matrix_mdev->kvm) && (matrix_mdev->kvm->arch.crypto.crycbd)) {
>   		mutex_unlock(&matrix_dev->lock);


If this function cannot be entered concurrently on separate threads then I think we can 
remove this mutex_unlock of matrix_dev->lock, (and the above mutex_lock) All that happens 
while holding the lock is the examination of the matrix_mdev->kvm pointer and then the 
subsequent examination of matrix_mdev->kvm->arch.crypto.crycbd. And since this function
is the only place that the kvm pointer is NULLed I don't see how the kvm pointer could go 
away between the two parts of the conditional.  Again, this is only true if this function 
cannot be entered concurrently.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
