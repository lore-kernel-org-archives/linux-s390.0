Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BD211703;
	Wed, 22 Jan 2025 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547354; cv=none; b=QfBas5uaWo6QwiiAsWFhbQEqjVnebBUU2kXvDAbNNMTzwu6JsAOOql8jwpVf2hQ1rbuGwRozZ5J3gjOfUKDd7m3WXFZEHmf4IwaRt0CVW2SJjeV1aJ2StRXO1j4SgptBTX6UcheWA99kRfkzKVwqHW2bbRU2C8WL++3Y2A8kvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547354; c=relaxed/simple;
	bh=mP5IWHEwLpTnfhhvl9YP6F0+7zqUzFXqF4ONyvUHP2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7SnRZTRZs3PMd+CWpy6+R55Ewa30XdYU92/5c8LzraZ3ak8pXKNjs4WtNqmd8bMH7rEOBfesDuVzJedYKX16FAbRfHhlICSCIVSLAAuSZyRdoQwMYolo6++i+VlCOQBaQW7gw/WKRqmPN8kWZZZKtuE8Iv7FEXMpPSydfS9AN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dCGYC8X/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dCGYC8X/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M21eWs004717;
	Wed, 22 Jan 2025 12:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9GA/ml
	Ce91vUUTDz/M4XXyYsYwPmQh3yxBPsgmFHsDk=; b=dCGYC8X/4g1kg3OOQUrjVF
	C9ZJFEVxpbSzp1TJrsXkOr6270E6PAB7PQcy1qw+h7BYySrJ75ZMl6yeKN5U5q6Z
	6OYbc0uWTlSjV6lPSMuZ4H7fEEA2sVPHWVgZ6Un1UrS1IXq+1n9Q0nClfVQGe0tv
	lPy5aDdDXxrbkrMxVj2XLG6xJ09JFjtvFSsY8GQA7kDpiq4ZSk4zMCMJ6+3N77em
	e2JFETOVpbQJpEO88o+uAU0rfR5yyCBfrRYhvG0VQaGmjzkCqMkz/Q5a7kC0uiyw
	UOvwrs4ab0eeYjKN3ewhPjw0rOqjQzEmBsSxPu8tispbxipJv+6O65kpEejuBt+w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aqgyj973-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:02:21 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MBvrqh015530;
	Wed, 22 Jan 2025 12:02:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aqgyj96y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:02:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9FMIl024258;
	Wed, 22 Jan 2025 12:02:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y8e89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 12:02:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MC2GDI34799954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 12:02:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FC882004F;
	Wed, 22 Jan 2025 12:02:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3574A20040;
	Wed, 22 Jan 2025 12:02:15 +0000 (GMT)
Received: from [9.171.82.13] (unknown [9.171.82.13])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 12:02:15 +0000 (GMT)
Message-ID: <3866f996-6a1f-4f5a-9f92-01268a98baaf@linux.ibm.com>
Date: Wed, 22 Jan 2025 13:02:14 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250122030459.GN89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sf17X__Yb9Rc43OPFBcegAp7Kj9HizLo
X-Proofpoint-ORIG-GUID: x0g5JqcONPg8fKYG4uShJsRd1D2OiaT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=890
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220089



On 22.01.25 04:04, Dust Li wrote:
> On 2025-01-20 11:28:41, Alexandra Winter wrote:
>>
>>
>> On 17.01.25 14:00, Alexandra Winter wrote:
>>>
>>>
>>> On 17.01.25 03:13, Dust Li wrote:
>>>>>>> Modular Approach: I've made the ism_loopback an independent kernel
>>>>>>> module since dynamic enable/disable functionality is not yet supported
>>>>>>> in SMC. Using insmod and rmmod for module management could provide the
>>>>>>> flexibility needed in practical scenarios.
>>>>>
>>>>> With this proposal ism_loopback is just another ism device and SMC-D will
>>>>> handle removal just like ism_client.remove(ism_dev) of other ism devices.
>>>>>
>>>>> But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
>>>>> which is a big disadvantage, I agree. The ism layer is prepared for dynamic
>>>>> removal by ism_dev_unregister(). In case of this RFC that would only happen
>>>>> in case of rmmod ism. Which should be improved.
>>>>> One way to do that would be a separate ism_loopback kernel module, like you say.
>>>>> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
>>>>> I also think it is a great way for testing any ISM client, so it has benefit for
>>>>> anybody using the ism module.
>>>>> Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
>>>>> (Once we agree if and how to represent ism devices in genera in sysfs).
>>>> This works for me as well. I think it would be better to implement this
>>>> within the common ISM layer, rather than duplicating the code in each
>>>> device. Similar to how it's done in netdevice.
>>>>
>>>> Best regards,
>>>> Dust
>>>
>>>
>>> Is there a specific example for enable/disable in the netdevice code, you have in mind?
>>> Or do you mean in general how netdevice provides a common layer?
>>> Yes, everything that is common for all devices should be provided by the network layer.
>>
>>
>> Dust for some reason, you did not 'Reply-all':
> 
> Oh, sorry I didn't notice that
> 
>> Dust Li wrote:
>>> I think dev_close()/dev_open() are the high-level APIs, while
>>> ndo_stop()/ndo_open() are the underlying device operations that we
>>> can reference.
>>
>>
>> I hear you, it can be beneficial to have a way for upper layers to
>> enable/disable an ism device.
>> But all this is typically a tricky area. The device driver can also have
>> reasons to enable/disable a device, then hardware could do that or even
>> hotplug a device. Error recovery on different levels may want to run a
>> disable/enable sequence as a reset, etc. And all this has potential for
>> deadlocks.
>> All this is rather trivial for ism-loopback, as there is not much of a
>> lower layer.
>> ism-vpci already has 'HW' / device driver configure on/off and device
>> add/remove.
>> For a future ism-virtio, the Hipervisor may want to add/remove devices.
>>
>> I wonder what could be the simplest definition of an enable/disable for
>> the ism layer, that we can start with? More sophisticated functionality
>> can always be added later.
>> Maybe support for add/remove ism-device by the device driver is
>> sufficient as  starting point?
> 
> I agree; this can be added later. For now, we can simply support
> unregistering a device from the device driver. Which is already handled
> by ism_dev_unregister() IIUC.
> 
> However, I believe we still need an API and the ability to enable or
> disable ISM devices from the upper layer. For example, if we want to
> disable a specific ISM device (such as the loopback device) in SMC, we
> should not do so by disabling the loopback device at the device layer,
> as it may also serve other clients beyond SMC.


Just a thought: not all clients have to use all available ism devices.
The client could opt out without removing the device.

> 
> Further more, I think removing the loopback from the loopback device
> driver seems unnecessory ? Since we should support that from the upper
> layer in the future.
> 
> Best regards,
> Dust


All good points. But it also shows that there are many options how to
extend ism device handling of the upper layers / clients.
e.g. I can image a loop macro ism_for_each_dev() might be nice...
I'd prefer to take one step at a time. Start with a minimal useful ism
layer and extend by usecase.








