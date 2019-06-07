Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:46453 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfFGMEV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Jun 2019 08:04:21 -0400
Date: Fri, 7 Jun 2019 22:03:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
Message-ID: <20190607220326.1e21fc9c@canb.auug.org.au>
In-Reply-To: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/f4dkIceQ5ZrfVlbLmfAkblH"; protocol="application/pgp-signature"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrey Konovalov <andreyknvl@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>

--Sig_/f4dkIceQ5ZrfVlbLmfAkblH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

On Fri,  7 Jun 2019 16:04:15 +0530 Anshuman Khandual <anshuman.khandual@arm=
.com> wrote:
>
> +static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
> +					      unsigned int trap)
> +{
> +	int ret =3D 0;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed
> +	 * to call kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
> +			ret =3D 1;
> +	}
> +	return ret;
> +}

Since this is now declared as "bool" (thanks for that), you should make
"ret" be bool and use true and false;

--=20
Cheers,
Stephen Rothwell

--Sig_/f4dkIceQ5ZrfVlbLmfAkblH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz6Uo4ACgkQAVBC80lX
0GwAlwgAndGNjcRg/+OZtSy1kiUIeIc3sDi7Ok5AjcBz7eTGTC6rACK7/CqF74Ff
Hw76yMUeoSjtJWLlhqmY0XI4ib30yQJSvSSWJyDvZpmgkDbNO69BK4rT4CO/d2YX
sCodILuUU462hNmmfr9N6uWJGSeDWdEvbfitkR2PEzQAUSsQacEA8UB+bqf+zQ13
xwBTJEE0YFg5UCqOcsE3bSTh/e+p7djYHrQIiZX0ntJOra+nJZuz/GfJQUmx4WYn
AHgcP+Marnv0/MW4JDWYDtetq+Fmr96wk01Ex4gMytm7TcpL0asnQ0IEVwljvVr/
HFKp+ZJLlwZP8lyt90zY76EEDgViPQ==
=7Lk0
-----END PGP SIGNATURE-----

--Sig_/f4dkIceQ5ZrfVlbLmfAkblH--
