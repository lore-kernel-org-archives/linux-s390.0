Return-Path: <linux-arch-owner@vger.kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 2/8] kernel/jump_label: implement generic support for relative references
Date: Mon,  2 Jul 2018 20:11:39 +0200
Message-ID: <20180702181145.4799-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180702181139.xkALONs6o-rvpEAzWS3-w6wMZ-ZfkS2x0kD06aJOxWY@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

To reduce the size taken up by absolute references in jump label
entries themselves and the associated relocation records in the
.init segment, add support for emitting them as relative references
instead.

Note that this requires some extra care in the sorting routine, given
that the offsets change when entries are moved around in the jump_entry
table.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig               |  3 +++
 include/linux/jump_label.h | 28 ++++++++++++++++++++
 kernel/jump_label.c        | 22 ++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2b8b70820002..22fa3792626e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -348,6 +348,9 @@ config HAVE_PERF_USER_STACK_DUMP
 config HAVE_ARCH_JUMP_LABEL
 	bool
 
+config HAVE_ARCH_JUMP_LABEL_RELATIVE
+	bool
+
 config HAVE_RCU_TABLE_FREE
 	bool
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 4603a1c88e48..871826fd0c3b 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -121,6 +121,32 @@ struct static_key {
 #include <asm/jump_label.h>
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
+
+struct jump_entry {
+	s32 code;
+	s32 target;
+	long key;	// key may be far away from the core kernel under KASLR
+};
+
+static inline unsigned long jump_entry_code(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->code + entry->code;
+}
+
+static inline unsigned long jump_entry_target(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->target + entry->target;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	long offset = entry->key & ~1L;
+
+	return (struct static_key *)((unsigned long)&entry->key + offset);
+}
+
+#else
 
 static inline unsigned long jump_entry_code(const struct jump_entry *entry)
 {
@@ -137,6 +163,8 @@ static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 	return (struct static_key *)((unsigned long)entry->key & ~1UL);
 }
 
+#endif
+
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
 {
 	return (unsigned long)entry->key & 1UL;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 8a3ac4f5f490..d424e1d22d63 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -47,14 +47,34 @@ static int jump_label_cmp(const void *a, const void *b)
 	return 0;
 }
 
+static void jump_label_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct jump_entry *jea = a;
+	struct jump_entry *jeb = b;
+	struct jump_entry tmp = *jea;
+
+	jea->code	= jeb->code - delta;
+	jea->target	= jeb->target - delta;
+	jea->key	= jeb->key - delta;
+
+	jeb->code	= tmp.code + delta;
+	jeb->target	= tmp.target + delta;
+	jeb->key	= tmp.key + delta;
+}
+
 static void
 jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 {
 	unsigned long size;
+	void *swapfn = NULL;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE))
+		swapfn = jump_label_swap;
 
 	size = (((unsigned long)stop - (unsigned long)start)
 					/ sizeof(struct jump_entry));
-	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
+	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, swapfn);
 }
 
 static void jump_label_update(struct static_key *key);
-- 
2.17.1
