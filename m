Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B273A7F40;
	Tue,  2 Jun 2026 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436347; cv=none; b=pKHWNZRacwL2YhKVd0qKZuU6mP1CVtg3ZUkJs5YRNEMDkOHcoG1zTtSPiNNtfBmgJ8KbTzzQooLvswwRRxFmUXlmtGQVTx4uBuHNNHx7kALEMYMXAMG0aWvJgDDjGA6kjzmP/1c33Lg7ehDuroT53tA1PJseDuo7z+g2KMtePCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436347; c=relaxed/simple;
	bh=Thawo5EVJPBQQZBDlv12MGpumeYPQEhw6IrKqGeYdSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIEqauzBFw1Uf8QLyRS/sDhPXcmW2/4wbfpj9osmDO5y3zp1EAyzfUItFmQvOO47O4AsQf/zDvmKouRy+9twqXaDqFJ32hxbqnpOFuBxFj1rHdh5dZzbUWAQGiIPM0xIIWXw1Vsgd3f1lSNS86/kT1EsrmKDWFmWpiOS13/1tRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OHN9FWRp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OHN9FWRp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652KeB8t2386944;
	Tue, 2 Jun 2026 21:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QySHnO
	ZE758w6JZq8bd2B9c49LnptW/4kYvCb1t8DDI=; b=OHN9FWRp5BB5xs6LbtytGr
	oVz1uXNMzuBdlubg+oyPwZ2gjCMulH7V6o48BwD9IIB8NJgwTryo48hhug3FxP3x
	j8LALWzYKMdK5Y4O0mMUQChv+tBrr63tLlvdMWv+37z3MMcNo/BYWsLAPKHEUH99
	rQd/QkJ9BnhJjDUWz33ONtETkoUvtza71Jl0foDzn0/f5A/a8mIVuUvi6HcfaaUr
	DzuAdfcmn0dLdjJjVkshKk+rdgj4kQiZQ6kStU7eEHzpLBtXEzJKwNuE90heD1EI
	ZeNkccm9gGHP8Z9Q9W3dVPm19py8Qxp7FBsb6D+ZbXjDs++tLYs/iK44xsaVm9mQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd484vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 21:39:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652LODpV004823;
	Tue, 2 Jun 2026 21:39:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegn1pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 21:39:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652Lcwul39060120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 21:38:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72B7758051;
	Tue,  2 Jun 2026 21:38:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A605805A;
	Tue,  2 Jun 2026 21:38:57 +0000 (GMT)
Received: from [9.61.249.141] (unknown [9.61.249.141])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 21:38:57 +0000 (GMT)
Message-ID: <a35f1171-eaad-4b5b-a85f-dfb64dbc6454@linux.ibm.com>
Date: Tue, 2 Jun 2026 14:38:56 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260520171113.1111-1-alifm@linux.ibm.com>
 <20260520171113.1111-6-alifm@linux.ibm.com>
 <20260602143202.6395e9e2@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260602143202.6395e9e2@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIxMCBTYWx0ZWRfXz8r/gaSk6aVB
 F+b+S2YkballFBoaVQ6COvsSzjpFhToTP0WTpqDFWv+RqGAXTDq+4vVNuWN0g/Tpb69OfdEG0iU
 mwz7qiYxpSPlMVQKJnQASOjfb0R10BCO4BGg/S6csm3prDstB0qIOysBCFgjG3a69Ve2QgtPLta
 Kg4XVi3JndFA2T1ScLbfJxse8EO1GXuvXDgTVRIrl/kNJS/CEjm6B0nEcRmPyq09Hw2EL6XDNY0
 4OGysGrR3Gl1vEQMaif/cNSjMvLQHAooo2TwfdZIHsvbbrS7SlkluHGpZp4jroED6iSQ8NpFOvV
 NDZ7YcepT4/WdTD6Ha4VOZi1EdS92daIRrpnqOsQW/fE6AqbRjafvXNGQ2JIq3T78PkuKFpVm4U
 GzmzdZhZEoStR7w7nuGINHkyv3FKWNd3a7KOXc1fDBnxeKn/1yYgJKHa3MxQMEfXc7ozpHcABVU
 Nv+FW1Q1Z4bzt0w+bLw==
X-Proofpoint-GUID: U_7TgJ7qY5rVqdiFGn4niH1FMOs95q5l
X-Proofpoint-ORIG-GUID: U_7TgJ7qY5rVqdiFGn4niH1FMOs95q5l
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1f4d75 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=y--LQT-nAaOemKz3C48A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020210


On 6/2/2026 1:32 PM, Alex Williamson wrote:
> On Wed, 20 May 2026 10:11:11 -0700
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
>>   arch/s390/pci/pci_event.c        | 19 ++++++++++++++++
>>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>   drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h        | 30 ++++++++++++++++++++++++
>>   6 files changed, 101 insertions(+)
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
>> index cf2ffa21ab8c..db1b44baf8fa 100644
>> --- a/arch/s390/pci/pci_event.c
>> +++ b/arch/s390/pci/pci_event.c
>> @@ -75,6 +75,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
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
>> index 78a28db00c6d..cc148123a97b 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -141,6 +141,45 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
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
>> +	if (copy_to_user(arg, &err, sizeof(err)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
> There's a concern here that the error is dequeued but we can still fail
> resulting in a lost error.  Is that a sufficiently unlikely scenario to
> ignore or should it at least be documented?

IMHO this scenario would be unlikely and could be ignored. I think to 
handle this we would need something like a peek() API and only remove 
and update the pending_errs if copy_to_user succeeds. This would be 
adding more complexity for a relatively low possibility of failure.


>
>> +
>>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>   {
>>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..3eead86a00ab 100644
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
>> +	__u32 ett		:  4;	/* expected table type */
>> +	__u32 mvn		: 12;	/* MSI vector number */
>> +	__u32 dmaas		:  8;	/* DMA address space */
>> +	__u32 reserved2		:  6;
>> +	__u32 q			:  1;	/* event qualifier */
>> +	__u32 rw		:  1;	/* read/write */
>> +	__u64 faddr;			/* failing address */
>> +	__u32 reserved3;
>> +	__u16 reserved4;
>> +	__u16 pec;			/* PCI event code */
>> +	__u8 reserved5[28];		/* Allow for future expansion */
>> +};
>> +
>> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
>> +
> There are currently at least 4 different patch series, including this
> one, that are vying for device feature allocations.  This series spans
> PCI, s390, and vfio, and I'm not entirely sure which maintainer should
> take it.  With Niklas' review on patch 4, should we ask Bjorn to take
> 1-3 through PCI, share a branch, and I could merge 4-7 through vfio?
> Thanks,
>
> Alex

If it helps I can break the series into PCI only and vfio only patches. 
Please let me know if there is anything I can help with to make the 
merge easier.

Thanks

Farhan

