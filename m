Return-Path: <linux-kernel-owner+w=401wt.eu-S1754531AbYCLRcu@vger.kernel.org>
Message-Id: <20080312173216.213008370@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
Date: Wed, 12 Mar 2008 18:31:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/10] Add new fields for System z10 to /proc/sysinfo
Content-Disposition: inline; filename=101-sysinfo.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add permanent and temporary model capacity and the corresponding
capacity value fields for the three capacity identifiers to the
output of /proc/sysinfo.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/sysinfo.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/sysinfo.c
===================================================================
--- quilt-2.6.orig/drivers/s390/sysinfo.c
+++ quilt-2.6/drivers/s390/sysinfo.c
@@ -26,6 +26,11 @@ struct sysinfo_1_1_1 {
 	char sequence[16];
 	char plant[4];
 	char model[16];
+	char model_perm_cap[16];
+	char model_temp_cap[16];
+	char model_cap_rating[4];
+	char model_perm_cap_rating[4];
+	char model_temp_cap_rating[4];
 };
 
 struct sysinfo_1_2_1 {
@@ -133,6 +138,8 @@ static int stsi_1_1_1(struct sysinfo_1_1
 	EBCASC(info->sequence, sizeof(info->sequence));
 	EBCASC(info->plant, sizeof(info->plant));
 	EBCASC(info->model_capacity, sizeof(info->model_capacity));
+	EBCASC(info->model_perm_cap, sizeof(info->model_perm_cap));
+	EBCASC(info->model_temp_cap, sizeof(info->model_temp_cap));
 	len += sprintf(page + len, "Manufacturer:         %-16.16s\n",
 		       info->manufacturer);
 	len += sprintf(page + len, "Type:                 %-4.4s\n",
@@ -155,8 +162,18 @@ static int stsi_1_1_1(struct sysinfo_1_1
 		       info->sequence);
 	len += sprintf(page + len, "Plant:                %-4.4s\n",
 		       info->plant);
-	len += sprintf(page + len, "Model Capacity:       %-16.16s\n",
-		       info->model_capacity);
+	len += sprintf(page + len, "Model Capacity:       %-16.16s %08u\n",
+		       info->model_capacity, *(u32 *) info->model_cap_rating);
+	if (info->model_perm_cap[0] != '\0')
+		len += sprintf(page + len,
+			       "Model Perm. Capacity: %-16.16s %08u\n",
+			       info->model_perm_cap,
+			       *(u32 *) info->model_perm_cap_rating);
+	if (info->model_temp_cap[0] != '\0')
+		len += sprintf(page + len,
+			       "Model Temp. Capacity: %-16.16s %08u\n",
+			       info->model_temp_cap,
+			       *(u32 *) info->model_temp_cap_rating);
 	return len;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
