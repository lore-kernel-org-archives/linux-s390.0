From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/5] s390: make cpu_relax a barrier again
Date: Fri, 21 Oct 2016 13:58:56 +0200
Message-ID: <1477051138-1610-4-git-send-email-borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

stop_machine seems to be the only important place for yielding during
cpu_relax. This was fixed by using cpu_relax_yield. Therefore, we can
now redefine cpu_relax to be a barrier instead. (With the option to do
some SMT tuning later on)

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index d05965b..5d262cf 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -236,7 +236,7 @@ static inline unsigned short stap(void)
  */
 void cpu_relax_yield(void);
 
-#define cpu_relax() cpu_relax_yield()
+#define cpu_relax() barrier()
 #define cpu_relax_lowlatency()  barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
-- 
2.5.5
