Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BFD44F578;
	Wed, 30 Sep 2026 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797248; cv=none; b=sLOqpVVA5lRMY9I3XDYx4Q+1YFtPJoiVdEM7auye+SQBU2QPVNVkvOf+7YRffWuRD2Zkw8cGcIHluWGhC2J90M7viYmFQy70Vk36ux2Sfb6mWSth0a/esrZk4mK61t8DitVUbdgG5/liCrg1+vCjED34xXy0zK2KnFMjctdH8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797248; c=relaxed/simple;
	bh=Gvx+eIlEJMO4lJRlLztCurx1ilu71xFofCZsDsktmxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+wJ0R8cI+r29xMXnR5+476+QtGu52tCY5Qcn7UEJAm4WHDcyVwG73vbYJtl+fWLPWa8OJO/rLQeXcfmNoEX0N/awf65vzf9v5yUxl7prsdVK8iz3pFi44IbZH7ERc//3BxUsQmOIK9NYju93rGDKV7ULg0zph56hSLqf38JvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aaiokfx0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aaiokfx0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UI5l7i3672399;
	Wed, 30 Sep 2026 19:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N6DBFO
	oVzhob+8M+6wL3UHrbDUFJsNvHsPvF+dODOzk=; b=aaiokfx0JdsXV9WUPzLQoH
	Vu3IyynXwUhg1br1QWWMc/5QTZbRuVdVDGSULW0B7mVtmvTLIpdE7U+x3U547I5F
	pw41NbnMu/wHUIcoDoXaH6GZNakZOp/EXi7WAR77aWloAmMOBcpAsego2BakmM5r
	Wkzz+YfcZR0Lvhz2QkbroCWAGDIoG6FfN/z0OPQSI8mJP7SUxxBE7dY+bL4KZCVl
	MvO5R0W2szRNDxszr3SJrWboRKfD3EhLLRuhIu758eDByH0/KK+XLuzaokMx5qJX
	kgNv9TxbZHAQh7DA3bn70bHcoPZFbc7MCbc8PtmPae11FSpDciQ4AR/pRWr9ig8g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pte4y3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 19:40:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHlTYH3874547;
	Wed, 30 Sep 2026 19:40:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23naeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 19:40:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UJegoI55247356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 19:40:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A46458056;
	Wed, 30 Sep 2026 19:40:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B4E95805A;
	Wed, 30 Sep 2026 19:40:41 +0000 (GMT)
Received: from [9.12.71.245] (unknown [9.12.71.245])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 19:40:41 +0000 (GMT)
Message-ID: <53c94059-fe7f-48e9-9588-ee07a40d45de@linux.ibm.com>
Date: Wed, 30 Sep 2026 15:40:40 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] vfio-pci/zdev: Add VFIO FMB device features
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-5-oelghoul@linux.ibm.com>
 <20260930125750.7a5bc3a8@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260930125750.7a5bc3a8@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZX8w0iL79EpCXfNUMH9OAtdv22uGBi00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX9K61GNq1w/d2
 K1cC7KWPy9Ki0g+N6IirGmwTfUC8Y7C+Gcc+MCD0GcD37t2iKzJh0/UBHYBRgn+TBP/7C3dEbpa
 gK28FL2+bOjHnGlHPPkQeiKHV6JvejHO4sj82N9+QQ+X0jwcvUXk+G2wnMBfSRIA3BCwP+0xNex
 i78fEqG9xM00jmNNlTax8/RuaUuIOpDUNChZ25zzT3XvyDN1eUHdCy5EMg0PlgPGZZgP8XOgiHl
 YWCZNZxg/HMYDCNfBbO4eFSsS1xC/CB7P63ls64Lb1xFtB7zR/IaNrXBncyqW4XKKZtxQCYS3r9
 pJrXYWSCnP4O0X+lSMYFE7OWBKewn2W13pvH2ywDdv0q++62QPsv6xPE0tP4GOkoaow1XoovcY+
 acjXybtKbH+cJD8+0y4WMEXWPsdtOAk5GOPpJw46j8QI1lVhlStwBXiPglyIea6FqgxkfNdhwqF
 L/+ZwCpAwdjSV0BHDBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX8AMT/doCTT20
 D0ZofVJzxOSmDXNbG4z71NAVWyM+ykdGEFrbpm7OMZLiDzyfOKcK/lJ6MuSceQ9R/tmeOy9nrL4
 QKST7KbuVpZLbECcCxWCKHxbbJD0miE=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd65bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=e3KBT_1kA633z9Ujvl8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZX8w0iL79EpCXfNUMH9OAtdv22uGBi00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300080

On 9/30/26 2:57 PM, Alex Williamson wrote:
> On Tue, 22 Sep 2026 15:51:41 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> 
>> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
>> userspace.
>>
>> Allow the user to enable or disable the FMB using the SET-only feature
>> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
>> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
>> in the case when the FMB is enabled.
>>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c |  4 +++
>>   drivers/vfio/pci/vfio_pci_priv.h | 18 ++++++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h        | 29 +++++++++++++++
>>   4 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 6757054e9d87..3c827a77725b 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1627,6 +1627,10 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>   		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>>   	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
>>   		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE:
>> +		return vfio_pci_zdev_feature_fmb_enable(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_ZPCI_FMB_READ:
>> +		return vfio_pci_zdev_feature_fmb_read(vdev, flags, arg, argsz);
>>   	default:
>>   		return -ENOTTY;
>>   	}
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index 4e7162234a2e..e04d7e9d0c30 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -95,6 +95,10 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>>   void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
>>   int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>>   			      void __user *arg, size_t argsz);
>> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
>> +				     void __user *arg, size_t argsz);
>> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
>> +				   void __user *arg, size_t argsz);
>>   #else
>>   static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>>   					      struct vfio_info_cap *caps)
>> @@ -116,6 +120,20 @@ static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
>>   {
>>   	return -ENOTTY;
>>   }
>> +
>> +static inline int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev,
>> +						   u32 flags, void __user *arg,
>> +						   size_t argsz)
>> +{
>> +	return -ENOTTY;
>> +}
>> +
>> +static inline int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev,
>> +						 u32 flags, void __user *arg,
>> +						 size_t argsz)
>> +{
>> +	return -ENOTTY;
>> +}
>>   #endif
>>   
>>   static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
>> index f47f36314a1c..b028de8e08a4 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -219,3 +219,63 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
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
>> +	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
>> +		return -EFAULT;
>> +
>> +	guard(mutex)(&zdev->fmb_lock);
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
>> +	struct zpci_fmb fmb_bounce;
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
>> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
>> +		return -EFAULT;
>> +	if (!fmb_read.data)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&zdev->fmb_lock);
>> +	if (!zdev->fmb_enabled) {
>> +		mutex_unlock(&zdev->fmb_lock);
>> +		return -ENOMSG;
>> +	}
>> +
>> +	memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
>> +	mutex_unlock(&zdev->fmb_lock);
> 
> A scoped guard would be preferable for consistency with the enable
> path.

I thought of that too, but then we'd do copy_to_user() while holding the
mutex for longer than is necessary, which I think was pointed out in an
earlier version.

Thanks

> 
>> +
>> +	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb_length))
>> +		return -EFAULT;
>> +	return 0;
>> +}
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index e41437fa17ad..a8d501e42ef9 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1555,6 +1555,35 @@ struct vfio_device_feature_zpci_err {
>>   
>>   #define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
>>   
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
>> + *
>> + * enabled is treated as a bool, so any non-zero value evaluates to true. Nested
>> + * enabling resets the FMB counters to zero, and nested disabling fails.
>> + *
>> + * Returns: 0 on success, -1 and errno set appropriately on error.
>> + */
>> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 14
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
>> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_READ 15
>> +
>> +struct vfio_device_feature_zpci_fmb_read {
>> +	__aligned_u64 data;
>> +};
>> +
> 
> As usual, feature numbers need to be coordinated with the vfio tree.
> What's the merge plan for this?  Thanks,
> 
> Alex

