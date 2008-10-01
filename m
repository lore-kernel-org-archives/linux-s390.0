Return-Path: <linux-kernel-owner+w=401wt.eu-S1755925AbYJAJDh@vger.kernel.org>
Message-Id: <20081001084128.270168308@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/21] cio: inline assembly cleanup
Content-Disposition: inline; filename=111-cio-inline.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Fix incorrect in- and output constraints, remove volatile declaration
of inline assembly parameters and reformat constraint declarations to
be more consistent.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c    |    2 -
 drivers/s390/cio/io_sch.h |   22 +++++++++++++++-----
 drivers/s390/cio/ioasm.h  |   49 ++++++++++++++++++++++++++--------------------
 3 files changed, 45 insertions(+), 28 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -901,7 +901,7 @@ static void cio_reset_pgm_check_handler(
 	pgm_check_occured = 1;
 }
 
-static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
+static int stsch_reset(struct subchannel_id schid, struct schib *addr)
 {
 	int rc;
 
Index: quilt-2.6/drivers/s390/cio/ioasm.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ioasm.h
+++ quilt-2.6/drivers/s390/cio/ioasm.h
@@ -23,38 +23,39 @@ struct tpi_info {
  * Some S390 specific IO instructions as inline
  */
 
-static inline int stsch(struct subchannel_id schid,
-			    volatile struct schib *addr)
+static inline int stsch(struct subchannel_id schid, struct schib *addr)
 {
 	register struct subchannel_id reg1 asm ("1") = schid;
 	int ccode;
 
 	asm volatile(
-		"	stsch	0(%2)\n"
+		"	stsch	0(%3)\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+		: "=d" (ccode), "=m" (*addr)
+		: "d" (reg1), "a" (addr)
+		: "cc");
 	return ccode;
 }
 
-static inline int stsch_err(struct subchannel_id schid,
-				volatile struct schib *addr)
+static inline int stsch_err(struct subchannel_id schid, struct schib *addr)
 {
 	register struct subchannel_id reg1 asm ("1") = schid;
 	int ccode = -EIO;
 
 	asm volatile(
-		"	stsch	0(%2)\n"
+		"	stsch	0(%3)\n"
 		"0:	ipm	%0\n"
 		"	srl	%0,28\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "+d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+		: "+d" (ccode), "=m" (*addr)
+		: "d" (reg1), "a" (addr)
+		: "cc");
 	return ccode;
 }
 
-static inline int msch(struct subchannel_id schid,
-			   volatile struct schib *addr)
+static inline int msch(struct subchannel_id schid, struct schib *addr)
 {
 	register struct subchannel_id reg1 asm ("1") = schid;
 	int ccode;
@@ -63,12 +64,13 @@ static inline int msch(struct subchannel
 		"	msch	0(%2)\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+		: "=d" (ccode)
+		: "d" (reg1), "a" (addr), "m" (*addr)
+		: "cc");
 	return ccode;
 }
 
-static inline int msch_err(struct subchannel_id schid,
-			       volatile struct schib *addr)
+static inline int msch_err(struct subchannel_id schid, struct schib *addr)
 {
 	register struct subchannel_id reg1 asm ("1") = schid;
 	int ccode = -EIO;
@@ -79,33 +81,38 @@ static inline int msch_err(struct subcha
 		"	srl	%0,28\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "+d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+		: "+d" (ccode)
+		: "d" (reg1), "a" (addr), "m" (*addr)
+		: "cc");
 	return ccode;
 }
 
-static inline int tsch(struct subchannel_id schid,
-			   volatile struct irb *addr)
+static inline int tsch(struct subchannel_id schid, struct irb *addr)
 {
 	register struct subchannel_id reg1 asm ("1") = schid;
 	int ccode;
 
 	asm volatile(
-		"	tsch	0(%2)\n"
+		"	tsch	0(%3)\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+		: "=d" (ccode), "=m" (*addr)
+		: "d" (reg1), "a" (addr)
+		: "cc");
 	return ccode;
 }
 
-static inline int tpi( volatile struct tpi_info *addr)
+static inline int tpi(struct tpi_info *addr)
 {
 	int ccode;
 
 	asm volatile(
-		"	tpi	0(%1)\n"
+		"	tpi	0(%2)\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "a" (addr), "m" (*addr) : "cc");
+		: "=d" (ccode), "=m" (*addr)
+		: "a" (addr)
+		: "cc");
 	return ccode;
 }
 
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h
+++ quilt-2.6/drivers/s390/cio/io_sch.h
@@ -123,7 +123,7 @@ struct ccw_device_private {
 	void *cmb_wait;			/* deferred cmb enable/disable */
 };
 
-static inline int ssch(struct subchannel_id schid, volatile union orb *addr)
+static inline int ssch(struct subchannel_id schid, union orb *addr)
 {
 	register struct subchannel_id reg1 asm("1") = schid;
 	int ccode = -EIO;
@@ -134,7 +134,9 @@ static inline int ssch(struct subchannel
 		"	srl	%0,28\n"
 		"1:\n"
 		EX_TABLE(0b, 1b)
-		: "+d" (ccode) : "d" (reg1), "a" (addr), "m" (*addr) : "cc");
+		: "+d" (ccode)
+		: "d" (reg1), "a" (addr), "m" (*addr)
+		: "cc", "memory");
 	return ccode;
 }
 
@@ -147,7 +149,9 @@ static inline int rsch(struct subchannel
 		"	rsch\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
+		: "=d" (ccode)
+		: "d" (reg1)
+		: "cc", "memory");
 	return ccode;
 }
 
@@ -160,7 +164,9 @@ static inline int csch(struct subchannel
 		"	csch\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
+		: "=d" (ccode)
+		: "d" (reg1)
+		: "cc");
 	return ccode;
 }
 
@@ -173,7 +179,9 @@ static inline int hsch(struct subchannel
 		"	hsch\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
+		: "=d" (ccode)
+		: "d" (reg1)
+		: "cc");
 	return ccode;
 }
 
@@ -186,7 +194,9 @@ static inline int xsch(struct subchannel
 		"	.insn	rre,0xb2760000,%1,0\n"
 		"	ipm	%0\n"
 		"	srl	%0,28"
-		: "=d" (ccode) : "d" (reg1) : "cc");
+		: "=d" (ccode)
+		: "d" (reg1)
+		: "cc");
 	return ccode;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
