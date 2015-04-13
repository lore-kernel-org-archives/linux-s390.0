From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 10/17] target-s390x: Add S390 CPU model alias definition routines
Date: Mon, 13 Apr 2015 15:56:29 +0200
Message-ID: <1428933396-37887-11-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the infrastructure to dynamically add
CPU model aliases.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target-s390x/cpu-models.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h | 13 ++++++++
 target-s390x/cpu.c        |  1 +
 3 files changed, 96 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 6cc121b..28251f9 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -88,3 +88,85 @@ S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
 S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
 S390_PROC_DEF("2964-ga1", CPU_S390_2964_GA1, "IBM z13 GA1")
 
+GSList *s390_cpu_aliases;
+
+static gint s390_cpu_compare_name(gconstpointer a, gconstpointer b)
+{
+    char *aname = strdup_cpu_name((S390CPUClass *) a);
+    gint rc;
+
+    rc = strcasecmp(aname, (char *) b);
+    free(aname);
+
+    return rc;
+}
+
+/**
+ * s390_cpu_class_by_name:
+ * @name: a cpu model or alias name
+ *
+ * The function searches for the requested cpu model name or an alias
+ * cpu model name and returns the associated object class.
+ *
+ * Returns: reference to object class on success or %NULL elsewise.
+ *
+ * Since: 2.4
+ */
+ObjectClass *s390_cpu_class_by_name(const char *name)
+{
+    GSList *list, *item;
+    ObjectClass *ret = NULL;
+    S390CPUAlias *alias;
+
+    for (item = s390_cpu_aliases; item != NULL; item = item->next) {
+        alias = (S390CPUAlias *) item->data;
+        if (strcmp(alias->name, name) == 0) {
+            return s390_cpu_class_by_name(alias->model);
+        }
+    }
+    list = object_class_get_list(TYPE_S390_CPU, false);
+    item = g_slist_find_custom(list, name, s390_cpu_compare_name);
+    if (item) {
+        ret = OBJECT_CLASS(item->data);
+    }
+    g_slist_free(list);
+    return ret;
+}
+
+/**
+ * set_s390_cpu_alias:
+ * @name: the cpu alias name
+ * @model: the cpu model name
+ *
+ * The function registers the alias @name for an existing cpu @model.
+ *
+ * Returns: %0 in case of success
+ *          -%EINVAL if name or model is %NULL or both are idential
+ *                   or model is not a valid cpu model
+ *          -%ENOMEM if internal memory allocation fails
+ *
+ * Since: 2.4
+ */
+int set_s390_cpu_alias(const char *name, const char *model)
+{
+    S390CPUAlias *alias;
+
+    if (!name || !model) {
+        return -EINVAL;
+    }
+    if (!strcmp(name, model)) {
+        return -EINVAL;
+    }
+    if (!s390_cpu_class_by_name(model)) {
+        return -EINVAL;
+    }
+    alias = g_try_malloc0(sizeof(S390CPUAlias));
+    if (!alias) {
+        return -ENOMEM;
+    }
+    alias->name = g_strdup(name);
+    alias->model = g_strdup(model);
+    s390_cpu_aliases = g_slist_append(s390_cpu_aliases, alias);
+    return 0;
+}
+
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index 948af10..35dde5a 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -36,6 +36,19 @@
 #define cpu_generation(x) (((x) >> 24) & 0xff)
 
 /*
+ * S390 cpu aliases will be added dynamically
+ */
+typedef struct S390CPUAlias {
+    char *name;
+    char *model;
+} S390CPUAlias;
+
+extern GSList *s390_cpu_aliases;
+
+ObjectClass *s390_cpu_class_by_name(const char *name);
+int set_s390_cpu_alias(const char *name, const char *model);
+
+/*
  * bits 0-7   : CMOS generation
  * bits 8-9   : reserved
  * bits 10-11 : machine class 0=unknown 1=EC 2=BC
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 9232a97..c081885 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -314,6 +314,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     scc->cpu_reset = s390_cpu_reset;
     scc->initial_cpu_reset = s390_cpu_initial_reset;
+    cc->class_by_name = s390_cpu_class_by_name;
     cc->reset = s390_cpu_full_reset;
     cc->has_work = s390_cpu_has_work;
     cc->do_interrupt = s390_cpu_do_interrupt;
-- 
1.8.3.1
