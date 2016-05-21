From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:08:49 +0000
Subject: [PATCH 0248/1529] Fix typo
Message-Id: <20160521120849.12939-1-andrea.gelmini@gelma.net>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/s390/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 7b89a75..3d2bb81 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -103,7 +103,7 @@ early_param("smt", early_smt);
 
 /*
  * The smp_cpu_state_mutex must be held when changing the state or polarization
- * member of a pcpu data structure within the pcpu_devices arreay.
+ * member of a pcpu data structure within the pcpu_devices array.
  */
 DEFINE_MUTEX(smp_cpu_state_mutex);
 
-- 
2.8.2.534.g1f66975
