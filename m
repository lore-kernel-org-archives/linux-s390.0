From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 18:31:46 +0000
Subject: [CRIU][PATCH v3 11/15] s390:criu: Add TASK_SIZE check for dump and restore
Message-Id: <20170630183150.76021-12-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For kernels that don't have commit ee71d16d22 ("s390/mm: make TASK_SIZE
independent from the number of page table levels") criu sets TASK_SIZE
to 4 TB on s390 (see compel_task_size()).

When dumping tasks >= 4 TB on such systems, we would silently loose
memory >= 4TB.

So add a check and refuse to dump the task in that case.

When restoring tasks >= 4 TB on such systems, the remap() call for
moving the vmas at the end of the restor process would fail
and a very unclear error message is printed.

So add a check and write a more speaking error message in that case.

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/mem.c        | 19 +++++++++++++++++++
 criu/proc_parse.c | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/criu/mem.c b/criu/mem.c
index 390fc0a..ab40295 100644
--- a/criu/mem.c
+++ b/criu/mem.c
@@ -772,6 +772,21 @@ static inline bool vma_force_premap(struct vma_area *vma, struct list_head *head
 	return false;
 }
 
+/*
+ * Ensure for s390x that vma is below task size on restore system
+ */
+static int task_size_check(pid_t pid, VmaEntry *entry)
+{
+#ifdef __s390x__
+	if (entry->end <= kdat.task_size)
+		return 0;
+	pr_err("Can't restore high memory region %lx-%lx because kernel does only support vmas up to %lx\n", entry->start, entry->end, kdat.task_size);
+	return -1;
+#else
+	return 0;
+#endif
+}
+
 static int premap_priv_vmas(struct pstree_item *t, struct vm_area_list *vmas,
 		void **at, struct page_read *pr)
 {
@@ -783,6 +798,10 @@ static int premap_priv_vmas(struct pstree_item *t, struct vm_area_list *vmas,
 	filemap_ctx_init(true);
 
 	list_for_each_entry(vma, &vmas->h, list) {
+		if (task_size_check(vpid(t), vma->e)) {
+			ret = -1;
+			break;
+		}
 		if (pstart > vma->e->start) {
 			ret = -1;
 			pr_err("VMA-s are not sorted in the image file\n");
diff --git a/criu/proc_parse.c b/criu/proc_parse.c
index b8881d2..7e93bfa 100644
--- a/criu/proc_parse.c
+++ b/criu/proc_parse.c
@@ -665,6 +665,22 @@ static int vma_list_add(struct vma_area *vma_area,
 	return 0;
 }
 
+/*
+ * On s390 we have old kernels where the global task size assumption of
+ * criu does not work. See also compel_task_size() for s390.
+ */
+static int task_size_check(pid_t pid, VmaEntry *entry)
+{
+#ifdef __s390x__
+	if (entry->end <= kdat.task_size)
+		return 0;
+	pr_err("Can't dump high memory region %lx-%lx of task %d because kernel commit ee71d16d22bb is missing\n", entry->start, entry->end, pid);
+	return -1;
+#else
+	return 0;
+#endif
+}
+
 int parse_smaps(pid_t pid, struct vm_area_list *vma_area_list,
 					dump_filemap_t dump_filemap)
 {
@@ -750,6 +766,9 @@ int parse_smaps(pid_t pid, struct vm_area_list *vma_area_list,
 		vma_area->e->pgoff	= pgoff;
 		vma_area->e->prot	= PROT_NONE;
 
+		if (task_size_check(pid, vma_area->e))
+			goto err;
+
 		if (r == 'r')
 			vma_area->e->prot |= PROT_READ;
 		if (w == 'w')
-- 
2.7.4
