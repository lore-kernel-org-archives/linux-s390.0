Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46005260A54;
	Tue, 25 Feb 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474113; cv=none; b=rORauHQM7WrLZBO+QDNPoYHXuJlNuJE9maDU/tBRe/dgvdohZdYW1626biaFv/4WpXWFsPdPdoAQlTeGdR6NXT2zg+juctiJ5JoqXv+9HHAvneLS8EWMehk4F615dOXncQt/YyWCc0Xj1gX3rUBJqqrizFL9KRcRUAowgQbjRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474113; c=relaxed/simple;
	bh=1pInpxZ61tHDalJfB2SmTTpAGa3xB1nkAFM9p4IyTXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dfa8mHsyTEEXNBBp1KKELuuz4KyaV83gx6/2DbifDgiIlUIqWtNXa28egMSzpBJw/pwMD840KE5yj7PN4SDbS0noyhwRKTThPqDEbrexr+a4mgM6M4PX2K2hEqGUw8XHzOZDO646bXE0u5UTmY+bKCxeHWZLaiMoOcqzC/N9b64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XCCQiym4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XCCQiym4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P6PXkZ019442;
	Tue, 25 Feb 2025 09:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ixtosj
	mSS12kt+uKV9bF9p+3z8x2LpmAncbesNPKDNk=; b=XCCQiym4EVz3kXqPC45bX+
	zH0NXIOAkIH0pz4ULD95FXIGeLh8Phc+SffhyZUXlAC5853g+4KKE+81NGCq+tgd
	pqethdbMPEYpjundg1IDhmH8YZi5+cFttqagWnHm1zNp64OIWyngIULc0Ewd0gqa
	MD7XwNSxOXGMuVlE/kEnkrSs727bBactIaKTGmlxLiZvxLSD/HIu5KjSdEAwCCcI
	RH6zxmo95uT9FIlnKfj+zRygJ5eVJHLqEdL+Y6/VM8RUeNPLlmzA5kVUIfOPa3s+
	8+9zohHaK/qx6LmnRuIPmboBlpGxwrMQNLuVWQTVkDtr7xM8dckaqkVQdZvLjICw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4518k68mex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:01:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51P8vh2K030821;
	Tue, 25 Feb 2025 09:01:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4518k68meg-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:01:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P56dml027327;
	Tue, 25 Feb 2025 08:40:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1udk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 08:40:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51P8ekHv55771438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:40:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEE1F20040;
	Tue, 25 Feb 2025 08:40:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FFA42004B;
	Tue, 25 Feb 2025 08:40:46 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 08:40:46 +0000 (GMT)
Message-ID: <9e7d3d0b-cb95-47ed-9a3f-33c9710cc647@linux.ibm.com>
Date: Tue, 25 Feb 2025 09:40:46 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer - naming
To: dust.li@linux.alibaba.com, Wen Gu <guwen@linux.alibaba.com>,
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
References: <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
 <20250118153154.GI89233@linux.alibaba.com>
 <d1927140-443b-401c-92ff-f467c12d3e75@linux.ibm.com>
 <20250210050851.GS89233@linux.alibaba.com>
 <1e96806f-0a4e-4292-9483-928b1913d311@linux.ibm.com>
 <59d386fb-0612-4c2e-a4e7-ca26b474917f@linux.alibaba.com>
 <88bfde57-a653-472a-936b-40e68c349ac1@linux.ibm.com>
 <20250225013638.GC81943@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250225013638.GC81943@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pyZrcXKEpyjoryLRaHtQdqI5reYHTTqd
X-Proofpoint-GUID: xmlChzzNdxbg0tR4bb4ACFRfeWD3lFq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=593 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250061



On 25.02.25 02:36, Dust Li wrote:
> On 2025-02-19 12:25:59, Alexandra Winter wrote:
>>
>>
>> On 16.02.25 16:40, Wen Gu wrote:
>>>
>>>
>>> On 2025/2/10 17:38, Alexandra Winter wrote:
>>>>
>>>>
>>>> On 10.02.25 06:08, Dust Li wrote:
>>>>> On 2025-01-28 17:04:53, Alexandra Winter wrote:
>>>>>>
>>>>>>
>>>>>> On 18.01.25 16:31, Dust Li wrote:
>>>>>>> On 2025-01-17 11:38:39, Niklas Schnelle wrote:
>>>>>>>> On Fri, 2025-01-17 at 10:13 +0800, Dust Li wrote:
>>>>>>>>>>
>>>>>>>> ---8<---

>>>>>>
>>>>>>
>>>>>
>>>>> Hi Winter,
>>>>>
>>>>> Sorry for the late reply; we were on break for the Chinese Spring
>>>>> Festival.
>>>>>
>>>>>>
>>>>>> In the discussion with Andrew Lunn, it showed that
>>>>>> a) we need an abstract description of 'ISM' devices (noted)
>>>>>> b) DMBs (Direct Memory Buffers) are a critical differentiator.
>>>>>>
>>>>>> So what do your think of Direct Memory Communication (DMC) as class name for these devices?
>>>>>>
>>>>>> I don't have a strong preference (we could also stay with ISM). But DMC may be a bit more
>>>>>> concrete than MCD or ISM.
>>>>>
>>>>> I personally prefer MCD over Direct Memory Communication (DMC).
>>>>>
>>>>> For loopback or Virtio-ISM, DMC seems like a good choice. However, for
>>>>> IBM ISM, since there's a DMA copy involved, it doesn’t seem truly "Direct,"
>>>>> does it?
>>>>>
>>>>> Additionally, since we are providing a device, MCD feels like a more
>>>>> fitting choice, as it aligns better with the concept of a "device."
>>>>>
>>>>> Best regards,
>>>>> Dust
>>>>
>>>> Thank you for your thoughts, Dust.
>>>> For me the 'D as 'direct' is not so much about the number of copies, but more about the
>>>> aspect, that you can directly write at any offset into the buffer. I.e. no queues.
>>>> More like the D in DMA or RDMA.
>>>>
>>>
>>> IMHO the 'D' means that the CPU copy does not need to be involved, and memory access
>>> only involves between memory and IO devices. So under this semantics, I think 'DMC'
>>> also applies to s390 ism device, since IIUC the s390 ism directly access to the memory
>>> which is passed down by move_data(). The exception is lo-ism, where the device
>>> actually doesn't need to access the memory(DMB), since the data has been put into the
>>> shared memory once the sendmsg() is called and no copy or move is needed. But this
>>> is not a violation of name, just a special kind of short-cut. So DMC makes sense
>>> to me.
>>>
>>>> I am preparing a talk for netdev in March about this subject, and the more I work on it,
>>>> it seems to me that the buffers ('B'), that are
>>>> a) only authorized for a single remote device and
>>>> b) can be accessed at any offset
>>>> are the important differentiator compared other virtual devices.
>>>> So maybe 'D' for Dedicated?
>>>>
>>>> I even came up with
>>>> dibs - Dedicated Internal Buffer Sharing or
>>>> dibc - Dedicated Internal Buffer Communication
>>>> (ok, I like the sound and look of the 'I'. But being on the same hardware as opposed
>>>> to RDMA is also an important aspect.)
>>>>
>>>>
>>>> MCD - 'memory communication device' sounds rather vague to me. But if it is the
>>>> smallest common denominator, i.e. the only thing we can all agree on, I could live with it.
>>>>
>>
>>
>> Could you guys accept
>> 'DIBS - Dedicated Internal Buffer Sharing'
>> as well?
>> -> dibs_layer, /class/dibs/, dibs_dev
>>
>> That is currently my favourite.
>>
> 
> I think you might prefer a name that describes shared memory,
> but I personally believe that something reflecting the device itself
> would be more fitting.
> 
> To be honest, here’s my ranking:
> 
> MCD > DMC > DIBS
> 
> Best regards,
> Dust


Thank you keeping the discussion going, Dust.
I know there is no perfect answer, but imo good names can make things easier to
understand.
For reasons described above, I would like to have a 'B for buffer' in the prefix.
There are many I/O concepts that share memory somehow, but the concept of a dmb dedicated to
exactly 2 devices is a differentiator, imo.
I thought 'D for device' was somehow redundant and obvious. But you now you are saying that for
you the device is a differentiator? As opposed to other memory sharing techniques that work
without devices? Maybe you have a point...

So maybe DMB - Direct Memory Buffers is a good term?
I know we use it for the buffers already, but they are actually a common aspect for all devices
and clients, right? So we could define a dmb layer with generic dmb_devices that can be used by dmb_clients
to communicate via dmb_bufs.




