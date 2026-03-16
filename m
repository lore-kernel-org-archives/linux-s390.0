Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CD313E18;
	Mon, 16 Mar 2026 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687792; cv=none; b=kr0bXA7MktM2n3GyfL6exgrR4h1AqHru5IhduBsgMLi079y5OIjR44NCNR/gJZ6EKZrdVU8arLyAX+6eXyZjVGMS0TP3ORsxy8XD0sNxNGpaRNBFuqglCVCj136/XCag141jFtpLD7zLwVdgzsTXdpZHemgntlWIeZY8eCWDQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687792; c=relaxed/simple;
	bh=Y5L2O3gaAYLD++EnGaGa2SB5rZnpdid6BByayaIW3Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7fxbmj/c+o+Aps2yLD80IpeKELF+wKrMF2twZ4/6LJjHfXAw3KafKjB7CivkVmUXP7H2Q4Q31tW4XYI/7iNj1irIQhbXNrNkXTPY5lQOBbT9dnVlinQQI/rQ0hUmXD8XJ9yjFOs/DX1IjxgSyqsM523sqIOrfdjvbA3TY97lt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=sBr5wcSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sUaVGN3X; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="sBr5wcSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sUaVGN3X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A16AEC0C71;
	Mon, 16 Mar 2026 15:03:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 15:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773687789;
	 x=1773774189; bh=xiEvY9YU9lk+iPWwoh4e728FSPYzQAU8z7zjAlUJVEs=; b=
	sBr5wcSpCqGqPmnTc13cqTVTX+f7lvmDtKmD9w/oiA2O3NYRumfVVtsF1fd7d/ew
	C7V+YMJJbtKCd4+OQliJhl8SWjQAhXVjaCCiUs5yqWALW0c5OiMs6oevrF+d9SpP
	02ELiIt/ZaY+wrmdmHLDOj15LFWBw/DyV26DcWf4XF54zP9zwlxvWlev6JIVzhF5
	ZVSr9cisd2Tc+eWMt8flCuU/cU+clx+uBEK1+9zBhPeWMo661Es0SJdQGhM0MRFn
	Ce11Q97gW/zouDr+G8qWAaJHRcKJrEtb9g5Y1LuWGVw51I7pOCASHV4EZ3WpNkBN
	ULzy9ZX7MOtaTEwV7HebLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773687789; x=
	1773774189; bh=xiEvY9YU9lk+iPWwoh4e728FSPYzQAU8z7zjAlUJVEs=; b=s
	UaVGN3XK1CCEDHDM6Vjj9cOzKe8wyuQgarQ7g2qjbOh5SNhTURmlwXxNxZaicLWZ
	aw2Qt1KACd3cyKzXsW3sE9LijrfNOsXH83SUbFH8UizXvsr4WcguCJXxc1f0Wk9e
	IflrRN54ARjxzfWwLtwfBztY8GMRS8x8OTvsPD4ZGY1J1oVL7EDrhrPnk6L3P1d3
	rHe47wL/yt5D6SaX/TFFlk1oeYNgtRiErwH402o6WV37TWaX6Ea1M4IqjN6V6V78
	1u+/mUp/egjdK0nUyGFSjhxbuEb7hA+g7pshHxXmVfz6S+hC9xuVWJShaqHfVA9+
	BpEx5gX3PvOuWSL8+wNjA==
X-ME-Sender: <xms:7FO4aSNhQB0dReqM0noeN_UFKu1zpMregpno-W3jkQ4JQgxxY1jirg>
    <xme:7FO4aTsaPVppVi3_fEgwJXpihDfbe4K7nuGEFvXAyvmsn-hI_1__Dk619DP0--hDC
    bCrA7TGPEAqcWNWiAhh5vx_ySD30kftyX4DIsbyF-CE7KUk-23Z8A>
X-ME-Received: <xmr:7FO4aWLIVT0a8eC0ITq5HJnZPxHOz7yCvs8iPxwBiwUKL0pzPDqw3Z5P9OI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjuhhlihgrnhhrsehlihhnuhigrdhisghmrdgtoh
    hmpdhrtghpthhtohepshgthhhnvghllhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghp
    thhtohepfihinhhtvghrrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehtsh
    eslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehosggvrhhprghrsehlihhnuhig
    rdhisghmrdgtohhmpdhrtghpthhtohepghgsrgihvghrsehlihhnuhigrdhisghmrdgtoh
    hmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohephihishhhrghi
    hhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvh
    hiughirgdrtghomh
X-ME-Proxy: <xmx:7FO4aaMO5eKI7ZLlXe9QfqfpVFJuKTKnPwU2fA7L37EagCovL16Rog>
    <xmx:7FO4aSCjYJgraQd0Iy-HtookuZnxMlowvI4h8zVMBp4t0LpQTr4dng>
    <xmx:7FO4aaWRoNlnGkrhB7aYVTZGlztFCQeiH99Ap-lMfIbDxDrBXg3qVA>
    <xmx:7FO4aWfANmdVtinJRNLj2eZDOFDtmkHNnmsxcf3bZr6VnIvKteOUdA>
    <xmx:7VO4aYxT4gRPCCB4mVJbRbT7proU_Idjy8R2KfJ2j3Zb0hZCectGIeP1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 15:03:07 -0400 (EDT)
Date: Mon, 16 Mar 2026 13:03:05 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Julian Ruess" <julianr@linux.ibm.com>
Cc: <schnelle@linux.ibm.com>, <wintera@linux.ibm.com>, <ts@linux.ibm.com>,
 <oberpar@linux.ibm.com>, <gbayer@linux.ibm.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Yishai Hadas" <yishaih@nvidia.com>, "Shameer Kolothum"
 <skolothumtho@nvidia.com>, "Kevin Tian" <kevin.tian@intel.com>,
 <mjrosato@linux.ibm.com>, <alifm@linux.ibm.com>, <raspl@linux.ibm.com>,
 <hca@linux.ibm.com>, <agordeev@linux.ibm.com>, <gor@linux.ibm.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v4 0/3] vfio/pci: Introduce vfio_pci driver for ISM
 devices
Message-ID: <20260316130305.21e015ef@shazbot.org>
In-Reply-To: <DH47JTI4L8PJ.2A4XCC5SRV0NW@linux.ibm.com>
References: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
	<20260313094127.74aa0767@shazbot.org>
	<DH47JTI4L8PJ.2A4XCC5SRV0NW@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Mar 2026 13:33:04 +0100
"Julian Ruess" <julianr@linux.ibm.com> wrote:

> On Fri Mar 13, 2026 at 4:41 PM CET, Alex Williamson wrote:
> > On Fri, 13 Mar 2026 15:40:27 +0100
> > Julian Ruess <julianr@linux.ibm.com> wrote:
> > =20
> >> Hi all,
> >>=20
> >> This series adds a vfio_pci variant driver for the s390-specific
> >> Internal Shared Memory (ISM) devices used for inter-VM communication
> >> including SMC-D.
> >>=20
> >> This is a prerequisite for an in-development open-source user space
> >> driver stack that will allow to use ISM devices to provide remote
> >> console and block device functionality. This stack will be part of
> >> s390-tools.
> >>=20
> >> This driver would also allow QEMU to mediate access to an ISM device,
> >> enabling a form of PCI pass-through even for guests whose hardware
> >> cannot directly execute PCI accesses, such as nested guests.
> >>=20
> >> On s390, kernel primitives such as ioread() and iowrite() are switched
> >> over from function handle based PCI load/stores instructions to PCI
> >> memory-I/O (MIO) loads/stores when these are available and not
> >> explicitly disabled. Since these instructions cannot be used with ISM
> >> devices, ensure that classic function handle-based PCI instructions are
> >> used instead.
> >>=20
> >> The driver is still required even when MIO instructions are disabled, =
as
> >> the ISM device relies on the PCI store=E2=80=91block (PCISTB) instruct=
ion to
> >> perform write operations.
> >>=20
> >> Thank you,
> >> Julian
> >>=20
> >> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> >> ---
> >> Changes in v4:
> >> - Fix bug with < 8 byte reads. For code simplicity, only support 8 byt=
e reads. =20
> >
> > Does the ISM device define sub-8-byte accesses as valid?  It looks like
> > if pread() doesn't return the desired size QEMU will fill the return
> > with -1.  Unless such accesses are classified as undefined by ISM,
> > doesn't that suggest a potential data corruption issue to the guest
> > driver?  Thanks,
> >
> > Alex =20
>=20
> Hi Alex,
>=20
> thanks for the quick feedback!
>=20
> We are currently developing this extension for a non=E2=80=91QEMU vfio us=
er space
> driver. Reads smaller than 8 bytes are theoretically valid, but they are =
not
> used by this driver nor the existing in-kernel driver at the moment. We c=
ould
> extend this in the future if needed.
>=20
> vfio=E2=80=91pci based PCI pass-through of the ISM device is already poss=
ible without
> this extension. In that case, the ISM driver in the guest kernel accesses=
 the
> BARs directly through hardware virtualization, without using the new acce=
ss
> routines provided by this variant driver.

Hi Julian,

The cover letter argues a secondary use case with QEMU, especially in a
nested environment.  The ISM range appears to be an interface to a
variety of device types, console and block are noted.  It's also noted
in the implementation that the z/Architecture allows sub-8-byte access.

I think we need to be cautious that the existence of this driver makes
it available for use with QEMU and other VMMs.  In the case of QEMU
vfio_region_ops will allow single-byte access by default.

The restricted access width is positioned as a simplification here, but
it needs to be evaluated against all the use cases.  Unless we're 100%
sure none of those use cases rely on sub-8-byte accesses, we might be
setting ourselves up for hacks later to fix or detect partial access
support.

I'll leave it to IBM folks to determine if this is indeed a
simplification for long term support of all use cases and not a short
term fix for the short term use case.  Thanks,

Alex
