Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Dec 2015 09:48:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.4-rc7
Message-ID: <20151222094859.2a5f25a0@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Two late bug fixes for kernel 4.4. Merry Christmas.

Ingo Tuchscherer (1):
      s390/zcrypt: Fix AP queue handling if queue is full

Michael Holzheu (1):
      s390/dis: Fix handling of format specifiers

 arch/s390/kernel/dis.c       | 17 ++++++++++++-----
 drivers/s390/crypto/ap_bus.c |  4 +++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 8140d10..6e72961 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -1920,16 +1920,23 @@ static int print_insn(char *buffer, unsigned char *code, unsigned long addr)
 			}
 			if (separator)
 				ptr += sprintf(ptr, "%c", separator);
+			/*
+			 * Use four '%' characters below because of the
+			 * following two conversions:
+			 *
+			 *  1) sprintf: %%%%r -> %%r
+			 *  2) printk : %%r   -> %r
+			 */
 			if (operand->flags & OPERAND_GPR)
-				ptr += sprintf(ptr, "%%r%i", value);
+				ptr += sprintf(ptr, "%%%%r%i", value);
 			else if (operand->flags & OPERAND_FPR)
-				ptr += sprintf(ptr, "%%f%i", value);
+				ptr += sprintf(ptr, "%%%%f%i", value);
 			else if (operand->flags & OPERAND_AR)
-				ptr += sprintf(ptr, "%%a%i", value);
+				ptr += sprintf(ptr, "%%%%a%i", value);
 			else if (operand->flags & OPERAND_CR)
-				ptr += sprintf(ptr, "%%c%i", value);
+				ptr += sprintf(ptr, "%%%%c%i", value);
 			else if (operand->flags & OPERAND_VR)
-				ptr += sprintf(ptr, "%%v%i", value);
+				ptr += sprintf(ptr, "%%%%v%i", value);
 			else if (operand->flags & OPERAND_PCREL)
 				ptr += sprintf(ptr, "%lx", (signed int) value
 								      + addr);
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 61f7685..24ec282 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -599,8 +599,10 @@ static enum ap_wait ap_sm_read(struct ap_device *ap_dev)
 	status = ap_sm_recv(ap_dev);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		if (ap_dev->queue_count > 0)
+		if (ap_dev->queue_count > 0) {
+			ap_dev->state = AP_STATE_WORKING;
 			return AP_WAIT_AGAIN;
+		}
 		ap_dev->state = AP_STATE_IDLE;
 		return AP_WAIT_NONE;
 	case AP_RESPONSE_NO_PENDING_REPLY:
