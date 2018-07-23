Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <1532348776.26425.7.camel@surriel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From: Rik van Riel <riel@surriel.com>
Date: Mon, 23 Jul 2018 08:26:16 -0400
In-Reply-To: <20180720083016.GN2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-1-riel@surriel.com>
         <20180716190337.26133-5-riel@surriel.com>
         <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
         <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
         <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
         <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
         <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
         <CALCETrXLMsSBChDvrms-omwYV4LHT30GenDjbnD-+LTg55yPow@mail.gmail.com>
         <20180720083016.GN2494@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4vkrqBG7jdk4C2JsdnAu"
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180723122616.rqzrh7eUm9YbDdG_oybRXH2Iiert2QkKMKCqqP-WfE8@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-s390@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Mike Galbraith <efault@gmx.de>, kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>
List-ID: <linux-s390.vger.kernel.org>


--=-4vkrqBG7jdk4C2JsdnAu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-07-20 at 10:30 +0200, Peter Zijlstra wrote:
> On Thu, Jul 19, 2018 at 10:04:09AM -0700, Andy Lutomirski wrote:
> > I added some more arch maintainers.  The idea here is that, on x86
> > at
> > least, task->active_mm and all its refcounting is pure
> > overhead.  When
> > a process exits, __mmput() gets called, but the core kernel has a
> > longstanding "optimization" in which other tasks (kernel threads
> > and
> > idle tasks) may have ->active_mm pointing at this mm.  This is
> > nasty,
> > complicated, and hurts performance on large systems, since it
> > requires
> > extra atomic operations whenever a CPU switches between real users
> > threads and idle/kernel threads.
> >=20
> > It's also almost completely worthless on x86 at least, since
> > __mmput()
> > frees pagetables, and that operation *already* forces a remote TLB
> > flush, so we might as well zap all the active_mm references at the
> > same time.
>=20
> So I disagree that active_mm is complicated (the code is less than
> ideal
> but that is actually fixable). And aside from the process exit case,
> it
> does avoid CR3 writes when switching between user and kernel threads
> (which can be far more often than exit if you have longer running
> tasks).
>=20
> Now agreed, recent x86 work has made that less important.
>=20
> And I of course also agree that not doing those refcount atomics is
> better.

It might be cleaner to keep the ->active_mm pointer
in place for now (at least in the first patch), even=20
on architectures where we end up dropping the refcounting.

That way the code is more similar everywhere, and
we just get rid of the expensive instructions.

Let me try coding this up...

--=20
All Rights Reversed.
--=-4vkrqBG7jdk4C2JsdnAu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltVyWkACgkQznnekoTE
3oNp5ggAhb/ScHMhsqjYPCfu5/gdUlsB46K5xr9f8ZxmVN0LNF0x4n0AROsADMQw
LLsM+EagLWYMdXjKeI5xCsMu2nwcm9aAqdONRkyjGbgIbupzjHNNMqRNa4NxB+dZ
t9mMgAbnGv+2HLxbIsb6zhb1ckdHkaLipv8llItk8orYkdb5WWtnvdQC6UHBr+0e
5eJuQiarWkHorhoqlXCh3Zc1ZinxSTlOFzmVAf+Vw0n0qjMcq1pPelsA9ynJPJM+
9NwXsdodm38ppTpXIPKAQb4NF73JgxtqaUZuPQmiasaUo3czZq67uQZin6v7iC+H
g2oK4ygHmep6StVwfzfx/FtsnTsqbg==
=BJ7M
-----END PGP SIGNATURE-----

--=-4vkrqBG7jdk4C2JsdnAu--
