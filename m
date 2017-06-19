From: Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH 4/7] ia64: Add __down_read_killable()
Date: Mon, 19 Jun 2017 21:02:51 +0300
Message-ID: <149789537165.9059.15919512843596106349.stgit@localhost.localdomain>
References: <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-ia64@vger.kernel.org, avagin@virtuozzo.com, peterz@infradead.org, heiko.carstens@de.ibm.com, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ktkhai@virtuozzo.com, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>

Similar to __down_write_killable(), and read killable primitive.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 arch/ia64/include/asm/rwsem.h |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/rwsem.h b/arch/ia64/include/asm/rwsem.h
index 8fa98dd303b4..1fb8b7cb1c98 100644
--- a/arch/ia64/include/asm/rwsem.h
+++ b/arch/ia64/include/asm/rwsem.h
@@ -37,15 +37,31 @@
 /*
  * lock for reading
  */
-static inline void
-__down_read (struct rw_semaphore *sem)
+static inline int
+___down_read (struct rw_semaphore *sem)
 {
 	long result = ia64_fetchadd8_acq((unsigned long *)&sem->count.counter, 1);
 
-	if (result < 0)
+	return (result < 0);
+}
+
+static inline void
+__down_read (struct rw_semaphore *sem)
+{
+	if (___down_read(sem))
 		rwsem_down_read_failed(sem);
 }
 
+static inline int
+__down_read_killable (struct rw_semaphore *sem)
+{
+	if (___down_read(sem))
+		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
+			return -EINTR;
+
+	return 0;
+}
+
 /*
  * lock for writing
  */
