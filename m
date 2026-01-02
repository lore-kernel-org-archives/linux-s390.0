Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D976311C11
	for <linux-s390@vger.kernel.org>; Fri,  2 Jan 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767361185; cv=none; b=W8xqT6UEsZrKzpOXNhMLQ0J9Suwd1BLZGE+b3YEf4TLm32jIURj/yLj8hJZWB/yzLiif0Cg2Hju1UcyTP6STzJZ+ZTjYMu+fIa3pE5nSPAI7mX37Ol9R/z/gDgupxywNc4UTdEfcLRavNgbNnNv8IqLsXcMcSdz9gZ/lT4VU+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767361185; c=relaxed/simple;
	bh=SVGIiSWIzg80Bqq7LCYYlALqbBWZ2ofIsrcdUHfyZPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVcUBCphy+ar1hxyZ4ickBuGSUlYSM6d1T3b4GYCW0X3xYdYq1n72daC0jWvHUqnjyh0r55mB1LcpZ5LCexlZUt9jme8JyIWHVqCNJxHkTOo6Dt5jE9I7W0RcilHZ1/Fp9lj14ND36rRcKZG6cWMUoy74wXxjrkdmQ0CHl0FSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bW2ENvpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bW2ENvpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403D3C19424
	for <linux-s390@vger.kernel.org>; Fri,  2 Jan 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bW2ENvpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1767361177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVGIiSWIzg80Bqq7LCYYlALqbBWZ2ofIsrcdUHfyZPU=;
	b=bW2ENvpWXyyENTYao9a8vpF6KdMw2iFyt3fMDnWm28sEiGCG1ZAVfj8QBckNS1URBdKuSy
	qMkKWGSU/R3XJnRP9oKK+a6PfgA0khTJvm4Y4kYpV+AgAW4PmlGOVPDAd3T5sq+1zoMJ/V
	G5EA9eYLmQnrQH/pUXdhhleeLIDRB8c=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79c768c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-s390@vger.kernel.org>;
	Fri, 2 Jan 2026 13:39:37 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ce0ef9d4eeso1073403a34.1
        for <linux-s390@vger.kernel.org>; Fri, 02 Jan 2026 05:39:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHIRqlFvhiwOwk4xEfSVPnFu3KpNJ9Tkr1bjsIaSOoQZdMIe8+1JvfN5ax9NfNeaoxhozABS7L1Rg6@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkVQ7JzTud/V7GET+cVzG03csru9jOwUB0pUEZEpHMr0Gq9+E
	IsIpiiL+USH0oYz6TfUEV0VHtm3xLoym9N6+Y8lbGGFPwMLFme4O2nN9fnkBHioBp4jdXCh7f7Z
	+bXqIVLyPmSqwEXMjGCldEiS2brF3jHc=
X-Google-Smtp-Source: AGHT+IFV0P4UwOKgGcidVSe3+C3GT9JSRutBmyTJY+Ko+TYwuWXifwQH5m/QQSPv0qrqCY9iwE1wKuoYX25E7txH4AI=
X-Received: by 2002:a05:6830:4c08:b0:7c7:65f4:1120 with SMTP id
 46e09a7af769-7cc66a6f068mr24618037a34.23.1767361173696; Fri, 02 Jan 2026
 05:39:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102131156.3265118-1-ryan.roberts@arm.com> <20260102131156.3265118-3-ryan.roberts@arm.com>
In-Reply-To: <20260102131156.3265118-3-ryan.roberts@arm.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 2 Jan 2026 14:39:21 +0100
X-Gmail-Original-Message-ID: <CAHmME9qHiVZwf4TAringRHSZ-yqHuPwmP=Wnx98n09jv7Vu_Rg@mail.gmail.com>
X-Gm-Features: AQt7F2qdo3e8gMqv9IRozONnOouAGf6XyGKVO6JwEtjeNVfJ3A-5G4I57eyZbDw
Message-ID: <CAHmME9qHiVZwf4TAringRHSZ-yqHuPwmP=Wnx98n09jv7Vu_Rg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] prandom: Convert prandom_u32_state() to __always_inline
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Fri, Jan 2, 2026 at 2:12=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
> context. Given the function is just a handful of operations and doesn't

How many? What's this looking like in terms of assembly? It'd also be
nice to have some brief analysis of other call sites to have
confirmation this isn't blowing up other users.

> +static __always_inline u32 prandom_u32_state(struct rnd_state *state)

Why not just normal `inline`? Is gcc disagreeing with the inlinability
of this function?

Jason
