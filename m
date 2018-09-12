From: Brice Goglin <Brice.Goglin@inria.fr>
Date: Wed, 12 Sep 2018 06:01:43 +0000
Subject: [PATCH] cputopology.txt: fix CONFIG_SCHED_DRAWER name
Message-Id: <28c08a4c-5814-a1ee-f4d2-b51f22ebe348@inria.fr>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

CONFIG_SCHED_DRAWER instead of CONFIG_DRAWER.

Signed-off-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index c6e7e9196a8b..981509fc138d 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -74,8 +74,8 @@ drivers/base/topology.c, is to export the 6 to 12 attributes. The book
 and drawer related sysfs files will only be created if CONFIG_SCHED_BOOK
 and CONFIG_SCHED_DRAWER are selected.
 
-CONFIG_SCHED_BOOK and CONFIG_DRAWER are currently only used on s390, where
-they reflect the cpu and cache hierarchy.
+CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
+where they reflect the cpu and cache hierarchy.
 
 For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
-- 
2.18.0
