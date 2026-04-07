Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB973BA227;
	Tue,  7 Apr 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585646; cv=none; b=XsrooiI93NSJtyK+C7/Z6J142Aiw0K0D2UN4Xg5yvuD8/h+RmzcOMONot4ME2fd6XntWzOJqgdDhEppkFI+zfJGixdhaLb77Gm+5JV8k0DlEO0UTdsYDuloBMq9HYDpSFtrKzEn3d/S5tl7lFajyZQ/lLpXKNUwvTg/k8/6CCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585646; c=relaxed/simple;
	bh=qArccHJoyyKXZ0LOulz+SwfQX6IvqQaLRNy0HKXVHXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ezq1dE5OV9tcCEf1UnYRISDSZPQSQy/1OyRUjtO/WppNvpoggJddXUt5MwI7lh9s3oMofdbebusILh+gVSwMRon0JjJLL9JLLKUhUqQuio/D93jNuIB/JewKWv2hQv2chXYysj6dahhYtikOujYhj3URU6HMurDl4FqTxh0vEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZlmpBIM6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZlmpBIM6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DfkOh2297475;
	Tue, 7 Apr 2026 18:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3+FmD3
	WVNDMa1PVKjsuHPWcVtPcWrOUGKi7ypav1zn8=; b=ZlmpBIM6A9LN/fb6Q5MiwL
	1FGZewS+8d66h9e9nPlNV1jU/Cq+S+VIrmScIVQ6YyKlb+Vs67f/N3q4nfdLVj0R
	dJ5Z/Zx/ScP12z56iUJRrFMXkaDdZi9Y7LPjHSHj/FG80TD5KgzzPl5ZpffXmf1m
	gLFxUll4uwUGSQ8ZJcIIJyOrAcumO2u+AGbbz4oV3pSNkGEi0YpZdHVZTOZZKj4q
	3RCagRC94ViJ/3RKEKxqyM8YUKcjAmGtzRddXJvI6F8uCCqfIxw85HTl586Derpw
	umTREJ9z9Fjvg9nrRsvEKjGZaweYTgYtAPRlKP2fCQ/BmtU0qIKGakBrCETabZPA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fv4nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 18:13:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Eb6CM019113;
	Tue, 7 Apr 2026 18:13:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9cbe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 18:13:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637IDtX631654428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 18:13:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 212D058055;
	Tue,  7 Apr 2026 18:13:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AD9D58043;
	Tue,  7 Apr 2026 18:13:54 +0000 (GMT)
Received: from [9.61.244.198] (unknown [9.61.244.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 18:13:54 +0000 (GMT)
Message-ID: <4866f6cb-8770-4a21-9b5c-4a9e46009c05@linux.ibm.com>
Date: Tue, 7 Apr 2026 11:13:53 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-6-alifm@linux.ibm.com>
 <20260407095321.6086a080@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260407095321.6086a080@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d54966 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=jbbMZsOuVxTQt3OaBu8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZgnVb0-Wu3uYGp_gjkGyy6dpIv_s-Zee
X-Proofpoint-GUID: ZgnVb0-Wu3uYGp_gjkGyy6dpIv_s-Zee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE2MSBTYWx0ZWRfXwH/dnHjmsmhb
 uecfBePPnO0kmMyAPejaz1Ubdjx0Ypz8QZfDPyXcjrTr0Bf3Jekt7AHRnvJrUuS00NQk5ft0+d+
 tVIPWQ0QTaIbmYg9hOPbnb50qMOCeqJBsrPyTX6AsWqit4fuyks0Zp79+WFuodPaZd6vSTECDKD
 17qr8Ju7DV3BRdCH28a7fXQzfBQwTTUMUymfFXs5eqvtYqF1kHwH5vgy+QjqLLIpO0BChdqAvpe
 fxGM41Cz9vKvhicbEF3OAURJn3ebEqq+2oXry9W7EahNQrV8SRfkFFN9L8D9WN2A/0ee8dqPENG
 w8T2osAOGyW5+gw3m020abLGSLhiIDGuY8/GHZZ/EnajJ0zgvaUaCVtZiFeWbL0oVMBdOCCCDvN
 r1tUOFwMZbNBHNcQwOlzGIOL0/P+1fEeCkgPo4IknFXuShkClAXMln6KrDpZnlJXJvVad8l0LOA
 5Ci2WHfFH3XMRSYCoNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070161


On 4/7/2026 8:53 AM, Alex Williamson wrote:
> On Mon, 30 Mar 2026 10:40:09 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> For zPCI devices, we have platform specific error information. The platform
>> firmware provides this error information to the operating system in an
>> architecture specific mechanism. To enable recovery from userspace for
>> these devices, we want to expose this error information to userspace. Add a
>> new device feature to expose this information.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>   drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 36 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h        | 18 ++++++++++++++++
>>   4 files changed, 65 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index d43745fe4c84..bbdb625e35ef 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1534,6 +1534,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>   		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>   	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>   		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
>> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
>>   	default:
>>   		return -ENOTTY;
>>   	}
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index 27ac280f00b9..647a9e8f348d 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -89,6 +89,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>   				struct vfio_info_cap *caps);
>>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>>   void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>> +			      void __user *arg, size_t argsz);
>>   #else
>>   static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>   					      struct vfio_info_cap *caps)
>> @@ -103,6 +105,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>   
>>   static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>>   {}
>> +
>> +static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
>> +					    u32 flags, void __user *arg,
>> +					    size_t argsz)
>> +{
>> +	return -ENOTTY;
>> +}
>>   #endif
>>   
>>   static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
>> index 0658095ac5b1..0a8663879eee 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -141,6 +141,42 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>   	return ret;
>>   }
>>   
>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>> +			      void __user *arg, size_t argsz)
>> +{
>> +	struct vfio_device_feature_zpci_err err = {};
>> +	struct vfio_pci_core_device *vdev;
>> +	struct zpci_dev *zdev;
>> +	int head = 0;
>> +	int ret;
>> +
>> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(err));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	mutex_lock(&zdev->pending_errs_lock);
>> +	if (zdev->pending_errs.count) {
>> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>> +		err.pec = zdev->pending_errs.err[head].pec;
>> +		zdev->pending_errs.head++;
>> +		zdev->pending_errs.count--;
>> +		err.pending_errors = zdev->pending_errs.count;
>> +	}
>> +	mutex_unlock(&zdev->pending_errs_lock);
> Inconsistent that this isn't a helper exported from the previous patch.

Do you prefer it to be in a helper function? I can move it to a helper 
function.

>
> What's the meaning of err.pec = 0?  Could this be interpreted as an
> error itself?

An err.pec = 0 would indicate there are no pending errors. I don't think 
anything would prevent userspace from doing a VFIO_DEVICE_FEATURE_GET 
even if not nudged by an eventfd?


>
>> +
>> +	err.version = 1;
>> +	if (copy_to_user(arg, &err, sizeof(err)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>   {
>>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index bb7b89330d35..2552eef42000 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1510,6 +1510,24 @@ struct vfio_device_feature_dma_buf {
>>   	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>>   };
>>   
>> +/**
>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>> + * userspace for vfio-pci devices on s390x. On s390x PCI error recovery
>> + * involves platform firmware and notification to operating system is done
>> + * by architecture specific mechanism. Exposing this information to
>> + * userspace allows userspace to take appropriate actions to handle an
>> + * error on the device. The pending_errors provide any additional errors
>> + * pending for the device, and userspace should read until zero.
>> + */
>> +
>> +struct vfio_device_feature_zpci_err {
>> +	__u8 version;
>> +	__u8 pending_errors;
>> +	__u16 pec;
>> +};
>> +
>> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 12
> 12 is used in linux-next by the PRECOPY_INFOv2 feature.  Thanks,
>
> Alex

Ah okay, will update this. I think my next rebase would be on the new 
kernel (7.1) and that should have the conflicting PCI patches.

Thanks

Farhan

>> +
>>   /* -------- API for Type1 VFIO IOMMU -------- */
>>   
>>   /**
