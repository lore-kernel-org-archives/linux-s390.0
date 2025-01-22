Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA41DFF0;
	Wed, 22 Jan 2025 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737515105; cv=none; b=etZj6imfLoIUbM/TZkVQN4tyf7TO+A6qIuRIwLJTWl85pOzpZ2a3ikYZMV5jCD8039SBwC7NC7as45/p6SiJd21BZi7wefxi1mUeKROQXDd3NulLGr1zxpj5Na4GXuAv9jfTiYTgaQX5Xb3vJpcMZ6eOKvDMwyHnB+/tZady1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737515105; c=relaxed/simple;
	bh=v7wNV92ceArbY3Q55JLdSkpDqJ235ENJaaLp30RgAK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiFOoiC8fzuL2m2LxQTZd4RsoELXQib3bXEvIzW1kPHoduuFLMCZZu+v8t74qIxd7VgI8mGc27tPWo4HyeRbgx37NqHYipTW9to5KAEKMmqLivlSydCCFOeFAg+1MK7h+0HgF6YGyR3bSMfqnMWKCKUNWtMFPmXDVYfvZ6jB3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AGoCjCA/; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AGoCjCA/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737515100; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ChLu+bsO1fPPKy1p8fiLQGD4NeUbVV1c6LJjwIvLBYU=;
	b=AGoCjCA/yPfCcEHv8+tNbuqGR8hfxz4lp7Z00kQ4Tw6Y2ZpQgiOiS/q5ewgZt9tzgzKhzSkro+XX9UdsL4wB+RHQGEUz5ivJIz4ZE0zkcQSINQmSCNltsgbrca4AWJ+GeSBuCUK2NcMlz/W9fBzKQh+HP/CZYZcWtsrlInqaQec=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WO6zR0i_1737515099 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 11:05:00 +0800
Date: Wed, 22 Jan 2025 11:04:59 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <20250122030459.GN89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>
 <17f0cbf9-71f7-4cce-93d2-522943d9d83b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f0cbf9-71f7-4cce-93d2-522943d9d83b@linux.ibm.com>

On 2025-01-20 11:28:41, Alexandra Winter wrote:
>
>
>On 17.01.25 14:00, Alexandra Winter wrote:
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
>
>Dust for some reason, you did not 'Reply-all':

Oh, sorry I didn't notice that

>Dust Li wrote:
>> I think dev_close()/dev_open() are the high-level APIs, while
>> ndo_stop()/ndo_open() are the underlying device operations that we
>> can reference.
>
>
>I hear you, it can be beneficial to have a way for upper layers to
>enable/disable an ism device.
>But all this is typically a tricky area. The device driver can also have
>reasons to enable/disable a device, then hardware could do that or even
>hotplug a device. Error recovery on different levels may want to run a
>disable/enable sequence as a reset, etc. And all this has potential for
>deadlocks.
>All this is rather trivial for ism-loopback, as there is not much of a
>lower layer.
>ism-vpci already has 'HW' / device driver configure on/off and device
>add/remove.
>For a future ism-virtio, the Hipervisor may want to add/remove devices.
>
>I wonder what could be the simplest definition of an enable/disable for
>the ism layer, that we can start with? More sophisticated functionality
>can always be added later.
>Maybe support for add/remove ism-device by the device driver is
>sufficient as  starting point?

I agree; this can be added later. For now, we can simply support
unregistering a device from the device driver. Which is already handled
by ism_dev_unregister() IIUC.

However, I believe we still need an API and the ability to enable or
disable ISM devices from the upper layer. For example, if we want to
disable a specific ISM device (such as the loopback device) in SMC, we
should not do so by disabling the loopback device at the device layer,
as it may also serve other clients beyond SMC.

Further more, I think removing the loopback from the loopback device
driver seems unnecessory ? Since we should support that from the upper
layer in the future.

Best regards,
Dust
