From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/36] perf s390: Always build with -fPIC
Date: Wed,  6 Dec 2017 11:40:57 -0300
Message-ID: <20171206144115.15097-19-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
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
LPU-Reference: 1512031765-9382-1-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-a8wga8hrl0d0r84cal96fmgv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2c437baf8364..bf86c09ca889 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -41,6 +41,7 @@ ifeq ($(SRCARCH),x86)
     LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
   endif
   NO_PERF_REGS := 0
+  CFLAGS += -fPIC
 endif
 
 ifeq ($(SRCARCH),arm)
-- 
2.13.6
