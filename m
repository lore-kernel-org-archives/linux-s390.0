Return-Path: <orenl@cs.columbia.edu>
From: Oren Laadan <orenl@cs.columbia.edu>
Subject: [PATCH v21 006/100] eclone (6/11): Check invalid clone flags
Date: Sat,  1 May 2010 10:14:48 -0400
Message-Id: <1272723382-19470-7-git-send-email-orenl@cs.columbia.edu>
In-Reply-To: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-api@vger.kernel.org, containers@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org, Matt Helsley <matthltc@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Pavel Emelyanov <xemul@openvz.org>
List-ID: <linux-s390.vger.kernel.org>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

As pointed out by Oren Laadan, we want to ensure that unused bits in the
clone-flags remain unused and available for future. To ensure this, define
a mask of clone-flags and check the flags in the clone() system calls.

Changelog[v9]:
	- Include the unused clone-flag (CLONE_UNUSED) to VALID_CLONE_FLAGS
	  to avoid breaking any applications that may have set it. IOW, this
	  patch/check only applies to clone-flags bits 33 and higher.

Changelog[v8]:
	- New patch in set

Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Serge E. Hallyn <serue@us.ibm.com>
Tested-by: Serge E. Hallyn <serue@us.ibm.com>
Acked-by: Oren Laadan <orenl.cs.columbia.edu>
---
 include/linux/sched.h |   12 ++++++++++++
 kernel/fork.c         |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index dad7f66..5de3ce5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -29,6 +29,18 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+#define CLONE_UNUSED		0x00001000	/* Can be reused ? */
+
+#define VALID_CLONE_FLAGS	(CSIGNAL | CLONE_VM | CLONE_FS | CLONE_FILES |\
+				 CLONE_SIGHAND | CLONE_UNUSED | CLONE_PTRACE |\
+				 CLONE_VFORK  | CLONE_PARENT | CLONE_THREAD  |\
+				 CLONE_NEWNS  | CLONE_SYSVSEM | CLONE_SETTLS |\
+				 CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID  |\
+				 CLONE_DETACHED | CLONE_UNTRACED             |\
+				 CLONE_CHILD_SETTID | CLONE_STOPPED          |\
+				 CLONE_NEWUTS | CLONE_NEWIPC | CLONE_NEWUSER |\
+				 CLONE_NEWPID | CLONE_NEWNET | CLONE_IO)
+
 /*
  * Scheduling policies
  */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d2b57e..e41b3d1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -964,6 +964,9 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 	struct task_struct *p;
 	int cgroup_callbacks_done = 0;
 
+	if (clone_flags & ~VALID_CLONE_FLAGS)
+		return ERR_PTR(-EINVAL);
+
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return ERR_PTR(-EINVAL);
 
-- 
1.6.3.3
