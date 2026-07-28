Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AC2FF675;
	Tue, 28 Jul 2026 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208999; cv=none; b=RjqNnJUpadcz1VNViEVb5qLkttJuCXCxeqMXUBQUBdZRsw+p5ILbjYPSZ5kt7pQ1ZdvlHnZFdO4sA4NWCfUP5QF/8OkH77xn9/jlDLOMSZuBMkLrVIiLMh8++ObNhRYzM2Q584uICFVcKGfz4xLwkiy/ncmil0TUfdp+BzA/jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208999; c=relaxed/simple;
	bh=Mda1mphhVW1IVZ4aAa8ttaBYEoRQmiNy0rnGX8xH5so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyo6CwVOl7TlUh7R3HXE6bGHNuF/QIrecKkFtM3j1ApNxCPYG9TNl6xxtSHCPBEefzz4lCVHmNg0nCVJ0aeengEnnxRbq+0snHFJxytPbtAiQIBCVtoN0dEZCXRqUWfQvbV2zC2K8mzwUeYhAG8O8PO5bRvFdyTeGyjhJdipkxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hzkwg3cr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hzkwg3cr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0lfI23673151;
	Tue, 28 Jul 2026 03:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vpFagX
	rAFokcs1uUQ79+YC5kzN4uJT+quTNW8vklGhA=; b=hzkwg3crjp0yp7XVfCK1eN
	pGqaUvey0T+3mCZbt4FGa9IPk/0jhWnNACzV4TQdG449LaS8wpRejRq5dNktGIm8
	PhbUGACrMOXTT/APgM9C+zA0+IobHKN/L4rfr8aHCj+AySGTGnuFsFpJp3DhuS8M
	WYiv4jYlkCzgBtXMGtIEVSF1IuXUqRUoJr51yKgr1puCGNKAHTvLp5w/DJanDUsT
	fyr5RqfZgX8HuftJB05rJVf5fFKuZzDCp/tVP6rgwd1AkcLROP5twsf4CcmBWooQ
	ZPn8B1Peoy0h1PxudwSqdhO6mTIzbKw78OObAOhlhiBE+jkpDIIGDt5+KNzxW85w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0njns6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:23:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S3BKdX021487;
	Tue, 28 Jul 2026 03:23:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xys8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:23:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S3NEna20382368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 03:23:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 072FC58055;
	Tue, 28 Jul 2026 03:23:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EE8F5804E;
	Tue, 28 Jul 2026 03:23:13 +0000 (GMT)
Received: from [9.61.152.139] (unknown [9.61.152.139])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 03:23:13 +0000 (GMT)
Message-ID: <3b83fd20-434c-4be9-96d0-4f162fe769b8@linux.ibm.com>
Date: Mon, 27 Jul 2026 23:23:12 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-9-farman@linux.ibm.com>
 <3048391c-003a-4bde-84c9-e1eca0063766@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <3048391c-003a-4bde-84c9-e1eca0063766@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX+NHW5KY0Q6Wt
 rs2S61zO7yvrPfLH1nVsbwmQl1NLipiAlF4VT9SGpt8dBGw1aifC5JoAxjrQoG7MWCwEGGKLFyN
 mMbtvXt713ewmD7nMtxp8OS5/8gc23U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX+TuTxVNxrSw4
 GHi+A6aIej1wt4OwmDD2xsyffCr4R9oSRL1jfJD0PtKuj/ABAdhcImH+OMNfCoxx+CXpfi3qoPM
 r0U1kRfZ/Gpq434vWCWrrC4tM3/GGiyspiMrY33vSKMz+koUbIvtk/4F1k+jBG0N8Zhp8P3k8Uy
 g++GvVHyRxiTi3c9r9NncoijVZE5g/0SDLTfTRs9wHI+fjBGTBBh9T8Gr1G95e+4AZnzDdBk7Nc
 ExTY5ceNKazjYbsy72CxwOSBYmKSc+69shK9dsGtBN0eSMjyqaclyAGLCW2pbVwstyA2K9QgNlv
 SnA6c7nkBO+PhiHUD2YMqJ3y/w+T0wqDpKc5vL83HDDMaNEV3EjTfG3hgRGIdGFJN9ng1nzYzws
 AYJkLhAEVZY5QbOylhHOQGaF/SNJbWRkAUrUlKhnZyb+jwLrKkjSLoSGmYvobe3jKRRthjxay1W
 D25zf6Xe0n8EIz4/i5w==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6820a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=P74itzF_Mj_26pILoQQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QFTZ3jpU8cgNBGTUNBlh4nGljTcbwBW2
X-Proofpoint-ORIG-GUID: QFTZ3jpU8cgNBGTUNBlh4nGljTcbwBW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280028



On 7/27/26 10:08 PM, Matthew Rosato wrote:
> On 7/27/26 9:35 PM, Eric Farman wrote:
>> The fsm_notoper() routine is called when the device has been
>> lost, and is (by definition) no longer operational. Since this
>> can happen asynchronously from the normal behavior of the
>> driver, the cleanup may happen when holding other locks
>> in the calling sequence (notably, the cio subchannel lock).
>>
>> Push the cleanup of the private->cp resources to a workqueue,
>> where it can be done out from under that lock sequence and
>> safely under a common locking mechanism.
> 
> Nit: you mention 'safely under a common locking mechanism' but that
> doesn't actually happen until next patch.
> 
> Maybe add something like 'so a subsequent patch can...'
> 
>>
>> Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
>>   drivers/s390/cio/vfio_ccw_ops.c     | 6 +++++-
>>   drivers/s390/cio/vfio_ccw_private.h | 3 +++
>>   4 files changed, 18 insertions(+), 3 deletions(-)
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
>> index bc8eb485d03f..1cca3ecdae45 100644
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
>> @@ -133,7 +134,9 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>>   
>>   	/*
>>   	 * Ensure these work items are fully drained, so none can
>> -	 * fire after being released.
>> +	 * fire after being released. The notoper_work struct is
>> +	 * only meaningful if the device had been opened, which
>> +	 * means it would have been cleaned in an earlier close.
>>   	 */
>>   	cancel_work_sync(&private->io_work);
>>   	cancel_work_sync(&private->crw_work);
>> @@ -216,6 +219,7 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
>>   	 */
>>   	cancel_work_sync(&private->io_work);
>>   	cancel_work_sync(&private->crw_work);
>> +	flush_work(&private->notoper_work);
> 
> Sashiko found a path where you might never open/close, so I guess we
> need to flush in both close and release after all?

Argh.

The distinction I overlooked is that while the device might not be 
opened, meaning there's no cp stuff to free, the fsm_notoper call will 
enqueue the workqueue itself anyway. It makes no distinction of whether 
there will be anything for the cp_free logic to actually do.

> 
> I still think flush vs cancel to ensure that we process the cp_free()
> work if it's pending else we risk leaking the cp resources.

I have been going back and forth, and agree flush is probably better. 
Seems wrong to just blindly cancel it, even if there -shouldn't- be 
anything to release.

> 
> I think this is the last issue of note, so this series is very close as
> far as I'm concerned.
> 
> Thanks,
> Matt
> 
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

