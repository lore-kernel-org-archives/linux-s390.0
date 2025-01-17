Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090001F5604;
	Fri, 17 Jan 2025 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080040; cv=none; b=foTG0/gPu/ULfYYVjxro3qiJf4rrGCDKMXLn8NMLrwcK8H7Ofev2z2cGZO7AoTdMOIFhkHQGujoXYPNzYMEnkCxnfMpX8bmbdfvFO9hMlqiu6KGH2tL4ifVuBpa49k0WuNFFoQRKUueQ6z7jxR0/iVhToFCCJ+aMDkmHxQMzr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080040; c=relaxed/simple;
	bh=b8bP5SE0USzXzDD7E0HSc23dN32N4tag6/cV3tDf0z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJb138s8Iuj4goYEVFoQMYP0KdJL0XtuS8Ft2o2spyxOp3mEIT3ORD/ercSPuW+6KOUvrlbMbLtWeD5U9tsYVp2N/VWQOG0JW5EsJ1wRrBlLxwnUeiCO2Ey/BMvCWHMvEIDs7WhF/lRuqI/LUCggR9X80xRDLl5d60zSQJxWUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e7eEHEYw; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e7eEHEYw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737080034; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=LsnmJDLMPx6BOmdSkxnx6bCuBrhMBXTPA1M6hZHcRM0=;
	b=e7eEHEYwLJwDOaOGHFGa1uWEJUkQCSylQiKQ9riTUAc2SiQlY/NeqtBnq3a9Kkp+lSdUGESc4+FlsCT01LzDzs6ZvL1DOnzq7ocuHcmlDem2VdnRmTNxiGJ4n0m3h/PG45qaL7ZgwUOAcaWllKVl9CZtyRQK4eUaSRfH52PwSWI=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNn-gA3_1737080033 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 10:13:53 +0800
Date: Fri, 17 Jan 2025 10:13:53 +0800
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
Message-ID: <20250117021353.GF89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>

On 2025-01-16 17:17:33, Alexandra Winter wrote:
>
>
>On 16.01.25 12:55, Julian Ruess wrote:
>> On Thu Jan 16, 2025 at 10:32 AM CET, Dust Li wrote:
>>> On 2025-01-15 20:55:20, Alexandra Winter wrote:
>>>
>>> Hi Winter,
>>>
>>> I'm fully supportive of the refactor!
>
>
>Thank you very much Dust Li for joining the discussion.
>
>
>>> Interestingly, I developed a similar RFC code about a month ago while
>>> working on enhancing internal communication between guest and host
>>> systems. 
>
>
>But you did not send that out, did you?
>I hope I did not overlook an earlier proposal by you.

No, I just did a POC and didn't find the time to improve it.
So I think we can go on with your version.

>
>
>Here are some of my thoughts on the matter:
>>>
>>> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>>> Device) instead of ISM (Internal Shared Memory). 
>
>
>So where does the 'H' come from? If you want to call it Shared Memory _D_evice?

Oh, I was trying to refer to SHM(Share memory file in the userspace, see man
shm_open(3)). SMD is also OK.

>
>
>To my knowledge, a
>>> "Shared Memory Device" better encapsulates the functionality we're
>>> aiming to implement. 
>
>
>Could you explain why that would be better?
>'Internal Shared Memory' is supposed to be a bit of a counterpart to the
>Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
>devices and by ism_loopback. So what is the benefit in changing it?

I believe that if we are going to separate and refine the code, and add
a common subsystem, we should choose the most appropriate name.

In my opinion, "ISM" doesn’t quite capture what the device provides.
Since we’re adding a "Device" that enables different entities (such as
processes or VMs) to perform shared memory communication, I think a more
fitting name would be better. If you have any alternative suggestions,
I’m open to them.


>
>
>It might be beneficial to place it under
>>> drivers/shd/ and register it as a new class under /sys/class/shd/. That
>>> said, my initial draft also adopted the ISM terminology for simplicity.
>> 
>> I'm not sure if we really want to introduce a new name for
>> the already existing ISM device. For me, having two names
>> for the same thing just adds additional complexity.

I believe that if we are going to rename it, there should be no
reference to "ISM" in this subsystem. IBM's PCI ISM can retain that
name, as it is an implementation of the Shared Memory device (assuming
we adopt that name).

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
>With this proposal ism_loopback is just another ism device and SMC-D will
>handle removal just like ism_client.remove(ism_dev) of other ism devices.
>
>But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
>which is a big disadvantage, I agree. The ism layer is prepared for dynamic
>removal by ism_dev_unregister(). In case of this RFC that would only happen
>in case of rmmod ism. Which should be improved.
>One way to do that would be a separate ism_loopback kernel module, like you say.
>Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
>I also think it is a great way for testing any ISM client, so it has benefit for
>anybody using the ism module.
>Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
>(Once we agree if and how to represent ism devices in genera in sysfs).

This works for me as well. I think it would be better to implement this
within the common ISM layer, rather than duplicating the code in each
device. Similar to how it's done in netdevice.

Best regards,
Dust

