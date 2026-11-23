Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428206;
	b=pCXxs4X75rPSYp2USdPKiLRQuNvzgKrXVpVPcUPPqYVb+sdUsdSp4I9/ra1bIQoeofke
	 OA/2dJNa60HH0NVeIyl6TxmN6aOTqVmPPYyfvU91KZ/JvOPwDQxPfA0tnKfCGWJeZSq+0
	 7+My5K8J6FYl8JfrX4Rn7bPXCXWrR5dc3FzXoUq+vv+DfIHPDEsLyUIIatcIcMZ/Tdd+N
	 JVHToIWG3IBiDK5aImXWPfIHrEZXJwhsEmRGgEQiU/HCuPSTBd2Yx1LJESIqi7xwb17ue
	 P0KYjilnHut0RXm+JW++0/3JYCBM0wYeY8V910rl0T5YprzdjmA/ZQ9MOjKjhXMqlkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428206;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=CD4ic9Gltp6sjM8mfIwiECFvv0TUSDYXBdZI3py6+Hs=;
	b=3smNCiNQcqRy6DF72m3ICcX5kI+gec/WKqLmOrPLoZfT+KvvfIbElVNFzfFMH+Tt1/00
	 q4OaSS0/fGGXKnBOX9uwAiV7O2HZqsKWeNXUftd8+HSPoe1QMyB0ZrXhJjUS0xavreQmv
	 AqTJF87cyAh7CVlKdkNrLZAstwxlKPU4mukFz2Yc0GGtcvtgM8dAw9b7J8FLgoTr3eH1/
	 cV+cc5QTiUorOEfxfEjVkgeqPyTSUIx1PgV11CMQNrdR1wrH6RNnaQL23gW+7dkLPNjZb
	 xKWSqSvd746j+h3MogSsmruhY6sIdQ9J/MsN0NxV3lfdB2xJSmubGwJYUdo4K6FclVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3VkflIru;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kAAiYpzk;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB4606A31F;
	Mon, 23 Nov 2026 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98CB4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3VkflIru;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kAAiYpzk
Date: Mon, 23 Nov 2026 11:03:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795428203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD4ic9Gltp6sjM8mfIwiECFvv0TUSDYXBdZI3py6+Hs=;
	b=3VkflIruKARozyrkLHlX2mQ95+oFUmmPQ9g7O4L3WFJ+V/4YkuEfXhftFZgsdG9N+ReUrC
	3ECXYSLczZ5sfXJmW/dp9rUJNM/FMjQfywHZgZtQzuHb0kSoe7hHEhJUgFIKC0qG05v5/W
	deQUhf+pARzVbGBEEIbo6yBX9OA7AK30MKgGM9nFf9PO5zjwkdkfGkZM9cxjaj34VKvOsw
	myOUpmdrBt4nOPgZIRTrtBBjy4he4UJ8IukvSGDbAO08UnI4M4oCeuCrk04sAimvWyNpHh
	OeIZxe3E8yO3AcaESf76ss7nR72GuxDw2HX74Yv5N4Yb5IVJ8j/g7DgcR1hCiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795428203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD4ic9Gltp6sjM8mfIwiECFvv0TUSDYXBdZI3py6+Hs=;
	b=kAAiYpzkfztPq6MYwun6e1Y8Vy2mVk9Secfye9usXniusBTfN7Fozg38iBhnOT33Y8lwOo
	+hHvYlvL/ixDdMDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH v3 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Message-ID: <20261123110111-6431e85f-39a4-427e-b545-2e7a590a6c19@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
 <ec5359c1-c16e-4177-8dfa-2ae5ab8a874f@app.fastmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec5359c1-c16e-4177-8dfa-2ae5ab8a874f@app.fastmail.com>

On Mon, Nov 23, 2026 at 10:44:40AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 23, 2026, at 10:37, Thomas Weiﬂschuh wrote:
> > There is nothing userspace can do with this value. In the kernel is
> > always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> > userspace and also changes from time to time.
> >
> > Move the symbol to kernel-internal headers.
> >
> > Meant to be applied through the asm-generic or execve tree.
> > The default recipient list was huge. I trimmed it to only the
> > architecture lists.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Hi Thomas,
> 
> I'm happy to take this through the asm-generic tree. I've already
> made sure it all applies and the patches look good to me. I'd
> wait a few more days for additional Ack or any other replies,
> let me know once you think I should apply this version.

This v3 is functionally identical to v1 and v2 which have been on the
list of a long time. I am not sure how much more feedback will come.
IMO it can already be applied to gain more exposure in -next.


Thomas
