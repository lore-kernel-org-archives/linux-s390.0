Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11F4F85B0;
	Thu, 17 Sep 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663149; cv=none; b=i+C+HNZA+XqWrT1bzyJHwXIyH5glGtD9orREXm6nQYOMj6B8kuF8LMnQtsICNVOa330GeTMbrKeJ5n9jm6avh2eM2JZW2NqJxocD5Nbos29TckNII+FWs8oMtzYO8EF2mFbTEGTCwaXF2NSD41jvwBjKcHsedfWnlXonhFOHoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663149; c=relaxed/simple;
	bh=uVYDKMQ/OAC28IZRtd6CZKrKe8EBa0w3jutt2qowyi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO28snnXx8g1jMoD1yp18VJ7hmhugBEWtumtbropZ0AXbWqKoaDA9fxj0T8sFoT5uV6G0psHmNAlQkTO/WYfOMsC0oQaL1JPv6CsO8n5PP/P6AL7ugUSG2YgmBpkMTkukwtwxdhZv42zKLcr+5A6NQwx7tUYEKsPTNwlo5Ve7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjlFhjzq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjlFhjzq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HE1RIh2710637;
	Thu, 17 Sep 2026 16:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8RA2qn
	zzrS7kRZVRYKA6kRl874/PzAtTz3F0PTmD5LI=; b=IjlFhjzqX686bAhjc4wR4T
	rUjl/wRvdaSL/Ah5lvNOZWzHSq45UZGNZIa0TcMB/kYot02YwH3L4Njk9WCKaV+E
	bKGMs+YmOOa1LMNqqtANm7YhT9+ctn2NMn41eX380yaL3j9KPrnhRnsT58HYCEq2
	YcPFC52K7qqstvK/9MZjrcNwOu2nCMfLDHz/iDiuKj2lQe8djPG/AztBpPu5r9Nc
	ZJt8FhYjDO5qRSHJRA/Y1xvswzl6C8y/bAo9dwd5FA0TeQxK1l2b4TT72ociIDQe
	QBje1odFoFIWjpBvb60aCXSN1/+kWXTRPQIxdDiDqLc4NBhgIUFxmUrfP5eamIkw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5bmdg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 16:39:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDa1Wp3208141;
	Thu, 17 Sep 2026 16:39:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa372w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 16:39:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HGd26m19399332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 16:39:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599AF5808F;
	Thu, 17 Sep 2026 16:39:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E170158083;
	Thu, 17 Sep 2026 16:39:00 +0000 (GMT)
Received: from [9.61.247.238] (unknown [9.61.247.238])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 16:39:00 +0000 (GMT)
Message-ID: <f826f068-b716-4cff-8c3d-620790db58c5@linux.ibm.com>
Date: Thu, 17 Sep 2026 12:38:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-3-oelghoul@linux.ibm.com>
 <099b4e3f-4156-42e4-a2e9-bdc715547bef@linux.ibm.com>
 <85cb647d-b1c8-4804-b206-2cae1e03e20d@linux.ibm.com>
 <dae3c7cd-21aa-4263-bec5-792b018d21e2@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <dae3c7cd-21aa-4263-bec5-792b018d21e2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ayvh7cBEJKGg5YAixQ3Fs48BxxMWQLfD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIzNSBTYWx0ZWRfXy7+2tOP5ZJ2y
 QdNuoiAVa5v3OCZJBnLrCA64JJXP3HRKzEgqshqS2OQBPhySknM5kWm4A4WMrUSXUVpMCu+snfv
 DqhychDWwASNYE7nUpsc+D3iI0MfYoI=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aac17a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=eUsDoICE4VMyY97GcngA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ayvh7cBEJKGg5YAixQ3Fs48BxxMWQLfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIzNSBTYWx0ZWRfX0/tL80MHUpnK
 JC8TlK/ZIHA97fhzPXnEpJOKRowQbtF6zJxRNy8s0YgYVQnBdLmMVfGobH+ZneStwooEtVBxJwg
 qNtO++6mp6qTCb8oskBF1t+lgw2er+s9wwJTt0lUl/tmKHNNcKaA8Y3fZKaVaczwXe3oOAlZpVe
 l7xY/ijo/WlzCzwn+rBVCV+PNyUyiftkMnINgc5qaK6qMloPqNaIuwkTWid2HeONuDJ7zpC32V5
 ZlFkG8XOqnA8FwDf5ll15U5fkLNRgfwFooub8KAhMrvJjlGphj6fUnjJn+Mml63bzJIRL8VpHtf
 8E/mXUe/Kb+FAaeFXhJl1wwMMsZX0vP3le2fehvuc9kCEMbRgGEbNfsm8frDqgMKfRPB0R970QK
 NQY+nkd0enck/8YhgpU8+D3mK5l3nJgEyFOInZQ7RdrjpBgQbWjA8QxEMSBNFx5dlHh2AjmfaRf
 8HJOf5B4lBTMyDMUhqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170235

On 9/17/26 11:28 AM, Matthew Rosato wrote:
> On 9/17/26 9:32 AM, Omar Elghoul wrote:
>> On 9/16/26 10:21 PM, Matthew Rosato wrote:
>>>
>>>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>>>> +{
>>>> +    u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>>>> +    struct zpci_fib fib = {0};
>>>> +    u8 cc, status;
>>>> +
>>>> +    lockdep_assert_held(&zdev->fmb_lock);
>>>> +
>>>> +    if (!zdev->fmb_enabled)
>>>> +        return zpci_fmb_enable_device(zdev);
>>>
>>> Sashiko has a point here, won't all paths that call zpci_reenable_device
>>> now unconditionally turn on FMB here even if it was purposely disabled?
>>>
>>> The pattern of callers for zpci_reenable_device() is:
>>>
>>> zpci_disable_device()
>>> ...
>>> zpci_reenable_device()
>>>
>>> We only care to re-enable the FMB during device re-enable if the device
>>> had FMB enabled at the time zpci_disable_device() was called.
>>
>> The way I thought of it was pcibios_enable_device() already enables
>> measurement, so we might as well ensure it is enabled when the zdev is
> 
> Yes, FMB starts enabled by default but then it could be disabled
> intentionally via sysfs; if a recovery action occurs on the device
> sometime after I manually disabled FMB for a device, I'd expect it to
> still be disabled after the recovery action but AFAICT with this
> codepath it will always get re-enabled.
> 
> Completely removing the device and re-introducing it to the system is a
> different matter; in that case yeah we'd be back to FMB-enabled because
> that's our default starting state via pcibios_enable_device().

Makes sense, I will fix this in the next version.

> 
>> re-enabled. That default state is also helpful for the later patches
>> because kvm_s390_pci_register_kvm() calls zpci_reenable_device().
>>
>> But I guess if we didn't want to conflate the two, we could also add an
>> unconditional zpci_fmb_reenable_device() within the KVM register hook,
>> to run after the zpci_reenable_device(), whichever you'd prefer.
> 
> Do we even want it to be part of the KVM register hook at all, or could
> we leave it off until we get a VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE?
> 
> That way if a guest isn't using FMB (we never intercepted the associated
> MPCIFC to enable measurement), QEMU would never issue
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE and then we just leave the host FMB off.
> 
> In practice, yes, FMB is always on by default for a linux guest today
> but if we were to ever move to a model where we make it opt-in, it would
> be nice to only enable the host FMB when the guest actually wants it.

