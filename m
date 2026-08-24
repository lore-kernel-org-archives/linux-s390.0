Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF238239C;
	Mon, 24 Aug 2026 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601304; cv=none; b=ldurIcOsD5uhfRsjZ9EmVvfurUGf9Kke8npHu4c0GQbty4QUbwZhOLpZt4d84720mNZQHkp7NFVXT4B33STcn7QIGDjTHUaYN+/Yc2AaUmpSDN5Etmp+pIcfUcqt14WyUd0uxLYxBTIohEq2NDsnvlHpVutUSdWG6G7flDAhNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601304; c=relaxed/simple;
	bh=20aqDRG+pvmN64pd1W7wLLUW7jkQNx9jCG4h9rlZ1rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFkAtp+OHDK2fchEJDA5HqiwRNoP9hypGOiE/Xw8YOeFIUQG8HH7ugaxcJlnvt3ONDqZCCT36yvWQUVOx/kIvy7G9iDroy1OAIe79r4MPixKEcCMyFN+/z8Atie9aGx+VEPqQvveM6Nv1mGuG5aVyhP464DhiNNXjomsS1e1Vdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FtOdnZk3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FtOdnZk3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVS8i2857824;
	Mon, 24 Aug 2026 19:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D29bjz
	bmzGVInxvBVJ385pNG8Xahef4ZcSVJEam39J8=; b=FtOdnZk3+U+dDWVhd5Q5Lq
	/ZeZ/pe+syGmoIN0fjDd5RIWtRrfC7m+MD3TtkZHLJdGQQxdlNWTMzCrc0CiNckz
	wYYqM8n15eFiNTtm4uCY5RFRcA0m7pYoX2sp7W4D84gLYPK/mQbWnqFzrLy0VmkP
	5bkz2wX0SgnP8ewVh8tFVzszYdFjS+FHcskCx+7luJp9I0A6iuXDeq8JoYOl2vEj
	yP+s8MOb2YQNRQEf8ap9CJDXPqc8SxYWlPb/Hkp5YeR2jYDUbvmIMM6Z5DVkgH7d
	7H979AwfszZYJkWVJAi1JCOnW9CntdR7bPLDvwou5Aaj1NXc/d4P4EmWysWgf58w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4ku73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:54:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OJfKwR011904;
	Mon, 24 Aug 2026 19:54:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag80qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:54:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OJsoN926280612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 19:54:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA6CE58060;
	Mon, 24 Aug 2026 19:54:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B01395805C;
	Mon, 24 Aug 2026 19:54:49 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 19:54:49 +0000 (GMT)
Message-ID: <86451d1d-240b-43a7-a0df-d9e973b254c8@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:54:49 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-4-akrowiak@linux.ibm.com>
 <07bdd3bb-0f9e-4288-9fd0-52ea9edf4b0d@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <07bdd3bb-0f9e-4288-9fd0-52ea9edf4b0d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u5Daa8ZzOEU4oNZ37NdRLnrbqtWrzIiN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX51yB9smVWGsr
 Zkf0VKd5ZXMtm8YGJCD/2neNaPctiU0FXB0coUumWm39pPTN/arHc++C6zZCTgB+KYGKWnzM45k
 Rxe33EWbv/X4tGcjajrZnKoRXCRyTGU=
X-Proofpoint-GUID: u5Daa8ZzOEU4oNZ37NdRLnrbqtWrzIiN
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ca18d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8XkFLdLQ_C6xlXzbQ_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX8ySaGuQKG/wg
 xLDrV6vanmMyV5lFGYY+PHncDFxXwiglFvXCmzi5xkp9QFIuAfGo3UfKBUlQdPjQlfsvTEpaZjC
 cFBKMOaNPYWTpz7hOf/Xzc6P4HlA916WBVRbw2z3gHimn7aatiRNSzOupXhMDNSCIzCTD6JyG7M
 mf+hFCWD9XoVqp64I2WADNQB2VRoYToGVWm/Gvfn+8XjNdV1LxDozcchI39QTG+7JMMUjHk6rfH
 hntBRQfhnVVxNcSPL7FSr/6IcJ+2008WVQfpilxtXxo/SZ04mbD93yfkqYFLqMeDoZAnZXMKe6e
 Ek852MLtheCChEG1DjyUeoEzVhf2UrrOTTNllXnV3qGrcrN2/MCln8eAfuIr20KseA93S+bQGgn
 +frBVyOo0qes2AmOs5pyXY5EMnhdqBtZ344xN6WhHrnKLuadKjiPX9bpqVEJ8yIPNlbPCXySyaH
 fG8Dz7uKYblgChcPTSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240165



On 8/24/26 1:04 PM, Matthew Rosato wrote:
> On 8/24/26 9:58 AM, Anthony Krowiak wrote:
>> The apq_reset_check() worker polls ap_tapq() in a while(true) loop
>> waiting for a queue reset to complete. When ap_tapq() returns
>> AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
>> apq_status_check() returns -EBUSY and the loop continues after
>> sleeping AP_RESET_INTERVAL (20ms). There is no upper bound on how
>> many times the loop iterates, so if the hardware continuously
>> returns a busy response the worker runs indefinitely.
>>
>> This is particularly harmful because several callers of
>> vfio_ap_mdev_reset_queues() and vfio_ap_mdev_reset_qlist() call
>> flush_work() on each queue's reset_work while holding one or more
>> of the global matrix_dev locks (guests_lock, mdevs_lock) or the
>> KVM lock. An indefinitely spinning worker permanently blocks all
>> of those locks, hanging mdev removal, KVM guest teardown, and the
>> VFIO_DEVICE_RESET ioctl path.
>>
>> Fix this by introducing AP_RESET_TIMEOUT (2000ms) and breaking out
> s/AP_RESET_TIMEOUT/AP_RESET_MAX_WAIT/ ?

I had to change that string at one time because the compiler
complained about the AP_RESET_TIMEOUT being a duplicate.
I'll fix it.

>
>> of the poll loop when elapsed time reaches that threshold. On
>> timeout the final busy status is written back to q->reset_status
>> so that callers inspecting reset_status.response_code after
>> flush_work() see a non-zero value and can return an appropriate
>> error. vfio_ap_free_aqic_resources() is called before returning
>> to release any KVM ISC registration and pinned NIB page,
>> consistent with all other early-exit paths in the function.
>>
>> Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 6e4569d6b975..c7eebbd0ed40 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -31,6 +31,7 @@
>>   #define AP_QUEUE_IN_USE "in use"
>>   
>>   #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
>> +#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
>>   
>>   static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
>>   static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
>> @@ -1973,6 +1974,12 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   					      status.response_code,
>>   					      status.queue_empty,
>>   					      status.irq_enabled);
>> +			if (elapsed >= AP_RESET_MAX_WAIT) {
>> +				/* Timed out waiting for reset to complete */
>> +				memcpy(&q->reset_status, &status, sizeof(status));
>> +				vfio_ap_free_aqic_resources(q);
>> +				return;
> Sashiko points out a concern here and I tend to agree; if this timer
> elapses you are effectively freeing resources that could still be in-use.
>
> This seems to go back to dd174833e44e 's390/vfio-ap: remove upper limit
> on wait for queue reset to complete' where it was decided to hang
> forever vs leak resources -- e.g. the hang seems intentional?
>
> If we don't have a way of forcing firmware to give up the resources I
> think we are stuck either waiting indefinitely or quarantining (leaking)
> the resources consciously.  And documenting the rationale in a comment
> block.
>
>> +			}
>>   		} else {
>>   			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>>   			    q->reset_status.response_code == AP_RESPONSE_BUSY ||

