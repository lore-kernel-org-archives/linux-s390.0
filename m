From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 4/9] s390x/css: add s390-map-css machine option
Date: Fri, 29 Apr 2016 14:13:18 +0200
Message-ID: <1461932003-23830-5-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

We want to support real (i.e. not virtual) channel devices
even for guests that do not support MCSS-E (where guests may
see devices from any channel subsystem image at once). As all
virtio-ccw devices are in css 0xfe (and show up in the default
css 0 for guests not activating MCSS-E), we need an option to
map e.g. passed-through channel devices from their real css (0-3,
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
index e3df9c7..c4706b7 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -237,6 +237,21 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
     ms->dea_key_wrap = value;
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
@@ -254,6 +269,14 @@ static inline void s390_machine_initfn(Object *obj)
             "enable/disable DEA key wrapping using the CPACF wrapping key",
             NULL);
     object_property_set_bool(obj, true, "dea-key-wrap", NULL);
+
+    object_property_add_bool(obj, "s390-map-css",
+                             machine_get_map_css,
+                             machine_set_map_css, NULL);
+    object_property_set_description(obj, "s390-map-css",
+            "enable/disable mapping passed-through ccw devices into the "
+            "virtual css", NULL);
+    object_property_set_bool(obj, false, "s390-map-css", NULL);
 }
 
 static const TypeInfo ccw_machine_info = {
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index ab08332..e99f1dd 100644
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
index 6106520..ce055a7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -44,7 +44,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                enforce-config-section=on|off enforce configuration section migration (default=off)\n",
+    "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
+    "                s390-map-css=on|off controls support for mapping into virtual css (default=off)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
@@ -85,6 +86,9 @@ controls whether DEA wrapping keys will be created to allow
 execution of DEA cryptographic functions.  The default is on.
 @item nvdimm=on|off
 Enables or disables NVDIMM support. The default is off.
+@item s390-map-css=on|off
+Enables or disables mapping passed-through ccw devices into the virtual css.
+The default is off.
 @end table
 ETEXI
 
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index 6d97c08..aab0481 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -1279,6 +1279,16 @@ static inline bool vregs_needed(void *opaque)
 }
 #endif
 
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
2.6.6
