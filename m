Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812C257851;
	Wed, 22 Jul 2026 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759554; cv=none; b=lpfH624a36DhFy2uLpjvk1/FReMpuZQkpok0fWIhHiqdvTbLy9subTBMA0U6D+fTd+aBl0ypQSHNpCOZbws3knt8cESYDv3kFjOhxFBhnB6Zn2rtYN3ArpUPBrSlEQmkwgWCPz1obBlgLUDzPrqzeia6ROwQWJcTtXGGQ0TLqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759554; c=relaxed/simple;
	bh=uprKlxS7ZQgDSIPrPLdW+RRlKXr48VRHjjV3dpQ4qc8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C4DZyvyn9Hh6NSTZYzY9QIn80jHYLe3OEmpYsNUlN1tzTN2XxevmSMgzwG6aEmY1cFXzN63qV3zNEx2cGcdD+3xfGelsBjB0j4uTl+7pninuDTjvTnI44YDdd5HBQJiIsXbc7yAVyoqeZ4hqfYCfC42Pu/QhdrtJMgM6JGanYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GutrhelS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GutrhelS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683A81F000E9;
	Wed, 22 Jul 2026 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784759552;
	bh=Y4UyDyYrkdpFTGRWoaBdCuW6YZ57p9qBdn9SogG3Io4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GutrhelSr1fKLeVRLLZGTTeWAcehTMHr2VU2rQUAwUjMvpygKNseMwky+2zn0r6rI
	 nyK2dmRRJ0ZHpxlAJWFER2aPHlHlcX/VvlbARxCjPnXs81kU39gXgOsqoJnAmGzJ6k
	 WVfkUbYV/g5mjwmcOWitZXmkYis0x+5ZrZIEWL2U7veLfOe7XE6Wkny1U8f7bpsfgZ
	 sfYbI9oMwjTiY6ZkTmIhSSfTBgo/1dDgTlmIPOyEaz4yLawRykZ1QuYof5ZGp6qQm6
	 Z/Zk6Jam3PSnTy9rESSRo7JJoJx8ZaqIt4CcPsQLLF7EFp5yjqxXs/mcfZTwwKiBSX
	 DtHKcRBdw4cwQ==
Date: Wed, 22 Jul 2026 17:32:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v21 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Message-ID: <20260722223231.GA801609@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f6e8f0-19b7-434f-a39c-7c07df67650f@linux.ibm.com>

On Thu, Jul 16, 2026 at 11:15:33AM -0700, Farhan Ali wrote:
> 
> On 7/15/2026 4:34 PM, Bjorn Helgaas wrote:
> > > On s390 systems, which use a machine level hypervisor, PCI devices are
> > > always accessed through a form of PCI pass-through which fundamentally
> > > operates on a per PCI function granularity. This is also reflected in the
> > > s390 PCI hotplug driver which creates hotplug slots for individual PCI
> > > functions. Its reset_slot() function, which is a wrapper for
> > > zpci_hot_reset_device(), thus also resets individual functions.
> > > 
> > > Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
> > > to multifunction devices.
> > PCI_SLOT() doesn't assign pci_slot objects; I guess they're assigned
> > by some code that*uses* PCI_SLOT().  Since this says "currently," I
> > assume you're changing that code, so we should mention where it is to
> > help readers out.
> 
> Thanks for your response! I can re-word the commit message, how about
> something like this:
> 
> Currently, the pci_create_slot() assigns the same pci_slot object to
> multifunction devices.
> 
> > I see some Sashiko comments; those also need to be addressed or
> > explained away.
> 
> Regarding Sashiko's comments for this patch, it mentions 2 issues:
> 
> New issues: - [High] Unconditional enablement of `per_func_slot` on S390
> breaks standard PCI hotplug (e.g., pciehp, shpchp) slot matching and resets.
> 
> I believe this is not applicable as on s390 we don't support any other PCI
> hotplug drivers given the unique nature of zPCI architecture.

Makes sense.

> Pre-existing issues:
> - [High] Lockless access to `dev->slot` in `pci_dev_reset_slot_function` can
> lead to Use-After-Free if a hotplug driver is concurrently unbound.
> 
> Sashiko identified this as a pre-existing issue, so I don't think should be
> addressed with this patch.

Right, we don't need to fix pre-existing issues in this series, but I
meant there were Sashiko comments on other patches in this series that
look like they *should* be addressed, e.g.,

  [PATCH v21 2/4] PCI: Avoid saving config space state if inaccessible

    - [High] pci_dev_save_and_disable() skips disabling the device if
      config space is momentarily inaccessible, potentially leaving
      DMA and interrupts enabled.
    - [Low] String literal passed to a non-const `char *` pointer in
      `pci_dev_config_accessible()`.

    https://lore.kernel.org/all/20260630170754.093021F00A3A@smtp.kernel.org

  [PATCH v21 3/4] PCI: Fail FLR when config space is inaccessible

    - [High] Un-ratelimited pci_warn() in pci_dev_config_accessible()
      allows an attacker to flood the host kernel log.
    - [High] Early bailout in pcie_flr() when config space is
      inaccessible skips the Function Level Reset and the subsequent
      wait, allowing device assignment to continue without reset,
      leaking state.

    https://lore.kernel.org/all/20260630171310.F25D41F000E9@smtp.kernel.org

  [PATCH v21 4/4] PCI/MSI: Enable memory decoding before restoring MSI-X messages

    - [Medium] Blindly restoring a stale PCI_COMMAND value introduces
      a TOCTOU race window that can erase concurrent modifications to
      the register.

    https://lore.kernel.org/all/20260630171255.20BD91F000E9@smtp.kernel.org

Annoyingly, on v22, Sashiko complained about *different* things and
didn't complain about some of these even though the v22 patches are
identical to v21.  Sigh.
