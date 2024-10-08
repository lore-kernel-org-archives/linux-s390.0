Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B51DE8A9;
	Tue,  8 Oct 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390597; cv=none; b=uVcALpihlwzYty4mYzdBZFYDlgi4vDuFsDrilUuSTrZo/qKjaz5J3HQQ45UAFkd4FoQlMZ7VjfS8mC7KT4JaIDtA4gRCZSUZwtoqeD1QYZN3CCS8tqNeAgP2caOzQsl7Ck3LaplsXKgtd3E8DZRcdiu2xM8fRq6RnF/y7/+aHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390597; c=relaxed/simple;
	bh=SwiKyk1qXPVibzNAdevq0KXsDs6bwkBWLmS/QmHNEeU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jwITej01oADPRZRloTNjPbc+gtqTwqt00aUIMi/aZv2NBuVH7UgmHNc7lpoRHNHAK1TFvj7bCC/Ya8ebFvRHFX8ydmQ8qlIWWdma71LDsZ1f5FwXnOVVer5R2Lq5mpAvLgjnDdK8agDLM30xSZHCUL+otlK1+MxZ1r+TkPUISWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fF+G7/sZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gm/tz02j; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fF+G7/sZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gm/tz02j"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAF4F1140242;
	Tue,  8 Oct 2024 08:29:53 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 08:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728390593;
	 x=1728476993; bh=UAD8NfSy5gmGeQl+E5iRkYF97RER4uEtGdtfvJHOxzw=; b=
	fF+G7/sZcZVBkjEtE3YDHju+SzZwr5W7qDi+1uy5ibQTo6Q/22u+lpmTERwpLpS/
	gM26A4LNudYtQO8fgP62a8EeudRT8I3GsjmfB4mJlx9877F9dVd8rzWfZ2l24fAC
	ISKBrRYmor8mtczIhF2xZ+dIpd98BKiPv+CS06ZtVMyUHLCdbqCBj+xdoTNBJyEF
	IxnYrtLFwa+VoPjqYTlQBUGgbXcppFkeq9b3lh//q9mTkMz3MMZKIE36i2WdNPJ+
	o9d//8MIo8PlZyBnzBM3U/ik64vPhXzmUic9mUe35+jsqbDMt5JV/5zqUFV1lHis
	KmJICWCSpGPizCYQ7ayN6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728390593; x=
	1728476993; bh=UAD8NfSy5gmGeQl+E5iRkYF97RER4uEtGdtfvJHOxzw=; b=g
	m/tz02joYJumjvkLzGwR9YDJV/kNuhChrInezhJLft8ruV/rp0jL0BSfVG9LIO9K
	UVwjDSnnNW1fP0lKW5SaNvPG+GNo943eZScGuRvgeTK2BTAXXEAEunZbELT+jO+k
	IJa/tL77Y5wqjkOELQToA2gY1447zJCUA/mnyoFOFdOhRYaHd35ie3JOaqRNjGG4
	3FuKRMcees2ti/q2rqrR2wgr0XGhaIerML2HXNFtYpqcMwWHCI7q4KBJOExki2wa
	Bq0I5ZymdsQnG9hpwbbed19kelGcdesJZknuuHVKfEf02/HkH1+v51cmyE36sIgy
	LukEjFjiGQYdp0Hz/VwAA==
X-ME-Sender: <xms:wCUFZ5W9KUAZHxz092rDJfAFDgciQGITdEh60sb3s0AjfK_rKE-Gdg>
    <xme:wCUFZ5myaxX1fsEJUll3ERo9TTHcFwkRpJnTJo7HVNVnSaCqeyq9l2otZ5c2ygbYN
    sUEW6JYPRnvLVCu9xE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqshefledtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhhsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgv
X-ME-Proxy: <xmx:wCUFZ1bZvCs7KfTBPM6DUJ3PVG0smdFNNiUbk3DjtNzrKYHLH5K9Fw>
    <xmx:wCUFZ8U5136AoThXc7VWd0g7CrnPBb5Ak-1OdDTkBhc-GJ7Zhkl30w>
    <xmx:wCUFZzlbarMfk_Iho0-WG5OL2VvvoMVKFW-lW08VKL4C8SE1qBzHCg>
    <xmx:wCUFZ5epsPnGQWmBgGbsiAV2bAo5MGKgMPLmtHvPs__hmbSH4NPBag>
    <xmx:wSUFZxgLlhp1BigvFG0qp-yQrfn6_NA4pwA4aMNAo029wW2gb0rRKNJY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4FC22220071; Tue,  8 Oct 2024 08:29:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 12:29:32 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Julian Vetter" <jvetter@kalrayinc.com>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-sound@vger.kernel.org, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <b54a6f76-fcfd-40bd-b478-ca0a7e1af128@app.fastmail.com>
In-Reply-To: <ZwUbsviaqFUtjKEQ@infradead.org>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
 <20241008075023.3052370-2-jvetter@kalrayinc.com>
 <ZwUbsviaqFUtjKEQ@infradead.org>
Subject: Re: [PATCH v8 01/14] Consolidate IO memcpy/memset into iomap_copy.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2024, at 11:46, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 09:50:09AM +0200, Julian Vetter wrote:
>>  lib/iomap_copy.c         | 127 +++++++++++++++++++++++++++++++++++++++
>
> On top of the previous comments:  this really should be iomem_copy.c
> instead.

Right, I suggested adding it to the existing file since the
functions are logically related, but the naming of that file
identifiers in it is unfortunate:

__iowrite32_copy/__iowrite64_copy/__ioread32_copy sound like
they are meant to work on both IORESOURCE_MEM and IORESOURCE_IO
mappings the same way that iowrite64/ioread64/ioread32 do,
but actually using them on x86 port I/O (from pci_iomap or
ioport_map) would lead to a NULL pointer dereference.

      Arnd
