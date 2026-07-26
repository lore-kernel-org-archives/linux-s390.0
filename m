Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E533D3D0E;
	Sun, 26 Jul 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086524; cv=none; b=ubABKeZWtjauVkZqYyve8AmKTdxotNte8BQcJnThlGsZYcAaznr9m8fGluph96Cyrn9QkoE05dccnreaFJoa93WEZt8xbccciUo4ms66k/KF4WvVVSF8cK4c9wEIPSJl/8VgZ2C7Dw06e4TAaeXj9Lb52n+X3DRvYn5VOtEFUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086524; c=relaxed/simple;
	bh=p+PbP0myv75st5mwvzBTsdFK7aSDgUKdeNFvumRPnck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueqFOXMbrpkfmCfR+ExVnE3+ZoQeoNd//DX7Kx+mAUc7sB2BJKDYZ8SkX03lw/6sFUYE6oslmGh0x/YwycHR9DNhtgKyGke+V/XzKTAIf4BrinEWPN5Bg039Q44R8hZQhMVIapKExbJoZEBZ8BUQjAExUhkeQ69o7vFkxioktmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lZuwSgnu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lZuwSgnu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHHbm24044080;
	Sun, 26 Jul 2026 17:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WRGNLeV0oXr2M/BZ+
	sfXha8JHIJWYlAk6/V1XSPYaiM=; b=lZuwSgnugDWycFtxWT56Er8SjTXuKhCEp
	rMt5ziNRX5KxyH9oHp8cEDryjq7l8y0mpe8QxxUwgNmVLUBxzPa3vCBBIVGh6GH/
	GnA/UTHg2Kxzn/2fEL+MfGtl6A2s+C2yV0ex5OJyd38qgnh+7lsHT9MzG1fOQ6jx
	ssWzXYmlWvqCsdGox/JxPFW88BnAlaYiwJly9DIA2Sjh1il3P+4R2k3hUMGKaeJG
	XADG7rEXc6DdgRGHI/TJFdN4B95vyj2qiN3/jIx1Lp4p8OSlOb7YthjXLHZ/5yrb
	srVAZBHo/Bf9Whj55Z2sB8MyylO3JxEq5X9o1VsiKoGxOxinzmROQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw74bqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBgIU030562;
	Sun, 26 Jul 2026 17:22:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjt7vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLu5037618032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6CA420082;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BBAE20081;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 7F3C6160E89; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v6 01/10] s390/vfio_ccw: free all memory if cp_init() fails
Date: Sun, 26 Jul 2026 19:21:44 +0200
Message-ID: <20260726172153.1818056-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726172153.1818056-1-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KcKAtfbZ1xSwrU-o_w7AgSspTFV2IKOa
X-Proofpoint-ORIG-GUID: KcKAtfbZ1xSwrU-o_w7AgSspTFV2IKOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfXx0VYFrxSYfM4
 hpRqDCCXP6rspYhdvPoG9gZgrJRpJVyKPsHfVCMLTKgfi/hQ8iZ1tcVBO+xheK2aLphrQ04p6SL
 5le4gKoThzqVT8yHfLlEKFqWKvCJARGwB/VSUPu6jSH59ZYHQS+/uDtlpNNLrJob4UT2K+cO8G1
 5UxD6DtnngCpkcWe/qtgRYxon1uBhzjH/B2xyO3Ep3cYW1x66c6ZjTKkhp6Yftctqarp3JdlOku
 NLggQSiiJJB963DuassH/HnNm66y+KW2yg4/pCpeV2kSRgNsFBQ/5G4zHa+RE8LA1qaGkz0WLnL
 deP6A3s9W22q4xtI99Lavr/1H8FQWGSIQL1cmKF/Or8wFyZ3UeVwIUtFXl16wmtoVviDh8DUAnK
 ZcEJmYL3+I4N8CQcZ5MCcN6cIIhM5/4Umga1Ksf0A18e79bKB/YwSyBDkSofYfTY+u45kw8uypp
 Eg+XtCHY0TbhxAb5REQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a66423a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WEmllObKAWPfCt-5-jUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX1UF3Mz0ZFccd
 kpMDdNoAKOIjhWPZULB+HKGqxWG3Lwxt4DINkFuRL3T8arxz3HHSM5IlTqqeEl+SogXfGNCH+dd
 5nIbMIpGiU2RlNz4BwuSUHmT+IuT1cE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260175

The routine cp_free() is called to unpin/free any memory once an I/O
is completed successfully, or if cp_prefetch() fails. But if cp_init()
fails, and cp->initialized is not enabled, the same routine cannot be
used to free all the memory.

An attempt to address this exists in ccwchain_handle_ccw(), where a
single call to ccwchain_free() is made for the currently-processed
CCW segment. But this will leak other segments (created as a result
of a Transfer in Channel) that had been allocated as part of the same
channel program.

Address this by performing the cleanup outside of the recursive
ccwchain_handle_ccw()/ccwchain_loop_tic() logic.

Fixes: 8b515be512a2 ("vfio-ccw: Fix memory leak and don't call cp_free in=
 cp_init")
Cc: stable@vger.kernel.org
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 7561aa7d3e01..086d1b54bdb0 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct ch=
annel_program *cp)
 	/* Loop for tics on this new chain. */
 	ret =3D ccwchain_loop_tic(chain, cp);
=20
-	if (ret)
-		ccwchain_free(chain);
-
 	return ret;
 }
=20
@@ -486,6 +483,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain,=
 struct channel_program *cp)
 	return 0;
 }
=20
+static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
+{
+	struct ccwchain *chain, *temp;
+	int ret;
+
+	ret =3D ccwchain_handle_ccw(cda, cp);
+
+	if (ret) {
+		/* Cleanup if an error occurred */
+		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+			ccwchain_free(chain);
+		}
+	}
+
+	return ret;
+}
+
 static int ccwchain_fetch_tic(struct ccw1 *ccw,
 			      struct channel_program *cp)
 {
@@ -735,7 +749,7 @@ int cp_init(struct channel_program *cp, union orb *or=
b)
 	memcpy(&cp->orb, orb, sizeof(*orb));
=20
 	/* Build a ccwchain for the first CCW segment */
-	ret =3D ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	ret =3D ccwchain_build_ccws(orb->cmd.cpa, cp);
=20
 	if (!ret)
 		cp->initialized =3D true;
--=20
2.53.0

