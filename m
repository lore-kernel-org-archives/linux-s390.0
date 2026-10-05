Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC33AFB19;
	Mon,  5 Oct 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237317; cv=none; b=sSSRzl5hQYDIjKm6QnvS1BC/mDVouQy+RfSRwkFsIyDmN1amXClAlS2MrtmjLk61V+U7yyohHrU07jY3NQ4oYUT2w0zGlpnuod4L6H+Rl2WPjhISKx3flkovURMDoLfySonSymnPjTU7leQGY0je9NhtXEX7JoPH9BUhLXGXoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237317; c=relaxed/simple;
	bh=KIuHd3IW+yo0ItNReYL7I4RSdvvYBsUEt8jE70Cop1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgJOQ+6MSO0cBH+O3o17ZRugCb82jPWS+1GweRl5/Vy/NPy6QjasjZX7UkWIt6S3KvhX+LMT8OUbk5JEpHbjggbLeBtQy77Zlm6y6k74aqSudVi+ztTdScWNEPKqKvYsjbxWrCk9V/3thg2jnHcSEwWPuKCO/LdKh9uLP/NqiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DJNB1rGU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DJNB1rGU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZrl81257970;
	Mon, 5 Oct 2026 21:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DUyTjy
	IC90zgl3h8ubutATsKp084cLeuE/tG8+o98ZU=; b=DJNB1rGUfK4Ie2R9RBRWKS
	PBxzy9KcBhM4vxSPdLFjFqAbgSkCBxsluompkpFN48RGWQiD6eBHnry8puITCnbw
	kEtR1oOkdbNxhvVW+c0ab5kQzHWgWWqj9xEzEfDtQ8o0QeU5E70LFN0zmlmu9dtU
	vdeVFa18qfgADpCeK0PoRBnUNnOonUUx0TtA14bfhyuMjvuaYBNgVRDVysJHvDwi
	jyiUnjqoh6pk+OixlQcpd1SxncV+Pya752f1Oo/uM4kFW52JW1oz+lxvcGSS2U1t
	/AZxtLW4WqfuzIe72iBHk9Qcg+J9aa6Zq4byECX2p5VD68oOgv0L/DoyBvzUZKTA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5cmvj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 21:55:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695HMbx83252062;
	Mon, 5 Oct 2026 21:55:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy72wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 21:55:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695Lt7KN20906532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 21:55:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 961C958054;
	Mon,  5 Oct 2026 21:55:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 080A25805A;
	Mon,  5 Oct 2026 21:55:06 +0000 (GMT)
Received: from [9.61.34.243] (unknown [9.61.34.243])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 21:55:05 +0000 (GMT)
Message-ID: <238c3e40-13db-492b-9ed5-517f321ce8b7@linux.ibm.com>
Date: Mon, 5 Oct 2026 17:55:05 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-8-akrowiak@linux.ibm.com>
 <9c69c913-49aa-4934-b46a-1ebddd425f76@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <9c69c913-49aa-4934-b46a-1ebddd425f76@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfXw3niMX/xt6ZY
 /8RvNgn8Bt0V6rLB/t+7N/5+SP/blqnLRy4O54VGD1h4sBi/jVxVjcM0pcFAiTNQSGTGmx9OTHs
 7f4Qb4EYzYS9VV2qJm9l2o4MC8z+H+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfX3w/OpZSBpw21
 cCiT+BVBhM8yPvLNj2JNGiByB8RLV+sMfzSphazEUJ2H1P5j/wZw2vnoK1bykx9AMSMEMhmR2DS
 eKLwK93jW2bGRu09l+QzKHtEKmISuyNwg7qO/PVMFJO5Lvfv8YYXfYtwXO6vUWnzX1yohmj005q
 bYCPQuKWl8xeF4/RnC9DRZVcXHeStODcNiZ17txrySbrWpfKtJ97R5AWF/ff5WYc59iUxf+BgCm
 NH5dcDmWq+vsKgNzY3v8J3Bvr9g0fHroY+ElJMMqn/iJ52GIcTRkZSbZDcfCTg87g3Qgrck1PRC
 GgefhUtLBxd6kSRHfPJTdS0FB93zwlIaVmyKeyePnbfmObTSnmDgIdgDJOtKB4xFe+uaHw/Q1Vd
 tnfCXZpLbVAF7+HeJJmy3kTJe6MQtRDBnxGIEMhSUr6mmNolZ4h51IKxltCf6lT6wIUfTwaP7nE
 XenicV9afubJ8PVJHkw==
X-Proofpoint-GUID: BFbOJqsDbk1qMRgLqPw3G-rsRRJhT73o
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac41cbd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xHGZ6dfit4Jw-R03iOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BFbOJqsDbk1qMRgLqPw3G-rsRRJhT73o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050085



On 8/13/26 11:08 AM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Implements the read callback function that was added to the
>> file_operations structure for the file created to save the state of the
>> vfio-ap device when the migration state transitioned from STOP to
>> to the STOP_COPY state.
>>
>> This function copies the guest's AP configuration information to
>> userspace. The information copied is comprised of the APQN of each queue
>> device passed through to the guest along with its hardware information.
>> This state data will be transferred to the vfio_ap device driver on the
>> destination host when the state is transitioned to RESUMING.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_migration.c | 287 +++++++++++++++++++++++-
>>   1 file changed, 277 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> index de693b308925..50781b61f7f1 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -117,9 +117,10 @@ struct vfio_ap_config {
>>   static void
>>   vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data 
>> *mig_data)
>>   {
>> -    /* Stub to be implemented when the 
>> mig_data->stop_copy_mig_file.ap_config
>> -     * object is allocated.
>> -     */
>> +    kvfree(mig_data->stop_copy_mig_file.ap_config);
>> +    mig_data->stop_copy_mig_file.ap_config = NULL;
>> +    mig_data->stop_copy_mig_file.config_sz = 0;
>> +    mig_data->stop_copy_mig_file.filp = NULL;
>>   }
>>     static void vfio_ap_release_resuming_file(struct 
>> vfio_ap_migration_data *mig_data)
>> @@ -129,13 +130,6 @@ static void vfio_ap_release_resuming_file(struct 
>> vfio_ap_migration_data *mig_dat
>>        */
>>   }
>>   -static ssize_t
>> -vfio_ap_stop_copy_read(struct file *, char __user *, size_t, loff_t *)
>> -{
>> -    /* TODO */
>> -    return -EOPNOTSUPP;
>> -}
>> -
>>   static int vfio_ap_release_mig_file(struct inode *file_inode, 
>> struct file *filp)
>>   {
>>       struct ap_matrix_mdev *matrix_mdev = filp->private_data;
>> @@ -150,6 +144,279 @@ static int vfio_ap_release_mig_file(struct 
>> inode *file_inode, struct file *filp)
>>       return 0;
>>   }
>>   +/**
>> + * validate_stop_copy_read_parms: Validate the input parameters to the
>> + *                                vfio_ap_stop_copy_read function
>> + *
>> + * @matrix_mdev: The object device containing the state to be read
>> + * @filp: Pointer to the file stream used to read the vfio-ap device 
>> state
>> + * @pos:  The file offset from which to start reading data
>> + * @len:  The length of the data to be read
>> + *
>> + * Verify the following:
>> + * - @filp private data is an ap_matrix_mdev instance
>> + * - @filp is the instance opened when state transitioned from STOP 
>> to STOP_COPY
>> + * - @pos + @len does not cause integer overflow
>> + *
>> + * Returns: 0 if the parameters pass validation; otherwise returns 
>> an error
>> + */
>> +static int validate_stop_copy_read_parms(struct file *filp, loff_t 
>> *pos,
>> +                     size_t len)
>> +{
>> +    struct vfio_ap_migration_data *mig_data;
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +    loff_t total_len;
>> +
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +    if (check_add_overflow((loff_t)len, *pos, &total_len))
>> +        return -EIO;
>> +
>> +    /*
>> +     * matrix_mdev is guaranteed live here: 
>> vfio_ap_open_file_stream() took
>> +     * a vfio_device registration reference that is held until
>> +     * vfio_ap_release_mig_file() runs, so the embedding matrix_mdev 
>> cannot
>> +     * be freed while this file descriptor is open.
>> +     */
>> +    matrix_mdev = filp->private_data;
>> +
>> +    if (!matrix_mdev->mig_data)
>> +        return -ENODEV;
>> +
>> +    mig_data = matrix_mdev->mig_data;
>> +
>> +    if (mig_data->stop_copy_mig_file.filp != filp)
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>> +static size_t vfio_ap_config_size(struct ap_matrix_mdev *matrix_mdev,
>> +                  int *num_queues)
>> +{
>> +    size_t qinfo_size;
>> +
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +    *num_queues = 
>> vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
>> +    qinfo_size = *num_queues * sizeof(struct vfio_ap_queue_info);
>> +
>> +    return qinfo_size + sizeof(struct vfio_ap_config);
>> +}
>> +
>> +static int get_hardware_info_for_queue(const char *mdev_name,
>> +                       struct ap_tapq_hwinfo *hwinfo,
>> +                       unsigned long apqn)
>> +{
>> +    struct ap_queue_status status;
>> +
>> +    status = ap_tapq(apqn, hwinfo);
>> +
>> +    switch (status.response_code) {
>> +    case AP_RESPONSE_NORMAL:
>> +    case AP_RESPONSE_RESET_IN_PROGRESS:
>> +    case AP_RESPONSE_DECONFIGURED:
>> +    case AP_RESPONSE_CHECKSTOPPED:
>> +    case AP_RESPONSE_BUSY:
>> +        /* For all these RCs the tapq info should be available */
>> +        return 0;
>> +    case AP_RESPONSE_Q_NOT_AVAIL:
>> +        pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo 
>> for queue %02lx.%04lx: TAPQ rc=%d",
>> +                   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
>> +                   status.response_code);
>> +        return -ENODEV;
>> +    default:
>> +        /*
>> +         * Without a pending async error, the tapq info should be
>> +         * available
>> +         */
>> +        if (status.async)
>> +            return 0;
>> +
>> +        pr_err_ratelimited("vfio_ap_mdev %s:Failed to get hwinfo for 
>> queue %02lx.%04lx: TAPQ rc=%d",
>> +                   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
>> +                   status.response_code);
>> +        return -EIO;
>> +    }
>> +}
>> +
>> +/**
>> + * vfio_ap_store_queue_info:
>> + *
>> + * Stores the hardware information returned from the PQAP(TAPQ) 
>> command for each
>> + * queue device identified in the 'qinfo' field of the a vfio_ap_config
>> + * object. If there are a large number of queues for which hardware 
>> information
>> + * must be retrieved, this function must be called without the 
>> mdevs_lock
>> + * held. This should not be a problem since the APQNs in the 'qinfo' 
>> field
>> + * should already have been snapshotted prior to calling this function.
>
> This warning message is ambiguous. What does large mean? What are the 
> consequences of holding the lock during a long call? And, "This should 
> not be a problem..." this whole thing seems to contradict the warning 
> entirely. Can you clarify the situation? :)

This is one of those issues reported by Sashiko. The problem here is 
that mdevs_lock prevents
access to every mdev under the control of the vfio_ap device driver. 
This means that nothing
can be done via the sysfs interfaces - i.e., assigning/unassinging 
adapters, domains and control
domains which also prevents hot plug of those devices - for as long as 
the mutex lock is held.
It also prevents starting any guests to which the mdev supplies an AP 
configuration or any
communication between userspace and the vfio_ap driver that is 
associated with an mdev.

Of course, what large means is dependent upon how long it takes to 
execute a TAPQ for
a queue device. The system wide limits for CEX8 cards are up to 60 
adapters and 85 domains
for a total of 5100 queues. This is probably highly unlikely since each 
card has a maximum of
2 adapters and 16 domains and the total is divided up between the LPARs. 
I've just convinced
myself that dropping the lock here is probably unnecessary. I should 
have looked deeper
into it rather than relying on AI. I think the lock drop creates a 
window where the snapshotted
APQN list can become stale, so I think I'm going to remove it.

I think the answer to all of these performance issues created by a 
global mdevs lock can
probably be resolved by redesigning the locking mechanism and maybe 
creating a
lock per mdev. That is a major design change which is for another day.

>
>> + *
>> + * @mdev_name:    The name (UUID) of the mediated device to use in 
>> log messages
>> + * @ap_config:    A reference to the vfio_ap_config instance in 
>> which to store
>> + *        the queue information. It is expected that each APQN 
>> identifying
>> + *        a queue device for which hardware information is to be 
>> retrieved
>> + *        shall be snapshotted prior to calling this function.
>> + *
>> + * Returns:    Zero (0) if the hardware information is retrieved for 
>> each queue
>> + *        device in the AP configuration; otherwise, returns an error.
>> + */
>> +static int vfio_ap_store_queue_info(const char *mdev_name,
>> +                    struct vfio_ap_config *ap_config)
>> +{
>> +    struct ap_tapq_hwinfo source_hwinfo;
>> +    unsigned long num_queues;
>> +    int ret;
>> +
>> +    for (num_queues = 0; num_queues < ap_config->num_queues; 
>> num_queues++) {
>> +        ret = get_hardware_info_for_queue(mdev_name, &source_hwinfo,
>> + ap_config->qinfo[num_queues].apqn);
>> +        if (ret)
>> +            return ret;
>> +
>> +        ap_config->qinfo[num_queues].data = source_hwinfo.value;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    struct vfio_ap_config *ap_configuration;
>> +    unsigned long *apm, *aqm, apid, apqi;
>> +    const char *mdev_name;
>> +    size_t ap_config_size;
>> +    int ret, num_queues;
>> +
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +    ap_config_size = vfio_ap_config_size(matrix_mdev, (int 
>> *)&num_queues);
>> +
>> +    ap_configuration = kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
>> +    if (!ap_configuration)
>> +        return -ENOMEM;
>> +
>> +    ap_configuration->magic   = VFIO_AP_MIG_MAGIC;
>> +    ap_configuration->version = VFIO_AP_MIG_VERSION;
>> +
>> +    /*
>> +     * num_queues must be set before writing qinfo[] elements; the
>> +     * __counted_by(num_queues) annotation on qinfo[] causes the 
>> compiler to
>> +     * insert bounds checks that evaluate against 
>> ap_configuration->num_queues.
>> +     * Writing through qinfo[i] with num_queues still 0 would trap.
>> +     */
>> +    ap_configuration->num_queues = num_queues;
>> +
>> +    apm = matrix_mdev->shadow_apcb.apm;
>> +    aqm = matrix_mdev->shadow_apcb.aqm;
>> +    num_queues = 0;
>> +    for_each_set_bit_inv(apid, apm, AP_DEVICES) {
>> +        for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
>> +            ap_configuration->qinfo[num_queues].apqn =
>> +                AP_MKQID(apid, apqi);
>> +            num_queues += 1;
>> +        }
>> +    }
>> +    memcpy(ap_configuration->adm, matrix_mdev->shadow_apcb.adm,
>> +           sizeof(ap_configuration->adm));
>> +    mdev_name = dev_name(matrix_mdev->vdev.dev);
>> +
>> +    /*
>> +     * Unlock the mdevs_lock so other mdevs are not precluded from 
>> being
>> +     * accessed while a potentially long running operation is 
>> performed.
>> +     */
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +    ret = vfio_ap_store_queue_info(mdev_name, ap_configuration);
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>
> I'm confused by the locking strategy here. Why is it okay to release 
> the lock, do stuff, then reacquire the lock? If that's okay, why do we 
> need the lock at all? What changes are we protecting against? And can 
> those changes land when we relase the lock to call 
> vfio_ap_store_queue_info()?

See my comment above.

>
>> +    if (ret) {
>> +        kvfree(ap_configuration);
>> +        return ret;
>> +    }
>> +
>> +    if (!matrix_mdev->mig_data) {
>> +        kvfree(ap_configuration);
>> +        return -ENODEV;
>> +    }
>> +
>> +    matrix_mdev->mig_data->stop_copy_mig_file.ap_config = 
>> ap_configuration;
>> +    matrix_mdev->mig_data->stop_copy_mig_file.config_sz = 
>> ap_config_size;
>> +
>> +    return 0;
>> +}
>> +
>> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user 
>> *buf,
>> +                      size_t len, loff_t *pos)
>> +{
>> +    struct vfio_ap_migration_file *mig_file;
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +    loff_t read_pos;
>> +    ssize_t ret;
>> +
>> +    /*
>> +     * This file was opened with stream_open(), so pos should be 
>> NULL for
>> +     * sequential read() calls; a non-NULL pointer will be passed only
>> +     * for positional pread() calls in which case we return an error
>> +     * indicating broken pipe/illegal seek on a non-seekable file
>> +     */
>> +    if (pos)
>> +        return -ESPIPE;
>> +
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>> +
>> +    pos = &filp->f_pos;
>> +
>> +    ret = validate_stop_copy_read_parms(filp, pos, len);
>
> Why pass pos here? Can't validate_stop_copy_read_parms() just read it 
> from fipl->f_pos?

I suppose we can. I'll have to change validate_stop_copy_read_parms() too.


>
>> +    if (ret) {
>> +        mutex_unlock(&matrix_dev->mdevs_lock);
>> +        return ret;
>> +    }
>> +
>> +    matrix_mdev = filp->private_data;
>> +    mig_file = &matrix_mdev->mig_data->stop_copy_mig_file;
>> +
>> +    if (!mig_file->ap_config) {
>> +        ret = vfio_ap_get_config(matrix_mdev);
>> +        if (ret) {
>> +            mutex_unlock(&matrix_dev->mdevs_lock);
>> +            return ret;
>> +        }
>> +    }
>
> What's the point of this block? Under what circumstances can we get 
> here not having set mig_file->ap_config?

I'm using lazy intialization here:
* vfio_ap_open_file_stream() initializes mig_file->ap_config = NULL
   and config_sz = 0
* vfio_ap_get_config() allocates the config, fills it, and stores it in
   mig_file->ap_config along with config_sz on the first call to
   vfio_ap_stop_copy_read().
* The stream_open() file position (filp->f_pos) tracks read offset across
   calls and the config is freed in vfio_ap_release_stop_copy_file()

I'm going to put a doc block in to explain that

>
>
>> +
>> +    /*
>> +     * Compute the offset and clamped length fully under the lock so 
>> that
>> +     * concurrent read()s on this stream file each see a consistent 
>> view of
>> +     * the current position.  *pos is advanced here while we still 
>> hold the
>> +     * lock; copy_to_user() then uses the snapshot read_pos. This 
>> prevents
>> +     * two threads from calculating the same offset and both copying 
>> the
>> +     * same region (or one reading past the end of the buffer).
>> +     */
>> +    if (*pos >= mig_file->config_sz) {
>> +        mutex_unlock(&matrix_dev->mdevs_lock);
>> +        return 0;
>> +    }
>> +
>> +    len = min_t(size_t, mig_file->config_sz - *pos, len);
>> +    if (len == 0) {
>> +        mutex_unlock(&matrix_dev->mdevs_lock);
>> +        return 0;
>> +    }
>> +
>> +    read_pos = *pos;
>> +    *pos += len;
>> +
>> +    /*
>> +     * Drop the lock only for the copy_to_user().  The ap_config 
>> buffer is
>> +     * stable: it is allocated once in vfio_ap_get_config() and 
>> freed only
>> +     * in vfio_ap_release_stop_copy_file() which requires mdevs_lock.
>> +     * Since we already advanced *pos above, no other thread will 
>> compute an
>> +     * overlapping region.
>> +     */
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +    if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
>> +        return -EFAULT;
>> +
>> +    return len;
>> +}
>> +
>>   static const struct file_operations vfio_ap_stop_copy_fops = {
>>       .owner = THIS_MODULE,
>>       .read = vfio_ap_stop_copy_read,
>

