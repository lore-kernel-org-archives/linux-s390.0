Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgDWLHq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 07:07:46 -0400
Date: Thu, 23 Apr 2020 13:07:38 +0200
From: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
Message-ID: <20200423110738.GA102241@blackbook>
References: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
 <20200410054544.GA17923@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20200410054544.GA17923@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Qian Cai <cai@lca.pw>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Fri, Apr 10, 2020 at 07:45:44AM +0200, Christoph Hellwig <hch@lst.de> wrote:
> @@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
> -	if (bdev->bd_part_count || bdev->bd_openers)
> +	if (bdev->bd_part_count || bdev->bd_openers > 1)
>  		return -EBUSY;
I noticed this (and the previous patch) change unmasks race between
ioctl(LOOP_SET_STATUS64, ... lo_flags=LO_FLAGS_PARTSCAN ...) and udev
processing loop device uevents. See [1] for details.

Should the condition be changed in the case of newly setup loop devices?
(Or shouldn't the ioctl propagate EBUSY in its return value?)

Thanks,
Michal

[1] https://bugzilla.opensuse.org/show_bug.cgi?id=1169932

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl6hdvAACgkQia1+riC5
qSgT0A/9HF8wBP+q81PKssmN3OAiHSEBVgWuK2oRpZDemVZOk7Ju4HOdfgFW//7y
3HREuHE2FTBMSvd+kp6B8PRSA8Qzw1GaJEHRCeh2+3nfUT4UmMDlJiw9mB7oN2pH
fmVdjfTWhsdEx1FhOTvKnPWzwrWJIdhCyqB8xnRzosIdCaeXPM7HLwbSG64GZ/VE
biTAGgAGXZGXexNVfi0UWbxll6td64pNFr+XMoToCzRNUvyxu9jMDBvyyAB7F5et
pOGedkxdysYujjFle3o3Lw6ifJ+dZh3BLgZfFWAPW59J/b6ZTi1k4vzv40vPdSju
fho2c4Q3QPPFC0o5SMws3Vu92woJfrzRbUdzqSpnCrXZY//8/0fyuuPyjgBEglDs
daxWBKhAdrAb4tsIul+jc3nSY7KGCgy1Eef7rU7TC5rduJ0a65dco4POXHL1CGk6
pppFxjAmupe6tevT/C7HtSWOaSvoWkaKPq7MQ0VSEMTyuErYhdv7402+IzSjLuxJ
z6uG/k52yUce51P1z8LW57BRiHW0rBB4Qs6nSN3qu2O+Hul2OBZAgCp5qpzYcIBG
qH0L4V39Q1U6PILsDkQYX9GLM3hEWf4LaSg7xCYcjYLn3YbXXMiUzmVvl/igXbBe
zBFiBwslvrRk/71wSdK7xYT1NbnqSNcRJLe6ePYnCNP8p2i77dI=
=pl+J
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
