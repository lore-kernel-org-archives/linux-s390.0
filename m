From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: [patch 00/12] zfcp patches for 2.6.37 merge window
Date: Wed, 08 Sep 2010 14:39:49 +0200
Message-ID: <20100908123949.483410445@de.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

James,

here is the series of zfcp updates for the 2.6.37 merge window. The
patches apply on top of the scsi-misc tree. The first patch is the
same as the one submitted as fix for 2.6.36 here:
http://marc.info/?l=linux-scsi&m=128324031704285&w=2
The patch is required for the following patches to apply.

The main change is the restructuring of the LUN data structures and
related code. With this change, zfcp finally can make use of the
REPORT LUNs scan in the SCSI midlayer when using a NPIV subchannel.

--
Christof
