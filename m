Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67943E06B;
	Wed, 26 Aug 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757973; cv=none; b=fEwXE0DhG2SFhYVWZnvdjbYuqqTTpFMTO5vxJmT2e+kZ6MKdzuRFPsUSLV6LxqBLlAgL/2w1dSTmT6w4fwFoKUsHNG47mMlct8TzRFGT1e3G0op8NoQp6naQgBDymg8BTLrL2foVNCw+cf9C0L2W1RwML+DXUHEpv7SOwrkMjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757973; c=relaxed/simple;
	bh=7IyDZ0s/GydxtolyVpLq8v22+Z0AOPAUCl+LMUWlh0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAS9Quq5oetJZs4tAJDBD6nQtEdPETUZywSbQmq8BsfaokV590vC/jEjuFx39xIn7ClI47Am+ARRtUtYJqlOBBDqqOmw0SuxHDoWaVihUG/+my79EsR2FEWH54kBDQEE9zD+t0HFgUZcBme0x8jxNyGPYE/j4rVyM0GjlePquCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b68/g829; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b68/g829"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1jh84099852;
	Wed, 26 Aug 2026 15:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vFZaXV
	96JCW1M3RkJfoXLd46a3WQxGEFbAq0U+hqbOM=; b=b68/g82955wX+noqP/M8Du
	UmXtdsgWgLKcLuCPCr2FEY89cqIz0rdI+8ipTNlky3UXVWQ8yOgZ6WKvBOOW+2/e
	nnNGOi0LMPUkwdw/QprgUcxvqhn+qn0N7m5qXmOeQTzHTO00fdRoMtOUF0FX0KLS
	wVhfCgDS6NXAOm3rCe1XTwTWsesgn24kFkAnHM67EWW3+jWKeYpi7MaMa7/EQ+Ck
	cJgGETtNeP9DFmIvVNGZ7ye1dqGv8MT70tgjtNNhWIAYWs45X89ZediTNysPEGfe
	WmGbJFso0CUoQc78sw9L/+3ae1IG5q9wuwEozCQg/q3FqmR5VSGo84RdFZgq3Ixg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hymym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:26:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QFBH1V004371;
	Wed, 26 Aug 2026 15:26:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhakxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:26:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QFQ4du30540406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:26:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5D2E58067;
	Wed, 26 Aug 2026 15:26:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0226158065;
	Wed, 26 Aug 2026 15:26:04 +0000 (GMT)
Received: from [9.61.175.92] (unknown [9.61.175.92])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:26:03 +0000 (GMT)
Message-ID: <012724fa-1979-4d46-8474-a7c8407a3c9b@linux.ibm.com>
Date: Wed, 26 Aug 2026 11:26:03 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
 <20260824215603.819379-4-akrowiak@linux.ibm.com>
 <20260824221128.891FB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260824221128.891FB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX9wdQRgcw/fnU
 IFYsjfnELnKCvxoV49VPUfFhSbuW9nNoHwv7+0N9IIXohVJ0lWn5aOJ6WeiIcG7M6klwPbyjf9N
 zbJirkUkQZp+A4C3+V2UTnO8+rcE4SA=
X-Proofpoint-GUID: Hzzh01mlRC5akCLOs9GzIQTprJmKsCqH
X-Proofpoint-ORIG-GUID: Hzzh01mlRC5akCLOs9GzIQTprJmKsCqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX5149zwK9tCsu
 1jMZT2nc9jfzNhIgbDTAH/WOmp9GadS27dZh5Go4TYofetzs6U0WMOe+dIYARzQxGjwyXd4ziF7
 AYoR8TUp+9YETDXzhYpKXBHMjr0ai/nm6mC8RI54rcxsl67uSabVyz1WhXFraKJzsBDv//uPEii
 4xV6LIdduBLXn4E/xYT7WAEtYOkmCQzgh8UbpQ2tT1tg8vwyvVeZ4m/kqrek0y6eP4JMTF9hvJ8
 MwtIooPVYDaOSpWL8cC8Sz2czzMSrZNdHAj++MizIQyak6V8lWq0ZoH0TQOPWnm63EhS1xgavI6
 1/v/QpzGviW4GuP+ltGa/qix8rZydFosIlNgMwqSAfFKckVrzmPBuzpp7ZiI/Cqwu/eFVYmRDnw
 RGXC9Iy1z6u/lk3OGsoVEdjbtDrs129FmU9xA0AMxvDLAux8nXmkWU3Bx/OvNuqs/iq2SOb+3YH
 vGZ/0ubC32aZLT08cUg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f058e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cNjGuAkbeVCNKkcG-F4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125



On 8/24/26 6:11 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
>
> New issues:
> - [Critical] The timeout mechanism intentionally skips unpinning the NIB page to avoid a driver-level UAF, but fails to realize the VFIO core will automatically unpin and free the page when the device is closed, resulting in a critical hardware DMA Use-After-Free.
> - [Critical] The timeout handler leaves `q->saved_iova` and `q->saved_isc` populated with the old guest's state, leading to cross-guest resource corruption when the queue is assigned to a new mdev.
> - [High] The timeout error path deliberately leaks the registered guest ISC and pinned NIB page, which permanently exhausts ISCs and directly causes a host kernel WARN when the KVM guest terminates.
> - [High] The worker can still loop indefinitely because the new timeout check is bypassed in the 'else' branch when retrying the reset via ap_zapq().
> - [Medium] The commit message explicitly claims that AQIC resources are freed on the early exit path, but the code does the exact opposite.
>
> Pre-existing issues:
> - [High] The worker returns early on `-EIO` without writing the final hardware status back to `q->reset_status`.
> --
>
> --- Patch [3]: [PATCH v2 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check() ---
> commit 84304c1f304fd7bd597c0aa370c7ee8ddc904d98
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix unbounded loop in apq_reset_check()
>
> This commit introduces a maximum wait timeout in the apq_reset_check worker
> to prevent indefinite loops when the hardware continuously returns a busy
> response. On timeout, the function writes the busy status back and breaks out
> of the loop.
>
>> Fix this by introducing AP_RESET_MAX_WAIT (2000ms) and breaking out
>> of the poll loop when elapsed time reaches that threshold. On
>> timeout the final busy status is written back to q->reset_status
>> so that callers inspecting reset_status.response_code after
>> flush_work() see a non-zero value and can return an appropriate
>> error. vfio_ap_free_aqic_resources() is called before returning
>> to release any KVM ISC registration and pinned NIB page,
>> consistent with all other early-exit paths in the function.
> [Severity: Medium]
> Is this description accurate? The code in the patch explicitly omits calling
> vfio_ap_free_aqic_resources() on the timeout path and includes a large
> comment explaining why it must leak these resources.

The description needs to change to match the code change.

>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 3f99b239fa959..7a9b5448e90a0 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -1971,6 +1972,27 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   					      status.response_code,
>>   					      status.queue_empty,
>>   					      status.irq_enabled);
> [Severity: High]
> This is a pre-existing issue, but does the early return on -EIO just above
> this block need to update q->reset_status before returning?

The response status returned from the tapq needs to be co

>
> If ap_zapq() initially succeeded, q->reset_status.response_code would be 0.
> If a subsequent ap_tapq() results in an -EIO from apq_status_check(), the
> function returns immediately. Will the caller vfio_ap_mdev_reset_queues()
> incorrectly assume the reset was successful because it sees a 0 response code?
>
>> +			if (elapsed >= AP_RESET_MAX_WAIT) {
>> +				/*
>> +				 * Timed out waiting for reset to complete.
>> +				 *
>> +				 * The AQIC resources associated with this queue - the pinned page
>> +				 * containing the NIB and the registered guest ISC - cannot be freed
>> +				 * here. The NIB is the active DMA target for AP interrupt delivery
>> +				 * until the reset completes; freeing the pinned page while the
>> +				 * hardware may still write to it would result in a use-after-free
>> +				 * kernel crash.
> [Severity: Critical]
> The comment mentions leaking the NIB page to avoid a use-after-free, but does
> the driver hold an independent reference to the page?
>
> When the user process terminates and the VFIO container is closed, the VFIO
> core automatically unpins tracked pages. Will the physical page be returned to
> the buddy allocator while the active hardware can still perform a DMA write to
> it, potentially corrupting memory reallocated to other processes?

Pages pinned via vfio_pin_pages() are reference-counted by the VFIO layer
and are not automatically unpinned unless the driver calls
vfio_unpin_pages(). The page is genuinely leaked (intentionally), not
silently freed.

The driver does hold an independent reference to the page, so it should
freed when the kvm is torn down, the mdev is removed, a queue is
removed from the device driver or a queue is unassigned from the mdev.
This will be fixed in a forthcoming patch.

>
>> +				 *
>> +				 * If the reset eventually completes, interrupts will be terminated
>> +				 * and the pinned NIB page and ISC registration will be leaked. This
> [Severity: High]
> By intentionally skipping vfio_ap_free_aqic_resources(),
> kvm_s390_gisc_unregister() is never called. Does this mean KVM ISCs are
> permanently depleted for the guest?
>
> Also, when the KVM guest is torn down, will kvm_s390_gisa_destroy() trigger a
> host kernel WARN due to the non-zero alert mask?

This is a legitimate concern. Similar to my response above, this will be
fixed in a forthcoming patch.

>
>> +				 * is preferable to either a use-after-free or waiting indefinitely:
>> +				 * apq_reset_check() holds the matrix_dev->mdevs_lock mutex, which
>> +				 * serializes access to all mdev objects system-wide, so blocking
>> +				 * here would stall all other guests using AP queues.
>> +				 */
>> +				memcpy(&q->reset_status, &status, sizeof(status));
>> +				return;
>> +			}
> [Severity: Critical]
> If the timeout handler leaves q->saved_iova and q->saved_isc populated, what
> happens when this queue is assigned to a new mdev?
>
> When the new guest enables interrupts, vfio_ap_free_aqic_resources() will
> process the old guest's saved IOVA and ISC using the new guest's KVM and
> VFIO container. Could this unpin an active page in the new guest or corrupt
> its GISA state?

This is a legitimate concern that will be fixed by clearing these resources
before any queue can get assigned to another mdev (see above responses).


>
>>   		} else {
>>   			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>>   			    q->reset_status.response_code == AP_RESPONSE_BUSY ||
>>   			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
>>   			    ret == -EAGAIN) {
>>   				status = ap_zapq(q->apqn, 0);
>>   				memcpy(&q->reset_status, &status, sizeof(status));
>>   				continue;
>>   			}
> [Severity: High]
> Does this bypass the timeout check entirely if apq_status_check() returns
> -EAGAIN?
>
> The loop will drop into this else block, re-issue ap_zapq(), update the
> status, and continue without evaluating the elapsed time. Will the worker
> spin indefinitely if the hardware continuously returns a state that triggers
> -EAGAIN?

Yes. This will be fixed in v3.

>
>>   			if (q->saved_isc != VFIO_AP_ISC_INVALID)
>>   				vfio_ap_free_aqic_resources(q);
>>   			break;
>>   		}

