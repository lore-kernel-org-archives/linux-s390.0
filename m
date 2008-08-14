Return-Path: <linux-kernel-owner+w=401wt.eu-S1759235AbYHNS1J@vger.kernel.org>
From: Ivan Warren <ivan@vmfacility.fr>
Subject: [PATCH] S390 : Set SLI on PSF/PRSSD on Dasd ECKD initialisation
Date: Thu, 14 Aug 2008 20:26:51 +0200
Message-Id: <1218738411-21828-1-git-send-email-ivan@vmfacility.fr>
In-Reply-To: <1218726426.25578.0.camel@localhost>
References: <1218726426.25578.0.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: elendil@planet.nl, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Warren <ivan@vmfacility.fr>
List-ID: <linux-s390.vger.kernel.org>

    s390 Dasd ECKD Driver issues a Perform Subsystem Function/Prepare
    for Read Subsystem Data with a length of 16.
    However, some hardware (namely 3990/9390 and some version of ESS)
    only take 12 bytes and therefore, an Incorrect Length indication is
    returned, breaking CCW Command Chaining and leads to a failure to
    initialize the DASD. This patch sets the SLI CCW bit to prevent an
    incorrect length indication to be reported when the control unit
    expects a length of 12 instead of 16.

Signed-off-by: Ivan Warren <ivan@vmfacility.fr>
---
 drivers/s390/block/dasd_eckd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 773b3fe..d644715 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -809,7 +809,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
-	ccw->flags |= CCW_FLAG_CC;
+	ccw->flags |= CCW_FLAG_CC|CCW_FLAG_SLI;
 	ccw->cda = (__u32)(addr_t) prssdp;
 
 	/* Read Subsystem Data - feature codes */
-- 
1.5.6.3
