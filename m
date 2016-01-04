Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 4 Jan 2016 22:45:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
Message-ID: <20160104224415-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-2-git-send-email-mst@redhat.com>
 <1451923660.4334.83.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1451923660.4334.83.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160104204519.dlYIB28jyS-T2T_SUIjAal_mIpHO_R-vZXshB62wM50@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, "Cc : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > SMP-only barriers were missing in checkpatch.pl
> >=20
> > Refactor code slightly to make adding more variants easier.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > =A0scripts/checkpatch.pl | 9 ++++++++-
> > =A01 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 2b3c228..0245bbe 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -5116,7 +5116,14 @@ sub process {
> > =A0			}
> > =A0		}
> > =A0# check for memory barriers without a comment.
> > -		if ($line =3D~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|sm=
p_wmb|smp_read_barrier_depends)\(/) {
> > +
> > +		my @barriers =3D ('mb', 'rmb', 'wmb', 'read_barrier_depends');
> > +		my @smp_barriers =3D ('smp_store_release', 'smp_load_acquire', 'smp_=
store_mb');
> > +
> > +		@smp_barriers =3D (@smp_barriers, map {"smp_" . $_} @barriers);
>=20
> I think using map, which so far checkpatch doesn't use,
> makes smp_barriers harder to understand and it'd be
> better to enumerate them.

Okay - I'll rewrite using foreach.

> > +		my $all_barriers =3D join('|', (@barriers, @smp_barriers));
> > +
> > +		if ($line =3D~ /\b($all_barriers)\(/) {
>=20
> It would be better to use /\b$all_barriers\s*\(/
> as there's no reason for the capture and there
> could be a space between the function and the
> open parenthesis.

That's the way it was - space before ( will trigger other
warnings. But sure, ok.

>=20
> > =A0			if (!ctx_has_comment($first_line, $linenr)) {
> > =A0				WARN("MEMORY_BARRIER",
> > =A0				=A0=A0=A0=A0=A0"memory barrier without comment\n" . $herecurr);
