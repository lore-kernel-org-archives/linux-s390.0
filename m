Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0895/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:56:01 +0800
Message-Id: <20160802115601.9643-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/s390/net/qeth_core_sys.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index e6e5b96..3960c47 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -41,7 +41,7 @@ static ssize_t qeth_dev_state_show(struct device *dev,
 	}
 }
 
-static DEVICE_ATTR(state, 0444, qeth_dev_state_show, NULL);
+static DEVICE_ATTR(state, S_IRUSR | S_IRGRP | S_IROTH, qeth_dev_state_show, NULL);
 
 static ssize_t qeth_dev_chpid_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -53,7 +53,7 @@ static ssize_t qeth_dev_chpid_show(struct device *dev,
 	return sprintf(buf, "%02X\n", card->info.chpid);
 }
 
-static DEVICE_ATTR(chpid, 0444, qeth_dev_chpid_show, NULL);
+static DEVICE_ATTR(chpid, S_IRUSR | S_IRGRP | S_IROTH, qeth_dev_chpid_show, NULL);
 
 static ssize_t qeth_dev_if_name_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -64,7 +64,7 @@ static ssize_t qeth_dev_if_name_show(struct device *dev,
 	return sprintf(buf, "%s\n", QETH_CARD_IFNAME(card));
 }
 
-static DEVICE_ATTR(if_name, 0444, qeth_dev_if_name_show, NULL);
+static DEVICE_ATTR(if_name, S_IRUSR | S_IRGRP | S_IROTH, qeth_dev_if_name_show, NULL);
 
 static ssize_t qeth_dev_card_type_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -76,7 +76,7 @@ static ssize_t qeth_dev_card_type_show(struct device *dev,
 	return sprintf(buf, "%s\n", qeth_get_cardname_short(card));
 }
 
-static DEVICE_ATTR(card_type, 0444, qeth_dev_card_type_show, NULL);
+static DEVICE_ATTR(card_type, S_IRUSR | S_IRGRP | S_IROTH, qeth_dev_card_type_show, NULL);
 
 static inline const char *qeth_get_bufsize_str(struct qeth_card *card)
 {
@@ -102,7 +102,7 @@ static ssize_t qeth_dev_inbuf_size_show(struct device *dev,
 	return sprintf(buf, "%s\n", qeth_get_bufsize_str(card));
 }
 
-static DEVICE_ATTR(inbuf_size, 0444, qeth_dev_inbuf_size_show, NULL);
+static DEVICE_ATTR(inbuf_size, S_IRUSR | S_IRGRP | S_IROTH, qeth_dev_inbuf_size_show, NULL);
 
 static ssize_t qeth_dev_portno_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -148,7 +148,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(portno, 0644, qeth_dev_portno_show, qeth_dev_portno_store);
+static DEVICE_ATTR(portno, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_portno_show, qeth_dev_portno_store);
 
 static ssize_t qeth_dev_portname_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -166,7 +166,7 @@ static ssize_t qeth_dev_portname_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(portname, 0644, qeth_dev_portname_show,
+static DEVICE_ATTR(portname, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_portname_show,
 		qeth_dev_portname_store);
 
 static ssize_t qeth_dev_prioqing_show(struct device *dev,
@@ -255,7 +255,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(priority_queueing, 0644, qeth_dev_prioqing_show,
+static DEVICE_ATTR(priority_queueing, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_prioqing_show,
 		qeth_dev_prioqing_store);
 
 static ssize_t qeth_dev_bufcnt_show(struct device *dev,
@@ -299,7 +299,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(buffer_count, 0644, qeth_dev_bufcnt_show,
+static DEVICE_ATTR(buffer_count, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_bufcnt_show,
 		qeth_dev_bufcnt_store);
 
 static ssize_t qeth_dev_recover_store(struct device *dev,
@@ -322,7 +322,7 @@ static ssize_t qeth_dev_recover_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(recover, 0200, NULL, qeth_dev_recover_store);
+static DEVICE_ATTR(recover, S_IWUSR, NULL, qeth_dev_recover_store);
 
 static ssize_t qeth_dev_performance_stats_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -363,7 +363,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(performance_stats, 0644, qeth_dev_performance_stats_show,
+static DEVICE_ATTR(performance_stats, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_performance_stats_show,
 		   qeth_dev_performance_stats_store);
 
 static ssize_t qeth_dev_layer2_show(struct device *dev,
@@ -427,7 +427,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(layer2, 0644, qeth_dev_layer2_show,
+static DEVICE_ATTR(layer2, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_layer2_show,
 		   qeth_dev_layer2_store);
 
 #define ATTR_QETH_ISOLATION_NONE	("none")
@@ -501,7 +501,7 @@ out:
 	return rc;
 }
 
-static DEVICE_ATTR(isolation, 0644, qeth_dev_isolation_show,
+static DEVICE_ATTR(isolation, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_isolation_show,
 			qeth_dev_isolation_store);
 
 static ssize_t qeth_dev_switch_attrs_show(struct device *dev,
@@ -536,7 +536,7 @@ static ssize_t qeth_dev_switch_attrs_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR(switch_attrs, 0444,
+static DEVICE_ATTR(switch_attrs, S_IRUSR | S_IRGRP | S_IROTH,
 		   qeth_dev_switch_attrs_show, NULL);
 
 static ssize_t qeth_hw_trap_show(struct device *dev,
@@ -593,7 +593,7 @@ static ssize_t qeth_hw_trap_store(struct device *dev,
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(hw_trap, 0644, qeth_hw_trap_show,
+static DEVICE_ATTR(hw_trap, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_hw_trap_show,
 		   qeth_hw_trap_store);
 
 static ssize_t qeth_dev_blkt_show(char *buf, struct qeth_card *card, int value)
@@ -649,7 +649,7 @@ static ssize_t qeth_dev_blkt_total_store(struct device *dev,
 
 
 
-static DEVICE_ATTR(total, 0644, qeth_dev_blkt_total_show,
+static DEVICE_ATTR(total, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_blkt_total_show,
 		   qeth_dev_blkt_total_store);
 
 static ssize_t qeth_dev_blkt_inter_show(struct device *dev,
@@ -669,7 +669,7 @@ static ssize_t qeth_dev_blkt_inter_store(struct device *dev,
 				   &card->info.blkt.inter_packet, 1000);
 }
 
-static DEVICE_ATTR(inter, 0644, qeth_dev_blkt_inter_show,
+static DEVICE_ATTR(inter, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_blkt_inter_show,
 		   qeth_dev_blkt_inter_store);
 
 static ssize_t qeth_dev_blkt_inter_jumbo_show(struct device *dev,
@@ -690,7 +690,7 @@ static ssize_t qeth_dev_blkt_inter_jumbo_store(struct device *dev,
 				   &card->info.blkt.inter_packet_jumbo, 1000);
 }
 
-static DEVICE_ATTR(inter_jumbo, 0644, qeth_dev_blkt_inter_jumbo_show,
+static DEVICE_ATTR(inter_jumbo, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_dev_blkt_inter_jumbo_show,
 		   qeth_dev_blkt_inter_jumbo_store);
 
 static struct attribute *qeth_blkt_device_attrs[] = {
-- 
2.9.2
