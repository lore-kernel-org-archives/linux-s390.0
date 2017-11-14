Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/9] drivers/s390/ license text cleanup
Date: Tue, 14 Nov 2017 18:37:59 +0100
Message-Id: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Harald Freudenberger <freude@de.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi all,

Here are 9 patches against linux-next of today that add SPDX identifiers
to the remaining files that do not currently have them, and then it
cleans up the various different ways that the license text boilerplate
was written for the GPLv2 in a few files.  This cleanup was done in the
quest to remove the 700+ different ways the kernel describes GPLv2.

No copyright headers or any other non-license-description text was
removed in these patches.

FWIW, this license cleanup action has been "blessed" by IBM lawyers, but
feel free to check internally if you are curious.

Greg Kroah-Hartman (9):
  s390: block: add SPDX identifiers to the remaining files
  s390: crypto: add SPDX identifiers to the remaining files
  s390: cio: add SPDX identifiers to the remaining files
  s390: char: add SPDX identifiers to the remaining files
  s390: net: add SPDX identifiers to the remaining files
  s390: scsi: zfcp_aux: add SPDX identifier
  s390: virtio: add SPDX identifiers to the remaining files
  s390: crypto: Remove redundant license text
  s390: drivers: Remove redundant license text

 drivers/s390/block/dasd.c              |  1 +
 drivers/s390/block/dasd_devmap.c       |  1 +
 drivers/s390/block/dasd_diag.c         |  1 +
 drivers/s390/block/dasd_eckd.c         |  1 +
 drivers/s390/block/dasd_fba.c          |  1 +
 drivers/s390/block/dcssblk.c           |  1 +
 drivers/s390/block/scm_blk.c           |  1 +
 drivers/s390/block/xpram.c             |  1 +
 drivers/s390/char/fs3270.c             |  1 +
 drivers/s390/char/hmcdrv_mod.c         |  1 +
 drivers/s390/char/monreader.c          |  1 +
 drivers/s390/char/monwriter.c          |  1 +
 drivers/s390/char/raw3270.c            |  1 +
 drivers/s390/char/sclp_async.c         |  1 +
 drivers/s390/char/tape_34xx.c          |  1 +
 drivers/s390/char/tape_3590.c          |  1 +
 drivers/s390/char/tape_class.c         |  1 +
 drivers/s390/char/tape_core.c          |  1 +
 drivers/s390/char/tty3270.c            |  1 +
 drivers/s390/char/vmlogrdr.c           |  1 +
 drivers/s390/char/vmur.c               |  1 +
 drivers/s390/char/zcore.c              |  2 +-
 drivers/s390/cio/ccwgroup.c            |  1 +
 drivers/s390/cio/chp.c                 |  1 +
 drivers/s390/cio/chsc.c                |  1 +
 drivers/s390/cio/chsc_sch.c            |  1 +
 drivers/s390/cio/cio.c                 |  1 +
 drivers/s390/cio/cmf.c                 | 15 +--------------
 drivers/s390/cio/css.c                 |  3 +--
 drivers/s390/cio/device.c              |  3 +--
 drivers/s390/cio/device_fsm.c          |  1 +
 drivers/s390/cio/device_ops.c          |  3 +--
 drivers/s390/cio/eadm_sch.c            |  1 +
 drivers/s390/cio/isc.c                 |  1 +
 drivers/s390/cio/qdio_main.c           |  1 +
 drivers/s390/cio/qdio_setup.c          |  1 +
 drivers/s390/cio/scm.c                 |  1 +
 drivers/s390/cio/vfio_ccw_drv.c        |  1 +
 drivers/s390/crypto/ap_bus.c           | 15 +--------------
 drivers/s390/crypto/ap_bus.h           | 15 +--------------
 drivers/s390/crypto/pkey_api.c         |  6 +-----
 drivers/s390/crypto/zcrypt_api.c       | 15 +--------------
 drivers/s390/crypto/zcrypt_api.h       | 15 +--------------
 drivers/s390/crypto/zcrypt_card.c      | 11 +----------
 drivers/s390/crypto/zcrypt_cca_key.h   | 15 +--------------
 drivers/s390/crypto/zcrypt_cex2a.c     | 15 +--------------
 drivers/s390/crypto/zcrypt_cex2a.h     | 15 +--------------
 drivers/s390/crypto/zcrypt_cex4.c      |  1 +
 drivers/s390/crypto/zcrypt_error.h     | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype50.c | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype50.h | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype6.c  | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype6.h  | 15 +--------------
 drivers/s390/crypto/zcrypt_pcixcc.c    | 15 +--------------
 drivers/s390/crypto/zcrypt_pcixcc.h    | 15 +--------------
 drivers/s390/crypto/zcrypt_queue.c     | 11 +----------
 drivers/s390/net/ctcm_main.c           |  1 +
 drivers/s390/net/fsm.c                 |  1 +
 drivers/s390/net/lcs.c                 | 15 +--------------
 drivers/s390/net/netiucv.c             | 16 +---------------
 drivers/s390/net/qeth_core_main.c      |  1 +
 drivers/s390/net/qeth_core_sys.c       |  1 +
 drivers/s390/net/qeth_l2_main.c        |  1 +
 drivers/s390/net/qeth_l3_main.c        |  1 +
 drivers/s390/net/smsgiucv.c            | 15 +--------------
 drivers/s390/net/smsgiucv_app.c        |  1 +
 drivers/s390/scsi/zfcp_aux.c           |  1 +
 drivers/s390/virtio/Makefile           |  5 +----
 drivers/s390/virtio/virtio_ccw.c       |  5 +----
 69 files changed, 69 insertions(+), 293 deletions(-)

-- 
2.15.0
