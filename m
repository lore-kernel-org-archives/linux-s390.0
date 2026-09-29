Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCD53A38D;
	Tue, 29 Sep 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701045; cv=none; b=Kv5tcZmy6LdLoRv0BhHui8O9TUsAbeNXn5EA7tMwYBuI0y32Jfr5SpR7VOQbnXfHkbdcmoIcGD6tcXz+Nt369OS8iDD5JAdwnpZ50vjDFPlgTsU2xdMHkHLrFlPDdFBvb7jOO0JRdAyOcct8qFFjZ+GeDzd+gQTgOI3o/mfO+Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701045; c=relaxed/simple;
	bh=8kkhWSLBFUa4+9QxUBFQ6d/1U9fhLDpXLuHQJyOLedA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJW1fywevvX9o2VJsDu9VnyC2JL0kDhqlEcLwGDQJ1I5zx5d6Hju7ttJVNBKqTfkidql9c1DRWWgeZZUpHN1rU7OdPfsK4BGYzCZq109uuCxFmcjJFWXKvLs74aPYryP4C9NSHrzHGExgOzEqy6ZSiz6YycY8+FsvsYbmVH8ET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KTIOBS1P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KTIOBS1P"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5X5X2187948;
	Tue, 29 Sep 2026 16:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wq/0bV
	RI7FzgPLTTsiKa8WJA6E6CA1Hxsz5L801Xmgs=; b=KTIOBS1Pv3m69OrO8Cx1A4
	guu5KzKx3KbroyUys82fr8fWF4qcCbrTwo86g0rvzPgmgkVFwYi/+BCb7hslwbIU
	r+fWACt96PZBvtD4GebK6zYiAMqiUq2JmIiYQaG0KBfnIlGjLVkgv04ClDKQFCC6
	0E6CxDVstzu1m312ZURYgWQX58YVwX/JWUBTc5Eb85BQsz9hXPUJQRYkd/qddRN4
	FbJNNGWDlUuAxmEUW5jzx5KgqaxxgbBJl6JHi03KEyTQlriKDxBgfvjRW9u6JXmn
	8UhM4FMIwA+GtOFQhrihLPS7N5kCwb9J6PlLWZ4ZIdznn2+Shu97w9DqnztP212g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr86vq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 16:57:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TF109w1647411;
	Tue, 29 Sep 2026 16:57:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2yacsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 16:57:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TGvKo823069374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 16:57:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA6DA58061;
	Tue, 29 Sep 2026 16:57:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 457375805A;
	Tue, 29 Sep 2026 16:57:19 +0000 (GMT)
Received: from [9.61.162.12] (unknown [9.61.162.12])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 16:57:19 +0000 (GMT)
Message-ID: <5c7cd376-2b86-45d9-b898-a8e927e2deb8@linux.ibm.com>
Date: Tue, 29 Sep 2026 12:57:18 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/6] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-4-akrowiak@linux.ibm.com>
 <20260929123815.287871F000FF@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260929123815.287871F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX5dWXnH0uKb9Y
 pQzNFzSmPZ3FmuJWQjuZJNSCdZ3YSb5WlnoeU41BQ6mAtYgl6HvH+iJpmh5IjRZ23creyXJKhnk
 HNPN5H3kjjmHuT8xY7MyF8bqqUZbIcBmLGk7E3HZRCRsnekdINFSDTAKWg7V+mBGJBu1dCr8f8B
 nkvdhopoA9TOHWrOq0u9wk1gBZ2hlriQYERBeSF01UfniEcR6lWDE8prlUQdkUFL+Z5HDtZ57Eq
 vA9zVenh9bSAurX+0OXO5Uru6luTJmd8ne+TXo8a7kVQJ2V8lNtjjhnGunPf9ozsG+aUOG6DpLz
 1rOc2gYYvUWt8y6KVsrTlZQVQL6YfwchGkrXd6EYVTwRr2nJcpYOjQdPOE3/hdk6qkVaW+S/oqE
 Iv8jTYlwO8fz8528rBh4qNSZaf1lWRtdHm4D/BLXtzag7W0VLI31eoAp7kU1RsDYdnAaXDgHHwb
 SSVHXDJuNSNO4sww0QQ==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbedf2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OakYlLxFb6o4_ZYK9GoA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: 8qK9x2e5DRBo5sSOH2mwhNt4QO69Oxve
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX6U4a9HB6pZ/U
 z6+OO0qDGFfK14C9nyn3Oce8JRGum8TQJxq/+2uG0uG5POsPuK1tsO7jrC9lBkItUT0+N97ZgSb
 05l1fMJVFPKW3W6CST5l/S+OlY5hzuE=
X-Proofpoint-GUID: 8qK9x2e5DRBo5sSOH2mwhNt4QO69Oxve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290066



On 9/29/26 8:38 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [Critical] crypto: zeroization bypass and DMA vulnerability if ZAPQ returns BUSY
> - [Critical] crypto: Use-After-Free of vdev pointer after reset timeout
> - [High] crypto: resource leak and erroneous WARN when ZAPQ returns BUSY
> - [High] crypto: zeroization bypass if non-reset state change completes at timeout
> - [Medium] crypto: spurious ZAPQs from conflating TAPQ and ZAPQ BUSY responses
> - [Low] crypto: dead code setting fallback reset status on timeout
> --
>
> commit 625818127ace62cbd33b251880fe0f1f6d732f69
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix unbounded loop in apq_reset_check()
>
> This commit fixes an unbounded wait loop in the apq_reset_check() worker by
> adding a 2000ms timeout. It also updates TAPQ status checks to accurately
> verify asynchronous queue zeroization completion before freeing AQIC
> resources.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 087e8474a34ab..07fbfa6f10152 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2164,6 +2164,12 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
>>   		return -EBUSY;
>>   
>>   	case AP_RESPONSE_BUSY:
>> +		/*
>> +		 * The queue is busy with something unrelated to a reset and our
>> +		 * ZAPQ was rejected outright. Re-issue the ZAPQ.
>> +		 */
>> +		return -EAGAIN;
>> +
> [Severity: Medium]
> Does returning `-EAGAIN` here trigger spurious ZAPQs by conflating TAPQ and
> ZAPQ BUSY responses?
>
> `apq_status_check()` evaluates the output of `ap_tapq()`. If `ap_tapq()`
> returns `AP_RESPONSE_BUSY`, it means the read instruction itself was
> transiently rejected. However, this code appears to incorrectly assume it
> means the previous ZAPQ was rejected outright, returning `-EAGAIN`.
>
> This forces the worker loop to immediately issue a new `ap_zapq()`, which
> overwrites `q->reset_status` and destroys the correct queue state tracking,
> likely leading to further failures.

Returning -EAGAIN causes apq_reset_check() to spuriously
issue a new ZAPQ and overwrite q->reset_status rather than continuing
to poll. We will change apq_status_check() to return -EBUSY on
AP_RESPONSE_BUSY.

>
> [ ... ]
>
>> @@ -2223,30 +2280,73 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   			 */
>>   			memcpy(&q->reset_status, &status, sizeof(status));
>>   			return;
>> -		}
>> -		if (ret == -EBUSY) {
>> +		} else if (elapsed >= AP_RESET_MAX_WAIT) {
>> +			/*Timed out without being able to verify zapq completed */
>> +			if (!ret || ret == -ENODEV) {
> [Severity: High]
> Does evaluating the timeout condition before the retry logic allow an
> unrelated state change completion to bypass the required zeroization step?
>
> If the initial ZAPQ returns `AP_RESPONSE_STATE_CHANGE_IN_PROGRESS`, the worker
> polls until it completes before retrying ZAPQ. If the state change completes
> exactly at `elapsed >= AP_RESET_MAX_WAIT`, `ap_tapq()` indicates the queue is
> idle, and `ret = 0`.
>
> Because the loop evaluates the timeout condition `else if (elapsed >=
> AP_RESET_MAX_WAIT)` before the ZAPQ retry logic, the timeout block executes
> `apq_reset_finalize()`, forces the status to `AP_RESPONSE_NORMAL`, and returns.
>
> The required `ap_zapq()` is entirely bypassed, leaving the queue unzeroized
> while freeing AQIC resources, resulting in a DMA vulnerability.

Thinking this through it makes no sense to issue a PQAP-TAPQ for
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS, because that response code is not 
valid for PQAP_TAPQ, so calling apq_status_check() will not tell us 
anything about the ZAPQ, because the response code indicates it failed 
to execute. The fix here is to check for 
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS as well as AP_RESPONSE_BUSY right 
after the msleep and update of timeout counter and continue the loop.
>
>> +				/*
>> +				 * Zeroization confirmed (ret == 0): the TAPQ status bits
>> +				 * indicate the async portion of the ZAPQ completed
>> +				 * successfully. Free AQIC resources and return.
>> +				 *
>> +				 * Queue non-operational (ret == -ENODEV): the queue is
>> +				 * deconfigured or checkstopped; interrupts are not
>> +				 * possible so AQIC resources can be safely freed.
>> +				 * Zeroization cannot be confirmed in this state, but the
>> +				 * queue cannot generate interrupts, so the NIB page is
>> +				 * no longer a DMA target and it is safe to free it.
>> +				 */
>> +				apq_reset_finalize(q, &status, ret);
>> +				return;
>> +			}
>> +
>> +			report_apq_reset_check_timeout(q);
>> +
>> +			/*
>> +			 * Zeroization could not be confirmed; set
>> +			 * reset_status to AP_RESPONSE_RESET_IN_PROGRESS.
>> +			 * This is used internally to signal that the reset
>> +			 * did not complete, and ensures that if the queue
>> +			 * is reset again, the re-issue logic in
>> +			 * apq_reset_check() will re-issue the ZAPQ.
>> +			 */
>> +			q->reset_status.response_code = AP_RESPONSE_RESET_IN_PROGRESS;
> [Severity: Low]
> Is this assignment to `q->reset_status.response_code` dead code?
>
> The timeout logic assigns `AP_RESPONSE_RESET_IN_PROGRESS` to theoretically
> trigger a re-issue during the next reset. However, the next reset requires
> calling `vfio_ap_mdev_reset_queue()`, which immediately executes
> `status = ap_zapq(q->apqn, 0)` and unconditionally overwrites
> `q->reset_status` via `memcpy`.

Valid. Setting q->reset_status.response_code to
AP_RESPONSE_RESET_IN_PROGRESS on timeout is overwritten on any
subsequent reset because vfio_ap_mdev_reset_queue() immediately issues
ap_zapq() and overwrites q->reset_status with the new ZAPQ status. We
will remove this redundant assignment.

>
>> +
>> +			return;
> [Severity: Critical]
> Does returning early here skip cleanup and leave `q->aqic_resources.vdev`
> as a dangling pointer?
>
> `q->aqic_resources.vdev` points to the `vdev` embedded in `ap_matrix_mdev`
> without holding a reference count. When the new timeout mechanism returns
> early without calling `apq_reset_finalize()`, it leaves
> `q->aqic_resources.vdev` populated.
>
> When the mediated device is removed, `vfio_ap_mdev_remove()` flushes the
> worker and calls `vfio_put_device()`, which frees the `ap_matrix_mdev`.
> This turns `q->aqic_resources.vdev` into a dangling pointer on a surviving
> `vfio_ap_queue`.
>
> Later, if the AP queue is unbound or reused, `vfio_ap_free_aqic_resources()`
> unconditionally dereferences this pointer via
> `vfio_unpin_pages(q->aqic_resources.vdev, ...)`, which could trigger a
> use-after-free on the host.

Valid. When apq_reset_check() times out without freeing AQIC resources,
q->aqic_resources.vdev retains a raw pointer to matrix_mdev->vdev. If
the mdev is subsequently removed, matrix_mdev is freed while the queue
remains bound. A later call to vfio_ap_free_aqic_resources() dereferences
the stale vdev pointer in vfio_unpin_pages(), causing a use-after-free.
We will handle stale pointer tracking to avoid this dereference.

>
>> +		} else if (ret == -EBUSY) {
>>   			pr_notice_ratelimited(WAIT_MSG, elapsed,
>>   					      AP_QID_CARD(q->apqn),
>>   					      AP_QID_QUEUE(q->apqn),
>>   					      status.response_code,
>>   					      status.queue_empty,
>>   					      status.irq_enabled);
>> +			continue;
>>   		} else {
>> -			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>> -			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
>> -			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
>> -			    ret == -EAGAIN) {
>> +			if (ret == -EAGAIN ||
>> +			    q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>> +			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS) {
> [Severity: Critical]
> Is it possible for `AP_RESPONSE_BUSY` to be missed in this retry check?
>
> If `ap_zapq()` inside the worker loop is rejected with `AP_RESPONSE_BUSY`,
> `q->reset_status.response_code` is set to `AP_RESPONSE_BUSY`.
> On the next iteration, if the queue becomes idle, `ap_tapq()` returns
> `AP_RESPONSE_NORMAL` (ret = 0).
>
> Since `AP_RESPONSE_BUSY` is missing from the retry condition, the worker seems
> to skip re-issuing the ZAPQ. It would fall through to `apq_reset_finalize()`,
> falsely overriding the status to `AP_RESPONSE_NORMAL` and freeing the AQIC
> resources. Can this leave secret keys intact and expose the host to wild
> DMA writes?

The AP_RESPONSE_BUSY was intentionally removed because it is not a valid 
response code from ZAPQ. If it is returned from ZAPQ, it will fall 
through to the default case in vfio_ap_mdev_reset_queue() because it is 
not architecturally possible to receive that response code for ZAPQ.
>
>> +				status = ap_zapq(q->apqn, 0);
>> +				memcpy(&q->reset_status, &status, sizeof(status));
>>   				continue;
>>   			}
>
> I also have a question about `vfio_ap_mdev_reset_queue()`:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_reset_queue() {
>      ...
> 	switch (status.response_code) {
> 	case AP_RESPONSE_NORMAL:
> 	case AP_RESPONSE_RESET_IN_PROGRESS:
> 	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
>      ...
> }
>
> [Severity: High]
> Does lacking `case AP_RESPONSE_BUSY:` here cause legitimately busy queues
> to fail in the default case?
>
> If the queue is transiently busy, ZAPQ returns `AP_RESPONSE_BUSY`. Execution
> falls to the `default:` branch, triggering a host WARN (falsely claiming a
> hardware bug) and intentionally leaking AQIC resources without queueing the
> worker to retry. Could this allow a guest that keeps the queue busy to cause
> resource leaks and kernel warnings on the host when the device is removed or
> reset?

See response to the previous question. Since AP_RESPONSE_BUSY is not a
valid response code for ZAPQ, it is in fact a hardware bug or an I/O
issue or something of the sort.

>

