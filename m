Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 19 Feb 2020 15:11:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Message-ID: <20200219151134.GI1078625@stefanha-x1.localdomain>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200213123728.61216-1-pasic@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 01:37:26PM +0100, Halil Pasic wrote:
> Two patches are handling new edge cases introduced by doing DMA mappings
> (which can fail) in virtio core.
>=20
> I stumbled upon this while stress testing I/O for Protected Virtual
> Machines. I deliberately chose a tiny swiotlb size and have generated
> load with fio. With more than one virtio-blk disk in use I experienced
> hangs.
>=20
> The goal of this series is to fix those hangs.
>=20
> Halil Pasic (2):
>   virtio-blk: fix hw_queue stopped on arbitrary error
>   virtio-blk: improve virtqueue error to BLK_STS
>=20
>  drivers/block/virtio_blk.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
>=20
> base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
> --=20
> 2.17.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5NUCYACgkQnKSrs4Gr
c8j5Pgf+MI41fd9a93cz9zlmiW7E/b+B99Zg/shlPYBcQXo0INymDnvknnpzLpqK
uHn5ZGq85kM6+ls29Zhh4w7bxiJlBBNRzCkIIRxe5CwyOptQPcKHONreD1suCGT0
boXaZtrbU1Wt1bWRBK4F9OLZcyIFxUESQ36b1r1VddZsKeFETUXAwjpSEU9bVCZ6
qJfDp9RLYVvFISB17avVnsqyw8xO9mVI3RyIdzQATERL9W3DVxaacULruMmlBHvq
T3nt4WcQjbTHEmTjvpnwGg2Oz4uvaRGm617bv082XAOP+Xr0h9uNU119WKCYk1Qk
VML23VMN5owhMcib+gUXV3/9bQQkYQ==
=GsRc
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
