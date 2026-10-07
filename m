Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110849D5B5;
	Wed,  7 Oct 2026 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383099; cv=none; b=oNCXZeCikznwkLMaWvEQV/UKomrOCAQQyMvXUkWYgT7Xq/Ofr3dKOCkK/ireH9rG2bYBw/Ksm4d0BsQMT3/U754d1frxImcHSi6YlLVtjrnCnc2lcY8BJdkMrRNMmE9vLQjElE/6u7sm9WaXLTA+gM1SUFhBqmWXw0pMEFlutTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383099; c=relaxed/simple;
	bh=dK7Sn+NSpFgqOgcaioLYd1Lv0GDmZtT8XQDseDKNwWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsNR2UirGA306WIkYTxmweg3+tI3yI2x5X3XUIfrUts9qT47QFlOg416Yk9paHFCbfATfT9+xfRK1ik0pPcLrh4iPvlCcWVOCeMQa6RbZQeiIYlaJnDIl6FuWquigBkcM7gkCcAo5o4Pn3possSMCMZyvC8beb/cTISvmeO8X8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C7aDI1g+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C7aDI1g+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZuSM596907;
	Wed, 7 Oct 2026 14:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zYcbyW
	wQt+GBmUHB8VXp6UZw1quCJmuZFkxV/1UnOJU=; b=C7aDI1g+20x2rYKinDgpxe
	KAGQup6LPm8GiLGJaQbwzBHQp7beyTux9GsBE9N44PD/X/LEl64K8LRtUQ41D7LL
	+fG/C5jFpqLg7jkshizfsB7RCQKuHQmGrddL/e7U6z9sQXk6TYby3jivurDR62t6
	b/4tRwFiWPYHBMyzHygI5Wv+sWw4R5XQK630doliJ15+jFvGNzmEBC+s37ek+Srs
	TIy7potIEvl2iWvDMIVUiLHubz38BaMvStpoDcgnHIuLv6brgll60noZS6UAmE6w
	JNpLwLv8AghUeCJTPr/ldYFB16yNPCQEjmrOc8BrrVBJyxhKoSitVIN2tQabCpiw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrnw2m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:24:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BX7cT1852625;
	Wed, 7 Oct 2026 14:24:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgxvwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:24:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697EOqDZ13173348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 14:24:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B35A58056;
	Wed,  7 Oct 2026 14:24:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A87E58052;
	Wed,  7 Oct 2026 14:24:52 +0000 (GMT)
Received: from [9.61.253.231] (unknown [9.61.253.231])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 14:24:51 +0000 (GMT)
Message-ID: <cecdfa03-3898-4059-a818-762599269531@linux.ibm.com>
Date: Wed, 7 Oct 2026 10:24:51 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] vfio-pci/zdev: Add VFIO FMB device features
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
 <20261007135926.82935-5-oelghoul@linux.ibm.com>
 <sashiko-outbox-163087@kernel.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <sashiko-outbox-163087@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX39Wk4oESuNHn
 ZELGnPxOmfHTEY2egCA4wbDFDCmA1SC4SMNtFDK2cD/O4gKDS9bTDu7nIp73vNE2kveAGxlxcuA
 qPm09DxM8rrtv+KQpj0yd8zReRZfja8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX85OlWzL+hGhH
 ZvNKjZZiHfhXB5W+UHhCAXnpJtEGqZc+qwZUIxx7UKNmylj5hB5ASuO8HLXEOq2cF5mfgHzgmQl
 0wQGXsaC3DA3Jz2ZMb93V+CkkPrGxrd1S5+3bl8e3sRhq9Ijt6D60hga2KFIeyCHXp+sWMgqBhM
 2F2FVBzcO8eC+SRReblITAMk8lsDUUewMuLSUmk6EHu4ZoIv1BWhXhc0CF4XLTd+DVeUddLfcQn
 pdLtt0A/DAoQPQQZtxIr34rnmaCcqMU2eKQpBh+cbIzeM63Z6ws1ThXjSUzANRg1GyCIKA5Pr45
 zBZj06MzW6/EgrfpHhs5U0VwiGchDXOxdba2e9tBXRtoKrh2JrtlG7Q1m6W0bevKCwBizw4518D
 BcK0Mxg+Bh3AmhuNGZHlYJbHw1VSYPYbbgHi4bgNIWnbzftifttGsrF0F9CZOD13cb2JK98fBnY
 SN4kuw49ReqVazdgdFA==
X-Proofpoint-GUID: Wt07SbZWz15TgMF61dj9P45HgwyuHWRf
X-Proofpoint-ORIG-GUID: Wt07SbZWz15TgMF61dj9P45HgwyuHWRf
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac65636 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=za8KfdIVL9pFmLL78OEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070056

On 10/7/26 10:07 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] vfio_pci: NULL pointer deref in fmb_read on fmb allocation failure
> - [High] vfio_pci: stack buffer overflow in fmb_read via unbounded fmb_length
> --
> 
> commit 759143700fb3898fd78661e48f994eff036f8cf5
> Author: Omar Elghoul <oelghoul@linux.ibm.com>
> 
> vfio-pci/zdev: Add VFIO FMB device features
> 
> This commit introduces new VFIO features for zPCI devices to provide FMB
> passthrough to userspace. It allows enabling or disabling the FMB using a SET
> feature, and reading the latest FMB using a GET feature.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
>> index f47f36314a1cc..1a66f455545ab 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> [ ... ]
>> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
>> +				     void __user *arg, size_t argsz)
>> +{
> [ ... ]
>> +	if (fmb_enable.enabled) {
>> +		zdev->fmb_requested = true;
>> +		return zpci_fmb_reenable_device(zdev);
> 
> [Severity: High]
> If zpci_fmb_reenable_device() fails (for example, if kmem_cache_zalloc()
> returns -ENOMEM), does zdev->fmb_requested remain set to true?
> 
> Since the failure doesn't revert the flag to false, could this leave the
> device state inconsistent for future FMB reads?

This flag is intentionally kept true and is documented in patch 2/4 to
track the desired FMB state, which is not necessarily the actual FMB
enablement state in firmware. In hindsight, the liveness check should've
been zdev->fmb_requested && zdev->fmb rather than just one or the other.
The "inconsistent" device state isn't an issue either because the FMB
sample includes a timestamp, so a consumer would know when it's reading
stale data.

> 
> [Severity: High]
> Is it intentional to bypass the zdev->fmb_length bounds check here?
> 
> The standard enablement path typically validates that zdev->fmb_length fits
> within the structure boundaries. By calling zpci_fmb_reenable_device()
> directly, it appears a hardware-supplied length greater than the size of
> struct zpci_fmb could be accepted and saved.

In practice this shouldn't be an issue, but it would've been a good idea
to move the sizeof(*zdev->fmb) < zdev->fmb_length check into
zpci_fmb_reenable_device() as well to prevent this issue from existing
even in theory.

> 
>> +	}
>> +
>> +	return zpci_fmb_disable_device(zdev);
>> +}
>> +
>> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
>> +				   void __user *arg, size_t argsz)
>> +{
>> +	struct zpci_dev *zdev;
>> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
>> +	struct zpci_fmb fmb_bounce;
> [ ... ]
>> +	scoped_guard(mutex, &zdev->fmb_lock) {
>> +		if (!zdev->fmb_requested)
>> +			return -ENOMSG;
>> +		memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
> 
> [Severity: High]
> If a previous call to vfio_pci_zdev_feature_fmb_enable() failed during
> allocation but left zdev->fmb_requested = true, this check will pass.
> 
> Will this result in a NULL pointer dereference when accessing zdev->fmb in
> this memcpy()?

Admittedly I did miss this one, sorry about that. I will address it in
the next iteration.

> 
> [Severity: High]
> Can zdev->fmb_length be larger than sizeof(struct zpci_fmb)?
> 
> If an oversized fmb_length is reported by the hardware or firmware and was not
> validated during enablement, could copying up to that length into the
> fixed-size local stack variable fmb_bounce result in a stack buffer overflow?

See above

> 
>> +	}
>> +
>> +	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb_length))
>> +		return -EFAULT;
>> +	return 0;
>> +}
> 

