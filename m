Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2329443;
	Fri, 17 Jan 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130865; cv=none; b=YdLsQNx5rKNUb43HN84FIUA55eNXIRb67g+P2YwKRW1zS6j7lH8EURCPMAp+410J/4wnmf3x0HbeG93huzNq4EvUvlY5h9Bmg6PU/srVe2ry9MhZNXjliWOm69OHOiW7KBxlmXWHg/XjEHzOXi/QFX0iqSwtmfLDupTpaJmK0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130865; c=relaxed/simple;
	bh=Tjho4acKS2vqGIV85FQZRWncNKnvgwo8IsPwRoUmBjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhcjR7mLg6iG86bx2v8ZCd0764ELk7Nr7CmGd38Gg8Hk/OadoB1hQRtOU6eJI8Yn1iFfcycdc1RPQ0nLLexE8QKcagKw9kG07i+thip196JnGfIJ8q7nIY/DU/snqeyhjIfhB78zPFh6yI1dBbpGhMALjhRUZ0FzdTM6KAAxxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hHLojEd8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hHLojEd8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H867iF001307;
	Fri, 17 Jan 2025 16:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hy33pq
	oJM743WFn31tUt+jQJFsYGaLenYBtnVpUuw1w=; b=hHLojEd85Gw6KO6P4qMFzm
	W4ObQowwrNmLgvDAnBCgjgvvOOrwFqzQt1zaWGeL21vk2O5xzJJqaYPy4m6daQKH
	jdyDggpXTBvFrtM90S/T+WIGRDFSlB2gmJi3NSCAoYzdeh7eqOuAlUtOxXFZeLwD
	CS97KWGDs0NnNOt205nLrTCeU0OuhGXUROSA4c91nCUxeI/azJVVfD6B5IRh0nqG
	G798807f/h8kRLHBeRmEHlV7uDwQ0X0CGJRKRVsWx0KgKdO1IqyjwfJOw64pgpiV
	x8gGYascXDsnYGf1R2jzd5NneZ1sQpkOsPhxObMVxmXbdq4IORnsJN2j+gERV2fA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3j684-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 16:20:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HGEXkg024168;
	Fri, 17 Jan 2025 16:20:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3j682-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 16:20:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HDiH3s002689;
	Fri, 17 Jan 2025 16:20:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443byksg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 16:20:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HGKoTI58917288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 16:20:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26FDF2004B;
	Fri, 17 Jan 2025 16:20:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDCB820040;
	Fri, 17 Jan 2025 16:20:48 +0000 (GMT)
Received: from [9.171.79.45] (unknown [9.171.79.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 16:20:48 +0000 (GMT)
Message-ID: <3f6defb9-5e68-4fe5-84f0-58477c8c897b@linux.ibm.com>
Date: Fri, 17 Jan 2025 17:20:48 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
To: Andrew Lunn <andrew@lunn.ch>
Cc: dust.li@linux.alibaba.com, Julian Ruess <julianr@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
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
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>
 <3e97f471-69fd-42bd-acf4-64201eaf6994@lunn.ch>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <3e97f471-69fd-42bd-acf4-64201eaf6994@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6a9zCcfnkGHylP8bQGICjviaPtS77EuF
X-Proofpoint-GUID: LWO5JUuE9G_SnMHjTLEyn8Lu3L6jzMyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=819
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170126



On 17.01.25 16:10, Andrew Lunn wrote:
> On Fri, Jan 17, 2025 at 02:00:55PM +0100, Alexandra Winter wrote:
>>
>>
>> On 17.01.25 03:13, Dust Li wrote:
>>>>>> Modular Approach: I've made the ism_loopback an independent kernel
>>>>>> module since dynamic enable/disable functionality is not yet supported
>>>>>> in SMC. Using insmod and rmmod for module management could provide the
>>>>>> flexibility needed in practical scenarios.
>>>>
>>>> With this proposal ism_loopback is just another ism device and SMC-D will
>>>> handle removal just like ism_client.remove(ism_dev) of other ism devices.
>>>>
>>>> But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
>>>> which is a big disadvantage, I agree. The ism layer is prepared for dynamic
>>>> removal by ism_dev_unregister(). In case of this RFC that would only happen
>>>> in case of rmmod ism. Which should be improved.
>>>> One way to do that would be a separate ism_loopback kernel module, like you say.
>>>> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
>>>> I also think it is a great way for testing any ISM client, so it has benefit for
>>>> anybody using the ism module.
>>>> Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
>>>> (Once we agree if and how to represent ism devices in genera in sysfs).
>>> This works for me as well. I think it would be better to implement this
>>> within the common ISM layer, rather than duplicating the code in each
>>> device. Similar to how it's done in netdevice.
>>>
>>> Best regards,
>>> Dust
>>
>>
>> Is there a specific example for enable/disable in the netdevice code, you have in mind?
>> Or do you mean in general how netdevice provides a common layer?
>> Yes, everything that is common for all devices should be provided by the network layer.
> 
> Again, lack of basic understanding.... but why is it not a network
> device? Network devices are not just Ethernet. We also have CAN, SLIP,
> FDDI, etc.
> 
> 	Andrew
> 

Thank you very much Andrew for spending the time and discussing this.

At the moment there is not usecase for attaching an ism interface via
struct net_device to the linux network layer.
Current client is SMC-D and they bypass the network stack.
Next client is a tty-over-ism console driver.
And Niklas Schnelle envisions TTYs, block devices, framebuffers over ISM.
None of them do need queues or headers or other things the network stack
offers, as long as the source can directly write into the target buffer.
As mentioned earlier, probably one could write an network-over-ism
driver, but nobody asks for it at the moment.

I have read about the Linux device model with devices and buses, but I
have a bit of a hard time mapping that to an existing machine with
classes, susbsystems, slots, subtypes, buses over buses and virtual
things, etc that often have the same names for different things.
So any advice for alternative placements of ism is welcome.

This is the kind of picture I have in my head:

                 SMC-sockets		     console
ISM clients:         |				|
             +-----------------+        +-----------------+
             |     SMC-D       |        |     tty-ism     |
             +-----------------+        +-----------------+
		     |			         |
+----------------------------------------------------------------------+
|            ism layer						       |
|  ism interfaces:     						       |
| ism_vp0	     ism_vp1,        ism_lo,           ism_virtio0, .. |
+----------------------------------------------------------------------+
     |			|		|
+--------------+  +--------------+ +----------------+	
| 0000:00:00.0 |  | 0000:00:00.1 | | virtual/ism/lo |	
+--------------+  +--------------+ +----------------+	
	\		/
+------------------------+
|     pci bus            |
+------------------------+


ls /sys/class/ism
ism_vp0 -> ../../devices/pci0124:00/0124:00:00.0/ism/ism_vp0
ism_vp1 -> ../../devices/pci0125:00/0125:00:00.0/ism/ism_vp1
ism_lo -> ../../devices/virtual/ism/ism_lo


Maybe all that is overkill for ISM?
I think it would be very helpful, if they show up in sysfs, but not
absolutely required.










