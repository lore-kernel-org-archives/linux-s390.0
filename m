Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E27383;
	Mon, 20 Jan 2025 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737354085; cv=none; b=tpFIMycswVkMxEQC5cC0ldj8g5IJxtSnEqo93pFnmx9+5aV29Dv7KmP76oW33N9GuDIkxP7Z+wAJCW4wqRfn0Gy3PcdpbRqGGhIXnT2LLl+iysh3OQJ5c+gdVz6ZU+rxc1XzFca6p9Qp8TxdyTziCCXtC+byxOVyuvCuaUD963E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737354085; c=relaxed/simple;
	bh=zfwYgDRUW9Zl6cHu4rZP3RzJXaaSwNoPlStDkgjDCDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ano3XrDqH+B7iJLuIYbQmvk+XUtokBczr0h3ytoZ/R/8DTZ7j/6fp52w1OH9X+zNNzamwO6NMwgmjvln/BRS2pm4nt7DFzVmQ6foXx6hSmRXQNNAddbFYbn88Y0AOeBRFyh+EV8z8zZ7ljYK1VQFd9sPA5M+p95akHhAdmdccM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BHy719zu; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BHy719zu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737354074; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Wlr3z3S7c27vFsqcrMzjiJr4K74Vv/O5ns4GoAc3b58=;
	b=BHy719zucLsVc00i/i3RZc7BPS4BrfFkmEubaki+F/TwY5H1/efZ1tMFawXzFBhWXzcEowazXsIMI4mPZEou/651Ar2upvf1V/321o2QLAMVqBFiZUZIa1+QprDCggCmWvV2IVRVtF4JToFg1WYk9B3AFMdpOoYikk1AyP8Zn1A=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNwwNLG_1737354072 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 14:21:13 +0800
Date: Mon, 20 Jan 2025 14:21:12 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <20250120062112.GL89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
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
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85d94131-6c2b-41bd-ad93-c0e7c24801db@lunn.ch>

On 2025-01-17 21:29:09, Andrew Lunn wrote:
>On Fri, Jan 17, 2025 at 05:57:10PM +0100, Niklas Schnelle wrote:
>> On Fri, 2025-01-17 at 17:33 +0100, Andrew Lunn wrote:
>> > > Conceptually kind of but the existing s390 specific ISM device is a bit
>> > > special. But let me start with some background. On s390 aka Mainframes
>> > > OSs including Linux runs in so called logical partitions (LPARs) which
>> > > are machine hypervisor VMs which use partitioned non-paging memory. The
>> > > fact that memory is partitioned is important because this means LPARs
>> > > can not share physical memory by mapping it.
>> > > 
>> > > Now at a high level an ISM device allows communication between two such
>> > > Linux LPARs on the same machine. The device is discovered as a PCI
>> > > device and allows Linux to take a buffer called a DMB map that in the
>> > > IOMMU and generate a token specific to another LPAR which also sees an
>> > > ISM device sharing the same virtual channel identifier (VCHID). This
>> > > token can then be transferred out of band (e.g. as part of an extended
>> > > TCP handshake in SMC-D) to that other system. With the token the other
>> > > system can use its ISM device to securely (authenticated by the token,
>> > > LPAR identity and the IOMMU mapping) write into the original systems
>> > > DMB at throughput and latency similar to doing a memcpy() via a
>> > > syscall.
>> > > 
>> > > On the implementation level the ISM device is actually a piece of
>> > > firmware and the write to a remote DMB is a special case of our PCI
>> > > Store Block instruction (no real MMIO on s390, instead there are
>> > > special instructions). Sadly there are a few more quirks but in
>> > > principle you can think of it as redirecting writes to a part of the
>> > > ISM PCI devices' BAR to the DMB in the peer system if that makes sense.
>> > > There's of course also a mechanism to cause an interrupt on the
>> > > receiver as the write completes.
>> > 
>> > So the s390 details are interesting, but as you say, it is
>> > special. Ideally, all the special should be hidden away inside the
>> > driver.
>> 
>> Yes and it will be. There are some exceptions e.g. for vfio-pci pass-
>> through but that's not unusual and why there is already the concept of
>> vfio-pci extension module.
>> 
>> > 
>> > So please take a step back. What is the abstract model?
>> 
>> I think my high level description may be a good start. The abstract
>> model is the ability to share a memory buffer (DMB) for writing by a
>> communication partner, authenticated by a DMB Token. Plus stuff like
>> triggering an interrupt on write or explicit trigger. Then Alibaba
>> added optional support for what they called attaching the buffer which
>> means it becomes truly shared between the peers but which IBM's ISM
>> can't support. Plus a few more optional pieces such as VLANs, PNETIDs
>> don't ask. The idea for the new layer then is to define this interface
>> with operations and documentation.
>> 
>> > 
>> > Can the abstract model be mapped onto CLX? Could it be used with a GPU
>> > vRAM? SoC with real shared memory between a pool of CPUs.
>> > 
>> > 	Andrew
>> 
>> I'd think that yes, one could implement such a mechanism on top of CXL
>> as well as on SoC. Or even with no special hardware between a host and
>> a DPU (e.g. via PCIe endpoint framework). Basically anything that can
>> DMA and IRQs between two OS instances.
>
>Is DMA part of the abstract model? That would suggest a true shared
>memory system is excluded, since that would not require DMA.
>
>Maybe take a look at subsystems like USB, I2C.
>
>usb_submit_urb(struct urb *urb, gfp_t mem_flags)
>
>An URB is a data structure with a block of memory associated with it,
>contains the detail to pass to the USB device.
>
>i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>
>*msgs points to num of messages which get transferred to/from the I2C
>device.
>
>Could the high level API look like this? No DMA, no IRQ, no concept of
>a somewhat shared memory. Just an API which asks for a message to be
>sent to the other end? struct urb has some USB concepts in it, struct
>i2c_msg has some I2C concepts in it. A struct ism_msg would follow the
>same pattern, but does it need to care about the DMA, the IRQ, the
>memory which is semi shared?

I don’t have a clear picture of what the API should look like yet, but I
believe it’s possible to avoid DMA and IRQ. In fact, the current data
transfer API, ops->move_data() in include/linux/ism.h, already abstracts
away the DMA and IRQ details.

One thing we cannot hide, however, is whether the operation is zero-copy
or copy. This distinction is important because we can reuse the data at
different times in copy mode and zero-copy mode.

Best regards,
Dust

