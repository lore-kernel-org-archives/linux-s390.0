From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [RFC 0/9] zfcp: decouple scsi_eh callbacks from scsi_cmnd
Date: Tue, 25 Jul 2017 16:14:18 +0200
Message-ID: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Cc: linux-s390@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an early request for comments.
The patch set serves as a zfcp preparation step for Hannes' series
"[PATCH 00/47] SCSI EH argument reshuffle part II"
http://www.spinics.net/lists/linux-scsi/msg111165.html
or
http://marc.info/?l=linux-scsi&m=150091945302995&w=2

The series is based on 18 preceding zfcp patches,
including some stable regression bugfixes for zfcp tracing.
Hence it might not apply cleanly.
However, we plan to post the 18 preceding patches soon for integration
and I would like to get those in first.

Please do not apply to any tree that will merge into upstream yet,
as it's not ready for prime time.
It only builds (after each patch; sparse and checkpatch clean)
but it has not seen any function testing yet.

There are still some open questions:
* Search victim scsi_device in target_reset_handler just to get a LUN?
  (Even if we do, zfcp_fsf_fcp_handler_common() should not print that LUN!)
  http://www.spinics.net/lists/linux-scsi/msg111164.html
  http://www.spinics.net/lists/linux-scsi/msg111166.html
* Exact rport blocking logic in host_reset_handler.
  http://www.spinics.net/lists/linux-scsi/msg111165.html


Steffen Maier (9):
  zfcp: drop unsuitable scsi_cmnd usage from SCSI traces for scsi_eh /
    TMF
  zfcp: decouple TMF response handler from scsi_cmnd
  zfcp: split FCP_CMND IU setup between SCSI I/O and TMF again
  zfcp: decouple FSF request setup of TMF from scsi_cmnd
  zfcp: decouple SCSI setup of TMF from scsi_cmnd
  scsi: fc: start decoupling fc_block_scsi_eh from scsi_cmnd
  zfcp: use fc_block_rport for TMFs and host reset to decouple from
    scsi_cmnd
  zfcp: fix waiting for rport(s) unblock in eh_host_reset_handler
  zfcp: decouple our scsi_eh callbacks from scsi_cmnd

 drivers/s390/scsi/zfcp_dbf.c     |  51 ++++++++++++-------
 drivers/s390/scsi/zfcp_dbf.h     |  26 +++++++---
 drivers/s390/scsi/zfcp_ext.h     |  12 +++--
 drivers/s390/scsi/zfcp_fc.h      |  24 ++++++---
 drivers/s390/scsi/zfcp_fsf.c     | 106 +++++++++++++++++++++++++--------------
 drivers/s390/scsi/zfcp_scsi.c    | 105 +++++++++++++++++++++++++++++---------
 drivers/scsi/scsi_transport_fc.c |  31 ++++++++++--
 include/scsi/scsi_transport_fc.h |   1 +
 8 files changed, 252 insertions(+), 104 deletions(-)

-- 
2.11.2
