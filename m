Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528994;
	b=QYUo76sFRBofh/i0JOTn9xXs3ZrvrVm7jY+7+qVAAhOH82fyYEQg/+0/+IzRFEqqcVqd
	 kOChWObGyv+ldjzibmd2ZEzInd5y1xjtItParIK9SKGNcTiT5VMyxwoWr5LzYG0qFsjI5
	 t7ypCpMZG5q+j0YosolM1qtwRorycX97KzXISAMTYNlKFa3WB4TAhROizkPm3cgKbz2Sy
	 Sr4dVaQP48KNaEcE1iixPjKr8Md/xAk/ZyQ8DHWMjiLHv9I+Z1oXNJc+K/c4NHB/FKCZN
	 yFg1hIuErtjt77Vn5lyioOKAvfps8TUJHIQB+C6uhe8ml1//RBMfkTQ0j4NGMKCSM5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528994;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=JVwSuPPW9LnMTHGbyC/LWwKgzpeuxTVxDYf7431PF50=;
	b=QhhSQ7vgadIcGOwgOzSDE8ZnMSXWTc7ybuoTL6HaOBwO47OpcjCC83W6DiOFYRArBx0j
	 XkyeejO2CmHWGkBCVCnF7pj5b6nihO0G9rI3KpbLTML7CiqlEP14A4dSqVpPtbBrIHwgJ
	 B2HL52NumqVE5dG7z4jYocfPybor/S2QnYqu/NrD6lzlkP2gepxTGzfREV8jcQ+vS86z3
	 06Lrtxh1ZKtjJdL7uHZ1xgflgkQ6U/3VRY/RJZXdyMc6NF+KKJ2am+bEHb0xTgtYym0PG
	 wyv3jjmk4JxNWBnc5JcFfOoxRb3Uo8hqzmZdoY6WRaYLf7GPlAnYDUzTwmtJ7amm5Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TsFM2UqX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="xAU2/Slp";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2F606A697;
	Tue, 24 Nov 2026 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB2F606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TsFM2UqX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xAU2/Slp
Date: Tue, 24 Nov 2026 15:03:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795528991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVwSuPPW9LnMTHGbyC/LWwKgzpeuxTVxDYf7431PF50=;
	b=TsFM2UqXj5b+V3/3KG4PfYS0lJNbWBi4ZtJFudmyjLsy5pNIYarTh0tMz5+qpiSEDIi1xS
	HyrxXGzCQXJampyFbYOhVPHNR0EzLY86FTeFG6FZD0w4bIGAwEvr4CnvR2tBqmvfdP0Jqj
	ABrv9AM+Zl1RRFdb2qAqPrxpTtptABWGfulBb7/sSoDC3yo156pcTW9t6JksZHLYhIImiO
	FE7G5/5+goHgIN5sgm+L5r/zBFNwItCrE75jN4VU2ZTDRzJkY4OIKz1kICZEQgNgvFoNQg
	lCD+QeV82ITKpmTIMtDIReW4yGPGAIAylgjo7X3eIFqpkmxR300nw4Cyd2ZCcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795528991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVwSuPPW9LnMTHGbyC/LWwKgzpeuxTVxDYf7431PF50=;
	b=xAU2/SlpVCQkMOYGKKQKfVe4HuUQTiCOuOagdD2hmbXtwhmh0KbeBZnsCI/iY1oyjBa7XN
	Is50/oIaDKTJS6Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: sashiko-reviews@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	linux-mm@kvack.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 03/15] asm-generic: add an in-kernel auxvec.h header
Message-ID: <20261124145907-12f830e3-70ab-4e58-a330-2fa974be1a25@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
 <20261123-at-vector-size-arch-v3-3-d342dae9e843@linutronix.de>
 <sashiko-outbox-230870@kernel.org>
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
In-Reply-To: <sashiko-outbox-230870@kernel.org>

On Tue, Nov 24, 2026 at 09:49:24AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] asm-generic: auxvec.h unconditionally redefines
>   AT_VECTOR_SIZE_ARCH to 0

This is indeed an issue. Not sure, how I missed this, especially as I thought
to have sent this through 0day.

@Arnd: Could you drop the patches?

I'll prepare a fixed version, probably for the next cycle.


Thomas

> --
> 
> commit 0c922d7a496b0d1a5af6ec9787042de6d54ad285
> Author: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> asm-generic: add an in-kernel auxvec.h header
> 
> This commit adds an asm-generic/auxvec.h fallback header as mandatory-y
> and includes uapi/asm/auxvec.h and asm/auxvec.h from linux/auxvec.h.
> 
> > diff --git a/include/asm-generic/auxvec.h b/include/asm-generic/auxvec.h
> > new file mode 100644
> > index 0000000000000..b5f73f35e21ce
> > --- /dev/null
> > +++ b/include/asm-generic/auxvec.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_GENERIC_AUXVEC_H__
> > +#define __ASM_GENERIC_AUXVEC_H__
> > +
> > +#define AT_VECTOR_SIZE_ARCH 0
> > +
> > +#endif /* __ASM_GENERIC_AUXVEC_H__ */
> > diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
> > index 4b364e639f080..de1c33c4a2560 100644
> > --- a/include/linux/auxvec.h
> > +++ b/include/linux/auxvec.h
> > @@ -2,7 +2,9 @@
> >  #ifndef _LINUX_AUXVEC_H
> >  #define _LINUX_AUXVEC_H
> >  
> > +#include <uapi/asm/auxvec.h>
> >  #include <uapi/linux/auxvec.h>
> > +#include <asm/auxvec.h>
> >  
> >  #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
> >    /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
> 
> [Severity: High]
> Does defining AT_VECTOR_SIZE_ARCH unconditionally in asm-generic/auxvec.h
> redefine and clobber AT_VECTOR_SIZE_ARCH on architectures that still
> define it in uapi/asm/auxvec.h?
> 
> For any architecture that does not yet provide its own asm/auxvec.h
> (such as x86, arm64, riscv, powerpc, s390, mips, loongarch, sparc, sh,
> and alpha at this point in the series), mandatory-y generates an
> asm/auxvec.h wrapper around asm-generic/auxvec.h.  When linux/auxvec.h
> includes uapi/asm/auxvec.h followed by asm/auxvec.h, AT_VECTOR_SIZE_ARCH
> is redefined to 0, breaking the build under CONFIG_WERROR=y and shrinking
> AT_VECTOR_SIZE and mm->saved_auxv[] when built with CONFIG_WERROR=n
> (which causes create_elf_tables() to write past the end of
> mm->saved_auxv).
> 
> Later patches in the series migrate those architectures out of
> uapi/asm/auxvec.h one by one, leaving intermediate commits broken for
> bisection.  Since linux/auxvec.h already provides an #ifndef
> AT_VECTOR_SIZE_ARCH fallback to 0, could asm-generic/auxvec.h omit the
> AT_VECTOR_SIZE_ARCH definition or guard it with #ifndef
> AT_VECTOR_SIZE_ARCH?
> 
> -- 
> Sashiko AI review ∑ https://sashiko.dev/#/patchset/20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de?part=3
