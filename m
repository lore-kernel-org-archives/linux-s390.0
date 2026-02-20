Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC69309EFC;
	Fri, 20 Feb 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620796; cv=none; b=qMPMp/42VHFbdqL+H3aLzlVOVPQVGGARIQcrE8ZIPDi1qFWVQtdy5YAy6A6p/d0SskZr38Ii5a61Hkoxqqj62ca3TJG5cJiaUqMGaQ3Hxj7BdJeNb0IAk3jTE7bgfgCP7NEFns/VLEtttHtlMYZ1PPAadXqiMr7BOXso2ZO0VV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620796; c=relaxed/simple;
	bh=wvPZ+iAZm0GaEH+FUhgCt1TsGu2hBXjc9GP/9tT7qZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnXBYodK9h6zpKzjQ5EbNj2cMZ9sa+T4TgonULP2nlrUxCWUwoRJKZDyljvKTrpeimITeHBfVQ5RwiKI7ndIrMIA9AbOKzqO+3XlQMzZLZTtceyUdaEeLN112MPcELCDXN3D07wa5aaAS1Bc1Yqnea7RitwpxawyF5iUOm4AbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Yu/+eoeN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGzfpmTn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Yu/+eoeN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGzfpmTn"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 15293EC05A5;
	Fri, 20 Feb 2026 15:53:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Feb 2026 15:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771620792;
	 x=1771707192; bh=D9VGSeggv5pbXKRZhKSaAquvTwtnNjiZ0IjcroFhx90=; b=
	Yu/+eoeN3KHq3XOCG6vANYO7WgqR6V6wbP5JTAnymrYMQSGbOBGtQu/ZFfdMS8NY
	CeDErX91mg51KXANmVtzuJ3e33yYC8I8OFCQrwIxsQCgikd5Dq8Bpzm4mLm5WUjF
	8nlLD3KNOFDFUAgUX6N0pSyNQhOQbhJwAbMMythR2WNDwJj5buaXjnZ9p36wNfk3
	sBfiSc3NZUrur1WfYnCvGzHLvSPIB7Yrf3lJqey1ynsWxHDT+x+66/cJ6DsiL24t
	DOQ+YYcHDz1T2axBkdiLgq1J6sOwmkeAqDG07z9GhrsipF4aw6f3nkqs49k21/zH
	KgBjlhow8MgCFyNalwY5VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771620792; x=
	1771707192; bh=D9VGSeggv5pbXKRZhKSaAquvTwtnNjiZ0IjcroFhx90=; b=C
	GzfpmTnvcFLr7cbCxnDGZMtReQ7v1VNOBFojknS0p7E4QHg7JbgcTfzb/hVKV55m
	Q7z29FvctnpWFzyjuP1/rmiA3LkxU4RgyiS9YjqAKQ8tNMK+s8wQPyhQE0hig2PQ
	CZ8RoWiXdKHR5ZgLweOkTVoA6VDEBKpCGht/XKQ+Zei99goq99T0Z/zuDgzHoxjD
	pIvOI4ZVUyPYAA20twRtVzOQTjafZ4T/wioN+JN8i5ZFASj8JJe5KNOUlpHkhx8K
	G8jyB/CbXDZqvCnBIbgfGg/YlehKaQVBuOjuSxK4hIqTdgqpCb1YZANml53tQimY
	4DNFbD1Zl+UqVsAwISXfA==
X-ME-Sender: <xms:t8mYaaYl882_KgUMUPCceDYTR8_LeMvjuOVTtL7mdYlCFgV3UpO5xQ>
    <xme:t8mYadi8HRBgwUPeV92bKUyIPLtlV-CobZ7Ehjo12RZx-2o56NTuNIqvnTq21r-Q8
    FOpf75mvb5YULKbTx8eVh6tfMEa5Mhg5XeiDt4KCo1lB6V3T1ecrQ>
X-ME-Received: <xmr:t8mYacaMqILaMPhnTmt5Kmt5jLA1wEpusgdgn0LNP0aS5ALXT-JNgZo8lrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hlihhfmheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheptghlghesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:t8mYaTN0jDcRPdW5IcUxnqWblm_mDv5i2fZyRmYyZHrHoylB1Et_vA>
    <xmx:t8mYadZvnkttPZT0I6OyWPhobqpD7U9mMTnjoNFSQJPEjxik_Gxwaw>
    <xmx:t8mYaTXnYsx7XSF7b0mCcRBAUTva9wfnzRiPSx40r9mct62hs1m9EA>
    <xmx:t8mYacCCXDBslqBgwjS5EpXvqNNvZsbaFKD76RZiLgEHBarNsFJ5FQ>
    <xmx:uMmYaXjCDZf-j-BOV6qgBe3YvRI25Sy9hztBI4-25pKxjlQE4gIITBUS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 15:53:10 -0500 (EST)
Date: Fri, 20 Feb 2026 13:53:09 -0700
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lukas@wunner.de, clg@redhat.com,
 stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
 Bjorn Helgaas <bhelgaas@google.com>, alex@shazbot.org
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset
 path
Message-ID: <20260220135309.0014e308@shazbot.org>
In-Reply-To: <f6ef9900-ae3a-4580-a89d-f497fb4e5adf@linux.ibm.com>
References: <20260219002010.GA3445930@bhelgaas>
	<f6ef9900-ae3a-4580-a89d-f497fb4e5adf@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Feb 2026 10:06:05 -0800
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 2/18/2026 4:20 PM, Bjorn Helgaas wrote:
> > On Wed, Feb 18, 2026 at 01:48:57PM -0800, Farhan Ali wrote:  
> >> On 2/18/2026 11:35 AM, Bjorn Helgaas wrote:  
> >>> On Wed, Feb 18, 2026 at 12:02:01PM -0700, Keith Busch wrote:  
> >>>> On Tue, Feb 17, 2026 at 11:55:43AM -0800, Farhan Ali wrote:  
> >>>>> Yes I think you are right, with this change the PCI Command
> >>>>> register gets restored to state at enumeration. So we will
> >>>>> lose the updated state after pci_clear_master() and
> >>>>> pci_enable_device(). I think we can update the vfio driver to
> >>>>> call pci_save_state() after pci_enable_device()?  
> >>>> Either that, or move the pci_enable_device() call to after the
> >>>> function reset.  
> >>> I kind of like the latter idea because it seems a little simpler
> >>> for the rule of thumb to be that a reset done by the PCI core
> >>> returns the device to the same state as when the driver first
> >>> probed the device.  Drivers would generally not use
> >>> pci_save_state() at all, and they could share some initialization
> >>> logic between probe and post-reset recovery.  
> >> I think the vfio-pci driver was intentionally doing the
> >> pci_enable_device() before doing the reset. As per commit
> >> 9a92c5091a42 ("vfio-pci: Enable device before attempting reset") it
> >> was done to handle devices using PM reset, that were getting
> >> incorrectly identified not supporting PM reset due to current state
> >> of the device not being D0. It looks like pci_pm_reset() still
> >> returns -EINVAL if current power state is not D0. So I think we
> >> can't move pci_enable_device() after reset. Unless we want to update
> >> pci_pm_reset() to not use cached value of current_state and read it
> >> directly from register?  
> > Devices are generally disabled at .probe() time, so that will be the
> > default saved state.  But every driver will expect the device to be
> > enabled after the reset.  Skipping the save state at reset time seems
> > like it would need a lot of work first and maybe it wouldn't ever be
> > practical.  It wasn't really thought out; I was just hoping we could
> > simplify the save-state model and maybe unify driver reset and error
> > recovery paths.  I think we need to drop this patch at least for now.  
> 
> Yeah, I agree this patch might be too disruptive for drivers. In that 
> case would my previous version [1] to at least prevent saving state in 
> case of an error be acceptable? Or is there another approach we should 
> consider?
> 
> [1] https://lore.kernel.org/all/20260122194437.1903-4-alifm@linux.ibm.com/
> 
> >
> > 9a92c5091a42 ("vfio-pci: Enable device before attempting reset") was
> > mostly done to make pci_pm_reset() work, which requires the device to
> > be in D0.  The main purpose of pci_enable_device() is to make device
> > BARs accessible; it *does* also put the device in D0 because BARs are
> > only accessible in D0, but pci_pm_reset() itself doesn't need the
> > BARs.
> >
> > Other reset methods, e.g., FLR, don't seem to require the device to be
> > in D0, so I'm not sure why pci_pm_reset() requires that.  I think the
> > critical piece is the D3->D0 transition, and maybe we could arrange
> > for that to happen even if the device is already in D1/D2/D3hot or
> > even D3cold.  
> 
> Looking at the PCI spec (v6.1) I didn't see any requirement for the 
> device to be in D0 state to perform a power state change. So I think we 
> should be able to transition from D1/D2/D3hot to D0. But IIUC if a 
> device is in D3cold, then won't register reads/writes fail till power is 
> available to the device?

Yes, config space could be inaccessible in D3cold.  IIRC, 9a92c5091a42
was specifically addressing that devices are typically provided to the
driver in the PCI_UNKNOWN state and at the time vfio-pci wasn't
changing that in the .probe function, like most drivers would, so we
needed to adjust the ordering of enabling the device versus calling
reset function.

Now that we've gained PM management in vfio-pci, that's no longer an
issue, but pci_pm_reset() does still require the device to arrive in
D0.  Accepting devices arriving in D3cold or D3hot (with NoSoftReset-)
might avoid a power state bounce in some circumstances, but would not
have solved the original 9a92c5091a42 scenario where the device was in
PCI_UNKNOWN power state.

Sorry I missed my opportunity to reply to the suggestion for this
approach in the previous revision.  I'm not sure if anything
specifically breaks with this approach to restore the initial device
state, but it's certainly not the contract I currently expect as a
user of the reset-function interfaces.  I think that contract is
"reset the internal state of the device while saving and restoring
current config space".  If we stray from that, what's the expectation
for things like resizable BARs?  I don't think we want to reprovision
resources as a result of reset.

Here we seem to be worried about a specific, testable scenario where
config space might be inaccessible after error and applying the
workaround to that regardless whether that specific scenario is preset.
I don't see that a "test if config space is accessible and stuff the
original save state into the buffer rather than creating an invalid
save state" should be so complex as to require this simplification and
associated risk.  Thanks,

Alex
