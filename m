Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 7 Oct 2020 13:46:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 09/13] PCI: obey iomem restrictions for procfs mmap
Message-ID: <20201007184634.GA3259641@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201007164426.1812530-10-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 06:44:22PM +0200, Daniel Vetter wrote:
> There's three ways to access pci bars from userspace: /dev/mem, sysfs
> files, and the old proc interface. Two check against
> iomem_is_exclusive, proc never did. And with CONFIG_IO_STRICT_DEVMEM,
> this starts to matter, since we don't want random userspace having
> access to pci bars while a driver is loaded and using it.
>=20
> Fix this.

Please mention *how* you're fixing this.  I know you can sort of
deduce it from the first paragraph, but it's easy to save readers the
trouble.

s/pci/PCI/
s/bars/BARs/
Capitalize subject to match other patches.

> References: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/proc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index d35186b01d98..3a2f90beb4cb 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -274,6 +274,11 @@ static int proc_bus_pci_mmap(struct file *file, stru=
ct vm_area_struct *vma)
>  		else
>  			return -EINVAL;
>  	}
> +
> +	if (dev->resource[i].flags & IORESOURCE_MEM &&
> +	    iomem_is_exclusive(dev->resource[i].start))
> +		return -EINVAL;
> +
>  	ret =3D pci_mmap_page_range(dev, i, vma,
>  				  fpriv->mmap_state, write_combine);
>  	if (ret < 0)
> --=20
> 2.28.0
>=20
