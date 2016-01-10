From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
Date: Sun, 10 Jan 2016 14:52:16 -0800
Message-ID: <1452466336.7773.46.camel@perches.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
         <1452454200-8844-4-git-send-email-mst@redhat.com>
         <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Julian Calaby <julian.calaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
> On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
> > Add virt_ barriers to list of barriers to check for
> > presence of a comment.
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -5133,7 +5133,8 @@ sub process {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}x;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $all_barriers =3D=
 qr{
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0$barriers|
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0smp_(?:$smp_barrier_stems)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0smp_(?:$smp_barrier_stems)|
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0virt_(?:$smp_barrier_stems)
>=20
> Sorry I'm late to the party here, but would it make sense to write th=
is as:
>=20
> (?:smp|virt)_(?:$smp_barrier_stems)

Yes.  Perhaps the name might be better as barrier_stems.

Also, ideally this would be longest match first or use \b
after the matches so that $all_barriers could work
successfully without a following \s*\(

my $all_barriers =3D qr{
	(?:smp|virt)_(?:barrier_stems)|
	$barriers)
}x;

or maybe add separate $smp_barriers and $virt_barriers

<shrug>  it doesn't matter much in any case
