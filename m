Return-Path: <bpf-owner@vger.kernel.org>
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 01/28] x86/hyperv: use vmalloc_exec for the hypercall page
Date: Fri, 10 Apr 2020 20:40:21 +0000
Message-ID: <DM5PR2101MB1047BD681D8EDD0797DD1E28D7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-2-hch@lst.de>
In-Reply-To: <20200408115926.1467567-2-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "x86@kernel.org" <x86@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Christoph Hellwig <hch@lst.de> Sent: Wednesday, April 8, 2020 4:59 AM
>=20
> Use the designated helper for allocating executable kernel memory, and
> remove the now unused PAGE_KERNEL_RX define.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/hyperv/hv_init.c            | 2 +-
>  arch/x86/include/asm/pgtable_types.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
