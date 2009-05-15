From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: [patch 0/9] zfcp updates for 2.6.31
Date: Fri, 15 May 2009 13:18:13 +0200
Message-ID: <20090515111813.314177000@de.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

James,

this is the series of zfcp patches for the 2.6.31 merge window. My
plan was to resubmit the zfcp FC pass-through patch to fix the small
issues found during review on linux-scsi. Now that the patch has
already been included in scsi-misc, i put the changes in a new patch.
I assume this is the simpler approach.

The patches apply on the current scsi-misc tree.

--
Christof Schmitt
