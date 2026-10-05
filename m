Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE02D0605;
	Mon,  5 Oct 2026 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237930; cv=none; b=DjblMdwu4FrWqhr9gwWNepmz9vCidiqKtNxZ8N5N82PMRXYv2RBq41yzk7mtyeWNyaj5EbaUanjbXkkmxSB977pdbybMhZisS0j4AuvxORCXFnrf9HINmwUmm5RRzFCeCHeNpuuFWtWM+L5HeWG+btUkT4PDJrw4eki7Mom9YeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237930; c=relaxed/simple;
	bh=tlFKnI+/G46xEVtkZZz6SWIPAQ9LJRHy37Mwk0R9pxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCLdDhNb47ACZkjill4Rw4yckrHWA3Ue0XnoPufenRWzTny/gmLP4Wu7Zqd6cFrKsJZyWOFIvNgcXfwa2ky5w2uMdVn/dqo6CdMfGBrxu1nh8zPbA7A7szc6ZBwg0rLroVXyRv9S1dbNNzfuFK9CVcR6NWmYwh0Oq4Om498ZOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kivosnst; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kivosnst"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695Ha76w1132014;
	Mon, 5 Oct 2026 22:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xB8PL/
	aesM9tEy01+dDwzQohwUSfg/defvtVkjqE5i8=; b=kivosnstkLqKEQgLoa+j0N
	Idd5+djp6FKo2NxGfCH058vj+w+rNv4U44//QbMdFX+OHo5/6IEWGkS/10Bl0IJ+
	5hM6KC55XPY6eD62eljPCQlIkutAKBwvUDH5UsYFZ1CdY6tO3CQyROTlOawkolMv
	wiFo4VBW2u6JYBylLWeqq2/qXEqJ13VOfLJcJ/LlnVTLQFE6o85zRqVV/0j7JYr8
	W8uRgwbIEKneLB8wpSnYWkfsAwgNwD+lrbsBmZGwpYWFnGOtq33lJrGuGZd34HJA
	0WeAz1iRGa4b1v2Jt40RFat2gKEZmRbvlda/um+XmX0fcFzJ0n22lBldiHaLwUow
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jmafw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 22:05:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695LlaVt3238873;
	Mon, 5 Oct 2026 22:05:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pqhrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 22:05:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695M5N0E26608182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 22:05:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 615835805C;
	Mon,  5 Oct 2026 22:05:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2F9258058;
	Mon,  5 Oct 2026 22:05:21 +0000 (GMT)
Received: from [9.61.254.169] (unknown [9.61.254.169])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 22:05:21 +0000 (GMT)
Message-ID: <a6d35b06-694e-45da-ab3d-12279cacdc8c@linux.ibm.com>
Date: Mon, 5 Oct 2026 18:05:20 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
 <20261005154557.57801-3-oelghoul@linux.ibm.com>
 <023ed9db17d9c7d785dad387fc18dff6bed862d8.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <023ed9db17d9c7d785dad387fc18dff6bed862d8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -noYHEZDmDrEUdUrV-O_udIDeDP5xVHV
X-Proofpoint-GUID: -noYHEZDmDrEUdUrV-O_udIDeDP5xVHV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NyBTYWx0ZWRfX9C6pa0h+e+tK
 dORJgCEolNo+DZCqH0UeTBD1RuszfV2FZ9OZrr0z9kIc4xaRJxmX5sH8FaGVbvDj69+rMG4S6Or
 YLNKwwHOkPLx3hN2YiLI5P5idNeQ3/c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NyBTYWx0ZWRfX0HNoKS5Jnxo1
 kb6qmcO8XA7a9ZidioVkb2qnrWq8yVSCtiz1KKoWSoFydNmc+CTmWKFmk7Q3aZ82aw3c/nQPLWi
 kh6XykNJI3KRB6ARmSeCrL6f8ofr1qMLNzILlLvMr6zE94IIrJFTSGVOOuQCGeDKUqP8hrG9S9t
 PizwdmkfQoq3on5T4Fz5R4kCqIGRuNikSlNStGpE+5JGrHFaAx1iG+/a7M5u1UUS5WdJ8RXaJl4
 wMOHkovR89gfH3niVhkeSkJWL2WLfquFQ+kEoXkJVPLLWExi8MtGjn2tsWemRqGmmZjHjLwm7S5
 BywwqQaVQwfOY5t/tbvTPSYybHaQsH79oQbBp5ZUc7ulnF1bgt1m+wusbL/rNwBVVPPIj/tQL3d
 8euwXUhQSVHpKHPyGflzYZx/QfVaA8O1067IKxNHY19OFfEnXjdCywB8MXfl9VUVniUcBfaLsEh
 W57hxC9Yy1x/WUVkVxQ==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac41f25 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=D4a7Qy6VNviO5TZbTMkA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050087

On 10/5/26 3:53 PM, Niklas Schnelle wrote:
> On Mon, 2026-10-05 at 11:45 -0400, Omar Elghoul wrote:
>> Don't free the FMB buffer when disabling measurement in
>> zpci_fmb_disable_device(). Instead, make the buffer persistent for the
>> lifetime of the device and reuse it across enable/disable cycles. Defer
>> freeing the buffer until teardown in zpci_release_device().
>>
>> To support the persistent buffers, add the fmb_enabled bool to struct
>> zpci_dev to decouple whether FMB is enabled from whether the buffer has
>> been allocated. Audit the only consumer of zdev->fmb as a liveness check
>> and update it to reflect this change.
>>
>> Introduce the function zpci_fmb_reenable_device() to ensure that the FMB
>> is enabled. If it was already enabled, disable it, zero the counters,
>> and re-enable it. This allows the function to be used in both first-time
>> enabling and re-enabling measurement. Call it in zpci_reenable_device()
>> to preserve the FMB enablement if it had been implicitly disabled by
>> firmware in zpci_disable_device().
> 
> I think this causes a sequencing error in zpci_hot_reset_device().
> First the device gets disabled via zpci_disable_device(). This
> implicitly disables the FMB but keeps zdev->fmb_enabled set. Then we
> call zpci_fmb_reenable_device() in zpci_reenable_device(). Since zdev-
>> fmb_enabled is set we don't first enable the FMB and instead go
> directly to disabling it but that is wrong since the FMB is already
> disabled as a side effect of the CLP Set PCI Function (Disable) in
> zpci_disable_device().
> 
> Also, and I think Gerd mentioned this before, there is a disconnect in
> semantics between zpci_fmb_reenable_device() and zpci_reenable_device()
> that is quite confusing. While zpci_reenable_device() re-enables the
> device with existing interrupts and I/O address translations, after it
> was disabled, zpci_fmb_reenable_device() on the other hand does a
> disable and then enable cycle.
> 
> I think the idea here is that zdev->fmb_enabled tries to track whether
> the FMB is supposed to be enabled rather than if it is enabled.  This
> makes some sense since the FMB can get disabled by the device entering
> the error state or a zpci_disable_device() and we want to know if we
> need to re-enable it at the re-enable of the device.
> 
> Importantly, unlike the disablement of a device we always initiate the
> enablement. But then we can't try to disable the FMB without knowing if
> it was already disabled. I think a possible solution for this would be
> to have zpci_fmb_reenable_device() mean that we know that the FMB is
> disabled but should be enabled, which we know when we re-enable the
> device and zdev->fmb_enabled is set. Of course then it doesn't do a
> disable but only an enable despite zdev->fmb_enabled already being set,
> Then zpci_fmb_enable_device() on the other hand sets the flag initially
> and then uses zpci_fmb_reenable_device() or a shared helper. Of course
> we would then have to properly document zdev->fmb_enabled as being a
> the target rather than current state.

I agree with your insight and I'd be happy to follow this approach, but
I think this can cause FMB consumers to read stale snapshots (e.g. if
the device was disabled due to an error state or similar but fmb_enabled
is true). What would you think of leaving fmb_enabled as-is to indicate
whether FMB is actually enabled, and then introducing a second bool,
maybe something like fmb_needed, to track the user's intent and whether
we should call zpci_fmb_reenable_device() from zpci_reenable_device()?

This way, a successful zpci_fmb_enable_device() sets both flags, and
zpci_fmb_disable_device() clears both. zpci_disable_device() should
only clear fmb_enabled and leave fmb_needed as-is, allowing us to track
the implicit disablement by the firmware. This will make fmb_enabled
represent the actual firmware truth, and it becomes a reliable liveness
check for the FMB consumers (debugfs and vfio, for now.)

As for zpci_reenable_device(), it would check fmb_needed and if set,
call zpci_fmb_reenable_device(), since we'd already know by that point
that the FMB was implicitly disabled by firmware.

Thanks

> 
> Thanks,
> Niklas

