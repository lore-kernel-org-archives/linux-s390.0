Return-Path: <linux-kernel-owner+w=401wt.eu-S1756718AbYHMXI2@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Fwd: [Patch 2.6] s390 - Allow ECKD devices to be used with older controllers and emulation
Date: Thu, 14 Aug 2008 01:07:59 +0200
References: <489C9494.9070504@vmfacility.fr>
In-reply-To: <489C9494.9070504@vmfacility.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808140108.00375.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Ivan Warren <ivan@vmfacility.fr>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Forwarding to s390 kernel list as there have been no replies so far.

(Patch may have whitespace damage because of forward.)

Ivan: You may want to read Documentation/SubmittingPatches in the kernel
source tree.

--------------------------- Forwarded message ---------------------------
Crowd,

Apologies if this is not formatted correctly, but I'm fairly new to this
(submitting patches that is)..

**************
    s390 dasd ECKD drivers issues a Perform Subsystem Function / Prepare
for Read SubSystem Data with a length of 16.
    However, older hardware and documentation specifies a length of 12
leading to a possible Incorrect Length indication.
    This patch activates the SLI CCW flag in order to avoid reporting
the Incorrect Length indication since it is possible that the DASD
control unit may be expecting a length of 12, not 16.
        -- Ivan Warren (ivan@vmfacility.fr)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c index 773b3fe..c4e3935 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -810,6 +810,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
+	ccw->flags |= CCW_FLAG_SLI;
 	ccw->cda = (__u32)(addr_t) prssdp;
 
 	/* Read Subsystem Data - feature codes */
**************

--Ivan
