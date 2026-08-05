Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A5B471D04;
	Wed,  5 Aug 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936996; cv=none; b=ibhhrW8cXxEplXsUpdJOIqHVGePXtkRTHpKcCmdYADuZATa7FFosbynSqUas3e8pAqm2d8L1xomndn03o/65o+NL5q9i7UoGinwzmWSIxTPPL0xGhgDA7uW4Ln20Mk0/jccZTUy5eLIuAqpEWPd7s4TcAf2CBoK6vegIzOgnEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936996; c=relaxed/simple;
	bh=MD2p9uu7/dJLT8xpJEoUQvqM/2MsFEs/OulayiYTwmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxZBR2esyhGmueqoLAoGGdS5dMhFYuiVXq8U5wwXLDkGiZoYeGNOYlh+DSUHvZ7vApQPxXyCerOSgdKZL0wuJgugOHxbzjc795acAiJTwFAwpTo4NQ1PDpdiz3wSHsHpb/ISbUiVxS2/h8g70PLRqt0Vw7nyNURPjwwDyJoOjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aGfpKlIB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aGfpKlIB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHnFM3724695;
	Wed, 5 Aug 2026 13:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IrgL8RqSglKkOyj5L
	roGQLh/JY/zuzIzE45hgk8qe04=; b=aGfpKlIB/MEMpBi3hzOmTaR5+F07GXAPI
	nsAGgmSiL+3ekCRnJqSE1LquZ8By6BRI+2OufEAqk4QhCHN/254ZsGDkocNllw2h
	ga5NqmEE7TOA7WTz6qeWIp19xQEdJ6A92kH5lXXBvCTZwJgJTV9ct8SdJVfhoIUE
	/0MeWwq7Ze+oAG7K8b8VgBAj9QukYyX82LSai6k4ofgG0PfE2HLae8akTQcWh08F
	75cFdg7mvwiYeFEgy60ioNF3Wlswji3HbTJibjDHUGh5zA0oUXFIbNQ9vWxw3lQR
	Ip26XKjvalN7GLsfhg4TcHAp7XzyTjbABhE30FMNeAw2MFQ6BDTDQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gavr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DQHHt027135;
	Wed, 5 Aug 2026 13:36:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhenv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DaSgb49545724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:36:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC6720040;
	Wed,  5 Aug 2026 13:36:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 161B92004B;
	Wed,  5 Aug 2026 13:36:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 13:36:28 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] s390/pci: Rework __zpci_event_availability() to remove conditional locking
Date: Wed,  5 Aug 2026 15:36:26 +0200
Message-ID: <20260805133627.1216607-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805133627.1216607-1-hca@linux.ibm.com>
References: <20260805133627.1216607-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX9cMr9i9CvTzt
 BxuD9zzxf1O8zgX6AdO6NOuMTNOUT2r8hb15YPmo5YiDonC95LJ197Vf3Hh0P3mDRaL4hVlUfzO
 LYfEPmUDZk62HFqJM1ZiQMK5B2LZp5pRApdwET9UGhdxb1nSzu7+p23VV+7DBWLKcoRAPsEVO3d
 898s74tl3lZvQCepWpKjmYDDlJWiz7OWADgWN8rtqim8hgNxFClS3l06UkGeNoV66/UYZHZFmg9
 LqW4Ww+y1Djvu1gXoEv6HusM19+gev22506i+9aK5Q/v0M5oVZKPn88C0aj+T8/JEXITquvaksI
 JRGCI551nOwlLS6xlRVIxs+twWgXLowX9IG5M6N8UC/y2LeqDPKhaEc8dyvw9c6qkb+fKt4aY6K
 1RPFdT18sJ7kdvrb9tK0QEdKbu4ewBGjK1YLQ2UQnZ9aAM6m0u0wHXHd3WDl4x7d69GgP2xgC2a
 iHCQ+j/eNmJRHc972Ow==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a733c61 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=poQ7gJ9nSTMEjbrCJsEA:9
X-Proofpoint-GUID: uofeoXWfKrGKwuur-sd8Q6UBlYHCBy82
X-Proofpoint-ORIG-GUID: uofeoXWfKrGKwuur-sd8Q6UBlYHCBy82
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX2JOBVx6V/mlm
 P1a0RwRGT/94fDpDEPR8AciyEMelYsRz1qaOW64KHcdtc1/8o4kdgxgO6oV6nd528dU707glNPt
 rzj4NvMBocz58CeopQ7DWOCcJFXrzrU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050107

Clang's compiler based static context analysis does not work with locks
that are conditionally taken like in __zpci_event_availability():

arch/s390/pci/pci_event.c:402:10: warning: mutex 'get_zdev_by_fid(ccdf->fid).state_lock'
  is not held on every path through here [-Wthread-safety-analysis]

Given that code which takes locks conditionally can be considered
suboptimal rework __zpci_event_availability() to get rid of this.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 162 ++++++++++++++++++++------------------
 1 file changed, 85 insertions(+), 77 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index bead4ed5d4ab..0a9eecb62bd1 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -387,98 +387,106 @@ static void zpci_event_reappear(struct zpci_dev *zdev)
 	zpci_dbg(1, "rea fid:%x, fh:%x\n", zdev->fid, zdev->fh);
 }
 
-static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
+static bool zpci_event_avail_any_device(struct zpci_ccdf_avail *ccdf)
 {
-	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
-	bool existing_zdev = !!zdev;
-	enum zpci_state state;
+	/* 0x0306 - No handle or fid stored */
+	if (ccdf->pec != 0x0306)
+		return false;
+	/* 0x308 or 0x302 for multiple devices */
+	zpci_remove_reserved_devices();
+	zpci_scan_devices();
+	return true;
+}
 
-	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
-		 ccdf->fid, ccdf->fh, ccdf->pec);
-
-	if (existing_zdev)
-		mutex_lock(&zdev->state_lock);
+static void zpci_event_avail_new_device(struct zpci_ccdf_avail *ccdf)
+{
+	struct zpci_dev *zdev;
 
 	switch (ccdf->pec) {
 	case 0x0301: /* Reserved|Standby -> Configured */
-		if (!zdev) {
-			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
-			if (IS_ERR(zdev))
-				break;
-			if (zpci_add_device(zdev)) {
-				kfree(zdev);
-				break;
-			}
-		} else {
-			if (zdev->state == ZPCI_FN_STATE_RESERVED)
-				zpci_event_reappear(zdev);
-			/* the configuration request may be stale */
-			else if (zdev->state != ZPCI_FN_STATE_STANDBY)
-				break;
-			zdev->state = ZPCI_FN_STATE_CONFIGURED;
+		zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
+		if (IS_ERR(zdev))
+			break;
+		if (zpci_add_device(zdev)) {
+			kfree(zdev);
+			break;
 		}
 		zpci_scan_configured_device(zdev, ccdf->fh);
 		break;
 	case 0x0302: /* Reserved -> Standby */
-		if (!zdev) {
-			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
-			if (IS_ERR(zdev))
-				break;
-			if (zpci_add_device(zdev)) {
-				kfree(zdev);
-				break;
-			}
-		} else {
-			if (zdev->state == ZPCI_FN_STATE_RESERVED)
-				zpci_event_reappear(zdev);
-			zpci_update_fh(zdev, ccdf->fh);
-		}
-		break;
-	case 0x0303: /* Deconfiguration requested */
-		if (zdev) {
-			/* The event may have been queued before we configured
-			 * the device.
-			 */
-			if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
-				break;
-			zpci_update_fh(zdev, ccdf->fh);
-			zpci_deconfigure_device(zdev);
-		}
-		break;
-	case 0x0304: /* Configured -> Standby|Reserved */
-		if (zdev) {
-			/* The event may have been queued before we configured
-			 * the device.:
-			 */
-			if (zdev->state == ZPCI_FN_STATE_CONFIGURED)
-				zpci_event_hard_deconfigured(zdev, ccdf->fh);
-			/* The 0x0304 event may immediately reserve the device */
-			if (!clp_get_state(zdev->fid, &state) &&
-			    state == ZPCI_FN_STATE_RESERVED) {
-				zpci_device_reserved(zdev);
-			}
-		}
-		break;
-	case 0x0306: /* 0x308 or 0x302 for multiple devices */
-		zpci_remove_reserved_devices();
-		zpci_scan_devices();
-		break;
-	case 0x0308: /* Standby -> Reserved */
-		if (!zdev)
+		zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
+		if (IS_ERR(zdev))
 			break;
-		zpci_device_reserved(zdev);
-		break;
-	default:
+		if (zpci_add_device(zdev)) {
+			kfree(zdev);
+			break;
+		}
 		break;
 	}
-	if (existing_zdev) {
-		mutex_unlock(&zdev->state_lock);
-		zpci_zdev_put(zdev);
+}
+
+static void zpci_event_avail_existing_device(struct zpci_dev *zdev, struct zpci_ccdf_avail *ccdf)
+{
+	enum zpci_state state;
+
+	switch (ccdf->pec) {
+	case 0x0301: /* Reserved|Standby -> Configured */
+		if (zdev->state == ZPCI_FN_STATE_RESERVED)
+			zpci_event_reappear(zdev);
+		/* the configuration request may be stale */
+		else if (zdev->state != ZPCI_FN_STATE_STANDBY)
+			break;
+		zdev->state = ZPCI_FN_STATE_CONFIGURED;
+		zpci_scan_configured_device(zdev, ccdf->fh);
+		break;
+	case 0x0302: /* Reserved -> Standby */
+		if (zdev->state == ZPCI_FN_STATE_RESERVED)
+			zpci_event_reappear(zdev);
+		zpci_update_fh(zdev, ccdf->fh);
+		break;
+	case 0x0303: /* Deconfiguration requested */
+		/* The event may have been queued before we configured
+		 * the device.
+		 */
+		if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
+			break;
+		zpci_update_fh(zdev, ccdf->fh);
+		zpci_deconfigure_device(zdev);
+		break;
+	case 0x0304: /* Configured -> Standby|Reserved */
+		/* The event may have been queued before we configured
+		 * the device.:
+		 */
+		if (zdev->state == ZPCI_FN_STATE_CONFIGURED)
+			zpci_event_hard_deconfigured(zdev, ccdf->fh);
+		/* The 0x0304 event may immediately reserve the device */
+		if (!clp_get_state(zdev->fid, &state) &&
+		    state == ZPCI_FN_STATE_RESERVED) {
+			zpci_device_reserved(zdev);
+		}
+		break;
+	case 0x0308: /* Standby -> Reserved */
+		zpci_device_reserved(zdev);
+		break;
 	}
 }
 
 void zpci_event_availability(void *data)
 {
-	if (zpci_is_enabled())
-		__zpci_event_availability(data);
+	struct zpci_ccdf_avail *ccdf = data;
+	struct zpci_dev *zdev;
+
+	if (!zpci_is_enabled())
+		return;
+	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
+		 ccdf->fid, ccdf->fh, ccdf->pec);
+	if (zpci_event_avail_any_device(ccdf))
+		return;
+	zdev = get_zdev_by_fid(ccdf->fid);
+	if (!zdev)
+		return zpci_event_avail_new_device(ccdf);
+	mutex_lock(&zdev->state_lock);
+	zpci_event_avail_existing_device(zdev, ccdf);
+	mutex_unlock(&zdev->state_lock);
+	zpci_zdev_put(zdev);
 }
-- 
2.53.0

