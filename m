Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 29 Sep 2011 09:46:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 3.1-rc7
Message-ID: <20110929094620.1ea35330@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Carsten Otte (1):
      [S390] gmap: always up mmap_sem properly

Martin Schwidefsky (1):
      [S390] Do not clobber personality flags on exec

Peter Oberparleiter (1):
      [S390] cio: fix cio_tpi ignoring adapter interrupts

 arch/s390/include/asm/elf.h |    3 ++-
 arch/s390/mm/pgtable.c      |    7 ++++---
 drivers/s390/cio/cio.c      |    8 ++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 64b61bf..547f1a6 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -188,7 +188,8 @@ extern char elf_platform[];
 #define SET_PERSONALITY(ex)					\
 do {								\
 	if (personality(current->personality) != PER_LINUX32)	\
-		set_personality(PER_LINUX);			\
+		set_personality(PER_LINUX |			\
+			(current->personality & ~PER_MASK));	\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
 		set_thread_flag(TIF_31BIT);			\
 	else							\
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index f69ff3c..5d56c2b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -303,15 +303,15 @@ int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len)
 		/* Walk the guest addr space page table */
 		table = gmap->table + (((to + off) >> 53) & 0x7ff);
 		if (*table & _REGION_ENTRY_INV)
-			return 0;
+			goto out;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
 		table = table + (((to + off) >> 42) & 0x7ff);
 		if (*table & _REGION_ENTRY_INV)
-			return 0;
+			goto out;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
 		table = table + (((to + off) >> 31) & 0x7ff);
 		if (*table & _REGION_ENTRY_INV)
-			return 0;
+			goto out;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
 		table = table + (((to + off) >> 20) & 0x7ff);
 
@@ -319,6 +319,7 @@ int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len)
 		flush |= gmap_unlink_segment(gmap, table);
 		*table = _SEGMENT_ENTRY_INV;
 	}
+out:
 	up_read(&gmap->mm->mmap_sem);
 	if (flush)
 		gmap_flush_tlb(gmap);
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index cbde448..eb3140e 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -654,8 +654,8 @@ static struct io_subchannel_private console_priv;
 static int console_subchannel_in_use;
 
 /*
- * Use tpi to get a pending interrupt, call the interrupt handler and
- * return a pointer to the subchannel structure.
+ * Use cio_tpi to get a pending interrupt and call the interrupt handler.
+ * Return non-zero if an interrupt was processed, zero otherwise.
  */
 static int cio_tpi(void)
 {
@@ -667,6 +667,10 @@ static int cio_tpi(void)
 	tpi_info = (struct tpi_info *)&S390_lowcore.subchannel_id;
 	if (tpi(NULL) != 1)
 		return 0;
+	if (tpi_info->adapter_IO) {
+		do_adapter_IO(tpi_info->isc);
+		return 1;
+	}
 	irb = (struct irb *)&S390_lowcore.irb;
 	/* Store interrupt response block to lowcore. */
 	if (tsch(tpi_info->schid, irb) != 0)
