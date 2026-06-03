Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5D466B53;
	Wed,  3 Jun 2026 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490153; cv=none; b=SWkxfmHaf6TQ8DxnIMNruO+itQdyW3xIcOIvzbjk5kOJR2IrGcnSFSqug9WJ+1mMQGkcvqe2sYeb9BkUb7AmnZ1594Z7v1VXtEM4xZ3gpmJKy1sNxZoGzIBV6dEulKWGOrEmLYo/jrmS3hkte838PkfVtjzWmYRiI7FriP5AqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490153; c=relaxed/simple;
	bh=9LB5dqjGNQmEwWf3RUkAA5iI+a/DiJyrNPHbZvjp+8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACAUGYR64iXWMRnRKlbx11DaiwH6qjIaz5QOokM2cy86Wq1AXLoGdLDI8jQsiEaO3otBqVRiolrJtHTTRSdxxVFgFB+X6pecYZhWmKs0glLyJKA2wkdiFQ7AbSToNe7wiImCQAwMU2U45t/k2jaAMYMhDf7X0BBdpml2U/nEasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qqvJo1LJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qqvJo1LJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6538xaZ43309410;
	Wed, 3 Jun 2026 12:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N3AR1g
	z9O/tUGi6vL8A3wjLUBGJLyj7XsBejUI23oUw=; b=qqvJo1LJrbI2gqFw2Rp+RE
	yK7Qrg68Tk5gb/U4K/qDV3pHnvk2sT5G8XnVf3zL5yyrvQ8bfVQ2HCfUUd4dqEX9
	8otwaXGkpcjqyQhmRik7SmmJfY5GTRcicwzZM7GFaTtgGT0aCcp1kVHN/mF+rWa2
	HcwSN5KG4wzaLARflLvpnprg4mqmvzOeV+IsSSv/Q1ukRrmIcIGm4lXlvQP61noP
	YASkgZ+D5tCmwOov1C2zjyk0qR5VKDmkm1EiJjP9JyfinBy2hsxRNI0zRC+4x83Z
	SwcgP+pNO+dB1fkdEz9Rs4lrOsqmvoCXF22JFyg+rDlthEEgXPHCnabodGnjDspQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahtg7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 12:35:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653COBYR030752;
	Wed, 3 Jun 2026 12:35:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegqvkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 12:35:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653CZk5C31588908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 12:35:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BB3E5805D;
	Wed,  3 Jun 2026 12:35:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA5D58064;
	Wed,  3 Jun 2026 12:35:44 +0000 (GMT)
Received: from [9.61.244.94] (unknown [9.61.244.94])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jun 2026 12:35:44 +0000 (GMT)
Message-ID: <395b0d85-3057-4bd5-b8cc-10ceea2d978a@linux.ibm.com>
Date: Wed, 3 Jun 2026 08:35:43 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio-pci/zdev: Add VFIO FMB device feature
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
 <20260519224204.19154-3-oelghoul@linux.ibm.com>
 <20260602162409.1ca3c765@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260602162409.1ca3c765@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExNiBTYWx0ZWRfX7UHXkYpFa8/8
 N2460fVI7ghG3OZJ9ACtuO8o/MGiE2XwR2B98UesY6gz2k7HR5gnccZrDcsRwhDbUfMg4Wl57zs
 6n/r4OruIRtLBDowL/en+GgWpQ8xybhzMiqjGthMPolTsfaTK9eUKG/zzwbiHq5AMyFDYIgmey3
 uS6F0iJ2wony2wY7zgBThi3gsxhb1O3n4Y5JBKyTeK93s/6KISIvdG7SYRWUrs14el5GHxq6B+j
 xC20Xu3NDIQ0S3K9Lz7l4+aCXTnOAvLcS7nmGLontlty3YmZI9BIxhNO31DEF72OVjksY5RigYB
 pi/DnzvHIIDSyNF4eUpFul+xEkHhlX7JWZQ2yB3xmEw2Z+eRWdKlLHyn34sCsWJjanj7wzP2Q5c
 XrIlOVHdsJhhg7y7ZfpcLPHgCs3HH1st5t9ReG1r8+F/7MxskSzxhg9LlFoeQnDZQ5GWEdy/77u
 NFKPE2L5QHvUmOm3HMQ==
X-Proofpoint-ORIG-GUID: oL2kytOQ2EZoJ0BAfkuyxkn-_whsK8_6
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a201fa4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KpnDc4kbIwCV01XF7HUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oL2kytOQ2EZoJ0BAfkuyxkn-_whsK8_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030116

On 6/2/26 6:24 PM, Alex Williamson wrote:

> On Tue, 19 May 2026 18:42:03 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
>> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
>> index 0990fdb146b7..1e9efe2bee69 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -167,3 +167,80 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>>   	if (zpci_kvm_hook.kvm_unregister)
>>   		zpci_kvm_hook.kvm_unregister(zdev);
>>   }
>> +
>> +int vfio_pci_zdev_feature_fmb(struct vfio_pci_core_device *vdev, u32 flags,
>> +			      void __user *arg, size_t argsz)
>> +{
>> +	struct zpci_dev *zdev;
>> +	struct vfio_device_feature_zpci_fmb fmb = {0};
>> +	u32 ops = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET;
> Somewhat gratuitous variable usage.
Acked, will remove in v3.
>
>> +	int ret;
>> +
>> +	ret = vfio_check_feature(flags, argsz, ops, sizeof(fmb));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&zdev->fmb_lock);
> Use a guard and avoid the release_lock gotos.
Acked as well
>
>> +	if (flags & VFIO_DEVICE_FEATURE_SET) {
>> +		if (copy_from_user(&fmb, arg, sizeof(fmb))) {
>> +			ret = -EFAULT;
>> +			goto release_lock;
>> +		}
>> +
>> +		if (fmb.flags & VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED)
>> +			ret = zpci_fmb_reenable_device(zdev);
>> +		else
>> +			ret = zpci_fmb_disable_device(zdev);
>> +		goto release_lock;
> Remaining flag bits are not tested, breaks any future expanded use of
> flags.
Oversight on my part, I will fix this.
>
> Why does the user need to be able to control these?
We want the user (e.g. QEMU) to be able to control these so that when a
guest enables or disables the FMB, this state gets cascaded to the host and
all the way to the firmware.
>
> Doesn't allowing the user to disable FMB remove guaranteed host-based
> monitoring?
Yes it does, but this one isn't an oversight and is intentional behavior
to achieve the functionality mentioned above. The host-based monitoring is
not necessarily guaranteed and is treated as a device-specific state, so it
makes sense in the case of passthrough to have that state reflect the state
of the guest that is actually using the device.
>
> Since this is already provided via debugfs, why not make this a
> userspace problem to interact with the existing interface?
It might be possible but it would undoubtedly be really ugly and harder to
maintain. I think what we'd dislike most about using debugfs is parsing
text data into the FMB structure. If any of the text representations of the
fields were to change, we would need to update them anywhere that uses them
(e.g., in QEMU or any other user driver). The ABI would be super fragile.
>
> Alternatively, couldn't the existing zpci mediation be extended to
> support the guest registering a fmb buffer to be written at regular
> intervals (the interface here seems to drop the reporting interval).
The firmware only writes the FMB into one buffer every firmware-specified
interval. If we wanted to write the FMB directly into guest memory, we
would either 1) lose host access to the FMB or 2) have to run a periodic
worker in the kernel to copy the host FMB into the guest-provided buffer
every time the firmware does an update. I don't believe either of these
approaches are favorable.

WRT reporting interval, I intentionally dropped that one as it is already
provided by VFIO_DEVICE_INFO_CAP_ZPCI_GROUP.
>
>> +	}
>> +
>> +	ret = 0;
>> +	if (zdev->fmb) {
>> +		fmb.flags |= VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
>> +	} else {
>> +		fmb.flags &= ~VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
>> +		goto release_lock;
>> +	}
> Flag bit is cleared, goto skips copy-to-user, returns success...
I don't know how I missed this one... I'll fix it or remove it entirely by
using the guard like you suggested earlier.
>
> Regardless of what's documented in the header, the buffer should be
> assumed to be userspace garbage.  Failing to set or clear the entire
> flags field precludes any future use.
Acked.
>
> Why do we need to use flags to indicate the enable state?  Couldn't we
> just as easily have success indicate enabled and -ENOMSG indicate
> disabled?  Thanks,
Good point, I had not previously considered using -ENOMSG. It makes sense
and would for sure simplify this feature.

Thanks.
>
> Alex
