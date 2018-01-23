From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 1/5] prctl: add PR_ISOLATE_BP process control
Date: Tue, 23 Jan 2018 14:07:01 +0100
Message-ID: <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Add the PR_ISOLATE_BP operation to prctl. The effect of the process
control is to make all branch prediction entries created by the execution
of the user space code of this task not applicable to kernel code or the
code of any other task.

This can be achieved by the architecture specific implementation
in different ways, e.g. by limiting the branch predicion for the task,
or by clearing the branch prediction tables on each context switch, or
by tagging the branch prediction entries in a suitable way.

The architecture code needs to define the ISOLATE_BP macro to implement
the hardware specific details of the branch prediction isolation.

The control can not be removed from a task once it is activated and it
is inherited by all children of the task.

The user space wrapper to start a program with the isolated branch
prediction:

int main(int argc, char *argv[], char *envp[])
{
	int rc;

	if (argc < 2) {
		fprintf(stderr, "Usage: %s <file-to-exec> <arguments>\n",
			argv[0]);
		exit(EXIT_FAILURE);
	}

	rc = prctl(PR_ISOLATE_BP);
	if (rc) {
		perror("PR_ISOLATE_BP");
		exit(EXIT_FAILURE);
	}
	execve(argv[1], argv + 1, envp);
	perror("execve");
	exit(EXIT_FAILURE);
}

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/uapi/linux/prctl.h | 8 ++++++++
 kernel/sys.c               | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index af5f8c2..e7b84c9 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -207,4 +207,12 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/*
+ * Prevent branch prediction entries created by the execution of
+ * user space code of this task to be used in any other context.
+ * This makes it impossible for malicious user space code to train
+ * a branch in the kernel code or in another task to be mispredicted.
+ */
+#define PR_ISOLATE_BP			52
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 83ffd7d..e41cb2f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -117,6 +117,9 @@
 #ifndef SVE_GET_VL
 # define SVE_GET_VL()		(-EINVAL)
 #endif
+#ifndef ISOLATE_BP
+# define ISOLATE_BP()		(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2398,6 +2401,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SVE_GET_VL:
 		error = SVE_GET_VL();
 		break;
+	case PR_ISOLATE_BP:
+		error = ISOLATE_BP();
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.7.4
