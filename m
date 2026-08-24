Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541D33D6FD;
	Mon, 24 Aug 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600743; cv=none; b=RtFidlaB3JGqaq2tNImIFNmaeJbuhRseZzYzrIaUhSIsR28eYqAJTkAh0H3HKDnccdQ0as0gLwxQ1fp+7rwtdEZ7sISfp/rqO3lcK8635z2Pw6sy2JcdrobLoyG/Wt6ckpevncI6oVOsj3dGsTYv87YkakYgka7WGZ4ujVYEG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600743; c=relaxed/simple;
	bh=uYyZ0kMlZIN6WWOMc3I9b5jMy/SMT7I7ZwcIcQyx15o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmyP6tE5l/c/Uhi9k110pjbgOSfQw7m25Y2wH9Eug8OHrcZOqBujRNZJYC7vqHxCdDWcUmROLK/AlFt+JK0PpaH1H40a4P0tqclZ67skSfPYBctPZSx02dQ123zmbw0RCQwDf9wmI35DYtC6qDJv1cwVCbccjUk4wCm+dp1jwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W+uEkBca; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W+uEkBca"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVSUf2857821;
	Mon, 24 Aug 2026 19:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sBuVer
	O8Qk/T5fOZIahkQYiR/BzjVDj34G91AgNmnn0=; b=W+uEkBcailcQQb31ZrReUd
	FYQ3vj5fbVIFIYqHRheYED2aqe7N7V+WWC0lVD6QAZPMmRY8uajwuzA9F1XXM4L5
	wc0e1jATuyMjH2Y43bbATukBTpsWYKF50h7GtEm5Unm+2efflwO5clpA2aEO+CIV
	XiqtDvS4mXBOuIVRLV84ehELJys3nrwvMuDNwTwgzQd7wkuRbvS0iCDhLLDFjN+1
	w9Pj/PjAarDGPOm/oHIbCg3h43kMcrcO31JCewxmZSwdBpJ5UCl58Rga5BtUWelm
	6vRrpI3CtLcETFDozAHbzS7mpEdCQxRPY9iaNXtpzhiTqaws6AsIpUZw8P7Ph/EA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4ksvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:45:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OJfIDJ011864;
	Mon, 24 Aug 2026 19:45:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag7ypr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:45:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OJjcSl26608262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 19:45:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 897A858051;
	Mon, 24 Aug 2026 19:45:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F3E5805A;
	Mon, 24 Aug 2026 19:45:37 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 19:45:37 +0000 (GMT)
Message-ID: <8b76666b-4f7f-44be-ad7e-4a9455657bd2@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:45:37 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered
 NISC in vfio_ap_irq_enable()
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-2-akrowiak@linux.ibm.com>
 <20260824141125.56FC91F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260824141125.56FC91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n3CYjT-_Qxme1QYMyuCZp8um4Q7qCha2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX1eeWi8rGj3eB
 zj3lNcjntL8GkGaDXfm5BvzubXJefOUaWI21yGHxBq/6lxQyDwpnDJ6ocdlieiDVNL4KT5E1A8M
 oor1Bp/SPoC4SHIedBDHaYeOJXVAw18=
X-Proofpoint-GUID: n3CYjT-_Qxme1QYMyuCZp8um4Q7qCha2
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c9f64 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=B-K8Wd-7pwmQGGK4uHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX/+nbKutGtPQW
 m5z2xzjmXpQHB6LV3Zis38qxnq3k60iYJcnTjouBl+petO7wXcx2VjE+Oz0pTdZJ+g/4eqW4fW9
 rWNwKC5h+wSE74XdeDGFgputdQ+9Cj/Ld0JhPeQlIL1pR/PURtlFICVnaNpZV7Gk23P3kSwU3kH
 Qj3HKG9hAHbLjP9j+8P+0QlkaWllqf9JIHktvpTJMlT2U2zTZ2Lozg1Ni79b68aK7G5+2ImcL3h
 W5lLlEmHyICAwAMvd1eCvBPy1na4Gt4FK/xHAEQxj697dlXOJjBfZhVYcJDmJC90zcCROp+DMvD
 pRDVb7Es4LrVO4zQ6+TnvW54g/jQbtPnM76UiG6nW6EOpdcSac4yrE06yNsiBeXennQwn+kUzGX
 5nsNs2vMlbWKad0wCY4y3W2ZoY0VRX7vVXOiaRNj90/AXJAGHzQSEMrEIuTYsvaMvKLUjkoQrWE
 msv2ZVAOwtxFr1lR4bQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240165



On 8/24/26 10:11 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] `vfio_ap_irq_enable` incorrectly treats `AP_RESPONSE_OTHERWISE_CHANGED` (0x07) as a failure, unpinning the NIB while the hardware has successfully configured it. This allows the AP hardware to DMA into freed host memory.
> - [High] Unprivileged guest can flood the host dmesg by repeatedly triggering a `pr_warn()` in the `default` case of the `ap_aqic()` response code switch.
> - [High] A malicious or misbehaving guest can trigger host-side WARN_ONCE macros by disabling IRQs on a checkstopped or busy AP queue, leading to kernel panics if panic_on_warn is enabled.
> --
>
> --- Patch [1]: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable() ---
> commit c278a02f835924e412b00c7f6b715a44741cbcce
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable()
>
> This commit addresses a resource leak of pinned NIB and registered NISC
> pages during AP queue interrupt enablement. It updates the error handling
> path to unpin and unregister resources directly when an unexpected status
> is returned. This avoids incorrectly invoking the interrupt disable routine
> on a failing queue.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..a46bf381ab726 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -503,9 +503,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
> [Severity: Critical]
> This is a pre-existing issue, but does vfio_ap_irq_enable() incorrectly
> treat AP_RESPONSE_OTHERWISE_CHANGED (0x07) as a failure?

This is an interesting question. I took a look at the AP bus to see how this
response code is handled; it returns 0 from the function that processes the
PQAP(AQIC) call to enable interrupts, treating it as a successful 
completion.
This has generated several questions for which I'm seeking answers. 
Depending
on those answers, a new patch will be posted should this require a fix.

>
> When a guest triggers PQAP(AQIC) to enable interrupts on an AP queue that
> is not empty, the hardware returns AP_RESPONSE_OTHERWISE_CHANGED. This
> indicates successful IRQ modification but a non-empty queue.
>
> Because this code treats it as an error and unpins the NIB pages, couldn't
> the AP hardware later DMA interrupt data into the physical address of the
> unpinned NIB, corrupting host memory if those pages are reallocated?
>
>>   	default:
>> -		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>> -			status.response_code);
> [Severity: High]
> This isn't a bug introduced by this patch, but is it safe to leave this
> pr_warn() un-ratelimited in the default case?
>
> If an unprivileged KVM guest executes PQAP(AQIC) in a tight loop on a
> queue that is in a state returning an unhandled response code (e.g.,
> AP_RESPONSE_Q_NOT_AVAIL), couldn't they flood the host dmesg?
>
> This violates KVM subsystem rules which mandate that guest-reachable
> warnings must be rate-limited or removed to prevent log flood Denial of
> Service.

Looking at the existing code, all other guest-triggered warning paths in
this function already use VFIO_AP_DBF_WARN() — the default branch is the
odd one out. The fix is to drop the pr_warn entirely and use
VFIO_AP_DBF_WARN() which routes to the s390 debug facility (ring buffer)
and is not exposed to dmesg flooding. Since it wasn't introduced by this
patch, it will come with a separate series along with the fix to the comment
below which is for a similar problem.

>
>> -		vfio_ap_irq_disable(q);
> [Severity: High]
> This patch correctly removes the call to vfio_ap_irq_disable() here, but
> this highlights a pre-existing issue: is it possible for a malicious guest
> to trigger the WARN_ONCE macros inside vfio_ap_irq_disable() directly?
>
> If the guest executes PQAP(AQIC) with the interrupt enable bit set to 0
> (disable) on a queue that returns AP_RESPONSE_DECONFIGURED or
> AP_RESPONSE_CHECKSTOPPED, it will directly invoke vfio_ap_irq_disable():
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_irq_disable() {
>      [ ... ]
> 	case AP_RESPONSE_Q_NOT_AVAIL:
> 	case AP_RESPONSE_DECONFIGURED:
> 	case AP_RESPONSE_CHECKSTOPPED:
> 	case AP_RESPONSE_INVALID_ADDRESS:
> 	default:
> 		/* All cases in default means AP not operational */
> 		WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
> 			  status.response_code);
>      [ ... ]
> }
>
> Since this path is fully reachable by an unprivileged guest, couldn't this
> lead to a host kernel panic if panic_on_warn is enabled?

With panic_on_warn=1 this is a guest-triggerable host panic — a real DoS.
The fix is to replace the WARN_ONCE with VFIO_AP_DBF_WARN like that which
is used in the vfio_ap_irq_enable() function. The fix will be posted in 
a separate
series along with the fix mentioned above since neither was introduced via
this patch and are related.

>
>> +		pr_warn("%s: PQAP(AQIC) failed with response code %02x for apqn %04x\n",
>> +			__func__, status.response_code, q->apqn);
>> +		/* We could not modify IRQ settings: clear new configuration */
>> +		ret = kvm_s390_gisc_unregister(kvm, isc);
>> +		if (ret)
>> +			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
>> +					 __func__, ret, isc, q->apqn);
>> +		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
>>   	}

