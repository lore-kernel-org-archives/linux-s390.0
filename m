Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9768 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbgJ1VdK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:10 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 0/5] zfcp: cleanups, refactorings and features for 5.11
Date: Wed, 28 Oct 2020 19:30:47 +0100
Message-Id: <cover.1603908167.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

Hello James, Martin,

here is a series of changes for our zfcp driver for 5.11.

Other than 2 smaller cleanups and clarifications for maintainability we
have a refactoring of how zfcp uses s390's qdio layer, and we have a
small feature improving our handling of out-of-band version changes to our
adapters (or firmware).

Especially the refactoring ("zfcp: lift Input Queue tasklet from qdio")
would be nice to have, because we have other patches queued internally
that depend on this, and because qdio patches go via the s390 tree, this
creates a dependency for Heiko and Vasily.

As always, feedback and reviews are appreciated :-)

Julian Wiedmann (4):
  zfcp: lift Input Queue tasklet from qdio
  zfcp: clarify & assert the stat_lock locking in zfcp_qdio_send()
  zfcp: process Version Change events
  zfcp: handle event-lost notification for Version Change events

Vasily Gorbik (1):
  zfcp: remove orphaned function declarations

 drivers/s390/scsi/zfcp_aux.c  | 11 ++++++++
 drivers/s390/scsi/zfcp_def.h  |  1 +
 drivers/s390/scsi/zfcp_ext.h  |  2 --
 drivers/s390/scsi/zfcp_fsf.c  | 19 ++++++++++++++
 drivers/s390/scsi/zfcp_fsf.h  | 11 ++++++++
 drivers/s390/scsi/zfcp_qdio.c | 47 +++++++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_qdio.h |  2 ++
 7 files changed, 91 insertions(+), 2 deletions(-)

-- 
2.26.2
