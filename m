Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BAC12002
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jul 2021 14:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8824B61221
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jul 2021 14:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhGUOFa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:05:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232977AbhGUOF3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Jul 2021 10:05:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LEXGE6016086;
        Wed, 21 Jul 2021 10:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=idOSKcIpSGAJCFkAxhVfxNrXuZDZVWjSg4IXQKAQfKE=;
 b=Zvd1yKxfs0V2BAD32UYslyzCjxyZQupea4xRTwXP/DNmFaLTCfLyykyQ90YXJ3vI89Mb
 wc/X+fts0l8tWZOXiYAPk3QDrVUiPqUMj779KZZ09GTosmCf2xbfyp5AX2eG6neqMA9/
 z1j7YKgK3bKnOuVXJWh7JkhBT3/cMUZkZGYV1sdSEnjw4rcH81qoS91YxW5lRyDaaIKL
 eheUWMxRZ3sx6vB7CDjcEM3EvBCIdYqwcLXyOtGfweuxRrCflWlUO7ulAO9d4Uz8Rivp
 zJKF42RWdIvmEoGvlxn1Te3X5VABDt5xMox1AMWElNenHZI2YRoaAspXjzS4kyefNz6H 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xkeemes9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 10:46:03 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16LEXlQs018761;
        Wed, 21 Jul 2021 10:46:02 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xkeemek3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 10:46:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16LEhiTh023345;
        Wed, 21 Jul 2021 14:45:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu89xn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 14:45:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16LEjsqO30540110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 14:45:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2899E42045;
        Wed, 21 Jul 2021 14:45:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1378C42042;
        Wed, 21 Jul 2021 14:45:53 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.34.151])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 21 Jul 2021 14:45:52 +0000 (GMT)
Date:   Wed, 21 Jul 2021 16:45:50 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210721164550.5402fe1c.pasic@linux.ibm.com>
In-Reply-To: <20210719193503.793910-3-akrowiak@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-3-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tOr7mkqCo33hLxPXSEAClv6pfQtjgpgP
X-Proofpoint-ORIG-GUID: F0wvlLJxm9y82zazex2Nac9ePluYyTaj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_09:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 19 Jul 2021 15:35:03 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> It was pointed out during an unrelated patch review that locks should not

[..]

> -static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
> +static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev,
> +				   struct kvm *kvm)
>  {
> -	/*
> -	 * If the KVM pointer is in the process of being set, wait until the
> -	 * process has completed.
> -	 */
> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> -		       !matrix_mdev->kvm_busy,
> -		       mutex_unlock(&matrix_dev->lock),
> -		       mutex_lock(&matrix_dev->lock));
> -
> -	if (matrix_mdev->kvm) {

We used to check if matrix_mdev->kvm is null, but ...

> -		matrix_mdev->kvm_busy = true;
> -		mutex_unlock(&matrix_dev->lock);
> -
> -		if (matrix_mdev->kvm->arch.crypto.crycbd) {
> -			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> -			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> -			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> -
> -			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> -		}
> +	if (kvm->arch.crypto.crycbd) {

... now we just try to dereference it. And ..

> +		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +		kvm->arch.crypto.pqap_hook = NULL;
> +		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> 
> +		mutex_lock(&kvm->lock);
>  		mutex_lock(&matrix_dev->lock);
> +
> +		kvm_arch_crypto_clear_masks(kvm);
>  		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> -		kvm_put_kvm(matrix_mdev->kvm);
> +		kvm_put_kvm(kvm);
>  		matrix_mdev->kvm = NULL;
> -		matrix_mdev->kvm_busy = false;
> -		wake_up_all(&matrix_mdev->wait_for_kvm);
> +
> +		mutex_unlock(&kvm->lock);
> +		mutex_unlock(&matrix_dev->lock);
>  	}
>  }
> 

[..]

> @@ -1363,14 +1323,11 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>  {
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> 
> -	mutex_lock(&matrix_dev->lock);
> -	vfio_ap_mdev_unset_kvm(matrix_mdev);
> -	mutex_unlock(&matrix_dev->lock);
> -

.. before access to the matrix_mdev->kvm used to be protected by
the matrix_dev->lock ...

>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>  				 &matrix_mdev->iommu_notifier);
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>  				 &matrix_mdev->group_notifier);
> +	vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);

... but it is not any more. BTW I don't think the code is guaranteed
to fetch ->kvm just once.

Can you please explain why can we get away with being more
lax when dealing with matrix_mdev->kvm?

Regards,
Halil

[..]
