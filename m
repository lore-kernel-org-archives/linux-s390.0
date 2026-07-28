Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416921ABC9;
	Tue, 28 Jul 2026 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200066; cv=none; b=QSpgYYAaT1DRowFv4N/E+hiaHk3lvk4h7g5ETysqSckxDlB6zVE7KbMT3w9Rz6MMe8BTl3aQQbR2yxNnPaCRpoHF+x4nLtvbf14ZfhCWIRB5csTIPVo9fWE2jAwMVjlnNO/MbUMbNZnu+zMkw8AlH3z1oNTMnr1uvMgFQenIVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200066; c=relaxed/simple;
	bh=Aq1nqApCWac3NM9UlBEVfTuwoFnw8H+j6n9sVOuoiRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rat6CVU5hTtVnJkHGQmkn4f4TK0zVnqNupyqzDA006SVU7Wv+QPp0KH8/LewfkilGVirOAw4BFnVr+ZsL+lFBBSsnPm1r12NKbnfRfMDRZoBzINUPmkPozoT81qlc32C1sqa1nzD91tjKFDqcttys9QaEP6N3UHGCrA15tlDxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NAvue33N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NAvue33N"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0luMM3783806;
	Tue, 28 Jul 2026 00:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7UGOVn
	7WsfOLQdIh3/1+lQeNnE+sauZtD54AY5BnAqs=; b=NAvue33NBlWEHUaqrqpn/6
	66Mv55j1C04T/JuPN6O+JUYuGkydyAMEicsxysKS/j1DhtnSlnSgh1MHg4zH2OFm
	oVlIXTDrsxNkG4y7utVhimAbnsyX5tpP7TEPyDbBt5kzpF49zW2xNaB5jc8mZ93G
	H+kgR/XJ45uFAMwYZkXz112tCoMlI0BhIpDu8bJ2HVqHl1fAl6EllArhzaud+WN4
	MeEmxORyuOXhax9Vf+TOba6m8Od7KWn5RZsbfxZrbWKWmphGz3fEdz+7L68B4vtA
	UwLZP8qnhTCNoHHrVVwAag7+a4vHkuBEAABi8UtZ130oJrVm2+bUE2u1DeHuKGeg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xjtp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 00:54:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S0fR8l026986;
	Tue, 28 Jul 2026 00:54:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjynef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 00:54:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S0rixU25362976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 00:53:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75BC358056;
	Tue, 28 Jul 2026 00:54:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C46058054;
	Tue, 28 Jul 2026 00:54:19 +0000 (GMT)
Received: from [9.61.152.139] (unknown [9.61.152.139])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 00:54:19 +0000 (GMT)
Message-ID: <59a72d98-5f33-4bda-88cd-4e89ba237b9a@linux.ibm.com>
Date: Mon, 27 Jul 2026 20:54:18 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-9-farman@linux.ibm.com>
 <1819d316-62b9-48c7-abaa-f40681e22abf@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <1819d316-62b9-48c7-abaa-f40681e22abf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tcubRgWp0vv7cFjJXpbVQgVLznZHO3zt
X-Proofpoint-ORIG-GUID: tcubRgWp0vv7cFjJXpbVQgVLznZHO3zt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAwNCBTYWx0ZWRfXxRkoTtoZ0iam
 luO6iqZmbruGlkR7IXcc/lyfgmvMIoTzobRZj0JWbtcD58PuOM0R/fetvVPTRYmN0xalZbsB+MQ
 /2+4kI5uVTr0SLxXKbFH0c+ABhmOzLA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a67fdbe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=BDJVAYCkDSfPSt_zWL4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAwNCBTYWx0ZWRfXxelnmyzUZOSI
 zJtKgixD3HqaVmTv1gK2UJng8IFjYGLtUufdnVDPQ4XmODLLZek/AiJ882yLkltTSNiO09rsAdj
 OKtTIpRjKG5ZMLDurqmgTNt+WfyH8xMTUKObAlV1ezP43r8WQo1o6Te3T1GydOLmEaMFJXbs0kS
 E+dGbwQM234OdwGj+CvLzZ8qxVK2RUhIaqz10gE0zk1yPQhIZ4Kva4gWDG849iE8O6ZWMb52AMD
 GqbnR9wL6FPsKirICxl0Jk6rh2d3HIxD3fLPA0Hnq5x0lXMos5HRAFrE1ZdMCaDqO9Z7quuM3sD
 adx3N58rf8rw4yXS65gPmKLhyeMInv1LpMsa+5GIjmelujUBZJTeFdiT3cHms98K20D/GCP47/W
 RyyYxT/7eRRD6LynYL5k3GWmmbIxBEzK+D0uj5Oprx77+K+c7kR85ZVPDaE2Jssh/4x3WLElWpG
 7l6vsizJYkf04L0SZ4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280004



On 7/27/26 5:54 PM, Matthew Rosato wrote:
> On 7/27/26 3:22 PM, Eric Farman wrote:
>> The fsm_notoper() routine is called when the device has been
>> lost, and is (by definition) no longer operational. Since this
>> can happen asynchronously from the normal behavior of the
>> driver, the cleanup may happen when holding other locks
>> in the calling sequence (notably, the cio subchannel lock).
>>
>> Push the cleanup of the private->cp resources to a workqueue,
>> where it can be done out from under that lock sequence and
>> (soon) under its own serialization mechanism.
> 
> This part of the commit message needs updating now that you are not
> introducing a cp_mutex.
> 
>>
>> Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
>>   drivers/s390/cio/vfio_ccw_ops.c     | 3 +++
>>   drivers/s390/cio/vfio_ccw_private.h | 3 +++
>>   4 files changed, 16 insertions(+), 2 deletions(-)
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
>> index bd488e40e153..8ec6b175d991 100644
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
>> @@ -139,6 +140,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>>   	/* Should be empty, but just in case */
>>   	cancel_work_sync(&private->io_work);
>>   	cancel_work_sync(&private->crw_work);
>> +	cancel_work_sync(&private->notoper_work);
> 
> Sashiko mentions (and I agree) that you can accidentally leak the cp
> resources if you manage to cancel the pending notoper_work before it runs.
> 
> Since you are not running on a workqueue thread, it should be OK to
> flush instead to make sure that the pending item is executed.
> 
> A subsequent cancel should not be necessary, since we know that only 1
> instance of vfio_ccw_notoper_todo() will ever be queued because we queue
> it on the first time the device goes NOT_OPER.  Based on the FSM, once
> the device goes NOT_OPER, subsequent transitions into NOT_OPER are
> treated as a NOP and there is no way to transition to a different state
> other than NOT_OPER until the device is released, so you can't go from
> NOT_OPER->x->NOT_OPER.

Agreed, this should be flush not cancel.

Though, the piece where that's important is the call in close_dev, which 
is the counterpart to the open_device path which allows a cp to be 
queued in the first place. A close will have preceded a release, which 
means there will no longer be any cp's outstanding, and userspace will 
have been unable to submit new ones without performing another open.

The other two elements (io_work and crw_work) would be queued in 
response to a hardware event (an interrupt and a CRW, respectively), 
which could come asynchronously from all of this, so needs to be in both 
close and release.

> 
> Would probably be good to include a (less verbose) comment to that
> effect along with the flush.
> 

Agreed; thanks.

>>   
>>   	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>>   	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
>> @@ -209,6 +211,7 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
>>   
>>   	cancel_work_sync(&private->io_work);
>>   	cancel_work_sync(&private->crw_work);
>> +	cancel_work_sync(&private->notoper_work);
>>   
>>   	vfio_ccw_unregister_dev_regions(private);
>>   }
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

