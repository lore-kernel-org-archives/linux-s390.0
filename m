Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Dec 2017 07:34:46 -0800
From: tip-bot for Hendrik Brueckner <tipbot@zytor.com>
Message-ID: <tip-a9a3f1d18a6c9ccf89728e23474645aa91e2f4f1@git.kernel.org>
Reply-To: heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jonathan.hermann@de.ibm.com,
        tmricht@linux.vnet.ibm.com
In-Reply-To: <20171207080951.GC4889@linux.vnet.ibm.com>
References: <20171207080951.GC4889@linux.vnet.ibm.com>
Subject: [tip:perf/core] perf s390: Always build with -fPIC
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org, tmricht@linux.vnet.ibm.com, jonathan.hermann@de.ibm.com, heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Commit-ID:  a9a3f1d18a6c9ccf89728e23474645aa91e2f4f1
Gitweb:     https://git.kernel.org/tip/a9a3f1d18a6c9ccf89728e23474645aa91e2f4f1
Author:     Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
AuthorDate: Wed, 13 Dec 2017 17:46:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 27 Dec 2017 12:15:57 -0300

perf s390: Always build with -fPIC

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
index eb6bd99..f050f38 100644
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
