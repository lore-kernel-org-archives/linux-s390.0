From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: [patch 00/22] zfcp patches for 2.6.33 merge window
Date: Tue, 24 Nov 2009 16:53:56 +0100
Message-ID: <20091124155356.135092000@de.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Here is the series of zfcp patches for the 2.6.33 merge window.

The first patch adds the target reset flag to the fc_fcp.h header file
to replace the private zfcp definition of this flag. The other zfcp
patches include:
 - rework locking and reference counting for zfcp structs
 - module unloading
 - use common code FC protocol definitions instead of private ones
 - minor updates and cleanup

--
Christof Schmitt
