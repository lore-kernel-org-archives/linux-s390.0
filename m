Return-Path: <bpf-owner@vger.kernel.org>
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 20/28] mm: remove the pgprot argument to __vmalloc
Date: Fri, 10 Apr 2020 20:39:22 +0000
Message-ID: <DM5PR2101MB10472EA3373D4D1A73AC0F7ED7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-21-hch@lst.de>
In-Reply-To: <20200408115926.1467567-21-hch@lst.de>
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
> The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
> it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/hyperv/hv_init.c              |  3 +--
>  arch/x86/include/asm/kvm_host.h        |  3 +--
>  arch/x86/kvm/svm.c                     |  3 +--
>  drivers/block/drbd/drbd_bitmap.c       |  4 +---
>  drivers/gpu/drm/etnaviv/etnaviv_dump.c |  4 ++--
>  drivers/lightnvm/pblk-init.c           |  5 ++---
>  drivers/md/dm-bufio.c                  |  4 ++--
>  drivers/mtd/ubi/io.c                   |  4 ++--
>  drivers/scsi/sd_zbc.c                  |  3 +--
>  fs/gfs2/dir.c                          |  9 ++++-----
>  fs/gfs2/quota.c                        |  2 +-
>  fs/nfs/blocklayout/extent_tree.c       |  2 +-
>  fs/ntfs/malloc.h                       |  2 +-
>  fs/ubifs/debug.c                       |  2 +-
>  fs/ubifs/lprops.c                      |  2 +-
>  fs/ubifs/lpt_commit.c                  |  4 ++--
>  fs/ubifs/orphan.c                      |  2 +-
>  fs/xfs/kmem.c                          |  2 +-
>  include/linux/vmalloc.h                |  2 +-
>  kernel/bpf/core.c                      |  6 +++---
>  kernel/groups.c                        |  2 +-
>  kernel/module.c                        |  3 +--
>  mm/nommu.c                             | 15 +++++++--------
>  mm/page_alloc.c                        |  2 +-
>  mm/percpu.c                            |  2 +-
>  mm/vmalloc.c                           |  4 ++--
>  net/bridge/netfilter/ebtables.c        |  6 ++----
>  sound/core/memalloc.c                  |  2 +-
>  sound/core/pcm_memory.c                |  2 +-
>  29 files changed, 47 insertions(+), 59 deletions(-)
>=20

For Hyper-V changes,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
