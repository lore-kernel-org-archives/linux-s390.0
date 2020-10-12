Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 12 Oct 2020 16:19:06 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 08/17] s390/pci: Remove races against pte updates
Message-ID: <20201012141906.GX438822@phenom.ffwll.local>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-9-daniel.vetter@ffwll.ch>
 <6deb08dd-46f3-bf26-5362-fdc696f6fd74@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6deb08dd-46f3-bf26-5362-fdc696f6fd74@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

On Mon, Oct 12, 2020 at 04:03:28PM +0200, Niklas Schnelle wrote:
> Hi Daniel,
>=20
> freshly back from my vacation I've just taken a look at your patch.
> First thanks for this fix and the detailed commit description.
> Definitely makes sense to fix this and you can add my
>=20
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Content wise it all looks sane and clear and since Gerald did the testing,
> I would have applied it to our tree already, but I got some trivial
> checkpatch violations that probably apply to the whole series.
> I've commented them inline below.
> If you confirm there I can do the fixups when applying or you can resend.
>=20
> On 10/9/20 9:59 AM, Daniel Vetter wrote:
> > Way back it was a reasonable assumptions that iomem mappings never
> > change the pfn range they point at. But this has changed:
> >=20
> > - gpu drivers dynamically manage their memory nowadays, invalidating
> > ptes with unmap_mapping_range when buffers get moved
> >=20
> > - contiguous dma allocations have moved from dedicated carvetouts to
> > cma regions. This means if we miss the unmap the pfn might contain
> > pagecache or anon memory (well anything allocated with GFP_MOVEABLE)
> >=20
> > - even /dev/mem now invalidates mappings when the kernel requests that
> > iomem region when CONFIG_IO_STRICT_DEVMEM is set, see 3234ac664a87
>=20
> The above commit mention should use the format
> 'commit 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the=
 region")'
> otherwise this results in a checkpatch ERROR.
>=20
> > ("/dev/mem: Revoke mappings when a driver claims the region")
> >=20
> > Accessing pfns obtained from ptes without holding all the locks is
> > therefore no longer a good idea. Fix this.
> >=20
> > Since zpci_memcpy_from|toio seems to not do anything nefarious with
> > locks we just need to open code get_pfn and follow_pfn and make sure
> > we drop the locks only after we've done. The write function also needs
>=20
> just a typo but just saw it "we're" instead of "we've"
>=20
> > the copy_from_user move, since we can't take userspace faults while
> > holding the mmap sem.
> >=20
> > Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> >=20
> No empty line after the Revied-by tag.
>=20
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>=20
> Your Signed-off-by mail address does not match the one you're sending fro=
m,
> this yields a checkpatch warning when using git am with your mail.
> This is probably just a silly misconfiguration but since Signed-offs
> are signatures should I change this to=20
> "Daniel Vetter <daniel.vetter@ffwll.ch>" which is the one you're
> sending from and also in the MAINTAINERS file?
>=20
>=20
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
>=20
> The above Cc: line for Dan Williams is a duplicate
>=20
> > Cc: linux-mm@kvack.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Cc: linux-media@vger.kernel.org
> > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > --
> > v2: Move VM_IO | VM_PFNMAP checks around so they keep returning EINVAL
> > like before (Gerard)
>=20
> I think the above should go before the CC/Signed-off/Reviewev block.

This is a per-subsystem bikeshed :-) drivers/gpu definitely wants it
above, but most core subsystems want it below. I'll move it.

> > ---
> >  arch/s390/pci/pci_mmio.c | 98 +++++++++++++++++++++++-----------------
> >  1 file changed, 57 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
> > index 401cf670a243..1a6adbc68ee8 100644
> > --- a/arch/s390/pci/pci_mmio.c
> > +++ b/arch/s390/pci/pci_mmio.c
> > @@ -119,33 +119,15 @@ static inline int __memcpy_toio_inuser(void __iom=
em *dst,
> >  	return rc;
> >  }
> > =20
> > -static long get_pfn(unsigned long user_addr, unsigned long access,
> > -		    unsigned long *pfn)
> > -{
> > -	struct vm_area_struct *vma;
> > -	long ret;
> > -
> > -	mmap_read_lock(current->mm);
> > -	ret =3D -EINVAL;
> > -	vma =3D find_vma(current->mm, user_addr);
> > -	if (!vma)
> > -		goto out;
> > -	ret =3D -EACCES;
> > -	if (!(vma->vm_flags & access))
> > -		goto out;
> > -	ret =3D follow_pfn(vma, user_addr, pfn);
> > -out:
> > -	mmap_read_unlock(current->mm);
> > -	return ret;
> > -}
> > -
> >  SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
> >  		const void __user *, user_buffer, size_t, length)
> >  {
> >  	u8 local_buf[64];
> >  	void __iomem *io_addr;
> >  	void *buf;
> > -	unsigned long pfn;
> > +	struct vm_area_struct *vma;
> > +	pte_t *ptep;
> > +	spinlock_t *ptl;
>=20
> With checkpatch.pl --strict the above yields a complained
> "CHECK: spinlock_t definition without comment" but I think
> that's really okay since your commit description is very clear.
> Same oin line 277.

I think this is a falls positive, checkpatch doesn't realize that
SYSCALL_DEFINE3 is a function, not a structure. And in a structure I'd
have added the kerneldoc or comment.

I'll fix up all the nits you've found for the next round. Thanks for
taking a look.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
