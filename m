Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43918A93C;
	Sat, 18 Jan 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737214322; cv=none; b=pbdn0JZOJ7chepKMtg7cKpeFaFF6dWFr5v841HlO+DaAjwvYMLUe2L0U9ZKIkkBjEfo5PQTWSQzdLN9IbZcZsZojvfxyfSj2KEgh4yumdd/mRHCU2pkGfnQeGHoBASuASQW4O33u6aM7L4CANaksmyjrnVAOOoMd/u2fLbcchro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737214322; c=relaxed/simple;
	bh=ZiEFqrXMXBUDaz/Mgv8SkHBj8ZsUoxRHA8O+A/UAHaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEXwRofuT7KbCcQoFvN9+HpjmbTXc8bRRxF+3iHPHWNJbbZlDJqkk9xQ090JYHx5nTHMaH4CTs9JjUtN0UV5zRf7poIGKwxv5mdZLY8VGppo2VvYflm7BhgSwD8gkwfjAIJeiOP+H8FLv+M1TVt1Q0HiC1OOZRDo1ogZNzUDlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N99tlrxx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N99tlrxx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737214315; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=um4EpNPGGZn6uHOIvs0vt5Qo5OXfZuSdQuMmUsvwHTA=;
	b=N99tlrxxojXtoZaqoUqNY+j7tm5dfKLj4Ul339SL6D7Nq2rzbX/RdA3iEFu9ukuHJwYJkCcURv4d5RrvP5x5AfzC+WXSz3nTPWoh0eU5NCxRZrfDRf0kt++5Q0ZNN0pVPERzkDLmHo3FocOzL8JQLtVIPQqQhH5IX2C393/oSM0=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNrobRO_1737214314 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 18 Jan 2025 23:31:54 +0800
Date: Sat, 18 Jan 2025 23:31:54 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
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
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <20250118153154.GI89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>

On 2025-01-17 11:38:39, Niklas Schnelle wrote:
>On Fri, 2025-01-17 at 10:13 +0800, Dust Li wrote:
>> > 
>---8<---
>> > Here are some of my thoughts on the matter:
>> > > > 
>> > > > Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>> > > > Device) instead of ISM (Internal Shared Memory). 
>> > 
>> > 
>> > So where does the 'H' come from? If you want to call it Shared Memory _D_evice?
>> 
>> Oh, I was trying to refer to SHM(Share memory file in the userspace, see man
>> shm_open(3)). SMD is also OK.
>> 
>> > 
>> > 
>> > To my knowledge, a
>> > > > "Shared Memory Device" better encapsulates the functionality we're
>> > > > aiming to implement. 
>> > 
>> > 
>> > Could you explain why that would be better?
>> > 'Internal Shared Memory' is supposed to be a bit of a counterpart to the
>> > Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
>> > devices and by ism_loopback. So what is the benefit in changing it?
>> 
>> I believe that if we are going to separate and refine the code, and add
>> a common subsystem, we should choose the most appropriate name.
>> 
>> In my opinion, "ISM" doesn’t quite capture what the device provides.
>> Since we’re adding a "Device" that enables different entities (such as
>> processes or VMs) to perform shared memory communication, I think a more
>> fitting name would be better. If you have any alternative suggestions,
>> I’m open to them.
>
>I kept thinking about this a bit and I'd like to propose yet another
>name for this group of devices: Memory Communication Devices (MCD)
>
>One important point I see is that there is a bit of a misnomer in the
>existing ISM name in that our ISM device does in fact *not* share
>memory in the common sense of the "shared memory" wording. Instead it
>copies data between partitions of memory that share a common
>cache/memory hierarchy while not sharing the memory itself. loopback-
>ism and a possibly future virtio-ism on the other hand would share
>memory in the "shared memory" sense. Though I'd very much hope they
>will retain a copy mode to allow use in partition scenarios.
>
>With that background I think the common denominator between them and
>the main idea behind ISM is that they facilitate communication via
>memory buffers and very simple and reliable copy/share operations. I
>think this would also capture our planned use-case of devices (TTYs,
>block devices, framebuffers + HID etc) provided by a peer on top of
>such a memory communication device.

Make sense, I agree with MCD.

Best regard,
Dust

