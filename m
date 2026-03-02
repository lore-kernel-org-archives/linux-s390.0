Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6030AD15;
	Mon,  2 Mar 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440967; cv=none; b=PXDRtAwMUiYIHwzGG6Yif9u0Jz49cFY50+z5x+jt2+AMhqTG2z9WuLSok/9PqN9P6NCozr4Xm/J1WE2RqUdR9yoFQ5ZGYDNP697w32V4+EHNiqQO/9l5QwMtmaf3pmfJOjQGg4N6PesM0umHZ52S92c0kY8Tq5NnRPu5paJWRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440967; c=relaxed/simple;
	bh=/G/ZevRGGBg7KBKwoflwzGFQp2KlchdCPLCsl3Vk++A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MB26U9ZZtOhHsE6DAKEotJ0JzUy8uR57nBe+uaUzPMz/DLwLv3B9VxBsDovDo215XYHpBAN8pAfnjc+j01WQLu09cetkCQfjO8/m12YyYl0LNOiAbK3ZqBISE3M0Ja5FDGvu5A+PEo01iI4vflO3SZ1IeBAoYqsadWC5Ev4iDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=e2wS1ibg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ah31G6bY; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="e2wS1ibg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ah31G6bY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 018851380B26;
	Mon,  2 Mar 2026 03:42:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 03:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772440964;
	 x=1772448164; bh=/G/ZevRGGBg7KBKwoflwzGFQp2KlchdCPLCsl3Vk++A=; b=
	e2wS1ibg6RlMucGIXZl11U5siRG7DFGtm6bC+PvUNh0qFf4wfWBBXXJeTNHjGQPB
	7tkCZx/djVx6l8Ss53ZWAkChKLcYizXbkoeZuuCZl/13XFwOWZDPM4cDgVwb6keI
	To7Al8a+0zieDm3PfukQn3Qytc8yek3XV5o9zvRHIPRnBxwpeKsdwRCj55uGwY1w
	/askmm8A+N1GBD3FueEfC3XgGG+S68UYLr7HD04n6bsZuCTAkuD0pAe/WtVNk3TK
	JIwK2dPY3b4gouLDtUOu4wX4Dkuj/5xG1wx3ZUMdzV/Q3/0tYck4b35KMhYb7C2d
	W453iFmdh6RYeuvi5h5PMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772440964; x=
	1772448164; bh=/G/ZevRGGBg7KBKwoflwzGFQp2KlchdCPLCsl3Vk++A=; b=a
	h31G6bYCgDas6Z5wnLlsnt8YvsDHw2wxwEklZob0IRcCMqtrMS68u5Ho5/cp+GVA
	jDmmUOzh7wybdc0EVm9mZO0wBGwxw9pKRGZD5fUfx3vT+Mw/bKiAC113rtIo1rdB
	kZ8bRxLQx1Gm0raSyUdMRYtXrDQeQCjNsUijJBIbnNXw0FgL2xqqyXj1mjv85MlS
	veqi4GconvZYq+OZodgiE5rrmdDO4nFM2o2fgs7PmabKOpC4syv7vjt7u5qLBXnN
	S1jIA90Sq7XPHZTiLdmlTVzLAaXoptC/DndW80dX3jrMJu4bU4L/0aMiBxTv4PVm
	X4tT2TtTGQfwvhE0RaCfg==
X-ME-Sender: <xms:hE2ladcfH9f9_Zr-sx7Dx6LZlcocAKisa-XNrZxzm51PJqde9AHiSQ>
    <xme:hE2laWCMnjZhK8Hn5tEzVBiNF538-t8HL5tLyHfIW9RG7M5iu5qlgrHuI3T3VKU9c
    sFNv6h9DKAgGTVhLvxhDdjG-HFzxwamlMdS-RpvUJGbQ9Q2WKYRe60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprghnughrvggrshesghgrihhslhgvrhdrtghomhdprhgtph
    htthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprhgt
    phhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhlhgvrh
    hohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hE2laVZq5YKB6OhbVzvQCRgWqbQSVDij-E-tlHIVbOfbeUE2GupkHg>
    <xmx:hE2laVmUMMQbmghaTN41BAhN-xukVfPXA6QwQJ6adig593UAc2esOA>
    <xmx:hE2laSEBsRubi0_AhFr6ENy4rDCDrKPXHTwlR85hHXsBNVnqYAV7Xw>
    <xmx:hE2laUh08LZUdmubbMhAM0FF3Vh_ouuQqvmSHlaV_H8NF6gUP9kfdQ>
    <xmx:hE2laSYGsbiwpNRuskHVP_Okhh0P19Msa_gddsDIxAAPYywdFpDfnAsP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D7A9700065; Mon,  2 Mar 2026 03:42:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgePG58Eu4E-
Date: Mon, 02 Mar 2026 09:42:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 "David Laight" <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <204f4051-4fdd-41c8-8bcd-cab7551474ea@app.fastmail.com>
In-Reply-To: 
 <20260302-vdso-compat-checkflags-v2-3-78e55baa58ba@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
 <20260302-vdso-compat-checkflags-v2-3-78e55baa58ba@linutronix.de>
Subject: Re: [PATCH v2 3/5] s390: Add -m64 to KBUILD_CPPFLAGS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026, at 08:58, Thomas Wei=C3=9Fschuh wrote:
> Some non-code files, like linkescripts, are preprocessed with the C
> preprocessor and make use of regular kernel headers.
> As -m64 is not passed to those preprocessor invocations this leads
> to an inconsistency between __BITS_PER_LONG and the C type 'long'.
> An upcoming consistency check will be tripped by this.
>
> Make sure -m64 is also defined for those preprocessing steps.
>
> As KBUILD_CPPFLAGS is inherited by both KBUILD_AFLAGS and KBUILD_CFLAG=
S,
> drop -m64 from these variables.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
