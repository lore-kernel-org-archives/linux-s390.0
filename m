Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D9383C71;
	Mon,  2 Mar 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480928; cv=none; b=NmqiB6MBZSQBDlApGfgBAHn59Dxawn97WJU/kVDl+Ss6yKVhdAukmc45yNzch9SlvzpJDbpwSjcEad8mtlTJvSKFz4BtBi7rHH0qimnEWgwNBl9oEEiVbFcfCJkUiKs/utc1zQuKYv/wAKTwCFNkCf4y3WYNj8dbLgSkUYRgqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480928; c=relaxed/simple;
	bh=smDOz3UPrxLygeawtBaJ9Hgh/CY9ryDMRmV2CGI8W+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNoWW+7CkjaCrUDW6YRgn8/G3JWajzSyEKTK6NajVJx6lqwO3WmMGPNe8IKm+kg1EOuQVy+X7yYdJbvTZUvxFWCg4sVzzkop+paIOpJRoWrSnDpIi7MhNZZAo+V1tix0qePd31HBfwoo62rrN0yjzasCQq+wQ37B9iW+jPvFbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkUtxMps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkUtxMps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC29C19423;
	Mon,  2 Mar 2026 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772480927;
	bh=smDOz3UPrxLygeawtBaJ9Hgh/CY9ryDMRmV2CGI8W+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkUtxMps/seGrND9XN30i6HZlFQNPnNAfpzkXqiq6MC54HmEbX2D9lP6rsmIuD/BM
	 Az5BWvjqW4y7x4ITGPl1gP8+hfFE9kZfRhLwDvnwSaRvNbJfP+mq+oKX8drImYzLcq
	 bPvUE98/d9izBOWrStARAXHnAkVIC2iZ1xlkX2PUByaLfoAe7FZioy8vgvSuJjrpZH
	 GmW8JAIyRm5Q16X+PnbenR415eHdiHChioL79PElok3w4FcjP7QHj4uBxFb6XvQYnL
	 M4dGWyPl1JUrkJ5cgWzWTr5hj52A7QuWHNb3oQT55Xjl877XClVN/BYnVcybW22Sdf
	 tIbmSnxol2ZkA==
Date: Mon, 2 Mar 2026 21:48:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Ramesh Errabolu <ramesh@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for PCI
 slots
Message-ID: <20260302194844.GU12611@unreal>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
 <20260226083427.GF12611@unreal>
 <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
 <20260226183945.GL12611@unreal>
 <5d30ad0a-9c16-4802-adfe-e795c38f5990@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d30ad0a-9c16-4802-adfe-e795c38f5990@linux.ibm.com>

On Fri, Feb 27, 2026 at 12:23:03PM +0100, Peter Oberparleiter wrote:
> On 2/26/2026 7:39 PM, Leon Romanovsky wrote:
> > On Thu, Feb 26, 2026 at 11:53:32AM -0600, Ramesh Errabolu wrote:
> >> On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
> >>> On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
> >>>> Add a new write-only 'uevent' attribute to PCI slot sysfs
> >>>> entries. This provides a mechanism for userspace to explicitly
> >>>> synthesize PCI slot uevents when needed.
> >>>>
> >>>> For cold-plugged PCI devices, slots may be created before
> >>>> udev is ready to receive events, causing the initial 'add'
> >>>> uevents to be missed. As a result, slot specific udev
> >>>> rules that define naming, permissions, and related policies,
> >>>> are not applied at boot. Allowing userspace to resynthesize
> >>>> the 'add' uevent ensures these rules are processed correctly.
> >>> This patch sounds like a hack to me. AFAIK, "udevadm trigger"
> >>> performs exactly that.
> >>>
> >>> Thanks
> >>
> >> AFAIK, PCI slots do not yet raise a uevent. 
> 
> That is only partially true. PCI slots are represented in sysfs by a
> kobject (pci_slot.kobj) and pci_hotplug_core generates uevents for these
> kobjects during pci_hp_add() [1].
> 
> Here is an example for these uevents:
> 
> KERNEL[62021.190266] add      /bus/pci/slots/000018d0 (slots)
> ACTION=add
> DEVPATH=/bus/pci/slots/000018d0
> SUBSYSTEM=slots
> SEQNUM=1638
> 
> KERNEL[62032.304390] remove   /bus/pci/slots/000018d0 (slots)
> ACTION=remove
> DEVPATH=/bus/pci/slots/000018d0
> SUBSYSTEM=slots
> SEQNUM=1682
> 
> On s390 there is a use case for reacting to these events via udev rules,
> namely to persistently apply a user-specified, per-slot power state.

But the component that issues the uevent should create this file.
In your example, it is the hotplug code that must provide a writable
file, isn't it?

Thanks
