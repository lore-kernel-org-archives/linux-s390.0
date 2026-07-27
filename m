Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D73CF209;
	Mon, 27 Jul 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180164; cv=none; b=sp3qrKHlLcT2c5fgl69FUAgv+cj4oe6VZvI/LdrLY/ZOwRDpQDZgYlP8/9MMkgkck3BvVwxZ9+sp6JqV0j9ZpBWY9S0ERKV2kNrme1sByFzMru6XfQOzUH+2gYYEZHWGZ/6BPlhRcf+xugqDGfK7K5LYlxIASzavDaJ2HrhQJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180164; c=relaxed/simple;
	bh=n+mbvvJEI8CH8TTkOdaxw00F0Fq88vljPQWMjBMIOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuPSF1+fQM9GBPsZGvust/2oQ/qrNxT6Up0Uq2Jc3RqbPtQmpCDhR5i4IvAxcY04HcjMmQIvjl/cB582vrMbHOTXJ4gvT67D29FjwzMMKpPV8TuvoIW+T1ggYnPDmo9WRtMcfz8qbM60TDP9KNtMDlv4zWKkMewgyFkuWtQ8CbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b2IiABCk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b2IiABCk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RII6Ai1096326;
	Mon, 27 Jul 2026 19:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gW7VP8CspOGU+wF0/
	N72fT1Tle3KtK4wWLpeUE28hPo=; b=b2IiABCkVnHDcqkM0IDibOzAi/Ib6Jn94
	HjZ2x6J3kxQZyyGwPMKjgqlGgOVG30pCBoTKTVFwDNva1wFlOyY4IdwC5D7l1yUa
	Xhet32tCYtirKiAKYsP6NvPiOYTGF7cEt8UYtxYx2X/NlQRwrnzMTF4O7rcvyUsf
	08oEfsTNbTtJB55HCOMAIeAJokQqVnImZ0yXExO9MElJ3LnPctObUxewvJFknVst
	Xj+YCM1+Qdq3GIF0bFEBfJHlD0aKLwCjdZOsO0OMuvaCWkhSO4nKIclfPP6F/tPX
	WBMS6M2JAop2ETzB9c82WnJvMiGl08lYuphX/1G6oWzJrDTu3Lcug==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc9prj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RJBGgA022947;
	Mon, 27 Jul 2026 19:22:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq6vdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RJMbQn26608116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 19:22:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03AB4200A0;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B6C2009F;
	Mon, 27 Jul 2026 19:22:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 27 Jul 2026 19:22:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id BAB03162820; Mon, 27 Jul 2026 21:22:36 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v7 03/10] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Mon, 27 Jul 2026 21:22:23 +0200
Message-ID: <20260727192230.2715207-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727192230.2715207-1-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bfwa-sOSmhRRti7nen4pwhrjePzU5cHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfXzCAGp7zi2f11
 VpSgkEyGWrFTWwNZeEDds9s3LOE3+AEtk4mytno3HZE9k2/5aLx4SjH9h35c+55txhXcf8n0MyI
 Fw/OpaT5QilWgAY+dK1yEYP+4YkLZ8F7+R6PG+9GAbqul1U8uxeiY9QKW20tn7JLV5rjuwmKB+t
 cFRTdUp1I/oBQcAyD7UKRSj9V7BilXLN90Dt9oAvRo46RUlY+hx7GISpB29AnnAfPPscbf6YRn0
 KfbUtUaqqk4hXF+LPCKQYGE5oT4cRNeB/5/jl7LH6PbhwgcdljkMVrC37DSAO963uKR0eHq6m3v
 fGc8FyNvilvKXOz4a+EOEpQOSE1RhG7fyQJPBoSGUoJf4tDLaLjwo97ZsjKNIKB0pTNKmlyKbQW
 t2tzXMxQLSvC1tAEwscQVAKz80a5obbuyxdlUGZ4K9HQEw3V38Mn8j6TTLV+bfShHdZxZM+Q+/U
 ryRllyHq7BNeOdToRLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfX36qbsxThKbHS
 wyBh1fQqW6xoHP6ElDzZPMLpD+O1vFB0+g4zN6PSLX+rhZmrdS2r7MiWUU8KkfwzrVu4annjpyZ
 EmudoZbnAXLppcfis5/dd4AMeY6dQh0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a67b001 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A5C3NnK3Tz1osX5E1PIA:9
X-Proofpoint-GUID: Bfwa-sOSmhRRti7nen4pwhrjePzU5cHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270177

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

