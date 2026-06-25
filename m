Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5D30D3ED;
	Thu, 25 Jun 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424374; cv=none; b=aNcmzz4q/1Aq/enoT1TQTLj0XZtaP2JbdGpiLiNJe4hA1sFiBCX/0A5ihyLBgQE3imho6byHOLxOaPIzn2hF1EtyZElZhvjU7b1JuWTSNJ+uFeNdv18AI4PvYrFtY22vS1pMJme63olIwdEUxukymkDPxKi6UNu/KqukfvE7aEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424374; c=relaxed/simple;
	bh=Z0Gpz2jXfscIWlDRYKXMMrTOt7a2Zcr3bUkhKQE20Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv5VCaa1u6sfnNx7sCR0hfabUrnBYqzumNsflFvSJSsci1WxV5LMNkuIYanZcI9ACNY+ORPREXqgd0QCRm5WneShxrYGmbVlqhVQfn6rZOH79xhjKBqXzDkwl2ozwgRowgWwtQO1s4rr9plA96gki4HpN8RuDpJ5eJ7v2yd8vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S5fdKf/K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S5fdKf/K"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFmNAi381116;
	Thu, 25 Jun 2026 21:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V0RdED
	VbHM3LPva88OVUFIXD9zPoi+IHil6MLzomhyo=; b=S5fdKf/Ksbfpb4agviJA11
	46HXrGt26mhFdKfBpqZTeA6ViLtom/OyZIVc6TT8EsrwAwLm/nsGnkITJTnuH5Aa
	WbINSPR6rw6kO0gUqFupvxtQ5HT97A6B9bD7pt76M7U/YNrjR8tTirrCCUwWYk0S
	A/R4o5C7485OsPfbQJAjsQ2tA2fwHzCTcW/FqMUia0ZkrlYhS/KDGG7KniuHvg4D
	z1lmJnSJBDYTq9UfQxg9PV35J+6s+qNP2T6ucP3201uVicabvft7srXoJ1BUHc0Z
	yYvHGZyNyzxIJNjPxaRqSlhFgkI72os7D26UEY9/JOrLeuzjSO44VjL/zMh79AZw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j41y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 21:52:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PLnh5H004326;
	Thu, 25 Jun 2026 21:52:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qreyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 21:52:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PLqk9830147172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 21:52:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55A875803F;
	Thu, 25 Jun 2026 21:52:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 764705804E;
	Thu, 25 Jun 2026 21:52:45 +0000 (GMT)
Received: from [9.61.243.248] (unknown [9.61.243.248])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 21:52:45 +0000 (GMT)
Message-ID: <f3f7faed-3564-43ab-b117-9d6e96abd62d@linux.ibm.com>
Date: Thu, 25 Jun 2026 14:52:45 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/3] vfio-pci/zdev: Add a device feature for error
 information
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260615183616.2902-1-alifm@linux.ibm.com>
 <20260615183616.2902-3-alifm@linux.ibm.com>
 <20260623150744.08177808@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260623150744.08177808@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ty_5ZYeePwrmLwYX-vcIZLqt085HhemP
X-Proofpoint-GUID: ty_5ZYeePwrmLwYX-vcIZLqt085HhemP
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3da330 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=y--LQT-nAaOemKz3C48A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE4OCBTYWx0ZWRfX6O6LteddjY+J
 ODvjp406azaxAKbWGhnhtOTOj7zunZ8hZEDb4mID8EfiLuDUryFf4Uk/VW1KHmtsLCeXaJHUF+a
 KNIsQFjjCiW/S3oZP7FP4o8aZ8ad382lGykj08q4aP4Uf2AwAixxaRtTVh2PXNAeqUegPosEocB
 bQWR31gpVrRl4wpjB5LTsJ2ayFuRAM0C9mXmDg/tZAX+XZFOkZJvM1CX8tP3TziBc3SSwvdNpeR
 uvhuJwj0hjv+00egyOrfaW8/dN1F+46ySOqHG11BmQnUkOBBHctHcDsO0SPQWe/h9nU8QSsSSFe
 y3k4Ew3UegnbN5FskoA4yit9NSdqRY7xJ7nV7X6kQtIHIsEZbYQQ0IfXsDna2tMiIXQG6Kv9iOW
 ocsqyv/HSavKLDzAbjpVdtu6DegalNZ3B1ML8sfqZ1Bk1/uHhcPKdo1Xfbtm4Q4hDn2bceTv+cn
 fuEOToDy4GnrdkRIBeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE4OCBTYWx0ZWRfXwqZLXDMkiLqc
 yY3/PGy1U7YCIw105rTD7IIfXGJvx2bGhEa3JJAJJOchc98sMO62NhwbAPCVHYyLlGB5KFTNt/B
 cCE/lthD2/GOQV+szJrry7X8j7pnI0M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250188


On 6/23/2026 2:07 PM, Alex Williamson wrote:
> On Mon, 15 Jun 2026 11:36:15 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> For zPCI devices, we have platform specific error information. The platform
>> firmware provides this error information to the operating system in an
>> architecture specific mechanism. To enable recovery from userspace for
>> these devices, we want to expose this error information to userspace. Add a
>> new device feature to expose this information.
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h      |  2 ++
>>   arch/s390/pci/pci_event.c        | 19 ++++++++++++++
>>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>   drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 43 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h        | 30 ++++++++++++++++++++++
>>   6 files changed, 105 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 016386f7ef4a..88a125b92bdd 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -364,6 +364,8 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
>>   int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>>   void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>>   void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
>> +int zpci_get_pending_error(struct zpci_dev *zdev,
>> +			   struct zpci_ccdf_err *ccdf);
>>   
>>   #ifdef CONFIG_NUMA
>>   
>> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
>> index 8934b640a095..3ad16038e005 100644
>> --- a/arch/s390/pci/pci_event.c
>> +++ b/arch/s390/pci/pci_event.c
>> @@ -77,6 +77,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
>>   	return 0;
>>   }
>>   
>> +int zpci_get_pending_error(struct zpci_dev *zdev,
>> +			   struct zpci_ccdf_err *ccdf)
>> +{
>> +	int head = 0;
>> +
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +
>> +	if (!zdev->pending_errs.count)
>> +		return -ENOMSG;
>> +
>> +	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>> +	memcpy(ccdf, &zdev->pending_errs.err[head],
>> +	       sizeof(struct zpci_ccdf_err));
>> +	zdev->pending_errs.head++;
>> +	zdev->pending_errs.count--;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_get_pending_error);
>> +
>>   void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>>   {
>>   	guard(mutex)(&zdev->pending_errs_lock);
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 050e7542952e..27642f10fe97 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1569,6 +1569,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
>> index 78a28db00c6d..c0d6362cc4eb 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -141,6 +141,49 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
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
>> +	ret = zpci_get_pending_error(zdev, &ccdf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	err.fh = ccdf.fh;
>> +	err.fid = ccdf.fid;
>> +	err.ett = ccdf.ett;
>> +	err.mvn = ccdf.mvn;
>> +	err.dmaas = ccdf.dmaas;
>> +	err.q = ccdf.q;
>> +	err.rw = ccdf.rw;
>> +	err.faddr = ccdf.faddr;
>> +	err.pec = ccdf.pec;
>> +
>> +	if (copy_to_user(arg, &err, sizeof(err))) {
>> +		dev_warn_ratelimited(device->dev,
>> +				     "Failed to handle PCI error event for PCI function 0x%x",
>> +				     zdev->fid);
>> +		return -EFAULT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>   {
>>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..83c93193b22d 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
>>    */
>>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>   
>> +/**
>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>> + * userspace for vfio-pci devices on s390. On s390, PCI error recovery
>> + * involves platform firmware and notification to operating systems is done
>> + * by architecture specific mechanism. Exposing this information to
>> + * userspace allows it to take appropriate actions to handle an
>> + * error on the device. The ioctl returns -ENOMSG if there are no pending
>> + * PCI errors.
>> + */
>> +
>> +struct vfio_device_feature_zpci_err {
>> +	__u32 feature_flags;		/* Indicate future features */
>> +	__u32 reserved1;
>> +	__u32 fh;			/* function handle */
>> +	__u32 fid;			/* function id */
>> +	__u64 faddr;                    /* failing address */
>> +	__u32 ett		:  4;	/* expected table type */
>> +	__u32 mvn		: 12;	/* MSI vector number */
>> +	__u32 dmaas		:  8;	/* DMA address space */
>> +	__u32 reserved2		:  6;
>> +	__u32 q			:  1;	/* event qualifier */
>> +	__u32 rw		:  1;	/* read/write */
>> +	__u32 reserved3;
>> +	__u16 reserved4;
>> +	__u16 pec;			/* PCI event code */
>> +	__u8 reserved5[28];		/* Allow for future expansion */
>> +};
> In v18 I probed whether this should be passed as opaque data as we're
> doing for FMB, which was declined because the user doesn't know the
> size.  However, the fmb_length is provided through a device info cap,
> where we could extend the existing zpci info cap with a v3 that does
> report this fixed size.  That doesn't seem like an insurmountable
> barrier.
>
> In the implementation here, we have the worst combination of
> trade-offs, reserved fields for some vague notion of future expansion
> and bitfields that mimic the architecture specification but don't fit
> well into a uAPI as their position is compiler dependent.
>
> This should either fully abandon the architecture layout and create a
> well defined, naturally aligned uAPI structure, or extend the zpci info
> cap to report the size and pass the error data as opaque.

I think it should be doable by extending the zpci info cap and providing 
a size for userspace to provide a buffer. I think making the error data 
opaque makes sense, and it provides a mechanism (along with size) to 
possibly extend the data returned to user. I will look into implementing 
that in the next version.

Thanks

Farhan


> As Bjorn notes, we're already into the merge window, so this is at best
> v7.3 material, and as we've designed the split, merging the vfio
> changes will be dependent on a branch provided with the PCI changes.
> Thanks,
>
> Alex
