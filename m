Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA478F2B;
	Thu, 16 Jan 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044269; cv=none; b=n9gTs/EvQzsEGH0c+gQEvE1b9BiC9qZ4zMZUpmyB49voMfwohGpQex09Y1QxnWMrVQl1CJQlbWp4giJBpc2JBBe9LVsOvAn6hGFUQfPz7SdbcX3DearuyEL2rAgPv9EV6SMIjWxumazZpuAWA+PmtfQRtn5q/MnZw+MCPNCXGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044269; c=relaxed/simple;
	bh=pIKytAdtXKpVYASFmcHFnlyR2BiFx970oXXfr1V44Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6CzCWlp9V4jBg0lc9dyECz3c8xegL51JTbxXPIPVBo0ju7x4qEkNYA/LEhot2FiQdx+VXnD/2hEAv/CcuDemoSaD53zC7qV6z00eQtA/5AXedbfzkncuvqzA8qqYVwsJYiDjDLqbzoPs1F1TpMDZQ73nePqmQ4BVWE5HGQ83B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tib4ayVt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tib4ayVt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBvX77022867;
	Thu, 16 Jan 2025 16:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yz8DXn
	BWEUGcHEegJJtqj1vvCHBWIJPhGb/k2OWbxLQ=; b=Tib4ayVtggjqCpuGyKzikG
	TI032VIg3wEcsggAIQ9VFHx0p9DC8bYYXIqhIzR55KP80QfkLBW1s7181ArYIvZA
	+g69S5aiGmf8VLbRZUrjV8UTuJ7+P2Ig70+WdQsmZA6l7jELKD/+orFuHCTXNXEX
	c/fS4tRjw5/PJ9m8laSvfwgp/OAEqZzVpsRtz+Xx+s/qRMZDz9/Id3QoHwl16EbV
	BwgzV3FFDhkHS+vqUyhTuPgh9b6Q7jUj1njeQrO/lwXarVTaWj7VYbebfqmj0eqz
	GSEcOquu2na3HuvL41QISqs5B1sPWGDm6OrFafRObfPBgGCjWlBvFYm53jV+EpFQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub43va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 16:17:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GGHcd9024334;
	Thu, 16 Jan 2025 16:17:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub43v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 16:17:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE3DNG017014;
	Thu, 16 Jan 2025 16:17:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkeh1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 16:17:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GGHYcD43450838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 16:17:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 093AF2004B;
	Thu, 16 Jan 2025 16:17:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95C4720040;
	Thu, 16 Jan 2025 16:17:33 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 16:17:33 +0000 (GMT)
Message-ID: <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
Date: Thu, 16 Jan 2025 17:17:33 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Content-Language: en-US
To: Julian Ruess <julianr@linux.ibm.com>, dust.li@linux.alibaba.com,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2ZF7Tt_ZVWtQjrdbX7Np-O9GotYqG2xd
X-Proofpoint-ORIG-GUID: gWFvR8XsF4n3gxyV9mSXN_OI2YNfUR4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160121



On 16.01.25 12:55, Julian Ruess wrote:
> On Thu Jan 16, 2025 at 10:32 AM CET, Dust Li wrote:
>> On 2025-01-15 20:55:20, Alexandra Winter wrote:
>>
>> Hi Winter,
>>
>> I'm fully supportive of the refactor!


Thank you very much Dust Li for joining the discussion.


>> Interestingly, I developed a similar RFC code about a month ago while
>> working on enhancing internal communication between guest and host
>> systems. 


But you did not send that out, did you?
I hope I did not overlook an earlier proposal by you.


Here are some of my thoughts on the matter:
>>
>> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>> Device) instead of ISM (Internal Shared Memory). 


So where does the 'H' come from? If you want to call it Shared Memory _D_evice?


To my knowledge, a
>> "Shared Memory Device" better encapsulates the functionality we're
>> aiming to implement. 


Could you explain why that would be better?
'Internal Shared Memory' is supposed to be a bit of a counterpart to the
Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
devices and by ism_loopback. So what is the benefit in changing it?


It might be beneficial to place it under
>> drivers/shd/ and register it as a new class under /sys/class/shd/. That
>> said, my initial draft also adopted the ISM terminology for simplicity.
> 
> I'm not sure if we really want to introduce a new name for
> the already existing ISM device. For me, having two names
> for the same thing just adds additional complexity.
> 
> I would go for /sys/class/ism
> 
>>
>> Modular Approach: I've made the ism_loopback an independent kernel
>> module since dynamic enable/disable functionality is not yet supported
>> in SMC. Using insmod and rmmod for module management could provide the
>> flexibility needed in practical scenarios.


With this proposal ism_loopback is just another ism device and SMC-D will
handle removal just like ism_client.remove(ism_dev) of other ism devices.

But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
which is a big disadvantage, I agree. The ism layer is prepared for dynamic
removal by ism_dev_unregister(). In case of this RFC that would only happen
in case of rmmod ism. Which should be improved.
One way to do that would be a separate ism_loopback kernel module, like you say.
Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
I also think it is a great way for testing any ISM client, so it has benefit for
anybody using the ism module.
Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
(Once we agree if and how to represent ism devices in genera in sysfs).

>>
>> Abstraction of ISM Device Details: I propose we abstract the ISM device
>> details by providing SMC with helper functions. These functions could
>> encapsulate ism->ops, making the implementation cleaner and more
>> intuitive. This way, the struct ism_device would mainly serve its
>> implementers, while the upper helper functions offer a streamlined
>> interface for SMC.
>>
>> Structuring and Naming: I recommend embedding the structure of ism_ops
>> directly within ism_dev rather than using a pointer. Additionally,
>> renaming it to ism_device_ops could enhance clarity and consistency.
>>
>>
>>> This RFC is about providing a generic shim layer between all kinds of
>>> ism devices and all kinds of ism users.
>>>
>>> Benefits:
>>> - Cleaner separation of ISM and SMC-D functionality
>>> - simpler and less module dependencies
>>> - Clear interface definition.
>>> - Extendable for future devices and clients.
>>
>> Fully agree.
>>
>>>
[...]
>>>
>>> Ideas for next steps:
>>> ---------------------
>>> - sysfs representation? e.g. as /sys/class/ism ?
>>> - provide a full-fledged ism loopback interface
>>>    (runtime enable/disable, sysfs device, ..)
>>
>> I think it's better if we can make this common for all ISM devices.
>> but yeah, that shoud be the next step.


The s390 ism_vpci devices are already backed by struct pci_dev. 
And I assume that would be represented in sysfs somehow like:
/sys/class/ism/ism_vp0/device -> /sys/devices/<pci bus no>/<pci dev no>
so there is an 
/sys/class/ism/<ism dev name>/device/enable entry already, 
because there is /sys/devices/<pci bus no>/<pci dev no>/enable today.

I remember Wen Gu's first proposal for ism_loopback had a device
in /sys/devices/virtual/ and had an 'active' entry to enable/disable.
Something like that could be linked to /sys/class/ism/ism_lo/device.


> 
> I already have patches based on this series that introduce
> /sys/class/ism and show ism-loopback as well as
> s390/ism devices. I can send this soon.
> 
> 
> Julian

