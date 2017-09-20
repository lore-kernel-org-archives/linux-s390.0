Return-Path: <stable-owner@vger.kernel.org>
From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] s390: Fix perf event init
Date: Wed, 20 Sep 2017 09:04:38 -0700
Message-ID: <2025443.x60lSU25Yf@np-p-burton>
In-Reply-To: <20170920121517.GE3583@osiris>
References: <20170920050757.22857-1-paul.burton@imgtec.com> <20170920085100.6adb0e0d@mschwideX1> <20170920121517.GE3583@osiris>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4731555.PSZWrRODgQ";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/stable/>
List-Post: <mailto:stable@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

--nextPart4731555.PSZWrRODgQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Heiko,

On Wednesday, 20 September 2017 05:15:17 PDT Heiko Carstens wrote:
> On Wed, Sep 20, 2017 at 08:51:00AM +0200, Martin Schwidefsky wrote:
> > Hi Paul,
> > 
> > On Tue, 19 Sep 2017 22:07:57 -0700
> > 
> > Paul Burton <paul.burton@imgtec.com> wrote:
> > > Commit c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
> > > modified cpumsf_pmu_event_init() to cast the struct perf_event cpu field
> > > to an unsigned integer before it is compared with nr_cpumask_bits. This
> > > is broken because the cpu field may be -1 for events which follow a
> > > process rather than being affine to a particular CPU. When this is the
> > > case the cast to an unsigned int results in a value equal to ULONG_MAX,
> > > which is always greater than nr_cpumask_bits so we always fail
> > > cpumsf_pmu_event_init() and return -ENODEV.
> > > 
> > > The check against nr_cpumask_bits seems nonsensical anyway, so this
> > > patch simply removes it. The cpu field is going to either be 0 or a
> 
> I assume you meant to write "...either be -1..."?

Indeed I did... and I wrote -1 in the MIPS patch which I then copied this 
from, so I'm not sure how it became 0. Oops!

> > > valid CPU number. Comparing it with nr_cpumask_bits is effectively
> > > checking that it's a valid cpu number, but it seems safe to rely on the
> > > core perf events code to ensure that's the case.
> 
> Looks like you are right and the nr_cpumask_bits check is not needed. The
> sanity check is done at the beginning of perf_event_alloc() and everything
> else can rely on a sane cpu number (-1 or within bounds of nr_cpumask_bits).
> > Thanks for the patch, there is indeed an issue with nr_cpumask_bits.
> > But we already have a slightly different fix for this queued on the
> > fixes branch of s390/linux:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=f
> > ixes&id=fc3100d64f0ae383ae8d845989103da06d62763b
> So we should either use your patch or remove the superfluous check with an
> addon patch. Martin's call ;)

Glad the patch is of use either way.

Thanks,
    Paul
--nextPart4731555.PSZWrRODgQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlnCkZYACgkQgiDZ+mk8
HGVdpA//bh6WK0QO5MUtRKdYvX9rI1hFmburRBAik1wL4D7coDDrVKHzBi6syjXU
fl/qCiizZbyrfrmDh1Tl/UaR2/BDFtgwBH+zEaa2jO7sT2b0vUmMQLG0AMUoGCy5
oW5vpBS59bf9ivGs1Z5GnGxn3wmQEyKmqu3B6dnwX0UcktVw/TCK7Kk3YhqHZzEk
9ZA8HuS5Y8DyFKUDpW5ZTk9KqvOocJf1bm1JEHRD3zKVUIzblJjjqedOTkoDxULd
i5sUOPsPb/3f2ykJCBFgH+3Ory750OX1/IcqU8vB21EldQRT5Qok7ciePyphv0Kp
/4RCf5i2qBksBy3kYva7yqI7Wl8AHpjBo8oT96CjEsscsSI2cyPLGCmPM5yI8jlJ
Rg58q+l6rqhdjHQQJl1A/pE3PPWk5YQ5f5SHnaCJ0OgGNVOaKfGucpfm3JBWn+jk
paaycKynZZ2Ku2wzO8UQW/CMnJt99DZ3GGrlpBEq63qgeRW+0uuJ2mGPhj1Lxfh6
G6DS3fV812lxKlM712LoUofLb1fD9+JJr7/djkGg8cp/gnu5jcVwwQEl0muMNL0r
EwfKF0ygvi5REasOk9xkJGd5nTBehmR2p1nb4dF7NF7aHVcTa3TdhUOu7SOzu1mw
3vcLl1m00k2TI9su9pOuy6Vf65jTyGiKtmw1rAsOh4XdKTO0ezg=
=8aTI
-----END PGP SIGNATURE-----

--nextPart4731555.PSZWrRODgQ--
