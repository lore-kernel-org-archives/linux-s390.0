Return-Path: <linux-kernel-owner+w=401wt.eu-S933887AbXCSNCi@vger.kernel.org>
Date: Mon, 19 Mar 2007 14:02:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] cio: allow 0 and 1 as input for channel path status attribute
Message-ID: <20070319130247.GE1292@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: peter.oberparleiter@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: allow 0 and 1 as input for channel path status attribute

Channel path status can now be modified by writing '0' and '1'
to the sysfs status attribute in addition to 'offline' and
'online' respectively.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2007-03-19 13:09:34.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2007-03-19 13:09:36.000000000 +0100
@@ -1169,9 +1169,9 @@ chp_status_write(struct device *dev, str
 	if (!num_args)
 		return count;
 
-	if (!strnicmp(cmd, "on", 2))
+	if (!strnicmp(cmd, "on", 2) || !strcmp(cmd, "1"))
 		error = s390_vary_chpid(cp->chpid, 1);
-	else if (!strnicmp(cmd, "off", 3))
+	else if (!strnicmp(cmd, "off", 3) || !strcmp(cmd, "0"))
 		error = s390_vary_chpid(cp->chpid, 0);
 	else
 		error = -EINVAL;
