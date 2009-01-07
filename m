From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 07 Jan 2009 16:21:29 +0000
Subject: Re: oops on shutdown with 2.6.27.10
Message-Id: <200901071121.29780.vapier@gentoo.org>
In-Reply-To: <1231333822.5456.33.camel@localhost.localdomain>
References: <1231333822.5456.33.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--nextPart1514234.BI38pWaJmg"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--nextPart1514234.BI38pWaJmg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 07 January 2009 08:10:22 Jan Glauber wrote:
> I guess your kernel has CONFIG_DEBUG_FS disabled?

yes

> Can you try if the following patch resolves the oops?

it does, thanks!
-mike

--nextPart1514234.BI38pWaJmg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJZNaJAAoJEEFjO5/oN/WBRlEQAJjzbGunD0NDKRu/BIvdj4In
3VBvXWvWMj3kbBrkSTTERNHplxcMRcndr5SmBoV/7wO0OxpXRPjOBN3SCqDz8WTG
8lnmvxB8rLS0+fV0YV+tqP0ktyy6Ev5DnNce5p3Q2FpXo6Y1Mc6hQEIZYBKd2lz0
iKqzj1jvT3qXFJPokzji5ukWL8sbTgXbuh2cuTmYQCcPRd5wYxxlLSE6Wy5NuOij
o6h1P+81eF/zcTCLmv0X7WMkfoMI2VBV7CMLr8nGdTu6+0CRAy+pr1ezi82rUle7
06JYxflC2lECIv0v8qx+hpAbOTXhwgMpSRnxN+tdsMZRtZPTbRhtvmF2rMi5hh2m
6gllkge0z9vYOrTQueV6BgkTsx7jhG1K2EdCrfcVepYZrsUG0POvVtjkW1Dgn295
5UMgQAEiXIrgljXnNAAhUfhX/hbSWiynMaQxBGctN7v2QKhSJlYjCTdrhB9eeQZb
0Gq6svncUVH8m8sMRTOqUzRGNn+Iwgu/E7dSo/MHvgsftWTFfgR86Vqw/NxJln6Y
dGoCXubAtmszNH/iFz3LmC01yxbjW5mu1uOHlmlT9gCxHOI5CxN0+E5pREDCxWSU
WXbOaYsp9AR1xDXcy4xPe18W4ZtDQHe3vQgMMnnfpAtV3lvna48u54O7Qs94svP4
slrUUC1eTDlpOi/MCHRz
=jJ5J
-----END PGP SIGNATURE-----

--nextPart1514234.BI38pWaJmg--
