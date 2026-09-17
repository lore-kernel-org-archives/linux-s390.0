Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D884E324F;
	Thu, 17 Sep 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658930; cv=none; b=gdAqqJsFCgqctLLtHcVACDA1yBsXb36Ovjj0n950nzE1Xv/VcWU0a4Wi1Hv9IFo4IT9qdblNC61uhceFMoXlthlA7DQ+Fr2+9TbCVXIAu7Gu4CiT3ghhpb1YJmka5VG9ia0VNrcSJ1QC2eV14jphNi2F3gLLyq31/KAqDZ+2UxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658930; c=relaxed/simple;
	bh=spGyfUBCYh3KlTVzWWfoJXnz3KSmwZ/Jna0x/WafKaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/A8eo+cDeJbFoWmz6au14kayYKTLMwZZKQJj+JnvQpBXOqXLEp1zK39vAu4RRT+yz/+Q0d19gp9t0z1eUBFU6Yq35bkc3qlhO1pa6c28dfHDEYa3phUi06PMXe7tqg7QfroD+ovhhVNiicXaj1fedX8KiU8/rmdBl0DFI4a3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iiPr30OJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iiPr30OJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HE1OqE2697537;
	Thu, 17 Sep 2026 15:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U0Tc9u
	yXmMfyLV1ayrCY/xTViDSnXLmr1wgF/h8IAVw=; b=iiPr30OJs+eg1mpPQVAdTE
	GUkpXItMTwPexOS2jKew0Lep1esnbkDmVGkL/0MOjJ+aIOOH8UijTYbOsmoUrFV4
	NskABVACAMX3bCOhtoypLSINqFk4GU1xRa4V1Gqy+P0AL672gIS9R+SPgpHpU7MU
	BSgGdtTNsFTTu3EGzWihFy4tLEQhkBY0yF6tE9/NBuP40bUCOdrTHQGBPsVXoHpR
	aCuNxyRDAHnFjmjGgFOEHTr5dgN/p3VBDMjdQgJ/9cdjVOMs/v3aUVLQJs5IU/yB
	bEPkI4ZrnA5vWBzQp1zrhUAEU/KeC9AeddVLbiaJUupm+HwvqCKMx+SkD0h5N1PA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx8437w6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 15:28:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDa8tO3244819;
	Thu, 17 Sep 2026 15:28:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffb128-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 15:28:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HFSRk321430892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 15:28:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ECD158050;
	Thu, 17 Sep 2026 15:28:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE4B158045;
	Thu, 17 Sep 2026 15:28:25 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 15:28:25 +0000 (GMT)
Message-ID: <dae3c7cd-21aa-4263-bec5-792b018d21e2@linux.ibm.com>
Date: Thu, 17 Sep 2026 11:28:25 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-3-oelghoul@linux.ibm.com>
 <099b4e3f-4156-42e4-a2e9-bdc715547bef@linux.ibm.com>
 <85cb647d-b1c8-4804-b206-2cae1e03e20d@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <85cb647d-b1c8-4804-b206-2cae1e03e20d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIxMyBTYWx0ZWRfXyCERjNxpZfVK
 bhU16/nvWM5Wq7KBv5fdyrBhnnYdly2yPDyuvL5PpFPibG1aQnrl6XxfHtfu0qV/obQX8JLOn7c
 N8OLvqHKwN1NSD3R9PP7StimSmmbLNPyzwd/++A3ALpPYQwbTg94WORxd9kEsRuTMTqU0jZJ74x
 zMleZXiIrIq/ojw5RvW+qaqyj4pazcDth7eRz7GEWL5ZRQBZOtlw8gW9rl81v0iyKDvyE3AduKg
 DGTFIM5loRLrSDRtXk4NME6aeM9jXu1nWpFUkmm+fUfG4JdxeQ6sd/8Dcae14T5qbFJuH3Cw0IN
 l86ihH4NYK3rZ0XD7FY/pnk1DLeYWlgPOk4th6SuHZFLZ16TuEDuSrH4BYwZI8MLdIyUm5ty5Vj
 XhtM6mOGGz5kbrHGQ/NW5piqUTztLmmMSfSOl90uCrhEtT4pa22lk+Jbq9TaAuVHUXYHGrEcVYW
 vgHXWV6QZsEOsVBuV1A==
X-Proofpoint-ORIG-GUID: 4HXhigPyXuNUNIC4p-7LJLBKi6HBMXeT
X-Proofpoint-GUID: 4HXhigPyXuNUNIC4p-7LJLBKi6HBMXeT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIxMyBTYWx0ZWRfX8xDrPTutH1Tn
 mOq1INcIwdfAmLAFf1o7IMQm8pMyQGNYccf3KKLlUCcLnGFa2nkOoCn2rvuRORHFQCV+ax0VTcq
 AV67lhzQg1WbR4rpvOB+FY05dIlqjW4=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aac071d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=sr11kz5vdOI1Ry7keEkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170213

On 9/17/26 9:32 AM, Omar Elghoul wrote:
> On 9/16/26 10:21 PM, Matthew Rosato wrote:
>>
>>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>>> +{
>>> +    u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>>> +    struct zpci_fib fib = {0};
>>> +    u8 cc, status;
>>> +
>>> +    lockdep_assert_held(&zdev->fmb_lock);
>>> +
>>> +    if (!zdev->fmb_enabled)
>>> +        return zpci_fmb_enable_device(zdev);
>>
>> Sashiko has a point here, won't all paths that call zpci_reenable_device
>> now unconditionally turn on FMB here even if it was purposely disabled?
>>
>> The pattern of callers for zpci_reenable_device() is:
>>
>> zpci_disable_device()
>> ...
>> zpci_reenable_device()
>>
>> We only care to re-enable the FMB during device re-enable if the device
>> had FMB enabled at the time zpci_disable_device() was called.
> 
> The way I thought of it was pcibios_enable_device() already enables
> measurement, so we might as well ensure it is enabled when the zdev is

Yes, FMB starts enabled by default but then it could be disabled
intentionally via sysfs; if a recovery action occurs on the device
sometime after I manually disabled FMB for a device, I'd expect it to
still be disabled after the recovery action but AFAICT with this
codepath it will always get re-enabled.

Completely removing the device and re-introducing it to the system is a
different matter; in that case yeah we'd be back to FMB-enabled because
that's our default starting state via pcibios_enable_device().

> re-enabled. That default state is also helpful for the later patches
> because kvm_s390_pci_register_kvm() calls zpci_reenable_device().
> 
> But I guess if we didn't want to conflate the two, we could also add an
> unconditional zpci_fmb_reenable_device() within the KVM register hook,
> to run after the zpci_reenable_device(), whichever you'd prefer.

Do we even want it to be part of the KVM register hook at all, or could
we leave it off until we get a VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE?

That way if a guest isn't using FMB (we never intercepted the associated
MPCIFC to enable measurement), QEMU would never issue
VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE and then we just leave the host FMB off.

In practice, yes, FMB is always on by default for a linux guest today
but if we were to ever move to a model where we make it opt-in, it would
be nice to only enable the host FMB when the guest actually wants it.
