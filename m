Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1A382391;
	Mon, 30 Mar 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895976; cv=none; b=BdCqr+6FP02qZlRK56A0Ur8Pjpqt3//Ou6C6MGIrqoeJYQYEhfdpMG73FCOE2nBZ0V2dW1BSLxsxr8+tYHvgo1Umc7Uyva/LQB6zw8lahrLv4JZWgJPLnS2qrThegGlp7gI2XqrTpOu7Snc9Yg5HEPI+YZjxobFHEK2FwrQd9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895976; c=relaxed/simple;
	bh=mnv9e8QJ/jw0xqPEuiuY4pozE+28iBaA0mh8sFehcCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TypjxUfFTbggf0SGZUbzUWDGP/4ZPE5zmDrGGv7hZ1SEuk6YGd3kItmVeV7oQVOcwKkIZ5aNTzTF7ps/qZyMQ3NmEQ08sD9EuRY5AQDFu4iMH19TxNzoTba+lEzKuj9D6mlkST3tBWiM/kSgnusLJdcfKyNopENQXzHPgnfKIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dHFQdM38; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rXd7v7Lp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dHFQdM38";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rXd7v7Lp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C9BD140026B;
	Mon, 30 Mar 2026 14:39:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 14:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774895973;
	 x=1774982373; bh=ZplfpB0cjd9kg8wAfMC2ogmEVqs/9HnbmdmVOnPFHWc=; b=
	dHFQdM38a0uSgcDg05vc44mWJng1bAG+FBaN1Xeo4D4sHzjHGiuTdILIKYwNfa14
	IQCb2fsqW1uYYzINpUkxi+V+spAB1WDlXe2uMX6s+0+cjRxxxugSP/ob/xx2Y6Zv
	L+nrRjS/4NseD4EZpUlTuxosvFiy4rGwq2QVLU6op+AB5klTgxEBxjsI+0ByCvrg
	Ea1d65X2cWwpAPkaB2c8RaYDMf4N3hX2wiUWxqGT5XsIe3FcnYoELEtBW2KDVynD
	cQXyRkS09nbNu4Z+gp/72WJ1hvB1lcGqNQ6p2hdMuCGQxl6yu1YGH65OC0rm8A6D
	AgZ5wGyG4HTK/T+tApXqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774895973; x=
	1774982373; bh=ZplfpB0cjd9kg8wAfMC2ogmEVqs/9HnbmdmVOnPFHWc=; b=r
	Xd7v7Lpm2dORlnjGCEewzaeZUQcSNCxzL0OlK1NkJtEuTtdn0EPDHlSUDOYpSLQL
	vqTgRggLk8uUvJkSMQi4eJfKnRWacIhfSQ+jFq8h8/2PNFK+LKw+QOd1utMPPMli
	z7bAcErl6HjIr8c1caLWrhsps3tRKySqZ2zgTL9iCe5IwTJvdxajBmXgkbQvq+Yg
	Z2tYoZNZwANkIbT6uyS+/4VQfbTv6mu4YjLAhFHWBqE8joVsVxcILoSE3cBBlTKT
	vd6rMAKVGWhW2YTFGePapIWCEiqI4aM2smpoz7gNPKPuId6ytYdUXrISyD7Fo8Kz
	rkEtM8UrrYIQzpnvg+BFg==
X-ME-Sender: <xms:ZMPKabGE50KLbQmfbNKEx8f6DkAuUw2dv8_Q4n7gx9jiiTw-35TfvA>
    <xme:ZMPKaUe0mKcM76aUoUCX-Nq63vEri7DAFM-D3z77-wFO4eSc0iSc6pJR0tJcJQp8g
    Z3aELRtapHlHj14VlDI5jLEucDTG_i-fZ4DscP-wqTFmmOimZXfYA>
X-ME-Received: <xmr:ZMPKaY_YunkgTAFUv91V7Zkqr0VjcwNuHpS1FzeDnst3Q938sL6twstNy0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeljedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ZMPKaSZKT-x8-ocQWsKybO5oysZgOXeGEh4Yt0oaMm7RzROnkcSq6Q>
    <xmx:ZMPKaRdnZyZ7K5PXPkH-slnaCyHSNZ964VXrMPUvZE8-AjPuE6nM6g>
    <xmx:ZMPKaYSESJUmG8BW1booBccvDt15AE0Y1Jca1fxonjWZAlOQ5WCf0Q>
    <xmx:ZMPKaTlhC10Jtgk8iNx6tC2bFAa-xcz5-drQfAYm3vKIkNkchDHq_w>
    <xmx:ZcPKaUa6ld2chtb91mdTQRtzeJF4UUotOowOfLZsWyfXOJ9U7bGMMqnT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 14:39:29 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:39:25 -0600
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
Message-ID: <20260330123925.713edac4@shazbot.org>
In-Reply-To: <20260330181645.GE246076@ziepe.ca>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
	<20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
	<4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
	<3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
	<64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
	<20260330093646.03b0455f@shazbot.org>
	<20260330155651.GD246076@ziepe.ca>
	<20260330120945.023b2295@shazbot.org>
	<20260330181645.GE246076@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 15:16:45 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Mar 30, 2026 at 12:09:45PM -0600, Alex Williamson wrote:
> > On Mon, 30 Mar 2026 12:56:51 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >   
> > > On Mon, Mar 30, 2026 at 09:36:46AM -0600, Alex Williamson wrote:  
> > > > There's risk involved with changing the default shift.  The fear is
> > > > there's userspace drivers that hard code the shift.  DPDK was even such
> > > > a user at one point, iirc.  Maybe it's ok to break such users, maybe
> > > > there are actually no such users left and it's all FUD at this point.
> > > > Either way, I have a hard time justifying that risk for a single,
> > > > obscure S390 device.    
> > > 
> > > If we go ahead with that DMABUF series could obscure cases like this
> > > be told to just get a DMABUF FD and then mmap it? Avoid this whole
> > > issue?  
> > 
> > The ISM device here doesn't support mmap, so that much is still a
> > problem.  However, if we imagine a future where we've fully converted
> > to dma-buf for both DMA and CPU access to BARs, then maybe...  I don't
> > know how we'd describe a region overflow in the "legacy" ioctls to
> > maintain some consistency between what's exposed through the region
> > versus the dma-buf.  Thanks,  
> 
> Oh, Ok.. I go back to what I've said before many times, if we fix this
> we should fix it by making the region offset fully dynamic and managed
> by a maple tree.
> 
> We can detect at runtime when the vfio device is created if it is
> compatible with the legacy indexs and use them by default to maintain
> compatibility. But cases like this where the region is just too big
> (and GPUs will get there soon too!) can run a full dynamic mode.

Yes, that would be the ideal balance of enabling larger BARs while
retaining compatibility for existing devices.  Sounds like we'll
continue down the variant driver path for this one-off device for
now.  It remains fairly self contained so long as we don't add more
regions for vfio-pci-core to manage.

This could be a good project if someone is looking though, especially
if it had a build-time config option to set the minimum region size so
we can exercise it before we hit 1TB BARs.  Thanks,

Alex
