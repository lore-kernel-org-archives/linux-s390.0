Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34BE567;
	Sun, 16 Feb 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720356; cv=none; b=G4GyiWpjgDRCSq+kYg+H4Syr369k69R0Bw84i5fbcmDO0Y0pFtGtUfzB1m4Mn/sDmbJ/FgZprfP8zXVFAP+WqyG/WAPK3qvvULTZg/ArKzcYMEi2mnjAcYNrR+pzLuOfkEqBduJxw2z/a/miY7PlFWlTJGXB5FzZ2NL4R8tEqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720356; c=relaxed/simple;
	bh=R/rjesY1vUA6QWSva5TdUE0A3eW1/D0JRd6BbtBqM4U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dh1bU/H8MfvRzTWetX1upF9tXicRCDnHmI3HSBeVzMx+z7gpJmL+2SVcqtdaAtU21xi6OnaVgDW2B6hiumHZPkvRRijcSRqyfSYyinUqCpzUQVK6v5R45ayBe5EqCisFKmbRL1kHn7HSEMX3RhbOaeCuG3SeuLK95rDzGqKiFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GvMLObNK; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GvMLObNK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739720344; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=+1uFYePbL4gJcuBtQwdJFiHz1tFGGrZucYBZ/AAb9e0=;
	b=GvMLObNKW2ZU41T5n2O3/qibtej2aoeDdV2scLza9LJQrBK1VlEpUmo7LoChCGTOqhCf+zUODA6BK8mylsmMtYXIh1Wd7rFao/2kCqhBX1oa+q3P21lwDxSn3CJJd0FeC4yTbEqhRQwNzwb57X2LFBE7D12cyprigSg6fIdaWPY=
Received: from 30.212.179.125(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WPWxkrU_1739720330 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Feb 2025 23:39:03 +0800
Message-ID: <ac35c3ce-f568-4d1d-b9a5-2e5c51bd4494@linux.alibaba.com>
Date: Sun, 16 Feb 2025 23:38:47 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
To: Alexandra Winter <wintera@linux.ibm.com>,
 Julian Ruess <julianr@linux.ibm.com>, dust.li@linux.alibaba.com,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
In-Reply-To: <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/17 00:17, Alexandra Winter wrote:
> 
> 
> On 16.01.25 12:55, Julian Ruess wrote:
>> On Thu Jan 16, 2025 at 10:32 AM CET, Dust Li wrote:
>>> On 2025-01-15 20:55:20, Alexandra Winter wrote:
>>>
>>> Hi Winter,
>>>
>>> I'm fully supportive of the refactor!
> 
> 
> Thank you very much Dust Li for joining the discussion.
> 
> 
>>> Interestingly, I developed a similar RFC code about a month ago while
>>> working on enhancing internal communication between guest and host
>>> systems.
> 
> 
> But you did not send that out, did you?
> I hope I did not overlook an earlier proposal by you.
> 
> 
> Here are some of my thoughts on the matter:
>>>
>>> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>>> Device) instead of ISM (Internal Shared Memory).
> 
> 
> So where does the 'H' come from? If you want to call it Shared Memory _D_evice?
> 
> 
> To my knowledge, a
>>> "Shared Memory Device" better encapsulates the functionality we're
>>> aiming to implement.
> 
> 
> Could you explain why that would be better?
> 'Internal Shared Memory' is supposed to be a bit of a counterpart to the
> Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
> devices and by ism_loopback. So what is the benefit in changing it?
> 
> 
> It might be beneficial to place it under
>>> drivers/shd/ and register it as a new class under /sys/class/shd/. That
>>> said, my initial draft also adopted the ISM terminology for simplicity.
>>
>> I'm not sure if we really want to introduce a new name for
>> the already existing ISM device. For me, having two names
>> for the same thing just adds additional complexity.
>>
>> I would go for /sys/class/ism
>>
>>>
>>> Modular Approach: I've made the ism_loopback an independent kernel
>>> module since dynamic enable/disable functionality is not yet supported
>>> in SMC. Using insmod and rmmod for module management could provide the
>>> flexibility needed in practical scenarios.
> 
> 
> With this proposal ism_loopback is just another ism device and SMC-D will
> handle removal just like ism_client.remove(ism_dev) of other ism devices.
> 
> But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
> which is a big disadvantage, I agree. The ism layer is prepared for dynamic
> removal by ism_dev_unregister(). In case of this RFC that would only happen
> in case of rmmod ism. Which should be improved.
> One way to do that would be a separate ism_loopback kernel module, like you say.
> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
> I also think it is a great way for testing any ISM client, so it has benefit for
> anybody using the ism module.
> Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
> (Once we agree if and how to represent ism devices in genera in sysfs).
> 
>>>
>>> Abstraction of ISM Device Details: I propose we abstract the ISM device
>>> details by providing SMC with helper functions. These functions could
>>> encapsulate ism->ops, making the implementation cleaner and more
>>> intuitive. This way, the struct ism_device would mainly serve its
>>> implementers, while the upper helper functions offer a streamlined
>>> interface for SMC.
>>>
>>> Structuring and Naming: I recommend embedding the structure of ism_ops
>>> directly within ism_dev rather than using a pointer. Additionally,
>>> renaming it to ism_device_ops could enhance clarity and consistency.
>>>
>>>
>>>> This RFC is about providing a generic shim layer between all kinds of
>>>> ism devices and all kinds of ism users.
>>>>
>>>> Benefits:
>>>> - Cleaner separation of ISM and SMC-D functionality
>>>> - simpler and less module dependencies
>>>> - Clear interface definition.
>>>> - Extendable for future devices and clients.
>>>
>>> Fully agree.
>>>
>>>>
> [...]
>>>>
>>>> Ideas for next steps:
>>>> ---------------------
>>>> - sysfs representation? e.g. as /sys/class/ism ?
>>>> - provide a full-fledged ism loopback interface
>>>>     (runtime enable/disable, sysfs device, ..)
>>>
>>> I think it's better if we can make this common for all ISM devices.
>>> but yeah, that shoud be the next step.
> 
> 
> The s390 ism_vpci devices are already backed by struct pci_dev.
> And I assume that would be represented in sysfs somehow like:
> /sys/class/ism/ism_vp0/device -> /sys/devices/<pci bus no>/<pci dev no>
> so there is an
> /sys/class/ism/<ism dev name>/device/enable entry already,
> because there is /sys/devices/<pci bus no>/<pci dev no>/enable today.
> 
> I remember Wen Gu's first proposal for ism_loopback had a device
> in /sys/devices/virtual/ and had an 'active' entry to enable/disable.
> Something like that could be linked to /sys/class/ism/ism_lo/device.
> 

Yes, the previous proposal can be refered to [1]. And the hierarchy
you mentioned makes sense to me.

[1] https://lore.kernel.org/netdev/20240111120036.109903-1-guwen@linux.alibaba.com/

> 
>>
>> I already have patches based on this series that introduce
>> /sys/class/ism and show ism-loopback as well as
>> s390/ism devices. I can send this soon.
>>
>>
>> Julian
