Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258618D622;
	Tue, 28 Jan 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080309; cv=none; b=dBMfjxDBTPYh5qniNy6fdbuXrV3uib782YEmRgM/DYeITL1KI4v0FJZobNTciCMZlsLVxtWIGphJOj6H69C0ZtLbx+s7B/tQPiPBZvaNgDOWSTzZ4MjtnPN0Vv5Yk7Sq0T6uBAo4GTkNc8Sf3Il7t3sbKWDtv0Quj8niuFDOZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080309; c=relaxed/simple;
	bh=Pkf6b56AWdm/rGhyG4QDIjkpCV/4hxlTfFzR8zuGX9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRKCyCTAuENJ3u54WzFkbpo+98ohVlAo6tTrXcwC5caFVLlbrs/0oexESQAyrgaz/6WQNnrBoyzt68f8Bj7mjXaMi+GWteP8wgzlfSAEyvfzaOf44FzKIU+x7YkpgUEGfImrzTyvMOOcSiH5H63TNpa4AxkI6lAz2j+WbU5ubU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=liA9sLH9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="liA9sLH9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SFdqRT003227;
	Tue, 28 Jan 2025 16:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IzNjcV
	hjrKQMxejQLyCn2KV8aNzS5ZHGiuH6TrHYIjQ=; b=liA9sLH9lVvdxPt6hyKTqZ
	v4UVkEszwAmzSX+8rR+7sEkEiAp2AYeok4UrE23B2BQGRQhizjsn931b3+32EXXF
	06IIbRabfsgVi7C/3m3mQA0OlgUpcLeHJ1j9xraeJJU1KCDKTLf8dq5ZkwbVSca6
	RnaPRCBfbxGDM2/E5qPYvVbZkAU2NCKqSZTlWflsbM1KZc69dAlTPR7myfRQpyHn
	ZPI/CLlrJlswImNgsHy2It+XTIf7R2jIjJIBC3BVxkSavm7ExrcWTIIONeYHPSGT
	6rO086XtDNV7rmvhRYcppehhN3WBWkYo+2LFmqcNWr1kkNJ2+iK3PKYplVCpEO9Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44f22t02s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 16:04:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SFlpKp019460;
	Tue, 28 Jan 2025 16:04:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44f22t02s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 16:04:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDru4W028051;
	Tue, 28 Jan 2025 16:04:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskbwa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 16:04:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SG4r0H49676710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 16:04:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B69CC2004D;
	Tue, 28 Jan 2025 16:04:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 512452004B;
	Tue, 28 Jan 2025 16:04:53 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 16:04:53 +0000 (GMT)
Message-ID: <d1927140-443b-401c-92ff-f467c12d3e75@linux.ibm.com>
Date: Tue, 28 Jan 2025 17:04:53 +0100
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250118153154.GI89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bqTxHgDLz9v6OtbVeE4rZTOzDHUAMPxZ
X-Proofpoint-ORIG-GUID: GZwnthjqGa3SwAk86z333Lvaf-Bouc1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=590 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280119



On 18.01.25 16:31, Dust Li wrote:
> On 2025-01-17 11:38:39, Niklas Schnelle wrote:
>> On Fri, 2025-01-17 at 10:13 +0800, Dust Li wrote:
>>>>
>> ---8<---
>>>> Here are some of my thoughts on the matter:
>>>>>>
>>>>>> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>>>>>> Device) instead of ISM (Internal Shared Memory). 
>>>>
>>>>
>>>> So where does the 'H' come from? If you want to call it Shared Memory _D_evice?
>>>
>>> Oh, I was trying to refer to SHM(Share memory file in the userspace, see man
>>> shm_open(3)). SMD is also OK.
>>>
>>>>
>>>>
>>>> To my knowledge, a
>>>>>> "Shared Memory Device" better encapsulates the functionality we're
>>>>>> aiming to implement. 
>>>>
>>>>
>>>> Could you explain why that would be better?
>>>> 'Internal Shared Memory' is supposed to be a bit of a counterpart to the
>>>> Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
>>>> devices and by ism_loopback. So what is the benefit in changing it?
>>>
>>> I believe that if we are going to separate and refine the code, and add
>>> a common subsystem, we should choose the most appropriate name.
>>>
>>> In my opinion, "ISM" doesn’t quite capture what the device provides.
>>> Since we’re adding a "Device" that enables different entities (such as
>>> processes or VMs) to perform shared memory communication, I think a more
>>> fitting name would be better. If you have any alternative suggestions,
>>> I’m open to them.
>>
>> I kept thinking about this a bit and I'd like to propose yet another
>> name for this group of devices: Memory Communication Devices (MCD)
>>
>> One important point I see is that there is a bit of a misnomer in the
>> existing ISM name in that our ISM device does in fact *not* share
>> memory in the common sense of the "shared memory" wording. Instead it
>> copies data between partitions of memory that share a common
>> cache/memory hierarchy while not sharing the memory itself. loopback-
>> ism and a possibly future virtio-ism on the other hand would share
>> memory in the "shared memory" sense. Though I'd very much hope they
>> will retain a copy mode to allow use in partition scenarios.
>>
>> With that background I think the common denominator between them and
>> the main idea behind ISM is that they facilitate communication via
>> memory buffers and very simple and reliable copy/share operations. I
>> think this would also capture our planned use-case of devices (TTYs,
>> block devices, framebuffers + HID etc) provided by a peer on top of
>> such a memory communication device.
> 
> Make sense, I agree with MCD.
> 
> Best regard,
> Dust
> 



In the discussion with Andrew Lunn, it showed that
a) we need an abstract description of 'ISM' devices (noted)
b) DMBs (Direct Memory Buffers) are a critical differentiator.

So what do your think of Direct Memory Communication (DMC) as class name for these devices?

I don't have a strong preference (we could also stay with ISM). But DMC may be a bit more
concrete than MCD or ISM.
