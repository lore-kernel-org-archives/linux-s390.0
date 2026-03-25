Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290B3E92A8;
	Wed, 25 Mar 2026 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461032; cv=none; b=mutOb9hmU0P87I9gUToH/mnBsxx+8vJW1YO2HxWhW2RyGQEytcsWVRt6g4Agz2ZlQKCr3uSyEc6N+Xv9p5yFgVrGacdbWOP+XMZ4ioYdaVOQ84G6Gqz/E+NrNeZBGuAMODWwsJaQR6ySh4r1G2BhTxxq2fzuA3+tjgBSbmqLIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461032; c=relaxed/simple;
	bh=SIVSMCrBlz0KV8OK7G5My33qGsJMdpAScmuH+aPsA3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7fsFAd0gLmsiHWIrBem0fKKvlmwhqo7SVgq8mqC7a4yJqCcvQgWkbiV3srqoLl5Onvd6NvkE/vKTPR9dUYPl1eKRMcYrgwtFWs8UKxNd5ijKwY2ZvXTnTm1CXnmR1Vt1HbwxOqKv2uwi24gc6ORqIMq9+oobveApUYx1XUXAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cfle9mdS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzKzY3a3; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cfle9mdS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzKzY3a3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54BBE7A006C;
	Wed, 25 Mar 2026 13:50:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 25 Mar 2026 13:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774461028;
	 x=1774547428; bh=pm7r3+s8pl7Hfj4UkVm3eVLx7AjrB7g+Dwi1zL2eB+4=; b=
	cfle9mdSNpfVFHzJaDj3TZrRvAnS62+YfO0/FB7iyUsoPSI9TOs87nMImmIv18nu
	fsER7ikAqwXUvKAhx1TAMeWmIADrKsLW5PtVGwTWjEBQYmjy+MMP5C5L7q3zR20E
	FM9Dv98VB1RMFAvN3TNTE523sFlY+oPlgL+Cqtk+hEMnUGqyAD5S2YGZZveP6QoU
	unvjhkOOBabsv4300o6RfVlIm1G0I+hZsUXi5lcvj+5flJ8Vm8qpQZxqFkS2V4ye
	mt5OyLfAAvF7rWTVvuh8EI2p52S/MkA9C4PXCNkKsNleylTlSvBOguC/YB/E/VAb
	CjRJUohknAyCvgIgsO2LQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774461028; x=
	1774547428; bh=pm7r3+s8pl7Hfj4UkVm3eVLx7AjrB7g+Dwi1zL2eB+4=; b=d
	zKzY3a3ht2FpkDlIlrXiA8K6jrMX0B6Jn/6NS5udjFHfKmalHJhL0KKKghiBZRAw
	BxpvNjLeHgyixd/GHdlXCG0Uo8ElniLMTE23xnZx5ZAScTvyC+PbhvrI7kksMBCF
	gJbLOeBVsEHpgAVPL1LIVQh+Uutkq1dk4Nl7bvSnn7auwYLTsOcuQI+oDK2rKTlI
	CDonl+o63TwpCmhvCDLU8bJ6PZvfMt1FS4UuBQpLUF1bHADcnZ/SrkpAlkmgoawE
	7Sdy9FIXyiRloVW6tefTCF0xBPQJdpdh45+SqkwF9Bp6Yx81e+3R+Sz+GFEbYZ2U
	+NSNnUeBYnZuT0R80eu9A==
X-ME-Sender: <xms:YyDEaWypC8oszZOPBbB-3PPMdUdrd7SocPP-gbgzJnEJWbszHiS6QQ>
    <xme:YyDEaco_899_ePnTU5GMoA8rffXzREhlfoH8ve1XdqbOqd0UxDUaFtWiXbhsB4tWa
    Th88IPq0PebkXuuMq84biGtVdPaJfauygMIbQhKZBDzf5NnPcUH24g>
X-ME-Received: <xmr:YyDEaedE4IyV8SP-LpHAukJlRxXZjxf-WMzracbxB-CMefd0dakYFCHSkR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhhifhhmsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrg
    hsseifuhhnnhgvrhdruggvpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsg
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YyDEaXoEwGtKHzarWg2KKcxKqdqMxFyKw4SUTrDG1CpieCYM1aeTKA>
    <xmx:YyDEaQmJauXzDPGTCmTBM5bAJyXsCEDliIsGejkpHbI2l1Fc2xvkig>
    <xmx:YyDEaQTicLvX5XKax1_5PI83b1WAASOvbb1qDxiEuLtV2KPBg-83zg>
    <xmx:YyDEaeZDs24kA1MoQ6QFQxL8TXx1oAmCG0kzUbLXY50tUTyUY7_0HA>
    <xmx:ZCDEaZEkRN8brBKY9ncpwlGqQxh2vfPdWeM6JPWoeja9Jf29wp9qNZXC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 13:50:26 -0400 (EDT)
Date: Wed, 25 Mar 2026 11:50:25 -0600
From: Alex Williamson <alex@shazbot.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de,
 kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, Julian Ruess
 <julianr@linux.ibm.com>, alex@shazbot.org
Subject: Re: [PATCH v11 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
Message-ID: <20260325115025.462317c8@shazbot.org>
In-Reply-To: <20260324212602.GA1151826@bhelgaas>
References: <20260316191544.2279-10-alifm@linux.ibm.com>
	<20260324212602.GA1151826@bhelgaas>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 16:26:02 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Mar 16, 2026 at 12:15:44PM -0700, Farhan Ali wrote:
> > We are configuring the error signaling on the vast majority of devices and  
> 
> Who is "we"?  If a function configures error signaling, can you
> mention the name?
> 
> > it's extremely rare that it fires anyway. This allows userspace to
> > be notified on errors for legacy PCI devices. The Internal Shared
> > Memory (ISM) device on s390 is one such device.   
> 
> This commit log talks about things that could be done, but doesn't
> actually say what the patch does or what makes it safe and effective,
> and I'm not VFIO-literate enough for it to be clear.
> 
> These pci_is_pcie() tests were added by dad9f8972e04 ("VFIO-AER:
> Vfio-pci driver changes for supporting AER"), so I suppose the
> dad9f8972e04 assumption was that AER was the only error reporting
> mechanism, and AER only exists on PCIe devices?

Yes, that's the conclusion we came to in previous discussions that
Farhan notes in their reply.

> But s390 can report errors for conventional PCI devices, and you want
> VFIO to support that as well?
> 
> Obviously this change needs to be safe for all arches, not just s390.
> I suppose it's safe to report the VFIO_PCI_ERR_IRQ_INDEX info
> everywhere; it's just that it will never be used except on s390?  And
> I guess powerpc, which can get to vfio_pci_core_aer_err_detected() via
> eeh_report_failure().
> 
> It looks like vfio_pci_driver provides vfio_pci_core_err_handlers
> whether the device is conventional PCI or PCIe, and s390 can already
> call vfio_pci_core_aer_err_detected() (the .error_detected() hook) via
> zpci_event_notify_error_detected(), so this patch makes it possible
> for the guest (QEMU, etc) to learn about it?
> 
> > For PCI devices on IBM s390 error
> > recovery involves platform firmware and notification to operating system
> > is done by architecture specific way. So the ISM device can still be
> > recovered when notified of an error.  
> 
> I guess this error recovery part would be done by the guest ISM
> driver, triggered when when something like QEMU receives the eventfd
> signal from vfio_pci_core_aer_err_detected()?
> 
> > Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>  
> 
> I don't maintain VFIO, so I'm just kibbitzing here.  Hopefully Alex
> will chime in.

It's the previous patch about restoring open state of the device on
.reset_done that gives me more anxiety than just reporting that
non-PCIe (non-AER) devices can report errors.  At worst here, I think
userspace might be wiring an interrupt on a conventional device that
cannot fire, whereas most PCIe device have AER.  The number of
conventional device in use with vfio-pci is probably not enough to
worry about though.

For completeness, I'll note that QEMU sets a "pci_aer" flag based on
whether this error IRQ is exposed, where I think we had intended this
might interact with emulated AER.  However, it never made it that far
and just registers a handler that stops the VM.

Farhan, this and the previous patch should use "vfio/pci:" as their
title prefix.  Thanks,

Alex

> > ---
> >  drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
> >  drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
> >  2 files changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index f1bd1266b88f..cfd9a51cd194 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -786,8 +786,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
> >  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
> >  		}
> >  	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
> > -		if (pci_is_pcie(vdev->pdev))
> > -			return 1;
> > +		return 1;
> >  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
> >  		return 1;
> >  	}
> > @@ -1163,11 +1162,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
> >  	switch (info.index) {
> >  	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
> >  	case VFIO_PCI_REQ_IRQ_INDEX:
> > -		break;
> >  	case VFIO_PCI_ERR_IRQ_INDEX:
> > -		if (pci_is_pcie(vdev->pdev))
> > -			break;
> > -		fallthrough;
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> > index 33944d4d9dc4..64f80f64ff57 100644
> > --- a/drivers/vfio/pci/vfio_pci_intrs.c
> > +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> > @@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
> >  	case VFIO_PCI_ERR_IRQ_INDEX:
> >  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> >  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> > -			if (pci_is_pcie(vdev->pdev))
> > -				func = vfio_pci_set_err_trigger;
> > +			func = vfio_pci_set_err_trigger;
> >  			break;
> >  		}
> >  		break;
> > -- 
> > 2.43.0
> >   

