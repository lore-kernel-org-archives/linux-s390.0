Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Dec 2020 17:18:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 0/4] vfio-pci/zdev: Fixing s390 vfio-pci ISM support
Message-ID: <20201222171822.2d9b5962.cohuck@redhat.com>
In-Reply-To: <f9f312d8-1948-d5b8-22fe-82f1975c8a18@linux.ibm.com>
References: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
        <20201210133306.70d1a556.cohuck@redhat.com>
        <ce9d4ef2-2629-59b7-99ed-4c8212cb004f@linux.ibm.com>
        <20201211153501.7767a603.cohuck@redhat.com>
        <6c9528f3-f012-ba15-1d68-7caefb942356@linux.ibm.com>
        <a974c5cc-fc42-7bf0-66a6-df095da7105f@linux.ibm.com>
        <20201217135919.46d5c43f.cohuck@redhat.com>
        <f9f312d8-1948-d5b8-22fe-82f1975c8a18@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 11:04:48 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 12/17/20 7:59 AM, Cornelia Huck wrote:
> > The basic question I have is whether it makes sense to specialcase the
> > ISM device (can we even find out that we're dealing with an ISM device
> > here?) to force the non-MIO instructions, as it is just a device with =
=20
>=20
> Yes, with the addition of the CLP data passed from the host via vfio=20
> capabilities, we can tell this is an ISM device specifically via the=20
> 'pft' field in VFOI_DEVICE_INFO_CAP_ZPCI_BASE.  We don't actually=20
> surface that field to the guest itself in the Q PCI FN clp rsponse (has=20
> to do with Function Measurement Block requirements) but we can certainly=
=20
> use that information in QEMU to restrict this behavior to only ISM device=
s.
>=20
> > some special requirements, or tie non-MIO to relaxed alignment. (Could
> > relaxed alignment devices in theory be served by MIO instructions as
> > well?) =20
>=20
> In practice, I think there are none today, but per the architecture it=20
> IS possible to have relaxed alignment devices served by MIO=20
> instructions, so we shouldn't rely on that bit alone as I'm doing in=20
> this RFC.  I think instead relying on the pft value as I mention above=20
> is what we have to do.

=46rom what you write this looks like the best way to me as well.

>=20
> >=20
> > Another thing that came to my mind is whether we consider the guest to
> > be using a pci device and needing weird instructions to do that because
> > it's on s390, or whether it is issuing instructions for a device that
> > happens to be a pci device (sorry if that sounds a bit meta :)
> >  =20
>=20
> Typically, I'd classify things as the former but I think ISM seems more=20
> like the latter -- To me, ISM seems like less a classic PCI device and=20
> more a device that happens to be using s390 PCI interfaces to accomplish=
=20
> its goal.  But it's probably more of a case of this particular device=20
> (and it's driver) are s390-specific and therefore built with the unique=20
> s390 interface in-mind (and in fact invokes it directly rather than=20
> through the general PCI layer), rather than fitting the typical PCI=20
> device architecture on top of the s390 interface.

Nod, it certainly feels like that.
