Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261A274FE9;
	Tue, 31 Mar 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989863; cv=none; b=DJY35KNgYIghbm6AZWqaalSScKhgjyT3/KPnKi0CI9S51VjZz9Aib8e0hIDjiajP9hk4GVevoJjYEA0CqkR3WWO3Wl6xBf762LPaW/7Krqv9HsWqm7ME2lePzvCm4z1VZgMAFtBwIYC+iunBf4gzpoms2mS84jFqSR6tJXSGxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989863; c=relaxed/simple;
	bh=9JiShWLzsMfEIFKmmLnX3lKHoUsByhcPPiUx3sx9ljc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBq6d7iE6tLdpmKcPk/GLQwt8LUxhRbkUhWng9oy5r/ldZSndEZuCbMMG21hlBUr8baIEAWja9CLEoJwEJGo0AEBxteZ/44dycMPnRncggnp6WN82Y3OnK3I1AqCuGFcMWK64ErJtd+2xaC2RXfBOfNlj5s6wezeZDp+nHvPI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=VBMvaleZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tqbvb7P5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="VBMvaleZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tqbvb7P5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 351F01D00157;
	Tue, 31 Mar 2026 16:44:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 16:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774989858;
	 x=1775076258; bh=2naYgeCqp4JHbxNG5hbN+LbC6Dsxev/Fv44jf/ivh80=; b=
	VBMvaleZt+xdbRoJyYB18VABz+FxWi5/91aNae+7rgz1BX7PhajEbbuasS3ij4DC
	huNWU9C8s2HgnV1dR5Q8WOziXdzFdclCqr66L+YwjQvOpCKzGhHbwQHJx3LJBWrv
	P4chF+s7ESahKXNCRl7o1AjyaZY+s+m2CiDWyB66XPt5b1J1gkClWOPk42htFW+F
	WkFRi3Hj1dWTCIOEONw7bKiPhc/+3d90vj1UWLKz9Mlc4N5gH9cS17ru5HoxFTAp
	6X8W0IyFewnU5kxfy5S/Cye7goWBgY7qju0OeiKqr/Ud9YYppINfjjxIuNqiY8vT
	H5sNi0jZRbbuxxe7eqdTng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774989858; x=
	1775076258; bh=2naYgeCqp4JHbxNG5hbN+LbC6Dsxev/Fv44jf/ivh80=; b=t
	qbvb7P5NAclNR0cZUBetzKGIU/7IELKS2xk1k1jYuzZfkFMw9cJXJ0BaRq6BTV9K
	UnlvjVeugDQlaVgODJBCMnm6855GbY43OZrut7Wuv565ZuPeByyWklx2MRnpGJMg
	LUi6JKaKlVGsD6sd0jeMnO7ltOK/uxUaNcIX3tGGX5PhiyisNQcazkOw/whg8vI3
	b5+0bVyz1ejTL0FjPtr1t3NcShfolO93Uxfs1GhN8GUc7CHYkrSfoUTDhd0OyKkD
	0xtGzdveLUa10B182NEX0F7TqYcwozl7GnUJJ10s1dWPDTCAIDCLul488BcNtyOr
	HyGfIYxS8xzzKy5cJTFCA==
X-ME-Sender: <xms:IjLMacrsgBD3gu0IR37Z5YNDHIlTiFshUvC-nZwKKrMhH9IYpGsjyQ>
    <xme:IjLMaex8fKqYyhE-bGQ7QRv3D0-xPg9cVLaipR1MzJ-in1ntgG1dq1Mwhse_N_kLq
    O3C8oSz4_S6tQY13Y9LrFAXQ7Rc3HEikbJXyvx96Un60GsSWF1qUg>
X-ME-Received: <xmr:IjLMadCEF2kj4gnvPHD0jZcqmaLp7Kcmu7ZHzqm1Fb3K9rTJxpZC8IJi7Ak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpeejteekhedvleehjefhgfdvteetudevieeiuefhhfevjeduleefiedvueegudeu
    hfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhn
    sggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgthh
    hnvghllhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepjhhgghesiihivghp
    vgdrtggrpdhrtghpthhtoheprghlihhfmheslhhinhhugidrihgsmhdrtghomhdprhgtph
    htthhopehjuhhlihgrnhhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepfihi
    nhhtvghrrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehtsheslhhinhhugi
    drihgsmhdrtghomhdprhgtphhtthhopehosggvrhhprghrsehlihhnuhigrdhisghmrdgt
    ohhmpdhrtghpthhtohepghgsrgihvghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpth
    htohephihishhhrghihhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:IjLMadMHc0M9iz76WizsN6efPPoIczIRKKmwZ9NFezIwWr3eGz8THQ>
    <xmx:IjLMacCXhD6Y4QmbnmdrEbvb9Pj8kgau2UDjPp_maGCGGQgnegxCbw>
    <xmx:IjLMaXkSOn2zDgo6cmx_kEKJ8COd9oytX3566cieldik_L-wEzovzQ>
    <xmx:IjLMaYrwSnimeExXGjhTOtXaE-BqIgdMOJkhvCkw2ezyHO7qd81ocg>
    <xmx:IjLMaYe4jDFN5PiN3KCRBYvEJ1Fp8oM_asnpUxrtq9sBpIsJyaTH2ijC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 16:44:17 -0400 (EDT)
Date: Tue, 31 Mar 2026 14:44:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Farhan Ali <alifm@linux.ibm.com>, Julian
 Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com, ts@linux.ibm.com,
 oberpar@linux.ibm.com, gbayer@linux.ibm.com, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum	 <skolothumtho@nvidia.com>, Kevin
 Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com, raspl@linux.ibm.com,
 hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260331144415.33f3414b@shazbot.org>
In-Reply-To: <4fb2b835ec81ca0ef24bc1c867d177a7d04b4873.camel@linux.ibm.com>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
	<20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
	<4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
	<3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
	<64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
	<20260330093646.03b0455f@shazbot.org>
	<20260330155651.GD246076@ziepe.ca>
	<20260330120945.023b2295@shazbot.org>
	<20260330181645.GE246076@ziepe.ca>
	<20260330123925.713edac4@shazbot.org>
	<20260331000334.GI246076@ziepe.ca>
	<4fb2b835ec81ca0ef24bc1c867d177a7d04b4873.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 10:29:31 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On Mon, 2026-03-30 at 21:03 -0300, Jason Gunthorpe wrote:
> > On Mon, Mar 30, 2026 at 12:39:25PM -0600, Alex Williamson wrote:  
> > > Yes, that would be the ideal balance of enabling larger BARs while
> > > retaining compatibility for existing devices.  Sounds like we'll
> > > continue down the variant driver path for this one-off device for
> > > now.  It remains fairly self contained so long as we don't add more
> > > regions for vfio-pci-core to manage.
> > > 
> > > This could be a good project if someone is looking though, especially
> > > if it had a build-time config option to set the minimum region size so
> > > we can exercise it before we hit 1TB BARs.  Thanks,  
> > 
> > Well, it took claude an hour to vibe code a draft from a four sentence
> > prompt.. I see many things that need changing/cleaning in here, but
> > the patch strategy and general idea looks sound.
> > 
> > I guess another day of effort would probably get things into something
> > presentable. We are not so far away - maybe the variant driver path is
> > not necessary?
> > 
> > https://github.com/jgunthorpe/linux/commits/vfio_maple_tree/
> > 
> > Jason  
> 
> I'm in no way against changing the offset handling in general but for
> what it's worth, we need a variant driver for ISM regardless, though it
> would be smaller with large offset support. This is because besides the
> large BAR we also have to use our classic function handle based PCI
> instructions to access that BAR instead of the newer memory-I/O (MIO)
> PCI instructions. And sadly the way the ISM device uses the PCI Store
> Block instruction there is no straight forward way to enable the newer
> instructions even if we changed the device implementation. This also
> means that we would want to keep the no-mmap() restriction.

It feels a bit late in the cycle for an untested maple tree conversion
anyway, though I am interested in it for v7.2.  So I think we're agreed
in the variant driver here to handle the excessively large BAR with no
currently foreseeable need for additional regions, and maybe it gets
simplified when that conversion occurs later.  Thanks,

Alex
