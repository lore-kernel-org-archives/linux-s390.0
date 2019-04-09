From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:43 +0000
Subject: [PATCH 00/10] zfcp: support retrieval of local RDP data
Message-Id: <cover.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello all,

with FC-LS-3 Fibre Channel got support for the RDP Extended Link
Service, which we can use to gather diagnostics data (health values from
the optics and such). To gather those data from our local link, the FCP
Channel firmware added some new fields in our Exchange Port Data
firmware command (primarily SFP data).
    This patchset adds a new sysfs-directory below our adapter-object
and several files in that to read those new fields.
    Additionally this also adds a file to read the buffer-to-buffer
credit value from our local port (also something that can be gathered
using the RDP ELS).

The main purpose of the data from RDP requests (at least in my mind) are
to catch some otherwise hard to track down errors, like dirt on the
fibre and such (I would expect optics data to degraded with such
conditions). These things are a pain to track down because it doesn't
cause the link to go away, just some sporadic errors that can result in
incomplete exchanges and such.

The patchset is somewhat big because I don't want to issue a single
Exchange Port/Config Data command for each read of those files, which
would generate unnecessary traffic (and possibly inconsistent data) on
our command-queue (we don't have an admin-queue or some such). So it
also adds a (time-based) mechanism to cache data from Exchange
Config/Port Data.
    We also want to prevent our adapter-structure from growing, which
would further grow Scsi_Host, which is already too damn big, so these
data are decoupled.

More details are in the patches themselves.

If there are no objections, It would be nice to consider this for 5.2.

FYI: I also plan to/am in the middle of writing a simple command-line
     tool to send RDP to all/certain available remote/local FC-Ports in
     the System and present them in a sane format (sane to me ;-) ).
     This could be used for logging, or while gathering debug-data from
     a system.

     The RDP ELS' to remote ports will be send using BSG. Local data
     (for zFCP) would be read using this new interface).

     If anyone is interested, I can point it out on the list once I have
     something that has at least a minimum set of functionality.

Benjamin Block (10):
  zfcp: signal incomplete or error for sync exchange config/port data
  zfcp: remove option to pass NULL to sync exchange config/port data
  zfcp: diagnostics buffer caching and use for exchange port data
  zfcp: add diagnostics buffer for exchange config data
  zfcp: support retrieval of SFP Data via Exchange Port Data
  zfcp: introduce SysFS interface for diagnostics of local SFP
    transceiver
  zfcp: implicitly refresh port-data diagnostics when reading SysFS
  zfcp: move maximum age of diagnostic buffers into a module-parameter
  zfcp: introduce SysFS interface to read the local B2B-Credit
  zfcp: implicitly refresh config-data diagnostics when reading SysFS

 drivers/s390/scsi/Makefile     |   2 +-
 drivers/s390/scsi/zfcp_aux.c   |  12 +-
 drivers/s390/scsi/zfcp_def.h   |   4 +-
 drivers/s390/scsi/zfcp_diag.c  | 321 +++++++++++++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_diag.h  |  97 +++++++++++++
 drivers/s390/scsi/zfcp_ext.h   |   1 +
 drivers/s390/scsi/zfcp_fsf.c   |  87 +++++++++--
 drivers/s390/scsi/zfcp_fsf.h   |  21 ++-
 drivers/s390/scsi/zfcp_scsi.c  |   4 +-
 drivers/s390/scsi/zfcp_sysfs.c | 125 +++++++++++++++-
 10 files changed, 651 insertions(+), 23 deletions(-)
 create mode 100644 drivers/s390/scsi/zfcp_diag.c
 create mode 100644 drivers/s390/scsi/zfcp_diag.h

--
2.16.4
