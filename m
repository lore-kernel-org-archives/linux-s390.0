Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913F35950;
	Sun, 26 Jul 2026 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785027551; cv=none; b=mt6wnetWILQsRILyVRp91Fb2n6R45BIpLyvWqnbopZiXkv+QyEiNar/5lFz+KzlmkyrpZm+nxxpKAe4+qoZGw9Tgf5qQcrM7d9GCDqDoH1igYBmQ2itgJl2fciSfN418u0K1061JLsLzzDEk7V/SVHVTKU2swx3r5ZXMHgUZmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785027551; c=relaxed/simple;
	bh=LRafxVP6eAzxCdvB6Z3mjoN5ojRHk+imC4vKysSLTbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioYT4psBTH+prW3M1FvlwySUoGmIriaDfBA6dSTyVSgDbxzAdpfq7UVQJf7E4IHFqca4eA8MGHMz6wUU4RO5mgEoW4PywCXLGQEpXQxwm1dtXNhlXJwOuxqDOdnTluPEkPkiu7IuKtdJ2V4k0H/SHRdVUx2z4YuDpo1L7P8CDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iQ4Wh0qG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iQ4Wh0qG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNI4wm1834454;
	Sun, 26 Jul 2026 00:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q+B6U8
	hO7/oRcKwqpELSoT9PLVnslate1q3Gflb/0mI=; b=iQ4Wh0qGuRK6Ac/SeKZYo7
	NmlvyrBqnla01PpT4hHk2Mw++p8G7FsuzsczrqZ4rlfuonO2aeq/36sB4cvZbcGt
	MbQdIAf27b0PInsOEVmyQbDTPGp+edIp+3AF9Jph/UWlxpv0K25Hfi5X+H04P1Ph
	+l0pMZTCHeAOB9k6yzC46SZMlqyiskVaDE8ss6m5TkCnExG9ZNv2Cs2kyuxH3U3P
	npWOdcZFdypZR+V5dB0ZiRjfzDM2tclEwmXl5/iaaWcAR3owWwSlwjP94/NXdc9a
	IVKLXWBg/RiFEMvLba72/1pAjHHXBp1Cvj7w6DKMcrHIsVGy8T7agstL4noXXudw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhsurn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 00:59:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q0uRDn008365;
	Sun, 26 Jul 2026 00:59:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn1u333x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 00:59:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q0x6F828574234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 00:59:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 443BE58057;
	Sun, 26 Jul 2026 00:59:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A004358058;
	Sun, 26 Jul 2026 00:59:05 +0000 (GMT)
Received: from [9.61.125.201] (unknown [9.61.125.201])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Jul 2026 00:59:05 +0000 (GMT)
Message-ID: <63b789b2-d66c-4630-a099-3dfd58bbd5b0@linux.ibm.com>
Date: Sat, 25 Jul 2026 20:59:04 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] s390/vfio_ccw: move cp cleanup out of not
 operational
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-8-farman@linux.ibm.com>
 <685bd45f-379e-4878-b76a-6c7a13f1c036@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <685bd45f-379e-4878-b76a-6c7a13f1c036@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAwNCBTYWx0ZWRfX1K+Ajeoy1c2/
 1NJ5P71cCG+NvPTNPnAc9s0vwxg/bJSH0g+jSe9j2oOOUg053MjQ/VPfF4bUxLOCxvGI1QiOQ4q
 aNJDNMZczoDeQsXWr37HHqtvk7ah8Kg=
X-Proofpoint-GUID: HrnsAcNuLECtyNQiHbStD1eGOJe28amA
X-Proofpoint-ORIG-GUID: HrnsAcNuLECtyNQiHbStD1eGOJe28amA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAwNCBTYWx0ZWRfX3b1s/Iir3THX
 +5LaJ9sQ3PDCaMCGJqw9fXCDei682KggEralus0CnsOOljPeDhZ+nyL21SkIf1as1+7T2MrcqJR
 pFeXt/wVRW4YOkauFVrWsLOHxgPDGbrXdVcbNoHhOmDtXLPbXUU8oIgC/T5Gy+ZH+vMXbSFeAcC
 Lj530mATfjC0GWFIvjvTGHLXbz1m1VwkGEXoevO9HOcpgNLfMOxL6AmXDrSD43AYPzU5p32tXoI
 xJ0Vuz79R8KeCD5CoXmIoZyRNR4Wb5ZJGuRb6hlslMJFn7cEycdvX/4OwNgXTlXW8ubjXE5cpCE
 TTXstKrsKwtPOrEzeeL9nHkqH5fLfcnl1Q5g+TTwWUVwNUlZAUOrll6o7fddbkQ6PA1aWs5qDw/
 qldDBMT8u0sIjKyacbBs218yV7pmfjtILChgvJGRByzzBcpZxvAyAo7cia6I/gXY4iUcUs3I649
 iNjvM1TOArcPCl93tJQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a655bdc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UeF5VpL8UoQ15ytA95MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260004



On 7/25/26 12:39 PM, Matthew Rosato wrote:
> On 7/25/26 11:27 AM, Eric Farman wrote:
>> The fsm_notoper() routine is called when the device has been
>> lost, and is (by definition) no longer operational. Since this
>> can happen asynchronously from the normal behavior of the
>> driver, the cleanup may happen when holding other locks
>> in the calling sequence (notably, the cio subchannel lock).
>>
>> Push the cleanup of the private->cp resources to a workqueue,
>> where it can be done out from under that lock sequence and
>> (soon) under its own serialization mechanism.
>>
>> Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> 
> Doesn't this need a cancel of the workqueue before the vfio_ccw_private
> gets freed, maybe in vfio_ccw_mdev_release_dev()?

Yeah, seems the existing flush_workqueue() call in vfio_ccw_sch_quiesce 
has some restrictions on how it'd possibly get there, so probably not as 
certain a situation as is called for. I'll fix.

>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
>>   drivers/s390/cio/vfio_ccw_ops.c     | 1 +
>>   drivers/s390/cio/vfio_ccw_private.h | 3 +++
>>   4 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index 1a095085bc72..c197ad5ab580 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -125,6 +125,15 @@ void vfio_ccw_crw_todo(struct work_struct *work)
>>   		eventfd_signal(private->crw_trigger);
>>   }
>>   
>> +void vfio_ccw_notoper_todo(struct work_struct *work)
>> +{
>> +	struct vfio_ccw_private *private;
>> +
>> +	private = container_of(work, struct vfio_ccw_private, notoper_work);
>> +
>> +	cp_free(&private->cp);
>> +}
>> +
>>   /*
>>    * Css driver callbacks
>>    */
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
>> index 4d7988ea47ef..4d47a3c7b9a0 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -170,8 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *private,
>>   	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>>   	private->state = VFIO_CCW_STATE_NOT_OPER;
>>   
>> -	/* This is usually handled during CLOSE event */
>> -	cp_free(&private->cp);
>> +	queue_work(vfio_ccw_work_q, &private->notoper_work);
>>   }
>>   
>>   /*
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index 032a1cdf4df7..6c74d596be9d 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -54,6 +54,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
>>   	INIT_LIST_HEAD(&private->crw);
>>   	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>>   	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
>> +	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
>>   
>>   	private->cp.guest_cp = kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
>>   	if (!private->cp.guest_cp)
>> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
>> index 0501d4bbcdbd..e2256402b089 100644
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -102,6 +102,7 @@ struct vfio_ccw_parent {
>>    * @req_trigger: eventfd ctx for signaling userspace to return device
>>    * @io_work: work for deferral process of I/O handling
>>    * @crw_work: work for deferral process of CRW handling
>> + * @notoper_work: work for deferred processing in not-operational state
>>    */
>>   struct vfio_ccw_private {
>>   	struct vfio_device vdev;
>> @@ -125,11 +126,13 @@ struct vfio_ccw_private {
>>   	struct eventfd_ctx	*req_trigger;
>>   	struct work_struct	io_work;
>>   	struct work_struct	crw_work;
>> +	struct work_struct	notoper_work;
>>   } __aligned(8);
>>   
>>   int vfio_ccw_sch_quiesce(struct subchannel *sch);
>>   void vfio_ccw_sch_io_todo(struct work_struct *work);
>>   void vfio_ccw_crw_todo(struct work_struct *work);
>> +void vfio_ccw_notoper_todo(struct work_struct *work);
>>   
>>   extern struct mdev_driver vfio_ccw_mdev_driver;
>>   
> 

