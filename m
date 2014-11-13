From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH 0/3] zfcp features for 3.19
Date: Thu, 13 Nov 2014 14:59:45 +0100
Message-ID: <1415887188-40233-1-git-send-email-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

James,

Here is a series of zfcp features for the upcoming merge window
preparing kernel v3.19.
The patches apply on top of the current misc branch of your scsi.git.

Steffen

Linux on System z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

Martin Peschke (2):
  zfcp: remove access control tables interface (port leftovers)
  zfcp: auto port scan resiliency

Steffen Maier (1):
  zfcp: bring back unit sysfs attributes for automatic LUN scan

 drivers/s390/scsi/zfcp_aux.c   |  6 ++--
 drivers/s390/scsi/zfcp_ccw.c   | 32 ++++++++++++++++----
 drivers/s390/scsi/zfcp_def.h   |  3 +-
 drivers/s390/scsi/zfcp_erp.c   |  7 -----
 drivers/s390/scsi/zfcp_ext.h   |  1 +
 drivers/s390/scsi/zfcp_fc.c    | 52 +++++++++++++++++++++++++++++++--
 drivers/s390/scsi/zfcp_fsf.c   |  3 +-
 drivers/s390/scsi/zfcp_sysfs.c | 66 ++++++++++++++++++++++++++++++++++++------
 8 files changed, 141 insertions(+), 29 deletions(-)

-- 
1.8.5.5
