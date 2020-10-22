Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506719AbgJVHjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Oct 2020 03:39:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC60C0613CE
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2020 00:39:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so875672wre.4
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2020 00:39:47 -0700 (PDT)
Date: Thu, 22 Oct 2020 09:39:43 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 08/17] s390/pci: Remove races against pte updates
Message-ID: <20201022073943.GS401619@phenom.ffwll.local>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-9-daniel.vetter@ffwll.ch>
 <6deb08dd-46f3-bf26-5362-fdc696f6fd74@linux.ibm.com>
 <20201012141906.GX438822@phenom.ffwll.local>
 <3594c115-541f-806a-ee33-e99a2d1d31e8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3594c115-541f-806a-ee33-e99a2d1d31e8@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

On Wed, Oct 21, 2020 at 09:55:57AM +0200, Niklas Schnelle wrote:
> Hi Daniel,
>=20
> friendly ping. I haven't seen a new version of this patch series,
> as I said I think your change for s390/pci is generally useful so
> I'm curious, are you planning on sending a new version soon?
> If you want you can also just sent this patch with the last few
> nitpicks (primarily the mail address) fixed and I'll happily apply.

(I think this was stuck somewhere in moderation, only showed up just now)

I was waiting for the testing result for the habana driver from Oded, but
I guess Oded was waiting for v3. Hence the delay.

Cheers, Daniel

>=20
> Best regards,
> Niklas Schnelle
>=20
> On 10/12/20 4:19 PM, Daniel Vetter wrote:
> > On Mon, Oct 12, 2020 at 04:03:28PM +0200, Niklas Schnelle wrote:
> ... snip ....
> >>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >>> Cc: Dan Williams <dan.j.williams@intel.com>
> >>> Cc: Kees Cook <keescook@chromium.org>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: John Hubbard <jhubbard@nvidia.com>
> >>> Cc: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> >>> Cc: Jan Kara <jack@suse.cz>
> >>> Cc: Dan Williams <dan.j.williams@intel.com>
> >>
> >> The above Cc: line for Dan Williams is a duplicate
> >>
> >>> Cc: linux-mm@kvack.org
> >>> Cc: linux-arm-kernel@lists.infradead.org
> >>> Cc: linux-samsung-soc@vger.kernel.org
> >>> Cc: linux-media@vger.kernel.org
> >>> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> >>> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> >>> Cc: linux-s390@vger.kernel.org
> >>> --
> >>> v2: Move VM_IO | VM_PFNMAP checks around so they keep returning EINVAL
> >>> like before (Gerard)
> >>
> >> I think the above should go before the CC/Signed-off/Reviewev block.
> >=20
> > This is a per-subsystem bikeshed :-) drivers/gpu definitely wants it
> > above, but most core subsystems want it below. I'll move it.
> >=20
> >>> ---
> >>>  arch/s390/pci/pci_mmio.c | 98 +++++++++++++++++++++++---------------=
--
> >>>  1 file changed, 57 insertions(+), 41 deletions(-)
> >>>
> >>> diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
> >>> index 401cf670a243..1a6adbc68ee8 100644
> >>> --- a/arch/s390/pci/pci_mmio.c
> >>> +++ b/arch/s390/pci/pci_mmio.c
> >>> @@ -119,33 +119,15 @@ static inline int __memcpy_toio_inuser(void __i=
omem *dst,
> >>>  	return rc;
> >>>  }
> >>> =20
> >>> -static long get_pfn(unsigned long user_addr, unsigned long access,
> >>> -		    unsigned long *pfn)
> >>> -{
> >>> -	struct vm_area_struct *vma;
> >>> -	long ret;
> >>> -
> >>> -	mmap_read_lock(current->mm);
> >>> -	ret =3D -EINVAL;
> >>> -	vma =3D find_vma(current->mm, user_addr);
> >>> -	if (!vma)
> >>> -		goto out;
> >>> -	ret =3D -EACCES;
> >>> -	if (!(vma->vm_flags & access))
> >>> -		goto out;
> >>> -	ret =3D follow_pfn(vma, user_addr, pfn);
> >>> -out:
> >>> -	mmap_read_unlock(current->mm);
> >>> -	return ret;
> >>> -}
> >>> -
> >>>  SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
> >>>  		const void __user *, user_buffer, size_t, length)
> >>>  {
> >>>  	u8 local_buf[64];
> >>>  	void __iomem *io_addr;
> >>>  	void *buf;
> >>> -	unsigned long pfn;
> >>> +	struct vm_area_struct *vma;
> >>> +	pte_t *ptep;
> >>> +	spinlock_t *ptl;
> >>
> >> With checkpatch.pl --strict the above yields a complained
> >> "CHECK: spinlock_t definition without comment" but I think
> >> that's really okay since your commit description is very clear.
> >> Same oin line 277.
> >=20
> > I think this is a falls positive, checkpatch doesn't realize that
> > SYSCALL_DEFINE3 is a function, not a structure. And in a structure I'd
> > have added the kerneldoc or comment.
> >=20
> > I'll fix up all the nits you've found for the next round. Thanks for
> > taking a look.
> > -Daniel
> >=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
