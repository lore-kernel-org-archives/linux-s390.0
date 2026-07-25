Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE863290C9;
	Sat, 25 Jul 2026 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993253; cv=none; b=lBkOzu90zqoJ0ONJiHufPjsU8ZbmUTM/7sD2RxtKqxSFqdLRDYlnyJPCm4QbCIbiZR0SPM6VUaQFTs1L/wmo8rz9rY/AYVLhTtj0TXHttHqQPy0iyAUDL+cNK64JFUbKTlDKx3lPqjxlshhy/wGgyp8hhUHVZg5IClY3p5pqhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993253; c=relaxed/simple;
	bh=MWY+0jwbIadbvBE2zh8KwKV7cb6u/VW77xCaJIKZglw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIXb1xaGTLOc36iPCPYv3qvlaWRUBWJ3vJtSdsrglQUo7zOsuODWitQlx8rgjVkQaiyg0KYyktlCNiTNtZ8iBhyuecBH7ba9CNbzY8ulfvTTJmgg6sST3HJStAopceZM99FC8OIEGwu6JNhFZYeba3jbgYxhB3LDVooExQbPrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GUL2t6WW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GUL2t6WW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDlhsl3116604;
	Sat, 25 Jul 2026 15:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5su0AaUohi1LbDjfP
	2X2bZCB1n+7Y8xMGiDzn+rlF7U=; b=GUL2t6WWSsv6IMau50P8qtbg3Kax6qApa
	+hiCwq/ILh62VJEcAdg9e32I0n4O3rtkSyVhlrEkpDm7Fh+7zNS54KbLZcKNfbmt
	6HkpSqDXjI+XzkrlKrZ0C5R3ERfCfpq8fGYK37Rq7+xKtF3i7xv1Ras1jUIbqkQB
	g8A8FRLWzaNVRhP58G3c58plQnUlza1XDjxGKLi/KNLl3qBXVbmWxEXhyZJYeFuA
	rcfzVoDcrvmRhcvjbUYvM3Rt1/XdXNB0fQK9nIVNdKUnd4j+VquW+fbJD9YLsCXr
	LQbuKwzldDfy59YMQBL5aRJ705QQMjvDKN8u1aK3Lt5H1BtbaGveg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc0k05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQRQN000348;
	Sat, 25 Jul 2026 15:27:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12hp6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFRJG851577174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BBB200C5;
	Sat, 25 Jul 2026 15:27:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C99200C4;
	Sat, 25 Jul 2026 15:27:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 69D4216280D; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v4 3/9] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Sat, 25 Jul 2026 17:26:59 +0200
Message-ID: <20260725152705.3958100-4-farman@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: mEjJd8AQFgl-DI2TY-FfpR9J2VL2wZp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX6swVFCMA6Xz1
 ujCjpeiM2Q/lJfCbwPCsZkCQW2xzB2YkZIEEUytVer4EiWNyuTZ1mRsFyCW6O8EX+V2AA1HEujN
 RGSdFdJ6WdwlKrtSkZQoQpLShf/5JqBB4Rxbv7t8AS+lNCw3yaAKBJVPlHoUwtqXCbpNJ50zyft
 ny+T+iVMIFs7Cn+n5mnXNXpk3Zw3xi8i+cDRZVD//Dl6tDFiIwX1cbc86CRXBa0ZajVHLwReQxP
 jrVZG0O2NlQx21ZwHD6VDgm8JNkIR35VeZEpKc1nx35FTYIPpIxWQogE/WtD7IuBf0AAGKA1m/d
 YmYGxuqurpkuY0kPL6jtc6/6/xh8Rn1Rt/EOMen6/RUivhogYO/gzRWClkKj0gdo6ytR4WwGUng
 /FhzncD95eMyw8Ja/sdu/QFOntxTBBRQ1z1zCoZddQHoNxrRLm4KFcNPQ5F0HZj7VksUywrFHoR
 V9OcOiKRLGmbjduLHmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX8BYD+CTpE1Ty
 nIfMBZLNHWxh9PVB9xWqIQUCFOwsqDKDLV7EBktr2KNqMpqUfL5HZxpPp/kDyfid027mxvNEuHo
 keC68NJv+XL5f/0mP5fov47hZ25F9tY=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a64d5dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A5C3NnK3Tz1osX5E1PIA:9
X-Proofpoint-GUID: mEjJd8AQFgl-DI2TY-FfpR9J2VL2wZp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250144

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

