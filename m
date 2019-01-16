Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 16 Jan 2019 09:18:24 -0600
Message-ID: <CAL_JsqJv=+SQwmbwuw1C5Rv9sFHhk4SiP=Z_cKJu3HG5kdwhrg@mail.gmail.com>
Subject: Re: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, SH-Linux <linux-sh@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, Openrisc <openrisc@lists.librecores.org>, Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB List <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 16, 2019 at 7:46 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
>
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
>
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/alpha/kernel/core_cia.c              |  3 +++
>  arch/alpha/kernel/core_marvel.c           |  6 ++++++
>  arch/alpha/kernel/pci-noop.c              | 11 ++++++++++-
>  arch/alpha/kernel/pci.c                   | 11 ++++++++++-
>  arch/alpha/kernel/pci_iommu.c             | 12 ++++++++++++
>  arch/arc/mm/highmem.c                     |  4 ++++
>  arch/arm/kernel/setup.c                   |  6 ++++++
>  arch/arm/mm/mmu.c                         | 14 +++++++++++++-
>  arch/arm64/kernel/setup.c                 |  9 ++++++---
>  arch/arm64/mm/kasan_init.c                | 10 ++++++++++
>  arch/c6x/mm/dma-coherent.c                |  4 ++++
>  arch/c6x/mm/init.c                        |  3 +++
>  arch/csky/mm/highmem.c                    |  5 +++++
>  arch/h8300/mm/init.c                      |  3 +++
>  arch/m68k/atari/stram.c                   |  4 ++++
>  arch/m68k/mm/init.c                       |  3 +++
>  arch/m68k/mm/mcfmmu.c                     |  6 ++++++
>  arch/m68k/mm/motorola.c                   |  9 +++++++++
>  arch/m68k/mm/sun3mmu.c                    |  6 ++++++
>  arch/m68k/sun3/sun3dvma.c                 |  3 +++
>  arch/microblaze/mm/init.c                 |  8 ++++++--
>  arch/mips/cavium-octeon/dma-octeon.c      |  3 +++
>  arch/mips/kernel/setup.c                  |  3 +++
>  arch/mips/kernel/traps.c                  |  3 +++
>  arch/mips/mm/init.c                       |  5 +++++
>  arch/nds32/mm/init.c                      | 12 ++++++++++++
>  arch/openrisc/mm/ioremap.c                |  8 ++++++--
>  arch/powerpc/kernel/dt_cpu_ftrs.c         |  5 +++++
>  arch/powerpc/kernel/pci_32.c              |  3 +++
>  arch/powerpc/kernel/setup-common.c        |  3 +++
>  arch/powerpc/kernel/setup_64.c            |  4 ++++
>  arch/powerpc/lib/alloc.c                  |  3 +++
>  arch/powerpc/mm/hash_utils_64.c           |  3 +++
>  arch/powerpc/mm/mmu_context_nohash.c      |  9 +++++++++
>  arch/powerpc/mm/pgtable-book3e.c          | 12 ++++++++++--
>  arch/powerpc/mm/pgtable-book3s64.c        |  3 +++
>  arch/powerpc/mm/pgtable-radix.c           |  9 ++++++++-
>  arch/powerpc/mm/ppc_mmu_32.c              |  3 +++
>  arch/powerpc/platforms/pasemi/iommu.c     |  3 +++
>  arch/powerpc/platforms/powermac/nvram.c   |  3 +++
>  arch/powerpc/platforms/powernv/opal.c     |  3 +++
>  arch/powerpc/platforms/powernv/pci-ioda.c |  8 ++++++++
>  arch/powerpc/platforms/ps3/setup.c        |  3 +++
>  arch/powerpc/sysdev/msi_bitmap.c          |  3 +++
>  arch/s390/kernel/setup.c                  | 13 +++++++++++++
>  arch/s390/kernel/smp.c                    |  5 ++++-
>  arch/s390/kernel/topology.c               |  6 ++++++
>  arch/s390/numa/mode_emu.c                 |  3 +++
>  arch/s390/numa/numa.c                     |  6 +++++-
>  arch/s390/numa/toptree.c                  |  8 ++++++--
>  arch/sh/mm/init.c                         |  6 ++++++
>  arch/sh/mm/numa.c                         |  4 ++++
>  arch/um/drivers/net_kern.c                |  3 +++
>  arch/um/drivers/vector_kern.c             |  3 +++
>  arch/um/kernel/initrd.c                   |  2 ++
>  arch/um/kernel/mem.c                      | 16 ++++++++++++++++
>  arch/unicore32/kernel/setup.c             |  4 ++++
>  arch/unicore32/mm/mmu.c                   | 15 +++++++++++++--
>  arch/x86/kernel/acpi/boot.c               |  3 +++
>  arch/x86/kernel/apic/io_apic.c            |  5 +++++
>  arch/x86/kernel/e820.c                    |  3 +++
>  arch/x86/platform/olpc/olpc_dt.c          |  3 +++
>  arch/x86/xen/p2m.c                        | 11 +++++++++--
>  arch/xtensa/mm/kasan_init.c               |  4 ++++
>  arch/xtensa/mm/mmu.c                      |  3 +++
>  drivers/clk/ti/clk.c                      |  3 +++
>  drivers/macintosh/smu.c                   |  3 +++
>  drivers/of/fdt.c                          |  8 +++++++-
>  drivers/of/unittest.c                     |  8 +++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/xen/swiotlb-xen.c                 |  7 +++++--
>  kernel/power/snapshot.c                   |  3 +++
>  lib/cpumask.c                             |  3 +++
>  mm/kasan/init.c                           | 10 ++++++++--
>  mm/sparse.c                               | 19 +++++++++++++++++--
>  74 files changed, 415 insertions(+), 29 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
