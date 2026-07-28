Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E52C0261;
	Tue, 28 Jul 2026 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202518; cv=none; b=IRt4ybkhYDF2GuXdKIxQ4B1YzfEXFpE+d1z6Bs9V70wpmJil2yeCtvEljWmNJ4uZcnmNQKIcxqjmGd1VdTqRzPexATftJmJnCkvs8fVX6DRwH/zuKYdcXO6FyHXSlhn0DvzcXcqjo7G2Mfaa1BBxCgEPq1/1lFF8AKsvi0CGEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202518; c=relaxed/simple;
	bh=n+mbvvJEI8CH8TTkOdaxw00F0Fq88vljPQWMjBMIOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg0p8osjXnM5iuRsEj+TYoPn79zTNRNes5zhZQRBTQFWkr3nmbtlcSDKz+tQvy/y5oXBMZvid5m9Aeg9YWyfIs7mmrJAjVcw7VBxXYESsOLK4d6E2OibvAdLn79p2C4Rrqobxi+FMMCpLT9NT3GNlmtqtscfe9ii6Cpop2ZBqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XLuvt0XR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XLuvt0XR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0mVgr3675438;
	Tue, 28 Jul 2026 01:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gW7VP8CspOGU+wF0/
	N72fT1Tle3KtK4wWLpeUE28hPo=; b=XLuvt0XRmFEPZ4r8z1aEREaw89ox77Crd
	lWyZ4ypIGqFvheYxAI/kiU4axqirX0EWyKTbtd2nskmcL6SJeY2hVjXMoOIyeH60
	AutrFCc9avuG+rFJFoCwFyvhjBIh6gzTLwGu8dJUQK5o/iwujgcjhCAQ5Pm7y+jn
	6BpImDPOqYux1Wk4iefEhKRyIIZsi0chdSeRWFskLnOniuGgG+wBDDA6X5QhpIuR
	xNYVSyIBYLPFuJ2MZuJPFTPQW+dhTipplvi6t/R8swePPc0tykK0AxCBkOiesmH/
	bo4GSNhh6jEjzXX900W+b5xKRkUBo9vyErFqdloZLcPBkRr55efOQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0njc49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1QQk0029311;
	Tue, 28 Jul 2026 01:35:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq7x1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S1ZAF550069804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 01:35:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B68492009C;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 928C52009B;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 79536162820; Tue, 28 Jul 2026 03:35:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v8 03/10] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Tue, 28 Jul 2026 03:35:02 +0200
Message-ID: <20260728013509.1551753-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728013509.1551753-1-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfXwZMyDxxyOb3Q
 wlIzPt+y2aG13ZSWcysOPO3tAQg/5rU0xZswUQ3CaORutKcEYMmftUR+X6Jp6WvbrqQJ7KKNX/p
 svYzoFRIa6ERwLOFhfHlBFX3LL3U+LQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX02aq34Hn696l
 oh55mRFLmxf9IQHB0olLNEzef1fI3nqqCEnNZwwFiwCHyg6K7sgacMGjAClp2lRyTNOSQt/EHlm
 FndxyQdcxl60/93S/pqHKspgD0gSU4yXdRyqMIe3qtZ75yn5ysO/DOkBbrHn5oIScCffa4vneRW
 Mv5d76KCGVqxt1D3a/oagtTTz3NMFCDipBecXRfJLEQzdo3q4UQ9Q92qiqs6sj2KoM3PE0jMoQ9
 pzndU/9T6LDQDWVGwuFA2tklzMy/8OW5h9UAnW4rZov3tCXZqXYUn78aB53h8zOMWhJ/waqd/pm
 mrRpOFoVSBEn8sjfBjedjyPtjSahqIppQ39VwbCnQIIbFNrBZ1vxrgZUXikbdKXxSco67n1Tb06
 J3940tG6C3bMeij0z/ebyygnMF+BA0SD4rYHKqmjwB5q0kyQ++UVcmRiZCKSmZlTIui5dkot2Cc
 ujF4VxlmqxEEo4gnM2g==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a680753 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A5C3NnK3Tz1osX5E1PIA:9
X-Proofpoint-GUID: UymOfGnzSQ6PCzZxVNhW32e2-2Xk-YUI
X-Proofpoint-ORIG-GUID: UymOfGnzSQ6PCzZxVNhW32e2-2Xk-YUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280009

The routine ccwchain_calc_length() counts the number of channel
command words (CCWs) that are chained together in a single channel
program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.

The loop itself is "do..while (count < 257)", and while the logic in
is_cpa_within_range() correctly adjusts between the 0-index array of
CCWs and the count of CCWs starting at 1, this means it would look
at a possible 257th CCW before ending the loop and (correctly)
returning an error.

Fix this by restructuring the loop to break as soon as 256 CCWs
(thus indexes 0-255) are examined, without looking at memory
outside the range.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 1c2890d139c6..af632f9d5453 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -377,11 +377,9 @@ static void ccwchain_cda_free(struct ccwchain *chain=
, int idx)
 static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 {
 	struct ccw1 *ccw =3D cp->guest_cp;
-	int cnt =3D 0;
-
-	do {
-		cnt++;
+	int cnt;
=20
+	for (cnt =3D 1; cnt <=3D CCWCHAIN_LEN_MAX; cnt++, ccw++) {
 		/*
 		 * We want to keep counting if the current CCW has the
 		 * command-chaining flag enabled, or if it is a TIC CCW
@@ -391,15 +389,10 @@ static int ccwchain_calc_length(u64 iova, struct ch=
annel_program *cp)
 		 * after the TIC, depending on the results of its operation.
 		 */
 		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
-			break;
-
-		ccw++;
-	} while (cnt < CCWCHAIN_LEN_MAX + 1);
-
-	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
-		cnt =3D -EINVAL;
+			return cnt;
+	}
=20
-	return cnt;
+	return -EINVAL;
 }
=20
 static int tic_target_chain_exists(struct ccw1 *tic, struct channel_prog=
ram *cp)
--=20
2.53.0

