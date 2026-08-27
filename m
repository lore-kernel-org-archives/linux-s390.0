Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7930FC26;
	Thu, 27 Aug 2026 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861091; cv=none; b=kGLjy2FfO0DXX9ULsj3Hhqg9fsec/0iMSXeOOtUzAafFl/Asy8GJB7Eid3PtD8KcaWpEGCeSRxapO9stubMY8NP89T0QmxPfZ8e3nwJW7uQMICeebjTwKmY1l6AvalmKrvLcIw+34fqA6QyUKJhYYQeyVg3FzTdDGY49mnk06g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861091; c=relaxed/simple;
	bh=1il3nJbdBJw952zYQSTsRc3RMGT5iPsRTZkbafYZ+QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRg8AEMHDh8chtnd48COFxi0hzndskWqTvU2bohFXrsCJgvRWOkkczX+u3d2Bjs0zXPDSMEYx6uoWzGlYXUTy+KLu2gvBOPuCYRfX9G9AuagzIGdyayaFwPDtzKdUI+BWVuJPEHMN+azF6+26R9wsTYFeRZPRnCsf3AdxZfCIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gqURWQ7z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gqURWQ7z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RJVVNJ3940290;
	Thu, 27 Aug 2026 20:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CsgVab
	weD5B0k3oqK+TvQ7ye6YOVkWb9TXW1DSzp3Zk=; b=gqURWQ7zpmXgYl0n02MY3I
	sYBdTK9gYrgr4RQZBV4+d32u2LGxJTTfCXMKqPJdm/c46apdrRK8NWt4TuxMzfVu
	Asa62MAZHrUA8PmK2A0OIzrNokvrvdVghyOsYpm6wwkSVv/UvzhRC/iW9E0RqfF+
	UpUpT5LyInSpa0J5ZXiAWZKM8Rr0D7raK1XxB+8JOV30cCQkjzs9yPEi0TVo8ftn
	6cRusrlx1YqLDyge+IsBmi4ma4BXE31iYli/4/6dHZknYpxYuTffdSJfIaIotJuQ
	RjjE5V4CHokRe+lx2p/41dC7/XRwYYjvsqRhI6iN+k4Vwj7mlm0ePNIvYC/a88lg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394fsuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 20:04:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RJuGqO028392;
	Thu, 27 Aug 2026 20:04:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyhuad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 20:04:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RK4kI932309972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 20:04:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD5458051;
	Thu, 27 Aug 2026 20:04:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A24FC5805E;
	Thu, 27 Aug 2026 20:04:45 +0000 (GMT)
Received: from [9.61.15.38] (unknown [9.61.15.38])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 20:04:45 +0000 (GMT)
Message-ID: <b8449e09-945c-4e43-bf6c-abb6d87c63b4@linux.ibm.com>
Date: Thu, 27 Aug 2026 16:04:45 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
 <20260827132441.555866-4-akrowiak@linux.ibm.com>
 <20260827134318.D34871F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260827134318.D34871F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e2gQngnGlkfolhfMqVsyYzs2VHDt6Duc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE2OSBTYWx0ZWRfX7L1F3kCtCRA6
 Qh7AgdTQbhHSPXnNskwUf1lSOfh/41NcdNdyCuqq5YVrR3AacGLremKVqmA5RrcwCI0bpcb8nRZ
 MRZkdQ2x/E5oBbrYA+vkmK+L6e3UiQ4/0QNnE5Tx8lijHreD+ivgEeUKS8pbTSiCNkjzDwrAMG+
 sZIjXxmJGpUo55Z/kBm6cbnrMFITCmsPYVNLe+eSmuPeiKPwx12w96egB3LvBWeSpHf3lNHXD3F
 36tO35dX9kovIMThWvdf4dXMnizUljf6z1b6KzSTadjb9Ihx9ngePK7av1+TRXVNLM6Uuh/67Jr
 gygfKFIF5u7J2mSH8mTd+HKkZzFsnM9ReDkW+pS6k2lBIxL6ZZg6Iv0YZq5ORsEN0OPRThhSMvv
 dyw/rmfIN/GorqR5jVm2/H28QgLzmCbPYU5OztTWx+vLnXw9iBrZLf+6urAey124gMChFzW2yae
 UTULeFzRpT3dE0G7Gxg==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a909860 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=wW7R1OCKvlurdSdFt8YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE2OSBTYWx0ZWRfX+YhLLkkzrBic
 fbOWWwqJeFuZ1H9WSWsoFpoZeQLTh/EdMZ/93GxMAjoeXqkDgM/+V0ZPPzeKKvYRJge2QfosW60
 sQoLma2dHRzYL9Hi9O9hEYJ1BpVWnz8=
X-Proofpoint-ORIG-GUID: e2gQngnGlkfolhfMqVsyYzs2VHDt6Duc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270169



On 8/27/26 9:43 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The timeout condition is evaluated before checking for a successful reset, causing the driver to falsely report success while skipping required resource cleanup if success occurs exactly at the timeout boundary.
> - [High] The timeout path fails to clear `q->saved_isc`, leading to Cross-VM KVM interrupt routing corruption when the queue is reassigned to a new guest.
> --
>
> commit bdd9b4236348c839f4b1d25d5fe39d6e047b2068
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix unbounded loop in apq_reset_check()
>
> This commit introduces a 2000ms maximum wait time for AP queue resets in
> apq_reset_check() to prevent indefinite spinning. If the reset times out,
> the function breaks out of the loop and leaves the AQIC resources pinned to
> avoid use-after-free issues.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 4c32fd6eaaa63..a9a33f4949a0e 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -2016,8 +2017,32 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   		elapsed += AP_RESET_INTERVAL;
>>   		status = ap_tapq(q->apqn, NULL);
>>   		ret = apq_status_check(q->apqn, &status);
>> -		if (ret == -EIO)
>> +		if (ret == -EIO) {
>> +			memcpy(&q->reset_status, &status, sizeof(status));
>>   			return;
>> +		}
>> +		if (elapsed >= AP_RESET_MAX_WAIT) {
>> +		/*
>> +		 * Timed out waiting for reset to complete.
>> +		 *
>> +		 * The AQIC resources associated with this queue - the pinned page
>> +		 * containing the NIB and the registered guest ISC - cannot be freed
>> +		 * here. The NIB is the active DMA target for AP interrupt delivery
>> +		 * until the reset completes; freeing the pinned page while the
>> +		 * hardware may still write to it would result in a use-after-free
>> +		 * kernel crash.
>> +		 *
>> +		 * If the reset eventually completes, interrupts will be terminated
>> +		 * and the pinned NIB page and ISC registration will be leaked. This
>> +		 * is preferable to either a use-after-free or waiting indefinitely:
>> +		 * the caller of apq_reset_check() holds mdevs_lock while flush_work()
>> +		 * blocks holds the matrix_dev->mdevs_lock mutex, which
>> +		 * serializes access to all mdev objects system-wide, so blocking
>> +		 * here would stall all other guests using AP queues.
>> +		 */
>> +			memcpy(&q->reset_status, &status, sizeof(status));
>> +			return;
> [Severity: High]
> Does this code falsely report success while skipping required resource cleanup
> if the reset succeeds exactly at the timeout boundary?
>
> Because this timeout condition is evaluated before checking if the response is
> successful, if ap_tapq() returns AP_RESPONSE_NORMAL on the exact iteration
> where elapsed reaches AP_RESET_MAX_WAIT (2000ms), it is treated as a timeout.
>
> The loop exits without calling vfio_ap_free_aqic_resources(), but copies the
> success status into q->reset_status, meaning the caller thinks the reset
> fully succeeded.

Ironically I was just reviewing this code and drew that same conclusion.
We need to check the return code from the call to apq_reset_check()
and if it 0, bail out of the wait loop.

Regarding copying the status into q->reset_status, that should only be
done prior to entering the loop and on ret == -EAGAIN after the
AQIC instruction is executed.

>
> [Severity: High]
> Does this timeout path fail to clear q->saved_isc, leading to cross-vm kvm
> interrupt routing corruption when the queue is reassigned to a new guest?
>
> When apq_reset_check() times out, it skips vfio_ap_free_aqic_resources() to
> leak the memory, but leaves q->saved_isc populated since the vfio_ap_queue
> struct persists across mdev assignments.
>
> When a new guest later enables AP interrupts, vfio_ap_free_aqic_resources()
> uses the stale q->saved_isc to call:
>
>      kvm_s390_gisc_unregister(new_kvm, q->saved_isc);
>
> This unregisters the stale ISC against the new guest's KVM object,
> decrementing the new guest's ISC reference count and wrongly disabling alerts
> for that ISC.

If the return code from apq_status_check() returns 0, the
AQIC resources need to be freed.

>
>> +		}
>>   		if (ret == -EBUSY) {

