From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 1/3] procfs: add guest steal time in /proc/<pid>/stat
Date: Wed,  6 May 2015 17:26:34 +0530
Message-ID: <763805b68b8741de0172099163d9650c0352d724.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de, mingo@redhat.com, ego@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Introduce a field in /proc/<pid>/stat to expose guest steal time.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 fs/proc/array.c       | 6 ++++++
 include/linux/sched.h | 7 +++++++
 kernel/fork.c         | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index fd02a9e..ad8e616 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -381,6 +381,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long rsslim = 0;
 	char tcomm[sizeof(task->comm)];
 	unsigned long flags;
+	cputime_t gstime;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -400,6 +401,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	sigemptyset(&sigcatch);
 	cutime = cstime = utime = stime = 0;
 	cgtime = gtime = 0;
+	gstime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
 		struct signal_struct *sig = task->signal;
@@ -428,6 +430,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
 				gtime += task_gtime(t);
+				gstime += task_gstime(t);
 			} while_each_thread(task, t);
 
 			min_flt += sig->min_flt;
@@ -450,6 +453,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		maj_flt = task->maj_flt;
 		task_cputime_adjusted(task, &utime, &stime);
 		gtime = task_gtime(task);
+		gstime = task_gstime(task);
 	}
 
 	/* scale priority and nice values from timeslices to -20..20 */
@@ -523,6 +527,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	else
 		seq_put_decimal_ll(m, ' ', 0);
 
+	seq_put_decimal_ull(m, ' ', cputime_to_clock_t(gstime));
+
 	seq_putc(m, '\n');
 	if (mm)
 		mmput(mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 26a2e61..e28f869 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1430,6 +1430,7 @@ struct task_struct {
 
 	cputime_t utime, stime, utimescaled, stimescaled;
 	cputime_t gtime;
+	cputime_t gstime;
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	struct cputime prev_cputime;
 #endif
@@ -1956,6 +1957,12 @@ static inline cputime_t task_gtime(struct task_struct *t)
 	return t->gtime;
 }
 #endif
+
+static inline cputime_t task_gstime(struct task_struct *t)
+{
+	return t->gstime;
+}
+
 extern void task_cputime_adjusted(struct task_struct *p, cputime_t *ut, cputime_t *st);
 extern void thread_group_cputime_adjusted(struct task_struct *p, cputime_t *ut, cputime_t *st);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 03c1eaa..edf4ffb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1339,7 +1339,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 
 	init_sigpending(&p->pending);
 
-	p->utime = p->stime = p->gtime = 0;
+	p->utime = p->stime = p->gtime = p->gstime = 0;
 	p->utimescaled = p->stimescaled = 0;
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	p->prev_cputime.utime = p->prev_cputime.stime = 0;
-- 
2.3.7
