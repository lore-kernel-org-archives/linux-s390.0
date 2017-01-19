Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 08/15] livepatch: separate enabled and patched states
Date: Thu, 19 Jan 2017 09:46:16 -0600
Message-Id: <d274474df2bdb08285335651dcac908ac31fa18a.1484839971.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1484839971.git.jpoimboe@redhat.com>
References: <cover.1484839971.git.jpoimboe@redhat.com>
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

Once we have a consistency model, patches and their objects will be
enabled and disabled at different times.  For example, when a patch is
disabled, its loaded objects' funcs can remain registered with ftrace
indefinitely until the unpatching operation is complete and they're no
longer in use.

It's less confusing if we give them different names: patches can be
enabled or disabled; objects (and their funcs) can be patched or
unpatched:

- Enabled means that a patch is logically enabled (but not necessarily
  fully applied).

- Patched means that an object's funcs are registered with ftrace and
  added to the klp_ops func stack.

Also, since these states are binary, represent them with booleans
instead of ints.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 include/linux/livepatch.h | 17 ++++-------
 kernel/livepatch/core.c   | 72 +++++++++++++++++++++++------------------------
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 5cc20e5..9787a63 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -28,11 +28,6 @@
 
 #include <asm/livepatch.h>
 
-enum klp_state {
-	KLP_DISABLED,
-	KLP_ENABLED
-};
-
 /**
  * struct klp_func - function structure for live patching
  * @old_name:	name of the function to be patched
@@ -41,8 +36,8 @@ enum klp_state {
  *		can be found (optional)
  * @old_addr:	the address of the function being patched
  * @kobj:	kobject for sysfs resources
- * @state:	tracks function-level patch application state
  * @stack_node:	list node for klp_ops func_stack list
+ * @patched:	the func has been added to the klp_ops list
  */
 struct klp_func {
 	/* external */
@@ -60,8 +55,8 @@ struct klp_func {
 	/* internal */
 	unsigned long old_addr;
 	struct kobject kobj;
-	enum klp_state state;
 	struct list_head stack_node;
+	bool patched;
 };
 
 /**
@@ -71,7 +66,7 @@ struct klp_func {
  * @kobj:	kobject for sysfs resources
  * @mod:	kernel module associated with the patched object
  * 		(NULL for vmlinux)
- * @state:	tracks object-level patch application state
+ * @patched:	the object's funcs have been added to the klp_ops list
  */
 struct klp_object {
 	/* external */
@@ -81,7 +76,7 @@ struct klp_object {
 	/* internal */
 	struct kobject kobj;
 	struct module *mod;
-	enum klp_state state;
+	bool patched;
 };
 
 /**
@@ -90,7 +85,7 @@ struct klp_object {
  * @objs:	object entries for kernel objects to be patched
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
- * @state:	tracks patch-level application state
+ * @enabled:	the patch is enabled (but operation may be incomplete)
  */
 struct klp_patch {
 	/* external */
@@ -100,7 +95,7 @@ struct klp_patch {
 	/* internal */
 	struct list_head list;
 	struct kobject kobj;
-	enum klp_state state;
+	bool enabled;
 };
 
 #define klp_for_each_object(patch, obj) \
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 217b39d..2dbd355 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -348,11 +348,11 @@ static unsigned long klp_get_ftrace_location(unsigned long faddr)
 }
 #endif
 
-static void klp_disable_func(struct klp_func *func)
+static void klp_unpatch_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
 
-	if (WARN_ON(func->state != KLP_ENABLED))
+	if (WARN_ON(!func->patched))
 		return;
 	if (WARN_ON(!func->old_addr))
 		return;
@@ -378,10 +378,10 @@ static void klp_disable_func(struct klp_func *func)
 		list_del_rcu(&func->stack_node);
 	}
 
-	func->state = KLP_DISABLED;
+	func->patched = false;
 }
 
-static int klp_enable_func(struct klp_func *func)
+static int klp_patch_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
 	int ret;
@@ -389,7 +389,7 @@ static int klp_enable_func(struct klp_func *func)
 	if (WARN_ON(!func->old_addr))
 		return -EINVAL;
 
-	if (WARN_ON(func->state != KLP_DISABLED))
+	if (WARN_ON(func->patched))
 		return -EINVAL;
 
 	ops = klp_find_ops(func->old_addr);
@@ -437,7 +437,7 @@ static int klp_enable_func(struct klp_func *func)
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 	}
 
-	func->state = KLP_ENABLED;
+	func->patched = true;
 
 	return 0;
 
@@ -448,36 +448,36 @@ static int klp_enable_func(struct klp_func *func)
 	return ret;
 }
 
-static void klp_disable_object(struct klp_object *obj)
+static void klp_unpatch_object(struct klp_object *obj)
 {
 	struct klp_func *func;
 
 	klp_for_each_func(obj, func)
-		if (func->state == KLP_ENABLED)
-			klp_disable_func(func);
+		if (func->patched)
+			klp_unpatch_func(func);
 
-	obj->state = KLP_DISABLED;
+	obj->patched = false;
 }
 
-static int klp_enable_object(struct klp_object *obj)
+static int klp_patch_object(struct klp_object *obj)
 {
 	struct klp_func *func;
 	int ret;
 
-	if (WARN_ON(obj->state != KLP_DISABLED))
+	if (WARN_ON(obj->patched))
 		return -EINVAL;
 
 	if (WARN_ON(!klp_is_object_loaded(obj)))
 		return -EINVAL;
 
 	klp_for_each_func(obj, func) {
-		ret = klp_enable_func(func);
+		ret = klp_patch_func(func);
 		if (ret) {
-			klp_disable_object(obj);
+			klp_unpatch_object(obj);
 			return ret;
 		}
 	}
-	obj->state = KLP_ENABLED;
+	obj->patched = true;
 
 	return 0;
 }
@@ -488,17 +488,17 @@ static int __klp_disable_patch(struct klp_patch *patch)
 
 	/* enforce stacking: only the last enabled patch can be disabled */
 	if (!list_is_last(&patch->list, &klp_patches) &&
-	    list_next_entry(patch, list)->state == KLP_ENABLED)
+	    list_next_entry(patch, list)->enabled)
 		return -EBUSY;
 
 	pr_notice("disabling patch '%s'\n", patch->mod->name);
 
 	klp_for_each_object(patch, obj) {
-		if (obj->state == KLP_ENABLED)
-			klp_disable_object(obj);
+		if (obj->patched)
+			klp_unpatch_object(obj);
 	}
 
-	patch->state = KLP_DISABLED;
+	patch->enabled = false;
 
 	return 0;
 }
@@ -522,7 +522,7 @@ int klp_disable_patch(struct klp_patch *patch)
 		goto err;
 	}
 
-	if (patch->state == KLP_DISABLED) {
+	if (!patch->enabled) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -540,12 +540,12 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	struct klp_object *obj;
 	int ret;
 
-	if (WARN_ON(patch->state != KLP_DISABLED))
+	if (WARN_ON(patch->enabled))
 		return -EINVAL;
 
 	/* enforce stacking: only the first disabled patch can be enabled */
 	if (patch->list.prev != &klp_patches &&
-	    list_prev_entry(patch, list)->state == KLP_DISABLED)
+	    !list_prev_entry(patch, list)->enabled)
 		return -EBUSY;
 
 	pr_notice("enabling patch '%s'\n", patch->mod->name);
@@ -554,12 +554,12 @@ static int __klp_enable_patch(struct klp_patch *patch)
 		if (!klp_is_object_loaded(obj))
 			continue;
 
-		ret = klp_enable_object(obj);
+		ret = klp_patch_object(obj);
 		if (ret)
 			goto unregister;
 	}
 
-	patch->state = KLP_ENABLED;
+	patch->enabled = true;
 
 	return 0;
 
@@ -617,20 +617,20 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (ret)
 		return -EINVAL;
 
-	if (val != KLP_DISABLED && val != KLP_ENABLED)
+	if (val > 1)
 		return -EINVAL;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
 
 	mutex_lock(&klp_mutex);
 
-	if (val == patch->state) {
+	if (patch->enabled == val) {
 		/* already in requested state */
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (val == KLP_ENABLED) {
+	if (val) {
 		ret = __klp_enable_patch(patch);
 		if (ret)
 			goto err;
@@ -655,7 +655,7 @@ static ssize_t enabled_show(struct kobject *kobj,
 	struct klp_patch *patch;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
-	return snprintf(buf, PAGE_SIZE-1, "%d\n", patch->state);
+	return snprintf(buf, PAGE_SIZE-1, "%d\n", patch->enabled);
 }
 
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
@@ -749,7 +749,7 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&func->stack_node);
-	func->state = KLP_DISABLED;
+	func->patched = false;
 
 	/* The format for the sysfs directory is <function,sympos> where sympos
 	 * is the nth occurrence of this symbol in kallsyms for the patched
@@ -804,7 +804,7 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 	if (!obj->funcs)
 		return -EINVAL;
 
-	obj->state = KLP_DISABLED;
+	obj->patched = false;
 	obj->mod = NULL;
 
 	klp_find_object_module(obj);
@@ -845,7 +845,7 @@ static int klp_init_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	patch->state = KLP_DISABLED;
+	patch->enabled = false;
 
 	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
 				   klp_root_kobj, "%s", patch->mod->name);
@@ -891,7 +891,7 @@ int klp_unregister_patch(struct klp_patch *patch)
 		goto out;
 	}
 
-	if (patch->state == KLP_ENABLED) {
+	if (patch->enabled) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -978,13 +978,13 @@ int klp_module_coming(struct module *mod)
 				goto err;
 			}
 
-			if (patch->state == KLP_DISABLED)
+			if (!patch->enabled)
 				break;
 
 			pr_notice("applying patch '%s' to loading module '%s'\n",
 				  patch->mod->name, obj->mod->name);
 
-			ret = klp_enable_object(obj);
+			ret = klp_patch_object(obj);
 			if (ret) {
 				pr_warn("failed to apply patch '%s' to module '%s' (%d)\n",
 					patch->mod->name, obj->mod->name, ret);
@@ -1035,10 +1035,10 @@ void klp_module_going(struct module *mod)
 			if (!klp_is_module(obj) || strcmp(obj->name, mod->name))
 				continue;
 
-			if (patch->state != KLP_DISABLED) {
+			if (patch->enabled) {
 				pr_notice("reverting patch '%s' on unloading module '%s'\n",
 					  patch->mod->name, obj->mod->name);
-				klp_disable_object(obj);
+				klp_unpatch_object(obj);
 			}
 
 			klp_free_object_loaded(obj);
-- 
2.7.4
