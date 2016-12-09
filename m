From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH 0/3] zfcp fixes
Date: Fri,  9 Dec 2016 17:16:30 +0100
Message-ID: <20161209161633.72445-1-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi all,

here is a series of important zfcp fixes all marked for stable.
They apply to the fixes branch of James' scsi.git or to v4.9-rc8.

Patch 1 is the most important one since it fixes a panic
that can occur under certain circumstances.

Benjamin Block (1):
  zfcp: fix use-after-"free" in FC ingress path after TMF

Steffen Maier (2):
  zfcp: do not trace pure benign residual HBA responses at default level
  zfcp: fix rport unblock race with LUN recovery

 drivers/s390/scsi/zfcp_dbf.c     | 17 +++++++++--
 drivers/s390/scsi/zfcp_dbf.h     | 41 +++++++++++++++++++++++++--
 drivers/s390/scsi/zfcp_erp.c     | 61 ++++++++++++++++++++++++++++++++++++++--
 drivers/s390/scsi/zfcp_ext.h     |  4 ++-
 drivers/s390/scsi/zfcp_fsf.h     |  3 +-
 drivers/s390/scsi/zfcp_reqlist.h | 30 +++++++++++++++++++-
 drivers/s390/scsi/zfcp_scsi.c    | 61 ++++++++++++++++++++++++++++++++++++----
 7 files changed, 202 insertions(+), 15 deletions(-)

-- 
2.8.4
