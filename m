Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0242DA29;
	Tue, 14 Jul 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071339; cv=none; b=qmuigXfEInOIDOAz5rrl1vZVA6P52mwinKaJ4oxU+nkN9R+2/+nDyVui3WIsCKFkgal9mEEiJBnde5t30PnZynXJc30I85oRArvahn8I3K6Qd+F4kunNBL+pzy/5RrraACNx8edaX0nPEDuViIewkKx6mrGWi1NAR0i/lbnFeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071339; c=relaxed/simple;
	bh=n0LzOgDMKKopcnoAa2Witr0UJS29Rj+2RrqDEKY2eIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4cbucXoIhaOr2v2VHVYldAl0cSoifhWU49hmcwkkgu+cD2YLFVDUe3d7e2/TVxlBSexUrPOncRoZ0z+8utJkFbAfvoXNA0kDh5+pcETISW/55651+0nIm/0tocPGgP3zPZE4WVjh+GOMSG3JTV8XgFfb2W2PTavct9PZ87XdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pSFYx1HA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pSFYx1HA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EJBmpx2116371;
	Tue, 14 Jul 2026 23:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xrfGuHNduIxh00NuU
	+zcXAaLn9SOXoYXyRh+TxevBu0=; b=pSFYx1HAi7J6myw+pEPuEaPfmatfqPbJx
	OaGVGOva1WQ7Ksj5nnBSrPmR+uPFp7bAt+YjrE8CSt/iV+ZChn/WwIqV/Nu2WyYA
	00zRA5GFZyxJ9+qnjoTii4lDeFpU/A+cnhkwy2AQiD3zb/oExVXAy2ZJ43U14Qin
	HNTCUiTVNRrx0dgLlSM4XeYRJGyMIyuSXLKVSQ8Ku4pCy8igIj1K16NNZU864duJ
	86T8EhhlrGjoroEqlXi+NctBWN8O9JX9Je4/duKqJp0x7gQAre59Lj49l2OaQNhQ
	XExjAHU8A1ydyU7YKJmH8DVauqnR0dLtqrNty//fl9KCGByQXQNkA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a86dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ENJg5F000379;
	Tue, 14 Jul 2026 23:22:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhd3nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ENMCYG21889312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 23:22:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ED5120049;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FE9420040;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 1E6BD16260D; Wed, 15 Jul 2026 01:22:12 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v1 1/6] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Wed, 15 Jul 2026 01:22:03 +0200
Message-ID: <20260714232208.1683788-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714232208.1683788-1-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX9fR7JOnIjWFc
 57O2WLU1tiLmG/PmmeKzf0csH8aKBQcG1cNL5vOZ4OrBP4pkGlSKB79BWgDRGZpdGtS7zKm2C8J
 ObGMw6dqbKPyv7Q9T+lFjXO7iu1pBW8=
X-Proofpoint-GUID: gEChmZ9XFlrYps8-XIgC-kkpwze5kw5b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX5pVNQ202t3x8
 tFGz1ciPrDQ3a126yJeLVCgUHau6XAnoZRQ9naGKEqN+p9ufBu4Hr22Ph0EfJl5548c0zdiC86K
 pXFkezGBSJEhGqVIjVpMzs/xtI+S0b0vciUPyV+jYfzZxHBZzPFg1MoQQ8ISZRviTz8n7lBx+q1
 bK1lvdhZRFsQDHlFpbWYxyU6KcoqCqzV6vRMYv9FhYpwa/eFjg/My0eTGIV47JSh/Wn+aHeoy0O
 oLuq/WNZz7hPo5N3cifQOR1FXobkmPBQaSLv17gVdwUZnV6cR+HMnAmSQL3g/IgiMFpgqckaEdO
 h4/sKoayHbwLBoxJT/LI+vdCOD8LOsRGgiRw0xcGq3HdL6AMSJi4J6zWuC+tXNv786z0mJvUFTJ
 brQXH8TjLfwLsdZl5vMZ2X4Vq/41YNpDqfzdD29YaKaKWrfjQePFPrbeB8fsJVmDrvmwPojZwvo
 M4ZSxpb2sj+OtHe7Xsg==
X-Proofpoint-ORIG-GUID: gEChmZ9XFlrYps8-XIgC-kkpwze5kw5b
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a56c4a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ztfy0_AA8xUuwmIluScA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140240

The routine ccwchain_calc_length() counts the number of channel
command words (CCWs) that are chained together in a single channel
program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.

The loop itself is "do..while (count < 257)", and while the logic in
is_cpa_within_range() correctly adjusts between the 0-index array of
CCWs and the count of CCWs starting at 1, this means it would look
at a possible 257th CCW before ending the loop and (correctly)
returning an error.

Fix this by limiting the loop to 256 CCWs such that only indexes 0-255
are examined.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 7561aa7d3e01..80c3d87f5482 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -393,9 +393,9 @@ static int ccwchain_calc_length(u64 iova, struct chan=
nel_program *cp)
 			break;
=20
 		ccw++;
-	} while (cnt < CCWCHAIN_LEN_MAX + 1);
+	} while (cnt < CCWCHAIN_LEN_MAX);
=20
-	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
+	if (cnt >=3D CCWCHAIN_LEN_MAX)
 		cnt =3D -EINVAL;
=20
 	return cnt;
--=20
2.53.0

