Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922D46AED3;
	Fri, 14 Aug 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713970; cv=none; b=KX6s9x4viW5sWx6mopx8ghWvqvbTyHGsTDgIf5CYIeVF96NpNWneaiG1D7DHnm/ezNHg6CxgR6+BvLL+rOEiLNsBwGDi6eRLq/xDHKO/vPxue5+kj45qh7ax/cUMa8OQRd08kKaI0+ADWSxJ/K+Llrnbg6Th6lWCnHqH2almFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713970; c=relaxed/simple;
	bh=PyHM8BBZFmPU/b7RrL1JiCWG4Uf81zYoEnIwJ4aH3Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mipRG7GhLbkzNoX0NF2CBdRB98RXOqgbuS7Y3lAmFYB4XWmyuFqQZQIQqU89uRuuSonN9puKgmVIhmHSeUQoqcS8DNPKqx/DK3u83V3Y6/R8jogDc48ryILL2gROL+BbqIeD5OMWUT91wNiT7ksXx/3g96nlcnXKzyBW7VdKZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT1VbG/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT1VbG/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2351F00A3A;
	Fri, 14 Aug 2026 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713968;
	bh=60pLn9ZJyQXnPkuxB969U2pASlm9jTTNOCWjHPaNZx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TT1VbG/GUj8Up0nX43kMB72pMqDduy+cVqf13gs3mIO8oEzXG7nLCgJ1pZAUaQuaQ
	 m64IbrzbZ5acUO74V22bs8xHRsWHmfiq9APiBRxeVm2MfzcR7HtSSonl1GMZI0T40/
	 wya73YKMhxTO5ZM0RlwoSxK26qF7vCo7F+indbLOJTn+7zGuKlLvpZwTn4ZkVGsxpk
	 gZzMJXffhj0iy2sZIsC1SBpVDs8zbBO2AUHxw4FRMPThPy1GBekeUaI83TXQ/6rDgC
	 kx8bZaaMw9BrlBkp/vA3K66qolyWZPSvAc1Zy90H2MWmSlczWBA8ajOopnw9Y9RMQN
	 /VBJYddgL2HIw==
Date: Fri, 14 Aug 2026 08:26:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	alex@shazbot.org, mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v23 2/5] PCI: Allow per function PCI slots to fix slot
 reset on s390
Message-ID: <20260814132607.GA1353174@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c89ca6f9d0a996ab75c47cb62c57c50635a700bc.camel@linux.ibm.com>

On Fri, Aug 14, 2026 at 10:46:28AM +0200, Niklas Schnelle wrote:
> On Thu, 2026-08-13 at 18:25 -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 05, 2026 at 09:55:15AM -0700, Farhan Ali wrote:
> > > On s390 systems, which use a machine level hypervisor, PCI devices are
> > > always accessed through a form of PCI pass-through which fundamentally
> > > operates on a per PCI function granularity. This is also reflected in the
> > > s390 PCI hotplug driver which creates hotplug slots for individual PCI
> > > functions. Its reset_slot() function, which is a wrapper for
> > > zpci_hot_reset_device(), thus also resets individual functions.
> > 
> > Sorry to come back to this yet again.  I understand the issue with
> > the wrong pci_slot being assigned for these s390 functions.
> > 
> > What I don't understand is why we would use slot_reset() in the first
> > place.  I would expect FLR instead.
> > 
> > The hotplug slot_reset() path is used by pci_reset_bus_function().
> > But given the order in pci_reset_fn_methods[], we would typically try
> > pcie_reset_flr() first, and we would only get to
> > pci_reset_bus_function() if FLR and the other resets are not
> > available.
> > 
> > Since these are actually multi-function devices, I'm surprised that
> > they wouldn't advertise FLR support.
> 
> Good question. The problem isn't that FLR isn't advertised or
> unsupported. Rather we end up needing to use the slot reset when the
> platform has put the PCI function in the architected error state which
> blocks both MMIO and DMA similar to DPC and which we can only get out
> of with the platform specific CLP Set PCI Function Disable/Enable
> hypercalls. FLR still works if you have a function that wasn't put in
> the error state but for most real world errors as well as some service
> scenarios we do end up in the error state where a FLR won't work.

I assume these are standard PCIe devices, but this architected error
state doesn't sound like something from the PCIe spec.

DPC works by disabling the link, but of course that blocks traffic to
all the functions of an MFD, so maybe this is some s390-specific thing
outside the endpoint, e.g., something in a Downstream Port that can
selectively block traffic to/from a specific function?

To get to pci_reset_bus_function() where we can use the slot reset, I
think all the previous methods, including pcie_reset_flr(), must have
failed with -ENOTTY.  But I don't see a place that would do that.
Maybe you remove the other methods from dev->reset_methods[]?

In addition to whatever the CLP Set PCI Function Disable/Enable
hypercall does to unblock traffic to/from the endpoint, I suppose it
does an FLR internally?  It must use some standard PCIe mechanism
because the endpoint doesn't know anything about s390 or the
hypervisor.

I wonder if we should make some kind of direct platform-specific reset
method, or maybe a pcibios_*()-style hook in the pcie_reset_flr() path
instead of this somewhat convoluted pci_slot stuff.  But
s390_pci_hpc.c is pretty simple and maybe it's used for things other
than reset.

Bjorn
