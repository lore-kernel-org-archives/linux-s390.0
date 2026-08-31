Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDE2D781B;
	Mon, 31 Aug 2026 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172249; cv=none; b=c/GEJ/i4rXx8h54viTlfeGY6XA6NBV0uXKiG6ociicQR5gVA/UhA8vai/a9MXOZMIfM8AarnPctheoeScCF69dp8S8thbPZyux+5EgVkjvJpKI7oF4Q1ZdyowY1gySdo2GYnHLYp+6KcJI49PN0XGnQ7GFKx8M97iSWnr4OZTFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172249; c=relaxed/simple;
	bh=Ue8rScCqsgQwVU9eRcaCG6I8bspucEAE0U9uhwqA8Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFP/kgbKTEaerR8Ud8jJ8h1E8M9Yk2qwshURm+iZvfqX/+iHsM6R1pK3qdZ66/NeT9QUB+X3GiUqEKAta/DAQpO7lVrsPgKv0KjGC1c1Gs54iU2N5IdvwY0iXyDWorjriV1kRP7qKgubCCHdF/10Qs0/rOwbQNaklawxoRNi6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jawdq48k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jawdq48k"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82GOf1530799;
	Mon, 31 Aug 2026 10:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=evGkbM
	QEP+5mb1V6gxg3J2QclLIKC91JRKvgKC5iC9A=; b=Jawdq48k6gJ+HX+XljNsUK
	fwMwYZ+9A5go4Wypiv0IP7xE+OQEE9krNqrOYbD1uGNCEnzZ7Ns+flf4cJs35x1r
	Wd1AZuRuI29xe0pNw8roqV6tSeB1OcLKMQ/XuDRLuqp5INUCuq3KqQ2s/KtuJ1/n
	02bgS/XE1hB9xN6aLocwiOMqrD0N5qgHXkbMfUvGG+umlJHG8hjGjghFgxP/SUtO
	XN2ar0rfPcr2O3NTPRr8pgyfqFy70+181VATZQPrSPBW0XrGSgPHJT69TT0fs6oa
	YG8xz/QKMgVlNddxMB2VjKBUf5FyHAYiJkv/2aBg1oEkdb/+mhCNEU4/QWOTRwaQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhgtkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 10:30:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VAQGWj028110;
	Mon, 31 Aug 2026 10:30:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexw44u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 10:30:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VAUigZ24117888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 10:30:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E085804B;
	Mon, 31 Aug 2026 10:30:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E74F58059;
	Mon, 31 Aug 2026 10:30:44 +0000 (GMT)
Received: from [9.61.70.47] (unknown [9.61.70.47])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 10:30:43 +0000 (GMT)
Message-ID: <e25ef4a2-947e-4caa-94eb-fecaed8b0432@linux.ibm.com>
Date: Mon, 31 Aug 2026 06:30:43 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable/disable()
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
 <20260828214653.1087009-2-akrowiak@linux.ibm.com>
 <20260828215749.5B3EA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260828215749.5B3EA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wUplwUnnJ8ANJYzbiIiBijqP2Wx_ASZn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NiBTYWx0ZWRfX+UWbXUZC/jnF
 BpFGDuGbC6MMWyOSHeTjGR2UrpgZmM3WO9HureYqpQc399Fy7C6hXl7PmkNtKIVRb6D5TZG1m4K
 6Jn5Lps3UVwJ7hDeKK2RHENedWaxwNXdLOWrJmP5CuyE4W2mr3bSce9tw7FTh0dSAhDLHRjzCPo
 CoIKgbcMtz7PpecyoA4XfistOZWHktdIdTbQ+PINkG00Plrfs6z4KbYoX7wKoMP4qHbNtjtWDvK
 KRRB4gis1kk/qlc4TRshQhhutPNEfeAujHHlymcZp0INs8sliHH19f3aF0cJzz9UM+wmppXHc8I
 mKWazvXIuxjt8PIyMsIOe1XKk1tPZJYem6J9rxvLSZF9f+uWxwygJ0mfcFOnbq8xvFj5XnMYmdn
 UbIq+YKK3VM6zyqv5Ui1G8/DOT3F1z80rJPEkgsUsQzaBlLtPLD7yhtHG5RYNpkkWW5u1k8adNS
 KljL3oECTleDcOun4dg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9557d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=X6a0j2lC6GQecTCcd7cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NiBTYWx0ZWRfX5w2Op2MDiq3v
 Ih+LE7L7IAPR7+VnGDeEORN4L/+2xaKEwOgdcVzlo396USGjR7vpO86O+zxzCcYsgihZbO0M7YE
 uYv3qnIMFGhrx/h4uIsiNBvM+i/gT4Q=
X-Proofpoint-ORIG-GUID: wUplwUnnJ8ANJYzbiIiBijqP2Wx_ASZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310086



On 8/28/26 5:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Critical] Prematurely unpinning the new NIB page on a hardware timeout in `vfio_ap_irq_enable` causes a host use-after-free and wild DMA write if the hardware later completes the asynchronous interrupt configuration.
>
> Pre-existing issues:
> - [High] Guest-reachable `WARN_ONCE` in `vfio_ap_wait_for_irqstate` and `vfio_ap_irq_disable` violates KVM subsystem guidelines and creates a denial of service vector on `panic_on_warn` systems.
> --
>
> commit f514ef27dfc693d5c326ffed4fd1a9985acce1d0
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> Subject: s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable/disable()
>
> This commit addresses resource leaks by restructuring how the AQIC
> instruction responses are handled for AP queues. It introduces a polling
> mechanism to wait and confirm asynchronous hardware transitions before freeing
> resources.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..24e93fb7f81a2 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -245,8 +259,8 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>>   		switch (status.response_code) {
>>   		case AP_RESPONSE_NORMAL:
>>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>> -			if (!status.irq_enabled)
>> -				return;
>> +			if (status.irq_enabled == ir)
>> +				return true;
>>   			fallthrough;
>>   		case AP_RESPONSE_BUSY:
>>   			msleep(20);
>> @@ -257,12 +271,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>>   		default:
>>   			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
>>   				  status.response_code, apqn);
>> -			return;
>> +			return true;
>>   		}
>>   	} while (--retry);
>>   
>> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
>> -		  __func__, status.response_code, apqn);
>> +	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts %s for %02x.%04x\n",
>> +		  __func__, status.response_code,
>> +		  ir ? "enabled" : "disabled",
>> +		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
>> +	return false;
>>   }
> [Severity: High]
> This isn't a bug introduced by this patch, but does this guest-reachable
> warning violate KVM subsystem guidelines?
>
> A malicious guest can intentionally manipulate AP queue states or rapidly
> spam PQAP instructions to stall the hardware, triggering these warnings on
> non-operational states or polling timeouts. On systems configured with
> panic_on_warn, this creates a host denial of service vector.
>
> Could these be converted to rate-limited debug messages or dropped entirely?

Responded to with v3, not legitimate.

>
> [ ... ]
>
>> @@ -326,18 +365,46 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>>   		case AP_RESPONSE_Q_NOT_AVAIL:
>>   		case AP_RESPONSE_DECONFIGURED:
>>   		case AP_RESPONSE_CHECKSTOPPED:
>> +			/* AP not operational; no further interrupts possible */
>> +			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>> +				  status.response_code);
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
>> -			goto end_free;
>> +			goto end_fail;
>>   		}
> [Severity: High]
> This is also a pre-existing issue, but can this similarly be triggered by
> an unprivileged guest manipulating the queue into an unavailable state during
> a disable attempt?

Responded to with v3, not legitimate.


>
> [ ... ]
>
>> @@ -489,13 +557,49 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
>>   	switch (status.response_code) {
>>   	case AP_RESPONSE_NORMAL:
>> -		/* See if we did clear older IRQ configuration */
>> +		/*
>> +		 * AQIC initiates an asynchronous process; however, AP_RESPONSE_NORMAL
>> +		 * does not guarantee the IR bit is set yet.  Wait to confirm before
>> +		 * committing the new NIB and freeing the old resources.
>> +		 */
>> +		if (!vfio_ap_wait_for_irqstate(q->apqn, AP_IRQ_ENABLED)) {
>> +			/*
>> +			 * Timed out: the hardware may not have accepted the new
>> +			 * NIB.  Clean up the new resources and return
>> +			 * OTHERWISE_CHANGED to signal the guest to retry.
>> +			 */
>> +			ret = kvm_s390_gisc_unregister(kvm, isc);
>> +			if (ret) {
>> +				msg = "%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n";
>> +				VFIO_AP_DBF_WARN(msg, __func__, ret, isc, q->apqn);
>> +			}
>> +			vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>> +			memset(&status, 0, sizeof(status));
>> +			status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
>> +			break;
>> +		}
> [Severity: Critical]
> Does unpinning the new NIB page here introduce a race that could lead to a
> wild DMA write and host memory corruption?
>
> Because ap_aqic() returned AP_RESPONSE_NORMAL, the hardware accepted the
> asynchronous request. If the hardware is merely stalled (e.g., due to a
> malicious guest spamming instructions) and vfio_ap_wait_for_irqstate() times
> out, the hardware might still eventually complete the transition and write
> interrupt status bytes to the new NIB.
>
> If vfio_unpin_pages() is called here, that physical page could be reallocated
> by the host kernel for a different purpose before the delayed hardware DMA
> write completes.

Legitimate concern, will be fixed in v5

>

