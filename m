Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Jul 2020 16:33:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200706163340.2ce7a5f2.cohuck@redhat.com>
In-Reply-To: <a677decc-5be3-8095-bc33-0f95634011f6@linux.ibm.com>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
        <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
        <20200629115651-mutt-send-email-mst@kernel.org>
        <20200629180526.41d0732b.cohuck@redhat.com>
        <26ecd4c6-837b-1ce6-170b-a0155e4dd4d4@linux.ibm.com>
        <a677decc-5be3-8095-bc33-0f95634011f6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On Mon, 6 Jul 2020 15:37:37 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-07-02 15:03, Pierre Morel wrote:
> >=20
> >=20
> > On 2020-06-29 18:05, Cornelia Huck wrote: =20
> >> On Mon, 29 Jun 2020 11:57:14 -0400
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> =20
> >>> On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote: =20
> >>>> An architecture protecting the guest memory against unauthorized host
> >>>> access may want to enforce VIRTIO I/O device protection through the
> >>>> use of VIRTIO_F_IOMMU_PLATFORM.
> >>>>
> >>>> Let's give a chance to the architecture to accept or not devices
> >>>> without VIRTIO_F_IOMMU_PLATFORM.
> >>>>
> >>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>> ---
> >>>> =C2=A0 arch/s390/mm/init.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> >>>> =C2=A0 drivers/virtio/virtio.c | 22 ++++++++++++++++++++++
> >>>> =C2=A0 include/linux/virtio.h=C2=A0 |=C2=A0 2 ++
> >>>> =C2=A0 3 files changed, 30 insertions(+) =20
> >> =20
> >>>> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct=20
> >>>> virtio_device *dev)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!virtio_has_feature(dev, VIRTIO_F=
_VERSION_1))
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>>> +=C2=A0=C2=A0=C2=A0 if (arch_needs_virtio_iommu_platform(dev) &&
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !virtio_has_feature(dev,=
 VIRTIO_F_IOMMU_PLATFORM)) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(&dev->dev,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> +
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_add_status(dev, VIRTIO_CONFIG_=
S_FEATURES_OK);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D dev->config->get_status(de=
v);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(status & VIRTIO_CONFIG_S_FEATUR=
ES_OK)) { =20
> >>>
> >>> Well don't you need to check it *before* VIRTIO_F_VERSION_1, not afte=
r? =20
> >>
> >> But it's only available with VERSION_1 anyway, isn't it? So it probably
> >> also needs to fail when this feature is needed if VERSION_1 has not be=
en
> >> negotiated, I think. =20
>=20
>=20
> would be something like:
>=20
> -       if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
> -               return 0;
> +       if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +               ret =3D arch_accept_virtio_features(dev);
> +               if (ret)
> +                       dev_warn(&dev->dev,
> +                                "virtio: device must provide=20
> VIRTIO_F_VERSION_1\n");
> +               return ret;
> +       }

That looks wrong; I think we want to validate in all cases. What about:

ret =3D arch_accept_virtio_features(dev); // this can include checking for
                                        // older or newer features
if (ret)
	// assume that the arch callback moaned already
	return ret;

if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
	return 0;

// do the virtio-1 only FEATURES_OK dance

>=20
>=20
> just a thought on the function name:
> It becomes more general than just IOMMU_PLATFORM related.
>=20
> What do you think of:
>=20
> arch_accept_virtio_features()

Or maybe arch_validate_virtio_features()?

>=20
> ?
>=20
> Regards,
> Pierre
>=20
>=20
