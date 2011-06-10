Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] s390, exec: remove redundant set_fs(USER_DS)
Date: Fri, 10 Jun 2011 15:10:28 +0200
Message-Id: <1307711428-15908-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTiknCeAxe30MJdVTxDom+ko8+EDQ4A@mail.gmail.com> <1307642718-22257-1-git-send-email-minipli@googlemail.com> <20110609155630.0f734351.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
List-ID: <linux-s390.vger.kernel.org>

The address limit is already set in flush_old_exec() so those calls to
set_fs(USER_DS) are redundant.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/s390/include/asm/processor.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 1300c30..4164533 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -118,14 +118,12 @@ struct stack_frame {
  * Do necessary setup to start up a new thread.
  */
 #define start_thread(regs, new_psw, new_stackp) do {		\
-	set_fs(USER_DS);					\
 	regs->psw.mask	= psw_user_bits;			\
 	regs->psw.addr	= new_psw | PSW_ADDR_AMODE;		\
 	regs->gprs[15]	= new_stackp;				\
 } while (0)
 
 #define start_thread31(regs, new_psw, new_stackp) do {		\
-	set_fs(USER_DS);					\
 	regs->psw.mask	= psw_user32_bits;			\
 	regs->psw.addr	= new_psw | PSW_ADDR_AMODE;		\
 	regs->gprs[15]	= new_stackp;				\
-- 
1.5.6.5
