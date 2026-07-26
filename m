Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDB4908B7;
	Sun, 26 Jul 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785024078; cv=none; b=BjeTY6a5FoT8Erx9CH03fU0RBuHzppK1HMYwTqOJfepAy0cZ81a6vEsPrzpBJnRrniPB+L99eyQ2jlp/C6eF9Q++sUqajtVm3OKH1/ycAPrWvHNmqfXNHD6q7S/AGxx5YGuJei/cUez/rm+3PA+U88jbABScb2+MBqt9nJRbaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785024078; c=relaxed/simple;
	bh=mO+SDPvKmEt7Bo1fxIdSzqQ4cit6Ue4XBOukZ89y8EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svczyLgIie4uvVqHmJIPUtT5xbq6DM3hksLBkJrhaKmygmqH32/HqVwHbp+eZjpePILrJ+c+uN7RN4gCOLoztR/gU/gbMrjcK19IeC3b38rXSpibZ8apYza6OeJ2RJh1MUxw6Z/t2N04X3n72x4vCEg1RaStuc+/4CX2l9oUVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WVhQKk6x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WVhQKk6x"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNHhn41944632;
	Sun, 26 Jul 2026 00:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G3Gkf4
	WxL0VIPL/r0LW/Ui329GKU0CGgRdeXekggkhU=; b=WVhQKk6xVZPFYReuBEqLEW
	ueRONa7BV68zYt2mj75IxCo6N1XD1GtA80BtHiS8UgGCI3zTKpY4MHL4b8FcCj2y
	Kmhm34m76iI0TtXpyxg1ZCNjjFNc2eq4Vk4opCuKmVkBs82LgaeE2e7K4oEFCmg4
	/qmQwkDvkSH6GH5hcp9b81Ff7txceuhKaEQeRRupfGbc/W8OWFNsPeNTagVYawaF
	soqMUQq3Vbka4rcPffHVloXLfu8HUqLLszJhusHFHzlB9pGKExB1h3Uniw6NJwd5
	I7Mp9GGH6/Nho4W8YFSqPxU70WalcbLEQvvZRciYOfpohChKKrmVAcu3hVXtyyow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwchqy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 00:01:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PNv0r4030496;
	Sun, 26 Jul 2026 00:01:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn59tw7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 00:01:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q01DjE40960488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 00:01:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9646858066;
	Sun, 26 Jul 2026 00:01:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3155458059;
	Sun, 26 Jul 2026 00:01:12 +0000 (GMT)
Received: from [9.61.125.201] (unknown [9.61.125.201])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Jul 2026 00:01:11 +0000 (GMT)
Message-ID: <0fd76431-0ccb-4141-bf80-69afd19cdc62@linux.ibm.com>
Date: Sat, 25 Jul 2026 20:01:11 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] s390/vfio_ccw: implement a crw lock
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-10-farman@linux.ibm.com>
 <7a3da5de-de52-4543-8b42-a3ee344d4d95@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <7a3da5de-de52-4543-8b42-a3ee344d4d95@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 36iVbkSlFHpU7jjuuHE7nyXSfmyKXOqG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDIyNiBTYWx0ZWRfX2RG+W19wtOrq
 jJtPamSAOp5pwxubDBqtbYNxj7OEh5dtEJuvOsH8PqZ/nikuzjTT0F0uzM6KIdsOMqKJViOWYKv
 tuK0b/S2zsdBdfPEAvfvgYdggjNBt6s=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a654e4b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9LUc9bIMTqo9_Lqi4y0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDIyNiBTYWx0ZWRfX70Iyzb8HIbci
 +xyGkE2UOMpA/oGnLyFY//vPWvtHANEdD8hiBvIwyKPoC61hrUtXojr8fDkcXbUdKF+1IGS2tdU
 eEcjrUwBQUBYhdkmaD6cdQT0Agy58p4K47RVdw5ifA7idGUsn2FBa00qEQ8vTOBdEkdJ4/mTG/O
 4pUjztqEuwUlIh5DOmHgS3wPwxs3rZeVpKUdR0INcfbSGRKq+GzoPNN13voK9RvsNDMMVYYa5k0
 U0EG/dZxWB8mkU1eYrK1iF0PNIF7t8lrpRDCnzk8LknjMr51cYN5pEdTSn8zHbOJIgXeeSjTXZh
 74yUZJtnAy0r0vPslwzbx6pR+0FGYnzkelrUauTFi+oNrugzy/kzFpl97cp8iV+o0NwePy+ZUew
 mzEbGqOG5db8lD6bviZPoC6HmCift3mcN9TOgFJ8gRqG/yXKMowCvKfRXT8VcjeGcfmZTkVor9i
 TV936mDj6XLuGQe7nYg==
X-Proofpoint-GUID: 36iVbkSlFHpU7jjuuHE7nyXSfmyKXOqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250226



On 7/25/26 1:03 PM, Matthew Rosato wrote:
> On 7/25/26 11:27 AM, Eric Farman wrote:
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
> 
> ...
> 
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -98,6 +98,8 @@ struct vfio_ccw_parent {
>>    * @cp: channel program for the current I/O operation
>>    * @irb: irb info received from interrupt
>>    * @scsw: scsw info
>> + * @crw_lock: serialization of CRW information
> 
> I would re-word this to say 'CRW list', to make it a bit more clear that
> the lock does not protect crw_trigger at this time (as discussed in v3).

Yeah, good call.

> 
> With that:
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Thanks,

> 
> 
>> + * @crw: list of Channel Report Word elements
>>    * @io_trigger: eventfd ctx for signaling userspace I/O results
>>    * @crw_trigger: eventfd ctx for signaling userspace CRW information
>>    * @req_trigger: eventfd ctx for signaling userspace to return device
>> @@ -122,6 +124,8 @@ struct vfio_ccw_private {
>>   
>>   	struct irb		irb;
>>   	union scsw		scsw;
>> +
>> +	spinlock_t		crw_lock;
>>   	struct list_head	crw;
>>   
>>   	struct eventfd_ctx	*io_trigger;
> 

