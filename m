From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] include/linux/interrupt.h: add dummy irq_set_irq_wake() for
 "!GENERIC_HARDIRQS"
Date: Fri, 28 Jun 2013 09:23:08 +0800
Message-ID: <51CCE57C.5000901@asianux.com>
References: <51C8F685.6000209@asianux.com> <20130625064832.GA4999@osiris> <51C94599.1020707@asianux.com> <20130625090928.GA8981@osiris> <51CBA6B6.1010809@asianux.com> <20130627081845.GA3824@osiris> <51CC046F.2050009@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <51CC046F.2050009@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: paul.mckenney@linaro.org, josh@joshtriplett.org, Ben Hutchings <bhutchings@solarflare.com>, decot@googlers.com
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

Since irq_set_irq_wake() has already declared in header file, when
GENERIC_HARDIRQS enabled.

Recommend to define the dummy one for GENERIC_HARDIRQS disabled, and
also let the other related "static inline" functions are independent
from GENERIC_HARDIRQS.

So can avoid the compiling error below, and also let the code simpler
and clearer.

The related compiling error (ARCH=3Ds390 allmodconfig):

  sound/soc/codecs/wm0010.c: In function =91wm0010_spi_probe=92:
  sound/soc/codecs/wm0010.c:976:2: error: implicit declaration of funct=
ion =91irq_set_irq_wake=92 [-Werror=3Dimplicit-function-declaration]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 include/linux/interrupt.h |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5fa5afe..1a311e0 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -344,16 +344,6 @@ static inline void enable_irq_lockdep_irqrestore(u=
nsigned int irq, unsigned long
 /* IRQ wakeup (PM) control: */
 extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
=20
-static inline int enable_irq_wake(unsigned int irq)
-{
-	return irq_set_irq_wake(irq, 1);
-}
-
-static inline int disable_irq_wake(unsigned int irq)
-{
-	return irq_set_irq_wake(irq, 0);
-}
-
 #else /* !CONFIG_GENERIC_HARDIRQS */
 /*
  * NOTE: non-genirq architectures, if they want to support the lock
@@ -370,16 +360,23 @@ static inline int disable_irq_wake(unsigned int i=
rq)
 						enable_irq(irq)
 # endif
=20
-static inline int enable_irq_wake(unsigned int irq)
+/* IRQ wakeup (PM) control: */
+static inline int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
 	return 0;
 }
=20
+#endif /* CONFIG_GENERIC_HARDIRQS */
+
+static inline int enable_irq_wake(unsigned int irq)
+{
+	return irq_set_irq_wake(irq, 1);
+}
+
 static inline int disable_irq_wake(unsigned int irq)
 {
-	return 0;
+	return irq_set_irq_wake(irq, 0);
 }
-#endif /* CONFIG_GENERIC_HARDIRQS */
=20
=20
 #ifdef CONFIG_IRQ_FORCED_THREADING
--=20
1.7.7.6
