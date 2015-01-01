Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54A55954.6000002@sunrus.com.cn>
Date: Thu, 01 Jan 2015 22:27:32 +0800
From: Chen Gang <gang.chen@sunrus.com.cn>
MIME-Version: 1.0
Subject: [PATCH] s390: include: timex: Use macro CLOCK_STORE_SIZE instead
 of hard code number
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux390@de.ibm.com, holzheu@linux.vnet.ibm.com, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

For C language, it treats array parameter as a pointer, so sizeof for an
array parameter is equal to sizeof for a pointer, which causes compiler
warning (with allmodconfig by gcc 5):

    CC      arch/s390/kernel/asm-offsets.s
  In file included from include/linux/timex.h:65:0,
                   from include/linux/sched.h:19,
                   from include/linux/kvm_host.h:15,
                   from arch/s390/kernel/asm-offsets.c:10:
  ./arch/s390/include/asm/timex.h: In function 'get_tod_clock_ext':
  ./arch/s390/include/asm/timex.h:76:32: warning: 'sizeof' on array function parameter 'clk' will return size of 'char *' [-Wsizeof-array-argument]
    typedef struct { char _[sizeof(clk)]; } addrtype;
                                  ^

Can use macro CLOCK_STORE_SIZE instead of all related hard code numbers,
which also can avoid this warning. And also add a tab to CLOCK_TICK_RATE
definition to match coding styles.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/s390/hypfs/hypfs_vm.c    |    2 +-
 arch/s390/include/asm/timex.h |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 32040ac..344b622 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -231,7 +231,7 @@ failed:
 struct dbfs_d2fc_hdr {
 	u64	len;		/* Length of d2fc buffer without header */
 	u16	version;	/* Version of header */
-	char	tod_ext[16];	/* TOD clock for d2fc */
+	char	tod_ext[CLOCK_STORE_SIZE]; /* TOD clock for d2fc */
 	u64	count;		/* Number of VM guests in d2fc buffer */
 	char	reserved[30];
 } __attribute__ ((packed));
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 8beee1c..2d2fab6 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -67,20 +67,21 @@ static inline void local_tick_enable(unsigned long long comp)
 	set_clock_comparator(S390_lowcore.clock_comparator);
 }
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
+#define CLOCK_STORE_SIZE	16 /* store size for clock */
 
 typedef unsigned long long cycles_t;
 
-static inline void get_tod_clock_ext(char clk[16])
+static inline void get_tod_clock_ext(char clk[CLOCK_STORE_SIZE])
 {
-	typedef struct { char _[sizeof(clk)]; } addrtype;
+	typedef struct { char _[CLOCK_STORE_SIZE]; } addrtype;
 
 	asm volatile("stcke %0" : "=Q" (*(addrtype *) clk) : : "cc");
 }
 
 static inline unsigned long long get_tod_clock(void)
 {
-	unsigned char clk[16];
+	unsigned char clk[CLOCK_STORE_SIZE];
 	get_tod_clock_ext(clk);
 	return *((unsigned long long *)&clk[1]);
 }
-- 
1.7.9.5
