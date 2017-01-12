From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v2 03/12] s390x/css: add s390-map-css machine option
Date: Thu, 12 Jan 2017 08:25:04 +0100
Message-ID: <20170112072513.98411-4-bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

We want to support real (i.e. not virtual) channel devices
even for guests that do not support MCSS-E (where guests may
see devices from any channel subsystem image at once). As all
virtio-ccw devices are in css 0xfe (and show up in the default
css 0 for guests not activating MCSS-E), we need an option to
map e.g. passed-through subchannels from their real css (0-3,
or 0 for hosts not activating MCSS-E) into the default css.
This will be exploited in a later patch.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 23 +++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 qemu-options.hx                    |  6 +++++-
 target-s390x/cpu.h                 | 10 ++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e340eab..4e8ffda 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -272,6 +272,21 @@ bool cpu_model_allowed(void)
     return true;
 }
 
+static inline bool machine_get_map_css(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return ms->s390_map_css;
+}
+
+static inline void machine_set_map_css(Object *obj, bool value,
+                                       Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    ms->s390_map_css = value;
+}
+
 static inline void s390_machine_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aes-key-wrap",
@@ -289,6 +304,14 @@ static inline void s390_machine_initfn(Object *obj)
             "enable/disable DEA key wrapping using the CPACF wrapping key",
             NULL);
     object_property_set_bool(obj, true, "dea-key-wrap", NULL);
+
+    object_property_add_bool(obj, "s390-map-css",
+                             machine_get_map_css,
+                             machine_set_map_css, NULL);
+    object_property_set_description(obj, "s390-map-css",
+            "enable/disable mapping passed-through subchannels into the "
+            "virtual css", NULL);
+    object_property_set_bool(obj, false, "s390-map-css", NULL);
 }
 
 static const TypeInfo ccw_machine_info = {
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 6ecae00..bbc1d21 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -28,6 +28,7 @@ typedef struct S390CcwMachineState {
     /*< public >*/
     bool aes_key_wrap;
     bool dea_key_wrap;
+    bool s390_map_css;
 } S390CcwMachineState;
 
 typedef struct S390CcwMachineClass {
diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f..293783c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                enforce-config-section=on|off enforce configuration section migration (default=off)\n",
+    "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
+    "                s390-map-css=on|off controls support for mapping into virtual css (default=off)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
@@ -82,6 +83,9 @@ controls whether DEA wrapping keys will be created to allow
 execution of DEA cryptographic functions.  The default is on.
 @item nvdimm=on|off
 Enables or disables NVDIMM support. The default is off.
+@item s390-map-css=on|off
+Enables or disables mapping passed-through subchannels into the virtual css.
+The default is off.
 @end table
 ETEXI
 
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index fd36a25..85d705d 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -1249,6 +1249,16 @@ static inline void s390_crypto_reset(void)
     }
 }
 
+static inline bool s390_get_map_css(void)
+{
+    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-map-css",
+                                 NULL)) {
+        return true;
+    }
+
+    return false;
+}
+
 /* machine check interruption code */
 
 /* subclasses */
-- 
2.8.4
