Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B63185935;
	Mon, 10 Feb 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180324; cv=none; b=mp7XjE7ZAveFmgnS7c0fCqYGiKxz0r0jT0sWOzf5oYOBSnlLG3lO37Iq0rWMLra3SokNKwutP8/uMXMTzlseN37ELMit+0GADZMTZL3vUGu1rknD6kTZbRQsZtE26zusqyvE5hPvZu7Gv1n99HJ6CV5K1JdDw0WvcmC9SpV770U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180324; c=relaxed/simple;
	bh=Bnr8nlzxW4be0QMbIzK7H7SpQV3GQZRjleUSYZEwTYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSkd+LCjo3rO8NGRxE0vx47y1IuCKzQeefcfPAMO0kP9IPxargG7T31Cha45CtjVbDrldqadUG3TSt6nFljaql5nlQ2vvkjQkGjNTGcOWP2CbU7j7wmxneSvPA/QOmWe89dNX+M4cW4JSWr4ha32wYxMkkGM2yFBUBBZl0iNEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gbA5h+bk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gbA5h+bk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A5NnRr014109;
	Mon, 10 Feb 2025 09:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=popzWI
	PTmAirApyC3XWQ8mFJPHtAI4FAQo69XIqoIOo=; b=gbA5h+bklUTgebaUux/S3X
	sQVpECOQ4BdH2JeSaSxLdW9QJ0MSaR52/UcJ9f9/pjpKahsISwsQly7kwO73l5Dh
	xklLcbkhae1agrpmVNHtNb15+vDgXGfRqV8mEgvzuER2V1UgSSgK/xRn9sL69dwc
	N9RwiKDSndoziOou00H3JcroUvH+ZU/cAb/nk5tfXT/iyAKTpJ6eIloBX4A7mew5
	WF4FHGYftQKj3EConNBgGYKtK85b/Urv2CXlCsszZqkn9RxzGcl/0DNoc74lrMxg
	DZQddpbroDjcfI7D/T6gFivlmcskoompaP6scNAz+aY0q5D3RlxPspPmzFPonnCg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qb97s3w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:38:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51A9WIJe026869;
	Mon, 10 Feb 2025 09:38:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qb97s3vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:38:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51A8BmXw016672;
	Mon, 10 Feb 2025 09:38:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3jwh9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:38:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51A9cS6a44564752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:38:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0282012D;
	Mon, 10 Feb 2025 09:38:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BB5320129;
	Mon, 10 Feb 2025 09:38:27 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 09:38:27 +0000 (GMT)
Message-ID: <1e96806f-0a4e-4292-9483-928b1913d311@linux.ibm.com>
Date: Mon, 10 Feb 2025 10:38:27 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
To: dust.li@linux.alibaba.com, Niklas Schnelle <schnelle@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
 <20250118153154.GI89233@linux.alibaba.com>
 <d1927140-443b-401c-92ff-f467c12d3e75@linux.ibm.com>
 <20250210050851.GS89233@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250210050851.GS89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tKs-IO5xHX0wWxos7ucAef5RPIMr4t5t
X-Proofpoint-ORIG-GUID: 6GRDQvdMUltAZAP5CTJ-LM0Fk82y-Fsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=856 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100079



On 10.02.25 06:08, Dust Li wrote:
> On 2025-01-28 17:04:53, Alexandra Winter wrote:
>>
>>
>> On 18.01.25 16:31, Dust Li wrote:
>>> On 2025-01-17 11:38:39, Niklas Schnelle wrote:
>>>> On Fri, 2025-01-17 at 10:13 +0800, Dust Li wrote:
>>>>>>
>>>> ---8<---
>>>>>> Here are some of my thoughts on the matter:
>>>>>>>>
>>>>>>>> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>>>>>>>> Device) instead of ISM (Internal Shared Memory). 
>>>>>>
>>>>>>
>>>>>> So where does the 'H' come from? If you want to call it Shared Memory _D_evice?
>>>>>
>>>>> Oh, I was trying to refer to SHM(Share memory file in the userspace, see man
>>>>> shm_open(3)). SMD is also OK.
>>>>>
>>>>>>
>>>>>>
>>>>>> To my knowledge, a
>>>>>>>> "Shared Memory Device" better encapsulates the functionality we're
>>>>>>>> aiming to implement. 
>>>>>>
>>>>>>
>>>>>> Could you explain why that would be better?
>>>>>> 'Internal Shared Memory' is supposed to be a bit of a counterpart to the
>>>>>> Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
>>>>>> devices and by ism_loopback. So what is the benefit in changing it?
>>>>>
>>>>> I believe that if we are going to separate and refine the code, and add
>>>>> a common subsystem, we should choose the most appropriate name.
>>>>>
>>>>> In my opinion, "ISM" doesn’t quite capture what the device provides.
>>>>> Since we’re adding a "Device" that enables different entities (such as
>>>>> processes or VMs) to perform shared memory communication, I think a more
>>>>> fitting name would be better. If you have any alternative suggestions,
>>>>> I’m open to them.
>>>>
>>>> I kept thinking about this a bit and I'd like to propose yet another
>>>> name for this group of devices: Memory Communication Devices (MCD)
>>>>
>>>> One important point I see is that there is a bit of a misnomer in the
>>>> existing ISM name in that our ISM device does in fact *not* share
>>>> memory in the common sense of the "shared memory" wording. Instead it
>>>> copies data between partitions of memory that share a common
>>>> cache/memory hierarchy while not sharing the memory itself. loopback-
>>>> ism and a possibly future virtio-ism on the other hand would share
>>>> memory in the "shared memory" sense. Though I'd very much hope they
>>>> will retain a copy mode to allow use in partition scenarios.
>>>>
>>>> With that background I think the common denominator between them and
>>>> the main idea behind ISM is that they facilitate communication via
>>>> memory buffers and very simple and reliable copy/share operations. I
>>>> think this would also capture our planned use-case of devices (TTYs,
>>>> block devices, framebuffers + HID etc) provided by a peer on top of
>>>> such a memory communication device.
>>>
>>> Make sense, I agree with MCD.
>>>
>>> Best regard,
>>> Dust
>>>
>>
>>
> 
> Hi Winter,
> 
> Sorry for the late reply; we were on break for the Chinese Spring
> Festival.
> 
>>
>> In the discussion with Andrew Lunn, it showed that
>> a) we need an abstract description of 'ISM' devices (noted)
>> b) DMBs (Direct Memory Buffers) are a critical differentiator.
>>
>> So what do your think of Direct Memory Communication (DMC) as class name for these devices?
>>
>> I don't have a strong preference (we could also stay with ISM). But DMC may be a bit more
>> concrete than MCD or ISM.
> 
> I personally prefer MCD over Direct Memory Communication (DMC).
> 
> For loopback or Virtio-ISM, DMC seems like a good choice. However, for
> IBM ISM, since there's a DMA copy involved, it doesn’t seem truly "Direct,"
> does it?
> 
> Additionally, since we are providing a device, MCD feels like a more
> fitting choice, as it aligns better with the concept of a "device."
> 
> Best regards,
> Dust

Thank you for your thoughts, Dust.
For me the 'D as 'direct' is not so much about the number of copies, but more about the
aspect, that you can directly write at any offset into the buffer. I.e. no queues.
More like the D in DMA or RDMA.

I am preparing a talk for netdev in March about this subject, and the more I work on it,
it seems to me that the buffers ('B'), that are
a) only authorized for a single remote device and
b) can be accessed at any offset
are the important differentiator compared other virtual devices.
So maybe 'D' for Dedicated?

I even came up with
dibs - Dedicated Internal Buffer Sharing or
dibc - Dedicated Internal Buffer Communication
(ok, I like the sound and look of the 'I'. But being on the same hardware as opposed
to RDMA is also an important aspect.)


MCD - 'memory communication device' sounds rather vague to me. But if it is the
smallest common denominator, i.e. the only thing we can all agree on, I could live with it.


