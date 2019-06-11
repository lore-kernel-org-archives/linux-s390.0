Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406313AbfFKRbh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 13:31:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BHJAlJ094562
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 13:31:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2eug5u1g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 13:31:36 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <leonardo@linux.ibm.com>;
        Tue, 11 Jun 2019 18:31:35 +0100
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Tue, 11 Jun 2019 14:31:12 -0300
In-Reply-To: <7b0a7afd-2776-0d95-19c5-3e15959744eb@arm.com>
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
         <ec764ff4-f68a-fce5-ac1e-a4664e1123c7@c-s.fr>
         <97e9c9b3-89c8-d378-4730-841a900e6800@arm.com>
         <8dd6168592437378ff4a7c204e0f2962d002b44f.camel@linux.ibm.com>
         <7b0a7afd-2776-0d95-19c5-3e15959744eb@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+TvBOjv046XEorglXBMQ"
MIME-Version: 1.0
Message-Id: <bec5983d50e37953b3962a6e53fca0a243c7158b.camel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>


--=-+TvBOjv046XEorglXBMQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-11 at 10:44 +0530, Anshuman Khandual wrote:
>=20
> On 06/10/2019 08:57 PM, Leonardo Bras wrote:
> > On Mon, 2019-06-10 at 08:09 +0530, Anshuman Khandual wrote:
> > > > > +    /*
> > > > > +     * To be potentially processing a kprobe fault and to be all=
owed
> > > > > +     * to call kprobe_running(), we have to be non-preemptible.
> > > > > +     */
> > > > > +    if (kprobes_built_in() && !preemptible() && !user_mode(regs)=
) {
> > > > > +        if (kprobe_running() && kprobe_fault_handler(regs, trap)=
)
> > > >=20
> > > > don't need an 'if A if B', can do 'if A && B'
> > >=20
> > > Which will make it a very lengthy condition check.
> >=20
> > Well, is there any problem line-breaking the if condition?
> >=20
> > if (A && B && C &&
> >     D && E )
> >=20
> > Also, if it's used only to decide the return value, maybe would be fine
> > to do somethink like that:
> >=20
> > return (A && B && C &&
> >         D && E );=20
>=20
> Got it. But as Dave and Matthew had pointed out earlier, the current x86
> implementation has better readability. Hence will probably stick with it.
>=20
Sure, I agree with them. It's way more readable.

--=-+TvBOjv046XEorglXBMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAlz/5WAACgkQlQYWtz9S
ttSg4A/6A45T2BOxIm5qp+PJ+LwF0fbX0ZI762cE3X6nXDk5fJuRrjyQifBfrD0V
IVWSUrnOXqarYOmPT3CxT33rW05vGtDWObX+OI6J/QW6qU7jSOD1Db1ZUHL0W3WL
7B27RA3gNmEMugnjmM+JvtMkf5SwTdk3ZLr2IA22revoOBxOF5b8iICzA0HfaXg6
8lFSegTY8C2nNQipkeSS4d3KiObNEA1TVJUFqhwJ/VA6qYMnOpKD6WR58QCOxFaF
NIP4ln+HJccwleioGnQ+Q7jFGRD8Hb9zqLKNccpN1MfuZdE9OXcbFB5MXVuPyE/h
JVYbITwMXbIxpZe8o6/Yoc875Tz1phA2GeprZlEF3FDbw/tH0tyb6U5o+8UNpOXp
YdrNxy1oJRK6ZzhW0+FqgMJVo/BBh/8OV3r9ECwYxR3o8ELPVFAcyqrx2XEU7E6p
fBWN/cYXuZFizM0/b2yKd3kO/JIemEdz58/aPOTgJevEb996p7JohS8H8/3lm4gu
VcnlAsH9ivKDmkoFzz6JuXWJB19OSohPW8j2p9fqP5LA5snz8o+ehsewTjaVQsPJ
eNlp1HQzVumviM07wrZmXzVc0zoUb3YhWHrUL26xcfvtfDZVQ+gIOCH9baNsgcoe
U0uI1HQuuUreC4L10sgC2qrlYqbWMUmK5uj6T8fjTRaHlzP1UX8=
=i2hD
-----END PGP SIGNATURE-----

--=-+TvBOjv046XEorglXBMQ--
