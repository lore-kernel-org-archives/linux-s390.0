Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD13A7F4E;
	Tue, 23 Jun 2026 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256488; cv=none; b=J0yQ9OmKr+8KL6/g4r/1YALUmClDS7X8lk608PxSrn773IkLiXU35AxWWndSNcY38C1IwG4UB57k/EQAtpPCTW5lBXmdT50ApSeDH7ZiuFdP0cIJZWUgTQgobRQosohPFuIixQBAlS9dVEdZL11pZZIYzIRRAyepluceN8FV/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256488; c=relaxed/simple;
	bh=uEHntS13QbhORygu2usgqJbN+Jmc8SA+56gTKRvi/1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoXp/6WZMUzDZRnaZ052F4xn0urF84i0nbf3FQU3qP4n3lH05f9kBclCHw02VCr7/4kyC0Z0XW3rwpc8zAbBLbCyrLr1b4Wtpsc7lAqxXttQyfY7pZNVRr+kEaXeaRVhqlp7e8o+rvabvS5PCPPIg2pXuqwOjKasRe9bW577tfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MF4PU0q+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nh4B8HBd; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="MF4PU0q+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nh4B8HBd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CBB36EC032B;
	Tue, 23 Jun 2026 19:14:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 23 Jun 2026 19:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782256484;
	 x=1782342884; bh=/ZZ2Je6Wf74Jd9uu0Ad+g7IenG2afcZ0VBi92IuobMo=; b=
	MF4PU0q+TlcSYid2HxaoZvmllhwHt2Xzv8FR+tKO3M2VrKFK9LleBja5vjI7fGVL
	xwdhlxBfIcdgPh3yWbMqBqAXZWojmcURYD0aL5OyCCzoQm8gPq0yiMZSgUZmNr5X
	71NN8OPv/kdap3q02Aj52iL4S3smUZLwyjT0LUt5JWQhhjzsU1CMdwfAT196dPbL
	Eyex3iDFVM5YmGhC810eW+T/zhoEpeQ+Cm0wIRXlBRtIBhLc7hs2ZB/Wxr5milYU
	p3b8LPWFx9JuqEoqIYpWGNKH4RXCFKiy/cBMP9Vv0VmJ/EtpjxmDCySrxbGfOAM1
	8W+bjN8hdJ/xeYreGjQIFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782256484; x=
	1782342884; bh=/ZZ2Je6Wf74Jd9uu0Ad+g7IenG2afcZ0VBi92IuobMo=; b=N
	h4B8HBdl4deMns2uVcdTGQBpDntydbK6Raa0sTNJquyUIF4wCf2pjQczH43Au/6/
	kycVtMyZ8NR6UUr1QxmHFAD6KjCkvBwXfgqoMHezAcnbe2vp/w6FqOzwsNl3Q1PF
	0dqG96R7Ad9FyrrYsFfJaaqxdUu6xasNg2PAMIws5Uhfz4QovrEDO2ctDWJEe6B4
	yaxYX1Abs2nPqPizTQAZV3nvwylc/VcB89Wy4cLEGarSNQ/JKMYglBFVOsGnNS70
	j5jIYMekgmtni0tYwPmE1o3A1pKNVdCGr0KwExAzh0K+TnCaenvci+yl7SYhShSB
	WGCE2Aa38aUNE8w4XNcXg==
X-ME-Sender: <xms:ZBM7arC3NxEyMc4yuQBg82LCq4mmYk6jIduvPPBzC988qfuXeIgDBw>
    <xme:ZBM7anjNAzMYDQ_rkEp70J573ySdUYGXS8wizdow_L-b2-i4nn4ToYEUHaz2lPS1u
    _Dso_6IvwSF3650gWrGDjZmAd7-QUBclCMqocWXuCZ-cBEEL9kQ>
X-ME-Received: <xmr:ZBM7aha1mDHPtlparH1cYhRGIif0m5xn9nGPBpvWkje-Dz0xjkbGak3-QgU>
X-ME-Proxy-Cause: dmFkZTEJaNibHEAGILh7AHf2UTUOuG0R/5orFFI8emSi6gb4ys6YZRB4fyFFVQU+0eKMjV
    Tk6OVLNQlTFKEuzPGs5EAXRYXtDeYi9ZBNoP0H7IkSZ+YdhR+aR/9rRc6kkzxku+0MDWmx
    0wzzShNDNPk1tyb9336HcpV85//gfIPFFjqIPuHnaNga9Wl1LH6/oxNPpbZ9ufBiEzksQn
    TzQpshn1HBdv1ZDEBU1j8e64t8+MY7ojc7WIDBmZqudzBan9p3jCGaK7XI3b4bN4ebJSYt
    4n5dkbMoEh2Gyj9tGII2NgO013uqtpAsvWBgpiu5GLsblg3UnG9qAgg/yIzNgZsm9T87gU
    XsIvjgRhKDFIb7qdzdopE6JGDizkv5PgQX60pP31JZwb23/3GJtfeyMJDWI0KoYUsThGLv
    v/fvrzIKv/WkKyJaZervgHeiwhI3+IpI77eaMddDTPnW798/yN477tmNIUwqgAz1Tt13gT
    i7fH3RMZE3yA4myKUuaY5htbtuKvt8OSamh+QwJbiU6/M8JkjdGAfRpR9wYnqpS1VFTd9Z
    xXf2QMlXp8mkZGZPUpPDLr8EVe+SYHGhN4PW38HlJp1e9bHIbt0w91dLcDD2cDKEl+t3rU
    z861OXxash7iI6yBxmRuYqgQuoK9rshGaHTu21YSJEKAUB63xFhN/g5lY5+Q
X-ME-Proxy: <xmx:ZBM7agnvcBcK2rMNkAQ6NAuNlRVfEX8w6M9Mojge8ufUKATQxpg83A>
    <xmx:ZBM7avieniUwpLOFFAfgF6q5IwM8vfr1k6UKATLgFnfPY6Fk_tQQbw>
    <xmx:ZBM7aqQFdYZT_b7CwQYGwe3cQ_D3YnTlmR_QQjPPuWCAcBZyCoVjVA>
    <xmx:ZBM7aoYCY8XQsTGbew_Sa-0WrQQi3WcN3fPzyOnIG2N0XujXatZaYQ>
    <xmx:ZBM7atZIxGxk3o6yP_pUhdWiCZbZZ5fPv7QzcQBhflRbqqRGf5w0jpWk>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 19:14:43 -0400 (EDT)
Date: Tue, 23 Jun 2026 17:14:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Thomas Gleixner
 <tglx@kernel.org>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 helgaas@kernel.org, mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
Message-ID: <20260623171441.6a3f4a30@shazbot.org>
In-Reply-To: <730608ca-4a3f-4dd2-ab3e-4b83716a97d1@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
	<20260622171840.1618-5-alifm@linux.ibm.com>
	<87ik7al3of.ffs@fw13>
	<c8abc1c8-71e0-443f-820f-182c0ff931e9@linux.ibm.com>
	<087b5cafd04d2fee89f3a4a941d425e967d1ee72.camel@linux.ibm.com>
	<730608ca-4a3f-4dd2-ab3e-4b83716a97d1@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 09:36:39 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 6/23/2026 4:28 AM, Niklas Schnelle wrote:
> > On Mon, 2026-06-22 at 13:49 -0700, Farhan Ali wrote: =20
> >> On 6/22/2026 1:29 PM, Thomas Gleixner wrote: =20
> >>> On Mon, Jun 22 2026 at 10:18, Farhan Ali wrote: =20
> >>>> The current MSI-X restoration path assumes the Command register Memo=
ry bit
> >>>> is enabled when writing MSI-X messages. But its possible the last sa=
ved and
> >>>> restored state of device may not have the Memory bit enabled, even i=
f a
> >>>> device driver later enables Memory bit and MSI-X. Attempting to acce=
ss
> >>>> Memory space without Memory bit enabled can lead to Unsupported Requ=
est
> >>>> (UR) from the device. Fix this by enabling Memory bit and restore
> >>>> it afterwards.
> >>>>
> >>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >>>> ---
> >>>> =20
> > --- 8< --- =20
> >>>> @@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *de=
v)
> >>>>    	pci_intx_for_msi(dev, 0);
> >>>>    	pci_msix_clear_and_set_ctrl(dev, 0,
> >>>>    				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> >>>> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> >>>> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);=
 =20
> >>> Can we please have a comment there which explains this? Three month d=
own
> >>> the road this will results in head scratching otherwise.
> >>>
> >>> I agree with Niklas that this wants a Fixes and a Cc:stable tag.
> >>>
> >>> Other than that:
> >>>
> >>> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> >>>
> >>> Thanks,
> >>>
> >>>           tglx
> >>> =20
> >> I can add a comment, how about something like below?
> >>
> >> "The restored device state may not have Memory decoding enabled in
> >> Command register. Since the MSI-X was enabled for the device, enable
> >> Memory decoding before restoring MSI-X" =20
> > Missing "the" before "Command register" other than that this sounds
> > good to me and I agree with Thomas that a comment makes sense here.
> > =20
> >> For the Fixes tag, do you have a suggestion for a commit? This behavior
> >> has been present since=C2=A041017f0cac92 ("[PATCH] PCI: MSI(X) save/re=
store
> >> for suspend/resume" which introduced these restore functions. So should
> >> be Fixes against 41017f0cac92? =20
> > I'm not sure but my guess would be that for suspend/resume this isn't
> > an issue since the suspend part would save the state with Memory Space
> > enabled. So it wouldn't be broken in this original use-case. I think
> > the problem only occurs in case restore is done for error recovery.
> > Might it make sense to have the Fixes tag point to a2f1e22390ac
> > ("PCI/ERR: Ensure error recoverability at all times") even though that
> > only helps to expose the issue?
> >
> > Thanks,
> > Niklas =20
>=20
> Yeah, commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all=20
> times") exposes this issue. I am okay if we want Fixes tag to point to=20
> this change, unless someone objects. I will also add a note in the=20
> commit message to specify a2f1e22390ac exposes this issue.

I'm not following how we come to that limited conclusion.  vfio-pci has
long relied on the save/restore in PCI core and it doesn't seem
unreasonable that if a guest triggers a pci_reset_function() using a
method that vfio-pci traps and implements through another
pci_reset_function() in the host, that it's done with memory disabled.

It would be atypical for a guest to trigger a reset with MSI-X enabled,
but I don't see what prevents it.  I'd attribute the fix to the
introduction for better stable coverage.  This might also be pulled out
of the series as an independent fix.  Thanks,

Alex
