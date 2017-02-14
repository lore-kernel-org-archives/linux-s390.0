Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 15/15] livepatch: allow removal of a disabled patch
Date: Mon, 13 Feb 2017 19:42:42 -0600
Message-Id: <95fe68239fc91360093f84aea97418ae88cfc634.1487036215.git.jpoimboe@redhat.com>
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

From: Miroslav Benes <mbenes@suse.cz>

Currently we do not allow patch module to unload since there is no
method to determine if a task is still running in the patched code.

The consistency model gives us the way because when the unpatching
finishes we know that all tasks were marked as safe to call an original
function. Thus every new call to the function calls the original code
and at the same time no task can be somewhere in the patched code,
because it had to leave that code to be marked as safe.

We can safely let the patch module go after that.

Completion is used for synchronization between module removal and sysfs
infrastructure in a similar way to commit 942e443127e9 ("module: Fix
mod->mkobj.kobj potentially freed too early").

Note that we still do not allow the removal for immediate model, that is
no consistency model. The module refcount may increase in this case if
somebody disables and enables the patch several times. This should not
cause any harm.

With this change a call to try_module_get() is moved to
__klp_enable_patch from klp_register_patch to make module reference
counting symmetric (module_put() is in a patch disable path) and to
allow to take a new reference to a disabled module when being enabled.

Finally, we need to be very careful about possible races between
klp_unregister_patch(), kobject_put() functions and operations
on the related sysfs files.

kobject_put(&patch->kobj) must be called without klp_mutex. Otherwise,
it might be blocked by enabled_store() that needs the mutex as well.
In addition, enabled_store() must check if the patch was not
unregisted in the meantime.

There is no need to do the same for other kobject_put() callsites
at the moment. Their sysfs operations neither take the lock nor
they access any data that might be freed in the meantime.

There was an attempt to use kobjects the right way and prevent these
races by design. But it made the patch definition more complicated
and opened another can of worms. See
https://lkml.kernel.org/r/1464018848-4303-1-git-send-email-pmladek@suse.com

[Thanks to Petr Mladek for improving the commit message.]

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/livepatch/livepatch.txt | 28 ++++--------
 include/linux/livepatch.h             |  3 ++
 kernel/livepatch/core.c               | 80 ++++++++++++++++++++++-------------
 kernel/livepatch/transition.c         | 12 +++++-
 samples/livepatch/livepatch-sample.c  |  1 -
 5 files changed, 72 insertions(+), 52 deletions(-)

diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 4f2aec8..ecdb181 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -316,8 +316,15 @@ section "Livepatch life-cycle" below for more details about these
 two operations.
 
 Module removal is only safe when there are no users of the underlying
-functions.  The immediate consistency model is not able to detect this;
-therefore livepatch modules cannot be removed. See "Limitations" below.
+functions. The immediate consistency model is not able to detect this. The
+code just redirects the functions at the very beginning and it does not
+check if the functions are in use. In other words, it knows when the
+functions get called but it does not know when the functions return.
+Therefore it cannot be decided when the livepatch module can be safely
+removed. This is solved by a hybrid consistency model. When the system is
+transitioned to a new patch state (patched/unpatched) it is guaranteed that
+no task sleeps or runs in the old code.
+
 
 5. Livepatch life-cycle
 =======================
@@ -469,23 +476,6 @@ The current Livepatch implementation has several limitations:
     by "notrace".
 
 
-  + Livepatch modules can not be removed.
-
-    The current implementation just redirects the functions at the very
-    beginning. It does not check if the functions are in use. In other
-    words, it knows when the functions get called but it does not
-    know when the functions return. Therefore it can not decide when
-    the livepatch module can be safely removed.
-
-    This will get most likely solved once a more complex consistency model
-    is supported. The idea is that a safe state for patching should also
-    mean a safe state for removing the patch.
-
-    Note that the patch itself might get disabled by writing zero
-    to /sys/kernel/livepatch/<patch>/enabled. It causes that the new
-    code will not longer get called. But it does not guarantee
-    that anyone is not sleeping anywhere in the new code.
-
 
   + Livepatch works reliably only when the dynamic ftrace is located at
     the very beginning of the function.
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ed90ad1..194991e 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/completion.h>
 
 #if IS_ENABLED(CONFIG_LIVEPATCH)
 
@@ -114,6 +115,7 @@ struct klp_object {
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
  * @enabled:	the patch is enabled (but operation may be incomplete)
+ * @finish:	for waiting till it is safe to remove the patch module
  */
 struct klp_patch {
 	/* external */
@@ -125,6 +127,7 @@ struct klp_patch {
 	struct list_head list;
 	struct kobject kobj;
 	bool enabled;
+	struct completion finish;
 };
 
 #define klp_for_each_object(patch, obj) \
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 3dc3c90..6844c12 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -29,6 +29,7 @@
 #include <linux/livepatch.h>
 #include <linux/elf.h>
 #include <linux/moduleloader.h>
+#include <linux/completion.h>
 #include <asm/cacheflush.h>
 #include "patch.h"
 #include "transition.h"
@@ -354,6 +355,18 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	    !list_prev_entry(patch, list)->enabled)
 		return -EBUSY;
 
+	/*
+	 * A reference is taken on the patch module to prevent it from being
+	 * unloaded.
+	 *
+	 * Note: For immediate (no consistency model) patches we don't allow
+	 * patch modules to unload since there is no safe/sane method to
+	 * determine if a thread is still running in the patched code contained
+	 * in the patch module once the ftrace registration is successful.
+	 */
+	if (!try_module_get(patch->mod))
+		return -ENODEV;
+
 	pr_notice("enabling patch '%s'\n", patch->mod->name);
 
 	klp_init_transition(patch, KLP_PATCHED);
@@ -442,6 +455,15 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	mutex_lock(&klp_mutex);
 
+	if (!klp_is_patch_registered(patch)) {
+		/*
+		 * Module with the patch could either disappear meanwhile or is
+		 * not properly initialized yet.
+		 */
+		ret = -EINVAL;
+		goto err;
+	}
+
 	if (patch->enabled == enabled) {
 		/* already in requested state */
 		ret = -EINVAL;
@@ -498,10 +520,10 @@ static struct attribute *klp_patch_attrs[] = {
 
 static void klp_kobj_release_patch(struct kobject *kobj)
 {
-	/*
-	 * Once we have a consistency model we'll need to module_put() the
-	 * patch module here.  See klp_register_patch() for more details.
-	 */
+	struct klp_patch *patch;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+	complete(&patch->finish);
 }
 
 static struct kobj_type klp_ktype_patch = {
@@ -572,7 +594,6 @@ static void klp_free_patch(struct klp_patch *patch)
 	klp_free_objects_limited(patch, NULL);
 	if (!list_empty(&patch->list))
 		list_del(&patch->list);
-	kobject_put(&patch->kobj);
 }
 
 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
@@ -695,11 +716,14 @@ static int klp_init_patch(struct klp_patch *patch)
 	mutex_lock(&klp_mutex);
 
 	patch->enabled = false;
+	init_completion(&patch->finish);
 
 	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
 				   klp_root_kobj, "%s", patch->mod->name);
-	if (ret)
-		goto unlock;
+	if (ret) {
+		mutex_unlock(&klp_mutex);
+		return ret;
+	}
 
 	klp_for_each_object(patch, obj) {
 		ret = klp_init_object(patch, obj);
@@ -715,9 +739,12 @@ static int klp_init_patch(struct klp_patch *patch)
 
 free:
 	klp_free_objects_limited(patch, obj);
-	kobject_put(&patch->kobj);
-unlock:
+
 	mutex_unlock(&klp_mutex);
+
+	kobject_put(&patch->kobj);
+	wait_for_completion(&patch->finish);
+
 	return ret;
 }
 
@@ -731,23 +758,29 @@ static int klp_init_patch(struct klp_patch *patch)
  */
 int klp_unregister_patch(struct klp_patch *patch)
 {
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&klp_mutex);
 
 	if (!klp_is_patch_registered(patch)) {
 		ret = -EINVAL;
-		goto out;
+		goto err;
 	}
 
 	if (patch->enabled) {
 		ret = -EBUSY;
-		goto out;
+		goto err;
 	}
 
 	klp_free_patch(patch);
 
-out:
+	mutex_unlock(&klp_mutex);
+
+	kobject_put(&patch->kobj);
+	wait_for_completion(&patch->finish);
+
+	return 0;
+err:
 	mutex_unlock(&klp_mutex);
 	return ret;
 }
@@ -760,12 +793,13 @@ EXPORT_SYMBOL_GPL(klp_unregister_patch);
  * Initializes the data structure associated with the patch and
  * creates the sysfs interface.
  *
+ * There is no need to take the reference on the patch module here. It is done
+ * later when the patch is enabled.
+ *
  * Return: 0 on success, otherwise error
  */
 int klp_register_patch(struct klp_patch *patch)
 {
-	int ret;
-
 	if (!patch || !patch->mod)
 		return -EINVAL;
 
@@ -788,21 +822,7 @@ int klp_register_patch(struct klp_patch *patch)
 		return -ENOSYS;
 	}
 
-	/*
-	 * A reference is taken on the patch module to prevent it from being
-	 * unloaded.  Right now, we don't allow patch modules to unload since
-	 * there is currently no method to determine if a thread is still
-	 * running in the patched code contained in the patch module once
-	 * the ftrace registration is successful.
-	 */
-	if (!try_module_get(patch->mod))
-		return -ENODEV;
-
-	ret = klp_init_patch(patch);
-	if (ret)
-		module_put(patch->mod);
-
-	return ret;
+	return klp_init_patch(patch);
 }
 EXPORT_SYMBOL_GPL(klp_register_patch);
 
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 428533e..e96346e 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -59,6 +59,7 @@ static void klp_complete_transition(void)
 	struct klp_func *func;
 	struct task_struct *g, *task;
 	unsigned int cpu;
+	bool is_immediate = false;
 
 	if (klp_target_state == KLP_UNPATCHED) {
 		/*
@@ -79,9 +80,16 @@ static void klp_complete_transition(void)
 	if (klp_transition_patch->immediate)
 		goto done;
 
-	klp_for_each_object(klp_transition_patch, obj)
-		klp_for_each_func(obj, func)
+	klp_for_each_object(klp_transition_patch, obj) {
+		klp_for_each_func(obj, func) {
 			func->transition = false;
+			if (func->immediate)
+				is_immediate = true;
+		}
+	}
+
+	if (klp_target_state == KLP_UNPATCHED && !is_immediate)
+		module_put(klp_transition_patch->mod);
 
 	/* Prevent klp_ftrace_handler() from seeing KLP_UNDEFINED state */
 	if (klp_target_state == KLP_PATCHED)
diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
index 629e0dc..84795223f 100644
--- a/samples/livepatch/livepatch-sample.c
+++ b/samples/livepatch/livepatch-sample.c
@@ -99,7 +99,6 @@ static int livepatch_init(void)
 
 static void livepatch_exit(void)
 {
-	WARN_ON(klp_disable_patch(&patch));
 	WARN_ON(klp_unregister_patch(&patch));
 }
 
-- 
2.7.4
