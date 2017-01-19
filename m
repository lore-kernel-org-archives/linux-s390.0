Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 12/15] livepatch: store function sizes
Date: Thu, 19 Jan 2017 09:46:20 -0600
Message-Id: <2df8ae798ca9be5cfb9d49cd7dafee0e3ce4aced.1484839971.git.jpoimboe@redhat.com>
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

For the consistency model we'll need to know the sizes of the old and
new functions to determine if they're on the stacks of any tasks.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 include/linux/livepatch.h |  3 +++
 kernel/livepatch/core.c   | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 9787a63..6602b34 100644
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
index 83c4949..10ba3a1 100644
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
