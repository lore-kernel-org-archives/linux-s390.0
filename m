Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB231B4F0C;
	Wed, 19 Feb 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964378; cv=none; b=TMqT7ImHYmC5iJeVBQshj77X/iIbNtw9m9rdJQrgsbYRPxKwaTtcqRrfmZNwxNQe2a8dFoeLqpLrqcxltJjOKZH+e0XmpgAJpZcWbhw/gScl7wE5trwsJ34nAecE6jG//scT9ttaO0VOgY4ISRCCzyQoZDJY5Ez9MieXDBUMJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964378; c=relaxed/simple;
	bh=YxfScXZAlJ6bOse6O0wASagS5LXMwyJ8yNmAVj2UFKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFTrwc5/usM5mP6w+xKSuYIP2mCBjpniu97lmoXyXIWYSoc2EWqzZPUHM1SJ3dOHE4d0+22UeEyKprRcQ9a36ynE04qVlyLLe6U5z41SY4lJudcW7jMm7f9PjkAjgvuyPk2PUdG6kuXGwraa7Hlf1ckp2YRW+haYJ8GmRbANp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TqBr3xcs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TqBr3xcs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75Fne020382;
	Wed, 19 Feb 2025 11:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uRm/ZX
	rrmZDiHxzq1OpsDmafdpexez7z1eulcwkB2xU=; b=TqBr3xcsbANOPNt8qJqpBP
	1TErLTVxuyU+8GRHeWEEJbgFwQ544PnpnCX6p2aQbQWKA2k76AtnQEWFKpTw0rfC
	Vp+/peyl6C351879zCLpjf1vP4vAbFhxjbbH4IhBZ4mRo5+an7VkCc/Ktxcp9AIR
	agW7znlZ5B5ccRcFuRSzpdKLgs8/mQ2uiJqtKzL2lD4CM9/54M8AtHFINoWWIour
	C1L89OSmKGlOvXs323G2hZcQvV7dou5G1BnbR0TIjdQJumcVZQVHeoFgv1EEt/j1
	YOVpfiRBEPWInpM1Lb/tby+fAUpMDj0rSUG5OHZ6UV5SXxm0j2GMh1lam1YOQWjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyq3ktb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 11:26:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JBN6SN019645;
	Wed, 19 Feb 2025 11:26:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyq3kt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 11:26:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JAMHin009686;
	Wed, 19 Feb 2025 11:26:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y3qgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 11:26:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JBQ0jb35782966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 11:26:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8877620043;
	Wed, 19 Feb 2025 11:26:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C1620040;
	Wed, 19 Feb 2025 11:26:00 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 11:26:00 +0000 (GMT)
Message-ID: <88bfde57-a653-472a-936b-40e68c349ac1@linux.ibm.com>
Date: Wed, 19 Feb 2025 12:25:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer - naming
To: Wen Gu <guwen@linux.alibaba.com>, dust.li@linux.alibaba.com,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
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
 <1e96806f-0a4e-4292-9483-928b1913d311@linux.ibm.com>
 <59d386fb-0612-4c2e-a4e7-ca26b474917f@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <59d386fb-0612-4c2e-a4e7-ca26b474917f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5aq85u8LBeoxTgVsRwpOeL32X8S58FTI
X-Proofpoint-ORIG-GUID: VjMTp0R9jhtiSUku56tMoMHBot6hh-XR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=797 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190088



On 16.02.25 16:40, Wen Gu wrote:
> 
> 
> On 2025/2/10 17:38, Alexandra Winter wrote:
>>
>>
>> On 10.02.25 06:08, Dust Li wrote:
>>> On 2025-01-28 17:04:53, Alexandra Winter wrote:
>>>>
>>>>
>>>> On 18.01.25 16:31, Dust Li wrote:
>>>>> On 2025-01-17 11:38:39, Niklas Schnelle wrote:
>>>>>> On Fri, 2025-01-17 at 10:13 +0800, Dust Li wrote:
>>>>>>>>
>>>>>> ---8<---
>>>>>>>> Here are some of my thoughts on the matter:
>>>>>>>>>>
>>>>>>>>>> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>>>>>>>>>> Device) instead of ISM (Internal Shared Memory).
>>>>>>>>
>>>>>>>>
>>>>>>>> So where does the 'H' come from? If you want to call it Shared Memory _D_evice?
>>>>>>>
>>>>>>> Oh, I was trying to refer to SHM(Share memory file in the userspace, see man
>>>>>>> shm_open(3)). SMD is also OK.
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> To my knowledge, a
>>>>>>>>>> "Shared Memory Device" better encapsulates the functionality we're
>>>>>>>>>> aiming to implement.
>>>>>>>>
>>>>>>>>
>>>>>>>> Could you explain why that would be better?
>>>>>>>> 'Internal Shared Memory' is supposed to be a bit of a counterpart to the
>>>>>>>> Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
>>>>>>>> devices and by ism_loopback. So what is the benefit in changing it?
>>>>>>>
>>>>>>> I believe that if we are going to separate and refine the code, and add
>>>>>>> a common subsystem, we should choose the most appropriate name.
>>>>>>>
>>>>>>> In my opinion, "ISM" doesn’t quite capture what the device provides.
>>>>>>> Since we’re adding a "Device" that enables different entities (such as
>>>>>>> processes or VMs) to perform shared memory communication, I think a more
>>>>>>> fitting name would be better. If you have any alternative suggestions,
>>>>>>> I’m open to them.
>>>>>>
>>>>>> I kept thinking about this a bit and I'd like to propose yet another
>>>>>> name for this group of devices: Memory Communication Devices (MCD)
>>>>>>
>>>>>> One important point I see is that there is a bit of a misnomer in the
>>>>>> existing ISM name in that our ISM device does in fact *not* share
>>>>>> memory in the common sense of the "shared memory" wording. Instead it
>>>>>> copies data between partitions of memory that share a common
>>>>>> cache/memory hierarchy while not sharing the memory itself. loopback-
>>>>>> ism and a possibly future virtio-ism on the other hand would share
>>>>>> memory in the "shared memory" sense. Though I'd very much hope they
>>>>>> will retain a copy mode to allow use in partition scenarios.
>>>>>>
>>>>>> With that background I think the common denominator between them and
>>>>>> the main idea behind ISM is that they facilitate communication via
>>>>>> memory buffers and very simple and reliable copy/share operations. I
>>>>>> think this would also capture our planned use-case of devices (TTYs,
>>>>>> block devices, framebuffers + HID etc) provided by a peer on top of
>>>>>> such a memory communication device.
>>>>>
>>>>> Make sense, I agree with MCD.
>>>>>
>>>>> Best regard,
>>>>> Dust
>>>>>
>>>>
>>>>
>>>
>>> Hi Winter,
>>>
>>> Sorry for the late reply; we were on break for the Chinese Spring
>>> Festival.
>>>
>>>>
>>>> In the discussion with Andrew Lunn, it showed that
>>>> a) we need an abstract description of 'ISM' devices (noted)
>>>> b) DMBs (Direct Memory Buffers) are a critical differentiator.
>>>>
>>>> So what do your think of Direct Memory Communication (DMC) as class name for these devices?
>>>>
>>>> I don't have a strong preference (we could also stay with ISM). But DMC may be a bit more
>>>> concrete than MCD or ISM.
>>>
>>> I personally prefer MCD over Direct Memory Communication (DMC).
>>>
>>> For loopback or Virtio-ISM, DMC seems like a good choice. However, for
>>> IBM ISM, since there's a DMA copy involved, it doesn’t seem truly "Direct,"
>>> does it?
>>>
>>> Additionally, since we are providing a device, MCD feels like a more
>>> fitting choice, as it aligns better with the concept of a "device."
>>>
>>> Best regards,
>>> Dust
>>
>> Thank you for your thoughts, Dust.
>> For me the 'D as 'direct' is not so much about the number of copies, but more about the
>> aspect, that you can directly write at any offset into the buffer. I.e. no queues.
>> More like the D in DMA or RDMA.
>>
> 
> IMHO the 'D' means that the CPU copy does not need to be involved, and memory access
> only involves between memory and IO devices. So under this semantics, I think 'DMC'
> also applies to s390 ism device, since IIUC the s390 ism directly access to the memory
> which is passed down by move_data(). The exception is lo-ism, where the device
> actually doesn't need to access the memory(DMB), since the data has been put into the
> shared memory once the sendmsg() is called and no copy or move is needed. But this
> is not a violation of name, just a special kind of short-cut. So DMC makes sense
> to me.
> 
>> I am preparing a talk for netdev in March about this subject, and the more I work on it,
>> it seems to me that the buffers ('B'), that are
>> a) only authorized for a single remote device and
>> b) can be accessed at any offset
>> are the important differentiator compared other virtual devices.
>> So maybe 'D' for Dedicated?
>>
>> I even came up with
>> dibs - Dedicated Internal Buffer Sharing or
>> dibc - Dedicated Internal Buffer Communication
>> (ok, I like the sound and look of the 'I'. But being on the same hardware as opposed
>> to RDMA is also an important aspect.)
>>
>>
>> MCD - 'memory communication device' sounds rather vague to me. But if it is the
>> smallest common denominator, i.e. the only thing we can all agree on, I could live with it.
>>


Could you guys accept
'DIBS - Dedicated Internal Buffer Sharing'
as well?
-> dibs_layer, /class/dibs/, dibs_dev

That is currently my favourite.


