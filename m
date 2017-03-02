Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv2 07/14] drm: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:14:59 -0800
Message-ID: <1488413706-9739-8-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170302001459.NWQAqC7KEQqYvk_dbySHuSpOypnpDe74qE9Cx1qdi8Y@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Airlie <airlied@linux.ie>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 1 +
 drivers/gpu/drm/gma500/gtt.c             | 1 +
 drivers/gpu/drm/gma500/psb_drv.c         | 1 +
 drivers/gpu/drm/radeon/radeon_gart.c     | 1 +
 drivers/gpu/drm/ttm/ttm_page_alloc.c     | 1 +
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 1 +
 drivers/gpu/drm/ttm/ttm_tt.c             | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 964d2a94..2479ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -27,6 +27,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/amdgpu_drm.h>
+#include <asm/set_memory.h>
 #include "amdgpu.h"
 
 /*
diff --git a/drivers/gpu/drm/gma500/gtt.c b/drivers/gpu/drm/gma500/gtt.c
index 3f4f424..3949b09 100644
--- a/drivers/gpu/drm/gma500/gtt.c
+++ b/drivers/gpu/drm/gma500/gtt.c
@@ -21,6 +21,7 @@
 
 #include <drm/drmP.h>
 #include <linux/shmem_fs.h>
+#include <asm/set_memory.h>
 #include "psb_drv.h"
 #include "blitter.h"
 
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 5ee93ff..1f9b35a 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include <acpi/video.h>
 #include <linux/module.h>
+#include <asm/set_memory.h>
 
 static struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index c4777c8..dcf8042 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -27,6 +27,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/radeon_drm.h>
+#include <asm/set_memory.h>
 #include "radeon.h"
 
 /*
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index a37de5d..04d8b43 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -51,6 +51,7 @@
 #if IS_ENABLED(CONFIG_AGP)
 #include <asm/agp.h>
 #endif
+#include <asm/set_memory.h>
 
 #define NUM_PAGES_TO_ALLOC		(PAGE_SIZE/sizeof(struct page *))
 #define SMALL_ALLOCATION		16
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index cec4b4b..d6e4cb7 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -53,6 +53,7 @@
 #if IS_ENABLED(CONFIG_AGP)
 #include <asm/agp.h>
 #endif
+#include <asm/set_memory.h>
 
 #define NUM_PAGES_TO_ALLOC		(PAGE_SIZE/sizeof(struct page *))
 #define SMALL_ALLOCATION		4
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index aee3c00..668ae6f 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -44,6 +44,7 @@
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
 #include <drm/ttm/ttm_page_alloc.h>
+#include <asm/set_memory.h>
 
 /**
  * Allocates storage for pointers to the pages that back the ttm.
-- 
2.7.4
