Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E113EB10C;
	Thu,  1 Oct 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851702; cv=none; b=I/IoqP40qbUTKFu1sD6Zguce3tf5t16+9pdUZq0u6TkCgYW4StkIBQ+m/utLpqZMXmkK8HaCvZ601kaQfW13kOzPaooQUTDyxo7zaDwULlSsbDcum5CcsviGmc1Fn8HlP91TTrCIZD/r/R7vHoumhcUv4JDE8O9bWlWsOziRFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851702; c=relaxed/simple;
	bh=Nk60LiUU20mXr1zbUVNQcc4+c0dxMgDULcPnYRde7Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu/jHhEuBJrwjFEMZ9VGDqX1v7L14TVy0ODrwgOQU7aWJujiIMrPJDefNR1ILuJygHK6x0c68OYf4gqlCHcuL7ETWT8GeFS879VYIhpkHCXiU4sMuA6fKlsFUdPrY/TpMr/YeyML3qy0D83Z9ACdOaQth1VQmhfjlpjrMvZSiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=B57mDsY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B57mDsY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6031F000FF;
	Thu,  1 Oct 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=B57mDsY4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790851695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/oOpPY/gsh1NivZHQbt/4ewXmUw4hi2f8c5A+91XjAQ=;
	b=B57mDsY4+jopKLImXZNVOWxdVpQrgNONXSBu75IrKyl7123Al4mEDaeWWuv661fwT5QFtp
	DyBe8f04ARHZI529RupFjeyvDFHWlpXWFuVEmNR4jf9UiXLsJ+Xu0/uwQUzKXb1sdqw5Bu
	rwXQT6Por1A+lDJO9XzMggVf/BrbZ0A=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 03abc62d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 10:48:15 +0000 (UTC)
Date: Thu, 1 Oct 2026 12:48:10 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <ar46ap4jzLWyP92C@zx2c4.com>
References: <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001102059.GA4176271@ax162>

On Thu, Oct 01, 2026 at 12:20:59PM +0200, Nathan Chancellor wrote:
> control. The change that introduced -max-store-memset only did it to
> "allow fine-tuning of the inlining threshold for performance analysis
> and optimization". If they decide to remove it for whatever reason,
> we're back to square one.

I suppose all the more reason to get -finline-stringops=memset added to
clang. Then the dual-default thing you came up with below will naturally
start choosing the first option when it becomes available.

> I know something like below would be uglier due to the ifdef but it
> would avoid changing anything for GCC while clearing up the issue at
> hand for clang in a guaranteed stable and succinct manner.

But then we're back to the byte-by-byte codegen that Christophe pointed
out.
 
> If that is not acceptable, something like the following does appear to
> work for me.

Okay, great, let's do that.

Does this commit seem okay with you? I used the diff you sent below and
adjusted the commit message: https://git.zx2c4.com/linux-rng/commit/?id=56ff95ee85715047eb5b5220243778af657778c8

Jason
