Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 03/15] livepatch: temporary stubs for klp_patch_pending()
 and klp_update_patch_state()
Date: Thu,  8 Dec 2016 12:08:28 -0600
Message-Id: <26bb2315093328bf31e94fdd6eec61c341a6e924.1481220077.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1481220077.git.jpoimboe@redhat.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Create temporary stubs for klp_patch_pending() and
klp_update_patch_state() so we can add TIF_PATCH_PENDING to different
architectures in separate patches without breaking build bisectability.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/livepatch.h | 7 ++++++-
 kernel/livepatch/core.c   | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 9072f04..60558d8 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -123,10 +123,15 @@ void arch_klp_init_object_loaded(struct klp_patch *patch,
 int klp_module_coming(struct module *mod);
 void klp_module_going(struct module *mod);
 
+static inline bool klp_patch_pending(struct task_struct *task) { return false; }
+void klp_update_patch_state(struct task_struct *task);
+
 #else /* !CONFIG_LIVEPATCH */
 
 static inline int klp_module_coming(struct module *mod) { return 0; }
-static inline void klp_module_going(struct module *mod) { }
+static inline void klp_module_going(struct module *mod) {}
+static inline bool klp_patch_pending(struct task_struct *task) { return false; }
+static inline void klp_update_patch_state(struct task_struct *task) {}
 
 #endif /* CONFIG_LIVEPATCH */
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index af46438..217b39d 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -64,6 +64,9 @@ static LIST_HEAD(klp_ops);
 
 static struct kobject *klp_root_kobj;
 
+/* TODO: temporary stub */
+void klp_update_patch_state(struct task_struct *task) {}
+
 static struct klp_ops *klp_find_ops(unsigned long old_addr)
 {
 	struct klp_ops *ops;
-- 
2.7.4
