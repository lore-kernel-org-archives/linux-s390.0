Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCB35E949;
	Mon, 13 Apr 2026 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123660; cv=none; b=R5/nVZdPa3KVXGNdmsao/BcMrYyBRnVW4aAo2xgkRVL1gvmCH6LYXoP3gMtKK7dcolXtZDbY5/Cq4Gl5cff5d5PUpVU0iQOawi6yWfWky08q0+6IDWemgM19YhglujW/n+6yQkyMfunTJPR3+aWTfFCKojaeRdc5vS9FvFDjmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123660; c=relaxed/simple;
	bh=MAiEAcmw9bIasbQc42qB2Mu70OEKB/rRrgqlAtn/oPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8nXebVaekMCEoPaJqtt7MMnb3Es2P+70r4VPwiZnaQg91FmFb6mTK4oM5QoijKMXvwL3WhEq+X8T4DkBXoFg1tLaRPOvFhw+i8jheXHnoorAjuF0pHxHq1AEWwKnDkXZpXd+JyOzhZ8U3VocZEV8fd4CmCdJcwD0qHEpOqWE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YfOZuesJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YfOZuesJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIFHQ1804537;
	Mon, 13 Apr 2026 23:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nRrPRH
	vAx0lYxy3y85QdUpSwvFTrFT9GLgDb39V+ryg=; b=YfOZuesJfiAsviHtCDEZsx
	dWQZfQ0Tk8ul5NS0i1HhKS5KgsvYmPhudJ4j/PiOk1FRZcALTknGcqOqfjDGOYf1
	XZ1yQXGSLjRnlmr8Oji4pUkcil32m3fYhgUMC+oYH6RSdqHbwNqZn4GMPQr9ziiW
	pZgqgb9QzjFN/6TllmDk6SbNp2CDyCbkmkb/CFQPuFfzbSmsaZDfYJSmfIaSxfZI
	Xe0j8Bt5CMnkPC/rgfmZ4yj1Dbft88qey+t0vEovHzyBHu8n9qxA1yndGFxet2+a
	/vNSztpDpuVrgl/WnqmPDEQ9Q3YY4AhpVASgCu14MaEC8Q+zhASDg4QWHa8DqBCA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k0a80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 23:40:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DM0IfU003514;
	Mon, 13 Apr 2026 23:40:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn789c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 23:40:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DNepcG26149574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 23:40:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6769A5805C;
	Mon, 13 Apr 2026 23:40:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B92558054;
	Mon, 13 Apr 2026 23:40:50 +0000 (GMT)
Received: from [9.61.242.98] (unknown [9.61.242.98])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 23:40:50 +0000 (GMT)
Message-ID: <cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
Date: Mon, 13 Apr 2026 16:40:49 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260413210608.2912-1-alifm@linux.ibm.com>
 <20260413210608.2912-6-alifm@linux.ibm.com>
 <20260413165758.0f87312b@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260413165758.0f87312b@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kB3pJ4wLEUyKh3m8mDOvvYKlW5_Xg91H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIyOSBTYWx0ZWRfX8BpfcXUdMbNr
 H20hG91+wZ67yZ2Y+JCdcJMrQMO8NymBcK7wDnlfCOm+TSpFRsMdi8RIPdAzSBT9LKKBJC+8Ocx
 DHCvn6WJdi9U58lPFkBQ1i5o5Oef8P2pvK/GIwylv+h/FnbmCvRL5OzSA2DNdht5ejz90QePV6F
 GqEVE+qbhDBN61jum2aecbwsFs0KnKK4CK/KQbHn7LFftLEo5dWNgRXTk0HiubJmmaLAtdB3j3s
 CDa3BL3KAkz1kKHEvj6RJRFmyCWNpvFAs1Exp01TUoFdkmaTfROva7jvol1iNgDOqpOFON27L4N
 kzZ8LE2GvneJeHkuFEV5xB84LhZUz0D65S4VcI6lm40tP5/HdJzm7MegN/qaY2/unV9h8RaxYOW
 5e3KerYU6DAG41SOG8uqsEEh7tJfrZvBO1MCGnbIQyO4S/0V7Bq+zXijyskEzj3bXxJjCCRvFpu
 wahTmoPissmTAqpKiLQ==
X-Proofpoint-ORIG-GUID: kB3pJ4wLEUyKh3m8mDOvvYKlW5_Xg91H
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69dd7f05 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LI8zkurGpkgCOcO8t2sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604130229


On 4/13/2026 3:57 PM, Alex Williamson wrote:
> On Mon, 13 Apr 2026 14:06:06 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> For zPCI devices, we have platform specific error information. The platform
>> firmware provides this error information to the operating system in an
>> architecture specific mechanism. To enable recovery from userspace for
>> these devices, we want to expose this error information to userspace. Add a
>> new device feature to expose this information.
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h      |  3 +++
>>   arch/s390/pci/pci_event.c        | 19 +++++++++++++++++++
>>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>   drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 31 +++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h        | 20 ++++++++++++++++++++
>>   6 files changed, 84 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 9a6a4eb9d7c1..9c8ee97d7e8a 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -360,6 +360,9 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
>>   int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>>   void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>>   void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
>> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
>> +				      struct zpci_ccdf_err *ccdf,
>> +				      int *count);
>>   
>>   #ifdef CONFIG_NUMA
>>   
>> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
>> index c279a9f50a64..c8714d4a32fa 100644
>> --- a/arch/s390/pci/pci_event.c
>> +++ b/arch/s390/pci/pci_event.c
>> @@ -74,6 +74,25 @@ static void zpci_store_pci_error(struct pci_dev *pdev,
>>   	zdev->pending_errs.count++;
>>   }
>>   
>> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
>> +				      struct zpci_ccdf_err *ccdf,
>> +				      int *count)
>> +{
>> +	int head = 0;
> Unnecessary.  Should also be a blank line between variable declaration
> and code.
>
>> +	*count = 0;
> But why do we zero this and not ccdf?

I had thought of memsetting ccdf to 0, but the only caller right already 
initializes to 0. So didn't think it was needed.


>
>> +
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	if (zdev->pending_errs.count) {
>> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>> +		memcpy(ccdf, &zdev->pending_errs.err[head],
>> +		       sizeof(struct zpci_ccdf_err));
>> +		zdev->pending_errs.head++;
>> +		zdev->pending_errs.count--;
>> +		*count = zdev->pending_errs.count;
>> +	}
>> +}
> You've describe in the uAPI now how pec = 0 means no error, but why not
> remove that ambiguity altogether and return -ENOMSG in that case.  We
> could start here and pass it through:
>
> {
> 	int head;
>
> 	guard(mutex)(&zdev->pending_errs_lock);
>
> 	if (!zdev->pending_errs.count)
> 		return -ENOMSG;
>
> 	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> 	memcpy(ccdf, &zdev->pending_errs.err[head],
> 	       sizeof(struct zpci_ccdf_err));
> 	zdev->pending_errs.head++;
> 	zdev->pending_errs.count--;
> 	*count = zdev->pending_errs.count;
>
> 	return 0;
> }

I had thought of returning an error (ENOENT was what I was going with), 
but perhaps I misunderstood your comment from v12 about specifying pec = 
0 and pending error = 0 as not being an error. My assumption was as this 
is not an error we shouldn't return an error to userspace.


>> +EXPORT_SYMBOL_GPL(zpci_get_pending_error_and_count);
>> +
>>   void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>>   {
>>   	guard(mutex)(&zdev->pending_errs_lock);
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index ad52abc46c04..5403730786a1 100644
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
>> index fca9d0dfac90..4e7162234a2e 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>   				struct vfio_info_cap *caps);
>>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>>   void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>> +			      void __user *arg, size_t argsz);
>>   #else
>>   static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>   					      struct vfio_info_cap *caps)
>> @@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
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
>> index 0658095ac5b1..ee1647f0ffe6 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -141,6 +141,37 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>   	return ret;
>>   }
>>   
>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>> +			      void __user *arg, size_t argsz)
>> +{
>> +	struct vfio_device_feature_zpci_err err = {};
>> +	struct vfio_pci_core_device *vdev;
>> +	struct zpci_ccdf_err ccdf = {};
>> +	struct zpci_dev *zdev;
>> +	int pending_errors = 0;
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
>> +	zpci_get_pending_error_and_count(zdev, &ccdf, &pending_errors);
>> +
>> +	err.version = 1;
>> +	err.pec = ccdf.pec;
>> +	err.pending_errors = pending_errors;
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
>> index 5de618a3a5ee..2980ca39dd38 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
>>    */
>>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>   
>> +/**
>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>> + * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
>> + * involves platform firmware and notification to operating system is done
>> + * by architecture specific mechanism. Exposing this information to
>> + * userspace allows it to take appropriate actions to handle an
>> + * error on the device. The pending_errors provide any additional errors
>> + * pending for the device, and userspace should read until zero. A value of
>> + * 0 for pending_errors and pec would indicate no pending errors that need
>> + * to be handled.
>> + */
>> +
>> +struct vfio_device_feature_zpci_err {
>> +	__u8 version;
>> +	__u8 pending_errors;
>> +	__u16 pec;
>> +};
> I assume .version is for compatibility, but we don't define a strategy
> for using it or specify what the version should be for this table.  It
> doesn't seem like there's actually an value-add to having it.

Its possible we may need to extend this structure in the future if we 
want to report more information to userspace. I at least want the 
flexibility to do so. We had some discussion around this [1] in an 
earlier version. I was trying to follow similar versioning pattern we 
had around vfio-pci/zdev structures.

[1] 
https://lore.kernel.org/all/88289f74-3d4f-4dd9-8f2a-8871d150fd50@linux.ibm.com/

>
> I'm also not clear why we need to report .pending_errors.  It mostly
> seems like another ambiguous feature of this API.  The value seems
> volatile and the suggestion is to read until zero, so why provide the
> value at all, the user can just read until -ENOMSG.

Since we don't explicitly return an error indicating there are no 
available pci errors to handle, was why I added it. Is the preference to 
just return linux error code here?

Thanks

Farhan

>
> At that point, maybe we don't even need a return structure at all,
> return small positive values for pec or -errno.  The internal API could
> match, avoiding the pass by address parameters.  Thanks,
>
> Alex
>
>
>> +
>> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
>> +
>>   /* -------- API for Type1 VFIO IOMMU -------- */
>>   
>>   /**
