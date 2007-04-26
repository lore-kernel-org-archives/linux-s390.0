Return-Path: <linux-kernel-owner+w=401wt.eu-S1031505AbXDZUfM@vger.kernel.org>
Date: Thu, 26 Apr 2007 13:36:56 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-Id: <20070426133656.ab02d68a.randy.dunlap@oracle.com>
In-Reply-To: <20070426013059.ce948f50.akpm@linux-foundation.org>
References: <20070423141123.GA21174@skybase>
	<20070425143011.57247c1d.akpm@linux-foundation.org>
	<20070425172447.1576c399.akpm@linux-foundation.org>
	<200704260232.06909.arnd@arndb.de>
	<20070426013059.ce948f50.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Apr 2007 01:30:59 -0700 Andrew Morton wrote:

> On Thu, 26 Apr 2007 02:32:06 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> > On Thursday 26 April 2007, Andrew Morton wrote:
> > > It would be neat if someone could create and maintain a new
> > > scripts/spot-common-mistakes. =A0Feed it a unified diff and it would =
complain
> > > about newly-added code (and only newly-added code) which has busted
> > > whitespace, adds new semaphores, adds new kernel_thread calls, etc, e=
tc.
> >=20
> > http://patchstylecheck.googlecode.com/svn/trunk/patchstylecheckemail.pl
> > Might serve as a starting point for this. It doesn't have any semantic
> > checks right now, but I guess they can be added.
>=20
> oh man, every patch I review, every bug I fix, I dream of this.

singing?


> Wishlist:
>=20
> - wire it up to a robot which monitors all Linux mailing lists and sends
>   machine-review comments back to originators.  This will be a huge win by
>   eliminating so much stupid crap. =20
>=20
> - auto-detect wordwrapped and tab-replaced emails (oh glory)
>=20
> - auto-detect code wider than 80-cols (swoon)
>=20
> - auto-detect missing Signed-off-by:
>=20
> - auto-check patch format and protocol, as per
>   http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and
>   http://linux.yyz.us/patch-format.html
>=20
> - teach it about semantics:
>=20
>   - kthread instead of kernel_thread
>=20
>   - mutexes instead of semaphores
>=20
>   - the whole plethora of whitespace uckfuppednesses
>=20
>   - needlessly-initialised-to-zero-static-variables
>=20
>   - extern-decls-in-C
>=20
>   - EXPORT_SYMBOL(foo) is placed immediately after foo()'s closing
>     brace
>=20
>     Hard to do?  Could just whine about all EXPORT_SYMBOL's which
>     aren't immediately preceded by ^}$ or by ;$
>=20
>   - new typedefs
>=20
>   - use of uint32_t and friends
>=20
>   - use of BUG_ON and BUG, frankly.  The thing's a damn pest.  Suggest
>     WARN_ON+recover-from-it.
>=20
>   - use of `if ((var =3D expr()))' and similar
>=20
>   - large inlined functions?
>=20
>   - braces around single statements (advanced topic ;))
>=20
>   - StudlyCaps?
>=20
>   - anything called "tmp" or "temp"
>=20
>   - old-style struct initialisers
>=20
>   - non-ascii characters(?)
>=20
>   - lots more to come, I'm sure.

I made a short list last night, but yours is better/longer.
Here are a few more items:

- check for new docs and/or kernel-doc
- storage class should be first
- don't use deprecated APIs
- no floating point
- no MIN/MAX
- printk wants KERN_* levels
- limit on new /proc files


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
