Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 12/15] livepatch: store function sizes
Date: Thu,  8 Dec 2016 12:08:37 -0600
Message-Id: <830c8cc09323addf5b3d5e708be371044ea38651.1481220077.git.jpoimboe@redhat.com>
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

For the consistency model we'll need to know the sizes of the old and
new functions to determine if they're on the stacks of any tasks.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/livepatch.h |  3 +++
 kernel/livepatch/core.c   | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 1e2eb91..1a5a93c 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -37,6 +37,8 @@
  * @old_addr:	the address of the function being patched
  * @kobj:	kobject for sysfs resources
  * @stack_node:	list node for klp_ops func_stack list
+ * @old_size:	size of the old function
+ * @new_size:	size of the new function
  * @patched:	the func has been added to the klp_ops list
  */
 struct klp_func {
@@ -56,6 +58,7 @@ struct klp_func {
 	unsigned long old_addr;
 	struct kobject kobj;
 	struct list_head stack_node;
+	unsigned long old_size, new_size;
 	bool patched;
 };
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 8ca8a0e..fc160c6 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -584,6 +584,22 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 					     &func->old_addr);
 		if (ret)
 			return ret;
+
+		ret = kallsyms_lookup_size_offset(func->old_addr,
+						  &func->old_size, NULL);
+		if (!ret) {
+			pr_err("kallsyms size lookup failed for '%s'\n",
+			       func->old_name);
+			return -ENOENT;
+		}
+
+		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
+						  &func->new_size, NULL);
+		if (!ret) {
+			pr_err("kallsyms size lookup failed for '%s' replacement\n",
+			       func->old_name);
+			return -ENOENT;
+		}
 	}
 
 	return 0;
-- 
2.7.4
