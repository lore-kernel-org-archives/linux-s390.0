Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65543C7D3
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899071; cv=none; b=fxi4UAuRBUTHCTnF+Gjo/oL0qBDi2LpEFIVa5bMA2NDN1wHVQ64OvYqfOP3rgnqdRDD3orSHMqF743s36AZU5BENflGtllFGOIgOID1wB2PGCUP0u9DnbAWufHcdX1qzvlOiEcVCp2ad5/Em2YKyi8kBCrF7lgs+y4AprUA/9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899071; c=relaxed/simple;
	bh=u31Xm6uvKZT0EettGEkWjVeaMwX0HzkEek9yh3FFpeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEAhR6sz8TTzEmHwtPr5K7+IpI7dsBhaN+9+y4pkBrvWiHSHYUqFjioGgpERTrshuwfyp97hwrLiHqP15T7E7zXasbCS+2n4N9UZTayDaS33h7AFvFVVw0Iy/QJl4M8Jj0xi/ZTndkVEio2hFUXPMpsq7ezazoA5Bad5TDyGik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dn8Hsqlr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dn8Hsqlr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDfuGb1774883
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q7vVNs9n53o7iXr6q
	sKQb+r82fzUAWf2rVG/F+BDT5A=; b=Dn8HsqlrvxMzeDP/AZ06HI2auBpbS23Mc
	c3BL7jioWwVqmtSLZMj0dUlZnAwLcqPSTfuDRqEIF70UP6Bg/op3Rs+HPuZAFGM7
	CvjC/OLLDB6BRrCCpvQpT/HeIucuwvD6PpqDzftDpBsdx6s1nnciYvTS5yAY3ilK
	Upodm+P0A4CRR4uYzyAeNoe+xL0Lx4MxMnMTx7dAc6o6JgVjo+Nr/n/3siETrKLI
	LPdcA/r/Aa++mAVFdKTjbLqal+ohSXtceTUyktLKbPikWx/NIfP5o6BHb3uVIZ/g
	30+AEdl1ZsvMQnyW3BO+r4D48ZQR1qywDaqeiV7/t2PRFYcsEKFUA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhx2f2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCO79W2709269
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h21ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DDiNCR16843044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 13:44:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5072320040;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F5092004F;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.94.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 1/2] s390/ap: Support new APMLM field with PQAP/TAPQ instruction
Date: Tue, 13 Oct 2026 15:44:21 +0200
Message-ID: <20261013134422.64155-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013134422.64155-1-freude@linux.ibm.com>
References: <20261013134422.64155-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX+Shtq7YaFUzt
 /ddTuBTwtybESHEIaHA8oC1+TZ8aYa3nLxvbDKjQgkGDrtwNfJ1K+M+iU74jvP6rykfwQLUzw5c
 sRg+H4UFHoHXZD0WIb9wrfooF5mTsJoYeyGAhGiRfyLO6g5yUwu7i2cv5J1HBIOUq6JGxkILVsm
 FwWkn8QNIdST8P5huENUG7Y7BWVG4+cAiibK//2FYbwhsewemikVPPG2oM46DFRB93Q+wm3p1CK
 JPQBJt4Ee63fvM5Ag04Pr9ZC1dC95s9J9BTJHvyvYz1QZY4gFN1FrtmfpJpWTRIgCqVfwDRyVvr
 +NAF/BH1xqhAdy72ib68NkNs/JkBoaIf9yo60Nob/Ac/wVsOGlPs1dupbBrsusgEVn7jq/XEXkW
 O6ogisw/rajqhF4aCSLqb5HUujvEvtj/ehqyGs6eOgJ+qvg/Tmkak8CY/bxBY/g4XefrEkd+tBk
 A+CeDQ1BmQWwbOZcYJA==
X-Proofpoint-GUID: c-B0mUMuvJIowMWgrKdnunZf3_mVgFN5
X-Proofpoint-ORIG-GUID: c-B0mUMuvJIowMWgrKdnunZf3_mVgFN5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX8YNOwb2jeGzs
 eshAU0dQN0QjAFVJhT4BARJ2gjdvks8+WZbjySG7sllbuWkeYgzhw4GwBg5fte7tUoJuzGoNwia
 0R1F4Ej5hRZd/XDAAvHhyenl9eIrh14=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ace35bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=9dvGAY6gNLD2BIB7gb4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130054

There is a new field APMLM (AP message limit multiplier) defined
within the GR2 register on successful invocation of the TAPQ
subfunction for the PQAP instruction.

So the new formula to calculate the AP max message limit is now:

  if ml field <= 3
    AP max message limit is 12KB
  else
    AP max message limit = apml * (apmlm + 1) * 4KB

Also adapt the HWINFO mask to have this new apmlm field shine
through this bit filter mask.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/include/asm/ap.h    | 4 ++--
 drivers/s390/crypto/ap_bus.h  | 2 +-
 drivers/s390/crypto/ap_card.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index c91b6ace199d..01d575c35887 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -123,8 +123,8 @@ struct ap_tapq_hwinfo {
 			unsigned int	   : 14;
 			unsigned int at	   :  8; /* ap type */
 			unsigned int nd	   :  8; /* nr of domains */
-			unsigned int	   :  4;
-			unsigned int ml	   :  4; /* apxl ml */
+			unsigned int mlm   :  4; /* AP msg limit multiplier */
+			unsigned int ml	   :  4; /* AP msg limit */
 			unsigned int	   :  3;
 			unsigned int qd	   :  5; /* queue depth */
 		};
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index fb4d678336e4..34f9dcd96bc7 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -181,7 +181,7 @@ struct ap_card {
 	bool chkstop;			/* checkstop state */
 };
 
-#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFF0F1FUL
+#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFFFF1FUL
 #define ASSOC_IDX_INVALID 0x10000
 
 #define to_ap_card(x) container_of((x), struct ap_card, ap_dev.device)
diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index c86397f4ddcd..e9a8180f08c2 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct ap_tapq_hwinfo hwinfo,
 	ac->hwinfo = hwinfo;
 	ac->id = id;
 	ac->maxmsgsize = hwinfo.ml > 3 ?
-		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
+		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
+		AP_DEFAULT_MAX_MSG_SIZE;
 
 	return ac;
 }
-- 
2.43.0

