Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0897/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:56:10 +0800
Message-Id: <20160802115610.9775-1-baolex.ni@intel.com>
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
 drivers/s390/net/qeth_l3_sys.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 386eb7b..820da34 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -102,7 +102,7 @@ static ssize_t qeth_l3_dev_route4_store(struct device *dev,
 				QETH_PROT_IPV4, buf, count);
 }
 
-static DEVICE_ATTR(route4, 0644, qeth_l3_dev_route4_show,
+static DEVICE_ATTR(route4, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_l3_dev_route4_show,
 			qeth_l3_dev_route4_store);
 
 static ssize_t qeth_l3_dev_route6_show(struct device *dev,
@@ -128,7 +128,7 @@ static ssize_t qeth_l3_dev_route6_store(struct device *dev,
 				QETH_PROT_IPV6, buf, count);
 }
 
-static DEVICE_ATTR(route6, 0644, qeth_l3_dev_route6_show,
+static DEVICE_ATTR(route6, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_l3_dev_route6_show,
 			qeth_l3_dev_route6_store);
 
 static ssize_t qeth_l3_dev_fake_broadcast_show(struct device *dev,
@@ -169,7 +169,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(fake_broadcast, 0644, qeth_l3_dev_fake_broadcast_show,
+static DEVICE_ATTR(fake_broadcast, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_l3_dev_fake_broadcast_show,
 		   qeth_l3_dev_fake_broadcast_store);
 
 static ssize_t qeth_l3_dev_sniffer_show(struct device *dev,
@@ -233,7 +233,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(sniffer, 0644, qeth_l3_dev_sniffer_show,
+static DEVICE_ATTR(sniffer, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_l3_dev_sniffer_show,
 		qeth_l3_dev_sniffer_store);
 
 
@@ -335,7 +335,7 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(hsuid, 0644, qeth_l3_dev_hsuid_show,
+static DEVICE_ATTR(hsuid, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_l3_dev_hsuid_show,
 		   qeth_l3_dev_hsuid_store);
 
 
@@ -406,7 +406,7 @@ out:
 	return rc ? rc : count;
 }
 
-static QETH_DEVICE_ATTR(ipato_enable, enable, 0644,
+static QETH_DEVICE_ATTR(ipato_enable, enable, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_ipato_enable_show,
 			qeth_l3_dev_ipato_enable_store);
 
@@ -444,7 +444,7 @@ static ssize_t qeth_l3_dev_ipato_invert4_store(struct device *dev,
 	return rc ? rc : count;
 }
 
-static QETH_DEVICE_ATTR(ipato_invert4, invert4, 0644,
+static QETH_DEVICE_ATTR(ipato_invert4, invert4, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_ipato_invert4_show,
 			qeth_l3_dev_ipato_invert4_store);
 
@@ -558,7 +558,7 @@ static ssize_t qeth_l3_dev_ipato_add4_store(struct device *dev,
 	return qeth_l3_dev_ipato_add_store(buf, count, card, QETH_PROT_IPV4);
 }
 
-static QETH_DEVICE_ATTR(ipato_add4, add4, 0644,
+static QETH_DEVICE_ATTR(ipato_add4, add4, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_ipato_add4_show,
 			qeth_l3_dev_ipato_add4_store);
 
@@ -588,7 +588,7 @@ static ssize_t qeth_l3_dev_ipato_del4_store(struct device *dev,
 	return qeth_l3_dev_ipato_del_store(buf, count, card, QETH_PROT_IPV4);
 }
 
-static QETH_DEVICE_ATTR(ipato_del4, del4, 0200, NULL,
+static QETH_DEVICE_ATTR(ipato_del4, del4, S_IWUSR, NULL,
 			qeth_l3_dev_ipato_del4_store);
 
 static ssize_t qeth_l3_dev_ipato_invert6_show(struct device *dev,
@@ -624,7 +624,7 @@ static ssize_t qeth_l3_dev_ipato_invert6_store(struct device *dev,
 	return rc ? rc : count;
 }
 
-static QETH_DEVICE_ATTR(ipato_invert6, invert6, 0644,
+static QETH_DEVICE_ATTR(ipato_invert6, invert6, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_ipato_invert6_show,
 			qeth_l3_dev_ipato_invert6_store);
 
@@ -651,7 +651,7 @@ static ssize_t qeth_l3_dev_ipato_add6_store(struct device *dev,
 	return qeth_l3_dev_ipato_add_store(buf, count, card, QETH_PROT_IPV6);
 }
 
-static QETH_DEVICE_ATTR(ipato_add6, add6, 0644,
+static QETH_DEVICE_ATTR(ipato_add6, add6, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_ipato_add6_show,
 			qeth_l3_dev_ipato_add6_store);
 
@@ -666,7 +666,7 @@ static ssize_t qeth_l3_dev_ipato_del6_store(struct device *dev,
 	return qeth_l3_dev_ipato_del_store(buf, count, card, QETH_PROT_IPV6);
 }
 
-static QETH_DEVICE_ATTR(ipato_del6, del6, 0200, NULL,
+static QETH_DEVICE_ATTR(ipato_del6, del6, S_IWUSR, NULL,
 			qeth_l3_dev_ipato_del6_store);
 
 static struct attribute *qeth_ipato_device_attrs[] = {
@@ -762,7 +762,7 @@ static ssize_t qeth_l3_dev_vipa_add4_store(struct device *dev,
 	return qeth_l3_dev_vipa_add_store(buf, count, card, QETH_PROT_IPV4);
 }
 
-static QETH_DEVICE_ATTR(vipa_add4, add4, 0644,
+static QETH_DEVICE_ATTR(vipa_add4, add4, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_vipa_add4_show,
 			qeth_l3_dev_vipa_add4_store);
 
@@ -791,7 +791,7 @@ static ssize_t qeth_l3_dev_vipa_del4_store(struct device *dev,
 	return qeth_l3_dev_vipa_del_store(buf, count, card, QETH_PROT_IPV4);
 }
 
-static QETH_DEVICE_ATTR(vipa_del4, del4, 0200, NULL,
+static QETH_DEVICE_ATTR(vipa_del4, del4, S_IWUSR, NULL,
 			qeth_l3_dev_vipa_del4_store);
 
 static ssize_t qeth_l3_dev_vipa_add6_show(struct device *dev,
@@ -816,7 +816,7 @@ static ssize_t qeth_l3_dev_vipa_add6_store(struct device *dev,
 	return qeth_l3_dev_vipa_add_store(buf, count, card, QETH_PROT_IPV6);
 }
 
-static QETH_DEVICE_ATTR(vipa_add6, add6, 0644,
+static QETH_DEVICE_ATTR(vipa_add6, add6, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_vipa_add6_show,
 			qeth_l3_dev_vipa_add6_store);
 
@@ -831,7 +831,7 @@ static ssize_t qeth_l3_dev_vipa_del6_store(struct device *dev,
 	return qeth_l3_dev_vipa_del_store(buf, count, card, QETH_PROT_IPV6);
 }
 
-static QETH_DEVICE_ATTR(vipa_del6, del6, 0200, NULL,
+static QETH_DEVICE_ATTR(vipa_del6, del6, S_IWUSR, NULL,
 			qeth_l3_dev_vipa_del6_store);
 
 static struct attribute *qeth_vipa_device_attrs[] = {
@@ -924,7 +924,7 @@ static ssize_t qeth_l3_dev_rxip_add4_store(struct device *dev,
 	return qeth_l3_dev_rxip_add_store(buf, count, card, QETH_PROT_IPV4);
 }
 
-static QETH_DEVICE_ATTR(rxip_add4, add4, 0644,
+static QETH_DEVICE_ATTR(rxip_add4, add4, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_rxip_add4_show,
 			qeth_l3_dev_rxip_add4_store);
 
@@ -953,7 +953,7 @@ static ssize_t qeth_l3_dev_rxip_del4_store(struct device *dev,
 	return qeth_l3_dev_rxip_del_store(buf, count, card, QETH_PROT_IPV4);
 }
 
-static QETH_DEVICE_ATTR(rxip_del4, del4, 0200, NULL,
+static QETH_DEVICE_ATTR(rxip_del4, del4, S_IWUSR, NULL,
 			qeth_l3_dev_rxip_del4_store);
 
 static ssize_t qeth_l3_dev_rxip_add6_show(struct device *dev,
@@ -978,7 +978,7 @@ static ssize_t qeth_l3_dev_rxip_add6_store(struct device *dev,
 	return qeth_l3_dev_rxip_add_store(buf, count, card, QETH_PROT_IPV6);
 }
 
-static QETH_DEVICE_ATTR(rxip_add6, add6, 0644,
+static QETH_DEVICE_ATTR(rxip_add6, add6, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_l3_dev_rxip_add6_show,
 			qeth_l3_dev_rxip_add6_store);
 
@@ -993,7 +993,7 @@ static ssize_t qeth_l3_dev_rxip_del6_store(struct device *dev,
 	return qeth_l3_dev_rxip_del_store(buf, count, card, QETH_PROT_IPV6);
 }
 
-static QETH_DEVICE_ATTR(rxip_del6, del6, 0200, NULL,
+static QETH_DEVICE_ATTR(rxip_del6, del6, S_IWUSR, NULL,
 			qeth_l3_dev_rxip_del6_store);
 
 static struct attribute *qeth_rxip_device_attrs[] = {
-- 
2.9.2
