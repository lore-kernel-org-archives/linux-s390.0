Return-Path: <linux-kernel-owner+w=401wt.eu-S1757383AbYHOORJ@vger.kernel.org>
Message-ID: <48A58F9A.8070301@linux.vnet.ibm.com>
Date: Fri, 15 Aug 2008 16:15:54 +0200
From: Stefan Weinhuber <wein@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] S390 : Set SLI on PSF/PRSSD on Dasd ECKD initialisation
References: <1218726426.25578.0.camel@localhost> <1218738411-21828-1-git-send-email-ivan@vmfacility.fr>
In-Reply-To: <1218738411-21828-1-git-send-email-ivan@vmfacility.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ivan Warren <ivan@vmfacility.fr>
Cc: schwidefsky@de.ibm.com, elendil@planet.nl, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Ivan Warren wrote:
>     s390 Dasd ECKD Driver issues a Perform Subsystem Function/Prepare
>     for Read Subsystem Data with a length of 16.
>     However, some hardware (namely 3990/9390 and some version of ESS)
>     only take 12 bytes and therefore, an Incorrect Length indication is
>     returned, breaking CCW Command Chaining and leads to a failure to
>     initialize the DASD. This patch sets the SLI CCW bit to prevent an
>     incorrect length indication to be reported when the control unit
>     expects a length of 12 instead of 16.

Hi Ivan,

while I agree that your patch is technically correct, I think I'd
rather like to fix the problematic data length instead of making
the storage server ignore it. There is no need for the
dasd_psf_prssd_data structure to be 16 bytes long as it is only used
for suborders that require 12 bytes. The current layout of that
structure was probably just a mistake. If we ever go to use a
suborder that requires more data, we should either define a further
structure specific to that purpose or find some other way to make
sure that each suborder is called with the appropriate data length.

The following patch works fine on current hardware. Can you please
verify that it indeed fixes your problem as well?

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
---
 drivers/s390/block/dasd_eckd.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.26/drivers/s390/block/dasd_eckd.h
===================================================================
--- linux-2.6.26.orig/drivers/s390/block/dasd_eckd.h
+++ linux-2.6.26/drivers/s390/block/dasd_eckd.h
@@ -379,7 +379,7 @@ struct dasd_psf_prssd_data {
 	unsigned char flags;
 	unsigned char reserved[4];
 	unsigned char suborder;
-	unsigned char varies[9];
+	unsigned char varies[5];
 } __attribute__ ((packed));
 
 /*
