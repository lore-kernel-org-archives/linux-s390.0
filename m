From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] perf s390: always build with -fPIC
Date: Thu, 30 Nov 2017 09:49:25 +0100
Message-ID: <1512031765-9382-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linux perf users list <linux-perf-users@vger.kernel.org>, Linux s390 list <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, jonathan.hermann@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On s390, object files must be compiled with position-indepedent code
in order to be incrementally linked or linked to shared libraries.
Therefore, add -fPIC to the CFLAGS for s390 to ensure each object
file is built properly.

Reported-by: Jonathan Hermann <jonathan.hermann@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ed65e82..0833d9f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -55,6 +55,7 @@ endif
 
 ifeq ($(ARCH),s390)
   NO_PERF_REGS := 0
+  CFLAGS += -fPIC
 endif
 
 ifeq ($(NO_PERF_REGS),0)
-- 
1.8.3.1
