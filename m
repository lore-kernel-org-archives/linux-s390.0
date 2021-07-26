Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6869C4320A
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jul 2021 20:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB87160F94
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jul 2021 20:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhGZT4Z (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:56:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232838AbhGZT4Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Jul 2021 15:56:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QKZdsp139693;
        Mon, 26 Jul 2021 16:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=5S/DkxxWN/Se0LCQVtrLCodyp/iaLv1XjmF0iWwgR6Q=;
 b=U7mwWz378IPUIpjoPMN9FeNY4apn4uhW8dSL84017bFxrSOhn6jvqDEWAfslHBpWbBIy
 2/zLgzJaTu0403i5PI8lYaxWTFkcY5Bst56XTVWL7xfVWGPlLvtFt02/YHEFido8QWCr
 7gwvJuDYMlFmAaCaBnIJINT8kQkm4oioGbLEZYUJ67uduoL5x71FqHQv1daOU/PjwNNd
 uGKAP91Ktp7L50YVRr7H0QnzhNEbRuKu6myAEROZONbjVIgpRVeIfkVodxJb5s+eIroT
 L1WXh0zgTzcVarncYWCz+GKwKrBJPnEln4emaOXe9Ie9Ny5EtPxwRaulqTJLFwUkqu0X 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a243qg7rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 16:36:51 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16QKZgkX142735;
        Mon, 26 Jul 2021 16:36:50 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a243qg7q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 16:36:50 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16QKQHtO019237;
        Mon, 26 Jul 2021 20:36:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3a235kg0hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 20:36:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16QKaiC927132344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 20:36:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0E42AE04D;
        Mon, 26 Jul 2021 20:36:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA840AE045;
        Mon, 26 Jul 2021 20:36:43 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.33.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 26 Jul 2021 20:36:43 +0000 (GMT)
Date:   Mon, 26 Jul 2021 22:36:28 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210726223628.4d7759bf.pasic@linux.ibm.com>
In-Reply-To: <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-3-akrowiak@linux.ibm.com>
        <20210721164550.5402fe1c.pasic@linux.ibm.com>
        <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
        <20210723162625.59cead27.pasic@linux.ibm.com>
        <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sXEccmQp0QKz3IIlfMq4Jm3iVH_NqrT5
X-Proofpoint-GUID: h-QHh2MAVlG8fVylJ9V-tAa7EGgPCb_u
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_14:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107260121
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 23 Jul 2021 17:24:16 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 7/23/21 10:26 AM, Halil Pasic wrote:
> > On Thu, 22 Jul 2021 09:09:26 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> On 7/21/21 10:45 AM, Halil Pasic wrote:  
> >>> On Mon, 19 Jul 2021 15:35:03 -0400
> >>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>     
> >>>> It was pointed out during an unrelated patch review that locks should not  
> >>> [..]
> >>>     
> >>>> -static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
> >>>> +static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev,
> >>>> +				   struct kvm *kvm)
> >>>>    {
> >>>> -	/*
> >>>> -	 * If the KVM pointer is in the process of being set, wait until the
> >>>> -	 * process has completed.
> >>>> -	 */
> >>>> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> >>>> -		       !matrix_mdev->kvm_busy,
> >>>> -		       mutex_unlock(&matrix_dev->lock),
> >>>> -		       mutex_lock(&matrix_dev->lock));
> >>>> -
> >>>> -	if (matrix_mdev->kvm) {  
> >>> We used to check if matrix_mdev->kvm is null, but ...
> >>>     
> >>>> -		matrix_mdev->kvm_busy = true;
> >>>> -		mutex_unlock(&matrix_dev->lock);
> >>>> -
> >>>> -		if (matrix_mdev->kvm->arch.crypto.crycbd) {
> >>>> -			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> >>>> -			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> >>>> -			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> >>>> -
> >>>> -			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> >>>> -		}
> >>>> +	if (kvm->arch.crypto.crycbd) {  
> >>> ... now we just try to dereference it. And ..  
> >> We used to check matrix_mdev->kvm, now the kvm pointer is passed into
> >> the function; however, having said that, the pointer passed in should be
> >> checked before de-referencing it.
> >>  
> >>>     
> >>>> +		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> >>>> +		kvm->arch.crypto.pqap_hook = NULL;
> >>>> +		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> >>>>
> >>>> +		mutex_lock(&kvm->lock);
> >>>>    		mutex_lock(&matrix_dev->lock);
> >>>> +
> >>>> +		kvm_arch_crypto_clear_masks(kvm);
> >>>>    		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> >>>> -		kvm_put_kvm(matrix_mdev->kvm);
> >>>> +		kvm_put_kvm(kvm);
> >>>>    		matrix_mdev->kvm = NULL;
> >>>> -		matrix_mdev->kvm_busy = false;
> >>>> -		wake_up_all(&matrix_mdev->wait_for_kvm);
> >>>> +
> >>>> +		mutex_unlock(&kvm->lock);
> >>>> +		mutex_unlock(&matrix_dev->lock);
> >>>>    	}
> >>>>    }
> >>>>     
> >>> [..]
> >>>     
> >>>> @@ -1363,14 +1323,11 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
> >>>>    {
> >>>>    	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >>>>
> >>>> -	mutex_lock(&matrix_dev->lock);
> >>>> -	vfio_ap_mdev_unset_kvm(matrix_mdev);
> >>>> -	mutex_unlock(&matrix_dev->lock);
> >>>> -  
> >>> .. before access to the matrix_mdev->kvm used to be protected by
> >>> the matrix_dev->lock ...
> >>>     
> >>>>    	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> >>>>    				 &matrix_mdev->iommu_notifier);
> >>>>    	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> >>>>    				 &matrix_mdev->group_notifier);
> >>>> +	vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);  
> >>> ... but it is not any more. BTW I don't think the code is guaranteed
> >>> to fetch ->kvm just once.  
> >> There are a couple of things to point out here:
> >> 1. The vfio_ap_mdev_unset_kvm function() is the only place where the
> >>       matrix_mdev->kvm pointer is cleared. That function is called here
> >>       as well as by the group notifier callback for VFIO_GROUP_NOTIFY_SET_KVM
> >>       events. If you notice in the code above, the group notifier is
> >> unregistered
> >>       before calling the unset function, so either the notifier will have
> >> already
> >>       been invoked and the pointer cleared (which is why you are correct
> >>       that the KVM pointer passed in needs to get checked in the unset
> >> function),
> >>       or will get cleared here.  
> > Hm, vfio_unregister_notifier() indeed seems to guarantee, that by the
> > time it returns no notifer is running. I didn't know that. But this
> > blocking notifier chain uses an rwsem. So mutual exclusion with
> > vfio_ap_mdev_open() is guaranteed, than it is indeed guaranteed. A quick
> > glance at the code didn't tell me if vfio/mdev guarantees that.
> >
> > I mean it would make sense to me to make the init and the cleanup
> > mutually exclusive, but I'm reluctant to just assume it is like that.
> > Can you please point me into the right direction?  
> 
> I'm not quite sure what you're asking for here, but I'll give it a
> shot. The notifier is registered by the vfio_ap_mdev_open()
> callback which is invoked in response to the opening of the mdev fd.

vfio_ap_mdev_open <-vfio_group_get_device_fd

> Since mdev fd can't be closed unless and until it's open,
> there is no way for the vfio_ap_mdev_release() callback, which
> is invoked when the mdev fd is closed, to execute at the same
> time as the vfio_ap_mdev_open callback. 

A plain old file you can open several times over (and thus close
several times over as well). So if you imagine something like:
thread A               thread B
--------               --------
open()
close()                open()
open()                 close()
close()

You may end up with open and close running interleaved. What I'
trying to say is, to my best knowledge, normally there is no
you have to close it before you open it again rule for files.

Does that make sense?

If there is no special mechanism to prevent such a scenario for the
mdev device, I guess, the second open (B) if you like would try to
register a group notifier. I'm not aware of such an mechanism. I 
had a brief look at vfio_group_get_device_fd but couldn't find any
such logic there.

Maybe Connie can actually help us with this one?



> Since the release
> callback unregisters the notifier and both the registration and
> unregistration are done under the same rwsem, I don't see how
> they can be anything but mutually exclusive. Am I missing something
> here?
> 
> >
> >  
> >> 2. The release callback is invoked when the mdev fd is closed by userspace.
> >>       The remove callback is the only place where the matrix_mdev is
> >> freed. The
> >>       remove callback is not called until the mdev fd is released, so it
> >> is guaranteed
> >>       the matrix_mdev will exist when the release callback is invoked.
> >> 3. The matrix_dev->lock is then taken in the vfio_ap_mdev_unset_kvm function
> >>       before doing any operations that modify the matrix_mdev.  
> > Yeah but both the reader, and the writer needs to use the same lock to
> > have the protected by the lock type of situation. That is why I asked
> > about the place where you read matrix_mdev members outside the
> > matrix_dev->lock.  
> 
> With this patch, the matrix_mdev is always written or read with
> the matrix_dev->lock mutex locked.

Sorry I don't understand. How is the struct matrix_mdev.kvm read
with the matrix_dev->lock mutex locked in:

static void vfio_ap_mdev_release(struct mdev_device *mdev)                      
{                                                                               
        struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);            
                                                                                
        vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,             
                                 &matrix_mdev->iommu_notifier);                 
        vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,             
                                 &matrix_mdev->group_notifier);                 
        vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);   <==== HERE!
        module_put(THIS_MODULE);                                                
} 
> By moving the locking of the
> kvm->lock mutex out of the functions that set/clear the masks
> in the guest's CRYCB, we are now able to lock the kvm->lock
> mutex before locking the matrix_dev->lock mutex in both the
> vfio_ap_mdev_set_kvm() and vfio_ap_mdev_unset_kvm()
> functions. This precludes the need to unlock the
> matrix_dev->lock mutex while the masks are being set or
> cleared and alleviates the lockdep splat for which the open coded
> locks were created.


> 
> >
> > Regards,
> > Halil  
> 

