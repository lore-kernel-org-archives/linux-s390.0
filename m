Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 Feb 2010 10:20:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.33-rc7
Message-ID: <20100210102055.6814488d@mschwide.boeblingen.de.ibm.com>
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

hopefully the last s390 update for 2.6.33.
Please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (1):
      [S390] Fix struct _lowcore layout.

Jan Glauber (1):
      [S390] qdio: prevent call trace if CHPID is offline

Ursula Braun (1):
      [S390] qdio: continue polling for buffer state ERROR

 arch/s390/include/asm/lowcore.h |    4 ++--
 drivers/s390/cio/qdio_main.c    |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index f2ef4b6..c25dfac 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -293,12 +293,12 @@ struct _lowcore
 	__u64	clock_comparator;		/* 0x02d0 */
 	__u32	machine_flags;			/* 0x02d8 */
 	__u32	ftrace_func;			/* 0x02dc */
-	__u8	pad_0x02f0[0x0300-0x02f0];	/* 0x02f0 */
+	__u8	pad_0x02e0[0x0300-0x02e0];	/* 0x02e0 */
 
 	/* Interrupt response block */
 	__u8	irb[64];			/* 0x0300 */
 
-	__u8	pad_0x0400[0x0e00-0x0400];	/* 0x0400 */
+	__u8	pad_0x0340[0x0e00-0x0340];	/* 0x0340 */
 
 	/*
 	 * 0xe00 contains the address of the IPL Parameter Information
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 999fe80..62b654a 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -531,7 +531,7 @@ static inline int qdio_inbound_q_done(struct qdio_q *q)
 	qdio_siga_sync_q(q);
 	get_buf_state(q, q->first_to_check, &state, 0);
 
-	if (state == SLSB_P_INPUT_PRIMED)
+	if (state == SLSB_P_INPUT_PRIMED || state == SLSB_P_INPUT_ERROR)
 		/* more work coming */
 		return 0;
 
@@ -960,6 +960,8 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 			qdio_handle_activate_check(cdev, intparm, cstat,
 						   dstat);
 		break;
+	case QDIO_IRQ_STATE_STOPPED:
+		break;
 	default:
 		WARN_ON(1);
 	}
