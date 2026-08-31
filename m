Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEB3D412B;
	Mon, 31 Aug 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179932; cv=none; b=gfVZc6BrWHsPtBVGoHHH+YJVoQZpW8Vzu6mMdxqatC8snvNCc0NBOkPibUck0pKS+NzeG7t2E6mpYDrHPPRFTHnom/djozR3Ce+zsY2UIYpRq0TRvagoTsYg8c6jRkRx/U0+cmmIYnepXXLvk6d1uA1499x0i/3drWCrhjnrhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179932; c=relaxed/simple;
	bh=0hgLm5DHq1vq36c5PXnjohJW19MNVXBX09vpqiKOjEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFR2I0/lckLqo3z4MAD3DR8JD8Endp6+u2BCQrpohBD/Hz4I7yssRTwbHShTGANgqc/CjZ24I+TZ+xA/HC9F4jejNujXOxnX37eC3Ufi+3n2S9aOTTJLF1ARKLyIJoGVjXNQgv+fn9b2NqvzFNwGJ2xSFec7Fgk8D6U0AaFQdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HjHxTfg1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HjHxTfg1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBVed72088347;
	Mon, 31 Aug 2026 12:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8gzkJJ
	4zvaruZfp8DKnUZXzCVf3gQ5FSUz4NrgBFc7k=; b=HjHxTfg1VX6Kw1jdMzLb+1
	Lb+uAR4OHec6S4jhJ+bd5yyUPCEMhT0QaG+/PD7Kx7Ncccwct+oJDUKlnnaF6t1A
	gxANEswzCO1ia2OCf7+hO6RMdC3MRuu6f/WPkx0TmcblE4Fu3eucjN9tfz3vzjbW
	YGgCDU8RkIN+PWiLn7BJEUYYiT104dHhtTXuVgmJR4v2SvoqJ/gLTZ+UULNMFKgr
	VbcHoJlyujzXu5BoO+qT1M9RbTlnD2EzoJN5BTisk+tYBJ1Z242MR3MCyAq6Aj6P
	OcTR2DnpUF39cq511ctfYQkjl6K6T36sY9Auq1qAhxxYtEqNPYgfaxjCbIBJYPYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx598vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 12:38:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VCQFcQ015577;
	Mon, 31 Aug 2026 12:38:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexwm8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 12:38:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VCckWx26280672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 12:38:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E026258056;
	Mon, 31 Aug 2026 12:38:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44D7A58052;
	Mon, 31 Aug 2026 12:38:46 +0000 (GMT)
Received: from [9.61.29.117] (unknown [9.61.29.117])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 12:38:46 +0000 (GMT)
Message-ID: <8b10d2d5-1039-4165-9e55-9ae09ea4e2ba@linux.ibm.com>
Date: Mon, 31 Aug 2026 08:38:45 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
 <20260828214653.1087009-4-akrowiak@linux.ibm.com>
 <20260828220201.595A81F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260828220201.595A81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9575d8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=BQq3glUuSdYeObrb-csA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pO9kvgHlZm3yYpJWGD5EmQElmtNrADqM
X-Proofpoint-ORIG-GUID: pO9kvgHlZm3yYpJWGD5EmQElmtNrADqM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwOCBTYWx0ZWRfX15MwphLewJlT
 /2rT9s9WIWMdR1hJKoCeKZOyX7ruNTT+GT/1MkC4HL6n4WTugtnoOeuc1aqGW0I/BPlw7MKYmcj
 1FpPtrN72nD5mqjktkQjjBipw9xYpOI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwOCBTYWx0ZWRfX5LZXdSFSNlm0
 LrP2zWVZOvWaXicyR7sX89dU6QIN6Uldgu6BNe4KBUbmNP6at3MS5e9TOkgMgN1Y/HW/enlQwP8
 na5jg+yMOXfMG3pKtKWmBfnq9EtT147Hwmz4dBjyXZhiLsRXe5ZcgKZMUSRw7PwhrnXszzPmCvE
 XN3vvhyaE4T4eM8AgFU8SGJju8zeyWdEaw24bFPB90O6WCGfIWfYcy4/cVoi7lfFxYQ02AE6gDI
 ERPqHWW+PLbkLEOHys5qvavjM3taWJXcxadoCCaaSWYiUtoXyUiwCoI/MuToHkqWWlnJ3qmAsWz
 yKgx1or0Ss5db6USYwS12+XRkie9pPYGrSK0UOx3hmFLI7aNKPJJNA+R/dLjjp01ySweQbfMqgH
 UbNZgPPH/W0zT2uey8BmBseucri4TJgG8p6g3yHPg4WLNkZEuXtoIwtBLtj0vSGb/XgNO0glMtG
 Dj05MxFvXsv3fLEq8Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310108



On 8/28/26 6:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] The timeout path incorrectly treats an idle queue state as a completed reset, bypassing the necessary zeroize command and causing Use-After-Free.
> - [High] The reset operation silently reports success to callers when the reset times out, masking the failure and misleading userspace.
> - [Medium] The `elapsed` timer is not reset when a new reset command is issued, causing subsequent resets to prematurely time out.
> --
>
> commit 3ef072206a03ac06e2b0604371727e31f5cba1a8
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix unbounded loop in apq_reset_check()
>
> This commit introduces a 2000ms timeout for queue reset operations in
> apq_reset_check() to prevent indefinite blocking in the worker thread.
> Upon timeout, it skips freeing AQIC resources to avoid a use-after-free,
> leaking them instead.
>
> Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
> Cc: stable@vger.kernel.org
>
> The commit message states:
>
>>     Note that on timeout, q->reset_status will hold the status from the most
>>     recent reset operation so that callers inspecting
>>     q->reset_status.response_code after flush_work() will see the value
>>     and can return an appropriate return code.
> Is this description accurate?

Yes

>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 363d9e53e2490..3f5b012be450c 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2067,6 +2068,37 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   		ret = apq_status_check(q->apqn, &status);
>>   		if (ret == -EIO)
>>   			return;
>> +		if (elapsed >= AP_RESET_MAX_WAIT) {
>> +			/*
>> +			 * If the status check determined that the reset completed
>> +			 * successfully or the queue is not operational, clean up
>> +			 * the AQIC resources because queue reset disables
>> +			 * interrupts, or because interrupts are not possible on a
>> +			 * non-operational queue.
>> +			 */
>> +			if (!ret)
>> +				goto done;
> [Severity: Critical]
> Does this incorrectly treat an idle queue as a successfully reset queue?
>
> If the queue is continuously busy for 2000ms, the initial ap_zapq() command
> is rejected (returning AP_RESPONSE_BUSY). On the exact iteration where
> elapsed reaches AP_RESET_MAX_WAIT (2000ms), if the queue finally stops being
> busy, ap_tapq() returns 0.
>
> Could this misinterpret the 0 as a completed reset, jump to done, and free
> the AQIC resources? Since the queue was never actually zeroized, interrupts
> remain enabled. Can this lead to a host kernel use-after-free if the hardware
> writes to the freed NIB page?

After further review of the architecture, it can't be assumed that 
AP_RESPONSE_VALID
indicates the zeroize is complete because the initial response code only 
indicates
that the ZAPQ was successfully initiated, but the zeroizing of the queue 
is being
done asynchronously. To verify it has completed, the following bits in 
the status
returned from TAPQ must be checked:

queue_empty == 1
replies_waiting == 0
irq_enabled == 0
async == 0

This will be fixed in v5

>
>> +			/*
>> +			 * Timed out without being able to verify reset completed.
>> +			 *
>> +			 * The AQIC resources associated with this queue - the pinned page
>> +			 * containing the NIB and the registered guest ISC - cannot be freed
>> +			 * here. The NIB is the active DMA target for AP interrupt delivery
>> +			 * until the reset completes; freeing the pinned page while the
>> +			 * hardware may still write to it would result in a use-after-free
>> +			 * kernel crash.
>> +			 *
>> +			 * If the reset eventually completes, interrupts will be terminated
>> +			 * and the pinned NIB page and ISC registration will be leaked. This
>> +			 * is preferable to either a use-after-free or waiting indefinitely:
>> +			 * the caller of apq_reset_check() holds mdevs_lock while flush_work()
>> +			 * blocks holds the matrix_dev->mdevs_lock mutex, which
>> +			 * serializes access to all mdev objects system-wide, so blocking
>> +			 * here would stall all other guests using AP queues.
>> +			 */
>> +
>> +			return;
> [Severity: High]
> Does this return early on timeout without updating q->reset_status to indicate
> a failure?
>
> If the queue reset times out and q->reset_status.response_code was 0 from the
> initial accepted command, it remains unmodified.
>
> Would callers like vfio_ap_mdev_reset_queues() check this unmodified response
> code, incorrectly assume the reset succeeded, and mislead userspace into
> believing the VFIO device was successfully reset while the hardware is still
> operational?

See previous response

>
> [ ... ]
>
>> @@ -2083,11 +2115,13 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   				memcpy(&q->reset_status, &status, sizeof(status));
>>   				continue;
> [Severity: Medium]
> Is the elapsed timer supposed to be reset when a new reset command is issued
> here?
>
> If the queue is initially busy, takes time (e.g., 1980ms) to become idle, and
> requires a retry of the ap_zapq() command, the next loop iteration will
> instantly hit the 2000ms limit because elapsed was not cleared.
>
> Could this prematurely time out subsequent legitimate reset operations and
> result in resource leaks?

This makes sense and will be changed for v5.

>
>>   			}
>> -			if (q->saved_isc != VFIO_AP_ISC_INVALID)
>> -				vfio_ap_free_aqic_resources(q);
>> -			break;
>> +			goto done;
>>   		}
>>   	}
>> +
>> +done:
>> +	if (q->saved_isc != VFIO_AP_ISC_INVALID)
>> +		vfio_ap_free_aqic_resources(q);
>>   }

