Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B743B05B2;
	Wed, 14 Oct 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004908; cv=none; b=iSA9M+KHaH6vD9StF09CECa3eDpMsER25FVbzNhJK6xmkmUgtCgX/oujp0zRaiu2oXIsZMzwwAhe4prmrrGfQdrfAnLLnGobGl4fdJWBuyEErcXZNRqvt/Xe6ELhY+uBE/yIkBsWyQs1yMiNXVXsxdiECWckZZD1gmQ5kPd+zi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004908; c=relaxed/simple;
	bh=Uv7UthX6eHfk1uJ15uCh+BOEUFvwtA3DILIGfDRdUrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF60iQ7QwUoVxguy2HJv2Z0Dmu7nPA4qP/UFgEr//r3Z2ZkfTyy3ENePrZ9Q8NsEz31Q9VXc0/iKnpYkCZB/TKZUWNXR4ZeDv9DTY42JYXR9iFbS6ogXbtFOUr79hTU5gsCy8JsoF3IYzPheASPca2OtVGs1Q/KYIS1VhvUjzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phMz1UZL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phMz1UZL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEj2GP1271549;
	Wed, 14 Oct 2026 19:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ARQKtf
	2cjv0SFyALl6Est+Z2sJTqNDSOnGPiZzxreeI=; b=phMz1UZLVzukiKS/lBtj/V
	4nmcpgz2SDz5VcFp+1sxRxA3s1ngNvXakT6fsnJFpJHQBphkdzmoCOmRd0vm6oM9
	MIOarb2obpgLEuSnDphx8whVlpgS7966xdKXQ91AtB/9Pz16Zp0t6NL7SC7W1RzF
	q6RNO4EySk3Ntrpg4lFulxzZQSvMaPuBR6u48cC42fDKS/l3qD7i0rsoCk/SKwLU
	t9e49hVQCsKvrFt8vtVNQ3elCqBkLt3qDZijLVESI3dlcpHr6iiCMyYEK73t+PHq
	ba0VfZBzD7UtB26IJeRWi2EQzStlu/ex7lbjJrkwSRmNfsozAxb7xjN9r22Dselw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0nq1w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 19:08:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIZ4EZ702814;
	Wed, 14 Oct 2026 19:08:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h8spg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 19:08:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EJ7baL25428574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 19:07:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1020758055;
	Wed, 14 Oct 2026 19:08:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EAB558043;
	Wed, 14 Oct 2026 19:08:23 +0000 (GMT)
Received: from [9.61.132.24] (unknown [9.61.132.24])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 19:08:23 +0000 (GMT)
Message-ID: <35a8a596-ffe8-4b7a-89cc-f82465a9dd26@linux.ibm.com>
Date: Wed, 14 Oct 2026 15:08:22 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-12-akrowiak@linux.ibm.com>
 <sashiko-outbox-170099@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-170099@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NCBTYWx0ZWRfXwBDbEAqkzkgX
 GXBRNWqdPkepDCqHirtpp6GZpqDx0M7+qA/C6nDrSWbCtVm5AZ2rv7+xpV9PaAxzRrEq7Y3Aipy
 gOZsFfaidjiGgj8SZ47uqBZrS3x0TZIUOoai8L2ahx/GN5/3819Qgg2N3icWz2asMj++9cqiXjO
 NNNrBX2qq5dTKIP2MX+MwV+7Kgm7DsBsGlKov8dznWxsXhjBGCtxx8skxkB1kJ0C4CwVbrwiv/D
 yRAkAbmkt+J7PgI6BIOBpGrVH0F+wxQMkIw3aJ9moNJ4OOIFXC5Wz8pgwKSf4r8wJNckC0zZaFd
 OYY0Ojx0UusXRqDTr+kYySDi4mIRuQr5cX5MzcIEuXzN2L2OTRBvhL/n7brDO9sAc9ztsfpcg2o
 ln1s0T/cOGFDiH8sS23O7cspxwhrWaoHB8wfr1SJBeRjgH7fSUQb8jDcxZE7hZjTdjNckxsLSxH
 xm1xFFGrMBzFIeFjkNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NCBTYWx0ZWRfX9+iiSq47jiVM
 vM5DNrOJj2UKYQkxAogZasfF1wRTRVtFeRFIvfWKWZPsSLwD/ePARdtXLc7QWxB4oWJXcEcJUTM
 g4iCVzU3aivQwVF2dnAdArRZq+5un24=
X-Proofpoint-ORIG-GUID: AQ7mQuzZTm83IbxjaPxW7o5J8wRuQXcl
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acfd329 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2rxGisQGleF7859r0JcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AQ7mQuzZTm83IbxjaPxW7o5J8wRuQXcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140074



On 10/13/26 12:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] fortify: __counted_by() traps on memcpy() of ap_config causing kernel panic
> - [Low] build: incompatible pointer type warning for num_queues in vfio_ap_get_config()
> --
>
> commit 1f3606fec30cc37e82a55e4d85b768771f43fc2f
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to resume the vfio device migration
>
> This commit implements the write callback function for the file stream
> created to restore the state of the vfio-ap device on the destination system.
> Userspace reads the source guest's saved vfio-ap device state and writes it
> to this file stream. The write callback copies each chunk into a pre-allocated
> vfio_ap_config structure and validates it against the destination host's
> configuration.
>
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -284,7 +340,7 @@ static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
>>   
>>   	lockdep_assert_held(&matrix_dev->mdevs_lock);
>>   
>> -	ap_config_size = vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
>> +	ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
> [Severity: Low]
> Is it possible this causes a build failure? vfio_ap_config_size() expects
> an int pointer for its second argument, but num_queues is declared as an
> unsigned int. Passing an unsigned int pointer here introduces an
> incompatible pointer type warning which breaks the build under
> CONFIG_WERROR.

The async bit in the AP queue status word indicates that the response
code was reported asynchronously. Per the architecture, the only
response code for which GR2 (hwinfo) is guaranteed to be populated
is AP_RESPONSE_NORMAL (0x00). For all other response codes, including
AP_RESPONSE_DECONFIGURED, AP_RESPONSE_CHECKSTOPPED, and any code with
the async bit set, the architecture states that all fields except the
response-code field are set to zeros, so hwinfo is not valid.

AP_RESPONSE_BUSY and AP_RESPONSE_RESET_IN_PROGRESS are transient
conditions; the function will be updated to retry up to 5 times with
a 10ms delay between attempts, consistent with how other vfio_ap
operations handle these response codes. All other non-NORMAL response
codes will return -EIO. The async path in the default branch that
returned 0 will be removed.

>
> [ ... ]
>
>> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
> [ ... ]
>
>> +	ret = validate_resuming_write_parms(filp, len);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
>> +
>> +	memcpy((char *)ap_config + *pos, kbuf, len);
> [Severity: High]
> Does this memcpy() trigger a fortify panic? The struct vfio_ap_config
> utilizes the __counted_by(num_queues) annotation for its flexible array.
> During the resuming phase, ap_config is allocated with num_queues initialized
> to 0.
>
> Because memcpy() is fortified, it evaluates the maximum size of the
> destination object using __builtin_dynamic_object_size(). At the time of
> this memcpy(), ap_config->num_queues is still 0, so the compiler evaluates
> the destination capacity strictly as the struct header size.
>
> If userspace writes the migration data in a chunk larger than the header
> size, the bounds check will fail before num_queues can be overwritten,
> triggering a panic and crashing the system.

The memcpy() destination is (char *)ap_config + *pos — a char * into
the raw allocation, not an access through the flexible array member
qinfo[]. The __counted_by annotation on qinfo[] constrains accesses
expressed as ap_config->qinfo[i]; it does not restrict a char * byte
copy into the same allocation.

>
>> +	*pos += len;
>> +
>> +	/*
>> +	 * Check whether we have received all the data.  We know the total
>> +	 * expected size once num_queues has arrived, i.e. once *pos is past
>> +	 * the fixed header.  Until then keep accumulating.
>> +	 */
>> +	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {

