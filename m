Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81537AA91;
	Tue, 17 Feb 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362878; cv=none; b=pj3Yi+4xaVZh98mafMwVz1+m4MoHphT6nOIVpZF6TxmU56SHQkPmH2nRyFAUTdYdCHc1TtjKEpkmrQME8NA/qMLppZOqz9MpHWkCB+qpdLft5RMwEduk9Ep3f0xhCpOIOZIDJlJMYMT+AL1SkPL0tEBE+TDajaqP1fKihS+NymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362878; c=relaxed/simple;
	bh=mEnkSbLM6LxEqpz0tbpk9ZCXl/UGZw64QBDzsnMu/yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r66hLZojRHRYGHnEI/B58wAXYbbcf+cH2m2VcZjPXHhLg+z0+F/aaa0CkQy+dVVxEGafDgcf8aBM/vk88bOcetWweWeX+gUf8f9Cm2vDf9vbdJ1WIG1FieAdJUnSMDtBpSwZ2+l5mk2ce0Aaz6mVlpZWfUMGwG9LOO5QTwlr2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQctjnY1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQctjnY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB96DC4CEF7;
	Tue, 17 Feb 2026 21:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771362878;
	bh=mEnkSbLM6LxEqpz0tbpk9ZCXl/UGZw64QBDzsnMu/yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQctjnY1gY/bn1L6TYutbm67IcNMDkvjaJjn3RnYaGbUjQO99pYV0khA2xAPQqy8d
	 54afIvVarjwwD+FINFuFzYpI9fbxX0hMJqY7FbV7n3Z3eAOMrFKTY8XXC4c/nYTU2R
	 JbP/C1PSsocp70CdcIon7MwjJh5eliHvh2E4Prb4gTwsvXJ7BUhnC3Geja2e0zEjTH
	 aJkMOyPNcr+u/Ym/JPNypuwYM+qNK+Cy+JOsxDz8+TK6YLoT+PeoMpTeA2ph9kGngp
	 TemeWyplUVSDP5PXDYElawltWv/BW8NTx3UA23YUlNhy5rqeuAPhtAUYaE5psMVBsg
	 oEH6LFAeTQnEA==
Date: Tue, 17 Feb 2026 14:14:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
	alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v9 1/9] PCI: Allow per function PCI slots
Message-ID: <aZTaPH85j5R81Vna@kbusch-mbp>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
 <20260217182257.1582-2-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217182257.1582-2-alifm@linux.ibm.com>

On Tue, Feb 17, 2026 at 10:22:49AM -0800, Farhan Ali wrote:
> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
> to multifunction devices. This approach worked fine on s390 systems that
> only exposed virtual functions as individual PCI domains to the operating
> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> s390 supports exposing the topology of multifunction PCI devices by
> grouping them in a shared PCI domain. When attempting to reset a function
> through the hotplug driver, the shared slot assignment causes the wrong
> function to be reset instead of the intended one. It also leaks memory as
> we do create a pci_slot object for the function, but don't correctly free
> it in pci_slot_release().

I think leakage is because s390 is passing in devfn when pci_create_slot
is expecting devnr, so things are not getting matched and assigned as
expected.

If you're able to make this change, it will clash with one existing
thing, and another proposal I've got at v5 now(*). Specifically, this
would allow all 8 bits to be used for the pci_slot 'number' when it's
currently expected to be limited to 5 bits. 0xff is special, and I'm
proposing another special value. If we are going to allow the slot
numbers to use all 8 bits, I think we need to change the type from u8 to
u16 so that there is space to encode such special values.

 * https://lore.kernel.org/linux-pci/20260217160836.2709885-3-kbusch@meta.com/
