Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66402379C43;
	Sat, 25 Jul 2026 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784978525; cv=none; b=D43oJNYiUnVgJf5Jrcd4UV5hBmNjf+4gUl/TS3bvl8OSRbo8ByrwTGVK3arNHdKIv0/HvM/ba215RDUM4gGJb+WRYvPzPVnU8pfwFLhU48ozFiBim9WVbHSk/VP7VWvh8IDsAADYWZIyxi7M61hUPbO7O+BQEflegnZ2HvQ2YIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784978525; c=relaxed/simple;
	bh=5apGCNr6xg4UvUdmHVWYhCgOTPgzd0UlrUWtHwQKonY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI0f2x2eqyqFTqPnRUFtIHO9CIvbMZK1ie2lcnyRrY7UL8v5ZK4m5L1V5CvMNWSpbzdv+9KKsM/DbtCZAfZDfK6WqfUcZ2ZRF1UeA4XVkYLDRQOe+RXt06uSSYqtOYGlW70VFPn2NqwetXHWiRiB3cUCgi5ag3KGJ8Do32weqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RKrtspra; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RKrtspra"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PB5pTV400905;
	Sat, 25 Jul 2026 11:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AUtaFW
	kaoob0mqvHh/spX4F/r/hTOOhRTaekiDehmfM=; b=RKrtspraJ8YUIbSPPTHfA6
	V/M2idMwSttHXvGdSF4vcpGkpkcNRQ+KR7uOMn/81IBfS4U6PfK9USQ6AWnViXBX
	s8oWfE1ZGfBxMhzN5sg1uF6Zi+kTBriuRv2/Qp6BPPp9yr6aqnGds9UCpsho1VUk
	+tME4VASOABBL8xMxPJhd98mJ+CzgHQMcAL04l/Dyzg5bPkyZWrc9P/MwUtimfVp
	4rk4UUI8kYLHsrfDRdHJb3XvGVI/q9hO829VR70sBZBBODuEEWuqkh5eMv5tdXpp
	Eb4k8QdGneM0dwcTpoTO/Infq52H42aQfrYuKFZdpaHH+Ef8oxJIKqxEnCP/G88A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhr0xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 11:22:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PBBFVk008860;
	Sat, 25 Jul 2026 11:22:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12h452-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 11:22:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PBM0dS38732132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 11:22:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9FC58055;
	Sat, 25 Jul 2026 11:22:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA44A5804B;
	Sat, 25 Jul 2026 11:21:59 +0000 (GMT)
Received: from [9.61.19.212] (unknown [9.61.19.212])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 11:21:59 +0000 (GMT)
Message-ID: <51955778-de09-4d1d-88d3-23d067b9f051@linux.ibm.com>
Date: Sat, 25 Jul 2026 07:21:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] s390/vfio_ccw: implement a crw lock
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-9-farman@linux.ibm.com>
 <bebb434e-4923-4e39-b754-72d608a457a0@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <bebb434e-4923-4e39-b754-72d608a457a0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDEwNiBTYWx0ZWRfXxWZrPKOy3zN/
 tSyv5nsUXj/ATcZPS+JkhqTxCYR+4KtdJK09MC85Jpm1lz+/aAj4cpFhTy2iHhHNkTqb7RUpgji
 9HpFg/2K7ugewrLMlKwHtWxk0zP/b5U=
X-Proofpoint-GUID: DeWSjaMXnJzELSIqpWCWrlwXhtOoscow
X-Proofpoint-ORIG-GUID: DeWSjaMXnJzELSIqpWCWrlwXhtOoscow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDEwNiBTYWx0ZWRfXxKUBZLcvlsYg
 H8r6JMm+vKvUdmcQzZZ1qVENmJ26Xik+XXDz3jWZFGbmfq3YAVlb7EEFo3PV/zKGSaw+YVwLSNh
 B7WzZHKjOH3RCYyVVCpe5VDzayvIhhpl61y66wFPBnFMiPRSo4x7ojqZ4SkffwFJpl3DKEM/lpJ
 /kqZQ9HsYPEZ0HV/zL640nj5HpJo24ytxQkeHrUXsFK/m5mSV88OFy14QflKBcN1/u4zmi4vbVL
 YgXsq+qJjAvm+e1LVwQCUS/M3nd1uCfo0dY4GyDERGNZtdGy2yUlpv1vxZKT07og5rN4c5kE+eg
 L/6RxI8dYBCQJyoN/tuXyKlIVkgJayoLt0GvUubmXRP+kwD8nB2L/OH8kMVXp1IiHJYFUbR1ayy
 2/LhhAyKByFbuixVk3h0MVOfyqBR0K26B+AtEkW/tInFc1DUEOQpDcWyowgpm2t56BV8O4kC7S2
 t5rz+q2TIv/PMReY/lQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a649c5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=M55gZVjYqC4F6Pnyi9kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250106



On 7/24/26 4:44 PM, Matthew Rosato wrote:
> On 7/23/26 1:47 PM, Eric Farman wrote:
>> Unlike the channel_program struct, which covers synchronous I/O
>> submissions and asynchronous interrupts, the CRW region relies
>> exclusively on asynchronous events coming from hardware.
>>
>> Implement a lock to manage the list of those payloads, to ensure
>> they are read cohesively.
>>
>> Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
>> Cc: stable@vger.kernel.org
>> Cc: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_chp.c     | 17 +++++++++++------
>>   drivers/s390/cio/vfio_ccw_drv.c     |  4 ++++
>>   drivers/s390/cio/vfio_ccw_ops.c     |  3 +++
>>   drivers/s390/cio/vfio_ccw_private.h |  2 ++
>>   4 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
>> index bf678270c457..3d05aaf790fa 100644
>> --- a/drivers/s390/cio/vfio_ccw_chp.c
>> +++ b/drivers/s390/cio/vfio_ccw_chp.c
>> @@ -93,15 +93,19 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>>   	if (pos + count > sizeof(*region))
>>   		return -EINVAL;
>>   
>> +	mutex_lock(&private->io_mutex);
>> +	i = array_index_nospec(i, private->num_regions);
> 
> Same comment as patch 6 wrt to array_index_nospec
> 
> ...
> 
>> index ac5aaa78a74b..2562679b5ef5 100644
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -121,6 +121,8 @@ struct vfio_ccw_private {
>>   
>>   	struct irb		irb;
>>   	union scsw		scsw;
>> +
>> +	spinlock_t		crw_lock;
> 
> This should have a comment either here or, in keeping with the rest of
> the struct, in the comment block above.

Thanks, missed that. The crw field itself was never added to the comment 
block, so I'll add that as well.

Similarly, I didn't add definitions for the new fields in struct 
channel_program earlier in this series, so I've gone back and done those.

> 
> This looks good if you're trying to protect private->crw list, I don't
> think it's complete if you're also trying to protect
> private->crw_trigger - it looks to me like you hold the new lock over
> most accesses to crw_trigger but at least not vfio_ccw_mdev_set_irqs
> where you set/clear it.

I suspect you're right that crw_trigger needs some love and be moved 
under this umbrella, but I'm drawing the line at private->crw for the now.

> 
> 
>>   	struct list_head	crw;
>>   
>>   	struct eventfd_ctx	*io_trigger;
> 

