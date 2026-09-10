Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A347126A;
	Thu, 10 Sep 2026 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038025; cv=none; b=ql+fueCxIji6vasP4jTbbXmAx8iOchEJMZae3C38IHdtT78seIM8rTeN68Qj+P/lZzfixTsS/1+TYRqajNq346YN+qhE+R3wyOtLxqsK4jagOhEbErqiBf+VUc1KtLFFF71EtprSjRa9w9WZrmiyJfVQ0xFVxZvO88oKIDCQp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038025; c=relaxed/simple;
	bh=CSUDFFdhmtCWeW8oSX88//X3I6uiPteZhW4Opf/GQyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qz7EUw/FeoJ/qGPOhM1VzBD0eGmqlHMrH4Dr0OnAWPWZM3ZiiHfmI6b1WFLY6Ss0v18GaACPqWU2lsLMXWkI/c+zSo2Sdph5V7XblDCy/rfYahoUZDBGuoGOPXJigHu+n4tTGhogcxUuPhnnGHonM5eu15UPYMd4MCLU5SnlM+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aij3lXrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aij3lXrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479C91F00898;
	Thu, 10 Sep 2026 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038023;
	bh=wH/HnScIECqzPez57vPSs9kJwAMAsBLZmPepnLoPjpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aij3lXrDhzEmq4euQgQGNWweCFCBcmv0Ru0IiJlQP6T/gGHCdTA5F2z8v2TOzbEaG
	 r9EC/B87klCZ6vmju7+fOePhoDhM6PShCPX0Bk3998yr4qWk9WVmKKexXQTBSOdWA4
	 OUsqhnLJ5MWyxT3egO7/NOrzO25AboDvPj7FEDkkGnPOrKTdpUPUKAXHzTHRGbvkgm
	 6lDdW7QmQ18221krdqayeKawV9PKSfqQXNN6eLHBRKw9XImdCEIIRCEC6phN3offim
	 T/vY/+sxFKJ6b9ozKhfOmBz/wEDM6Fp//r2VsYk/wJQYrwf8DfiTJ7NQRg/FUYPPvk
	 eolO1XLedPSCA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:06 +0300
Subject: [PATCH v2 04/13] s390/chsc_sch: Use __free(kfree) for synchronous
 CHSC requests
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-4-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
In-Reply-To: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.17-dev

Use __free(kfree) for local buffers in the synchronous CHSC ioctl
handlers and replace their cleanup labels with early returns.

Keep the asynchronous and on-close handlers unchanged.

Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/chsc_sch.c | 272 +++++++++++++++-----------------------------
 1 file changed, 92 insertions(+), 180 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index c8d6871d1841e..225aaac7dd309 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/kernel_stat.h>
+#include <linux/cleanup.h>
 
 #include <asm/cio.h>
 #include <asm/chsc.h>
@@ -389,39 +390,29 @@ static int chsc_ioctl_on_close_remove(void)
 
 static int chsc_ioctl_start_sync(void __user *user_area)
 {
-	struct chsc_sync_area *chsc_area;
-	int ret, ccode;
+	struct chsc_sync_area *chsc_area __free(kfree) = NULL;
+	int ccode;
 
 	chsc_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!chsc_area)
 		return -ENOMEM;
-	if (copy_from_user(chsc_area, user_area, PAGE_SIZE)) {
-		ret = -EFAULT;
-		goto out_free;
-	}
-	if (chsc_area->header.code & 0x4000) {
-		ret = -EINVAL;
-		goto out_free;
-	}
+	if (copy_from_user(chsc_area, user_area, PAGE_SIZE))
+		return -EFAULT;
+	if (chsc_area->header.code & 0x4000)
+		return -EINVAL;
 	chsc_log_command(chsc_area);
 	ccode = chsc(chsc_area);
-	if (ccode != 0) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (ccode != 0)
+		return -EIO;
 	if (copy_to_user(user_area, chsc_area, PAGE_SIZE))
-		ret = -EFAULT;
-	else
-		ret = 0;
-out_free:
-	kfree(chsc_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static int chsc_ioctl_info_channel_path(void __user *user_cd)
 {
-	struct chsc_chp_cd *cd;
-	int ret, ccode;
+	struct chsc_chp_cd *cd __free(kfree) = NULL;
+	int ccode;
 	struct {
 		struct chsc_header request;
 		u32 : 2;
@@ -436,20 +427,16 @@ static int chsc_ioctl_info_channel_path(void __user *user_cd)
 		u32 : 32;
 		struct chsc_header response;
 		u8 data[PAGE_SIZE - 20];
-	} __attribute__ ((packed)) *scpcd_area;
+	} __attribute__ ((packed)) *scpcd_area __free(kfree) = NULL;
 
 	scpcd_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!scpcd_area)
 		return -ENOMEM;
 	cd = kzalloc_obj(*cd);
-	if (!cd) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(cd, user_cd, sizeof(*cd))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	if (!cd)
+		return -ENOMEM;
+	if (copy_from_user(cd, user_cd, sizeof(*cd)))
+		return -EFAULT;
 	scpcd_area->request.length = 0x0010;
 	scpcd_area->request.code = 0x0028;
 	scpcd_area->m = cd->m;
@@ -459,31 +446,23 @@ static int chsc_ioctl_info_channel_path(void __user *user_cd)
 	scpcd_area->last_chpid = cd->chpid.id;
 
 	ccode = chsc(scpcd_area);
-	if (ccode != 0) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (ccode != 0)
+		return -EIO;
 	if (scpcd_area->response.code != 0x0001) {
-		ret = -EIO;
 		CHSC_MSG(0, "scpcd: response code=%x\n",
 			 scpcd_area->response.code);
-		goto out_free;
+		return -EIO;
 	}
 	memcpy(&cd->cpcb, &scpcd_area->response, scpcd_area->response.length);
 	if (copy_to_user(user_cd, cd, sizeof(*cd)))
-		ret = -EFAULT;
-	else
-		ret = 0;
-out_free:
-	kfree(cd);
-	kfree(scpcd_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static int chsc_ioctl_info_cu(void __user *user_cd)
 {
-	struct chsc_cu_cd *cd;
-	int ret, ccode;
+	struct chsc_cu_cd *cd __free(kfree) = NULL;
+	int ccode;
 	struct {
 		struct chsc_header request;
 		u32 : 2;
@@ -498,20 +477,16 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 		u32 : 32;
 		struct chsc_header response;
 		u8 data[PAGE_SIZE - 20];
-	} __attribute__ ((packed)) *scucd_area;
+	} __attribute__ ((packed)) *scucd_area __free(kfree) = NULL;
 
 	scucd_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!scucd_area)
 		return -ENOMEM;
 	cd = kzalloc_obj(*cd);
-	if (!cd) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(cd, user_cd, sizeof(*cd))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	if (!cd)
+		return -ENOMEM;
+	if (copy_from_user(cd, user_cd, sizeof(*cd)))
+		return -EFAULT;
 	scucd_area->request.length = 0x0010;
 	scucd_area->request.code = 0x0026;
 	scucd_area->m = cd->m;
@@ -521,31 +496,23 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 	scucd_area->last_cun = cd->cun;
 
 	ccode = chsc(scucd_area);
-	if (ccode != 0) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (ccode != 0)
+		return -EIO;
 	if (scucd_area->response.code != 0x0001) {
-		ret = -EIO;
 		CHSC_MSG(0, "scucd: response code=%x\n",
 			 scucd_area->response.code);
-		goto out_free;
+		return -EIO;
 	}
 	memcpy(&cd->cucb, &scucd_area->response, scucd_area->response.length);
 	if (copy_to_user(user_cd, cd, sizeof(*cd)))
-		ret = -EFAULT;
-	else
-		ret = 0;
-out_free:
-	kfree(cd);
-	kfree(scucd_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static int chsc_ioctl_info_sch_cu(void __user *user_cud)
 {
-	struct chsc_sch_cud *cud;
-	int ret, ccode;
+	struct chsc_sch_cud *cud __free(kfree) = NULL;
+	int ccode;
 	struct {
 		struct chsc_header request;
 		u32 : 2;
@@ -561,20 +528,16 @@ static int chsc_ioctl_info_sch_cu(void __user *user_cud)
 		u32 : 32;
 		struct chsc_header response;
 		u8 data[PAGE_SIZE - 20];
-	} __attribute__ ((packed)) *sscud_area;
+	} __attribute__ ((packed)) *sscud_area __free(kfree) = NULL;
 
 	sscud_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sscud_area)
 		return -ENOMEM;
 	cud = kzalloc_obj(*cud);
-	if (!cud) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(cud, user_cud, sizeof(*cud))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	if (!cud)
+		return -ENOMEM;
+	if (copy_from_user(cud, user_cud, sizeof(*cud)))
+		return -EFAULT;
 	sscud_area->request.length = 0x0010;
 	sscud_area->request.code = 0x0006;
 	sscud_area->m = cud->schid.m;
@@ -585,31 +548,23 @@ static int chsc_ioctl_info_sch_cu(void __user *user_cud)
 	sscud_area->last_sch = cud->schid.sch_no;
 
 	ccode = chsc(sscud_area);
-	if (ccode != 0) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (ccode != 0)
+		return -EIO;
 	if (sscud_area->response.code != 0x0001) {
-		ret = -EIO;
 		CHSC_MSG(0, "sscud: response code=%x\n",
 			 sscud_area->response.code);
-		goto out_free;
+		return -EIO;
 	}
 	memcpy(&cud->scub, &sscud_area->response, sscud_area->response.length);
 	if (copy_to_user(user_cud, cud, sizeof(*cud)))
-		ret = -EFAULT;
-	else
-		ret = 0;
-out_free:
-	kfree(cud);
-	kfree(sscud_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static int chsc_ioctl_conf_info(void __user *user_ci)
 {
-	struct chsc_conf_info *ci;
-	int ret, ccode;
+	struct chsc_conf_info *ci __free(kfree) = NULL;
+	int ccode;
 	struct {
 		struct chsc_header request;
 		u32 : 2;
@@ -623,20 +578,16 @@ static int chsc_ioctl_conf_info(void __user *user_ci)
 		u64 : 64;
 		struct chsc_header response;
 		u8 data[PAGE_SIZE - 20];
-	} __attribute__ ((packed)) *sci_area;
+	} __attribute__ ((packed)) *sci_area __free(kfree) = NULL;
 
 	sci_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sci_area)
 		return -ENOMEM;
 	ci = kzalloc_obj(*ci);
-	if (!ci) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(ci, user_ci, sizeof(*ci))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	if (!ci)
+		return -ENOMEM;
+	if (copy_from_user(ci, user_ci, sizeof(*ci)))
+		return -EFAULT;
 	sci_area->request.length = 0x0010;
 	sci_area->request.code = 0x0012;
 	sci_area->m = ci->id.m;
@@ -645,31 +596,23 @@ static int chsc_ioctl_conf_info(void __user *user_ci)
 	sci_area->ssid = ci->id.ssid;
 
 	ccode = chsc(sci_area);
-	if (ccode != 0) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (ccode != 0)
+		return -EIO;
 	if (sci_area->response.code != 0x0001) {
-		ret = -EIO;
 		CHSC_MSG(0, "sci: response code=%x\n",
 			 sci_area->response.code);
-		goto out_free;
+		return -EIO;
 	}
 	memcpy(&ci->scid, &sci_area->response, sci_area->response.length);
 	if (copy_to_user(user_ci, ci, sizeof(*ci)))
-		ret = -EFAULT;
-	else
-		ret = 0;
-out_free:
-	kfree(ci);
-	kfree(sci_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 {
-	struct chsc_comp_list *ccl;
-	int ret, ccode;
+	struct chsc_comp_list *ccl __free(kfree) = NULL;
+	int ccode;
 	struct {
 		struct chsc_header request;
 		u32 ctype : 8;
@@ -681,7 +624,7 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 		u64 : 64;
 		struct chsc_header response;
 		u8 data[PAGE_SIZE - 36];
-	} __attribute__ ((packed)) *sccl_area;
+	} __attribute__ ((packed)) *sccl_area __free(kfree) = NULL;
 	struct {
 		u32 m : 1;
 		u32 : 31;
@@ -700,14 +643,10 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 	if (!sccl_area)
 		return -ENOMEM;
 	ccl = kzalloc_obj(*ccl);
-	if (!ccl) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(ccl, user_ccl, sizeof(*ccl))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	if (!ccl)
+		return -ENOMEM;
+	if (copy_from_user(ccl, user_ccl, sizeof(*ccl)))
+		return -EFAULT;
 	sccl_area->request.length = 0x0020;
 	sccl_area->request.code = 0x0030;
 	sccl_area->fmt = ccl->req.fmt;
@@ -728,61 +667,46 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 		break;
 	}
 	ccode = chsc(sccl_area);
-	if (ccode != 0) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (ccode != 0)
+		return -EIO;
 	if (sccl_area->response.code != 0x0001) {
-		ret = -EIO;
 		CHSC_MSG(0, "sccl: response code=%x\n",
 			 sccl_area->response.code);
-		goto out_free;
+		return -EIO;
 	}
 	memcpy(&ccl->sccl, &sccl_area->response, sccl_area->response.length);
 	if (copy_to_user(user_ccl, ccl, sizeof(*ccl)))
-		ret = -EFAULT;
-	else
-		ret = 0;
-out_free:
-	kfree(ccl);
-	kfree(sccl_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static int chsc_ioctl_chpd(void __user *user_chpd)
 {
-	struct chsc_scpd *scpd_area;
-	struct chsc_cpd_info *chpd;
+	struct chsc_scpd *scpd_area __free(kfree) = NULL;
+	struct chsc_cpd_info *chpd __free(kfree) = NULL;
 	int ret;
 
 	chpd = kzalloc_obj(*chpd);
 	scpd_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
-	if (!scpd_area || !chpd) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(chpd, user_chpd, sizeof(*chpd))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	if (!scpd_area || !chpd)
+		return -ENOMEM;
+	if (copy_from_user(chpd, user_chpd, sizeof(*chpd)))
+		return -EFAULT;
 	ret = chsc_determine_channel_path_desc(chpd->chpid, chpd->fmt,
 					       chpd->rfmt, chpd->c, chpd->m,
 					       scpd_area);
 	if (ret)
-		goto out_free;
+		return ret;
 	memcpy(&chpd->chpdb, &scpd_area->response, scpd_area->response.length);
 	if (copy_to_user(user_chpd, chpd, sizeof(*chpd)))
-		ret = -EFAULT;
-out_free:
-	kfree(chpd);
-	kfree(scpd_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static int chsc_ioctl_dcal(void __user *user_dcal)
 {
-	struct chsc_dcal *dcal;
-	int ret, ccode;
+	struct chsc_dcal *dcal __free(kfree) = NULL;
+	int ccode;
 	struct {
 		struct chsc_header request;
 		u32 atype : 8;
@@ -794,20 +718,16 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 		u32 res1[2];
 		struct chsc_header response;
 		u8 data[PAGE_SIZE - 36];
-	} __attribute__ ((packed)) *sdcal_area;
+	} __attribute__ ((packed)) *sdcal_area __free(kfree) = NULL;
 
 	sdcal_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sdcal_area)
 		return -ENOMEM;
 	dcal = kzalloc_obj(*dcal);
-	if (!dcal) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(dcal, user_dcal, sizeof(*dcal))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	if (!dcal)
+		return -ENOMEM;
+	if (copy_from_user(dcal, user_dcal, sizeof(*dcal)))
+		return -EFAULT;
 	sdcal_area->request.length = 0x0020;
 	sdcal_area->request.code = 0x0034;
 	sdcal_area->atype = dcal->req.atype;
@@ -816,26 +736,18 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 	       sizeof(sdcal_area->list_parm));
 
 	ccode = chsc(sdcal_area);
-	if (ccode != 0) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (ccode != 0)
+		return -EIO;
 	if (sdcal_area->response.code != 0x0001) {
-		ret = -EIO;
 		CHSC_MSG(0, "sdcal: response code=%x\n",
 			 sdcal_area->response.code);
-		goto out_free;
+		return -EIO;
 	}
 	memcpy(&dcal->sdcal, &sdcal_area->response,
 	       sdcal_area->response.length);
 	if (copy_to_user(user_dcal, dcal, sizeof(*dcal)))
-		ret = -EFAULT;
-	else
-		ret = 0;
-out_free:
-	kfree(dcal);
-	kfree(sdcal_area);
-	return ret;
+		return -EFAULT;
+	return 0;
 }
 
 static long chsc_ioctl(struct file *filp, unsigned int cmd,

-- 
2.53.0

