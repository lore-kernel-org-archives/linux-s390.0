Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 08/18] livepatch: temporary stubs for
 klp_patch_pending() and klp_patch_task()
Date: Thu, 28 Apr 2016 15:44:39 -0500
Message-Id: <887523cb94f22fb08fdd8843a0ecdf14666000d0.1461875890.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1461875890.git.jpoimboe@redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Create temporary stubs for klp_patch_pending() and klp_patch_task() so
we can add TIF_PATCH_PENDING to different architectures in separate
patches without breaking build bisectability.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/livepatch.h | 7 ++++++-
 kernel/livepatch/core.c   | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 0933ca4..a8c6c9c 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -118,10 +118,15 @@ int klp_disable_patch(struct klp_patch *);
 int klp_module_coming(struct module *mod);
 void klp_module_going(struct module *mod);
 
+static inline bool klp_patch_pending(struct task_struct *task) { return false; }
+void klp_patch_task(struct task_struct *task);
+
 #else /* !CONFIG_LIVEPATCH */
 
 static inline int klp_module_coming(struct module *mod) { return 0; }
-static inline void klp_module_going(struct module *mod) { }
+static inline void klp_module_going(struct module *mod) {}
+static inline bool klp_patch_pending(struct task_struct *task) { return false; }
+static inline void klp_patch_task(struct task_struct *task) {}
 
 #endif /* CONFIG_LIVEPATCH */
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a19f195..6ea6880 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -64,6 +64,9 @@ static LIST_HEAD(klp_ops);
 
 static struct kobject *klp_root_kobj;
 
+/* TODO: temporary stub */
+void klp_patch_task(struct task_struct *task) {}
+
 static struct klp_ops *klp_find_ops(unsigned long old_addr)
 {
 	struct klp_ops *ops;
-- 
2.4.11
