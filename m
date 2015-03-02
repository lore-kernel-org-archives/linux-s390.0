From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 08/16] target-s390x: Add cpu model alias definition routines
Date: Mon,  2 Mar 2015 13:44:00 +0100
Message-ID: <1425300248-40277-9-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the infrastructure to dynamically add cpu
model aliases.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target-s390x/cpu-models.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h | 11 ++++++
 target-s390x/cpu.c        |  1 +
 3 files changed, 101 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index bd9f0bc..608189d 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -87,3 +87,92 @@ S390_PROC_DEF("2827-ga1", CPU_S390_2827_GA1, "IBM zEnterprise EC12 GA1")
 S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
 S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
 
+static GSList *s390_cpu_aliases;
+
+static gint s390_cpu_compare_class_name(gconstpointer a, gconstpointer b)
+{
+    const char *aname = object_class_get_name((ObjectClass *) a);
+    const char *bname = b;
+    int blen;
+
+    if (!strcmp(bname, "none") &&
+        !strcmp(aname, TYPE_S390_CPU)) {
+        return 0;
+    }
+    blen = strlen(bname);
+    if (!strncasecmp(bname, aname, blen) &&
+        !strcmp(aname + blen, "-" TYPE_S390_CPU)) {
+        return 0;
+    }
+    return -1;
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
+ * Since: 2.3
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
+    item = g_slist_find_custom(list, name, s390_cpu_compare_class_name);
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
+ * Since: 2.3
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
index d5f0b59..a32f559 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -35,6 +35,17 @@
 #define cpu_class(x)      (((x) >> 20) & 0x3)
 #define cpu_generation(x) (((x) >> 24) & 0xff)
 
+ObjectClass *s390_cpu_class_by_name(const char *name);
+int set_s390_cpu_alias(const char *name, const char *model);
+
+/*
+ * S390 cpu aliases will be added dynamically
+ */
+typedef struct S390CPUAlias {
+    char *name;
+    char *model;
+} S390CPUAlias;
+
 /*
  * bits 0-7   : CMOS generation
  * bits 8-9   : reserved
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 7a26b91..1992910 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -308,6 +308,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     scc->cpu_reset = s390_cpu_reset;
     scc->initial_cpu_reset = s390_cpu_initial_reset;
+    cc->class_by_name = s390_cpu_class_by_name;
     cc->reset = s390_cpu_full_reset;
     cc->has_work = s390_cpu_has_work;
     cc->do_interrupt = s390_cpu_do_interrupt;
-- 
1.8.3.1
