Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7633D1CAD;
	Fri, 28 Aug 2026 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948088; cv=none; b=g79IF673kTGbuTQv42b6ETk/HRLe/mlZ57D+NhNO+fwEhjL2ZBL3mHlY8dTMOMVPM34HOwDX09MwtijgigAQiMWzEuJd2/P02uQNHA/1s0i+ws/egE+SAi7woqoXq38O8aCQRi8rPjLMmFMo98VhU0T+WmKBhm38TrED85BNM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948088; c=relaxed/simple;
	bh=nVqbHFt2cLKomMwsE7fBHllE22ksYtKqkC5aBV9oE2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swMEhn4YX1WA2TZr+aTZQqElxvOZYDIBX4kDl/1iN+MRQx0H+4GtDoWTkHPidYzb+Jr61RGIrE8G15z9J72pE0yELJgqxb25zG5tZjl7CutHCLz83BCv9Vy2CQOd8NU0NNi+n0kWjYSkHku6Iy5DTCy1coMj0UTeHL4ejVgXoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JoWiGXAD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JoWiGXAD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SJVdin3065346;
	Fri, 28 Aug 2026 20:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qtKtiu
	1HtcDmEvqOH4RgBPD7cUwqsslFPKZ2YlWgZrY=; b=JoWiGXADoQOrwyUDQcUFYN
	PV6naRKyNzsZQXacKOS0ikW4RcFRkttuL/SfhuzGHKgy7n7aRpzal0xTzosuxmYg
	gHuOWY9ZSVHI7qg9MDOHEGLUpZBID7bJZAP7Sq6LU5UohLRENptZUo8B29P3D7WF
	mWjCCXgW7Od+fBO78Y1Fm1UXCZM6sdDH6S5i1XpaLG12XfUnHWD8l6X57Azx1tlD
	m3dRzI2b2l5m2U+OdxtAWhXGV0TT4tWkLJJN8uEFRopyBi6Pn/BFHi5dbewEwMnA
	F/hN8PV+vQyC8Z9ywyc42GS1giqpOHZiRyugmjZH0rXKJVzVRdVervx+Uno7QqgQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxxj4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 20:14:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SKBGtU002315;
	Fri, 28 Aug 2026 20:14:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qrsr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 20:14:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SKEhvC22545122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 20:14:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC995803F;
	Fri, 28 Aug 2026 20:14:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C28458061;
	Fri, 28 Aug 2026 20:14:42 +0000 (GMT)
Received: from [9.61.33.14] (unknown [9.61.33.14])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 20:14:42 +0000 (GMT)
Message-ID: <cd2e1116-1219-4db0-a536-6631258c3723@linux.ibm.com>
Date: Fri, 28 Aug 2026 16:14:42 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable/disable()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
 <20260827132441.555866-2-akrowiak@linux.ibm.com>
 <20260827133916.93BF81F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260827133916.93BF81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3NCBTYWx0ZWRfX6PjwlJ3z99eo
 AQ3gd1xeYo7Y0eW4jaqpXP99wXLRSSpMwXTM9TpeX0Z9sEAdxhcSJ5CbtnKGsytfS6OjPqQGdlj
 Laba1EKYg+MsGp4kZITiYhRySAqQMzA=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a91ec35 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t1HfxZZpVsPCCiCQmTUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YDiXl9zEoZng6vxth2erechw2mf6B9HF
X-Proofpoint-GUID: YDiXl9zEoZng6vxth2erechw2mf6B9HF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3NCBTYWx0ZWRfX48HxcFNwxVUe
 rstn44++n/Xx3Xznsc5MJCrKXQoD6C2VHpF3EjuCg/EglQDs9NHVhWUV/Oz2wmIUYwMdeOYiZpn
 QHZLG9liRqotJshg5esFJE8YXTGSHW3FC0LDhZumQnbC9rzHHZT5Zujxs8w9c6C0saTp8dWedfQ
 g3JVrKHm9GklYHG5ZP+KybKuTRFO7qzA/op+ZSQoqYPvqJICURUl8kp2wfc4kbZL0tp86BOwd7o
 st56pAGHJVZVJlqTID4+Eu1LeJHLaVLtGP1aQfmqJQufGruUBfkyW92ikB4/u/NuDthTEtV8w5t
 0mCTgb7v0Orvv15iHOOP95JHpdUC0BVBoIme/OQQsJkS6Qcze80zejHgN0u+U30QfZluN4voPWx
 FkkNuetKlQYtb9EMucthV+SgWPSZ+bdcF3C8LCWzR+XmiNwEzpCSN4+Rf7BPbVNP6fzH2t7eHPO
 7GCC0Pzcs7vMjLSRvJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280174



On 8/27/26 9:39 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] State Inconsistency / Guest Memory Corruption
>
> Pre-existing issues:
> - [High] Guest-Triggerable Host Denial of Service via WARN_ONCE
> - [Medium] Potential Use-After-Free when replacing an active NIB in `vfio_ap_irq_enable`
> --
>
> commit 01ac8813c3b445f045948ad22e87c958b38cb3b4
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable/disable()
>
> This commit addresses resource leaks by ensuring the NIB is unpinned and the
> NISC is unregistered when the PQAP(AQIC) instruction fails or times out. It
> also introduces a wait loop to prevent a host use-after-free when disabling
> IRQ resources.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..64d6a8f8fa96e 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -257,12 +265,13 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>>   		default:
>>   			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
>>   				  status.response_code, apqn);
> [Severity: High]
> This is a pre-existing issue, but could a malicious guest intentionally
> trigger this warning by spamming AP queue instructions? KVM guidelines
> specify that guest-reachable WARN_ONCE statements can act as a local
> denial-of-service vector when panic_on_warn is enabled. Should this be
> converted to pr_warn_once() or dropped entirely?

This branch is reached only when ap_tapq returns a response code
indicating the queue is non-operational (Q_NOT_AVAIL, DECONFIGURED,
CHECKSTOPPED, or an unrecognised code). These conditions are
hardware/firmware-driven; a guest has no architectural mechanism to force
them on demand through normal PQAP instruction execution. The guest cannot
spam its way into a non-operational hardware state.

WARN_ONCE also fires at most once per unique call site for the lifetime of
the kernel, so even if somehow reachable it cannot be used as a repeated
DoS.

>
>> -			return;
>> +			return true;
>>   		}
>>   	} while (--retry);
>>   
>> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
>> -		  __func__, status.response_code, apqn);
>> +	WARN_ONCE(1, "%s: tapq rc %02x: timed out verifying interrupts disabled for %02x.%04x\n",
>> +		  __func__, status.response_code, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
> [Severity: High]
> This is a pre-existing issue, but does this WARN_ONCE pose the same
> denial-of-service risk if an untrusted guest intentionally stalls the
> hardware response to exhaust the retry loop?

The retry loop calls ap_tapq, which is a host-privileged instruction
  executed by the host kernel — not the guest. The guest cannot intercept
  or stall ap_tapq execution; that is a host/hypervisor operation. The
  timeout is bounded at 5 × 20 ms = 100 ms regardless of guest behaviour.
  The WARN_ONCE-once-per-site property also applies here.

>
>> +	return false;
>>   }
> [ ... ]
>
>> @@ -317,8 +326,21 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>>   		switch (status.response_code) {
>>   		case AP_RESPONSE_OTHERWISE_CHANGED:
>>   		case AP_RESPONSE_NORMAL:
>> -			vfio_ap_wait_for_irqclear(q->apqn);
>> -			goto end_free;
>> +			/*
>> +			 * AQIC disable was accepted (NORMAL), or the queue was
>> +			 * already disabled or a prior async request is still
>> +			 * completing (OTHERWISE_CHANGED).  In both cases, we must
>> +			 * wait until interrupt processing has been disabled
>> +			 * before proceeding.
>> +			 *
>> +			 * If it could not be determined whether interrupts
>> +			 * have been disabled, do not free the AQIC resources: the
>> +			 * hardware may still write to the NIB, so leave it pinned
>> +			 * to avoid a use-after-free. The resources will be leaked.
>> +			 */
>> +			if (vfio_ap_wait_for_irqclear(q->apqn))
>> +				goto end_free;
>> +			goto end_fail;
> [Severity: High]
> If vfio_ap_wait_for_irqclear() times out, the code correctly takes the
> end_fail path to prevent a host use-after-free. However, doesn't this
> result in returning the original AP_RESPONSE_NORMAL status back to the
> guest?
>
> If the guest receives a success status, it might assume interrupts are
> fully disabled and proceed to free and reuse the memory containing the NIB.
> Since the hardware may still be actively writing to the NIB, could this
> corrupt the guest's re-allocated memory? Should the driver override the
> return status (e.g., returning AP_RESPONSE_BUSY) to force the guest to
> retry instead?
>
>>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>>   		case AP_RESPONSE_BUSY:
>>   			msleep(20);
>> @@ -326,18 +348,46 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>>   		case AP_RESPONSE_Q_NOT_AVAIL:
>>   		case AP_RESPONSE_DECONFIGURED:
>>   		case AP_RESPONSE_CHECKSTOPPED:
>> +			/* AP not operational; no further interrupts possible */
>> +			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>> +				  status.response_code);
> [Severity: High]
> This is a pre-existing issue, but does this WARN_ONCE similarly allow an
> untrusted guest to trigger a kernel panic if panic_on_warn is enabled?

These response codes reflect hardware/firmware-reported non-operational
  states that the guest cannot manufacture on demand. WARN_ONCE fires at
  most once. Not a practical DoS vector in production.

>
>> +			goto end_free;
>>   		case AP_RESPONSE_INVALID_ADDRESS:
>>   		default:
>> -			/* All cases in default means AP not operational */
>> +			/*
>> +			 * The AQIC disable was rejected; IRQ is still enabled
>> +			 * and the hardware still holds the NIB address. Do not
>> +			 * free resources.
>> +			 */
>>   			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>>   				  status.response_code);
> [Severity: High]
> This is a pre-existing issue, but could this WARN_ONCE also act as a host
> denial-of-service vector if a guest provides invalid queue states?

AP_RESPONSE_INVALID_ADDRESS from ap_aqic means the host-supplied NIB
  address is invalid — this is a value the host driver passes, specifically
  the h_nib derived from vfio_pin_pages. The guest cannot directly control
  the host physical address used here. WARN_ONCE again fires at most once.
  Not a guest-reachable DoS path.

>
>> -			goto end_free;
>> +			goto end_fail;
>>   		}
>>   	} while (retries--);
>>   
>>   	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>>   		  status.response_code);
> [Severity: High]
> This is a pre-existing issue, but could an adversarial guest intentionally
> induce a timeout to hit this WARN_ONCE as well?

This fires only when ap_aqic itself keeps returning BUSY or
  RESET_IN_PROGRESS for all 5 retries × 20 ms. The AQIC instruction is
  issued by the host kernel against a hardware queue. A guest cannot
  artificially hold the AQIC response in BUSY state across all
  retries — that is a hardware/firmware concern. WARN_ONCE fires once.

>
> [ ... ]
>
>> @@ -490,6 +540,11 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
>>   	switch (status.response_code) {
>>   	case AP_RESPONSE_NORMAL:
>>   		/* See if we did clear older IRQ configuration */
>>   		vfio_ap_free_aqic_resources(q);
>>   		q->saved_iova = nib;
>>   		q->saved_isc = isc;
>>   		break;
> [Severity: Medium]
> This is a pre-existing issue, but if ap_aqic() accepts a new NIB replacement
> and returns AP_RESPONSE_NORMAL, does immediately freeing the old resources
> via vfio_ap_free_aqic_resources() pose a use-after-free risk?

No interrupts are made pending once AP_RESPONSE_NORMAL (cc=0)
is returned; however, in the unlikely event the queue was already enabled
for interrupts, there is no risk of use-after-free for the old NIB. On the
other hand, the new NIB does not get stored by the hardware, until
the I-bit (bit 7) is set in the APQSW, so it would make sense to verify that
before freeing the old NIB.

>
> If the hardware processes the change asynchronously, might it still have
> in-flight DMA writes directed to the old NIB (stored in q->saved_iova)? If
> so, does the old NIB need to be fully quiesced using a similar wait loop
> before it can be safely unpinned?

As stated above, no interrupts are made pending once
AP_RESPONSE_NORMAL (cc=0) is returned. What needs to be done, however,
is to wait until the I-bit (bit 7) is set before clearing the old NIB if 
in fact
it has been store for a previous enable. When the I-bit is set, the 
queue will
set the new NIB, so new writes will be made to the new NIB and the old
will be stale and can be freed.

The fix is to wait for the I-bit to be set before freeing an old NIB.

>
>>   	case AP_RESPONSE_OTHERWISE_CHANGED:
>> -		/* We could not modify IRQ settings: clear new configuration */

