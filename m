Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [RFT 00/13] constify s390 ccw_device_id
Date: Tue, 15 Aug 2017 16:05:31 +0530
Message-Id: <1502793344-5368-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com, jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, maier@linux.vnet.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

ccw_device_id are not supposed to change at runtime. All functions
working with ccw_device_id provided by <asm/ccwdev.h> work with
const ccw_device_id. So mark ccw_device_id member of struct ccw driver
as const. And change all driver relatively.

Arvind Yadav (13):
  [RFT 01/13] s390: ccwdev: constify ccw_device_id
  [RFT 02/13] s390: dasd_eckd: constify ccw_device_id
  [RFT 03/13] s390: dasd_fba: constify ccw_device_id
  [RFT 04/13] s390: con3215: constify ccw_device_id
  [RFT 05/13] s390: raw3270: constify ccw_device_id
  [RFT 06/13] s390: tape_34xx: constify ccw_device_id
  [RFT 07/13] s390: tape_3590: constify ccw_device_id
  [RFT 08/13] s390: vmur: constify ccw_device_id
  [RFT 09/13] s390: ctcm: constify ccw_device_id
  [RFT 10/13] s390: lcs: constify ccw_device_id
  [RFT 11/13] s390: qeth: constify ccw_device_id
  [RFT 12/13] s390: zfcp: constify ccw_device_id
  [RFT 13/13] s390: virtio: constify ccw_device_id

 arch/s390/include/asm/ccwdev.h    | 2 +-
 drivers/s390/block/dasd_eckd.c    | 2 +-
 drivers/s390/block/dasd_fba.c     | 2 +-
 drivers/s390/char/con3215.c       | 2 +-
 drivers/s390/char/raw3270.c       | 2 +-
 drivers/s390/char/tape_34xx.c     | 2 +-
 drivers/s390/char/tape_3590.c     | 2 +-
 drivers/s390/char/vmur.c          | 2 +-
 drivers/s390/net/ctcm_main.c      | 2 +-
 drivers/s390/net/lcs.c            | 2 +-
 drivers/s390/net/qeth_core_main.c | 2 +-
 drivers/s390/scsi/zfcp_ccw.c      | 2 +-
 drivers/s390/virtio/virtio_ccw.c  | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.7.4
