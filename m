From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v2 05/12] s390x/css: realize css_create_sch
Date: Thu, 12 Jan 2017 08:25:06 +0100
Message-ID: <20170112072513.98411-6-bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The S390 virtual css support already has a mechanism to create a
virtual subchannel and provide it to the guest. However, to
pass-through subchannels to a guest, we need to introduce a new
mechanism to create the subchannel according to the real device
information. Thus we realize a new css_create_sch function to
allocate and initialize the subchannel according to the real
device information.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 39 +++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h | 15 +++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 8703bc3..67fe468 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1486,6 +1486,19 @@ bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno)
                       channel_subsys.css[cssid]->sch_set[ssid]->devnos_used);
 }
 
+bool css_schid_used(uint8_t cssid, uint8_t ssid, uint16_t schid)
+{
+    if (!channel_subsys.css[cssid]) {
+        return false;
+    }
+    if (!channel_subsys.css[cssid]->sch_set[ssid]) {
+        return false;
+    }
+
+    return !!test_bit(schid,
+                      channel_subsys.css[cssid]->sch_set[ssid]->schids_used);
+}
+
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
                       uint16_t devno, SubchDev *sch)
 {
@@ -1911,6 +1924,32 @@ SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp)
     return sch;
 }
 
+SubchDev *css_create_sch(CssDevId bus_id, Error **errp)
+{
+    uint32_t devno;
+    SubchDev *sch;
+
+    if (css_schid_used(bus_id.cssid, bus_id.ssid, bus_id.devid)) {
+        error_setg(errp, "Subchannel %x.%x.%04x already exists",
+                   bus_id.cssid, bus_id.ssid, bus_id.devid);
+        return NULL;
+    }
+
+    devno = css_find_free_devno(bus_id.cssid, bus_id.ssid, bus_id.devid);
+    if (devno > MAX_DEVNO) {
+        error_setg(errp, "No free devno found");
+        return NULL;
+    }
+
+    sch = g_malloc0(sizeof(*sch));
+    sch->cssid = bus_id.cssid;
+    sch->ssid = bus_id.ssid;
+    sch->devno = devno;
+    sch->schid = bus_id.devid;
+    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, sch);
+    return sch;
+}
+
 static int css_sch_get_chpids(SubchDev *sch, CssDevId *dev_id)
 {
     char *fid_path;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 648ea2f..c92f624 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -128,6 +128,7 @@ void subch_device_save(SubchDev *s, QEMUFile *f);
 int subch_device_load(SubchDev *s, QEMUFile *f);
 int css_create_css_image(uint8_t cssid, bool default_image);
 bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
+bool css_schid_used(uint8_t cssid, uint8_t ssid, uint16_t schid);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
                       uint16_t devno, SubchDev *sch);
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
@@ -189,4 +190,18 @@ bool css_present(uint8_t cssid);
  * is responsible for unregistering and freeing it.
  */
 SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp);
+
+/**
+ * Create a subchannel for the given bus id.
+ *
+ * If @p bus_id is valid, verify that it is not already in use, and find
+ * a free devno for it.
+ * Allocate a subchannel structure, initialise it with the bus id,
+ * subchannel id and device number, register it with the CSS and return
+ * it. Otherwise return NULL.
+ *
+ * The caller becomes owner of the returned subchannel structure and
+ * is responsible for unregistering and freeing it.
+ */
+SubchDev *css_create_sch(CssDevId bus_id, Error **errp);
 #endif
-- 
2.8.4
