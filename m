Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 18/18] livepatch: add /proc/<pid>/patch_state
Date: Thu, 28 Apr 2016 15:44:49 -0500
Message-Id: <f17f1adde39724b662d6ff0a39987bff64a3fe25.1461875890.git.jpoimboe@redhat.com>
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

Expose the per-task patch state value so users can determine which tasks
are holding up completion of a patching operation.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/filesystems/proc.txt | 18 ++++++++++++++++++
 fs/proc/base.c                     | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index e8d0075..0b09495 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -44,6 +44,7 @@ Table of Contents
   3.8   /proc/<pid>/fdinfo/<fd> - Information about opened file
   3.9   /proc/<pid>/map_files - Information about memory mapped files
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
+  3.11	/proc/<pid>/patch_state - Livepatch patch operation state
 
   4	Configuring procfs
   4.1	Mount options
@@ -1880,6 +1881,23 @@ Valid values are from 0 - ULLONG_MAX
 An application setting the value must have PTRACE_MODE_ATTACH_FSCREDS level
 permissions on the task specified to change its timerslack_ns value.
 
+3.11	/proc/<pid>/patch_state - Livepatch patch operation state
+-----------------------------------------------------------------
+When CONFIG_LIVEPATCH is enabled, this file displays the value of the
+patch state for the task.
+
+A value of '-1' indicates that no patch is in transition.
+
+A value of '0' indicates that a patch is in transition and the task is
+unpatched.  If the patch is being enabled, then the task hasn't been
+patched yet.  If the patch is being disabled, then the task has already
+been unpatched.
+
+A value of '1' indicates that a patch is in transition and the task is
+patched.  If the patch is being enabled, then the task has already been
+patched.  If the patch is being disabled, then the task hasn't been
+unpatched yet.
+
 
 ------------------------------------------------------------------------------
 Configuring procfs
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 2868cdf..c485450 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2801,6 +2801,15 @@ static int proc_pid_personality(struct seq_file *m, struct pid_namespace *ns,
 	return err;
 }
 
+#ifdef CONFIG_LIVEPATCH
+static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	seq_printf(m, "%d\n", task->patch_state);
+	return 0;
+}
+#endif /* CONFIG_LIVEPATCH */
+
 /*
  * Thread groups
  */
@@ -2900,6 +2909,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("timers",	  S_IRUGO, proc_timers_operations),
 #endif
 	REG("timerslack_ns", S_IRUGO|S_IWUGO, proc_pid_set_timerslack_ns_operations),
+#ifdef CONFIG_LIVEPATCH
+	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3282,6 +3294,9 @@ static const struct pid_entry tid_base_stuff[] = {
 	REG("projid_map", S_IRUGO|S_IWUSR, proc_projid_map_operations),
 	REG("setgroups",  S_IRUGO|S_IWUSR, proc_setgroups_operations),
 #endif
+#ifdef CONFIG_LIVEPATCH
+	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
-- 
2.4.11
