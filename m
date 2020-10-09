Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:53580 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387763AbgJIKmC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 9 Oct 2020 06:42:02 -0400
Date: Fri, 9 Oct 2020 13:41:54 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 17/17] drm/i915: Properly request PCI BARs
Message-ID: <20201009104154.GR6112@intel.com>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-18-daniel.vetter@ffwll.ch>
 <20201009094750.GQ6112@intel.com>
 <CAKMK7uH3o3hnRkTDqr93PR=wuRejpty+AbyMacoEFDDb6OgJeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKMK7uH3o3hnRkTDqr93PR=wuRejpty+AbyMacoEFDDb6OgJeQ@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, KVM list <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Linux PCI <linux-pci@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Vetter <daniel.vetter@intel.com>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

On Fri, Oct 09, 2020 at 12:01:39PM +0200, Daniel Vetter wrote:
> On Fri, Oct 9, 2020 at 11:47 AM Ville Syrj=EF=BF=BDl=EF=BF=BD
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Fri, Oct 09, 2020 at 09:59:34AM +0200, Daniel Vetter wrote:
> > > When trying to test my CONFIG_IO_STRICT_DEVMEM changes I realized they
> > > do nothing for i915. Because i915 doesn't request any regions, like
> > > pretty much all drm pci drivers. I guess this is some very old
> > > remnants from the userspace modesetting days, when we wanted to
> > > co-exist with the fbdev driver. Which usually requested these
> > > resources.
> > >
> > > But makes me wonder why the pci subsystem doesn't just request
> > > resource automatically when we map a bar and a pci driver is bound?
> > >
> > > Knowledge about which pci bars we need kludged together from
> > > intel_uncore.c and intel_gtt.c from i915 and intel-gtt.c over in the
> > > fake agp driver.
> > >
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Cc: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-samsung-soc@vger.kernel.org
> > > Cc: linux-media@vger.kernel.org
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: linux-pci@vger.kernel.org
> > > ---
> > >  drivers/gpu/drm/i915/intel_uncore.c | 25 +++++++++++++++++++++++--
> > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i9=
15/intel_uncore.c
> > > index 54e201fdeba4..ce39049d8919 100644
> > > --- a/drivers/gpu/drm/i915/intel_uncore.c
> > > +++ b/drivers/gpu/drm/i915/intel_uncore.c
> > > @@ -1692,10 +1692,13 @@ static int uncore_mmio_setup(struct intel_unc=
ore *uncore)
> > >       struct pci_dev *pdev =3D i915->drm.pdev;
> > >       int mmio_bar;
> > >       int mmio_size;
> > > +     int bar_selection;
> >
> > Signed bitmasks always make me uneasy. But looks like
> > that's what it is in the pci api. So meh.
>=20
> Yeah it's surprising.
>=20
> > > +     int ret;
> > >
> > >       mmio_bar =3D IS_GEN(i915, 2) ? 1 : 0;
> > > +     bar_selection =3D BIT (2) | BIT(mmio_bar);
> >                            ^
> > spurious space
> >
> > That's also not correct for gen2 I think.
> >
> > gen2:
> > 0 =3D GMADR
> > 1 =3D MMADR
> > 2 =3D IOBAR
> >
> > gen3:
> > 0 =3D MMADR
> > 1 =3D IOBAR
> > 2 =3D GMADR
> > 3 =3D GTTADR
> >
> > gen4+:
> > 0+1 =3D GTTMMADR
> > 2+3 =3D GMADR
> > 4 =3D IOBAR
> >
> > Maybe we should just have an explicit list of bars like that in a
> > comment?
> >
> > I'd also suggest sucking this bitmask calculation into a small helper
> > so you can reuse it for the release.
>=20
> tbh I just hacked this up for testing. Given how almost no other drm
> driver does this, I'm wondering whether we should or not.
>=20
> Also the only reason why I didn't just use the pci_request_regions
> helper is to avoid the vga ioport range, since that's managed by
> vgaarbiter.

VGA io range isn't part of any bar. Or do you mean just the io decode
enable bit in the pci command register? That should be just a matter
or pci_enable_device() vs. pci_enable_device_mem() I think. So nothing
to do with which bars we've requested IIRC.

>=20
> So I think if we go for this for real we should:
> - register the vga ioport range in the vgaarbiter
> - have a pci_request_iomem_regions helper that grabs all mem bars
> - roll that out to all drm pci drivers
>=20
> Or something like that. The other complication is when we resize the
> iobar. So not really sure what to do here.

We resize it?

--=20
Ville Syrj=EF=BF=BDl=EF=BF=BD
Intel
