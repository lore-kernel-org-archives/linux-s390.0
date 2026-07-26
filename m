Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D3366567;
	Sun, 26 Jul 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086529; cv=none; b=hkVcTsmy9OHwyJL1R48vqtL+9zf/CrxyieGU6lr7WuxiL0ijNyBgWFFdEu89HBohqRVw+2UsFj0P+2qgX6uoDMqXKGjCYtXWWPNQ2WABj8N0Blb++wEXu3WEC6pW6Dc6mxifrMtIT6VkudnKvW8oG3M0tr6n4uNYctah7ZU2QKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086529; c=relaxed/simple;
	bh=n+mbvvJEI8CH8TTkOdaxw00F0Fq88vljPQWMjBMIOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYDModa8583nukjUuisx2DXMgHJTJW1lo8pN0URggJuyyVgcR9bKn1IjtVvzMslGWOzmUde97vRST0J3uAlTRvGXE6rOXrCiuCrwfi3R8RIdsLStLf2beTXny/p9Rg6NwJxgfmCJ3RzazIrsJqGo0QGydXLHPvBkRqqj2xYsZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ha9ll89V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ha9ll89V"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHHhN33953246;
	Sun, 26 Jul 2026 17:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gW7VP8CspOGU+wF0/
	N72fT1Tle3KtK4wWLpeUE28hPo=; b=Ha9ll89VrVlpNXMrEGQPomKfcN5zIsmwr
	AqxZUa2tJ0sVHIvdPSTgsHem+ZniS/odj1wOMJAv3a8KOBYYOAhCOXFybwsWZ9NU
	+XXMr3pp8IWX9WTncHCt+ffC0K3umsalbJr78sPjshBPGie4jTvVzqX+VJ9FHPlc
	+SNxCU5v2EhGC2BmdcQ5A7yLL3x7dDXimuwU/aaudD4lc/O6wwtVj1kGjUU6dm/Q
	R2o4Zai6f9ZdsH3iG5miPYAp53HUPnRtzXZSzyMY5nRsbbTerj0iQUeVz80Cq8sz
	CT8yKmkOmZwUm/X8GG89UWZojpaVUh0YMhR8qbxG0NL90hbM6fv1w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nc351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBdgr007555;
	Sun, 26 Jul 2026 17:22:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvtb94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLuWD51446176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70F2200D5;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9962E200D4;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 83C43160F4E; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v6 03/10] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Sun, 26 Jul 2026 19:21:46 +0200
Message-ID: <20260726172153.1818056-4-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfXzo/a1X5KSXyT
 POI2Xgx80Nmn5aAb2wW3I87wlR2v/HCdyanjhNE4PDR5YoDhGhrwSn4M8IV4ZBtHWeDaZq/LSF1
 QCKFmh5iFoCiQzdtbnY//YJy5jdnUkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX9vmRXDKBlxLC
 GFfFcuXdY97AThfDocui5TseN6KRj8AVvPtryQ1PWBKQzsZrBuauWM8Sa86d/SKvlKA8LxNg0TD
 wAoqVwKh1U3ai0vj3yW6Niofkc6WWQXz+U+0T8FEEYtgYYj5K1HsHFUDfVCsU+bON90u0vqEklK
 Cpr76KMlLvBEvQvBMt3GWcopRiN6gwsKdUGO+gZFn/359i9ymCUWlzQGNu7jmJKF5ODmuIlaEx0
 opYCMGW+21XyY7h7HBLLtFj0BZbI3q3IaVKGlMI7+BDDbm6dIZyukWoQTmaKlBaq1yBdBLbYkcS
 p4f/hjVTBLykeNX/0wa2Iu8WO33OLZBSjXuB3iV4c2mZ1K2YDTk8kkpYvkYzNzlCePCjAc4L/8p
 aMPvJ/X+YveS5onOTD3fpyrOXNVjWXs4ClYHnr++2myE13s65v7PYCEe/z0fy8dUIFQrR24tbmB
 QQPYyR6hylxGeaBRkvg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a664239 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A5C3NnK3Tz1osX5E1PIA:9
X-Proofpoint-GUID: YLj4OSSmTRXcyocft-_xQVAljM72ZGio
X-Proofpoint-ORIG-GUID: YLj4OSSmTRXcyocft-_xQVAljM72ZGio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260175

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

