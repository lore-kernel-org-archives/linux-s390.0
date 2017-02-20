From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 2/4] x86: convert threshold_bank.cpus from atomic_t to refcount_t
Date: Mon, 20 Feb 2017 13:06:19 +0200
Message-ID: <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 arch/x86/include/asm/amd_nb.h        | 3 ++-
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 00c88a0..da181ad 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -3,6 +3,7 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
+#include <linux/refcount.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
@@ -55,7 +56,7 @@ struct threshold_bank {
 	struct threshold_block	*blocks;
 
 	/* initialized to the number of CPUs on the node sharing this bank */
-	atomic_t		cpus;
+	refcount_t		cpus;
 };
 
 struct amd_northbridge {
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 524cc57..cfe0838 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -1202,7 +1202,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 				goto out;
 
 			per_cpu(threshold_banks, cpu)[bank] = b;
-			atomic_inc(&b->cpus);
+			refcount_inc(&b->cpus);
 
 			err = __threshold_add_blocks(b);
 
@@ -1225,7 +1225,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	per_cpu(threshold_banks, cpu)[bank] = b;
 
 	if (is_shared_bank(bank)) {
-		atomic_set(&b->cpus, 1);
+		refcount_set(&b->cpus, 1);
 
 		/* nb is already initialized, see above */
 		if (nb) {
@@ -1289,7 +1289,7 @@ static void threshold_remove_bank(unsigned int cpu, int bank)
 		goto free_out;
 
 	if (is_shared_bank(bank)) {
-		if (!atomic_dec_and_test(&b->cpus)) {
+		if (!refcount_dec_and_test(&b->cpus)) {
 			__threshold_remove_blocks(b);
 			per_cpu(threshold_banks, cpu)[bank] = NULL;
 			return;
-- 
2.7.4
