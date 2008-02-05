Return-Path: <linux-kernel-owner+w=401wt.eu-S1756223AbYBEPkJ@vger.kernel.org>
Message-Id: <20080205153910.840339871@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/18] cio: Clean up chsc response code handling.
Content-Disposition: inline; filename=002-cio-chsc-rc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

This provides unified return codes for common response codes and
also makes the debug feature messages more similar and informational.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |  147 +++++++++++++++++-------------------------------
 1 file changed, 55 insertions(+), 92 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -26,6 +26,25 @@
 
 static void *sei_page;
 
+static int chsc_error_from_response(int response)
+{
+	switch (response) {
+	case 0x0001:
+		return 0;
+	case 0x0002:
+	case 0x0003:
+	case 0x0006:
+	case 0x0007:
+	case 0x0008:
+	case 0x000a:
+		return -EINVAL;
+	case 0x0004:
+		return -EOPNOTSUPP;
+	default:
+		return -EIO;
+	}
+}
+
 struct chsc_ssd_area {
 	struct chsc_header request;
 	u16 :10;
@@ -75,11 +94,11 @@ int chsc_get_ssd_info(struct subchannel_
 		ret = (ccode == 3) ? -ENODEV : -EBUSY;
 		goto out_free;
 	}
-	if (ssd_area->response.code != 0x0001) {
+	ret = chsc_error_from_response(ssd_area->response.code);
+	if (ret != 0) {
 		CIO_MSG_EVENT(2, "chsc: ssd failed for 0.%x.%04x (rc=%04x)\n",
 			      schid.ssid, schid.sch_no,
 			      ssd_area->response.code);
-		ret = -EIO;
 		goto out_free;
 	}
 	if (!ssd_area->sch_valid) {
@@ -717,36 +736,15 @@ __chsc_do_secm(struct channel_subsystem 
 		return (ccode == 3) ? -ENODEV : -EBUSY;
 
 	switch (secm_area->response.code) {
-	case 0x0001: /* Success. */
-		ret = 0;
-		break;
-	case 0x0003: /* Invalid block. */
-	case 0x0007: /* Invalid format. */
-	case 0x0008: /* Other invalid block. */
-		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
-		ret = -EINVAL;
-		break;
-	case 0x0004: /* Command not provided in model. */
-		CIO_CRW_EVENT(2, "Model does not provide secm\n");
-		ret = -EOPNOTSUPP;
-		break;
-	case 0x0102: /* cub adresses incorrect */
-		CIO_CRW_EVENT(2, "Invalid addresses in chsc request block\n");
-		ret = -EINVAL;
-		break;
-	case 0x0103: /* key error */
-		CIO_CRW_EVENT(2, "Access key error in secm\n");
+	case 0x0102:
+	case 0x0103:
 		ret = -EINVAL;
-		break;
-	case 0x0105: /* error while starting */
-		CIO_CRW_EVENT(2, "Error while starting channel measurement\n");
-		ret = -EIO;
-		break;
 	default:
-		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
-			      secm_area->response.code);
-		ret = -EIO;
+		ret = chsc_error_from_response(secm_area->response.code);
 	}
+	if (ret != 0)
+		CIO_CRW_EVENT(2, "chsc: secm failed (rc=%04x)\n",
+			      secm_area->response.code);
 	return ret;
 }
 
@@ -827,27 +825,14 @@ int chsc_determine_channel_path_descript
 		goto out;
 	}
 
-	switch (scpd_area->response.code) {
-	case 0x0001: /* Success. */
+	ret = chsc_error_from_response(scpd_area->response.code);
+	if (ret == 0)
+		/* Success. */
 		memcpy(desc, &scpd_area->desc,
 		       sizeof(struct channel_path_desc));
-		ret = 0;
-		break;
-	case 0x0003: /* Invalid block. */
-	case 0x0007: /* Invalid format. */
-	case 0x0008: /* Other invalid block. */
-		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
-		ret = -EINVAL;
-		break;
-	case 0x0004: /* Command not provided in model. */
-		CIO_CRW_EVENT(2, "Model does not provide scpd\n");
-		ret = -EOPNOTSUPP;
-		break;
-	default:
-		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
+	else
+		CIO_CRW_EVENT(2, "chsc: scpd failed (rc=%04x)\n",
 			      scpd_area->response.code);
-		ret = -EIO;
-	}
 out:
 	free_page((unsigned long)scpd_area);
 	return ret;
@@ -923,8 +908,9 @@ int chsc_get_channel_measurement_chars(s
 		goto out;
 	}
 
-	switch (scmc_area->response.code) {
-	case 0x0001: /* Success. */
+	ret = chsc_error_from_response(scmc_area->response.code);
+	if (ret == 0) {
+		/* Success. */
 		if (!scmc_area->not_valid) {
 			chp->cmg = scmc_area->cmg;
 			chp->shared = scmc_area->shared;
@@ -935,22 +921,9 @@ int chsc_get_channel_measurement_chars(s
 			chp->cmg = -1;
 			chp->shared = -1;
 		}
-		ret = 0;
-		break;
-	case 0x0003: /* Invalid block. */
-	case 0x0007: /* Invalid format. */
-	case 0x0008: /* Invalid bit combination. */
-		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
-		ret = -EINVAL;
-		break;
-	case 0x0004: /* Command not provided. */
-		CIO_CRW_EVENT(2, "Model does not provide scmc\n");
-		ret = -EOPNOTSUPP;
-		break;
-	default:
-		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
+	} else {
+		CIO_CRW_EVENT(2, "chsc: scmc failed (rc=%04x)\n",
 			      scmc_area->response.code);
-		ret = -EIO;
 	}
 out:
 	free_page((unsigned long)scmc_area);
@@ -1002,21 +975,17 @@ chsc_enable_facility(int operation_code)
 		ret = (ret == 3) ? -ENODEV : -EBUSY;
 		goto out;
 	}
+
 	switch (sda_area->response.code) {
-	case 0x0001: /* everything ok */
-		ret = 0;
-		break;
-	case 0x0003: /* invalid request block */
-	case 0x0007:
-		ret = -EINVAL;
-		break;
-	case 0x0004: /* command not provided */
-	case 0x0101: /* facility not provided */
+	case 0x0101:
 		ret = -EOPNOTSUPP;
 		break;
-	default: /* something went wrong */
-		ret = -EIO;
+	default:
+		ret = chsc_error_from_response(sda_area->response.code);
 	}
+	if (ret != 0)
+		CIO_CRW_EVENT(2, "chsc: sda (oc=%x) failed (rc=%04x)\n",
+			      operation_code, sda_area->response.code);
  out:
 	free_page((unsigned long)sda_area);
 	return ret;
@@ -1041,33 +1010,27 @@ chsc_determine_css_characteristics(void)
 	} __attribute__ ((packed)) *scsc_area;
 
 	scsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!scsc_area) {
-		CIO_MSG_EVENT(0, "Was not able to determine available "
-			      "CHSCs due to no memory.\n");
+	if (!scsc_area)
 		return -ENOMEM;
-	}
 
 	scsc_area->request.length = 0x0010;
 	scsc_area->request.code = 0x0010;
 
 	result = chsc(scsc_area);
 	if (result) {
-		CIO_MSG_EVENT(0, "Was not able to determine available CHSCs, "
-			      "cc=%i.\n", result);
-		result = -EIO;
+		result = (result == 3) ? -ENODEV : -EBUSY;
 		goto exit;
 	}
 
-	if (scsc_area->response.code != 1) {
-		CIO_MSG_EVENT(0, "Was not able to determine "
-			      "available CHSCs.\n");
-		result = -EIO;
-		goto exit;
-	}
-	memcpy(&css_general_characteristics, scsc_area->general_char,
-	       sizeof(css_general_characteristics));
-	memcpy(&css_chsc_characteristics, scsc_area->chsc_char,
-	       sizeof(css_chsc_characteristics));
+	result = chsc_error_from_response(scsc_area->response.code);
+	if (result == 0) {
+		memcpy(&css_general_characteristics, scsc_area->general_char,
+		       sizeof(css_general_characteristics));
+		memcpy(&css_chsc_characteristics, scsc_area->chsc_char,
+		       sizeof(css_chsc_characteristics));
+	} else
+		CIO_CRW_EVENT(2, "chsc: scsc failed (rc=%04x)\n",
+			      scsc_area->response.code);
 exit:
 	free_page ((unsigned long) scsc_area);
 	return result;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
