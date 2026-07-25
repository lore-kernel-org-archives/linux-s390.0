Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFBF26AA91;
	Sat, 25 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993237; cv=none; b=XZ+EpCLaCKJzAwwJCgB4XnBAsq+Ra+B3lxOsJiooMOe6V7p+YjUk9hGhqbLFgjPNmY7JaDaBSNHuPBFtdQ8/R0ouhHy7V1Sv2tIuvspDIXv3JfvLR0oOGlx7Vx57mkMKAZjj1zQ8gOmeqfhmihT6E3eN+PknGfJu6aiFL5f2e80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993237; c=relaxed/simple;
	bh=p+PbP0myv75st5mwvzBTsdFK7aSDgUKdeNFvumRPnck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNH7FzX3tDA0JcG/qid0QgeX4wwjCgEPkod2vbZiVb8L4qd95I+d1pWL1AHU803eNC3YmIWgzPgPMmLnw4hUE7EveqmCrEz3Ea/vGdQj8//I8BPc1l/2AzHR0pxuSwkWIXkg1fxq6nOCzB/JhiXf9y+TX59AHTFi/L9vcExPB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dM+sUMUC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dM+sUMUC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDnC86818552;
	Sat, 25 Jul 2026 15:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WRGNLeV0oXr2M/BZ+
	sfXha8JHIJWYlAk6/V1XSPYaiM=; b=dM+sUMUCLBGdS6DA21I4SU1qBx8N/Yix8
	6qCQOwwhlMNX8i6EoCTtG8t96No4/dErG6s3C2pBrZIi0DZB2lsqE/0cOEEyPtff
	aJF8wD90vvxkZlQ9Yfnf5+GRdYUs2MCtx2YythYlp+9fEqIUamGqXou2YGTRVjtc
	qpUwZ5aTK8/UWpyzw4yV7x0rYUQO2v7/jR8lhaDwnb1vgOu0ZQMxIZhQJHeknLBO
	VaBxOe7OBRmLwOt0Ap+SSNqbYx5AaY7J3U9pA4exBdrHrv1EPNNS2G2GwOZrPDwJ
	HdtoKayvj29V6BGcb98NMgx0xBtnDOrzTH7pJLl+HpJDHywChSAdw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0x8jru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQM5d014015;
	Sat, 25 Jul 2026 15:27:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5h9n22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFR92b47382798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 939AF200E2;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C0A8200E1;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 65643162803; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v4 1/9] s390/vfio_ccw: free all memory if cp_init() fails
Date: Sat, 25 Jul 2026 17:26:57 +0200
Message-ID: <20260725152705.3958100-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725152705.3958100-1-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kfUMBgCPJTeDA7HvlONg_PDdYcgkNmzQ
X-Proofpoint-ORIG-GUID: kfUMBgCPJTeDA7HvlONg_PDdYcgkNmzQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX25JUif95S4gr
 gHMWH1GLA0CExX9QrY1F3mcdZKiP5cXK8mnXXBPMHT/WT5breMnM14sPhZHklHtUsHLJOBJboG6
 tqUuJuPvcqXN8MadWbzyHGKKFtAjaFk=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a64d5d2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WEmllObKAWPfCt-5-jUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX+sxZYBt4K9u3
 qSitZJQbwGLf4BwkI3q2Zr2LbYSOKHXLdy1fJsvt9v6HdgdcR+BAVVvIydRlEKF2zWnXdahaS0F
 LzxYXVaDkF5vWD75PqN5kkDk3bkwP+yvaODzIBLNLUJHTKvplQToxF5ElDROvS8+AT/x1GYj7pi
 PsXBLuoRLmvl348jrNz3kTu9o4lYyP235zrPxGV+NfCDpbuwbSGbVF0/paR3z7TnS3RsX65tuaN
 Yl948hcpS0wZeMqNz3nkUEqGjCCaQQlMFnULe7Uf2okC7dOBJc4Rq+fZhBYAhKc5wGo7kmbRpku
 QoA78q8DNApHYi0J4eyEgl+k38TR/yZ5/jwakuk2wAzAAzX352UArvdujmIwNPpC/Yb2GlF8D2z
 kdLugBreW+QbZbUtNwLExso9Ny3ALrkbjgnJJju3GtGt17MCYol03uK+Ltewc4MMhp5SWsSKz6a
 nSztDjyMFt8f/XsY5tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250144

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

