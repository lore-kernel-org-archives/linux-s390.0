Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0896/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:56:06 +0800
Message-Id: <20160802115606.9709-1-baolex.ni@intel.com>
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
 drivers/s390/net/qeth_l2_sys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 692db49..926d584 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -100,7 +100,7 @@ static ssize_t qeth_bridge_port_role_store(struct device *dev,
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(bridge_role, 0644, qeth_bridge_port_role_show,
+static DEVICE_ATTR(bridge_role, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, qeth_bridge_port_role_show,
 		   qeth_bridge_port_role_store);
 
 static ssize_t qeth_bridge_port_state_show(struct device *dev,
@@ -109,7 +109,7 @@ static ssize_t qeth_bridge_port_state_show(struct device *dev,
 	return qeth_bridge_port_role_state_show(dev, attr, buf, 1);
 }
 
-static DEVICE_ATTR(bridge_state, 0444, qeth_bridge_port_state_show,
+static DEVICE_ATTR(bridge_state, S_IRUSR | S_IRGRP | S_IROTH, qeth_bridge_port_state_show,
 		   NULL);
 
 static ssize_t qeth_bridgeport_hostnotification_show(struct device *dev,
@@ -157,7 +157,7 @@ static ssize_t qeth_bridgeport_hostnotification_store(struct device *dev,
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(bridge_hostnotify, 0644,
+static DEVICE_ATTR(bridge_hostnotify, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_bridgeport_hostnotification_show,
 			qeth_bridgeport_hostnotification_store);
 
@@ -218,7 +218,7 @@ static ssize_t qeth_bridgeport_reflect_store(struct device *dev,
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(bridge_reflect_promisc, 0644,
+static DEVICE_ATTR(bridge_reflect_promisc, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			qeth_bridgeport_reflect_show,
 			qeth_bridgeport_reflect_store);
 
-- 
2.9.2
