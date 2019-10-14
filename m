Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
Date: Mon, 14 Oct 2019 20:31:02 +0200
Message-Id: <20191014183108.24804-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: hch@infradead.org, mbrugger@suse.com, f.fainelli@gmail.com, wahrenst@gmx.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

Hi all,
the Raspberry Pi 4 offers up to 4GB of memory, of which only the first
is DMA capable device wide. This forces us to use of bounce buffers,
which are currently not very well supported by ARM's custom DMA ops.
Among other things the current mechanism (see dmabounce.c) isn't
suitable for high memory. Instead of fixing it, this series introduces a
way of selecting dma-direct as the default DMA ops provider which allows
for the Raspberry Pi to make use of swiotlb.

Regards,
Nicolas

---

Nicolas Saenz Julienne (5):
  dma/direct: turn ARCH_ZONE_DMA_BITS into a variable
  ARM: introduce arm_dma_direct
  ARM: let machines select dma-direct over arch's DMA implementation
  dma/direct: check for overflows in ARM's dma_capable()
  ARM: bcm2711: use dma-direct

 arch/arm/include/asm/dma-direct.h  |  6 ++++++
 arch/arm/include/asm/dma-mapping.h |  3 ++-
 arch/arm/include/asm/dma.h         |  2 ++
 arch/arm/include/asm/mach/arch.h   |  1 +
 arch/arm/mach-bcm/Kconfig          |  1 +
 arch/arm/mach-bcm/bcm2711.c        |  1 +
 arch/arm/mm/dma-mapping.c          | 10 ++--------
 arch/arm/mm/init.c                 | 21 ++++++++++++++++++++-
 arch/arm64/include/asm/page.h      |  2 --
 arch/arm64/mm/init.c               |  9 +++++++--
 arch/powerpc/include/asm/page.h    |  9 ---------
 arch/powerpc/mm/mem.c              | 20 +++++++++++++++-----
 arch/s390/include/asm/page.h       |  2 --
 arch/s390/mm/init.c                |  1 +
 include/linux/dma-direct.h         |  2 ++
 kernel/dma/direct.c                | 13 ++++++-------
 16 files changed, 66 insertions(+), 37 deletions(-)

-- 
2.23.0
