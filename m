Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B946AEEF;
	Wed,  3 Jun 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491160; cv=none; b=ULUfdKwh2GtZ9e9AfNLeLZoQIMcbMnxXVivsZzXfmazrmGx1reIYhR95k/MBApya13HPpAHq9kDBusKjTnj9XRc6cW8cZL+/vCEHJDEXLxJmLQYTTAGY1EwXMqGD8DjOtlRac7QjfUKE1dFQ8CnLb3BDA3GxvtaygV5YT/zsP68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491160; c=relaxed/simple;
	bh=uPLcN+Ju/3z/XX+V1gI8t4uaOpReAQGSOL1xFLt/t/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2dv0aOrCCoG8s7cZ1m3G/9lhxSw2YsJ82VXMSkEmCYjOoTOAGgRt6rtcPq3i/NnqnFmHf7D0Qxwuy+TvUxf2AYtf2cscMKe0B83fSU0gK+IOs6ZqLIAH0zO0G/pLvy5EQfSRG3U6TW/bp6asNGEwLW6KuIe9X6S2U0jZ7WG5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pPjbZhQv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pPjbZhQv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6538OBFe1640981;
	Wed, 3 Jun 2026 12:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WAxCMG
	xNQ2t9in4SKBZEVmH7LsIqxmr20UZ3NiqV/0s=; b=pPjbZhQv+fQUyqQhUINBaE
	px9ts7a+e8qnWgkCD5OAKBlO/kkm1jmg6CEqj/2hBFIBd7F8tSujFvw3RtyP1R7w
	RU0oi9QMBstgUw9t2AtBmlCbTY8mNGYiGRin3H0XmvQlz4j8sw4ArW10aJxiXjcC
	eSJ1t2eWS/2n/xGyYos0rUhnN0o0tfPeIf7ftXKkhjTE/+sdje39gO819zcCrOcS
	84QUHiWYQOBfrbA8BDxZ6J3XvHCG8DPWZWk1Al0Zp4EbMc2iKH7iRQrYUrc/4DP+
	R5oXnf1niUOdiVQ/jVEKQ9G/37qiwqIerFw4jP/p+6ZvbgTXMcFOu32jTrQBFF/w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahtju8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 12:52:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653CdE0p026627;
	Wed, 3 Jun 2026 12:52:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qgcsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 12:52:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653CqXHu23659104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 12:52:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB3A95805D;
	Wed,  3 Jun 2026 12:52:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 413E55805C;
	Wed,  3 Jun 2026 12:52:32 +0000 (GMT)
Received: from [9.61.244.94] (unknown [9.61.244.94])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jun 2026 12:52:32 +0000 (GMT)
Message-ID: <85db146f-f254-41d6-a4f2-72f73ae58dfc@linux.ibm.com>
Date: Wed, 3 Jun 2026 08:52:31 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] s390/pci: Preserve FMB state in device
 re-enablement
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        alex@shazbot.org
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
 <20260519224204.19154-2-oelghoul@linux.ibm.com>
 <e79d242ecee2090993538498c6169a999ef96e97.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <e79d242ecee2090993538498c6169a999ef96e97.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyMCBTYWx0ZWRfX6MA5X/s3H8wZ
 ELkMcQbmCML+RuUzEfMFAAitGMcQV6EfGnFh4U6Dp1MKR4+hcv87aSF9ZHCkUmj8ArCimVsCKx4
 ltqRqlcwX4+3mM7gZy7sRFlimIynqmeRq4KB7nT+YjKFhapR7eNrH/y+VH1j91TUDJNLrKTua2q
 r//HfYDs0X2xgXDmzRhxy5uesqU13boBQd9dkX5JVt9d3HwhRqKmV2vD+Mk5+RP89aYReybgEUn
 gXxs/C8tDi0HJFngeVoxI9jTUTKLBpAxUUEZ6yWz/w7PuT3qNC00BB4MhKLCH0SMZNvJXtdZZY4
 T+HZHjK/NRdiQVGlxkBKxO+GKNYjgDMa0W6SU0PEVw11PQo8xnrtw94TboDb8IHXEb6d+BPMXDt
 35T5/xOh1rLvAIxuA4yNyPzAqKMLEmkgQM3RSGeTs+5MccHcgGWjZiftF5t/RkSYAdqyD7tYZnr
 3OjTnejinXgH534mReQ==
X-Proofpoint-ORIG-GUID: L6_ZeGDu_xPAutBa5i8E4qQgkaHM_UJK
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a202394 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Rj30LMQBl44UuUZ7AaYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L6_ZeGDu_xPAutBa5i8E4qQgkaHM_UJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030120

On 6/3/26 6:50 AM, Niklas Schnelle wrote:

> On Tue, 2026-05-19 at 18:42 -0400, Omar Elghoul wrote:
>> Introduce a function zpci_fmb_reenable_device() that checks for the state
>> of the FMB and reuses the same buffer where appropriate. If FMB was not
>                                                               ^ the
Acked
>
>> previously enabled, it enables it for the device. Call this function during
>> a zPCI device re-enablement, which in turn implicitly ensures that the FMB
>> is enabled for host devices during their KVM registration.
>>
>> This function also clears out the software counters, so that a program
>> resetting an FMB would see all its counters restart from zero as expected.
>> The function to clear the software counters is also separated into a static
>> function as it is now reused in both zpci_fmb_enable_device() and
>> zpci_fmb_reenable_device().
> While the commit message starts in the correct imperative voice it then
> drifts to a passive voice in the last sentence. "is also separated
> into…", "it is now reused".
>
> Better:
> "Besides re-enabling the FMB itself in zpci_fmb_reenable_device() also
> clear out the software counters, such that a program resetting an FMB
> sees all counters start from zero as expected. Separate this clearing
> of software counters out into zpci_fmb_clear_iommu_ctrs() and reuse it
> in zpci_fmb_enable_device() and zpci_fmb_reenable_device()."
Noted, I will amend this.
>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h |  1 +
>>   arch/s390/pci/pci.c         | 75 +++++++++++++++++++++++++++++--------
>>   2 files changed, 61 insertions(+), 15 deletions(-)
>>
> --- snip ---
>> +}
>> +
>> +/* Modify PCI: Set PCI function measurement parameters */
>> +int zpci_fmb_enable_device(struct zpci_dev *zdev)
>> +{
>> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>> +	struct zpci_fib fib = {0};
>> +	u8 cc, status;
>> +
>> +	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
>> +		return -EINVAL;
>> +
>> +	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
>> +	if (!zdev->fmb)
>> +		return -ENOMEM;
>> +	WARN_ON((u64) zdev->fmb & 0xf);
>>   
>> +	zpci_fmb_clear_iommu_ctrs(zdev);
>>   
>>   	fib.fmb_addr = virt_to_phys(zdev->fmb);
> I think there is still some potential for sharing the actual enable
> code between zpci_fmb_enable_device() and zpci_fmb_reenable_device()
> e.g. using a static zpci_fmb_do_enable(struct zpci_dev *zdev) helper.
> I think that still makes it clearer what's happening too.
Acked as well, it would definitely be easier to read. Will do in v3.
>
>>   	fib.gd = zdev->gisa;
>> @@ -227,6 +232,41 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
>>   	}
>>   	return cc ? -EIO : 0;
>>   }
>> +EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
>> +
>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>> +{
>> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>> +	struct zpci_fib fib = {0};
>> +	u8 cc, status;
>> +
>> +	lockdep_assert_held(&zdev->fmb_lock);
> Sashiko correctly notes a pre-existing issue in that
> zpci_fmb_enable_device() is called without holding zdev->fmb_lock in
> pcibios_enable_device() and analogously zpci_fmb_disable_device() in
> pcibios_disable_device(). This should also be caught by lockdep if we
> had lockdep_assert_held() was in zpci_fmb_enable_device() respectively
> zpci_fmb_disable_device(). Would you mind adding a minimal fix patch
> for this pre-existing issue in your series? The fix should add the
> locking in the pcibios calls as well as add lockdep_assert_held(). Also
> don't forget a Fixes tag and Cc stable.
Sure thing, I will add a fix patch in v3.

Thanks.
>
>> +
>> +	if (!zdev->fmb)
>> +		return zpci_fmb_enable_device(zdev);
>> +
>> +	fib.gd = zdev->gisa;
>> +	cc = zpci_mod_fc(req, &fib, &status); /* Disable function measurement */
>> +
>> +	/* Unlike in zpci_fmb_disable_device(), cc == 3 is not a valid state here
>> +	 * because we are re-enabling function measurement for the same function
>> +	 * handle.
>> +	 */
>> +	if (cc)
>> +		return -EIO;
>> +
>> +	zpci_fmb_clear_iommu_ctrs(zdev);
>> +
>> +	fib.fmb_addr = virt_to_phys(zdev->fmb);
>> +	cc = zpci_mod_fc(req, &fib, &status); /* Re-enable function measurement */
>> +	if (cc) {
>> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> +		zdev->fmb = NULL;
>> +		return -EIO;
>> +	}
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
>>   
> The change itself makes sense to me.
>
> Thanks,
> Niklas
