Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817AC47082
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 02:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A60D61073
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 02:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhE0CaJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 May 2021 22:30:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231470AbhE0CaI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 May 2021 22:30:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R23rJL102151;
        Wed, 26 May 2021 22:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=y7bzL7BMsT3qu2VF6L1QOQTMiE9/AntLENcNdN3Sd6Q=;
 b=D7oixYWo2yB6vDKVtB/B/Dc8uE6zrR84s6RFZHwZBlw95q2y2w3RoVVKYaP5trsnqIPi
 tvzbkkLNKU0CElkvylugbmRwVkVDYkRljW8gj+ul4t8bF4lbXIOM1AkKYBvdaBBJpbO2
 +iDi/B430QgSMJyn9wYxgEv4JHl2PIQTz/807Eh/9nQH8K0GfBSElmnStBHGNPQANzST
 feHQ7vYFIsvjP4FIcZ2RNtaM1cq9sOQPx5LG2TPoKUoxvwQcO69eml6SrmtuzqcgqzGB
 pJg8l9sJENvH+BYRHoFjyk9CAfy5eJE/c3X3Hh/3o3sVd6zzVAy/7KWd6NqRkqSVOC6p gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38t0r6jagh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 22:28:34 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14R24rCB105436;
        Wed, 26 May 2021 22:28:33 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38t0r6jag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 22:28:33 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14R2I2uI026825;
        Thu, 27 May 2021 02:28:32 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 38s1q6w8tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 02:28:32 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14R2SUKZ24117646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 02:28:31 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E2713604F;
        Thu, 27 May 2021 02:28:30 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B320D136051;
        Thu, 27 May 2021 02:28:29 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 May 2021 02:28:29 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
 <20210525131912.GW1002214@nvidia.com>
 <c54ef522-f348-df16-a99f-1e31feb1b0bd@linux.ibm.com>
 <20210525162927.GC1002214@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <966142da-779f-d604-c6f6-e58cec128e5d@linux.ibm.com>
Date:   Wed, 26 May 2021 22:28:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525162927.GC1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XKLSOes9hCG5tvYX0vaTGrajp5zgkBUO
X-Proofpoint-ORIG-GUID: hIvO8VP7_i-fgLmoQKzSSMM5wLdbstiT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_13:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270012
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/25/21 12:29 PM, Jason Gunthorpe wrote:
> On Tue, May 25, 2021 at 11:56:50AM -0400, Tony Krowiak wrote:
>
>> The vfio_ap_mdev_unset_kvm() function, however, is called both by
>> the group notifier when the KVM pointer has been cleared or when the
>> mdev is being removed. In both cases, the only way to get the KVM
>> pointer - which is needed to unplug the AP resources from the guest
>> - is from the matrix_mdev which contains it.
> Okay, but that isn't a problem, the matrix dev holds a ref on the kvm
> pointer so we can just copy it outside the lock after we prevent it
> from changing by unregistering the notifier:
>
> @@ -1362,14 +1365,19 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   {
>          struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
> -       mutex_lock(&matrix_dev->lock);
> -       vfio_ap_mdev_unset_kvm(matrix_mdev);
> -       mutex_unlock(&matrix_dev->lock);
> -
>          vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>                                   &matrix_mdev->iommu_notifier);
>          vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>                                   &matrix_mdev->group_notifier);
> +
> +       mutex_lock(&matrix_dev->lock);
> +       /* matrix_dev->kvm cannot be changed now since we removed the notifiers */
> +       kvm = matrix_mdev->kvm;
> +       matrix_mdev->kvm = NULL;
> +       mutex_unlock(&matrix_dev->lock);
> +
> +       vfio_ap_mdev_unset_kvm(matrix_mdev, kvm);
> +
>          module_put(THIS_MODULE);
>
> Note the above misordering is an existing bug too
>
> And reoganize unset_kvm so it uses internal locking and gets the kvm
> from the argument.

As I told you in a previous email, this is not a trivial exercise.
If you take a look at the vfio_ap_mdev_unset_kvm()
function, you will notice that it invokes the vfio_ap_mdev_reset_queues()
function to reset the queues after taking them away from the
guest. As each queue is reset, the resources required for
processing interrupts for the queue are freed in the
vfio_ap_free_aqic_resources() function. In order to unregister the
the guest's ISC, the matrix_mdev->kvm pointer must still
be set, however, you cleared it above.

Another thing you're overlooking is the fact that all of the
assignment/unassignment functions associated with the
corresponding syfs attributes of the mdev change the
content of the matrix_mdev->matrix and
matrix_mdev->shadow_apcb structures. In particular,
the matrix_mdev->matrix contains the APQNs of the
queues that must be reset. These sysfs attributes can
be accessed at any time including when the
vfio_ap_mdev_unset_kvm() function is executing,
so that is something that must also be taken into
consideration.


>
> Also the kvm_busy should be replaced by a proper rwsem, don't try to
> open code locks like that - it just defeats lockdep analysis.

I've had no luck trying to refactor this using rwsem. I always
run into lockdep problems between the matrix_dev->lock
and matrix_mdev->rwsem, even if the locking order is maintained.
Clearly, I am lacking in understanding of how these locks
interact. Any clues here?

> Finally, since the only way the ->kvm can be become non-NULL is if the
> notifier is registered, release above removes the notifier, and remove
> can't be called unless release has been completed, it looks to me like
> this the remove check is just dead code, delete it, or leave it as a
> WARN_ON:
>
> @@ -366,16 +366,6 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>          struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>
>          mutex_lock(&matrix_dev->lock);
> -
> -       /*
> -        * If the KVM pointer is in flux or the guest is running, disallow
> -        * un-assignment of control domain.
> -        */
> -       if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> -               mutex_unlock(&matrix_dev->lock);
> -               return -EBUSY;
> -       }
>
> Jason

