Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE43C0610;
	Sat, 25 Jul 2026 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979007; cv=none; b=ASd08lsOLTW24eu4C4Kgr0RwAN8zP0Jg/La70xZYHbCCrZCcse9jWrFlWJAygw6Db/1qNDCZqMi8/dR8csHGNNABzYbLYMXlkqqZWJaVP4bRERNSo3nLo32t6GEL8axSkifky/n6TBcFeppj1idBoqNsfCrRAauADl4jzD4D1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979007; c=relaxed/simple;
	bh=DaWia+yI74PcH99eyLCzP2mPH23/69bwv+HTLMru3UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUwy0LoaTEJRgUL5HNBKEWLI4oHlRuP0HUDNnk52YHNoZPvqLCtHK8i4BfcMMSDgtgOhq5XyDqrkWNRIUApoZ9nAl6fire4g224KbJbnhsmpVFX+VzWJ9rz1EU1FL27KyoDwAmA6aDi1fYyD6HURaKFIlmrfOtuu6htEyyi2DNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cUAe8zfx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cUAe8zfx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PB1aci504090;
	Sat, 25 Jul 2026 11:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UK9mAP
	FlrCrGlN6FIAJfn2V4Rha6+9C0AgX3RQCRbTs=; b=cUAe8zfxyMS+y7PIDFi2xw
	gJP6/2z9S0gAV6QZMj7NtXvMWs+wBTMUULfah4yNXAHlaQ1qxT9NUjosyMFCsCbD
	OtRr7ST92h4MbGfcc8deBAyUfqR66jVBqwD198KoyOA3Xh2Z44es7bFMmtnaVfjC
	kbn2C74U/yJaSWdY1FyUi6DMibbABIeFGCo3Frled07vwiXFH5vTWMjCgmAa2e0i
	7CkftD1CndLMbVYu+bvS/EbYcJocbm+Lh+1IOn+LCpgX2/pNe+jQ4psyeVRv6iha
	NxGB18ZWm7VJGMtsI6jSwJ+N2UQO2Q26+5UXoplRn/LbfDnYBs94A8GZ+mJ1n+dQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcg1r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 11:30:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PBQNVh025261;
	Sat, 25 Jul 2026 11:30:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12h4mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 11:30:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PBU0nn4457212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 11:30:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5190458055;
	Sat, 25 Jul 2026 11:30:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 575565804B;
	Sat, 25 Jul 2026 11:29:59 +0000 (GMT)
Received: from [9.61.19.212] (unknown [9.61.19.212])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 11:29:59 +0000 (GMT)
Message-ID: <28371b29-4ec3-4162-bcd3-033925238771@linux.ibm.com>
Date: Sat, 25 Jul 2026 07:29:58 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] s390/vfio_ccw: implement a channel program mutex
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-8-farman@linux.ibm.com>
 <fa86ee74-1d36-4e14-a015-91599d4d0fa4@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <fa86ee74-1d36-4e14-a015-91599d4d0fa4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MEt7EZIlynfU_8V01Mvaf0jsjZ95xcHf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDEwNiBTYWx0ZWRfX5SSRZD3RzhKr
 eg7LujlosFchSd3dEAc2zLughDxYNar3WG+bI5Ct3YAuVd+Igp71+GERJ/3IMWEOn1ynEf/SHIn
 mCw7C5l1HG9L40bq/F9RvO/MBCO4d0o=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a649e3a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=XC0bjJr9udf0u12S4PsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDEwNiBTYWx0ZWRfXwgTLg7+3xefm
 vMBHu7g+BuEaUb4uOSmZVp4ZMJr+4jivmCli/dXCI9UbTYfE/+IVl1XQygH3RLnGLAZTXcIwgA/
 Zhh+EN+Zl5ZphgoOjq9O8E1RnY91gOYYg717fYrayAV8UMQaR2ObVBu4WkCuGqb31Q9QpN7dp0q
 Y6SbDc6Dc+jacsz0kSyDKbTge45Vcmkbevn3I2o6ldJJ3VzIBvPJjb25EqJY7XSpelfXvVbM8Cl
 4xBy9GLGxEmeiwvsIEupIzsHleB9ceNvHYhq7GjjFNNlwPgzNAKfqqZ0IY+J86vWIpK3SB5Owv5
 qPL476UEMdRmHWmMUjL5XFTTqHZ+VPsbxYr5LkBonykiwr6WCeug6eFTmUjAl7eoUer23OwoB2A
 TEUY06XFKAP+uRIhrHnQ6TCiLC4oreL39idSi88Ln4gX+XaGnvDmQX3k7qhjX7dECAjWxPb9QFc
 u+dBpMVSkoi2sOzkfHg==
X-Proofpoint-GUID: MEt7EZIlynfU_8V01Mvaf0jsjZ95xcHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250106



On 7/24/26 4:18 PM, Matthew Rosato wrote:
> On 7/23/26 1:47 PM, Eric Farman wrote:
>> The channel_program struct is manipulated without a serialization
>> mechanism to ensure consistent behavior. Take a broad stroke of
>> putting the entire structure behind a mutex, and ensure everything
>> that needs private->cp holds this mutex.
>>
>> There are a couple where the cio layer's subchannel->lock performs
>> this role in this code, which isn't correct (it should only be used
>> when touching the actual subchannel, like cio_enable_subchannel()),
>> so adjust the locations where that spinlock is acquired/released
>> to correctly coexist with this new mutex.
>>
>> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 10 +++++++++-
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 22 +++++++++++++++-------
>>   drivers/s390/cio/vfio_ccw_ops.c     | 10 +++++++++-
>>   drivers/s390/cio/vfio_ccw_private.h |  3 +++
>>   4 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index 1a095085bc72..1d8c2ed9da50 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -91,6 +91,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>>   
>>   	is_final = !(scsw_actl(&irb->scsw) &
>>   		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
>> +
>> +	mutex_lock(&private->cp_mutex);
>>   	if (scsw_is_solicited(&irb->scsw)) {
>>   		cp_update_scsw(&private->cp, &irb->scsw);
>>   		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
>> @@ -98,6 +100,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>>   			cp_is_finished = true;
>>   		}
>>   	}
>> +	mutex_unlock(&private->cp_mutex);
>> +
>>   	mutex_lock(&private->io_mutex);
>>   	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
>>   	mutex_unlock(&private->io_mutex);
>> @@ -259,12 +263,16 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>>   	rc = 0;
>>   
>>   	if (cio_update_schib(sch)) {
>> -		if (private)
>> +		if (private) {
>> +			spin_unlock_irqrestore(&sch->lock, flags);
>>   			vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   out_unlock:
>>   	spin_unlock_irqrestore(&sch->lock, flags);
>> +out:
>>   
>>   	return rc;
>>   }
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
>> index 4d7988ea47ef..9fbe97bd23f9 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -25,17 +25,15 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>>   	unsigned long flags;
>>   	int ret;
>>   
>> -	spin_lock_irqsave(&sch->lock, flags);
>> -
>>   	orb = cp_get_orb(&private->cp, sch);
> 
> Can you extend the documentation for cp_get_orb to indicate that
> cp_mutex must be held on entry?
> 
> Actually, better yet, can you use lockdep_assert_held()?

Of course; should've added that in the first place.

> 
> Would be a good idea to put these also in other functions that have now
> an implicit expectation that the mutex will be held, here's the list I
> came up with?
> 
> cp_get_orb
> cp_init
> cp_prefetch
> cp_free
> fsm_io_helper
> cp_iova_pinned	
> cp_update_scsw

I'm going to add them to cp_* functions, which means no fsm_io_helper. 
It's only interaction is for calling cp_get_orb anyway (and is the only 
one to do so), so it'll get covered in that path.

> 
> In some cases (like cp_get_orb) you'd have to do something like:
>      struct vfio_ccw_private *private = container_of(cp, struct vfio_ccw_private, cp);
>      lockdep_assert_held(&private->cp_mutex);
> 
> Then this lets us also use lockdep to make sure the mutex is OK now
> and in the future.
> 
>> -	if (!orb) {
>> -		ret = -EIO;
>> -		goto out;
>> -	}
>> +	if (!orb)
>> +		return -EIO;
>>   
>>   	VFIO_CCW_TRACE_EVENT(5, "stIO");
>>   	VFIO_CCW_TRACE_EVENT(5, dev_name(&sch->dev));
>>   
>> +	spin_lock_irqsave(&sch->lock, flags);
>> +
>>   	/* Issue "Start Subchannel" */
>>   	ccode = ssch(sch->schid, orb);
>>   
>> @@ -71,7 +69,6 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>>   	default:
>>   		ret = ccode;
>>   	}
>> -out:
>>   	spin_unlock_irqrestore(&sch->lock, flags);
>>   	return ret;
>>   }
>> @@ -171,7 +168,9 @@ static void fsm_notoper(struct vfio_ccw_private *private,
>>   	private->state = VFIO_CCW_STATE_NOT_OPER;
>>   
>>   	/* This is usually handled during CLOSE event */
>> +	mutex_lock(&private->cp_mutex);
>>   	cp_free(&private->cp);
>> +	mutex_unlock(&private->cp_mutex);
>>   }
>>   
>>   /*
>> @@ -252,6 +251,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>   	private->state = VFIO_CCW_STATE_CP_PROCESSING;
>>   	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>>   
>> +	mutex_lock(&private->cp_mutex);
>> +
>>   	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>>   		orb = (union orb *)io_region->orb_area;
>>   
>> @@ -300,6 +301,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>   			cp_free(&private->cp);
>>   			goto err_out;
>>   		}
>> +
>> +		mutex_unlock(&private->cp_mutex);
>>   		return;
>>   	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
>>   		VFIO_CCW_MSG_EVENT(2,
>> @@ -320,6 +323,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>   	}
>>   
>>   err_out:
>> +	mutex_unlock(&private->cp_mutex);
>>   	private->state = VFIO_CCW_STATE_IDLE;
>>   	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
>>   				      io_region->ret_code, errstr);
>> @@ -410,7 +414,11 @@ static void fsm_close(struct vfio_ccw_private *private,
>>   
>>   	private->state = VFIO_CCW_STATE_STANDBY;
>>   	spin_unlock_irq(&sch->lock);
>> +
>> +	mutex_lock(&private->cp_mutex);
>>   	cp_free(&private->cp);
>> +	mutex_unlock(&private->cp_mutex);
>> +
>>   	return;
>>   
>>   err_unlock:
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index 032a1cdf4df7..04800cfa779b 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -38,8 +38,13 @@ static void vfio_ccw_dma_unmap(struct vfio_device *vdev, u64 iova, u64 length)
>>   		container_of(vdev, struct vfio_ccw_private, vdev);
>>   
>>   	/* Drivers MUST unpin pages in response to an invalidation. */
>> -	if (!cp_iova_pinned(&private->cp, iova, length))
>> +	mutex_lock(&private->cp_mutex);
>> +	if (!cp_iova_pinned(&private->cp, iova, length)) {
>> +		mutex_unlock(&private->cp_mutex);
>>   		return;
>> +	}
>> +
>> +	mutex_unlock(&private->cp_mutex);
>>   
>>   	vfio_ccw_mdev_reset(private);
>>   }
>> @@ -50,6 +55,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
>>   		container_of(vdev, struct vfio_ccw_private, vdev);
>>   
>>   	mutex_init(&private->io_mutex);
>> +	mutex_init(&private->cp_mutex);
>>   	private->state = VFIO_CCW_STATE_STANDBY;
>>   	INIT_LIST_HEAD(&private->crw);
>>   	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>> @@ -90,6 +96,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
>>   out_free_cp:
>>   	kfree(private->cp.guest_cp);
>>   out_free_private:
>> +	mutex_destroy(&private->cp_mutex);
>>   	mutex_destroy(&private->io_mutex);
>>   	return -ENOMEM;
>>   }
>> @@ -141,6 +148,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>>   	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
>>   	kmem_cache_free(vfio_ccw_io_region, private->io_region);
>>   	kfree(private->cp.guest_cp);
>> +	mutex_destroy(&private->cp_mutex);
>>   	mutex_destroy(&private->io_mutex);
>>   }
>>   
>> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
>> index 0501d4bbcdbd..ac5aaa78a74b 100644
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -94,6 +94,7 @@ struct vfio_ccw_parent {
>>    * @schib_region: MMIO region for SCHIB information
>>    * @crw_region: MMIO region for getting channel report words
>>    * @num_regions: number of additional regions
>> + * @cp_mutex: protect against concurrent update of CP resources
>>    * @cp: channel program for the current I/O operation
>>    * @irb: irb info received from interrupt
>>    * @scsw: scsw info
>> @@ -115,7 +116,9 @@ struct vfio_ccw_private {
>>   	struct ccw_crw_region	*crw_region;
>>   	int num_regions;
>>   
>> +	struct mutex		cp_mutex;
>>   	struct channel_program	cp;
>> +
>>   	struct irb		irb;
>>   	union scsw		scsw;
>>   	struct list_head	crw;
> 

