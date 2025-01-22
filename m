Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAC212B26;
	Wed, 22 Jan 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547573; cv=none; b=tGtbSCEdL7I/5VR9RfGUw8DXqBbuQo9A6C71qdqLMEOMYkj3C/ac3ArjQ31UcvXKjVqrhlX4YK9n8dFOEYEH76DZ3tKSmj/67dI6OsTBHRiZnzYs5kNy1b+eCxdxJ+P+3qGfH3HSCbRwwr0cPfSLxzjpT2oxsTgGAG0IkDCqOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547573; c=relaxed/simple;
	bh=qhKExdq6H5yn+SxO+nzjmp0qrlsOSMd3x3CmBDXyjQY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TV/+7+VuIDAFksJYVOAsISzFENSrMn1g5EPq/lKfvyosTFecXvfxcwYFU0ObVatgVvK3vJivnNeVMPGqzlWEO1ZV2Pf95BMsUs7Ce1UOcypzvcEFI2sAgVZMssG6iuBukpYKtUweZmg5IQkV22QjjOKx0qjf2iQqVjkzXShZJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cud5IrVl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cud5IrVl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M18OhD013816;
	Wed, 22 Jan 2025 12:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hQfVpS
	5aaEFh3ttsy8+QLeF/KDNV0N+QMwW5vB1qVqM=; b=Cud5IrVl/rdqY0TIC+pmg+
	T9rb/qKsczg/0NwsoD1Ku1xRrJSaAGIjUFwK4wcIoFW3zP/nJCf7BX3eGQ36ncSD
	sxTylciJ9xE4ScnreeJzgjakDyIg3UP2j7QE+Rg1/5imOCldrYkaDRcwvq7WpJRF
	vwVd4wJL4PUU2K0RQdUdLJjs7XslMfcTtg5Rd6ylU0gEcSZfis3uoP35H0PrEvLW
	YyylLZtEatcy9Q/l+XqKXMNLa4PFvtrPkZi7rFWeDdLvfVVlPbwl0g0hObeVqrdJ
	cb0Hf+cwtmcf2Q4ViThD84W0gsBl15pinUTt0QHeDlKoWZR9/MfrCmCjzYdlvEqg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9ajva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:06:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MBvaRx000728;
	Wed, 22 Jan 2025 12:06:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9ajv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:06:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MBNPfX021002;
	Wed, 22 Jan 2025 12:06:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1fxpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:06:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MC5wfF31523420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 12:05:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D54D820043;
	Wed, 22 Jan 2025 12:05:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C82ED20040;
	Wed, 22 Jan 2025 12:05:57 +0000 (GMT)
Received: from [9.171.82.13] (unknown [9.171.82.13])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 12:05:57 +0000 (GMT)
Message-ID: <029fbf44-0627-4b1b-a884-59219897f844@linux.ibm.com>
Date: Wed, 22 Jan 2025 13:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
From: Alexandra Winter <wintera@linux.ibm.com>
To: dust.li@linux.alibaba.com, Julian Ruess <julianr@linux.ibm.com>,
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
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>
 <17f0cbf9-71f7-4cce-93d2-522943d9d83b@linux.ibm.com>
 <20250122030459.GN89233@linux.alibaba.com>
 <3866f996-6a1f-4f5a-9f92-01268a98baaf@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <3866f996-6a1f-4f5a-9f92-01268a98baaf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bt50aXbLSaCVX9Cck7TKp8j-5fDUpa4q
X-Proofpoint-ORIG-GUID: qYsSeciAqHmlQbpFcnLE0OunnokcEnsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220089



On 22.01.25 13:02, Alexandra Winter wrote:
> 
> 
> On 22.01.25 04:04, Dust Li wrote:
>> On 2025-01-20 11:28:41, Alexandra Winter wrote:
>>>
>>>
>>> On 17.01.25 14:00, Alexandra Winter wrote:
>>>>
>>>>
>>>> On 17.01.25 03:13, Dust Li wrote:
>>>>>>>> Modular Approach: I've made the ism_loopback an independent kernel
>>>>>>>> module since dynamic enable/disable functionality is not yet supported
>>>>>>>> in SMC. Using insmod and rmmod for module management could provide the
>>>>>>>> flexibility needed in practical scenarios.
>>>>>>
>>>>>> With this proposal ism_loopback is just another ism device and SMC-D will
>>>>>> handle removal just like ism_client.remove(ism_dev) of other ism devices.
>>>>>>
>>>>>> But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
>>>>>> which is a big disadvantage, I agree. The ism layer is prepared for dynamic
>>>>>> removal by ism_dev_unregister(). In case of this RFC that would only happen
>>>>>> in case of rmmod ism. Which should be improved.
>>>>>> One way to do that would be a separate ism_loopback kernel module, like you say.
>>>>>> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
>>>>>> I also think it is a great way for testing any ISM client, so it has benefit for
>>>>>> anybody using the ism module.
>>>>>> Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
>>>>>> (Once we agree if and how to represent ism devices in genera in sysfs).
>>>>> This works for me as well. I think it would be better to implement this
>>>>> within the common ISM layer, rather than duplicating the code in each
>>>>> device. Similar to how it's done in netdevice.
>>>>>
>>>>> Best regards,
>>>>> Dust
>>>>
>>>>
>>>> Is there a specific example for enable/disable in the netdevice code, you have in mind?
>>>> Or do you mean in general how netdevice provides a common layer?
>>>> Yes, everything that is common for all devices should be provided by the network layer.
>>>
>>>
>>> Dust for some reason, you did not 'Reply-all':
>>
>> Oh, sorry I didn't notice that
>>
>>> Dust Li wrote:
>>>> I think dev_close()/dev_open() are the high-level APIs, while
>>>> ndo_stop()/ndo_open() are the underlying device operations that we
>>>> can reference.
>>>
>>>
>>> I hear you, it can be beneficial to have a way for upper layers to
>>> enable/disable an ism device.
>>> But all this is typically a tricky area. The device driver can also have
>>> reasons to enable/disable a device, then hardware could do that or even
>>> hotplug a device. Error recovery on different levels may want to run a
>>> disable/enable sequence as a reset, etc. And all this has potential for
>>> deadlocks.
>>> All this is rather trivial for ism-loopback, as there is not much of a
>>> lower layer.
>>> ism-vpci already has 'HW' / device driver configure on/off and device
>>> add/remove.
>>> For a future ism-virtio, the Hipervisor may want to add/remove devices.
>>>
>>> I wonder what could be the simplest definition of an enable/disable for
>>> the ism layer, that we can start with? More sophisticated functionality
>>> can always be added later.
>>> Maybe support for add/remove ism-device by the device driver is
>>> sufficient as  starting point?
>>
>> I agree; this can be added later. For now, we can simply support
>> unregistering a device from the device driver. Which is already handled
>> by ism_dev_unregister() IIUC.
>>
>> However, I believe we still need an API and the ability to enable or
>> disable ISM devices from the upper layer. For example, if we want to
>> disable a specific ISM device (such as the loopback device) in SMC, we
>> should not do so by disabling the loopback device at the device layer,
>> as it may also serve other clients beyond SMC.
> 
> 
> Just a thought: not all clients have to use all available ism devices.
> The client could opt out without removing the device.
> 
>>
>> Further more, I think removing the loopback from the loopback device
>> driver seems unnecessory ? Since we should support that from the upper
>> layer in the future.


If it is not too much effort, I would like to have a simple remove for
ism_loopback soon, as it would allow for simple variations of testcases.


>>
>> Best regards,
>> Dust
> 
> 
> All good points. But it also shows that there are many options how to
> extend ism device handling of the upper layers / clients.
> e.g. I can image a loop macro ism_for_each_dev() might be nice...
> I'd prefer to take one step at a time. Start with a minimal useful ism
> layer and extend by usecase.
> 
> 
> 
> 
> 
> 
> 
> 
> 

