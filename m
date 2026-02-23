Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A77364E92;
	Mon, 23 Feb 2026 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847609; cv=none; b=A52h5s78GateN6Jk4yIwD5zyGO/YquHcZts0IEGtKqT6ZJI64lJ9O8rzq0gK0xBZBO72M9/P6JiNRTgcURtxkHGFhh4wiokm/46cOrn2sGyS1eYKJdXoFrgf28Tr+/7Zct7ct/DWggFyLM8vQnQj3wE9TljXbDd4fDRTS1jfr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847609; c=relaxed/simple;
	bh=g5yoWAeI6B+Hq6uFpd5VYzuzbkHx364OrxTfRWx0d1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nte+mVqXlX1LdlM3brlmSzWfVcmPZ7b6RbFDfWIhz6UBKbYFE7/OZ+T4i8cSP1+kbvFFwT1Mf4XrbuANwc9Qljr7kfK9E7lZS4TlSN8xhB316/NnEHOf/PpWzfFfO2YlP8bQ3FX/d4HN94P3sAqV6kXvkT6aWWKSXGIEAiqwq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dS5a3926; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dS5a3926"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNOPnj2839813;
	Mon, 23 Feb 2026 11:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dtoi6WxsFBpQPnnI4
	jiQWys6zQsSpfXOxB+meQZaJfo=; b=dS5a3926tb9lFIYlZu7aBI9Qi2p57+YQx
	cHOPx5fda1/ncnccroIcqr6PO69D4AOEYWon5rcAImhACMbF82MEJhAnZy7TjMK3
	V48oK90FvOa+qsFPpp3HSes4HsKirC9S9w0IxS9cEPz4WaDS6gS8QBDzkRaNrkQC
	XYKAXDPMCO6s7sAF3ma/2gqOmpTY+IOdXzuZzLyEFoMaqcoJN+z3nB7VXhT5xxg0
	PDx42R8TccAsP+8OU8/6NbziAP2T1rmrDOD9Db6qHMxyuR7D6b19JnVce0oY6V9y
	zK7TGZhD5UB90I/kYc6fI80tpdUjZX9C+ftipJMztSo0CAheyupuQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brpee5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NA31Ce013419;
	Mon, 23 Feb 2026 11:53:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdxvnsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NBrGJ030605940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:53:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A1F72004E;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62E3E20040;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 42E52E0B66; Mon, 23 Feb 2026 12:53:16 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: [PATCH 2/4] s390/pgtable: Use set_pmd_bit() to invalidate PMD entry
Date: Mon, 23 Feb 2026 12:53:14 +0100
Message-ID: <0aa1229418fc85cd89975e61abeef421a22097be.1771845678.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1771845678.git.agordeev@linux.ibm.com>
References: <cover.1771845678.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DJdugSA8pf3un2SMyjkFtn6m3EEbpSPF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OSBTYWx0ZWRfX6VlxABNsYuyo
 LpLWehqxZkWz5ST1QDK3NffVHaXaHbm+YEYrYwryvg7KgVpJC6YezjMMvh+eCuwZIChQT/DP4vT
 fOoVRBE5VEFHKHFbPE9TrYA1LADNsa3rk4tRjSfBYOFoI+8gq6CQi4ty4EC6SSoF1uu5syUdEN8
 y//Ke2RE6sWfyqcwh9YxUEOl0XkjM5/mVl4eWOAX5+tmMKLYmLrf0HpevD9H9T3AuSEfyk3GxBN
 MomQpkKawTBty5ZeI8IJfxUQYWrjExbzkEM6qhtXopgPbvZFG4uSHURQOCP6zCbaUQ/9g/9tt1v
 34scLjD6Qfpet0dGGIqQD4Gz9Psn+7OGQtHe8MScQTRJozUEYGa2nFUND2Znc583gFKazYB0ERy
 0IwtNIwteKE6KT3AliSVXOdpwf1s3JZr+x/GFrZM76vHHeioprzpM071IlHOGVgrRvu1H5pW4tB
 GRuOAvoIXJ87IS0Ab8A==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699c3faf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Wwf5FGOAHR2iKIFYnxsA:9
X-Proofpoint-GUID: DJdugSA8pf3un2SMyjkFtn6m3EEbpSPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230099

Commit 3a5a8d343e1c ("mm: fix race between __split_huge_pmd_locked()
and GUP-fast") failed to follow the convention and used direct PMD
entry modification instead of set_pmd_bit().

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index 1c3c3be93be9..04ec9fee6498 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1744,10 +1744,10 @@ static inline pmd_t pmdp_huge_clear_flush(struct =
vm_area_struct *vma,
 static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmdp)
 {
-	pmd_t pmd;
+	pmd_t pmd =3D *pmdp;
=20
-	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
-	pmd =3D __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
+	VM_WARN_ON_ONCE(!pmd_present(pmd));
+	pmd =3D set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_INVALID));
 	return pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
 }
=20
--=20
2.51.0

