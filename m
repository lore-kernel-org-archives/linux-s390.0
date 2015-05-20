Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2015 12:20:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.1-rc5
Message-ID: <20150520122045.6543de96@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Bug fixes. Three for our crypto code, two for eBPF, and one memory management
fix to get machines with memory > 8TB working.

Harald Freudenberger (1):
      s390/crypto: fix stckf loop

Ingo Tuchscherer (2):
      s390/zcrypt: fixed ap poll timer behavior
      s390/zcrypt: Fix invalid domain handling during ap module unload

Martin Schwidefsky (1):
      s390/mm: correct return value of pmd_pfn

Michael Holzheu (2):
      s390/bpf: Adjust ALU64_DIV/MOD to match interpreter change
      s390/bpf: Fix gcov stack space problem

 arch/s390/crypto/prng.c         |  2 +-
 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/net/bpf_jit_comp.c    | 19 ++++++++++---------
 drivers/s390/crypto/ap_bus.c    | 20 +++++++++-----------
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index 1f374b3..9d5192c 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -125,7 +125,7 @@ static int generate_entropy(u8 *ebuf, size_t nbytes)
 		/* fill page with urandom bytes */
 		get_random_bytes(pg, PAGE_SIZE);
 		/* exor page with stckf values */
-		for (n = 0; n < sizeof(PAGE_SIZE/sizeof(u64)); n++) {
+		for (n = 0; n < PAGE_SIZE / sizeof(u64); n++) {
 			u64 *p = ((u64 *)pg) + n;
 			*p ^= get_tod_clock_fast();
 		}
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index fc64239..ef24a21 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -494,7 +494,7 @@ static inline int pmd_large(pmd_t pmd)
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_LARGE) != 0;
 }
 
-static inline int pmd_pfn(pmd_t pmd)
+static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	unsigned long origin_mask;
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 7690dc8..20c146d 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -443,8 +443,11 @@ static void bpf_jit_epilogue(struct bpf_jit *jit)
 
 /*
  * Compile one eBPF instruction into s390x code
+ *
+ * NOTE: Use noinline because for gcov (-fprofile-arcs) gcc allocates a lot of
+ * stack space for the large switch statement.
  */
-static int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
+static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
 	int jmp_off, last, insn_count = 1;
@@ -588,8 +591,8 @@ static int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
 		EMIT4(0xb9160000, dst_reg, rc_reg);
 		break;
 	}
-	case BPF_ALU64 | BPF_DIV | BPF_X: /* dst = dst / (u32) src */
-	case BPF_ALU64 | BPF_MOD | BPF_X: /* dst = dst % (u32) src */
+	case BPF_ALU64 | BPF_DIV | BPF_X: /* dst = dst / src */
+	case BPF_ALU64 | BPF_MOD | BPF_X: /* dst = dst % src */
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
@@ -602,10 +605,8 @@ static int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
 		EMIT4_IMM(0xa7090000, REG_W0, 0);
 		/* lgr %w1,%dst */
 		EMIT4(0xb9040000, REG_W1, dst_reg);
-		/* llgfr %dst,%src (u32 cast) */
-		EMIT4(0xb9160000, dst_reg, src_reg);
 		/* dlgr %w0,%dst */
-		EMIT4(0xb9870000, REG_W0, dst_reg);
+		EMIT4(0xb9870000, REG_W0, src_reg);
 		/* lgr %dst,%rc */
 		EMIT4(0xb9040000, dst_reg, rc_reg);
 		break;
@@ -632,8 +633,8 @@ static int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
 		EMIT4(0xb9160000, dst_reg, rc_reg);
 		break;
 	}
-	case BPF_ALU64 | BPF_DIV | BPF_K: /* dst = dst / (u32) imm */
-	case BPF_ALU64 | BPF_MOD | BPF_K: /* dst = dst % (u32) imm */
+	case BPF_ALU64 | BPF_DIV | BPF_K: /* dst = dst / imm */
+	case BPF_ALU64 | BPF_MOD | BPF_K: /* dst = dst % imm */
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
@@ -649,7 +650,7 @@ static int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
 		EMIT4(0xb9040000, REG_W1, dst_reg);
 		/* dlg %w0,<d(imm)>(%l) */
 		EMIT6_DISP_LH(0xe3000000, 0x0087, REG_W0, REG_0, REG_L,
-			      EMIT_CONST_U64((u32) imm));
+			      EMIT_CONST_U64(imm));
 		/* lgr %dst,%rc */
 		EMIT4(0xb9040000, dst_reg, rc_reg);
 		break;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index f0b9871..3ba6114 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1158,11 +1158,12 @@ static ssize_t poll_timeout_store(struct bus_type *bus, const char *buf,
 	poll_timeout = time;
 	hr_time = ktime_set(0, poll_timeout);
 
-	if (!hrtimer_is_queued(&ap_poll_timer) ||
-	    !hrtimer_forward(&ap_poll_timer, hrtimer_get_expires(&ap_poll_timer), hr_time)) {
-		hrtimer_set_expires(&ap_poll_timer, hr_time);
-		hrtimer_start_expires(&ap_poll_timer, HRTIMER_MODE_ABS);
-	}
+	spin_lock_bh(&ap_poll_timer_lock);
+	hrtimer_cancel(&ap_poll_timer);
+	hrtimer_set_expires(&ap_poll_timer, hr_time);
+	hrtimer_start_expires(&ap_poll_timer, HRTIMER_MODE_ABS);
+	spin_unlock_bh(&ap_poll_timer_lock);
+
 	return count;
 }
 
@@ -1528,14 +1529,11 @@ static inline void __ap_schedule_poll_timer(void)
 	ktime_t hr_time;
 
 	spin_lock_bh(&ap_poll_timer_lock);
-	if (hrtimer_is_queued(&ap_poll_timer) || ap_suspend_flag)
-		goto out;
-	if (ktime_to_ns(hrtimer_expires_remaining(&ap_poll_timer)) <= 0) {
+	if (!hrtimer_is_queued(&ap_poll_timer) && !ap_suspend_flag) {
 		hr_time = ktime_set(0, poll_timeout);
 		hrtimer_forward_now(&ap_poll_timer, hr_time);
 		hrtimer_restart(&ap_poll_timer);
 	}
-out:
 	spin_unlock_bh(&ap_poll_timer_lock);
 }
 
@@ -1952,7 +1950,7 @@ static void ap_reset_domain(void)
 {
 	int i;
 
-	if (ap_domain_index != -1)
+	if ((ap_domain_index != -1) && (ap_test_config_domain(ap_domain_index)))
 		for (i = 0; i < AP_DEVICES; i++)
 			ap_reset_queue(AP_MKQID(i, ap_domain_index));
 }
@@ -2097,7 +2095,6 @@ void ap_module_exit(void)
 	hrtimer_cancel(&ap_poll_timer);
 	destroy_workqueue(ap_work_queue);
 	tasklet_kill(&ap_tasklet);
-	root_device_unregister(ap_root_device);
 	while ((dev = bus_find_device(&ap_bus_type, NULL, NULL,
 		    __ap_match_all)))
 	{
@@ -2106,6 +2103,7 @@ void ap_module_exit(void)
 	}
 	for (i = 0; ap_bus_attrs[i]; i++)
 		bus_remove_file(&ap_bus_type, ap_bus_attrs[i]);
+	root_device_unregister(ap_root_device);
 	bus_unregister(&ap_bus_type);
 	unregister_reset_call(&ap_reset_call);
 	if (ap_using_interrupts())
