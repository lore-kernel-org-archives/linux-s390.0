Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3040DFC3;
	Tue, 14 Apr 2026 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186813; cv=none; b=aK9RId/cNbkOzPFdoT8icsWQWQgHUl/nDXL3UH3lOShNof+s8714KMCZIGf/pbtvGiTT5mGiLNTVX0TFjLt1RD6hj8bK0/IcoA/6FGpPP/lBWvFynztl0dM4adWGVqP1qA0OpoWg7ovMMIWdEajGRD6mM/qtjw+Ch1xQrdJuTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186813; c=relaxed/simple;
	bh=JIs3S8VJmzGgcEtg/fL5H1IJoqYEvBQtZcGWw35xduc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NplehN99S4wYxTwrY0EmMAQYgtWi4da732Z8izLcCFiwGlj9rFsNimgcFTSPK0ufxtOb51J7cvjDRBXHw2njwawd9exHRkdbDfLuYNy3bt7il4DohtwZBkaxPdzQDpALXMJSjDQSh7HQf+QbfGhuJLNV3xx3AA+0NvW9i+wjVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STpB5DRA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STpB5DRA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EES5Su2130784;
	Tue, 14 Apr 2026 17:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ttdH+t
	hrBHwcVWodbjtWfYyN1VUGbaMvuy2Q/IkdChE=; b=STpB5DRAJuJE/jUbCrvZ+p
	kfJ81bywWmr+G6oElSGPWV+5Qr7C/W1/aoLJ7erPCCDOZ8xpoRwYV3kjiQ66oQat
	f51bUGy2Ta6Hrc3h0ZyQKQFDbs/1AtSDvVYuJJl3LUX0rm4QBf4gkmGgOwTisYy7
	XxxnqjrkDiyufaDO2AxXYX1RAeIkik0NUYKTwax0b58VQ/BlBAaju/d8lzE3Qykt
	VKrfrGSNFW41os0SDHP7T3/SYpx5a1tUu1I3bpFiaQisd3YfdIoAv8JTSiVE0KI7
	OofH11OCpOgCV6bp5QgixjfHcAcLpsjdZg1SYYmYjbBIyw8gGg1JMo71Kz4joI1Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nc1j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 17:13:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EGxrGu031854;
	Tue, 14 Apr 2026 17:13:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10yaqpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 17:13:24 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EHDNne32178846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 17:13:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EA6058068;
	Tue, 14 Apr 2026 17:13:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F4A958052;
	Tue, 14 Apr 2026 17:13:22 +0000 (GMT)
Received: from [9.61.240.138] (unknown [9.61.240.138])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 17:13:22 +0000 (GMT)
Message-ID: <5f26af4c-9584-4c70-9702-0a3bcd0c4ad1@linux.ibm.com>
Date: Tue, 14 Apr 2026 10:13:22 -0700
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
 <cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
 <20260414081238.23e2cecc@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260414081238.23e2cecc@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 01iS5vQT8wITVg0m5U5jguN7VnKMHDiu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE1NyBTYWx0ZWRfXyRjflQ0PREqg
 ztLZMgld3FAUhRi8uPByT2oJ7/3BKsacUTGFkNOZsJDVRWqS2IzTDeXHuJeuzmOXN1CPiuGlVVA
 rWbOyvy8kjuvO0YZS/K6B/+srEkiom9/Duf3+54LQZIb9XbTHU9RwWCWY27TN5jEM+g3gD5tYLc
 vKhu3TY0MSbTX3+XbqY5md9+wPDkdMv5WeLrShYkKaIqN6jhQN2m1znuJoUUFIfPfON7WAzEOlz
 A4vq4ped8C8ZNtq8m5l2lLZMWm5JOKyGAMTX0SfaqVmloU9KAt9Iy5jtSnhoc5l5FfXqbVYx8YE
 qO515Cb8PfTKKBPaHl7o0i1ZQF8xCxp/tOp/JWvAaPmOeR2Cipf55c6qMRvAALmW2UddqLBROfv
 6ckw74QYalq+nZpiWxlTxjYM4vXwugtnqRwIYtVTkE1ND/JQoaprjYcXOAZYgUL8pWgio+qGBLc
 IUW6+vzAxR7jH58uNfQ==
X-Proofpoint-ORIG-GUID: 01iS5vQT8wITVg0m5U5jguN7VnKMHDiu
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69de75b5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=zt6kzwg4mn7V0aSmamUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140157


On 4/14/2026 7:12 AM, Alex Williamson wrote:
> On Mon, 13 Apr 2026 16:40:49 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On 4/13/2026 3:57 PM, Alex Williamson wrote:
>>> On Mon, 13 Apr 2026 14:06:06 -0700
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>   
>>>> For zPCI devices, we have platform specific error information. The platform
>>>> firmware provides this error information to the operating system in an
>>>> architecture specific mechanism. To enable recovery from userspace for
>>>> these devices, we want to expose this error information to userspace. Add a
>>>> new device feature to expose this information.
>>>>
>>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    arch/s390/include/asm/pci.h      |  3 +++
>>>>    arch/s390/pci/pci_event.c        | 19 +++++++++++++++++++
>>>>    drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>>>    drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++++
>>>>    drivers/vfio/pci/vfio_pci_zdev.c | 31 +++++++++++++++++++++++++++++++
>>>>    include/uapi/linux/vfio.h        | 20 ++++++++++++++++++++
>>>>    6 files changed, 84 insertions(+)
>>>>
>>>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>>>> index 9a6a4eb9d7c1..9c8ee97d7e8a 100644
>>>> --- a/arch/s390/include/asm/pci.h
>>>> +++ b/arch/s390/include/asm/pci.h
>>>> @@ -360,6 +360,9 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
>>>>    int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>>>>    void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>>>>    void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
>>>> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
>>>> +				      struct zpci_ccdf_err *ccdf,
>>>> +				      int *count);
>>>>    
>>>>    #ifdef CONFIG_NUMA
>>>>    
>>>> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
>>>> index c279a9f50a64..c8714d4a32fa 100644
>>>> --- a/arch/s390/pci/pci_event.c
>>>> +++ b/arch/s390/pci/pci_event.c
>>>> @@ -74,6 +74,25 @@ static void zpci_store_pci_error(struct pci_dev *pdev,
>>>>    	zdev->pending_errs.count++;
>>>>    }
>>>>    
>>>> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
>>>> +				      struct zpci_ccdf_err *ccdf,
>>>> +				      int *count)
>>>> +{
>>>> +	int head = 0;
>>> Unnecessary.  Should also be a blank line between variable declaration
>>> and code.
>>>   
>>>> +	*count = 0;
>>> But why do we zero this and not ccdf?
>> I had thought of memsetting ccdf to 0, but the only caller right already
>> initializes to 0. So didn't think it was needed.
> The caller initializes count as well.
>
>>>> +
>>>> +	guard(mutex)(&zdev->pending_errs_lock);
>>>> +	if (zdev->pending_errs.count) {
>>>> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>>>> +		memcpy(ccdf, &zdev->pending_errs.err[head],
>>>> +		       sizeof(struct zpci_ccdf_err));
>>>> +		zdev->pending_errs.head++;
>>>> +		zdev->pending_errs.count--;
>>>> +		*count = zdev->pending_errs.count;
>>>> +	}
>>>> +}
>>> You've describe in the uAPI now how pec = 0 means no error, but why not
>>> remove that ambiguity altogether and return -ENOMSG in that case.  We
>>> could start here and pass it through:
>>>
>>> {
>>> 	int head;
>>>
>>> 	guard(mutex)(&zdev->pending_errs_lock);
>>>
>>> 	if (!zdev->pending_errs.count)
>>> 		return -ENOMSG;
>>>
>>> 	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>>> 	memcpy(ccdf, &zdev->pending_errs.err[head],
>>> 	       sizeof(struct zpci_ccdf_err));
>>> 	zdev->pending_errs.head++;
>>> 	zdev->pending_errs.count--;
>>> 	*count = zdev->pending_errs.count;
>>>
>>> 	return 0;
>>> }
>> I had thought of returning an error (ENOENT was what I was going with),
>> but perhaps I misunderstood your comment from v12 about specifying pec =
>> 0 and pending error = 0 as not being an error. My assumption was as this
>> is not an error we shouldn't return an error to userspace.
> I think I was trying to get clarity on how 0/0 is interpreted because
> it seems like a weak point of the uAPI.  We could make a more intuitive
> uAPI if we make the "I have no message of desired type" response an
> explicit, unique errno, rather than a reserved pec value.
>
>>>> +EXPORT_SYMBOL_GPL(zpci_get_pending_error_and_count);
>>>> +
>>>>    void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>>>>    {
>>>>    	guard(mutex)(&zdev->pending_errs_lock);
>>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>>>> index ad52abc46c04..5403730786a1 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_core.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>>>> @@ -1534,6 +1534,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>>>    		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>>>    	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>>>    		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>>>> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
>>>> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
>>>>    	default:
>>>>    		return -ENOTTY;
>>>>    	}
>>>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>>>> index fca9d0dfac90..4e7162234a2e 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>>>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>>>> @@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>>>    				struct vfio_info_cap *caps);
>>>>    int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>>>>    void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
>>>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>>>> +			      void __user *arg, size_t argsz);
>>>>    #else
>>>>    static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>>>    					      struct vfio_info_cap *caps)
>>>> @@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>>>    
>>>>    static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>>>>    {}
>>>> +
>>>> +static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
>>>> +					    u32 flags, void __user *arg,
>>>> +					    size_t argsz)
>>>> +{
>>>> +	return -ENOTTY;
>>>> +}
>>>>    #endif
>>>>    
>>>>    static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>>>> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
>>>> index 0658095ac5b1..ee1647f0ffe6 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>>>> @@ -141,6 +141,37 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>>>    	return ret;
>>>>    }
>>>>    
>>>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>>>> +			      void __user *arg, size_t argsz)
>>>> +{
>>>> +	struct vfio_device_feature_zpci_err err = {};
>>>> +	struct vfio_pci_core_device *vdev;
>>>> +	struct zpci_ccdf_err ccdf = {};
>>>> +	struct zpci_dev *zdev;
>>>> +	int pending_errors = 0;
>>>> +	int ret;
>>>> +
>>>> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>>>> +	zdev = to_zpci(vdev->pdev);
>>>> +	if (!zdev)
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>>>> +				 sizeof(err));
>>>> +	if (ret != 1)
>>>> +		return ret;
>>>> +
>>>> +	zpci_get_pending_error_and_count(zdev, &ccdf, &pending_errors);
>>>> +
>>>> +	err.version = 1;
>>>> +	err.pec = ccdf.pec;
>>>> +	err.pending_errors = pending_errors;
>>>> +	if (copy_to_user(arg, &err, sizeof(err)))
>>>> +		return -EFAULT;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>>>    {
>>>>    	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>> index 5de618a3a5ee..2980ca39dd38 100644
>>>> --- a/include/uapi/linux/vfio.h
>>>> +++ b/include/uapi/linux/vfio.h
>>>> @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
>>>>     */
>>>>    #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>>>    
>>>> +/**
>>>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>>>> + * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
>>>> + * involves platform firmware and notification to operating system is done
>>>> + * by architecture specific mechanism. Exposing this information to
>>>> + * userspace allows it to take appropriate actions to handle an
>>>> + * error on the device. The pending_errors provide any additional errors
>>>> + * pending for the device, and userspace should read until zero. A value of
>>>> + * 0 for pending_errors and pec would indicate no pending errors that need
>>>> + * to be handled.
>>>> + */
>>>> +
>>>> +struct vfio_device_feature_zpci_err {
>>>> +	__u8 version;
>>>> +	__u8 pending_errors;
>>>> +	__u16 pec;
>>>> +};
>>> I assume .version is for compatibility, but we don't define a strategy
>>> for using it or specify what the version should be for this table.  It
>>> doesn't seem like there's actually an value-add to having it.
>> Its possible we may need to extend this structure in the future if we
>> want to report more information to userspace. I at least want the
>> flexibility to do so. We had some discussion around this [1] in an
>> earlier version. I was trying to follow similar versioning pattern we
>> had around vfio-pci/zdev structures.
> IMHO, the version field is a dead end towards achieving this,
> especially if we don't specify from the onset the expected version
> value or the compatibility semantics.  All that's going to happen is
> that some userspace will hard code that it understands version 1
> because that's what's currently reported and matches the struct defined
> here, and you can never ever report anything other than version 1
> without breaking that user.  At that point you need to come up with
> some other means for the user to opt-in to a new version, whether it's
> triggered by another feature (as we did with the PRECOPY_INFOv2 above
> this), or we reimplement the whole v2 feature.

My understanding was based on how we version some of the capability 
structures for zdev (in include/uapi/linux/vfio_zdev.h). If we wanted to 
provide more information to userspace in the future, what would be 
preferred approach? Do we need to explicitly define a v2 feature? I am 
open to suggestions on this.

If we need to define v2 explicitly in the future, then yes I agree we 
can simplify it to return only the PEC code (or an error code otherwise).

Thanks

Farhan

