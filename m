From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 1/8] kernel/jump_label: abstract jump_entry member accessors
Date: Mon,  2 Jul 2018 20:11:38 +0200
Message-ID: <20180702181145.4799-2-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

In preparation of allowing architectures to use relative references
in jump_label entries [which can dramatically reduce the memory
footprint], introduce abstractions for references to the 'code',
'target' and 'key' members of struct jump_entry.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/jump_label.h | 34 +++++++++++++++++
 kernel/jump_label.c        | 40 ++++++++------------
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b46b541c67c4..4603a1c88e48 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -119,6 +119,40 @@ struct static_key {
 
 #ifdef HAVE_JUMP_LABEL
 #include <asm/jump_label.h>
+
+#ifndef __ASSEMBLY__
+
+static inline unsigned long jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline unsigned long jump_entry_target(const struct jump_entry *entry)
+{
+	return entry->target;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#endif
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..8a3ac4f5f490 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -38,10 +38,10 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
-	if (jea->key < jeb->key)
+	if (jump_entry_key(jea) < jump_entry_key(jeb))
 		return -1;
 
-	if (jea->key > jeb->key)
+	if (jump_entry_key(jea) > jump_entry_key(jeb))
 		return 1;
 
 	return 0;
@@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit);
 
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
-	if (entry->code <= (unsigned long)end &&
-		entry->code + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	if (jump_entry_code(entry) <= (unsigned long)end &&
+	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
 		return 1;
 
 	return 0;
@@ -321,16 +321,6 @@ static inline void static_key_set_linked(struct static_key *key)
 	key->type |= JUMP_TYPE_LINKED;
 }
 
-static inline struct static_key *jump_entry_key(struct jump_entry *entry)
-{
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
-}
-
-static bool jump_entry_branch(struct jump_entry *entry)
-{
-	return (unsigned long)entry->key & 1UL;
-}
-
 /***
  * A 'struct static_key' uses a union such that it either points directly
  * to a table of 'struct jump_entry' or to a linked list of modules which in
@@ -355,7 +345,7 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool enabled = static_key_enabled(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return enabled ^ branch;
@@ -370,12 +360,12 @@ static void __jump_label_update(struct static_key *key,
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
 		 */
-		if (entry->code) {
-			if (kernel_text_address(entry->code))
+		if (!jump_entry_is_init(entry)) {
+			if (kernel_text_address(jump_entry_code(entry)))
 				arch_jump_label_transform(entry, jump_label_type(entry));
 			else
 				WARN_ONCE(1, "can't patch jump_label at %pS",
-					  (void *)(unsigned long)entry->code);
+					  (void *)jump_entry_code(entry));
 		}
 	}
 }
@@ -430,8 +420,8 @@ void __init jump_label_invalidate_initmem(void)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (init_section_contains((void *)(unsigned long)iter->code, 1))
-			iter->code = 0;
+		if (init_section_contains((void *)jump_entry_code(iter), 1))
+			jump_entry_set_init(iter);
 	}
 }
 
@@ -441,7 +431,7 @@ static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool type = static_key_type(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return type ^ branch;
@@ -565,7 +555,7 @@ static int jump_label_add_module(struct module *mod)
 			continue;
 
 		key = iterk;
-		if (within_module(iter->key, mod)) {
+		if (within_module((unsigned long)key, mod)) {
 			static_key_set_entries(key, iter);
 			continue;
 		}
@@ -615,7 +605,7 @@ static void jump_label_del_module(struct module *mod)
 
 		key = jump_entry_key(iter);
 
-		if (within_module(iter->key, mod))
+		if (within_module((unsigned long)key, mod))
 			continue;
 
 		/* No memory during module load */
@@ -659,8 +649,8 @@ static void jump_label_invalidate_module_init(struct module *mod)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (within_module_init(iter->code, mod))
-			iter->code = 0;
+		if (within_module_init(jump_entry_code(iter), mod))
+			jump_entry_set_init(iter);
 	}
 }
 
-- 
2.17.1
