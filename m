From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 00/22] zfcp fixes and cleanups
Date: Fri, 28 Jul 2017 12:30:46 +0200
Message-ID: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.vnet.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi all,

here is a series of (important) fixes and some additional cleanups for the
zfcp driver. Our fixes are marked for stable accordingly.

Patches 01 - 04 are cleanups and external patches (also cleanups) that we
      & 13 - 22     had queued for quite some time now

Patches 05 - 12 are driver fixes that are all marked for stable as well

The set applies to the fixes branch of James' scsi.git.


                                                Beste Grüße / Best regards,
                                                  - Benjamin Block

Benjamin Block (2):
  zfcp: convert bool-definitions to use 'true' instead of '1'
  zfcp: add handling for FCP_RESID_OVER to the fcp ingress path

Corentin Labbe (1):
  zfcp: Remove unneeded linux/miscdevice.h include

LABBE Corentin (1):
  zfcp: replace zfcp_qdio_sbale_count by sg_nents

Lukáš Korenčik (1):
  zfcp: use setup_timer instead of init_timer

Martin Peschke (4):
  zfcp: clean up redundant code with fall through in link down SRB
    switch case
  zfcp: clean up a member of struct zfcp_qdio that was assigned but
    never used
  zfcp: clean up unnecessary module_param_named() with
    no_auto_port_rescan
  zfcp: early returns for traces disabled via level

Steffen Maier (13):
  zfcp: fix queuecommand for scsi_eh commands when DIX enabled
  zfcp: fix capping of unsuccessful GPN_FT SAN response trace records
  zfcp: fix passing fsf_req to SCSI trace on TMF to correlate with HBA
  zfcp: fix missing trace records for early returns in TMF eh handlers
  zfcp: fix payload with full FCP_RSP IU in SCSI trace records
  zfcp: trace HBA FSF response by default on dismiss or timedout late
    response
  zfcp: trace high part of "new" 64 bit SCSI LUN
  zfcp: more fitting constant for fc_ct_hdr.ct_reason on port scan
    response
  zfcp: clarify that we don't need "link" test on failed open port
  zfcp: use common code fcp_cmnd and fcp_resp with union in
    fsf_qtcb_bottom_io
  zfcp: use endianness conversions with common FC(P) struct fields
  zfcp: fix kernel doc comment typos for struct zfcp_dbf_scsi
  zfcp: clean up no longer existent prototype from zfcp API header

 drivers/s390/scsi/zfcp_aux.c  |  1 -
 drivers/s390/scsi/zfcp_dbf.c  | 95 +++++++++++++++++++++++++++++++++++--------
 drivers/s390/scsi/zfcp_dbf.h  | 25 ++++++++----
 drivers/s390/scsi/zfcp_erp.c  |  5 +--
 drivers/s390/scsi/zfcp_ext.h  |  1 -
 drivers/s390/scsi/zfcp_fc.c   | 52 +++++++++++------------
 drivers/s390/scsi/zfcp_fc.h   | 25 ++++++++----
 drivers/s390/scsi/zfcp_fsf.c  | 35 ++++++++--------
 drivers/s390/scsi/zfcp_fsf.h  | 12 ++++--
 drivers/s390/scsi/zfcp_qdio.c |  2 +-
 drivers/s390/scsi/zfcp_qdio.h | 17 --------
 drivers/s390/scsi/zfcp_scsi.c | 18 ++++----
 12 files changed, 178 insertions(+), 110 deletions(-)

--
2.11.2
