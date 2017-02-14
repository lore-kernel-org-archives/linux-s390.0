Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 10/15] livepatch: move patching functions into patch.c
Date: Mon, 13 Feb 2017 19:42:37 -0600
Message-Id: <eb7f5ccf7b384108f7f4c63bebb9569aff5bc816.1487036215.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1487036215.git.jpoimboe@redhat.com>
References: <cover.1487036215.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Move functions related to the actual patching of functions and objects
into a new patch.c file.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 kernel/livepatch/Makefile |   2 +-
 kernel/livepatch/core.c   | 202 +------------------------------------------
 kernel/livepatch/patch.c  | 213 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/livepatch/patch.h  |  32 +++++++
 4 files changed, 247 insertions(+), 202 deletions(-)
 create mode 100644 kernel/livepatch/patch.c
 create mode 100644 kernel/livepatch/patch.h

diff --git a/kernel/livepatch/Makefile b/kernel/livepatch/Makefile
index e8780c0..e136dad 100644
--- a/kernel/livepatch/Makefile
+++ b/kernel/livepatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 
-livepatch-objs := core.o
+livepatch-objs := core.o patch.o
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 47ed643..6a137e1 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -24,32 +24,13 @@
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/ftrace.h>
 #include <linux/list.h>
 #include <linux/kallsyms.h>
 #include <linux/livepatch.h>
 #include <linux/elf.h>
 #include <linux/moduleloader.h>
 #include <asm/cacheflush.h>
-
-/**
- * struct klp_ops - structure for tracking registered ftrace ops structs
- *
- * A single ftrace_ops is shared between all enabled replacement functions
- * (klp_func structs) which have the same old_addr.  This allows the switch
- * between function versions to happen instantaneously by updating the klp_ops
- * struct's func_stack list.  The winner is the klp_func at the top of the
- * func_stack (front of the list).
- *
- * @node:	node for the global klp_ops list
- * @func_stack:	list head for the stack of klp_func's (active func is on top)
- * @fops:	registered ftrace ops struct
- */
-struct klp_ops {
-	struct list_head node;
-	struct list_head func_stack;
-	struct ftrace_ops fops;
-};
+#include "patch.h"
 
 /*
  * The klp_mutex protects the global lists and state transitions of any
@@ -60,28 +41,12 @@ struct klp_ops {
 static DEFINE_MUTEX(klp_mutex);
 
 static LIST_HEAD(klp_patches);
-static LIST_HEAD(klp_ops);
 
 static struct kobject *klp_root_kobj;
 
 /* TODO: temporary stub */
 void klp_update_patch_state(struct task_struct *task) {}
 
-static struct klp_ops *klp_find_ops(unsigned long old_addr)
-{
-	struct klp_ops *ops;
-	struct klp_func *func;
-
-	list_for_each_entry(ops, &klp_ops, node) {
-		func = list_first_entry(&ops->func_stack, struct klp_func,
-					stack_node);
-		if (func->old_addr == old_addr)
-			return ops;
-	}
-
-	return NULL;
-}
-
 static bool klp_is_module(struct klp_object *obj)
 {
 	return obj->name;
@@ -314,171 +279,6 @@ static int klp_write_object_relocations(struct module *pmod,
 	return ret;
 }
 
-static void notrace klp_ftrace_handler(unsigned long ip,
-				       unsigned long parent_ip,
-				       struct ftrace_ops *fops,
-				       struct pt_regs *regs)
-{
-	struct klp_ops *ops;
-	struct klp_func *func;
-
-	ops = container_of(fops, struct klp_ops, fops);
-
-	rcu_read_lock();
-	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
-				      stack_node);
-	if (WARN_ON_ONCE(!func))
-		goto unlock;
-
-	klp_arch_set_pc(regs, (unsigned long)func->new_func);
-unlock:
-	rcu_read_unlock();
-}
-
-/*
- * Convert a function address into the appropriate ftrace location.
- *
- * Usually this is just the address of the function, but on some architectures
- * it's more complicated so allow them to provide a custom behaviour.
- */
-#ifndef klp_get_ftrace_location
-static unsigned long klp_get_ftrace_location(unsigned long faddr)
-{
-	return faddr;
-}
-#endif
-
-static void klp_unpatch_func(struct klp_func *func)
-{
-	struct klp_ops *ops;
-
-	if (WARN_ON(!func->patched))
-		return;
-	if (WARN_ON(!func->old_addr))
-		return;
-
-	ops = klp_find_ops(func->old_addr);
-	if (WARN_ON(!ops))
-		return;
-
-	if (list_is_singular(&ops->func_stack)) {
-		unsigned long ftrace_loc;
-
-		ftrace_loc = klp_get_ftrace_location(func->old_addr);
-		if (WARN_ON(!ftrace_loc))
-			return;
-
-		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
-
-		list_del_rcu(&func->stack_node);
-		list_del(&ops->node);
-		kfree(ops);
-	} else {
-		list_del_rcu(&func->stack_node);
-	}
-
-	func->patched = false;
-}
-
-static int klp_patch_func(struct klp_func *func)
-{
-	struct klp_ops *ops;
-	int ret;
-
-	if (WARN_ON(!func->old_addr))
-		return -EINVAL;
-
-	if (WARN_ON(func->patched))
-		return -EINVAL;
-
-	ops = klp_find_ops(func->old_addr);
-	if (!ops) {
-		unsigned long ftrace_loc;
-
-		ftrace_loc = klp_get_ftrace_location(func->old_addr);
-		if (!ftrace_loc) {
-			pr_err("failed to find location for function '%s'\n",
-				func->old_name);
-			return -EINVAL;
-		}
-
-		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
-		if (!ops)
-			return -ENOMEM;
-
-		ops->fops.func = klp_ftrace_handler;
-		ops->fops.flags = FTRACE_OPS_FL_SAVE_REGS |
-				  FTRACE_OPS_FL_DYNAMIC |
-				  FTRACE_OPS_FL_IPMODIFY;
-
-		list_add(&ops->node, &klp_ops);
-
-		INIT_LIST_HEAD(&ops->func_stack);
-		list_add_rcu(&func->stack_node, &ops->func_stack);
-
-		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
-		if (ret) {
-			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
-			       func->old_name, ret);
-			goto err;
-		}
-
-		ret = register_ftrace_function(&ops->fops);
-		if (ret) {
-			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
-			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
-			goto err;
-		}
-
-
-	} else {
-		list_add_rcu(&func->stack_node, &ops->func_stack);
-	}
-
-	func->patched = true;
-
-	return 0;
-
-err:
-	list_del_rcu(&func->stack_node);
-	list_del(&ops->node);
-	kfree(ops);
-	return ret;
-}
-
-static void klp_unpatch_object(struct klp_object *obj)
-{
-	struct klp_func *func;
-
-	klp_for_each_func(obj, func)
-		if (func->patched)
-			klp_unpatch_func(func);
-
-	obj->patched = false;
-}
-
-static int klp_patch_object(struct klp_object *obj)
-{
-	struct klp_func *func;
-	int ret;
-
-	if (WARN_ON(obj->patched))
-		return -EINVAL;
-
-	klp_for_each_func(obj, func) {
-		ret = klp_patch_func(func);
-		if (ret) {
-			klp_unpatch_object(obj);
-			return ret;
-		}
-	}
-	obj->patched = true;
-
-	return 0;
-}
-
 static int __klp_disable_patch(struct klp_patch *patch)
 {
 	struct klp_object *obj;
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
new file mode 100644
index 0000000..5efa262
--- /dev/null
+++ b/kernel/livepatch/patch.c
@@ -0,0 +1,213 @@
+/*
+ * patch.c - livepatch patching functions
+ *
+ * Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
+ * Copyright (C) 2014 SUSE
+ * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/livepatch.h>
+#include <linux/list.h>
+#include <linux/ftrace.h>
+#include <linux/rculist.h>
+#include <linux/slab.h>
+#include <linux/bug.h>
+#include <linux/printk.h>
+#include "patch.h"
+
+static LIST_HEAD(klp_ops);
+
+struct klp_ops *klp_find_ops(unsigned long old_addr)
+{
+	struct klp_ops *ops;
+	struct klp_func *func;
+
+	list_for_each_entry(ops, &klp_ops, node) {
+		func = list_first_entry(&ops->func_stack, struct klp_func,
+					stack_node);
+		if (func->old_addr == old_addr)
+			return ops;
+	}
+
+	return NULL;
+}
+
+static void notrace klp_ftrace_handler(unsigned long ip,
+				       unsigned long parent_ip,
+				       struct ftrace_ops *fops,
+				       struct pt_regs *regs)
+{
+	struct klp_ops *ops;
+	struct klp_func *func;
+
+	ops = container_of(fops, struct klp_ops, fops);
+
+	rcu_read_lock();
+	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
+				      stack_node);
+	if (WARN_ON_ONCE(!func))
+		goto unlock;
+
+	klp_arch_set_pc(regs, (unsigned long)func->new_func);
+unlock:
+	rcu_read_unlock();
+}
+
+/*
+ * Convert a function address into the appropriate ftrace location.
+ *
+ * Usually this is just the address of the function, but on some architectures
+ * it's more complicated so allow them to provide a custom behaviour.
+ */
+#ifndef klp_get_ftrace_location
+static unsigned long klp_get_ftrace_location(unsigned long faddr)
+{
+	return faddr;
+}
+#endif
+
+static void klp_unpatch_func(struct klp_func *func)
+{
+	struct klp_ops *ops;
+
+	if (WARN_ON(!func->patched))
+		return;
+	if (WARN_ON(!func->old_addr))
+		return;
+
+	ops = klp_find_ops(func->old_addr);
+	if (WARN_ON(!ops))
+		return;
+
+	if (list_is_singular(&ops->func_stack)) {
+		unsigned long ftrace_loc;
+
+		ftrace_loc = klp_get_ftrace_location(func->old_addr);
+		if (WARN_ON(!ftrace_loc))
+			return;
+
+		WARN_ON(unregister_ftrace_function(&ops->fops));
+		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
+
+		list_del_rcu(&func->stack_node);
+		list_del(&ops->node);
+		kfree(ops);
+	} else {
+		list_del_rcu(&func->stack_node);
+	}
+
+	func->patched = false;
+}
+
+static int klp_patch_func(struct klp_func *func)
+{
+	struct klp_ops *ops;
+	int ret;
+
+	if (WARN_ON(!func->old_addr))
+		return -EINVAL;
+
+	if (WARN_ON(func->patched))
+		return -EINVAL;
+
+	ops = klp_find_ops(func->old_addr);
+	if (!ops) {
+		unsigned long ftrace_loc;
+
+		ftrace_loc = klp_get_ftrace_location(func->old_addr);
+		if (!ftrace_loc) {
+			pr_err("failed to find location for function '%s'\n",
+				func->old_name);
+			return -EINVAL;
+		}
+
+		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+		if (!ops)
+			return -ENOMEM;
+
+		ops->fops.func = klp_ftrace_handler;
+		ops->fops.flags = FTRACE_OPS_FL_SAVE_REGS |
+				  FTRACE_OPS_FL_DYNAMIC |
+				  FTRACE_OPS_FL_IPMODIFY;
+
+		list_add(&ops->node, &klp_ops);
+
+		INIT_LIST_HEAD(&ops->func_stack);
+		list_add_rcu(&func->stack_node, &ops->func_stack);
+
+		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
+		if (ret) {
+			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
+			       func->old_name, ret);
+			goto err;
+		}
+
+		ret = register_ftrace_function(&ops->fops);
+		if (ret) {
+			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
+			       func->old_name, ret);
+			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
+			goto err;
+		}
+
+
+	} else {
+		list_add_rcu(&func->stack_node, &ops->func_stack);
+	}
+
+	func->patched = true;
+
+	return 0;
+
+err:
+	list_del_rcu(&func->stack_node);
+	list_del(&ops->node);
+	kfree(ops);
+	return ret;
+}
+
+void klp_unpatch_object(struct klp_object *obj)
+{
+	struct klp_func *func;
+
+	klp_for_each_func(obj, func)
+		if (func->patched)
+			klp_unpatch_func(func);
+
+	obj->patched = false;
+}
+
+int klp_patch_object(struct klp_object *obj)
+{
+	struct klp_func *func;
+	int ret;
+
+	if (WARN_ON(obj->patched))
+		return -EINVAL;
+
+	klp_for_each_func(obj, func) {
+		ret = klp_patch_func(func);
+		if (ret) {
+			klp_unpatch_object(obj);
+			return ret;
+		}
+	}
+	obj->patched = true;
+
+	return 0;
+}
diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
new file mode 100644
index 0000000..2d0cce0
--- /dev/null
+++ b/kernel/livepatch/patch.h
@@ -0,0 +1,32 @@
+#ifndef _LIVEPATCH_PATCH_H
+#define _LIVEPATCH_PATCH_H
+
+#include <linux/livepatch.h>
+#include <linux/list.h>
+#include <linux/ftrace.h>
+
+/**
+ * struct klp_ops - structure for tracking registered ftrace ops structs
+ *
+ * A single ftrace_ops is shared between all enabled replacement functions
+ * (klp_func structs) which have the same old_addr.  This allows the switch
+ * between function versions to happen instantaneously by updating the klp_ops
+ * struct's func_stack list.  The winner is the klp_func at the top of the
+ * func_stack (front of the list).
+ *
+ * @node:	node for the global klp_ops list
+ * @func_stack:	list head for the stack of klp_func's (active func is on top)
+ * @fops:	registered ftrace ops struct
+ */
+struct klp_ops {
+	struct list_head node;
+	struct list_head func_stack;
+	struct ftrace_ops fops;
+};
+
+struct klp_ops *klp_find_ops(unsigned long old_addr);
+
+int klp_patch_object(struct klp_object *obj);
+void klp_unpatch_object(struct klp_object *obj);
+
+#endif /* _LIVEPATCH_PATCH_H */
-- 
2.7.4
