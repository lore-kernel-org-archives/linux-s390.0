Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89482339872;
	Fri,  4 Sep 2026 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557963; cv=none; b=A3WG6AUkGb+kafFc/P7m7mW8BHfd0GuQEC0XjP6PiVT7cZDMa2ZQya97FhYiPC6oKmNVUjK/wNk3FCDbTYsDRn6oetHTO05YJ75xCu2z+L820YsoJsxxfv3WR9YiQiIy64YzZGqcjN3/ah6rHSOWodmL+PV7xhD3Kt/gZ7uI3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557963; c=relaxed/simple;
	bh=OUwSaXr08wTC7jqw1xEkbt9To7BxmBfaB/sEqteCQq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRZOLRdBfVH98QWe9BH3DSg1MkDMeEMOUAvgRpuqgroodbP9TvutPK+pH5nY1Fatste+U/THJ7EP214B3ff+LWpC3F6Ssr9Nu/AcOQdHpTOIhfppWKrbZ02JRT7MPDBtXjr+JNCTZEQBl7sD2LR6eb/NXE4XBiaaPzXpQmPd7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kTCxqETr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kTCxqETr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684L1eYi2820180;
	Fri, 4 Sep 2026 21:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LY3vF4
	cox+CKHCdxwQhVexrOp7JB8pARJLeOtt6z6QU=; b=kTCxqETroGMW/yq0wMsB6k
	qRUaBjLKa+a7Rn7mVTRaYpKvm2B4M2U9kMqjk2Ql6ST1v3bxCrjicGHvmN44SFRn
	LujW1xy6MATR/lxRUyo1dVZcSofdPZKAZwF8znrlEUAsVnteMcaU4MIQrtebcZjP
	IRwnX4Hm1bvXCCRWp/QAE+Fh8yxORy6Zy6IVkooUHiO3rHqMmGFiIn0xP2tpNy6a
	PhDWF5Z4dJx4XNqTJVvXXm1NQ+DbaorxOvy7yhaocrh/i/Hl9/Gce0ogjYUgbX/d
	S9CdXoaNqqVPnKDUx7pj/I8GjNwL6yvrbegaVJ4oSTdiafoacg2Ah3lgzn/sL4og
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq55dfxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 21:39:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684LQVg2019569;
	Fri, 4 Sep 2026 21:39:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hyb02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 21:39:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684LdHkB24642246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 21:39:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55C7758056;
	Fri,  4 Sep 2026 21:39:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF58A58052;
	Fri,  4 Sep 2026 21:39:16 +0000 (GMT)
Received: from [9.61.80.215] (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 21:39:16 +0000 (GMT)
Message-ID: <cb135f03-85ef-4077-9371-4f7c7f1eda25@linux.ibm.com>
Date: Fri, 4 Sep 2026 17:39:16 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] s390/vfio-ap: fix queue state leakage to guest and
 host
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-6-akrowiak@linux.ibm.com>
 <20260904095329.EEF6E1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260904095329.EEF6E1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE5OSBTYWx0ZWRfXwE0aDhZXQCud
 z+KgalBJStzGecHB6hVAw2zC2jBKRbryCg6fRfVuSKJF+SttQPS9gS1vaBNhNJivjiWWAk5WWkS
 GB8X7eEFOoPohUz+2f4VESxOyrzxSG4a++WjzfYcYmXzyN4qGjk4p43pWoH2cHRRQjrSBWmWt5c
 X0G9PkFtWtzfa7E8QiGzW8jpz1a7s9dic9t5Ch+fYUVGydfkC26X308wFAVhDZ2+EnvLZFjJhkR
 pEAIkD/fih3kgiuCXkyzbYporEFelMLR/Eh0vF/4eClEhu7DhhabkplSBESxtJXZvc+1955a9QY
 XYoH5Mf+32cl1ER0kGUvicMDuG8ASGBVAWk8kBJDDGkVZtPV4zkaY93dbdze7FWwL8eCzrWocm+
 Dd3ghrE2X2PZazBNVbse1znR4Ir4h3UJzYBddsFPaRZMSbXS0W5Ol68AjxJeqi4/R/dZhCLwWVe
 taARVQkgK9UTxxFs8aA==
X-Proofpoint-ORIG-GUID: 50_q1klq6mREviMgGmQzRbH9PO0muS9h
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9b3a88 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9-yERIUudiUxDrmFHcIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 50_q1klq6mREviMgGmQzRbH9PO0muS9h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE5OSBTYWx0ZWRfX8DbDyVWkK5XL
 LeF2bTOD7g2uS9RMGybegRtCmhRWtvFUhZBqwIUiorYfBZhBiVYG+/eu491wFTdvagyzj5ggv/I
 5vqHHo01nS5iohQOX7KESwV9urfGvS0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040199



On 9/4/26 5:53 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>
> New issues:
> - [High] `apq_reset_check()` fails to update `q->reset_status` on successful completion, breaking queue assignment and state tracking.
> - [High] `matrix_mdev` is accessed after its protecting locks are released in `vfio_ap_mdev_remove_queue()`, leading to a UAF.
> - [Medium] Unconditional queue resets during probe and removal bypass the host configuration check, triggering unhandled kernel WARNINGs.
>
> Pre-existing issues:
> - [High] Early return on `-EIO` in `apq_reset_check()` bypasses freeing AQIC resources, leading to a resource leak and Use-After-Free.
> --
>
> commit 0e38aebd52e81cf78709732210a4726b0f1c0dfa
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: fix queue state leakage to guest and host
>
> This patch modifies the queue reset logic to prevent state leakage to guests
> and hosts. It changes the passable state for queues to strictly require
> AP_RESPONSE_NORMAL, introduces a variable maximum wait time for resets, and
> ensures queues are properly reset and verified during probe and removal.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 6a964f82c8e89..e054fd4a94970 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2113,7 +2113,7 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   		ret = apq_status_check(q->apqn, &status);
>>   		if (ret == -EIO)
>>   			return;
> [Severity: High]
> This isn't a bug introduced by this patch, but does returning early on -EIO
> here bypass resource cleanup at the done: label?

The AQIC resources need to be freed here.

>
> If a hardware failure causes an unrecognized response code,
> vfio_ap_free_aqic_resources() is skipped here and in the default switch case of
> vfio_ap_mdev_reset_queue(), but q is eventually freed.
>
> Can the guest's gmap notifier remain registered, holding a pointer to q,
> resulting in a use-after-free when the notifier dereferences the freed q
> pointer?
>
>> -		if (elapsed >= AP_RESET_MAX_WAIT) {
>> +		if (q->reset_max_wait && elapsed >= q->reset_max_wait) {
>>   			/*
>>   			 * Zeroization confirmed (ret == 0): the TAPQ status bits
>>   			 * indicate the async portion of the ZAPQ completed
> [ ... ]
>
>> @@ -2161,6 +2161,8 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   
>>   			return;
>>   		}
>> +		if (!ret || ret == -ENODEV)
>> +			goto done;
> [Severity: High]
> Does this early exit skip updating the queue's reset_status with the actual
> final state?
>
> If apq_reset_check() loops until ap_tapq() indicates successful zeroization
> (ret == 0), but jumps to done without updating q->reset_status to
> AP_RESPONSE_NORMAL, does this mean _queue_passable() will incorrectly reject
> successfully zeroized queues?
>
> Furthermore, could this cause the new logic in vfio_ap_mdev_remove_queue() to
> evaluate q->reset_status.response_code != AP_RESPONSE_NORMAL to true,
> triggering an incorrect redundant reset that blocks indefinitely?

These are valid concerns.

The cases that result in verifying completion of the ZAPQ on a work 
queue are:
AP_RESPONSE_NORMAL
AP_RESPONSE_RESET_IN_PROGRESS
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS

That is what will be in the q->reset_status.response_code. The NORMAL is 
fine,
but the others are not. For ret == 0, the response code needs to be set to
AP_RESPONSE_NORMAL; for ret = -ENODEV, it should be set to whatever
response code was returned from TAPQ in apq_status_check().

>
>>   		if (ret == -EBUSY) {
>>   			pr_notice_ratelimited(WAIT_MSG, elapsed,
>>   					      AP_QID_CARD(q->apqn),
> [ ... ]
>
>> @@ -2675,8 +2675,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>>   
>>   	q->apqn = apqn;
>>   	q->saved_isc = VFIO_AP_ISC_INVALID;
>> -	memset(&q->reset_status, 0, sizeof(q->reset_status));
>> +	q->reset_max_wait = AP_RESET_MAX_WAIT;
>>   	INIT_WORK(&q->reset_work, apq_reset_check);
>> +	vfio_ap_mdev_reset_queue(q);
>> +	flush_work(&q->reset_work);
> [Severity: Medium]
> Will this unconditional reset during probe trigger a WARN if the probed device
> is not in the host's AP configuration?

The queue is probed by the vfio_ap driver precisely because the AP bus
scan detected it in the host's AP configuration, so ap_zapq() returning
AP_RESPONSE_Q_NOT_AVAIL at probe time is not possible

>
> When an AP device is bound to the vfio_ap driver but is not present in the
> host's AP configuration, ap_zapq() fails with response code 0x01.
>
> Does this feed the 0x01 response code into vfio_ap_mdev_reset_queue(), which
> falls through to the default switch case and triggers a WARN?
>
>>   
>>   	if (matrix_mdev) {
>>   		vfio_ap_mdev_link_queue(matrix_mdev, q);
> [ ... ]
>
>> @@ -2759,8 +2761,19 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
>>   		vfio_ap_unlink_queue_fr_mdev(q);
>>   
>>   	dev_set_drvdata(&apdev->device, NULL);
>> -	kfree(q);
>>   	release_update_locks_for_mdev(matrix_mdev);
>> +
>> +	if (q->reset_status.response_code != AP_RESPONSE_NORMAL) {
> [Severity: High]
> Are the locks protecting matrix_mdev dropped before the blocking reset
> operations, exposing it to concurrent freeing?
>
> vfio_ap_unlink_queue_fr_mdev() unlinks the queue but leaves the dangling
> pointer q->matrix_mdev intact.
>
> If flush_work() blocks indefinitely and a concurrent unbind tears down the
> mdev and frees matrix_mdev, will vfio_ap_free_aqic_resources() dereference
> q->matrix_mdev->kvm, resulting in a use-after-free?

Yes. This will be removed. There is also concern with hanging the function
indefinitely.

>
>> +		/*
>> +		 * Loop until zeroization of queue is verified so we don't leak
>> +		 * the internal state of the queue to the caller.
>> +		 */
>> +		q->reset_max_wait = 0;
>> +		vfio_ap_mdev_reset_queue(q);
>> +		flush_work(&q->reset_work);
> [Severity: Medium]
> Does this fallback reset completely ignore the test_bit_inv() host
> configuration check present earlier in this function, hitting the same WARN on
> unbind if the device is not in the host's AP configuration?

That will go away too.

>
>> +	}
>> +
>> +	kfree(q);
>>   }
>>   
>>   /**

