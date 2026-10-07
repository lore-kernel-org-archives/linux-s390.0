Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506C4A49A0;
	Wed,  7 Oct 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380830; cv=none; b=samNg8kj3tt59G8FqO1nItYaddKGK3hgjH8lvSfW1l47xeALN2wHJlxp0W2BNPtdCdiIOMjOb/3Z0Ezr9mba9x9z7L/IMyzIiK1kI2hy/Y3aesKddsEjL9HXfl/kvVwn0uTBjDmvHLCTeBsMcnMgitnsTtt7/IqeR7GikA4D3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380830; c=relaxed/simple;
	bh=PQFrcBK6cSeGCoHWmdQBaK/1RY7/BQ5WOAVXQaHm4u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pp2pH7WoYXw2yWA8QFe//8U/ctslxvRA+X8JD9WYGTzPN366Vstqsno1DTtMiyg5Jo+5F0pwR8PpdOTIErdPQ7lahxpEXq7J69n1+e+JgWnDjVE69K9pnUPc24C4TY4XyrhVF4yL90RA053PF+UXHQxTXrMhKS1gnVpjsgGpJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k/zL54vv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k/zL54vv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZg7K2259691;
	Wed, 7 Oct 2026 13:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wGuJJ7
	OApX8tP5m+rHzXmcs8qWffH++vdr/aAs+xsss=; b=k/zL54vvEuYj7y8O78b2R4
	UjY1Nv+CFI7zJs9FzX2tObFEq+cwsrK39JxTZXceckjjc2hKSUsFbuC0LnbojJbg
	Lno+/GqlolrVn3wkAXkhbDU4tvbB9Mms5+gfasBW8aHuDZkRqdTZSlPrOl3ipG8u
	RZSgnl3EytE1xhyR1v5dAJ4jvUa6RTJ7XuMUuAaTgBVNYcp6xs4aS+DNfBjDN5YQ
	deTUCf99oHN09yxrTpP0q9cEKHIXwTiSJDyrq/Oh1xUVaWS5x5yDM+teM7HkO/3j
	gGIroXxyWCpG5bQAgU+7+9cLQqG1z5GW8SC0GzmxJQxsn6QAYTff0S3smKJAr73Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jw5uk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:46:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BldAa1808483;
	Wed, 7 Oct 2026 13:46:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxw7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:46:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697DkqDG63701452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 13:46:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 377AD5804B;
	Wed,  7 Oct 2026 13:46:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8760658059;
	Wed,  7 Oct 2026 13:46:50 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 13:46:50 +0000 (GMT)
Message-ID: <131b8ee6-63b2-4f98-bad1-3697d9b6bc70@linux.ibm.com>
Date: Wed, 7 Oct 2026 09:46:50 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-10-akrowiak@linux.ibm.com>
 <cafcf3e4-4e67-483a-9516-4531266958c3@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <cafcf3e4-4e67-483a-9516-4531266958c3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hvIRp_x-ebnRmkq4_pGgDP5TsIwll_wC
X-Proofpoint-GUID: hvIRp_x-ebnRmkq4_pGgDP5TsIwll_wC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX3gTGmZnWw+2p
 GvXWHu2A2Qvf5HkDBnVRLGTjZTUODKY7hG3P7Yi2jMm61RUUOhgnOJlfuNdes1GHTQuIKA+YtXL
 HkXnZqMKsqlUYP0dsEwyI4l0Q/L8llU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX6Ww6nXAfxs9c
 mucEJULqXbHX6s5mQRhDOagxnGkqQwy6FZKd4WQEz7JKEkZJ0EoIRCfz8ZsqNEliXAHn5gUDPQg
 Qcc9fnyn0z2M2ZH8+qHLGKQXVYjiEO45GylAW+fpHjqSZcnROPIWCojsAW1cUVYps9bmcglFirg
 I7Pn2YffbTXy8MukXiI5KxYYaCty9Qb35WPvcegB3sLrUPSpbX4IWhqAZDSRsiqVEEnoWmj8MYL
 hpukcN9tecGf5FD6MyiPAznXKqMPpA9HTeXpLdQWjoE3ycAR1fvTjrSsh3Q6zA5VDji0tSvPlBm
 5jO7hB3n8KWxGzNrdzfbA2AfSvVhL5OZtvspgUoKeLrPWsiiFEhiOkONBLYXiI83TOqd5haUh3j
 /b2UTCrbkRE0g/J7JIdVFDZUmU7jIlLMbBbAO9R68EypgMqyF+OcgS+tnnmBI2X9sMT0YsoWJx4
 JaE2ZxahE341n6QkqPA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac64d4d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=7yNgoilTr2P9NN8D:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=SoNj4qaQepImSX9q2_QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070054



On 8/19/26 9:25 AM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Adds a new vfio_ap_set_new_config function to set a guest's AP
>> configuration. This is needed in order to set the state of the mdev when
>> it is migrated from a remote host system during the RESUMING phase.
>>
>> Key changes:
>> * Refactored code from the ap_config_store function - handles changes to
>>    the sysfs ap_config attribute - into a new, non-static function which
>>    is callable from the ap_config_store function as well as the live 
>> guest
>>    migration code.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 221 ++++++++++++++------------
>>   drivers/s390/crypto/vfio_ap_private.h |  61 +++++++
>>   2 files changed, 184 insertions(+), 98 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index d05372b50d2f..0f33f5189153 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -81,53 +81,6 @@ static inline void 
>> release_update_locks_for_kvm(struct kvm *kvm)
>>       mutex_unlock(&matrix_dev->guests_lock);
>>   }
>>   -/**
>> - * get_update_locks_for_mdev: Acquire the locks required to 
>> dynamically update a
>> - *                  KVM guest's APCB in the proper order.
>> - *
>> - * @matrix_mdev: a pointer to a struct ap_matrix_mdev object 
>> containing the AP
>> - *         configuration data to use to update a KVM guest's APCB.
>> - *
>> - * The proper locking order is:
>> - * 1. matrix_dev->guests_lock: required to use the KVM pointer to 
>> update a KVM
>> - *                   guest's APCB.
>> - * 2. matrix_mdev->kvm->lock:  required to update a guest's APCB
>> - * 3. matrix_dev->mdevs_lock:  required to access data stored in a 
>> matrix_mdev
>> - *
>> - * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, 
>> the KVM
>> - *     lock will not be taken.
>> - */
>> -static inline void get_update_locks_for_mdev(struct ap_matrix_mdev 
>> *matrix_mdev)
>> -{
>> -    mutex_lock(&matrix_dev->guests_lock);
>> -    if (matrix_mdev && matrix_mdev->kvm)
>> -        mutex_lock(&matrix_mdev->kvm->lock);
>> -    mutex_lock(&matrix_dev->mdevs_lock);
>> -}
>> -
>> -/**
>> - * release_update_locks_for_mdev: Release the locks used to 
>> dynamically update a
>> - *                  KVM guest's APCB in the proper order.
>> - *
>> - * @matrix_mdev: a pointer to a struct ap_matrix_mdev object 
>> containing the AP
>> - *         configuration data to use to update a KVM guest's APCB.
>> - *
>> - * The proper unlocking order is:
>> - * 1. matrix_dev->mdevs_lock
>> - * 2. matrix_mdev->kvm->lock
>> - * 3. matrix_dev->guests_lock
>> - *
>> - * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, 
>> the KVM
>> - *     lock will not be released.
>> - */
>> -static inline void release_update_locks_for_mdev(struct 
>> ap_matrix_mdev *matrix_mdev)
>> -{
>> -    mutex_unlock(&matrix_dev->mdevs_lock);
>> -    if (matrix_mdev && matrix_mdev->kvm)
>> -        mutex_unlock(&matrix_mdev->kvm->lock);
>> -    mutex_unlock(&matrix_dev->guests_lock);
>> -}
>> -
>>   /**
>>    * get_update_locks_by_apqn: Find the mdev to which an APQN is 
>> assigned and
>>    *                 acquire the locks required to update the APCB of
>> @@ -642,8 +595,7 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>       return 0;
>>   }
>>   -static void vfio_ap_matrix_init(struct ap_config_info *info,
>> -                struct ap_matrix *matrix)
>> +void vfio_ap_matrix_init(struct ap_config_info *info, struct 
>> ap_matrix *matrix)
>>   {
>
> This is unrelated cleaup work. Good change :) But it should be a 
> separate patch. Same for several other changes in this patch.

This was made non-static because it is called in patch 10/15; in other 
words you are right, it doesn't
belong here. This and the other unrelated patches will be done via a new 
patch which will
precede this one. In fact, all of the changes making static functions 
non-static in this patch will
be done in the new patch.

>
>
>>       matrix->apm_max = info->apxa ? info->na : 63;
>>       matrix->aqm_max = info->apxa ? info->nd : 15;
>> @@ -1018,13 +970,12 @@ static void vfio_ap_mdev_link_adapter(struct 
>> ap_matrix_mdev *matrix_mdev,
>>       unsigned long apqi;
>>         for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS)
>> -        vfio_ap_mdev_link_apqn(matrix_mdev,
>> -                       AP_MKQID(apid, apqi));
>> +        vfio_ap_mdev_link_apqn(matrix_mdev, AP_MKQID(apid, apqi));
>>   }
>>   -static void collect_queues_to_reset(struct ap_matrix_mdev 
>> *matrix_mdev,
>> -                    unsigned long apid,
>> -                    struct list_head *qlist)
>> +static void collect_queues_by_apid(struct ap_matrix_mdev *matrix_mdev,
>> +                   unsigned long apid,
>> +                   struct list_head *qlist)
>
> unrelated

This rename is not only unrelated, it is unnecessary. The original name 
will be
restored.

>
>>   {
>>       struct vfio_ap_queue *q;
>>       unsigned long  apqi;
>> @@ -1042,7 +993,7 @@ static void reset_queues_for_apid(struct 
>> ap_matrix_mdev *matrix_mdev,
>>       struct list_head qlist;
>>         INIT_LIST_HEAD(&qlist);
>> -    collect_queues_to_reset(matrix_mdev, apid, &qlist);
>> +    collect_queues_by_apid(matrix_mdev, apid, &qlist);
>>       vfio_ap_mdev_reset_qlist(&qlist);
>>   }
>>   @@ -1058,7 +1009,7 @@ static int reset_queues_for_apids(struct 
>> ap_matrix_mdev *matrix_mdev,
>>       INIT_LIST_HEAD(&qlist);
>>         for_each_set_bit_inv(apid, apm_reset, AP_DEVICES)
>> -        collect_queues_to_reset(matrix_mdev, apid, &qlist);
>> +        collect_queues_by_apid(matrix_mdev, apid, &qlist);
>
> unrelated
>
>>         return vfio_ap_mdev_reset_qlist(&qlist);
>>   }
>> @@ -1729,54 +1680,100 @@ static void ap_matrix_copy(struct ap_matrix 
>> *dst, struct ap_matrix *src)
>>       bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
>>   }
>>   -static ssize_t ap_config_store(struct device *dev, struct 
>> device_attribute *attr,
>> -                   const char *buf, size_t count)
>> +static void get_removed_matrixes(struct ap_matrix *m_removed,
>> +                 struct ap_matrix *m_old,
>> +                 struct ap_matrix *m_new)
>>   {
>> -    struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>> -    struct ap_matrix m_new, m_old, m_added, m_removed;
>> +    bitmap_andnot(m_removed->apm, m_old->apm, m_new->apm, AP_DEVICES);
>> +    bitmap_andnot(m_removed->aqm, m_old->aqm, m_new->aqm, AP_DOMAINS);
>> +    bitmap_andnot(m_removed->adm, m_old->adm, m_new->adm, AP_DOMAINS);
>> +}
>> +
>> +static void get_added_matrixes(struct ap_matrix *m_added,
>> +                   struct ap_matrix *m_old,
>> +                   struct ap_matrix *m_new)
>> +{
>> +    bitmap_andnot(m_added->apm, m_new->apm, m_old->apm, AP_DEVICES);
>> +    bitmap_andnot(m_added->aqm, m_new->aqm, m_old->aqm, AP_DOMAINS);
>> +    bitmap_andnot(m_added->adm, m_new->adm, m_old->adm, AP_DOMAINS);
>> +}
>
> Unless you plan on reusing these functions elsewhere, I'd argue 
> they're cleaner and easier to read when left in their calling function.

This is a stylistic preference, not a correctness concern; my preference 
is to keep it.
The primary reason I created these functions
is because I really don't like overly long functions that I have to page 
through.
vfio_ap_set_new_guest_config() is quite a verbose function, so I 
shortened it with
these functions. I don't think the code is any easier to read or 
understand if
left in-line. In my opinion, since the function names are 
self-documenting, it
makes the code more understandable at the point they are called. Looking
at bitmap_andnot and trying to figure out what that does is not cleaner
and clearer in my opinion. Of course, one could argue a doc block prior to
those three lines would do the same thing, but I think if one is reading 
the
code, they can always go to these functions to see how the sausage is made.
I'm sorry for the long dissertation, but I thought I'd state my 
reasoning for
keeping them.

>
>> +static int validate_new_state(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    int rc;
>> +
>> +    /* Ensure new state is valid, else undo new state */
>> +    rc = vfio_ap_mdev_validate_masks(matrix_mdev);
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = ap_matrix_overflow_check(matrix_mdev);
>> +    if (rc)
>> +        return rc;
>> +
>> +    return 0;
>> +}
>> +
>> +static void link_new_queues(struct ap_matrix_mdev *matrix_mdev,
>> +                struct ap_matrix *m_added)
>> +{
>> +    unsigned long apid, apqi;
>> +
>> +    for_each_set_bit_inv(apid, m_added->apm, AP_DEVICES)
>> +        vfio_ap_mdev_link_adapter(matrix_mdev, apid);
>> +
>> +    for_each_set_bit_inv(apqi, m_added->aqm, AP_DOMAINS)
>> +        vfio_ap_mdev_link_domain(matrix_mdev, apqi);
>> +}
>> +
>> +/**
>> + * vfio_ap_set_new_guest_config:
>> + *
>> + * Set a new AP configuration for a guest.
>> + *
>> + * @matrix_mdev: Object used to maintain the AP configuration for a 
>> guest
>> + * @m_new:         Object used to set the new AP configuration
>> + *
>> + * Returns: zero (0) if the new AP configuration is successfully 
>> set; otherwise,
>> + *        returns an error:
>> + *
>> + *        ~ EADDRNOTAVAIL One or more APQNs are reserved for host use
>> + *        ~ EADDRINUSE    One or more APQNs are assigned to another 
>> mdev
>> + *        ~ ENODEV        An adapter, domain or control domain in 
>> the new
>> + *                AP configuration exceeds the max architected value
>> + */
>> +int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
>> +                 struct ap_matrix *m_new)
>> +{
>> +    struct ap_matrix m_old, m_old_shadow, m_added, m_removed;
>>       DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>> -    unsigned long newbit;
>> -    char *newbuf, *rest;
>> -    int rc = count;
>>       bool do_update;
>> +    int rc;
>>   -    newbuf = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
>> -    if (!newbuf)
>> -        return -ENOMEM;
>> -    rest = newbuf;
>> +    lockdep_assert_held(&ap_attr_mutex);
>> +    assert_has_update_locks_for_mdev(matrix_mdev);
>>   -    mutex_lock(&ap_attr_mutex);
>> -    get_update_locks_for_mdev(matrix_mdev);
>> -
>> -    /* Save old state */
>> +    /* Save the old state */
>>       ap_matrix_copy(&m_old, &matrix_mdev->matrix);
>> -    if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
>> -        parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
>> -        parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
>> -        rc = -EINVAL;
>> -        goto out;
>> -    }
>> +    ap_matrix_copy(&m_old_shadow, &matrix_mdev->shadow_apcb);
>>   -    bitmap_andnot(m_removed.apm, m_old.apm, m_new.apm, AP_DEVICES);
>> -    bitmap_andnot(m_removed.aqm, m_old.aqm, m_new.aqm, AP_DOMAINS);
>> -    bitmap_andnot(m_added.apm, m_new.apm, m_old.apm, AP_DEVICES);
>> -    bitmap_andnot(m_added.aqm, m_new.aqm, m_old.aqm, AP_DOMAINS);
>> +    /*
>> +     * Get the adapters, domains and control domains added and/or 
>> removed
>> +     * from the existing configuration
>> +     */
>> +    get_removed_matrixes(&m_removed, &m_old, m_new);
>> +    get_added_matrixes(&m_added, &m_old, m_new);
>>         /* Need new bitmaps in matrix_mdev for validation */
>> -    ap_matrix_copy(&matrix_mdev->matrix, &m_new);
>> +    ap_matrix_copy(&matrix_mdev->matrix, m_new);
>>         /* Ensure new state is valid, else undo new state */
>> -    rc = vfio_ap_mdev_validate_masks(matrix_mdev);
>> -    if (rc) {
>> -        ap_matrix_copy(&matrix_mdev->matrix, &m_old);
>> -        goto out;
>> -    }
>> -    rc = ap_matrix_overflow_check(matrix_mdev);
>> +    rc = validate_new_state(matrix_mdev);
>>       if (rc) {
>>           ap_matrix_copy(&matrix_mdev->matrix, &m_old);
>> -        goto out;
>> +        ap_matrix_copy(&matrix_mdev->shadow_apcb, &m_old_shadow);
>
> You seem to be keeping shadow_apcb in lockstep with 
> matrix_mdev->matrix. But we still have the original code below that 
> does the official shadow_apcb update after validation has been 
> performed. Why did you decide to change how/when shadow_apcb was being 
> updated? And if this was intentional, why are we still performing a 
> separate update of shadow_apcb at the end?

This is a valid point, there is no need for m_old_shadow

>
> /* Apply changes to shadow apbc if things changed */
> if (do_update) {
>     vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>     reset_queues_for_apids(matrix_mdev, apm_filtered);
> }
>
>> +        return rc;
>>       }
>> -    rc = count;
>>         /* Need old bitmaps in matrix_mdev for unplug/unlink */
>>       ap_matrix_copy(&matrix_mdev->matrix, &m_old);
>> @@ -1786,14 +1783,10 @@ static ssize_t ap_config_store(struct device 
>> *dev, struct device_attribute *attr
>>       vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
>>         /* Need new bitmaps in matrix_mdev for linking new 
>> adapters/domains */
>> -    ap_matrix_copy(&matrix_mdev->matrix, &m_new);
>> -
>> -    /* Link newly added adapters */
>> -    for_each_set_bit_inv(newbit, m_added.apm, AP_DEVICES)
>> -        vfio_ap_mdev_link_adapter(matrix_mdev, newbit);
>> +    ap_matrix_copy(&matrix_mdev->matrix, m_new);
>>   -    for_each_set_bit_inv(newbit, m_added.aqm, AP_DOMAINS)
>> -        vfio_ap_mdev_link_domain(matrix_mdev, newbit);
>> +    /* Link queues associated with the newly added adapters and 
>> domains */
>> +    link_new_queues(matrix_mdev, &m_added);
>>         /* filter resources not bound to vfio-ap */
>>       do_update = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
>> @@ -1804,7 +1797,39 @@ static ssize_t ap_config_store(struct device 
>> *dev, struct device_attribute *attr
>>           vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>>           reset_queues_for_apids(matrix_mdev, apm_filtered);
>>       }
>> -out:
>> +
>> +    return 0;
>> +}
>> +
>> +static ssize_t ap_config_store(struct device *dev, struct 
>> device_attribute *attr,
>> +                   const char *buf, size_t count)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>> +    struct ap_matrix m_new;
>> +    char *newbuf, *rest;
>> +    ssize_t rc;
>> +
>> +    newbuf = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
>> +    if (!newbuf)
>> +        return -ENOMEM;
>> +    rest = newbuf;
>> +
>> +    mutex_lock(&ap_attr_mutex);
>> +    get_update_locks_for_mdev(matrix_mdev);
>> +
>> +    if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
>> +        parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
>> +        parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
>> +        kfree(newbuf);
>> +        release_update_locks_for_mdev(matrix_mdev);
>> +        mutex_unlock(&ap_attr_mutex);
>> +        return -EINVAL;
>> +    }
>> +
>> +    rc = vfio_ap_set_new_guest_config(matrix_mdev, &m_new);
>> +    if (!rc)
>> +        rc = count;
>> +
>>       release_update_locks_for_mdev(matrix_mdev);
>>       mutex_unlock(&ap_attr_mutex);
>>       kfree(newbuf);
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index 1fbdfcce5a11..150dfce8a674 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -157,6 +157,62 @@ struct vfio_ap_queue {
>>       struct work_struct reset_work;
>>   };
>>   +/**
>> + * get_update_locks_for_mdev: Acquire the locks required to 
>> dynamically update a
>> + *                  KVM guest's APCB in the proper order.
>> + *
>> + * @matrix_mdev: a pointer to a struct ap_matrix_mdev object 
>> containing the AP
>> + *         configuration data to use to update a KVM guest's APCB.
>> + *
>> + * The proper locking order is:
>> + * 1. matrix_dev->guests_lock: required to use the KVM pointer to 
>> update a KVM
>> + *                   guest's APCB.
>> + * 2. matrix_mdev->kvm->lock:  required to update a guest's APCB
>> + * 3. matrix_dev->mdevs_lock:  required to access data stored in a 
>> matrix_mdev
>> + *
>> + * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, 
>> the KVM
>> + *     lock will not be taken.
>> + */
>> +static inline void get_update_locks_for_mdev(struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> +    mutex_lock(&matrix_dev->guests_lock);
>> +    if (matrix_mdev && matrix_mdev->kvm)
>> +        mutex_lock(&matrix_mdev->kvm->lock);
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>> +}
>> +
>> +/**
>> + * release_update_locks_for_mdev: Release the locks used to 
>> dynamically update a
>> + *                  KVM guest's APCB in the proper order.
>> + *
>> + * @matrix_mdev: a pointer to a struct ap_matrix_mdev object 
>> containing the AP
>> + *         configuration data to use to update a KVM guest's APCB.
>> + *
>> + * The proper unlocking order is:
>> + * 1. matrix_dev->mdevs_lock
>> + * 2. matrix_mdev->kvm->lock
>> + * 3. matrix_dev->guests_lock
>> + *
>> + * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, 
>> the KVM
>> + *     lock will not be released.
>> + */
>> +static inline void release_update_locks_for_mdev(struct 
>> ap_matrix_mdev *matrix_mdev)
>> +{
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +    if (matrix_mdev && matrix_mdev->kvm)
>> +        mutex_unlock(&matrix_mdev->kvm->lock);
>> +    mutex_unlock(&matrix_dev->guests_lock);
>> +}
>> +
>> +static inline void
>> +assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    lockdep_assert_held(&matrix_dev->guests_lock);
>> +    if (matrix_mdev && matrix_mdev->kvm)
>> +        lockdep_assert_held(&matrix_mdev->kvm->lock);
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +}
>> +
>>   int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
>>     int vfio_ap_mdev_register(void);
>> @@ -172,9 +228,14 @@ void vfio_ap_on_cfg_changed(struct 
>> ap_config_info *new_config_info,
>>   void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>>                     struct ap_config_info *old_config_info);
>>   +void vfio_ap_matrix_init(struct ap_config_info *info, struct 
>> ap_matrix *matrix);
>> +
>>   void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev 
>> *matrix_mdev);
>>   int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
>>   void vfio_ap_release_migration_data(struct ap_matrix_mdev 
>> *matrix_mdev);
>>   void vfio_ap_reset_migration_state(struct ap_matrix_mdev 
>> *matrix_mdev);
>>   +int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
>> +                 struct ap_matrix *m_new);
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */
>

