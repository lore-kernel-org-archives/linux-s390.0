Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9A3A962D;
	Fri, 13 Mar 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416496; cv=none; b=NWL29dO+GRcDZoWdmNVfYUTZots76OFjNzy8nO2+r7NSxpa9qfYFmm3RuQRPoqTV37m+LWUw91ChUwdwJpe4co5R+tVwrPohDX4nn2nn+2kx+QoTIOSgDMarwPuU7jqvU2kI3pV4iPvHJo6UpkF3ZcMufLpUKPZK/2fIgBMYWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416496; c=relaxed/simple;
	bh=BhJpLRvTrRnHI360Y3G/8aswiGHh9HpiQX2cB4S8o9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKovZEx+2T7K4DZpEKR7iA+XLvd1wuV650Xrr8Def0g2tIWX0R7Zh035dzWDNRCxSYhVy2hyjcIh8Xg8VtRWRUCK5jnAP5eNPUyrd5V8Xegdq+i7r3PnBEsdxrMoAv8P5HqMlUJoiK7nWwYXjJSV+Nc1LpQRneaPM9vGWlXa9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=CLgutLG4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R9FBcQNs; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="CLgutLG4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R9FBcQNs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6196B1D001CC;
	Fri, 13 Mar 2026 11:41:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 11:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773416492;
	 x=1773502892; bh=kgj526aKwZrzrcQEKfOTYeHG2iUgfK1oZFrmdyv2yl0=; b=
	CLgutLG4ntcLyFOAbBQ1AWQisumepy/Mvyl4h6KkyQgjUNg4q2L2aNSZ5iWp4F3M
	/xz/dVV41l4kZcBIwqKaalvZ+BrFJBZcpWOua5Ri2zNXGisX1+6eBg/VF2fUIZZU
	fIO8Bn0WIBHa82ccA7iXRB01E09TGLp+U0SNYRSa96Sdfoy16cGn5oM72iSZ73PO
	dyPqJncSHyxxfoKtJfWvL0PRjEmc49f5uHYN0gz38tVguveWrw0vSyz51oRSQhiV
	KqmYTuwHqZPH7jLkouEQeRO6zPINA8ci4jAhwiZYQP9CyTRb71rDMTcdicomPsds
	HMES9jhoBDRb/4d7/+3h6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773416492; x=
	1773502892; bh=kgj526aKwZrzrcQEKfOTYeHG2iUgfK1oZFrmdyv2yl0=; b=R
	9FBcQNsKEocG/Osc/VTMTI+gftCa+DWHzey6JCB5AHjQAHxqa0VnzXD0WFQpk0PL
	fvvfUwN0T/i4nZfnfst9prEtfmxBdyIm2X5FV3rI9Ty6uTn3fKab3R19jpmIDsrS
	/azQ4vm3NfCKs/E6Qhz02xss6cOWixE2gIV9t/MD5OwcpmlR1kfxCkbOqM7KDW16
	1aIWazdrKok8ilYrnE3RjVj1CE+HQZPQHY/HpBXjiZz4Cz/mQ5vjt5dbp9Sd4DXv
	3ru0OfIXBdDoifYRSpVVyhlxOpwbvC/9sE3zDucE0YRCjicSWJUmVvFYRXNwo5LK
	IGqB1n/21/3vuZC5jef2A==
X-ME-Sender: <xms:KzC0adLdWLZrY32WZWLIH5jHdyTODgig88I69GhC3ed5x3ncWgldDQ>
    <xme:KzC0aVRNW21Z2zpp2CcLR1Szn1x8VyXz-abkReePqUu5zbgYfieNlR-BSpAViAqr2
    si_i-epWQCtaaDofQ43tmEEv1gblkWq59NPdTk28havlRfb-gPVpAs>
X-ME-Received: <xmr:KzC0aRixE-EvSDPlmwhfJZOYSWsy5JcU8tf8uOB3e2FynXr-GPlQx406_WE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:KzC0aXuS-iukiHn-AxQw_9X-DZUaOAwcuTybc9gRRRtGVX7qOSyi7Q>
    <xmx:KzC0aUiRrYkZNKkz4yatMt1gJXTsNvkCgjX2iRx2bf82GU-wE8dapg>
    <xmx:KzC0aWGBPEfNuwc3Z_Gn0AJVBLb2y0KoxH37GL68yyqWHCCQRIjawQ>
    <xmx:KzC0aVKZ2BjEzTdI4-GQzMalOpRMTT-NKq0QEowIDDiIs_b9SpFmug>
    <xmx:LDC0aaWflAQVC9FrhtiTHu9vVclibp9shvsS-2SdoGbvwPREorOuODBM>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 11:41:29 -0400 (EDT)
Date: Fri, 13 Mar 2026 09:41:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: Julian Ruess <julianr@linux.ibm.com>
Cc: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
 oberpar@linux.ibm.com, gbayer@linux.ibm.com, Jason Gunthorpe
 <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
 hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v4 0/3] vfio/pci: Introduce vfio_pci driver for ISM
 devices
Message-ID: <20260313094127.74aa0767@shazbot.org>
In-Reply-To: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
References: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Mar 2026 15:40:27 +0100
Julian Ruess <julianr@linux.ibm.com> wrote:

> Hi all,
>=20
> This series adds a vfio_pci variant driver for the s390-specific
> Internal Shared Memory (ISM) devices used for inter-VM communication
> including SMC-D.
>=20
> This is a prerequisite for an in-development open-source user space
> driver stack that will allow to use ISM devices to provide remote
> console and block device functionality. This stack will be part of
> s390-tools.
>=20
> This driver would also allow QEMU to mediate access to an ISM device,
> enabling a form of PCI pass-through even for guests whose hardware
> cannot directly execute PCI accesses, such as nested guests.
>=20
> On s390, kernel primitives such as ioread() and iowrite() are switched
> over from function handle based PCI load/stores instructions to PCI
> memory-I/O (MIO) loads/stores when these are available and not
> explicitly disabled. Since these instructions cannot be used with ISM
> devices, ensure that classic function handle-based PCI instructions are
> used instead.
>=20
> The driver is still required even when MIO instructions are disabled, as
> the ISM device relies on the PCI store=E2=80=91block (PCISTB) instruction=
 to
> perform write operations.
>=20
> Thank you,
> Julian
>=20
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---
> Changes in v4:
> - Fix bug with < 8 byte reads. For code simplicity, only support 8 byte r=
eads.

Does the ISM device define sub-8-byte accesses as valid?  It looks like
if pread() doesn't return the desired size QEMU will fill the return
with -1.  Unless such accesses are classified as undefined by ISM,
doesn't that suggest a potential data corruption issue to the guest
driver?  Thanks,

Alex
