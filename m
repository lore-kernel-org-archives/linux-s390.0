Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EB4FE2EE;
	Tue, 29 Sep 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680283; cv=none; b=TQw3wrF4v/GAHSswHICMIIXkBY8DoPzkIHK6a2PqWarQbgEPwM9KU0ldmazUKeYN2+L1mLCbIeEPdR5N2pb2tXIrOqWD59rGyP0DYeg9fFgITJBHWMb4AwQQMoS7gBON1QDuv2CSIv5xFwHO2vV53Y5X/oA1VWUopOLTddCCKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680283; c=relaxed/simple;
	bh=ZyyMkW5S1TM3sy3g1z9MwxHefuII4HNTK4qD5iAhAn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h85oX/KyJhoa5/TYuuHHDhTl0WRrTbNKZZoP1gLZfscydT2cczWt/dNzYt8ZX0YFk2WEqCv2P8MxYt7YxjswwCP2OxMez7op7LCu77P1xAVJDdYfLb026vQR8JJjwBU8styULQ6gJsDGxgsFCRMBpQvfXj81dvADGWmHqPOGSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xjy5v/dL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xjy5v/dL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5b7u2783627;
	Tue, 29 Sep 2026 11:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1noVY2
	vw/fnkEnLs97LTa80eKlAgUIq6tcCNC6juZ3A=; b=Xjy5v/dLCUZEsMMo5dGq1l
	qWkS8M/reQgbgKprBZ0BP6ikO9PtMWBa/a3xgS63kYf9ob8/6QLnCa9s7bL1drpb
	VCpYIqDGyr9nerPqPEsYcQSIq/xtUoDmYf8b/DC5wkor/dG+UorIgbrYfspeVHn/
	QWozi9vCCXUtUHnh8sS9GQ+tWJ+v8bCVl/F7asCkILSOFecIvhj511S2U2NGWPck
	A13/GZOWRJ/j83rKWPwvV/YSBGtaNrCcAfvWLZvQF1h7lbHEMCQ1c1d28H3OtNd4
	EotLkBoVZdo48d1k0I6nrNHA8uIqm1LZimO+3m+ADrBxaSBNf1Drh0Xao8+X32bw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe60ya-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:11:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAldpR1667746;
	Tue, 29 Sep 2026 11:11:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhhbdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:11:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBBI9A33751578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:11:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AD3B58054;
	Tue, 29 Sep 2026 11:11:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14C2658045;
	Tue, 29 Sep 2026 11:11:17 +0000 (GMT)
Received: from [9.61.24.130] (unknown [9.61.24.130])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:11:16 +0000 (GMT)
Message-ID: <af150dee-b942-4bb6-a25b-5c8be9f98b73@linux.ibm.com>
Date: Tue, 29 Sep 2026 07:11:16 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-4-akrowiak@linux.ibm.com>
 <20260925130031.739B01F00898@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260925130031.739B01F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abb9cd7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PggxQ46kYxiAi-Y4iioA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXy9HRfLijL5HL
 zx0kwWsCBC+Jo7OunbIZRtpfwetpZnB+sNpIs8X8zdxXw2B1aSguqSWHSzfnwuoqOMBJ7ZmFVgw
 hBEJXHXAbLgKEjN/EiiqkH47leckuss=
X-Proofpoint-ORIG-GUID: D8RaYGAv2Jo5y49noU0srvwd5_fmVw5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX+pvGNWhleGbM
 fvVjIUkHIde0deL+yOdksd1m93ltkSzxoIlyjfDiojoaGP+bXmJ2o8KXW+oVaPvUmq+pzdyKgj8
 kNQA/DBAjf52Lmk0ugH+kYIe4jJupyrwN20N8bplkon91RzlLEKuMjgmNRTcwlWs31JfqzFp2h7
 DxQx+9KasSG0RUdGjWwgj/2sxDd3Ep8gNBQ540H4OEBLyKvfQanoRlqnh5Yibz0VMZbPiKKH2k+
 9mSM5QEDzPcb2oEVmdW2rOWu8v/XfeghIYVbgV8bCurXITBxA3ue+XusMBkGW6V1Ax+oKGIgECU
 2UogKRNY6QPqmAvJRlD/WYqxbkGyUILlhAC0h83o0R4PF0BPD/VdQkq0lfpqF5j1fE+rPJ8EIU0
 C6n7nUg550VAxrcBkPQqen9hbjJRv4MR+HF9IhZ9faDxwAE0fP4uA1u4/nG0dfW3zbW9WMlSkiV
 LUyM1agMu+FgnJYqFTg==
X-Proofpoint-GUID: D8RaYGAv2Jo5y49noU0srvwd5_fmVw5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044



On 9/25/26 9:00 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [Critical] s390/vfio-ap: unmap_iova() defeats timeout leak, causing wild DMA write
> - [Critical] s390/vfio-ap: vfio_ap_mdev_reset_queue() abandons reset on AP_RESPONSE_BUSY
> - [Critical] s390/vfio-ap: apq_reset_check() falsely reports zeroization complete
> - [High] s390/vfio-ap: apq_reset_check() infinite loop on AP_RESPONSE_BUSY
> - [High] s390/vfio-ap: cross-guest resource corruption due to dangling IOVA/ISC
> - [Low] s390/vfio-ap: dead code and ineffective state handling on reset timeout
> --
>
> commit 3205ec637b4cfa8d70d28a8f5abc909aba0bd19c
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> Subject: s390/vfio-ap: Fix unbounded loop in apq_reset_check()
>
> The commit introduces a 2000ms timeout to apq_reset_check() to prevent
> indefinite spinning when the hardware continuously returns a busy response.
> If the timeout is reached, the NIB page and ISC registration are intentionally
> leaked to avoid memory corruption from potential wild DMA writes. It also
> corrects the confirmation logic by checking multiple status bits returned
> from TAPQ.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..47d4936fb9d7c 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -1857,8 +2006,28 @@ static void unmap_iova(struct ap_matrix_mdev *matrix_mdev, u64 iova, u64 length)
>>   	int loop_cursor;
>>   
>>   	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
>> -		if (q->saved_iova >= iova && q->saved_iova < iova + length)
>> +		if (q->saved_iova >= iova && q->saved_iova < iova + length) {
>>   			vfio_ap_irq_disable(q);
>> +			/*
>> +			 * If IRQ disable failed or IR=0 could not be confirmed,
>> +			 * vfio_ap_irq_disable() intentionally leaks the NIB to
>> +			 * prevent a wild DMA write. But vfio core requires the
>> +			 * page to be unpinned before dma_unmap returns, or it
>> +			 * will BUG_ON after 10 re-notification rounds.
>> +			 *
>> +			 * Fall back to a bounded queue reset. The ZAPQ zeroizes
>> +			 * the NIB pointer in hardware, eliminating the DMA risk
>> +			 * that justified the leak. Once the worker finishes (or
>> +			 * times out with a reset confirmed in-progress), the
>> +			 * hardware no longer holds a reference to saved_iova and
>> +			 * it is safe to unpin unconditionally.
>> +			 */
>> +			if (q->saved_iova) {
>> +				vfio_ap_mdev_reset_queue(q);
>> +				flush_work(&q->reset_work);
>> +				vfio_ap_free_aqic_resources(q);
> [Severity: Critical]
> Could this sequence unconditionally free the AQIC resources immediately after
> the timeout completes, defeating the deliberate leak?
>
> apq_reset_check() intentionally leaks the NIB page on timeout because hardware
> might still be actively writing to it. However, unmap_iova() executes
> flush_work(&q->reset_work) and then unconditionally checks q->saved_iova.
>
> Because the timeout path didn't clear saved_iova, unmap_iova() immediately
> unpins the page via vfio_ap_free_aqic_resources(). Returning an active DMA
> target to the page allocator could cause host memory corruption via wild DMA
> writes.

Asked and answered in response to same comment in patch 1/6.

>
>> +			}
>> +		}
>>   	}
>>   }
> [ ... ]
>> @@ -1959,8 +2220,77 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   		elapsed += AP_RESET_INTERVAL;
>>   		status = ap_tapq(q->apqn, NULL);
>>   		ret = apq_status_check(q->apqn, &status);
> [ ... ]
>> +		if (!ret || ret == -ENODEV) {
>> +			/*
>> +			 * Zeroization confirmed (ret == 0): the TAPQ status bits
>> +			 * indicate the async portion of the ZAPQ completed
>> +			 * successfully. Free AQIC resources and return.
>> +			 *
>> +			 * Queue non-operational (ret == -ENODEV): the queue is
>> +			 * deconfigured or checkstopped; interrupts are not
>> +			 * possible so AQIC resources can be safely freed.
>> +			 * Zeroization cannot be confirmed in this state, but the
>> +			 * queue cannot generate interrupts, so the NIB page is
>> +			 * no longer a DMA target and it is safe to free it.
>> +			 */
>> +			apq_reset_finalize(q, &status, ret);
>> +			return;
> [Severity: Critical]
> Does this immediate return prevent the rejected ZAPQ instruction from being
> reissued, bypassing queue zeroization entirely while falsely reporting success?
>
> If the initial ap_zapq() is rejected (e.g., returns
> AP_RESPONSE_STATE_CHANGE_IN_PROGRESS), apq_reset_check() is queued without the
> queue being zeroized. apq_reset_check() polls with ap_tapq().
>
> Once the hardware state change finishes, ap_tapq() returns AP_RESPONSE_NORMAL
> (queue empty). apq_reset_check() sees !ret, executes apq_reset_finalize(),
> and returns success.
>
> The ZAPQ command is never reissued. The queue is falsely marked as reset and
> can be assigned to a new guest with the previous guest's cryptographic secrets
> intact.

This is a legitimate concern and will be fixed in v9 of the series 
forthcoming.

>
>> +		}
>> +
>> +		if (elapsed >= AP_RESET_MAX_WAIT) {
>> +			/*
>> +			 * Timed out without being able to verify zapq completed.
> [ ... ]
>> +			 */
>> +			report_aqic_resource_leak(q);
>> +			/*
>> +			 * Zeroization could not be confirmed; set
>> +			 * reset_status to AP_RESPONSE_RESET_IN_PROGRESS.
>> +			 * This is used internally to signal that the reset
>> +			 * did not complete, and ensures that if the queue
>> +			 * is reset again, the re-issue logic in
>> +			 * apq_reset_check() will re-issue the ZAPQ.
>> +			 */
>> +			q->reset_status.response_code = AP_RESPONSE_RESET_IN_PROGRESS;
>> +
>> +			return;
> [Severity: High]
> Can leaving q->saved_iova and q->saved_isc populated after the timeout corrupt
> cross-guest resources?
>
> If the queue is assigned to a new guest, q->matrix_mdev points to the new
> guest's matrix_mdev. When the new guest enables interrupts,
> vfio_ap_free_aqic_resources() is called.
>
> It uses the new q->matrix_mdev to unpin the old q->saved_iova and unregister
> the old q->saved_isc, corrupting the new guest's IOMMU pinning counts
> and KVM ISC refcounts.

This is a legitimate concern; The guest ISC needs to be unregistered 
using the
kvm pointer used to register it if possible. The pinned NIB page needs to be
freed using the vfio_device whose IOMMU container owns the pinned NIB
page. This will be fixed in v9 of the series forthcoming.

>
>> +		}
>> +
>>   		if (ret == -EBUSY) {
>>   			pr_notice_ratelimited(WAIT_MSG, elapsed,
>>   					      AP_QID_CARD(q->apqn),
>> @@ -1968,18 +2298,15 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   					      status.response_code,
>>   					      status.queue_empty,
>>   					      status.irq_enabled);
>> -		} else {
>> -			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>> -			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
>> -			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
>> -			    ret == -EAGAIN) {
>> -				status = ap_zapq(q->apqn, 0);
>> -				memcpy(&q->reset_status, &status, sizeof(status));
>> -				continue;
>> -			}
>> -			if (q->saved_isc != VFIO_AP_ISC_INVALID)
>> -				vfio_ap_free_aqic_resources(q);
>> -			break;
>> +			continue;
>> +		}
>> +
>> +		if (ret == -EAGAIN ||
>> +		    q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>> +		    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS) {
> [Severity: Low]
> Is this condition checking dead code because earlier flow control guarantees
> ret == -EAGAIN is always true here?
>
> The code attempts to signal a failed reset by setting
> reset_status.response_code = AP_RESPONSE_RESET_IN_PROGRESS on timeout.
>
> However, vfio_ap_mdev_reset_queue() overwrites reset_status unconditionally
> with the result of a new ap_zapq() call on the next reset attempt, rendering
> the signal useless. Furthermore, the conditional check for this status inside
> apq_reset_check() is completely unreachable because execution only reaches that
> block if ret == -EAGAIN, which short-circuits the OR condition.

The premature early exit for !ret needs to be removed from the top of 
the loop.
When the worker starts after an initial ap_zapq() returns
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS or AP_RESPONSE_RESET_IN_PROGRESS,
TAPQ might initially report AP_RESPONSE_NORMAL (returning ret = 0); in 
this case,
the queue will not have been reset/zeroized, so we need to let it fall 
through to
the block above. This will be fixed in the forthcoming v9 of the series.


>
>> +			status = ap_zapq(q->apqn, 0);
>> +			memcpy(&q->reset_status, &status, sizeof(status));
>> +			elapsed = 0;
> [Severity: High]
> Will this repeatedly reset the timeout counter when dealing with busy
> responses, bypassing the timeout logic?
>
> If the hardware continuously returns AP_RESPONSE_BUSY, apq_status_check()
> maps this to -EAGAIN. In apq_reset_check(), if ret == -EAGAIN, the elapsed
> timeout counter is reset to 0, completely bypassing the new 2000ms timeout
> logic.
>
> This causes the worker to spin indefinitely, deadlocking the host system as
> callers hold global mutexes like mdevs_lock while waiting on flush_work().

The the 'elapsed' timeout counter should not be reset to 0.
If the hardware continuously returns busy / EAGAIN responses, the
loop will be guaranteed to exit once elapsed >= AP_RESET_MAX_WAIT (2000ms),
preventing any unbounded spinning or host deadlock.

>
>>   		}
>>   	}
>>   }
> [ ... ]
>> @@ -1995,18 +2322,27 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>   	switch (status.response_code) {
>>   	case AP_RESPONSE_NORMAL:
>>   	case AP_RESPONSE_RESET_IN_PROGRESS:
>> -	case AP_RESPONSE_BUSY:
>>   	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
>>   		/*
>>   		 * Let's verify whether the ZAPQ completed successfully on a work queue.
>>   		 */
>>   		queue_work(system_long_wq, &q->reset_work);
>>   		break;
> [Severity: Critical]
> Would removing AP_RESPONSE_BUSY here cause the flow to fall through to the
> default error case?
>
> If the initial ap_zapq() returns AP_RESPONSE_BUSY, it falls to the default
> case, aborting the reset and not queueing the reset_work.
>
> This leaves the cryptographic queue unzeroized, leading to an information
> leak when the queue is reassigned.

The AP_RESPONSE_BUSY (05) response code is not a valid response for
ZAPQ according to the architecture; so, it makes sense to let it fall 
through
to the default case since it is architecturally incorrect.  On the other 
hand,
AP_RESPONSE_BUSY is valid for TAPQ which is used by apq_status_check()
to verify whether a reset has successfully completed. If TAPQ returns
AP_RESPONSE_BUSY, the status check returns -EAGAIN so the ZAPQ
is re-issued.

>

