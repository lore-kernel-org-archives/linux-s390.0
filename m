Return-Path: <atm@profoundis.com>
Date: Thu, 19 Sep 2013 02:33:58 +0530
From: Anoop Thomas Mathew <atm@profoundis.com>
Subject: [PATCH] Fixed typo on word accounting in kprobes.c in mutliple
 architectures
Message-ID: <20130918210351.GA13811@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: vgupta@synopsys.com, tony.luck@intel.com, davem@davemloft.net
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Anoop Thomas Mathew <atm@profoundis.com>
---
 arch/arc/kernel/kprobes.c     |    2 +-
 arch/ia64/kernel/kprobes.c    |    2 +-
 arch/powerpc/kernel/kprobes.c |    2 +-
 arch/s390/kernel/kprobes.c    |    2 +-
 arch/sparc/kernel/kprobes.c   |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 72f9782..7446c8d 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -327,7 +327,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned long trapnr)
 		 */
 
 		/* We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accouting
+		 * we can also use npre/npostfault count for accounting
 		 * these specific fault cases.
 		 */
 		kprobes_inc_nmissed_count(cur);
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index f8280a7..074fde4 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -947,7 +947,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_SSDONE:
 		/*
 		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accouting
+		 * we can also use npre/npostfault count for accounting
 		 * these specific fault cases.
 		 */
 		kprobes_inc_nmissed_count(cur);
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 2156ea9..90fab64 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -429,7 +429,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_SSDONE:
 		/*
 		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accouting
+		 * we can also use npre/npostfault count for accounting
 		 * these specific fault cases.
 		 */
 		kprobes_inc_nmissed_count(cur);
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 0ce9fb2..018c1c4 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -673,7 +673,7 @@ static int __kprobes kprobe_trap_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_SSDONE:
 		/*
 		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accouting
+		 * we can also use npre/npostfault count for accounting
 		 * these specific fault cases.
 		 */
 		kprobes_inc_nmissed_count(p);
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index e722121..d3d5d38 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -349,7 +349,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_SSDONE:
 		/*
 		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accouting
+		 * we can also use npre/npostfault count for accounting
 		 * these specific fault cases.
 		 */
 		kprobes_inc_nmissed_count(cur);
-- 
1.7.9.5
