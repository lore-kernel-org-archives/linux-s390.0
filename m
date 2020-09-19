Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 19 Sep 2020 11:06:58 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 13/14] PM: mm: cleanup swsusp_swap_check
Message-ID: <20200919090658.GB12294@duo.ucw.cz>
References: <20200917165720.3285256-1-hch@lst.de>
 <20200917165720.3285256-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20200917165720.3285256-14-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-ide@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-09-17 18:57:19, Christoph Hellwig wrote:
> Use blkdev_get_by_dev instead of bdget + blkdev_get.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2XKMgAKCRAw5/Bqldv6
8jnIAJ9gnRBuWwSimm3SXF7hOAxcdZjhvgCfSC/nzlC9BvYn3OzlsY0Fu9KJK58=
=7alK
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
