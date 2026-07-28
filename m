Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B83446B0;
	Tue, 28 Jul 2026 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209431; cv=none; b=HJxS4MZ/m7LbRcxtSKoce25AXMXk1NP06lQ7VpD1DiGB0msmnt6MlyH29RxJ3BWa+QVLZ/ZRfeYWEnWm5nl0zFzfs8X1RXZ8+vul9iFcQnmSvNzVDhuv/JXm4vmowEUe280LiujfB7Ys8LI4SF3QeVp/lZzT7lCZzvMnOuvBeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209431; c=relaxed/simple;
	bh=n+mbvvJEI8CH8TTkOdaxw00F0Fq88vljPQWMjBMIOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZvEbvuAxZOWVGqrV3oJ4AREFFWn3KGRDRnMELQbjhGJUwnLvYY6aGZnnghrkn1zh49vPg5wFjNA0tQ9TtPlg/SI423KRIP5RX4dLRQlGHnZC+P+nYPDbtd8LnnVxWlrnNUybXZbZJDnLI6jogz+UC8zPwB6txgUp3myDG97x3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HyiyPSC/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HyiyPSC/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0luV73783806;
	Tue, 28 Jul 2026 03:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gW7VP8CspOGU+wF0/
	N72fT1Tle3KtK4wWLpeUE28hPo=; b=HyiyPSC/WMG2LyzvnQwkRE8ASkjQumvUo
	D50kDP63w/hGJGbSlKMddsUiT3lFEo/namrat5ZRyfTZEplVo6eyzWq8QvKEl/2m
	Hl3sN0fyu3gx0P37jQOaZDLgRqKgFDmh5ToQzCKX9F1GzTyj5JQLMlqWiu92H8MR
	Cm/w3dDxwBkCnHxFTOWFxtL3zoEcH5HkbjORpotsczJ15MmBVNgrQHAi4xcbP2/h
	WRJ8NqN5lX5qvyZyZHXJtK3vDOFia1Qk4F17bKueKyjCx0e3Svtk7m8he414SWiT
	xTiOl+CWArNeq8aJNIAcvyxLFPm4tnNSqY0qRqnaSyiTewOPxpPfA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xk93j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S3QMpN002271;
	Tue, 28 Jul 2026 03:30:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq880u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S3UOj714025016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 03:30:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E7FB2005A;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CF8E2004E;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 16B5416281B; Tue, 28 Jul 2026 05:30:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v9 03/10] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Tue, 28 Jul 2026 05:30:15 +0200
Message-ID: <20260728033022.2658232-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728033022.2658232-1-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: faNNML45TC-HAoBDhaVYT6zK21fldiVf
X-Proofpoint-ORIG-GUID: faNNML45TC-HAoBDhaVYT6zK21fldiVf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX39rEC4GaJ9yr
 fZiacqYJYzfSoRq5dKAHYff0JUuN+eFloP1JpSdHm+UF8uHwXHpDm2uHwB7naHWUnFGXEYCkC+l
 YRqeRcg83ry9iTaQ8dZvCEpqHWyLi6U=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a682255 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A5C3NnK3Tz1osX5E1PIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX7QD1EcE04iVg
 TfuxPmJgWXUHFp6lE2wWd/Klat9ja9vBLjJkSNfPLm1rCEkfPkZmVs/tunapiTNDxi9wtB51p+I
 GBw5DTCOFsebdBzy0oORgBN+/Gbe0UQFl03eSVb0ZptSsWZon34VZPSgkEUF6r8r8IAB06zEXma
 aoSWCtymYmqBEckSnm0m+SEizGpQ2Q22pKqDj6hlk24XSNyo86S/jWxzGB7xb/VQ+xO7PCSjRnT
 BJSsd3cUCVJPcWlJEEFzvXxph+CzKrsEaEwg464cbM8XzhrEQzUb3tw+hBbPfiPs1jcHW5zo3j5
 mosQCaMln3aByOTzXWvNHgdgjQ5MB5cEVOLTIlXOBJrOdUB3xp8mNNIDtqjrPSI8rsgSiMy6Jz2
 zPNYUakBVqsiIHTV7o1X1VdP5IIiv4+aWaynzrVs3A4u2ZEy6Vs4Hs4b+mYWVCq03yv5i5gmKZU
 LNRov5UupYEkCNbslRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280028

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

