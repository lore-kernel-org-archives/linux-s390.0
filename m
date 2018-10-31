From: "Justin M. Forbes" <jforbes@fedoraproject.org>
Date: Wed, 31 Oct 2018 18:02:03 +0000
Subject: [PATCH] s390/mm: Fix ERROR: "__node_distance" undefined!
Message-Id: <20181031180203.27256-1-jforbes@fedoraproject.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Fixes:
ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
make: *** [Makefile:1275: modules] Error 2
+ exit 1

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 arch/s390/numa/numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 5bd374491f94..bef306e45da8 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -55,6 +55,8 @@ int __node_distance(int a, int b)
 	return mode->distance ? mode->distance(a, b) : 0;
 }

+EXPORT_SYMBOL(__node_distance);
+
 int numa_debug_enabled;

 /*
-- 
2.19.1
