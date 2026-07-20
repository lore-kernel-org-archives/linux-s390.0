Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31653B27D9;
	Mon, 20 Jul 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558866; cv=none; b=aEix6Kfjbf0vUfpMr9DUVZ87++xC35Uw8qbM45RdF90FR5fVE3SqF9+1Eioz0O3kPT7pNMGF8aedcu9qct5fQB1koXEIrXTMjcPP1XbAyb+yoYtx7X7A2AAaC1fRVZZwz6nH5/V7rBfULq0tiAyUPL+WceTKRSxv8m2lncWZ4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558866; c=relaxed/simple;
	bh=3TUlDCN/rE9aLdIjJXSQbyMn4dQ2PNMj43gw9zcquqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmVhO4g906SF0PFXYxD0dbL/T6Z3TEb//ChzHwvzk+DAVm2XGaj3z/RQqVD7Ebikb17QUpqL8y4RrGFNAgIVvIFMPV6r27w7GsnI9Z3NQcd7UQfc8XgFhGyHScH0OPikPtiX0IGIB0amXxqPfSYIq5ufexsS//jFnElQLFnefdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RLQb8LxE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RLQb8LxE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KEC4Sj540477;
	Mon, 20 Jul 2026 14:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7Bey+fSuNzeHVoBw9TOF2GKwgVd5Ra1y3IUsF2SeS
	PY=; b=RLQb8LxEkN14anNX0ShBGxfFfSvEG/4SXIa/n/b1O1A7pxAS0bNuo5R7K
	Z5RYsDseiQZdlSPxeOqucFlQgaULXVA95FQUSUTOIojmYob7d3ZuQzgRd/5dMyjx
	Ox32coLbAbSvdghH4549iZjDMhbWiqx8qIHrRFx0zF6TXjN9YT9yllbWlvmnKtwz
	Z6cXXZX80d4yze1u7XYuSJXwMXAAzn8wEXjhnjz68BwJ9hYH2EI/LKlTYKWo0rVT
	vPO19PD1Qwp0ErNU1aE+lDsapRAZvmonfU9PMIuk2Cz65LY5WwCwgbuZLCMacdxN
	HpcZAfkA0LTNE+r64i84X1tit8uJg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a81bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 14:47:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KEYbbX020319;
	Mon, 20 Jul 2026 14:47:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagx08b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 14:47:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KElY4f52625734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 14:47:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF792004B;
	Mon, 20 Jul 2026 14:47:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E75E20040;
	Mon, 20 Jul 2026 14:47:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 14:47:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 132C5162734; Mon, 20 Jul 2026 16:47:34 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/maccess: use proper PTE accessors for copying old memory
Date: Mon, 20 Jul 2026 16:47:34 +0200
Message-ID: <20260720144734.1003497-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xLkk_rB6UYMFLFHL-PBc6JekVQ4gSehT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MyBTYWx0ZWRfX+h96QXLDFNq/
 ZPwBUEk/NZ14JI4B3AUR0wcayat7KMl5MRRynTJnZxiZM1l2V7HAOXllAH8rXgxeSQs5OCOOYgh
 DOEYlZU+M4MOe8ERswgngHo8XAQ9mxE=
X-Proofpoint-GUID: xLkk_rB6UYMFLFHL-PBc6JekVQ4gSehT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MyBTYWx0ZWRfX+jKyVYOY6xO9
 YX3WlcAcZ21mjP1VMNsNvHXD4aZAI9nXlWgL2HfDyGaq5P5vOA0dIAn6K3zpW7BPR9JYaAGX/LI
 tOP3vwuQXPfJg2A2UYmkB0gcUXDfzCCK7RUFX/gzmzf2ArdUooIUE9UfkuY0O5ORFbom8EukPR8
 EVhQo8vuaoTe6glS8SeRePGnTggI57DHIi+IwyJ5zFNz4c6Wm7ZbZ7jldGy+tNQ2+fExic441Yf
 5oBp07ZAZsHj7bsqYlh1q24zk/hCmC/HtZCuy1cyZsHOMVooETU/Cb6nPwHxuJlaKFDUP6Yof4O
 N0z7FEw+4CVcUOCatJm8I7zlS0cWXcxrYmwk++2q5OqLgdsePtIfoXQ7vmuD9SICCBn0ik3Oa6i
 xsbkivm6PfZ/Lnts9mKsSgNVcMipkKVy6iNfTtFPxZsWR1yR/RMMaQA0AweGrQowQUgxRjUq0bq
 Gi6SQ+tFVIt4OzwxgVQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e350b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6hP3MQ6zKI-DUMVT6IoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200163

Follow the pattern established by commit c33c794828f2 ("mm:
ptep_get() conversion") and use proper PTE accessors instead
of a direct pointer dereference in memcpy_real_iter().

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/maccess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index cfd219fe495c..f39968dd8063 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -96,7 +96,7 @@ size_t memcpy_real_iter(struct iov_iter *iter, unsigned=
 long src, size_t count)
 		pte =3D mk_pte_phys(phys, PAGE_KERNEL_RO);
=20
 		mutex_lock(&memcpy_real_mutex);
-		if (pte_val(pte) !=3D pte_val(*memcpy_real_ptep)) {
+		if (pte_val(pte) !=3D pte_val(ptep_get(memcpy_real_ptep))) {
 			__ptep_ipte(__memcpy_real_area, memcpy_real_ptep, 0, 0, IPTE_GLOBAL);
 			set_pte(memcpy_real_ptep, pte);
 		}
--=20
2.53.0

