From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/4] add NULL test
Date: Sun, 20 Dec 2015 12:15:49 +0100
Message-ID: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
To: linux-s390@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add NULL tests on various calls to kzalloc and devm_kzalloc.

The semantic match that finds these problems is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y;
identifier fld;
@@

(
x = \(vmalloc\|kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|krealloc\|
        kmemdup\|kstrdup\|
	devm_kzalloc\|devm_kmalloc\|devm_kcalloc\|devm_kasprintf\|
	kmalloc_array\)(...,<+... __GFP_NOFAIL ...+>,...);
|
* x = \(vmalloc\|kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|krealloc\|
        kmemdup\|kstrdup\|
	devm_kzalloc\|devm_kmalloc\|devm_kcalloc\|devm_kasprintf\|
	kmalloc_array\)(...);
)
  ... when != (x) == NULL
      when != (x) != NULL
      when != (x) == 0
      when != (x) != 0
      when != x = y
(
  x->fld
|
  *x
|
  x[...]
)
// </smpl>

---

 drivers/s390/char/con3215.c                 |    2 ++
 drivers/s390/char/raw3270.c                 |    2 ++
 sound/soc/fsl/imx-pcm-dma.c                 |    2 ++
 sound/soc/intel/baytrail/sst-baytrail-pcm.c |    2 ++
 sound/soc/omap/omap-hdmi-audio.c            |    2 ++
 5 files changed, 10 insertions(+)
