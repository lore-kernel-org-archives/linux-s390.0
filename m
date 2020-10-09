Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Oct 2020 12:58:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 15/17] sysfs: Support zapping of binary attr mmaps
Message-ID: <20201009105803.GA505688@kroah.com>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-16-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201009075934.3509076-16-daniel.vetter@ffwll.ch>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, "David S. Miller" <davem@davemloft.net>, Michael Ellerman <mpe@ellerman.id.au>, Sourabh Jain <sourabhjain@linux.ibm.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Nayna Jain <nayna@linux.ibm.com>

On Fri, Oct 09, 2020 at 09:59:32AM +0200, Daniel Vetter wrote:
> We want to be able to revoke pci mmaps so that the same access rules
> applies as for /dev/kmem. Revoke support for devmem was added in
> 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the
> region").
>=20
> The simplest way to achieve this is by having the same filp->f_mapping
> for all mappings, so that unmap_mapping_range can find them all, no
> matter through which file they've been created. Since this must be set
> at open time we need sysfs support for this.
>=20
> Add an optional mapping parameter bin_attr, which is only consulted
> when there's also an mmap callback, since without mmap support
> allowing to adjust the ->f_mapping makes no sense.
>=20
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
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> ---
>  fs/sysfs/file.c       | 11 +++++++++++
>  include/linux/sysfs.h |  2 ++
>  2 files changed, 13 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
