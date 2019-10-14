Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40134 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbfJNRXH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Oct 2019 13:23:07 -0400
Date: Mon, 14 Oct 2019 18:23:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V3 5/7] mdev: introduce virtio device and its device ops
Message-ID: <20191014172301.GA5359@stefanha-x1.localdomain>
References: <20191011081557.28302-1-jasowang@redhat.com>
 <20191011081557.28302-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20191011081557.28302-6-jasowang@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2019 at 04:15:55PM +0800, Jason Wang wrote:
> + * @set_vq_cb:			Set the interrut calback function for

s/interrut/interrupt/

s/calback/callback/

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2krvUACgkQnKSrs4Gr
c8hIpQgArOf5wNMCOOx9mrAoFEfDyFDnQGYWa6Ce2/25rBYZVN1BIaLrZLwRk4Za
aM65SiUsAMIh+UTdezqEPyUZCoRZbcxFRWUtyQZqHLCVg3yrwM++9xtTFclrIY0p
hP+v2ZVAMUT/1BQiaAo3+qlItEYbUDwtSl+wsSwzlvu9nFRlHjjdbUZAJmU78zv0
Y50LNaXQf3+E9GqPDj6nJEUSxpww44C1FOgxh9SErmqG8j7ReyAfng0loRKNdZbv
6g7U1I0J+vNgzcCxTSipVRS8EH0bOEY07w3OggpIoIRnOx6voaXYz8SMEQZ8tiRu
k0SSOtAyZ48s1BaOt3vREX8uYFlt0A==
=/ZZN
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
