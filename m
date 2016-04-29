From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 5/9] s390x/css: realize css_sch_build_schib
Date: Fri, 29 Apr 2016 14:13:19 +0200
Message-ID: <1461932003-23830-6-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

The S390 virtual css support already has a mechanism to build virtual
schib and provide virtual subchannels to the guest. However, to
pass-through ccw device to a guest, we need to introduce a new
mechanism to build its schib according to the real device information.
Thus we realize a new css_sch_build_schib function to do this. And to
reuse the existing code, we refactor css_add_virtual_chpid to
css_add_chpid.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/s390x/css.h |   1 +
 2 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 3a1d919..5d02ad3 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include <hw/qdev.h>
+#include "qemu/error-report.h"
 #include "qemu/bitops.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
@@ -1236,7 +1237,8 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid)
                                  (MAX_SCHID + 1) / sizeof(unsigned long));
 }
 
-static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
+static int css_add_chpid(uint8_t cssid, uint8_t chpid, uint8_t type,
+                         bool is_virt)
 {
     CssImage *css;
 
@@ -1253,7 +1255,7 @@ static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
     }
     css->chpids[chpid].in_use = 1;
     css->chpids[chpid].type = type;
-    css->chpids[chpid].is_virtual = 1;
+    css->chpids[chpid].is_virtual = is_virt;
 
     css_generate_chp_crws(cssid, chpid);
 
@@ -1277,7 +1279,7 @@ void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type)
     p->pam = 0x80;
     p->chpid[0] = chpid;
     if (!css->chpids[chpid].in_use) {
-        css_add_virtual_chpid(sch->cssid, chpid, type);
+        css_add_chpid(sch->cssid, chpid, type, true);
     }
 
     memset(s, 0, sizeof(SCSW));
@@ -1644,3 +1646,148 @@ void css_reset(void)
     channel_subsys.max_cssid = 0;
     channel_subsys.max_ssid = 0;
 }
+
+static int css_sch_get_chpids(SubchDev *sch, const char *hschid, uint32_t cssid)
+{
+    char *fid_path;
+    FILE *fd;
+    uint32_t chpid[8];
+    int i;
+    PMCW *p = &sch->curr_status.pmcw;
+
+    fid_path = g_strdup_printf("/sys/devices/css%x/%s/chpids",
+                               cssid, hschid);
+    fd = fopen(fid_path, "r");
+    if (fd == NULL) {
+        error_report("%s: open %s failed", __func__, fid_path);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    if (fscanf(fd, "%x %x %x %x %x %x %x %x",
+        &chpid[0], &chpid[1], &chpid[2], &chpid[3],
+        &chpid[4], &chpid[5], &chpid[6], &chpid[7]) != 8) {
+        fclose(fd);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
+        p->chpid[i] = chpid[i];
+    }
+
+    fclose(fd);
+    g_free(fid_path);
+
+    return 0;
+}
+
+static int css_sch_get_path_masks(SubchDev *sch, const char *hschid,
+                                  uint32_t cssid)
+{
+    char *fid_path;
+    FILE *fd;
+    uint32_t pim, pam, pom;
+    PMCW *p = &sch->curr_status.pmcw;
+
+    fid_path = g_strdup_printf("/sys/devices/css%x/%s/pimpampom",
+                               cssid, hschid);
+    fd = fopen(fid_path, "r");
+    if (fd == NULL) {
+        error_report("%s: open %s failed", __func__, fid_path);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    if (fscanf(fd, "%x %x %x", &pim, &pam, &pom) != 3) {
+        fclose(fd);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    p->pim = pim;
+    p->pam = pam;
+    p->pom = pom;
+    fclose(fd);
+    g_free(fid_path);
+
+    return 0;
+}
+
+static int css_sch_get_chpid_type(uint8_t chpid, uint32_t *type, uint32_t cssid)
+{
+    char *fid_path;
+    FILE *fd;
+
+    fid_path = g_strdup_printf("/sys/devices/css%x/chp0.%02x/type",
+                               cssid, chpid);
+    fd = fopen(fid_path, "r");
+    if (fd == NULL) {
+        error_report("%s: open %s failed", __func__, fid_path);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    if (fscanf(fd, "%x", type) != 1) {
+        fclose(fd);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    fclose(fd);
+    g_free(fid_path);
+
+    return 0;
+}
+
+int css_sch_build_schib(SubchDev *sch, const char *hschid)
+{
+    PMCW *p = &sch->curr_status.pmcw;
+    SCSW *s = &sch->curr_status.scsw;
+    int i, ret;
+    uint32_t type, cssid;
+    CssImage *css = channel_subsys.css[sch->cssid];
+
+    /* We are dealing with I/O subchannels only. */
+    assert(css != NULL);
+    memset(p, 0, sizeof(PMCW));
+    p->flags |= PMCW_FLAGS_MASK_DNV;
+    p->devno = sch->devno;
+
+    ret = sscanf(hschid, "%1x", &cssid);
+    if (ret != 1) {
+        error_report("%s: Get cssid from host schid %s failed",
+                     __func__, hschid);
+    }
+
+    /* Grab path mask from sysfs. */
+    ret = css_sch_get_path_masks(sch, hschid, cssid);
+    if (ret) {
+        return ret;
+    }
+
+    /* Grab chpids from sysfs. */
+    ret = css_sch_get_chpids(sch, hschid, cssid);
+    if (ret) {
+        return ret;
+    }
+
+   /* Build chpid type. */
+    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
+        if (p->chpid[i] && !css->chpids[p->chpid[i]].in_use) {
+            ret = css_sch_get_chpid_type(p->chpid[i], &type, cssid);
+            if (ret) {
+                return ret;
+            }
+            css_add_chpid(sch->cssid, p->chpid[i], type, false);
+        }
+    }
+
+    memset(s, 0, sizeof(SCSW));
+    sch->curr_status.mba = 0;
+    for (i = 0; i < ARRAY_SIZE(sch->curr_status.mda); i++) {
+        sch->curr_status.mda[i] = 0;
+    }
+
+    return 0;
+}
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index a320eea..bd45951 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -119,6 +119,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 void css_adapter_interrupt(uint8_t isc);
+int css_sch_build_schib(SubchDev *sch, const char *hschid);
 
 #define CSS_IO_ADAPTER_VIRTIO 1
 int css_register_io_adapter(uint8_t type, uint8_t isc, bool swap,
-- 
2.6.6
