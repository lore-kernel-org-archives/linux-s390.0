Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 24 Feb 2020 17:40:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200224064041.GL1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
 <20200221141230.13eebc35.pasic@linux.ibm.com>
 <bf0c87a2-adc6-a05a-835f-f98e7cd0cd3b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Content-Disposition: inline
In-Reply-To: <bf0c87a2-adc6-a05a-835f-f98e7cd0cd3b@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "Huang, Wei" <wei.huang2@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 09:39:38AM -0600, Tom Lendacky wrote:
> On 2/21/20 7:12 AM, Halil Pasic wrote:
> > On Thu, 20 Feb 2020 15:55:14 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >=20
> >> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> >>> Currently the advanced guest memory protection technologies (AMD SEV,
> >>> powerpc secure guest technology and s390 Protected VMs) abuse the
> >>> VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, whi=
ch
> >>> is in turn necessary, to make IO work with guest memory protection.
> >>>
> >>> But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really=
 a
> >>> different beast: with virtio devices whose implementation runs on an =
SMP
> >>> CPU we are still fine with doing all the usual optimizations, it is j=
ust
> >>> that we need to make sure that the memory protection mechanism does n=
ot
> >>> get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> >>> side of the guest (and possibly he host side as well) than we actually
> >>> need.
> >>>
> >>> An additional benefit of teaching the guest to make the right decision
> >>> (and use DMA API) on it's own is: removing the need, to mandate speci=
al
> >>> VM configuration for guests that may run with protection. This is
> >>> especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> >>> the virtio control structures into the first 2G of guest memory:
> >>> something we don't necessarily want to do per-default.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >>> Tested-by: Ram Pai <linuxram@us.ibm.com>
> >>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> >>
> >> This might work for you but it's fragile, since without
> >> VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
> >> GPA's, not DMA addresses.
> >>
> >=20
> > Thanks for your constructive approach. I do want the hypervisor to
> > assume it gets GPA's. My train of thought was that the guys that need
> > to use IOVA's that are not GPA's when force_dma_unencrypted() will have
> > to to specify VIRTIO_F_ACCESS_PLATFORM (at the device) anyway, because
> > otherwise it won't work. But I see your point: in case of a
> > mis-configuration and provided the DMA API returns IOVA's one could end
> > up trying to touch wrong memory locations. But this should be similar to
> > what would happen if DMA ops are not used, and memory is not made acces=
sible.
> >=20
> >>
> >>
> >> IOW this looks like another iteration of:
> >>
> >> 	virtio: Support encrypted memory on powerpc secure guests
> >>
> >> which I was under the impression was abandoned as unnecessary.
> >=20
> > Unnecessary for powerpc because they do normal PCI. In the context of
> > CCW there are only guest physical addresses (CCW I/O has no concept of
> > IOMMU or IOVAs).
> >=20
> >>
> >>
> >> To summarize, the necessary conditions for a hack along these lines
> >> (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect th=
at:
> >>
> >>   - secure guest mode is enabled - so we know that since we don't share
> >>     most memory regular virtio code won't
> >>     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_=
PLATFORM
> >=20
> > force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.
> >=20
> >>   - DMA API is giving us addresses that are actually also physical
> >>     addresses
> >=20
> > In case of s390 this is given. I talked with the power people before
> > posting this, and they ensured me they can are willing to deal with
> > this. I was hoping to talk abut this with the AMD SEV people here (hence
> > the cc).
>=20
> Yes, physical addresses are fine for SEV - the key is that the DMA API is
> used so that an address for unencrypted, or shared, memory is returned.
> E.g. for a dma_alloc_coherent() call this is an allocation that has had
> set_memory_decrypted() called or for a dma_map_page() call this is an
> address from SWIOTLB, which was mapped shared during boot, where the data
> will be bounce-buffered.
>=20
> We don't currently support an emulated IOMMU in our SEV guest because that
> would require a lot of support in the driver to make IOMMU data available
> to the hypervisor (I/O page tables, etc.). We would need hardware support
> to really make this work easily in the guest.

A tangent here: note that on POWER our IOMMU is paravirtualized
(updated with hypercalls), it's also always enabled.  For that reason
we can and do combine vIOMMU translation with the need for bounce
buffering for secure guests.

(We generally statically configure the vIOMMU to have a huge window
which just maps GPAs 1-to-1, which means we can still use dma-direct,
but the vIOMMU is still there from the platform point of view)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Tb+cACgkQbDjKyiDZ
s5JuYA/+PfSvSTQHH+JQEj0OF/7dpLptTGSV1vu254FmtjttOv1Jp6vV1qNrERui
WrRDf1Hu/dKxuJty9TNapcUvBHFWP5NtSSRXXYsTRm+A629Ykjtom+0/2TjOzKbF
oX7NvwxIc33a0Y64z3cstNSKcj8eTrRZC1SvIwezFXL1uldfKOq+WH42U/cImXy7
Br6oWhkuV5EHDcshTAQ2FLz6zxhzp0hPuL2+PrYETrqHJq2Vx08goX4ZgwH6iL40
NDTT6JNniVQE3rZ8NimqdXJETTXVuqTKPVinVod77U6V/QSEKf1YYL9upvc6oYSU
LZKsXAlQVgdSepYV/3PMafrZ6OhX0ZorfqzfDn/p0FkHYAKmSNgBG3mzI8JbIrE/
kPCF6Jo8vbs0SX24V4N/cTFxAodz+YQaMGtf+IZQ1LB56XhQBv2GES82btCMM8Re
1e6T6AXQuXUb0db5JsYzh9Iopa8cqABVVNqYKoCcDKll1bkCDW2OA0jK3qtz9wH6
mNNLn8ZLZDX0OjwINwQK2brVa6p5UTrk0l+Tgg94EbpISG5R4pb1e9rGK8UUrVcg
G4AqmwA8NkFmCJPEbeWxYwE2Rg73yJx1C3okR5KTC/odF/7Pw6KParzV1Wn3lMdz
WLYS9wIe5ZmNIjpbAPS1dEM1cjyza4Qyuu3xyvKcoKuT/uxPl5c=
=VdBp
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--
