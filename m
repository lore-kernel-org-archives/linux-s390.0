Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgIJRfC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:02 -0400
Date: Thu, 10 Sep 2020 18:34:14 +0100
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
Message-ID: <20200910173414.GD4898@sirena.org.uk>
References: <20200819124913.37261-1-broonie@kernel.org>
 <20200819124913.37261-4-broonie@kernel.org>
 <alpine.LSU.2.21.2009021128500.23200@pobox.suse.cz>
 <20200902184935.GA5875@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <20200902184935.GA5875@C02TD0UTHF1T.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2020 at 07:50:27PM +0100, Mark Rutland wrote:
> On Wed, Sep 02, 2020 at 11:32:13AM +0200, Miroslav Benes wrote:

> > > -		start_backtrace(&frame,
> > > -				(unsigned long)__builtin_frame_address(0),
> > > -				(unsigned long)__save_stack_trace);

> Oh whoops; I'm annoyed I didn't spot that.

> With that gone this cannot work for (task == current && regs == NULL), as
> we'll erroneously use stale values from the task struct.

I remember somehow convincing myself at the time I originally did this
that doing the above was redundant with the new interface but that was
quite some time ago and I can't reconstruct my reasoning any more, I'm
pretty sure I was just mistaken.  I've added it back in, thanks for
spotting this.

> It looks like the LKDTM tests only trigger cases with non-NULL regs, but
> IIUC this should show up with show_stack(NULL, NULL, KERN_INFO), as
> drivers/tty/sysrq.c does for other cpus.

show_stack() doesn't go through this bit of the stacktrace code, it goes
through dump_backtrace() in traps.c which used the underlying arch
specific unwinder directly so is unaffected by arch_stack_walk().
Actually now I look at LKDTM it's ending up using show_stack() mostly
if not entirely so my testing with it was not exercising this change
as much as might be expected anyway (the modified code was getting hit
by other things like /proc/N/stack).

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9aY5YACgkQJNaLcl1U
h9AoNgf/bxtql5YMDWhCmeDMNhMAagB2dVCtaee/UDna+zUsH1N44ptx9JFeXcW/
f9sDitnklB+I+tyAlXTeej76l/ohXZL6jkVGL1SYOQZZDgGw+bUkf9KsZLYjrtK/
TY4aybyOzZdHrwtImEb9GlLPZ65UWrzsUdDgnWOmWy0sBgsoa2g0YwkrM5EhbS/5
WHttMds5ootnjvB6znsKHoLOvi84gnIEAZf1F+gYDshZFdpeDVK7Zk4E7t+ZRpeE
wE1kUJd2UKJhZsyaqE2ewXL+0N9wIJgQ1F17aOqcRfHcWBrsyzyZzJSib6ygUfax
pWT5j9mXTEP/L6TiDwy/FIsH1+X2ZA==
=Vsd/
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
