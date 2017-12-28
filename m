From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/35] perf s390: Always build with -fPIC
Date: Thu, 28 Dec 2017 11:30:22 -0300
Message-ID: <20171228143027.30547-31-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, linux s390 list <linux-s390@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On s390, object files must be compiled with position-indepedent code in
order to be incrementally linked or linked to shared libraries.

Therefore, add -fPIC to the CFLAGS for s390 to ensure each object file
is built properly.

Reported-by: Jonathan Hermann <jonathan.hermann@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux s390 list <linux-s390@vger.kernel.org>
Link: https://lkml.kernel.org/r/20171207080951.GC4889@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eb6bd99be0bd..f050f38d8fa3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -58,7 +58,7 @@ endif
 ifeq ($(ARCH),s390)
   NO_PERF_REGS := 0
   NO_SYSCALL_TABLE := 0
-  CFLAGS += -I$(OUTPUT)arch/s390/include/generated
+  CFLAGS += -fPIC -I$(OUTPUT)arch/s390/include/generated
 endif
 
 ifeq ($(NO_PERF_REGS),0)
-- 
2.13.6
