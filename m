Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbgCLSUO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 14:20:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CIJJNP051078
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 14:20:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqt8s81sc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 14:20:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 12 Mar 2020 17:45:17 -0000
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 00/10] zfcp features for v5.7
Date: Thu, 12 Mar 2020 18:44:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20200312174505.51294-1-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>

Martin, James,

one small zfcp fix and 2 features for v5.7.
Patches apply to Martin's 5.7/scsi-queue or James' misc branch.

Patch 1 is a small preventive fix with locking for point-to-point.

Patches 2..4 is a feature to expose fabric_name in fc_host sysfs.

Patches 5..8 is a feature to provide user information on the state of
the otherwise transparent IBM Fibre Channel Endpoint Security.
Patches 9..10 is a feature to add new recovery and corresponding
kernel messages related to IBM Fibre Channel Endpoint Security.
[http://www.redbooks.ibm.com/redpieces/abstracts/sg248455.html?Open]


Jens Remus (6):
  zfcp: auto variables for dereferenced structs in open port handler
  zfcp: report FC Endpoint Security in sysfs
  zfcp: log FC Endpoint Security of connections
  zfcp: trace FC Endpoint Security of FCP devices and connections
  zfcp: enhance handling of FC Endpoint Security errors
  zfcp: log FC Endpoint Security errors

Steffen Maier (4):
  zfcp: fix missing erp_lock in port recovery trigger for point-to-point
  zfcp: expose fabric name as common fc_host sysfs attribute
  zfcp: wire previously driver-specific sysfs attributes also to fc_host
  zfcp: fix fc_host attributes that should be unknown on local link down

 drivers/s390/scsi/zfcp_dbf.c   |  44 ++++-
 drivers/s390/scsi/zfcp_dbf.h   |  32 +++-
 drivers/s390/scsi/zfcp_def.h   |   6 +-
 drivers/s390/scsi/zfcp_erp.c   |   2 +-
 drivers/s390/scsi/zfcp_ext.h   |  12 +-
 drivers/s390/scsi/zfcp_fsf.c   | 290 ++++++++++++++++++++++++++++++---
 drivers/s390/scsi/zfcp_fsf.h   |  23 ++-
 drivers/s390/scsi/zfcp_scsi.c  |   5 +
 drivers/s390/scsi/zfcp_sysfs.c |  70 +++++++-
 9 files changed, 449 insertions(+), 35 deletions(-)

-- 
2.17.1
