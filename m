Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0885/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:14 +0800
Message-Id: <20160802115514.8982-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/s390/cio/cmf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index b2afad5..2b8b387 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -96,7 +96,7 @@ enum cmb_format {
  * enum cmb_format.
  */
 static int format = CMF_AUTODETECT;
-module_param(format, bint, 0444);
+module_param(format, bint, S_IRUSR | S_IRGRP | S_IROTH);
 
 /**
  * struct cmb_operations - functions to use depending on cmb_format
@@ -470,7 +470,7 @@ static struct cmb_area cmb_area = {
  * maximum is 4096.
  */
 
-module_param_named(maxchannels, cmb_area.num_channels, uint, 0444);
+module_param_named(maxchannels, cmb_area.num_channels, uint, S_IRUSR | S_IRGRP | S_IROTH);
 
 /**
  * struct cmb - basic channel measurement block
@@ -1106,9 +1106,9 @@ cmf_attr_avg(device_active_only_time);
 cmf_attr_avg(device_busy_time);
 cmf_attr_avg(initial_command_response_time);
 
-static DEVICE_ATTR(avg_sample_interval, 0444, cmb_show_avg_sample_interval,
+static DEVICE_ATTR(avg_sample_interval, S_IRUSR | S_IRGRP | S_IROTH, cmb_show_avg_sample_interval,
 		   NULL);
-static DEVICE_ATTR(avg_utilization, 0444, cmb_show_avg_utilization, NULL);
+static DEVICE_ATTR(avg_utilization, S_IRUSR | S_IRGRP | S_IROTH, cmb_show_avg_utilization, NULL);
 
 static struct attribute *cmf_attributes[] = {
 	&dev_attr_avg_sample_interval.attr,
-- 
2.9.2
