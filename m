Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/8] constify s390 attribute_group structures
Date: Wed, 19 Jul 2017 12:39:09 +0530
Message-Id: <1500448157-24668-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, freude@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, wi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, jwi@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

Arvind Yadav (9):
  s390: zcrypt_queue: constify attribute_group structures.
  s390: zcrypt_card: constify attribute_group structures.
  s390: dasd_devmap: constify attribute_group structures.
  s390: device: constify attribute_group structures.
  s390: qeth: constify attribute_group structures.
  s390: raw3270: constify attribute_group structures.
  s390: tape_core: constify attribute_group structures.
  s390: sclp_ocf: constify attribute_group structures.

 drivers/s390/block/dasd_devmap.c   | 2 +-
 drivers/s390/char/raw3270.c        | 2 +-
 drivers/s390/char/sclp_ocf.c       | 2 +-
 drivers/s390/char/tape_core.c      | 2 +-
 drivers/s390/cio/device.c          | 4 ++--
 drivers/s390/crypto/zcrypt_card.c  | 2 +-
 drivers/s390/crypto/zcrypt_queue.c | 2 +-
 drivers/s390/net/qeth_l3_sys.c     | 8 ++++----
 8 files changed, 12 insertions(+), 12 deletions(-)

-- 
1.9.1
