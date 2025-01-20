Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C71DFDB8;
	Mon, 20 Jan 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374611; cv=none; b=nfMW4d3ymJZujHeZxqWvE67yHtgeQR9oEGKm1pFDDN0y+WT2OCztZJMWotzVK9px3pulcZM8ZjyPzRRDbHZsq2Nb7BaUOalpfqYy/0QE19teeq9mzdEtc6a/kVA+bXgL340z6uZl3PKmVh/X+vFgA6m5UG0st/TGYEns4sF8rKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374611; c=relaxed/simple;
	bh=SgvsEL/alox3CzfdBcp35ANX7DxF3HuZ3oEZMKhnxSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcKUY2TowEEIhn1GzWxpYp3+ieLmCPpQfB9cOOSNJuheAfnQsXEcN50WcBwBZlyUwDy5VslIVRFjwHdkoz9bdEpe+aSi5A4ABqtqDTcazSG8txTSSsXFtLfD5L4DFHUuEjnA1tqcrvVcAn3ViKhzPLvJU47vJ1HEiofqUdqu1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=egmyCRyE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="egmyCRyE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7XQLD011244;
	Mon, 20 Jan 2025 12:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pKYdhL
	2F8dD4gn4phqihXxjBxWqYHQo8P3oEPUq979Y=; b=egmyCRyEi6BoIibsNAPwb9
	62xqlA6k3ugN+70E1a9pFKk1kdiA+hXliZq5WPsXhZru0VFshM+DGeyjFEEr8ULP
	YlNxeBiZdYh/6AxvyIyNdFwRiA41ePi3f5pa6lW/95TtesXB5AwrksFsTheEH9Ap
	4qg3c3dK8Ds91mVuHDWLuvDmUaAlJK/KJDWQaA1t3ai57q2gQaDR3WknCapyTRoT
	1yBktoWnpgScrPxUEIdCEPJxawMpuYzJtQzoAalfjUH5ra1Ydor9BNaIo9Lq5Fao
	FkZJ/Xs714FQkvzh1jHJScv5OmIoJAM+UUpuNC9Ej1n7rrVplx3fyPWykYFO9uNg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n9734-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 12:03:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50KBhZIk020954;
	Mon, 20 Jan 2025 12:03:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n9731-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 12:03:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K85JSv022449;
	Mon, 20 Jan 2025 12:03:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4jx3t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 12:03:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KC3G4f31195720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 12:03:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B422C2006E;
	Mon, 20 Jan 2025 12:03:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4871820070;
	Mon, 20 Jan 2025 12:03:16 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 12:03:16 +0000 (GMT)
Message-ID: <7fc92a63-0017-4d59-bdaf-8976bf8dcee1@linux.ibm.com>
Date: Mon, 20 Jan 2025 13:03:16 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
To: dust.li@linux.alibaba.com, Andrew Lunn <andrew@lunn.ch>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Julian Ruess <julianr@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
 <034e69fe-84b4-44f2-80d1-7c36ab4ee4c9@lunn.ch>
 <64df7d8ca3331be205171ddaf7090cae632b7768.camel@linux.ibm.com>
 <7dc80dfb-5a75-4638-9d44-d5a080ddb693@lunn.ch>
 <c2eb6fd7e9a786749d70a17266a04fb50dbd5bb8.camel@linux.ibm.com>
 <85d94131-6c2b-41bd-ad93-c0e7c24801db@lunn.ch>
 <20250120062112.GL89233@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250120062112.GL89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jwn8neuaf6WdGn_bvB59pZ0RTF6nYhWG
X-Proofpoint-ORIG-GUID: -yroNUg7Sv1qroRDZB7ZLYRyfOlIdpaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=786 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200100



On 20.01.25 07:21, Dust Li wrote:
> On 2025-01-17 21:29:09, Andrew Lunn wrote:
>> On Fri, Jan 17, 2025 at 05:57:10PM +0100, Niklas Schnelle wrote:
>>> On Fri, 2025-01-17 at 17:33 +0100, Andrew Lunn wrote:
>>>>> Conceptually kind of but the existing s390 specific ISM device is a bit
>>>>> special. But let me start with some background. On s390 aka Mainframes
>>>>> OSs including Linux runs in so called logical partitions (LPARs) which
>>>>> are machine hypervisor VMs which use partitioned non-paging memory. The
>>>>> fact that memory is partitioned is important because this means LPARs
>>>>> can not share physical memory by mapping it.
>>>>>
>>>>> Now at a high level an ISM device allows communication between two such
>>>>> Linux LPARs on the same machine. The device is discovered as a PCI
>>>>> device and allows Linux to take a buffer called a DMB map that in the
>>>>> IOMMU and generate a token specific to another LPAR which also sees an
>>>>> ISM device sharing the same virtual channel identifier (VCHID). This
>>>>> token can then be transferred out of band (e.g. as part of an extended
>>>>> TCP handshake in SMC-D) to that other system. With the token the other
>>>>> system can use its ISM device to securely (authenticated by the token,
>>>>> LPAR identity and the IOMMU mapping) write into the original systems
>>>>> DMB at throughput and latency similar to doing a memcpy() via a
>>>>> syscall.
>>>>>
>>>>> On the implementation level the ISM device is actually a piece of
>>>>> firmware and the write to a remote DMB is a special case of our PCI
>>>>> Store Block instruction (no real MMIO on s390, instead there are
>>>>> special instructions). Sadly there are a few more quirks but in
>>>>> principle you can think of it as redirecting writes to a part of the
>>>>> ISM PCI devices' BAR to the DMB in the peer system if that makes sense.
>>>>> There's of course also a mechanism to cause an interrupt on the
>>>>> receiver as the write completes.
>>>>
>>>> So the s390 details are interesting, but as you say, it is
>>>> special. Ideally, all the special should be hidden away inside the
>>>> driver.
>>>
>>> Yes and it will be. There are some exceptions e.g. for vfio-pci pass-
>>> through but that's not unusual and why there is already the concept of
>>> vfio-pci extension module.
>>>
>>>>
>>>> So please take a step back. What is the abstract model?
>>>
>>> I think my high level description may be a good start. The abstract
>>> model is the ability to share a memory buffer (DMB) for writing by a
>>> communication partner, authenticated by a DMB Token. Plus stuff like
>>> triggering an interrupt on write or explicit trigger. Then Alibaba
>>> added optional support for what they called attaching the buffer which
>>> means it becomes truly shared between the peers but which IBM's ISM
>>> can't support. Plus a few more optional pieces such as VLANs, PNETIDs
>>> don't ask. The idea for the new layer then is to define this interface
>>> with operations and documentation.
>>>
>>>>
>>>> Can the abstract model be mapped onto CLX? Could it be used with a GPU
>>>> vRAM? SoC with real shared memory between a pool of CPUs.
>>>>
>>>> 	Andrew
>>>
>>> I'd think that yes, one could implement such a mechanism on top of CXL
>>> as well as on SoC. Or even with no special hardware between a host and
>>> a DPU (e.g. via PCIe endpoint framework). Basically anything that can
>>> DMA and IRQs between two OS instances.
>>
>> Is DMA part of the abstract model? That would suggest a true shared
>> memory system is excluded, since that would not require DMA.
>>
>> Maybe take a look at subsystems like USB, I2C.
>>
>> usb_submit_urb(struct urb *urb, gfp_t mem_flags)
>>
>> An URB is a data structure with a block of memory associated with it,
>> contains the detail to pass to the USB device.
>>
>> i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>>
>> *msgs points to num of messages which get transferred to/from the I2C
>> device.
>>
>> Could the high level API look like this? No DMA, no IRQ, no concept of
>> a somewhat shared memory. Just an API which asks for a message to be
>> sent to the other end? struct urb has some USB concepts in it, struct
>> i2c_msg has some I2C concepts in it. A struct ism_msg would follow the
>> same pattern, but does it need to care about the DMA, the IRQ, the
>> memory which is semi shared?
> 
> I don’t have a clear picture of what the API should look like yet, but I
> believe it’s possible to avoid DMA and IRQ. In fact, the current data
> transfer API, ops->move_data() in include/linux/ism.h, already abstracts
> away the DMA and IRQ details.
> 

What is central to ISM is the DMB (Direct Memory Buffer). The concept
that there is a DMB dedicated to one writer and one reader. It is owned
by the reader and only this writer can write at any offset into the DMB
(Fabric controlled). (Reader can technically read/write as well).

So for the client API I think the core functions are
- move_data(*data, target_dmb_token, offset) - called by the sending
client, to move data at some offset into a DMB.
- receive_signal(dmb_token, some_signal_info) - called by the ism layer
to signal the client, that this DMB needs handling. (currently called
handle_irq)

I would not want to abstract that to a message based API, because then
we need queues etc and are almost at a net_device. All that is not
needed for ism, because DMBs are dedicated to a single writer (who has
the responsibility).


> One thing we cannot hide, however, is whether the operation is zero-copy
> or copy. This distinction is important because we can reuse the data at
> different times in copy mode and zero-copy mode.
> 
> Best regards,
> Dust
> 

See my reply on 4/7, as well as Niklas' reply. Currently you can always
re-use the send buffer. So zero-copy can be a property of the DMB
(attach() function, etc. )

