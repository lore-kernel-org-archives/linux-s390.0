Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 00/11 linux-next] drivers: remove unnecessary version.h inclusion
Date: Mon, 29 Dec 2014 15:29:34 +0100
Message-Id: <1419863387-24233-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, openipmi-developer@lists.sourceforge.net, linux-input@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This small patchset removes unnecessary version.h includes detected by
versioncheck in drivers branch.

Fabian Frederick (11):
  rsxx: remove unnecessary version.h inclusion
  skd: remove unnecessary version.h inclusion
  ipmi: remove unnecessary version.h inclusion
  input: remove unnecessary version.h inclusion
  [media] tw68: remove unnecessary version.h inclusion
  [media] s5p-g2d: remove unnecessary version.h inclusion
  [media] s5p-mfc: remove unnecessary version.h inclusion
  [media] vivid: remove unnecessary version.h inclusion
  [media] uvcvideo: remove unnecessary version.h inclusion
  GenWQE: remove unnecessary version.h inclusion
  s390/hmcdrv: remove unnecessary version.h inclusion

 drivers/block/rsxx/rsxx_priv.h               | 1 -
 drivers/block/skd_main.c                     | 1 -
 drivers/char/ipmi/ipmi_ssif.c                | 1 -
 drivers/input/touchscreen/elants_i2c.c       | 2 --
 drivers/media/pci/tw68/tw68.h                | 1 -
 drivers/media/platform/s5p-g2d/g2d.c         | 1 -
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 1 -
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 1 -
 drivers/media/platform/vivid/vivid-tpg.h     | 1 -
 drivers/media/usb/uvc/uvc_v4l2.c             | 1 -
 drivers/misc/genwqe/card_base.h              | 1 -
 drivers/misc/genwqe/card_sysfs.c             | 1 -
 drivers/s390/char/hmcdrv_mod.c               | 1 -
 13 files changed, 14 deletions(-)

-- 
2.1.0
