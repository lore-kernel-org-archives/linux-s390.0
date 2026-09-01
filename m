Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BCB44AB98;
	Tue,  1 Sep 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299898; cv=none; b=Jl/j+C8FKPXrUY+cl+KmpedPSvtkRSWWEpZBEeH98qk9bTE+dCkCeZH60z3P9JkxsjtRClpyO0BXR6GiCalr0H64xShqCZlmEfj+NFhmAz017/itn2SB+pqLqcZhcVAbrjGeL1UYUw4YiinstjD0v1vAHN76xGOFAPsTNZcbdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299898; c=relaxed/simple;
	bh=UVhSg7XrPdoMaG5o+g32D4HimVqFFhiOvCsK4wF3N5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC2ZjlovqD4mPAqmu4kKDDLztYui6rMz1dw4BmgKkrDFXwy86+emES+H3XlA730cs4AA357M1Ojr1CXofGtWyzRDdV4ZziLCTXj2K8UBh9CkI1kNaukf06PMHzkUoQq9SfVtnvvSySvZZi9gnwBPxcxOg/InXJzrvns4EnAI06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Io1mC+9e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Io1mC+9e"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWjKV1100618;
	Tue, 1 Sep 2026 21:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uN/Rqy
	RZ3pTXFk6Ebhnuj7cWPcN+ZZPEbEQ+yvmhVLw=; b=Io1mC+9eFhSD2vegfRsHhJ
	FnYEMYo7ql4+jZurTK9PeP5UlA7a0Rb7m1szVAs31/+QU+pqyBEbryROvgpAI5Vb
	icY2O6XOnK3jKwQszYeBK2xWo+RFqD4cSFY+LdFDc424hg2SvbjeD4ZpvUs7sTcU
	G8SoSvKYA9EJmLea+IzE3NhokWl9eFYHTOOK6h1nw7Te3t0lGaONSyP4VEyMT/oK
	ygIFyE4DMEQtxGE30fPabDCZ1xfA0J5shHY3jcUNV6ky7CrZ3EU+ujltK6OkF7IC
	kCNXkDJPqPDB8XI4dRI8xarBIf3xdOfXg19ON+wmOczlA2xia3yENF1GjJgV2/Xg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudtkkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 21:58:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681LuIj8023801;
	Tue, 1 Sep 2026 21:58:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark67ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 21:58:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681LwCh520447866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 21:58:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E165D5805A;
	Tue,  1 Sep 2026 21:58:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67B6C5803F;
	Tue,  1 Sep 2026 21:58:12 +0000 (GMT)
Received: from [9.61.73.208] (unknown [9.61.73.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 21:58:12 +0000 (GMT)
Message-ID: <e7cf0651-592e-4ef4-85cb-e5b4237f3d56@linux.ibm.com>
Date: Tue, 1 Sep 2026 17:58:12 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable/disable()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
 <20260831171443.222225-2-akrowiak@linux.ibm.com>
 <20260831194029.3896A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260831194029.3896A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5bq0DO7hkEdihl4MEamgiT1L1PI04EaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE4OSBTYWx0ZWRfX2Wi1fV4jk3Ib
 yhosrysXwjrrk5gajIwRLrIb9MVvyMHu18+7utt3ylhO5Zu9UhYcd2FAdJHT1cIh4I6NfaztiuV
 pFrp0wwU9feJajeuFl3s4Cola2k4J8sGQxg9bAi8mOmRBfHHkP2zQV9o+uUt78UQ3W0BiWypA8d
 SfcOqBxFYz8bIvyaB/xUIcyopK9yVytaDeP3W11cKiRRuKLVqLMepbP7M3HQRVgKrz7TH4ycwX/
 g4pToqbylcl2IPOdnDxbCNjTat9p6W7tPqj2/rEFXmhl8XRFQar/c0W65EBXUt+WGChpySXhTjf
 ZeWFeH7sv6uMSt+dnfCxE85anj446CTs7V7X83/n7PLdS10OhPkU8uJLAmfAp3CTnQuyqTSGejw
 Exh83aaz2OXq4b4i1AuPDeFn+z6ES47Govo1ee015C3PK5sXnQT5mKiCrtU0QO1tpmcq/IGmaZ4
 tAAyM51Gg0YyMWeJBjg==
X-Proofpoint-ORIG-GUID: 5bq0DO7hkEdihl4MEamgiT1L1PI04EaR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE4OSBTYWx0ZWRfX0AVeC9W56DKA
 T45IXlJlRQCgkekH72Woz83eXhzjkG5ygkJKRVpv/DZijyuvoAtuRd6lvAMt1fH9Q4okRW6l/AO
 fxm1VGclnY/hC2vEoqCKVikrMTOt7f8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a974a76 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=901hlMp7ESEGSOvW2LsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_LUqkwqZatCW1lO1y2b-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010189



On 8/31/26 3:40 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Unbounded memory leak of newly pinned NIB pages and GISC registrations when `vfio_ap_irq_enable` times out.
>
> Pre-existing issues:
> - [High] Guest-triggerable WARN_ONCE introduces a host-side denial of service risk.
> --
>
> commit 82e69024e1f94318c978aa31bed7a9d1888b87e2
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable/disable()
>
> This commit modifies the cleanup of pinned NIBs and registered NISCs after
> PQAP(AQIC) instructions are executed. It introduces a wait loop to verify the
> asynchronous completion of the interrupt state transition before allowing
> the release of older resources.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..8fb0476e3d397 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> +static bool vfio_ap_wait_for_irqstate(int apqn, int ir)
>>   {
>>   	struct ap_queue_status status;
>>   	int retry = 5;
> [ ... ]
>> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
>> -		  __func__, status.response_code, apqn);
>> +	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts %s for %02x.%04x\n",
>> +		  __func__, status.response_code,
>> +		  ir ? "enabled" : "disabled",
>> +		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
>> +	return false;
>>   }
> [Severity: High]
> This is a pre-existing issue, but does this WARN_ONCE introduce a guest-driven
> host denial of service risk?
>
> If a guest issues a PQAP(AQIC) instruction and the hardware takes longer than
> expected to transition states, this wait loop times out and triggers a warning.
> Because the KVM subsystem strictly forbids guest-reachable WARN_ON macros,
> could a malicious guest artificially induce these delays (for instance, by
> spamming requests) to intentionally panic the host kernel if panic_on_warn
> is enabled?
>
> [ ... ]
>> @@ -317,8 +334,30 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>>   		switch (status.response_code) {
> [ ... ]
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
>>   	} while (retries--);
> [Severity: High]
> This is a pre-existing issue, but does this WARN_ONCE pose the same guest-
> driven denial of service risk?
>
> If the hardware returns an unexpected status code in response to a guest-
> initiated disable request, this warning is hit. Can an untrusted guest
> intentionally induce unexpected hardware states to trigger this warning and
> crash the host?
>
> [ ... ]
>> @@ -489,13 +557,49 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
>>   	switch (status.response_code) {
>>   	case AP_RESPONSE_NORMAL:
>> -		/* See if we did clear older IRQ configuration */
>> +		/*
>> +		 * AQIC initiates an asynchronous process; however, AP_RESPONSE_NORMAL
>> +		 * does not guarantee interrupts are enabled yet (i.e., IR bit (7)
>> +		 * is set). Wait to confirm before committing the new NIB and
>> +		 * freeing the old resources.
>> +		 */
>> +		if (!vfio_ap_wait_for_irqstate(q->apqn, AP_IRQ_ENABLED)) {
>> +			/*
>> +			 * Timed out waiting to verify IRQs are enabled. If the
>> +			 * hardware is merely stalled, it might eventually complete
>> +			 * and write interrupt status bytes to the new NIB.
>> +			 *
>> +			 * If the NIB page is unpinned and freed here, this delayed
>> +			 * hardware write would result in a host use-after-free/wild
>> +			 * DMA write and a host kernel crash.
>> +			 *
>> +			 * To prevent this, we must leak the new resources (leave the
>> +			 * NIB page pinned and Guest ISC registered) and return
>> +			 * AP_RESPONSE_OTHERWISE_CHANGED to signal the guest to retry.
>> +			 */
>> +			msg = "%s: Timed out waiting to verify IRQs enabled for apqn=%#04x\n";
>> +			VFIO_AP_DBF_WARN(msg, __func__, q->apqn);
>> +			memset(&status, 0, sizeof(status));
>> +			status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
>> +			break;
>> +		}
> [Severity: High]
> Will this timeout path result in an unbounded memory leak?
>
> When vfio_ap_wait_for_irqstate() times out, the code breaks out of the switch
> statement without storing the newly pinned 'nib' and registered 'isc' into
> q->saved_iova or q->saved_isc. These local variables appear to be permanently
> orphaned.
>
> Because a guest controls the PQAP calls, could an untrusted guest VM repeatedly
> trigger this timeout to deliberately leak pinned host pages and KVM GISC
> registrations until host memory is exhausted?
>
> Additionally, this seems to contradict the commit message which states:
> "The fix is to unregister the NISC and an unpin the NIB used in the AQIC
> call in the default case of the switch statement..."
> Here the code explicitly notes "we must leak the new resources". Is this
> omission of cleanup intentional?

After thorough review of the architecture, it has been determined that
there is no need to wait for the IR bit to clear. The only responsibilities
of the vfio_ap device driver when receiving a mandated exception of
the PQAP-AQIC instruction is to set up the GR2 and GR3 so the queue
interrupts will go to the guest, re-issue the PQAP-AQIC on behalf
of the user and return the CC and the status.response code returned
from the enable command. It is up to the caller on the guest to
check the IR bit to determine when the queue is enabled for
interrupts.

The other responsibility is to manage the pinned page containing the
NIB and the registration of the GISC.

* If AP_RESPONSE_NORMAL is returned from the AQIC, then
    q->saved_iova (the page pinned from the previous enable if it set)
    needs to be unpinned - making it available to another process - and
    the q->saved_isc (the guest ISC registered with the previous enable 
if set)
    needs to be unregistered. The new paged pinned and ISC registered
    before executing the AQIC need to be stored in q.

* For all other response codes, the new NIB needs to be unpinned and
    the new ISC needs to be unregistered since the other response codes
    indicate the AQIC was rejected.


>

