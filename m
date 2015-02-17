From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 07/15] cpu-model/s390: Add cpu model alias definition routines
Date: Tue, 17 Feb 2015 15:24:05 +0100
Message-ID: <1424183053-4310-8-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the infrastructure to dynamically add cpu
model aliases.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target-s390x/cpu-models.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h | 11 +++++++
 2 files changed, 88 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index 9e5c5fb..8d2c2e2 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -90,3 +90,80 @@ S390_PROC_DEF("2827-ga1", CPU_S390_2827_GA1, "IBM zEnterprise EC12 GA1")
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
+    blen = strlen(bname);
+    if (!strncasecmp(bname, aname, blen) &&
+        !strcmp(aname + blen, "-" TYPE_S390_CPU)) {
+        return 0;
+    }
+    return -1;
+}
+
+/**
+ * s390_cpu_class_by_name - retrive cpu object class by given name
+ * @name: the cpu model name
+ *
+ * Returns: address of object class on success
+ *          NULL if name is not a valid model name
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
+ * set_s390_cpu_alias - define a alias for an existing cpu model
+ * @name: the cpu alias name
+ * @model: the cpu model name
+ *
+ * Returns: 0 on success
+ *          -EINVAL if name or model is NULL or both are idential
+ *                  or model is not a valid cpu model
+ *          -ENOMEM if internal memory allocation fails
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
index 41af159..623a7b2 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -34,6 +34,17 @@
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
-- 
1.8.3.1
