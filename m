Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95778C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 14:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0D60EB1
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 14:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhGWNqI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:46:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233666AbhGWNqH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Jul 2021 09:46:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NEKTEe191630;
        Fri, 23 Jul 2021 10:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3Spo8q7XmHT8k9bDd30RKxErqWuR5QT5w15Nadhhdj8=;
 b=K+d3wRkZj6r4jc2Vw9/VHWPVnAq7dtlsRMmyYxywzW12l7rCUrSkz7TVAAuIg9rO0eN4
 B/ZvlusM5aF9XaYx5ISPumjKpykfngfiCEk/xm3JUX4ytwLB8dbISr+ofzjCa41XqfgL
 lv4NuZPSmTuqnEisitQp/VQKl/0/WeeOf4dJHzhP/Pts4+7OlXnKUnIhmqId+VmGNW8F
 RrDkd7WJlFXp8pFmk1dQkP633ahgahqWIfUvSPqjSWSxV9Z2qgsG09+ZJ3SZvjIkWzVf
 gMKNIAB302gGg6vRjngeRUXDeQJGVIEUPv++S6C6QR9J9UPqf35y3vKdoI+/e0T6JLeE Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yyetr3xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 10:26:39 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16NEKikE193061;
        Fri, 23 Jul 2021 10:26:39 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yyetr3wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 10:26:38 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NEKlPS015763;
        Fri, 23 Jul 2021 14:26:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 39upu89w7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 14:26:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16NEQXYJ26345854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 14:26:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20AA9AE055;
        Fri, 23 Jul 2021 14:26:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2972CAE04D;
        Fri, 23 Jul 2021 14:26:32 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.6.217])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 23 Jul 2021 14:26:32 +0000 (GMT)
Date:   Fri, 23 Jul 2021 16:26:25 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210723162625.59cead27.pasic@linux.ibm.com>
In-Reply-To: <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-3-akrowiak@linux.ibm.com>
        <20210721164550.5402fe1c.pasic@linux.ibm.com>
        <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m4ymPi2y4JFMoQVTobtmf4UV69Szicgs
X-Proofpoint-ORIG-GUID: olJ_G38DjWZtccgGW2vk6j5N1c0FGCMT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_08:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230083
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 22 Jul 2021 09:09:26 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 7/21/21 10:45 AM, Halil Pasic wrote:
> > On Mon, 19 Jul 2021 15:35:03 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> It was pointed out during an unrelated patch review that locks should not  
> > [..]
> >  
> >> -static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
> >> +static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev,
> >> +				   struct kvm *kvm)
> >>   {
> >> -	/*
> >> -	 * If the KVM pointer is in the process of being set, wait until the
> >> -	 * process has completed.
> >> -	 */
> >> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> >> -		       !matrix_mdev->kvm_busy,
> >> -		       mutex_unlock(&matrix_dev->lock),
> >> -		       mutex_lock(&matrix_dev->lock));
> >> -
> >> -	if (matrix_mdev->kvm) {  
> > We used to check if matrix_mdev->kvm is null, but ...
> >  
> >> -		matrix_mdev->kvm_busy = true;
> >> -		mutex_unlock(&matrix_dev->lock);
> >> -
> >> -		if (matrix_mdev->kvm->arch.crypto.crycbd) {
> >> -			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> >> -			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> >> -			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> >> -
> >> -			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> >> -		}
> >> +	if (kvm->arch.crypto.crycbd) {  
> > ... now we just try to dereference it. And ..  
> 
> We used to check matrix_mdev->kvm, now the kvm pointer is passed into
> the function; however, having said that, the pointer passed in should be
> checked before de-referencing it.
> 
> >  
> >> +		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> >> +		kvm->arch.crypto.pqap_hook = NULL;
> >> +		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> >>
> >> +		mutex_lock(&kvm->lock);
> >>   		mutex_lock(&matrix_dev->lock);
> >> +
> >> +		kvm_arch_crypto_clear_masks(kvm);
> >>   		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> >> -		kvm_put_kvm(matrix_mdev->kvm);
> >> +		kvm_put_kvm(kvm);
> >>   		matrix_mdev->kvm = NULL;
> >> -		matrix_mdev->kvm_busy = false;
> >> -		wake_up_all(&matrix_mdev->wait_for_kvm);
> >> +
> >> +		mutex_unlock(&kvm->lock);
> >> +		mutex_unlock(&matrix_dev->lock);
> >>   	}
> >>   }
> >>  
> > [..]
> >  
> >> @@ -1363,14 +1323,11 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
> >>   {
> >>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >>
> >> -	mutex_lock(&matrix_dev->lock);
> >> -	vfio_ap_mdev_unset_kvm(matrix_mdev);
> >> -	mutex_unlock(&matrix_dev->lock);
> >> -  
> > .. before access to the matrix_mdev->kvm used to be protected by
> > the matrix_dev->lock ...
> >  
> >>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> >>   				 &matrix_mdev->iommu_notifier);
> >>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> >>   				 &matrix_mdev->group_notifier);
> >> +	vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);  
> > ... but it is not any more. BTW I don't think the code is guaranteed
> > to fetch ->kvm just once.  
> 
> There are a couple of things to point out here:
> 1. The vfio_ap_mdev_unset_kvm function() is the only place where the
>      matrix_mdev->kvm pointer is cleared. That function is called here
>      as well as by the group notifier callback for VFIO_GROUP_NOTIFY_SET_KVM
>      events. If you notice in the code above, the group notifier is 
> unregistered
>      before calling the unset function, so either the notifier will have 
> already
>      been invoked and the pointer cleared (which is why you are correct
>      that the KVM pointer passed in needs to get checked in the unset 
> function),
>      or will get cleared here.

Hm, vfio_unregister_notifier() indeed seems to guarantee, that by the
time it returns no notifer is running. I didn't know that. But this
blocking notifier chain uses an rwsem. So mutual exclusion with
vfio_ap_mdev_open() is guaranteed, than it is indeed guaranteed. A quick
glance at the code didn't tell me if vfio/mdev guarantees that. 

I mean it would make sense to me to make the init and the cleanup
mutually exclusive, but I'm reluctant to just assume it is like that.
Can you please point me into the right direction?


> 2. The release callback is invoked when the mdev fd is closed by userspace.
>      The remove callback is the only place where the matrix_mdev is 
> freed. The
>      remove callback is not called until the mdev fd is released, so it 
> is guaranteed
>      the matrix_mdev will exist when the release callback is invoked.
> 3. The matrix_dev->lock is then taken in the vfio_ap_mdev_unset_kvm function
>      before doing any operations that modify the matrix_mdev.

Yeah but both the reader, and the writer needs to use the same lock to
have the protected by the lock type of situation. That is why I asked
about the place where you read matrix_mdev members outside the
matrix_dev->lock.

Regards,
Halil
