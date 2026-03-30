Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96830DEB0;
	Mon, 30 Mar 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894192; cv=none; b=MVJPxLEOOUVchrXTFvjS/8avrOylIc1jmtdH1Bp+BBMyDXXkINnbwvv/nmQ6zw28+6cv/gIUzclGNr/9sMI9KyMt6yB1LZigEq5mdk+LvY0DAbKio6z5F9bpe/ZrqtBqaQd8b25cuOYaDaCQ5QrXZyPRNfjhFPHqzeAAXzcPlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894192; c=relaxed/simple;
	bh=75+5fFJFyUQFkda8RvZG8+2ldWjpRSvYlyVFKOtZpdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n63sQVqGzDnayHKVGicAF4JT4K+EO88qSZ1fPzjZzTt73uK/O1wkZxJ777ONGYUpuptuiiiBeHNQg+H0JrU8oZUn3jhhmUM4a0c5us2U40WdGNrwFsoX80i548viAnjdAOUVlKizjk+GGs4QFfsPuGcJPwZfMf0oQDkhwFZSbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TzqQBR2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwbJnNz3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TzqQBR2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwbJnNz3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B69E8EC0221;
	Mon, 30 Mar 2026 14:09:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 14:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774894189;
	 x=1774980589; bh=PxnB1idRPklbhSng1j8iSiRberE5zUGTRcSSDsXHQBg=; b=
	TzqQBR2Y7OfhUppYl3vObej4dhN/25IlgN57F3vZK/i2QpYDHSoOXVZJIWeospmH
	Xgb+K0jIrsPCJv5vkYZPL/THvSjVZrrO+KTymV20YnBY1oNurwq1uIZblaPVEWIm
	HZrCcfKXOEcq5yXK8sHO6ZUe8LlPOq8Ez2xfnsYxSdWBGm75WHmukxzQZosm3XJl
	5mIsr9ElACXbnpjaKpks6jcFyYhjKRo8DCPxPcr2l1zq0lUWjazy4o0RiK58Xo4o
	o7Rm2ok2mNlL3T14OXLBVKLyeIDY9P3BYpb3ANRIeym1f0SYUB5+cV9xluC/AuoH
	kAsbljk/k9YHWof5nCC9sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774894189; x=
	1774980589; bh=PxnB1idRPklbhSng1j8iSiRberE5zUGTRcSSDsXHQBg=; b=H
	wbJnNz3NDdLIRV+GJe8z/NRXJfkxd3a9h4JVOglSCXLC1r9GSWVPT9c9S7+kDdyt
	ezhcGj7S1K3X6zg/JAgvmj2OiM3GLSwBsRcbcv5erU70ktDhvjDy0mTJ4mLqjAPC
	Ctv2bcJm5gC1YWbBttF/rD0z6DNjUDTmwN6coLiRYtPP5DrN+Idd/3UIXU6rhDDC
	FrVT4JrECqwRgYcfDhZurV4Xc0WeyxE7GKT5FKopk+/mnMFdXlfbkalA/bdKtfpm
	/cFAtAfBT1P/DOXnKnWIFFZCQZFqFbWqi/rzHPRnxSlWCLJeTcZIuK0BaVTa03w0
	XG5kzzrM06MFgdH6NAJbQ==
X-ME-Sender: <xms:bLzKaZKcDa9xtDApAAlVbT93tYZI4fTVVz8M9zrQ0UbIgzWeYLgGPQ>
    <xme:bLzKaRQFsQ6ppC0PVO0_5a9275IrctQBsq1A5GMJOgFQzawdHHmuW_5SKchBW-3Os
    Tb_Faac1Vv28FXOKx13HE6RUwA1FByupSPCsJv4aUjZey6nFpfV5A>
X-ME-Received: <xmr:bLzKadhtqXq_sXgsKO_629e-pa4m6-mhWfis9qHW61kn5ut_ilNeCCNZMjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhope
    hstghhnhgvlhhlvgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopegrlhhifhhm
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepjhhulhhirghnrheslhhinhhugi
    drihgsmhdrtghomhdprhgtphhtthhopeifihhnthgvrhgrsehlihhnuhigrdhisghmrdgt
    ohhmpdhrtghpthhtohepthhssehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepoh
    gsvghrphgrrheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehgsggrhigvrhes
    lhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopeihihhshhgrihhhsehnvhhiughirg
    drtghomh
X-ME-Proxy: <xmx:bLzKaTtwUJm_ryd9yzH25N9axxyRJk_Y3GH57nU3R883BeeH3phWBg>
    <xmx:bLzKaQh8dylLjzB3BbGjD3n7BM6NKPstFqy8rUiSJC1RvKxXPzU45w>
    <xmx:bLzKaSH1HaI2PADrMbWGoXtlWcjpNEuEc6QFZZP59tBJjvj4iI_o0Q>
    <xmx:bLzKaRJi1Y0-uezjBm3lHEazmhIJbIEu4s6WV_BPhN546Q03abVnFQ>
    <xmx:bbzKaWX9kSRGVDF2-bptU3aMpYTb534xc0Wsh-b4jJIt25OrFyv6QcyV>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 14:09:47 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:09:45 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
 wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
 gbayer@linux.ibm.com, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 mjrosato@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
 agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260330120945.023b2295@shazbot.org>
In-Reply-To: <20260330155651.GD246076@ziepe.ca>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
	<20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
	<4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
	<3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
	<64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
	<20260330093646.03b0455f@shazbot.org>
	<20260330155651.GD246076@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 12:56:51 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Mar 30, 2026 at 09:36:46AM -0600, Alex Williamson wrote:
> > There's risk involved with changing the default shift.  The fear is
> > there's userspace drivers that hard code the shift.  DPDK was even such
> > a user at one point, iirc.  Maybe it's ok to break such users, maybe
> > there are actually no such users left and it's all FUD at this point.
> > Either way, I have a hard time justifying that risk for a single,
> > obscure S390 device.  
> 
> If we go ahead with that DMABUF series could obscure cases like this
> be told to just get a DMABUF FD and then mmap it? Avoid this whole
> issue?

The ISM device here doesn't support mmap, so that much is still a
problem.  However, if we imagine a future where we've fully converted
to dma-buf for both DMA and CPU access to BARs, then maybe...  I don't
know how we'd describe a region overflow in the "legacy" ioctls to
maintain some consistency between what's exposed through the region
versus the dma-buf.  Thanks,

Alex
