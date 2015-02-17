From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 13/15] cpu-model/s390: Add processor property routines
Date: Tue, 17 Feb 2015 15:24:11 +0100
Message-ID: <1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the functions:

- s390_get_proceccor_props()
- s390_set_proceccor_props()

They can be used to request or retrieve processor related information from an accelerator.
That information comprises the cpu identifier, the ICB value and the facility lists.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu-models.c | 36 ++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
index c63b4c2..9bc4d89 100644
--- a/target-s390x/cpu-models.c
+++ b/target-s390x/cpu-models.c
@@ -579,6 +579,42 @@ void s390_cpu_list_entry(gpointer data, gpointer user_data)
 }
 
 /**
+ * s390_get_processor_props - retrieves processor properties from
+ *                            from the currently used accelerator
+ * @prop: address to processor property structure to store the
+ *        retrieved processor properties
+ *
+ * Returns: 0 in case of success
+ *          -ENOSYS in case the current accelerator has no processor
+ *           properties implemented
+ */
+int s390_get_processor_props(S390ProcessorProps *prop)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_get_processor_props(prop);
+    }
+    return -ENOSYS;
+}
+
+/**
+ * s390_set_processor_props - stores processor properties in the
+ *                            currently used accelerator
+ * @prop: address to processor property structure to store the
+ *        retrieved processor properties
+ *
+ * Returns: 0 in case of success
+ *          -ENOSYS in case the current accelerator has no processor
+ *           properties implemented
+ */
+int s390_set_processor_props(S390ProcessorProps *prop)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_set_processor_props(prop);
+    }
+    return -ENOSYS;
+}
+
+/**
  * s390_cpu_classes_initialized - indicates if the all cpu classes and
  *                                their properties have been initialized
  *
diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
index d41fc37..bc478d8 100644
--- a/target-s390x/cpu-models.h
+++ b/target-s390x/cpu-models.h
@@ -108,6 +108,8 @@ int s390_setup_cpu_classes(AccelId accel, S390MachineProps *prop);
 gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b);
 gint s390_cpu_class_desc_order_compare(gconstpointer a, gconstpointer b);
 void s390_cpu_list_entry(gpointer data, gpointer user_data);
+int s390_get_processor_props(S390ProcessorProps *prop);
+int s390_set_processor_props(S390ProcessorProps *prop);
 bool s390_cpu_classes_initialized(void);
 bool s390_test_facility(S390CPUClass *cc, unsigned long nr);
 bool s390_probe_mode(void);
-- 
1.8.3.1
