Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <1451945750.4334.111.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
From: Joe Perches <joe@perches.com>
Date: Mon, 04 Jan 2016 14:15:50 -0800
In-Reply-To: <20160104224415-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
	 <1451907395-15978-2-git-send-email-mst@redhat.com>
	 <1451923660.4334.83.camel@perches.com>
	 <20160104224415-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160104221550.Iw8xGakMan1lHB6Sl1B9WRXh1xBbNe7ov6_uNMb8yk4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Cc : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2016-01-04 at 22:45 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > SMP-only barriers were missing in checkpatch.pl
> > >=20
> > > Refactor code slightly to make adding more variants easier.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > =A0scripts/checkpatch.pl | 9 ++++++++-
> > > =A01 file changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 2b3c228..0245bbe 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -5116,7 +5116,14 @@ sub process {
> > > =A0			}
> > > =A0		}
> > > =A0# check for memory barriers without a comment.
> > > -		if ($line =3D~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|=
smp_wmb|smp_read_barrier_depends)\(/) {
> > > +
> > > +		my @barriers =3D ('mb', 'rmb', 'wmb', 'read_barrier_depends');
> > > +		my @smp_barriers =3D ('smp_store_release', 'smp_load_acquire', 'sm=
p_store_mb');
> > > +
> > > +		@smp_barriers =3D (@smp_barriers, map {"smp_" . $_} @barriers);
> >=20
> > I think using map, which so far checkpatch doesn't use,
> > makes smp_barriers harder to understand and it'd be
> > better to enumerate them.
>=20
> Okay - I'll rewrite using foreach.
>=20

I think using the qr form (like 'our $Attribute' and
a bunch of others) is the general style that should
be used for checkpatch.
