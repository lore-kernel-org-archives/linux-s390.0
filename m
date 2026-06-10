Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620D35972;
	Wed, 10 Jun 2026 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050369; cv=none; b=Jckm0htqbiPMIWxIWFjTOT1Pf0lSY5L1ZoHL9F6rg+SYawTpXm6BuA/Cd/Dw1JLxsUCucGsHz0hIDz15n/nIcOsMBtytoN0JtOtxlKQGvmA4L/IQHOgK47IDXIPJC+SrFygPDxP2rsWPc3Cr2PAoZQJC2VMHFnV+T7b080voc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050369; c=relaxed/simple;
	bh=WH6MJ3BterG3mXGpV+/ZRIAnvKt36oJ3z46fTAaNuEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NE6wWZ0f+Dr01EkOlgpGmSFBeZeVkM87Kdc5nBsHfzuA4Ywk98plTfqIQGkjzFCp1R99rOdegg1ndUqgxEauV63EprHXmPkVSKFF4Guex3K1xJnomkljvO3Yv6a8K7dK7lDcz6KJFSzG53dNgTBA/fSp5H6wp8zG5+OfRWIobjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O16SJIt3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O16SJIt3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BKW8j2552576;
	Wed, 10 Jun 2026 00:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hDrEzm
	RabDidifqeplPuXB9RF/+q9mP050kuC2jxfGU=; b=O16SJIt399fWAGytR/u9Tc
	2eWeW8o1HGLJZkw9QVlF1bv/bQAHMDXUEMowRgLOdcnC3Qsv2yv5R4o9XKStmJjs
	inhmEErVQuu7jvziIOH9Ep7FI76LoGTnauzHUdycqoopts+fJyg+w2ndXrx16A41
	jDqts3aG8+gv/6nh07UwPiLp+xdSVFw7vOAvw9TUnV5cAr9nvN9L4Pbl+lTWFfNh
	rjwG/E6Ya6dQOUvbY0ZY6l72KB5hxWArfMxzFxmYQR0GGoj2DX9ouN7Q8zPl9NtK
	pNprj7762pkGa/6N+7FjyzVovjUJyqJPCWQouRtbYpyRHebRKFZmLLzfYLWc4krA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhxnnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 00:12:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A04fX3019972;
	Wed, 10 Jun 2026 00:12:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w4fyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 00:12:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A0Chjo23528078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 00:12:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5422F58056;
	Wed, 10 Jun 2026 00:12:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4857158052;
	Wed, 10 Jun 2026 00:12:42 +0000 (GMT)
Received: from [9.61.246.182] (unknown [9.61.246.182])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 00:12:42 +0000 (GMT)
Message-ID: <791e3c00-550a-4eb7-aeb7-5d3cc9bd5575@linux.ibm.com>
Date: Tue, 9 Jun 2026 20:12:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] vfio-pci/zdev: Add VFIO FMB device features
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
 <20260608171850.62829-4-oelghoul@linux.ibm.com>
 <20260609164332.5dc548f5@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260609164332.5dc548f5@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyOCBTYWx0ZWRfX28MZF8CSpUjy
 5V0Zm7MKOb/+Vn1O91VPs3+OeP55WKGbyBgdSNioUfYu9WKLarbJlJCjkl73bSYnZQfNBEd1+90
 eyARLTEI/4H3Cr1EYrqmB0hnqkZ495k683dFruU8FbLlW5DA4aLP2EkecF4YSX4EDG7UpkDC1ER
 Xz3mbhcFRq3JLfPth1gfZY1BQgW7Na4GwOct+1xGyUyLt/fm6x4fCKmM36s2WhxG64Muuy0Xy7+
 gMhbEAEAulL0uz9pARNvZ0rAZgsxvZV1xNNi6zDMiIPbVwJuiVNjLwbHd6XxPcsrip9p078PDbC
 vHAdk2XptRLdn8nMxsf4sxW6jO8CSMdYLq1ot/RXTqr501pTnNV0ODIasie6UhBEZX9tFQoejxN
 9CDwDpBn9VcITOSHeH3HsBXSl5QNxi2yhqvuuHd8bukAn+mGsDlFfvuXiRtC1DO6NXkHTgQlvXo
 qH3N1GDsO3nUh4yyqEQ==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a28abfd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=R80qHI7_lYkLXOIx1w4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pJDsFAVARoWHQAbREMlmeGbWHkjTfjk9
X-Proofpoint-GUID: pJDsFAVARoWHQAbREMlmeGbWHkjTfjk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090228

On 6/9/26 6:43 PM, Alex Williamson wrote:
> On Mon,  8 Jun 2026 13:18:49 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
>> index 0990fdb146b7..09454495ee23 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -167,3 +167,60 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>>   	if (zpci_kvm_hook.kvm_unregister)
>>   		zpci_kvm_hook.kvm_unregister(zdev);
>>   }
>> +
>> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
>> +				     void __user *arg, size_t argsz)
>> +{
>> +	struct zpci_dev *zdev;
>> +	struct vfio_device_feature_zpci_fmb_enable fmb_enable;
>> +	int ret;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, sizeof(fmb_enable));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	guard(mutex)(&zdev->fmb_lock);
>> +
>> +	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
>> +		return -EFAULT;
> 
> The guard can drop to here, it doesn't protect anything related to the
> copy_from_user().

Acked

> 
>> +
>> +	if (fmb_enable.enabled)
>> +		return zpci_fmb_reenable_device(zdev);
>> +	return zpci_fmb_disable_device(zdev);
>> +}
>> +
>> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
>> +				   void __user *arg, size_t argsz)
>> +{
>> +	struct zpci_dev *zdev;
>> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
>> +	struct zpci_fmb fmb_temp = {0};
> 
> Unnecessary initialization, we only copy to the user what's been
> written.

Acked as well

> 
>> +	int ret;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeof(fmb_read));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	guard(mutex)(&zdev->fmb_lock);
>> +
>> +	if (!zdev->fmb)
>> +		return -ENOMSG;
>> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
>> +		return -EFAULT;
>> +	if (!fmb_read.data)
>> +		return -EINVAL;
>> +
>> +	memcpy(&fmb_temp, zdev->fmb, zdev->fmb_length);
>> +	if (copy_to_user(fmb_read.data, &fmb_temp, zdev->fmb_length))
>> +		return -EFAULT;
> 
> The bounce buffer itself seems unnecessary in this usage, we could just:
> 
> 	if (copy_to_user(fmb_read.data, zdev->fmb, zdev->fmb_length))
> 
> But maybe there was an intention to scope the bounce buffer copy within
> the guard and perform the copy_to_user() after releasing the lock?

I did not have that intention actually. This was to avoid a particular
issue with copying from a kmem_cache object to userspace. I guess an
alternate solution could be to initialize the SLUB object itself to
allow usercopy without making this a VFIO concern.

> 
> 
>> +
>> +	return 0;
>> +}
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..3988e8690e0b 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,35 @@ struct vfio_device_feature_dma_buf {
>>    */
>>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>   
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
>> + *
>> + * enabled is treated as a bool, so any non-zero value evaluates to true. This
>> + * feature fails on attempt to double enable/disable.
> 
> Does it?  Double enable just does a re-enable.

My bad, I meant to remove the "re" from "reenable".

> 
>> + *
>> + * Returns: 0 on success, -1 and errno set appropriately on error.
>> + */
>> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 13
>> +
>> +struct vfio_device_feature_zpci_fmb_enable {
>> +	__u8 enabled;
>> +};
>> +
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
>> + *
>> + * The user-provided buffer must be at least fmb_length large, where fmb_length
>> + * is reported in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.
>> + *
>> + * Returns: 0 on success, -1 and errno set appropriately on error. errno==ENOMSG
>> + * when the FMB is not enabled.
>> + */
>> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_READ 14
>> +
>> +struct vfio_device_feature_zpci_fmb_read {
>> +	void __user *data;
> 
> We should use explicit data sizes for uAPI:
> 
> 	__aligned_u64 data;

Noted, will amend in the next version. Thanks.

> 
> Thanks,
> Alex
> 

