From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: [patch 0/2] zfcp: Fabric and channel latencies from FCP adapter
Date: Tue, 06 May 2008 11:00:04 +0200
Message-ID: <20080506090004.922666000@de.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

These patches let zfcp track the fabric and channel latencies provided
by the FCP adapter. The first patch adds the infrastructure to
retrieve the data from each completed request and the second patch
adds the sysfs attributes to read the data from userspace.

The patches apply to scsi-misc.

Christof
