Return-Path: <linux-kernel-owner+w=401wt.eu-S1756295AbXGQMTw@vger.kernel.org>
Message-Id: <20070717121747.591687140@de.ibm.com>
Date: Tue, 17 Jul 2007 14:17:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/8] s390 update.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The second s390 patchset for 2.6.23. This one contains bug fixes as
usual and one new feature: the z/VM unit record device driver (vmur).
This driver allows to access the virtual reader, punch and printer
when running under z/VM. This is useful, e.g. to access the spool
file containing a dump of the system generated with vmdump, or to
set up a bootable system in the reader.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
