Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 00/16] set_memory_* functions header refactor
Date: Tue,  7 Mar 2017 12:55:17 -0800
Message-ID: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170307205517.KSOOam5YVIHWQSbnfYPCGFtUumylDXFiZmD9VxgXjMI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Laura Abbott <labbott@redhat.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

This is v3 of the series to decouple set_memory_* from cacheflush.h. This
version contains a few minor alphabetical order fixes and some fixes caught
by the 0day bot. Several places unfortunately need an #ifdef around the
header for arches without the set_memory_* functions.

Andrew, it might be best to wait a few days to let the 0day bot churn on this
series.

Thanks,
Laura

Laura Abbott (16):
  treewide: Move set_memory_* functions away from cacheflush.h
  arm: Use set_memory.h header
  arm64: Use set_memory.h header
  s390: Use set_memory.h header
  x86: Use set_memory.h header
  agp: Use set_memory.h header
  drm: Use set_memory.h header
  intel_th: Use set_memory.h header
  watchdog: hpwdt: Use set_memory.h header
  bpf: Use set_memory.h header
  module: Use set_memory.h header
  PM / hibernate: Use set_memory.h header
  ALSA: Use set_memory.h header
  misc: sram: Use set_memory.h header
  video: vermilion: Use set_memory.h header
  treewide: Decouple cacheflush.h and set_memory.h

 arch/arm/include/asm/cacheflush.h         | 20 -------
 arch/arm/include/asm/set_memory.h         | 32 ++++++++++++
 arch/arm/kernel/ftrace.c                  |  1 +
 arch/arm/kernel/machine_kexec.c           |  1 +
 arch/arm/mm/pageattr.c                    |  1 +
 arch/arm/net/bpf_jit_32.c                 |  1 +
 arch/arm64/include/asm/Kbuild             |  1 +
 arch/arm64/include/asm/cacheflush.h       |  5 --
 arch/arm64/mm/pageattr.c                  |  1 +
 arch/arm64/net/bpf_jit_comp.c             |  1 +
 arch/s390/include/asm/Kbuild              |  1 +
 arch/s390/include/asm/cacheflush.h        | 34 ------------
 arch/s390/include/asm/set_memory.h        | 31 +++++++++++
 arch/s390/kernel/ftrace.c                 |  1 +
 arch/s390/kernel/kprobes.c                |  2 +-
 arch/s390/kernel/machine_kexec.c          |  1 +
 arch/s390/mm/init.c                       |  1 +
 arch/s390/mm/pageattr.c                   |  1 +
 arch/s390/mm/vmem.c                       |  1 +
 arch/s390/net/bpf_jit_comp.c              |  1 +
 arch/x86/include/asm/cacheflush.h         | 85 ------------------------------
 arch/x86/include/asm/set_memory.h         | 87 +++++++++++++++++++++++++++++++
 arch/x86/kernel/amd_gart_64.c             |  2 +-
 arch/x86/kernel/cpu/amd.c                 |  2 +-
 arch/x86/kernel/cpu/bugs.c                |  2 +-
 arch/x86/kernel/ftrace.c                  |  2 +-
 arch/x86/kernel/machine_kexec_32.c        |  2 +-
 arch/x86/kernel/machine_kexec_64.c        |  1 +
 arch/x86/mm/init.c                        |  2 +-
 arch/x86/mm/init_32.c                     |  2 +-
 arch/x86/mm/init_64.c                     |  2 +-
 arch/x86/mm/ioremap.c                     |  2 +-
 arch/x86/mm/pageattr.c                    |  1 +
 arch/x86/net/bpf_jit_comp.c               |  1 +
 arch/x86/pci/pcbios.c                     |  2 +-
 arch/x86/platform/efi/efi.c               |  2 +-
 arch/x86/realmode/init.c                  |  2 +-
 drivers/char/agp/amd-k7-agp.c             |  1 +
 drivers/char/agp/ati-agp.c                |  1 +
 drivers/char/agp/generic.                 |  0
 drivers/char/agp/generic.c                |  4 +-
 drivers/char/agp/intel-gtt.c              |  1 +
 drivers/char/agp/sworks-agp.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c  |  3 ++
 drivers/gpu/drm/gma500/gtt.c              |  1 +
 drivers/gpu/drm/gma500/psb_drv.c          |  1 +
 drivers/gpu/drm/radeon/radeon_gart.c      |  3 ++
 drivers/gpu/drm/ttm/ttm_page_alloc.c      |  3 ++
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c  |  3 ++
 drivers/gpu/drm/ttm/ttm_tt.c              |  3 ++
 drivers/hwtracing/intel_th/msu.c          |  4 +-
 drivers/misc/sram-exec.c                  |  3 +-
 drivers/video/fbdev/vermilion/vermilion.c |  2 +-
 drivers/watchdog/hpwdt.c                  |  2 +-
 include/asm-generic/set_memory.h          | 12 +++++
 include/linux/filter.h                    |  4 +-
 kernel/module.c                           |  3 ++
 kernel/power/snapshot.c                   |  3 ++
 sound/pci/hda/hda_intel.c                 |  2 +-
 sound/pci/intel8x0.c                      |  4 +-
 sound/x86/intel_hdmi_audio.c              |  2 +-
 61 files changed, 237 insertions(+), 166 deletions(-)
 create mode 100644 arch/arm/include/asm/set_memory.h
 delete mode 100644 arch/s390/include/asm/cacheflush.h
 create mode 100644 arch/s390/include/asm/set_memory.h
 create mode 100644 arch/x86/include/asm/set_memory.h
 create mode 100644 drivers/char/agp/generic.
 create mode 100644 include/asm-generic/set_memory.h

-- 
2.7.4
