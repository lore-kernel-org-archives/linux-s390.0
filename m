From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH 00/10] zfcp fixes
Date: Wed, 10 Aug 2016 18:30:43 +0200
Message-ID: <1470846653-90691-1-git-send-email-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi all,

here is a series of zfcp fixes all marked for stable.
They apply to the fixes branch of James' scsi.git or to v4.8-rc1.
Patches 1-3 are important functional bugfixes.
Patches 4-10 are serviceability regression fixes.

Steffen Maier (10):
  zfcp: fix fc_host port_type with NPIV
  zfcp: fix ELS/GS request&response length for hardware data router
  zfcp: close window with unblocked rport during rport gone
  zfcp: retain trace level for SCSI and HBA FSF response records
  zfcp: restore: Dont use 0 to indicate invalid LUN in rec trace
  zfcp: trace on request for open and close of WKA port
  zfcp: restore tracing of handle for port and LUN with HBA records
  zfcp: fix D_ID field with actual value on tracing SAN responses
  zfcp: fix payload trace length for SAN request&response
  zfcp: trace full payload of all SAN records (req,resp,iels)

 drivers/s390/scsi/zfcp_dbf.c  | 162 +++++++++++++++++++++++++++++++++++++-----
 drivers/s390/scsi/zfcp_dbf.h  |  14 +++-
 drivers/s390/scsi/zfcp_erp.c  |  12 +++-
 drivers/s390/scsi/zfcp_ext.h  |   8 ++-
 drivers/s390/scsi/zfcp_fsf.c  |  22 ++++--
 drivers/s390/scsi/zfcp_fsf.h  |   4 +-
 drivers/s390/scsi/zfcp_scsi.c |   8 ++-
 7 files changed, 196 insertions(+), 34 deletions(-)

-- 
2.6.6
