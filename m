Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D24C2247;
	Mon,  5 Oct 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213869; cv=none; b=prCbksTNIuRc6MB3qpqTp8mWoWNZfqh9+qWnKY+e46jnpEqZUGJ+NW2aPN6+vru5d6s7AzWYirVQTnOOaBgcC/lX6pl+jyjB0gnWoBUaL4ZHwuxcYasMn8sCbDo+FImZRGqkln6RDBHAhL7GPgx2O9ptDnYENeB+ZykIllRy6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213869; c=relaxed/simple;
	bh=7d/O3lOAsp6rsUnXlRJKvBp7BSrCFuxB0tBR+JTLmXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZvGP+1AUObZZbcBXWdaqkJIBfk+I0X7OBE8hdsJSpQfBzn5GS0K4xCf0JvFnD8KJMDUaCCA+YzkCYTdmWdX+S6qi/L2w2KqDFSzeYhEUWdoLNVmNRvG+RF/ZGvY044to6Bn7PNJ7GGWftQlRt7kY4YfDZQHv/FlJ0HPtVk8enA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=st4LMfaj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="st4LMfaj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZm7d3876505;
	Mon, 5 Oct 2026 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4QUaWy
	mfGnBs8rxN00ZEacL/mvEmz95xSXkLr8jS5uw=; b=st4LMfajsLqbTPcUypnApd
	r9nBJiq5lsQK8N5PN+uGWNYu67WKkW+EKazu5GrVPWKymG91NsJ9IFgG6ieQuWcA
	oTFBIqsTONY5MYL73nQEb5lqB/58ZYW/sjhzKKApsO4Ys/s66MDEWuBZyHUj4IeH
	0d1T2WNZ6x8K3OLSEXH7tT2e4Y3vgOUdY/5w6lJY3Vf0WuZVjhtDMDh7qcxCZ1hM
	HNiR9HXCimHn6wxzFsGReYCmQL1hFyEjP5RJREdDy5KZtT+5NTDsuxRWCwUCv9E8
	Vtli2fKUasZE/05RxbdaHhRXhDCcVP9kpp9H+yRhrcUfxPVuUWqdvn6Xn7HEK0tw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4ftesy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:24:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWbDU3025111;
	Mon, 5 Oct 2026 15:24:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jp141-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:24:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695FOIgl26149426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 15:24:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AED195805A;
	Mon,  5 Oct 2026 15:24:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 220F658054;
	Mon,  5 Oct 2026 15:24:17 +0000 (GMT)
Received: from [9.61.34.243] (unknown [9.61.34.243])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 15:24:16 +0000 (GMT)
Message-ID: <37554c65-1834-449a-bfbc-60f2c4ac73f5@linux.ibm.com>
Date: Mon, 5 Oct 2026 11:24:16 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-4-akrowiak@linux.ibm.com>
 <46194cc6-b5de-4f03-abb0-927b6c72960e@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <46194cc6-b5de-4f03-abb0-927b6c72960e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac3c124 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_iRe76FCLie6KbKwzNQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfX+JEwcdqxZv1l
 SPLQRARrN6ydDiVIY/exXL59LI9i21E4oAk65CT0Mc/fvlYDbANr1e5BSPs0YZNldiwAKscof5E
 zC9vLsIMJRBhndts8IwtGOJg1gB6+pOvJPlLzmgdfVmQYMherBow6+hG9t9AVGIHfYgjfje7uNs
 6utetYbLm9iEbB8d/BOMlDt4oFFmmoAY6ruIIlL+mmQ18aR6he441fq3yVLP0rEFx2tSN76FdqN
 Qz/zYeNsiWNuGT7nKNBN0Ddux824gLGhv6SupnbXOkb3cyF8Anx3OmWZKQEiZRxz8oEevTr5+gw
 lLKemQkmRDPzZ785ZeSAoziPrhhXv0Iu8YgWr3CcCj7Zh9hhlt5xL3uPmft97W6Dy4ODtIwX/Qh
 lrsQB/eZyT1UgI3hVYeZQrSk2NmtP56mCb/ApsBprkxIZBJ8hkGLLugZ8Dv852BWDzlicvHA4JX
 Ef/RKe7AgpoYQb2+K9Q==
X-Proofpoint-GUID: jS2XHS1aEwHT8U9l-4UXn_GRwlh7Xrpb
X-Proofpoint-ORIG-GUID: jS2XHS1aEwHT8U9l-4UXn_GRwlh7Xrpb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfXx4Ynoke2wmRJ
 j5Y3jULurDHrr1QJdlCmeciNoAXbnh1jUCylxjzOrYj0uV8ny6jn1L+OIk7XcolAqSk0OB3K/DE
 LnBIhwpC3r8pgjzRtKEHmQ7/ZxC1iFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050059



On 8/11/26 9:57 AM, Jason J. Herne wrote:
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Provides the functions that initialize and release the data structures
>> used during live guest migration:
>>
>> ...
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_migration.c | 127 ++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c       |  64 ++++++++++--
>>   drivers/s390/crypto/vfio_ap_private.h   |   4 +
>>   3 files changed, 187 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> index 374d3a67cb21..cf303d228a0a 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -4,6 +4,7 @@
>>    *
>>    * Copyright IBM Corp. 2025
>>    */
>> +#include <linux/file.h>
>>   #include "vfio_ap_private.h"
>>     /* Magic number and version for the vfio_ap_config migration blob */
>> @@ -111,3 +112,129 @@ struct vfio_ap_config {
>>       u64                adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
>>       struct vfio_ap_queue_info    qinfo[] __counted_by(num_queues);
>>   };
>> +
>> +static void
>> +vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
>> +{
>> +    /* Stub to be implemented when the 
>> mig_data->stop_copy_mig_file.ap_config
>> +     * object is allocated.
>> +     */
>> +}
>> +
>> +static void vfio_ap_release_resuming_file(struct 
>> vfio_ap_migration_data *mig_data)
>> +{
>> +    /* Stub to be implemented when the 
>> mig_data->resuming_mig_file.ap_config
>> +     * object is allocated.
>> +     */
>> +}
>> +
>> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>> +                      enum vfio_device_mig_state  new_state)
>> +{
>> +    return NULL;
>> +}
>> +
>> +static int vfio_ap_get_state(struct vfio_device *vdev,
>> +                 enum vfio_device_mig_state  *current_state)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int vfio_ap_get_data_size(struct vfio_device *vdev,
>> +                 unsigned long *stop_copy_length)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct vfio_migration_ops vfio_ap_migration_ops = {
>> +    .migration_set_state = vfio_ap_set_state,
>> +    .migration_get_state = vfio_ap_get_state,
>> +    .migration_get_data_size = vfio_ap_get_data_size,
>> +};
>> +
>> +/**
>> + * vfio_ap_init_migrations_capabilities - initialize migration 
>> capabilities
>
> typo: vfio_ap_init_migration s _capabilities

I will fix that

>
>> + *
>> + * @matrix_mdev: pointer to object containing the mdev state
>> + */
>> +void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> +    if (ap_is_se_guest())
>> +        return;
>> +
>> +    matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
>> +    matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
>> +}
>> +
>> +/**
>> + * vfio_ap_init_migration_data - initialize migration data and 
>> functions
>> + *
>> + * @matrix_mdev: pointer to object containing the mdev state
>> + *
>> + * Return: zero if initialization is successful; otherwise, returns 
>> a error.
>> + */
>> +int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    struct vfio_ap_migration_data *mig_data;
>> +
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +    mig_data = kzalloc_obj(struct vfio_ap_migration_data, GFP_KERNEL);
>> +    if (!mig_data)
>> +        return -ENOMEM;
>> +
>> +    mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
>> +    matrix_mdev->mig_data = mig_data;
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * vfio_ap_release_mig_files:
>> + *
>> + * Free the ap_config buffers for any open migration FDs. Although a
>> + * migration FD may still be held open by userspace, it is safe to free
>> + * mig_data here because:
>> + *
>> + *   1. matrix_mdev remains valid for the lifetime of any open 
>> migration
>> + *      FD via the vfio_device registration reference taken in
>> + *      vfio_ap_open_file_stream() and dropped in
>> + *      vfio_ap_release_mig_file().
>> + *
>> + *   2. mig_data is only accessed by the migration file ops
>> + *      (vfio_ap_stop_copy_read, vfio_ap_resuming_write) under
>> + *      mdevs_lock. Once mig_data is set to NULL by the caller, those
>> + *      paths will see NULL and return -ENODEV before dereferencing it.
>> + *
>> + * @matrix_mdev: The object used to maintain the state for a 
>> mediated device
>> + */
>> +static void vfio_ap_release_mig_files(struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> +    struct vfio_ap_migration_data *mig_data;
>> +
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +    mig_data = matrix_mdev->mig_data;
>> +    if (!mig_data)
>> +        return;
>
> Both callers already perform the above check under lock. This one 
> seems redundant.

That is true, will fix.

>
>> + vfio_ap_release_stop_copy_file(mig_data);
>> +    vfio_ap_release_resuming_file(mig_data);
>> +}
>> +
>> +/**
>> + * vfio_ap_release_migration_data: reclaim private migration data
>> + *
>> + * @vdev: pointer to the mdev
>> + */

