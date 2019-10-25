Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728051AbfJYQNB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 12:13:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PG8xrq043063
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vv1xnx40c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Fri, 25 Oct 2019 17:12:59 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 00/11] zfcp: retrieve local RDP data, fix and cleanup
Date: Fri, 25 Oct 2019 18:12:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <cover.1571934247.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

Hello all,

this is the second version of my RDP patchset for zfcp, after I noticed
a memory-leak in the first version earlier this year. Here is the
original description, which remains valid:

    With FC-LS-3 Fibre Channel got support for the RDP Extended Link
    Service, which we can use to gather diagnostics data (health values
    from the optics and such). To gather those data from our local link,
    the FCP Channel firmware (for FCP and Ficon Express adapters) added
    some new fields in our Exchange Port Data firmware command
    (primarily SFP data).
        This patchset adds a new sysfs-directory below our
    adapter-object and several files in that to read those new fields.
        Additionally this also adds a file to read the buffer-to-buffer
    credit value from our local port (also something that can be
    gathered using the RDP ELS).
    
    The main purpose of the data from RDP requests (at least in my mind)
    are to catch some otherwise hard to track down errors, like dirt on
    the fibre and such (I would expect optics data to degraded with such
    conditions). These things are a pain to track down because it
    doesn't cause the link to go away, just some sporadic errors that
    can result in incomplete exchanges and such.
    
    The patchset is somewhat big because I don't want to issue a single
    Exchange Port/Config Data command for each read of those files,
    which would generate unnecessary traffic (and possibly inconsistent
    data) on our command-queue (we don't have an admin-queue or some
    such). So it also adds a (time-based) mechanism to cache data from
    Exchange Config/Port Data.
        We also want to prevent our adapter-structure from growing,
    which would further grow Scsi_Host, which is already too damn big,
    so these data are decoupled.
    
    More details are in the patches themselves.

Additionally to this, there are two more patches from Steffen that we
want to include, the first (patch 10) is just a cleanup for better
readability, the second (patch 11) is a fix/improvement for our
tracing-feature to make traces of failed FCP requests better. Even
though Steffen flagged the later as fix, I don't think we need extra
handling for it, if it goes in with the rest, thats fine - its nothing
pressing.

Reviews are highly welcome :-).

James, Martin, if there are no objections, it would be nice if you could
still include this in the merge for 5.5.

FYI: I also plan to/am in the middle of writing a simple command-line
     tool to send RDP to all/certain available remote/local FC-Ports in
     the System and present them in a sane format (sane to me ;-) ).
     This could be used for logging, or while gathering debug-data from
     a system.

     The RDP ELS' to remote ports will be send using BSG. Local data
     (for zFCP) would be read using this new interface.

     If anyone is interested, I can point it out on the list once I have
     something that has at least a minimum set of functionality.

Benjamin Block (9):
  zfcp: signal incomplete or error for sync exchange config/port data
  zfcp: diagnostics buffer caching and use for exchange port data
  zfcp: add diagnostics buffer for exchange config data
  zfcp: support retrieval of SFP Data via Exchange Port Data
  zfcp: introduce SysFS interface for diagnostics of local SFP
    transceiver
  zfcp: implicitly refresh port-data diagnostics when reading SysFS
  zfcp: introduce SysFS interface to read the local B2B-Credit
  zfcp: implicitly refresh config-data diagnostics when reading SysFS
  zfcp: move maximum age of diagnostic buffers into a per-adapter
    variable

Steffen Maier (2):
  zfcp: proper indentation to reduce confusion in zfcp_erp_required_act
  zfcp: trace channel log even for FCP command responses

 drivers/s390/scsi/Makefile     |   2 +-
 drivers/s390/scsi/zfcp_aux.c   |  12 +-
 drivers/s390/scsi/zfcp_dbf.c   |   8 +-
 drivers/s390/scsi/zfcp_def.h   |   4 +-
 drivers/s390/scsi/zfcp_diag.c  | 305 +++++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_diag.h  | 101 +++++++++++
 drivers/s390/scsi/zfcp_erp.c   |   4 +-
 drivers/s390/scsi/zfcp_ext.h   |   1 +
 drivers/s390/scsi/zfcp_fsf.c   |  73 +++++++-
 drivers/s390/scsi/zfcp_fsf.h   |  21 ++-
 drivers/s390/scsi/zfcp_scsi.c  |   4 +-
 drivers/s390/scsi/zfcp_sysfs.c | 170 +++++++++++++++++-
 12 files changed, 683 insertions(+), 22 deletions(-)
 create mode 100644 drivers/s390/scsi/zfcp_diag.c
 create mode 100644 drivers/s390/scsi/zfcp_diag.h

-- 
2.21.0
