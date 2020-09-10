Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgIJRYG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 13:24:06 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/8] s390/cio: Helper functions to read CSSID, IID, and CHID
Date: Thu, 10 Sep 2020 19:23:45 +0200
Message-Id: <20200910172351.5622-3-jwi@linux.ibm.com>
In-Reply-To: <20200910172351.5622-1-jwi@linux.ibm.com>
References: <20200910172351.5622-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>

From: Alexandra Winter <wintera@linux.ibm.com>

Add helper functions to expose Channel Subsystem ID (CSSID), MIF Image Id
(IID), Channel ID (CHID) and Channel Path ID (CHPID).
These values are required by the qeth driver's exploitation of network-
address-change-notifications to determine which entries belong to this
interface.

Store the Partition identifier in System log, as this may be used to map
a Linux view to a Hardware view for debugging purpose.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/ccwdev.h |  4 ++
 drivers/s390/cio/chsc.c        | 11 +++--
 drivers/s390/cio/chsc.h        |  2 +-
 drivers/s390/cio/css.c         | 11 +++--
 drivers/s390/cio/css.h         |  4 +-
 drivers/s390/cio/device_ops.c  | 85 ++++++++++++++++++++++++++++++++++
 6 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 9739a00e2190..c0be5fe1ddba 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -240,4 +240,8 @@ u8 *ccw_device_get_util_str(struct ccw_device *cdev, int chp_idx);
 int ccw_device_pnso(struct ccw_device *cdev,
 		    struct chsc_pnso_area *pnso_area, u8 oc,
 		    struct chsc_pnso_resume_token resume_token, int cnc);
+int ccw_device_get_cssid(struct ccw_device *cdev, u8 *cssid);
+int ccw_device_get_iid(struct ccw_device *cdev, u8 *iid);
+int ccw_device_get_chpid(struct ccw_device *cdev, int chp_idx, u8 *chpid);
+int ccw_device_get_chid(struct ccw_device *cdev, int chp_idx, u16 *chid);
 #endif /* _S390_CCWDEV_H_ */
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 8f764a295a51..38017c4a31e9 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1116,7 +1116,7 @@ int chsc_enable_facility(int operation_code)
 	return ret;
 }
 
-int __init chsc_get_cssid(int idx)
+int __init chsc_get_cssid_iid(int idx, u8 *cssid, u8 *iid)
 {
 	struct {
 		struct chsc_header request;
@@ -1127,7 +1127,8 @@ int __init chsc_get_cssid(int idx)
 		u32 reserved2[3];
 		struct {
 			u8 cssid;
-			u32 : 24;
+			u8 iid;
+			u32 : 16;
 		} list[0];
 	} *sdcal_area;
 	int ret;
@@ -1153,8 +1154,10 @@ int __init chsc_get_cssid(int idx)
 	}
 
 	if ((addr_t) &sdcal_area->list[idx] <
-	    (addr_t) &sdcal_area->response + sdcal_area->response.length)
-		ret = sdcal_area->list[idx].cssid;
+	    (addr_t) &sdcal_area->response + sdcal_area->response.length) {
+		*cssid = sdcal_area->list[idx].cssid;
+		*iid = sdcal_area->list[idx].iid;
+	}
 	else
 		ret = -ENODEV;
 exit:
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 7416957ba9f4..c2b83b68bc57 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -208,7 +208,7 @@ int chsc_scm_info(struct chsc_scm_info *scm_area, u64 token);
 int chsc_pnso(struct subchannel_id schid, struct chsc_pnso_area *pnso_area,
 	      u8 oc, struct chsc_pnso_resume_token resume_token, int cnc);
 
-int __init chsc_get_cssid(int idx);
+int __init chsc_get_cssid_iid(int idx, u8 *cssid, u8 *iid);
 
 #ifdef CONFIG_SCM_BUS
 int scm_update_information(void);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index aca022239b33..1981eb62d329 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -854,7 +854,7 @@ css_generate_pgid(struct channel_subsystem *css, u32 tod_high)
 	if (css_general_characteristics.mcss) {
 		css->global_pgid.pgid_high.ext_cssid.version = 0x80;
 		css->global_pgid.pgid_high.ext_cssid.cssid =
-			(css->cssid < 0) ? 0 : css->cssid;
+			css->id_valid ? css->cssid : 0;
 	} else {
 		css->global_pgid.pgid_high.cpu_addr = stap();
 	}
@@ -877,7 +877,7 @@ static ssize_t real_cssid_show(struct device *dev, struct device_attribute *a,
 {
 	struct channel_subsystem *css = to_css(dev);
 
-	if (css->cssid < 0)
+	if (!css->id_valid)
 		return -EINVAL;
 
 	return sprintf(buf, "%x\n", css->cssid);
@@ -975,7 +975,12 @@ static int __init setup_css(int nr)
 	css->device.dma_mask = &css->device.coherent_dma_mask;
 
 	mutex_init(&css->mutex);
-	css->cssid = chsc_get_cssid(nr);
+	ret = chsc_get_cssid_iid(nr, &css->cssid, &css->iid);
+	if (!ret) {
+		css->id_valid = true;
+		pr_info("Partition identifier %01x.%01x\n", css->cssid,
+			css->iid);
+	}
 	css_generate_pgid(css, (u32) (get_tod_clock() >> 32));
 
 	ret = device_register(&css->device);
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index 8d832900a63d..3f322ea0f498 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -115,7 +115,9 @@ extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
 void css_update_ssd_info(struct subchannel *sch);
 
 struct channel_subsystem {
-	int cssid;
+	u8 cssid;
+	u8 iid;
+	bool id_valid; /* cssid,iid */
 	struct channel_path *chps[__MAX_CHPID + 1];
 	struct device device;
 	struct pgid global_pgid;
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index cdf44f398957..0fe7b2f2e7f5 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -733,6 +733,91 @@ int ccw_device_pnso(struct ccw_device *cdev,
 }
 EXPORT_SYMBOL_GPL(ccw_device_pnso);
 
+/**
+ * ccw_device_get_cssid() - obtain Channel Subsystem ID
+ * @cdev: device to obtain the CSSID for
+ * @cssid: The resulting Channel Subsystem ID
+ */
+int ccw_device_get_cssid(struct ccw_device *cdev, u8 *cssid)
+{
+	struct device *sch_dev = cdev->dev.parent;
+	struct channel_subsystem *css = to_css(sch_dev->parent);
+
+	if (css->id_valid)
+		*cssid = css->cssid;
+	return css->id_valid ? 0 : -ENODEV;
+}
+EXPORT_SYMBOL_GPL(ccw_device_get_cssid);
+
+/**
+ * ccw_device_get_iid() - obtain MIF-image ID
+ * @cdev: device to obtain the MIF-image ID for
+ * @iid: The resulting MIF-image ID
+ */
+int ccw_device_get_iid(struct ccw_device *cdev, u8 *iid)
+{
+	struct device *sch_dev = cdev->dev.parent;
+	struct channel_subsystem *css = to_css(sch_dev->parent);
+
+	if (css->id_valid)
+		*iid = css->iid;
+	return css->id_valid ? 0 : -ENODEV;
+}
+EXPORT_SYMBOL_GPL(ccw_device_get_iid);
+
+/**
+ * ccw_device_get_chpid() - obtain Channel Path ID
+ * @cdev: device to obtain the Channel Path ID for
+ * @chp_idx: Index of the channel path
+ * @chpid: The resulting Channel Path ID
+ */
+int ccw_device_get_chpid(struct ccw_device *cdev, int chp_idx, u8 *chpid)
+{
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	int mask;
+
+	if ((chp_idx < 0) || (chp_idx > 7))
+		return -EINVAL;
+	mask = 0x80 >> chp_idx;
+	if (!(sch->schib.pmcw.pim & mask))
+		return -ENODEV;
+
+	*chpid = sch->schib.pmcw.chpid[chp_idx];
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ccw_device_get_chpid);
+
+/**
+ * ccw_device_get_chid() - obtain Channel ID associated with specified CHPID
+ * @cdev: device to obtain the Channel ID for
+ * @chp_idx: Index of the channel path
+ * @chid: The resulting Channel ID
+ */
+int ccw_device_get_chid(struct ccw_device *cdev, int chp_idx, u16 *chid)
+{
+	struct chp_id cssid_chpid;
+	struct channel_path *chp;
+	int rc;
+
+	chp_id_init(&cssid_chpid);
+	rc = ccw_device_get_chpid(cdev, chp_idx, &cssid_chpid.id);
+	if (rc)
+		return rc;
+	chp = chpid_to_chp(cssid_chpid);
+	if (!chp)
+		return -ENODEV;
+
+	mutex_lock(&chp->lock);
+	if (chp->desc_fmt1.flags & 0x10)
+		*chid = chp->desc_fmt1.chid;
+	else
+		rc = -ENODEV;
+	mutex_unlock(&chp->lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ccw_device_get_chid);
+
 /*
  * Allocate zeroed dma coherent 31 bit addressable memory using
  * the subchannels dma pool. Maximal size of allocation supported
-- 
2.17.1
