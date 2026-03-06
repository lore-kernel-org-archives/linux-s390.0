Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138503F074E;
	Fri,  6 Mar 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813830; cv=none; b=q/47b6SsedTtf1arz1/ckGLb1QPk/ge6ypttn7c+oOUZAGdTNq3i20YGdZdwS8eHFKBej8rGca7+LTtcAxcpyAg27pwu9FrxIYv/ghRBZtoESWQuFcxqw/a58AyH+5ZU+Fe8alVGAIhRRc0vmQ72R8jcGElgD799u6tVHGkMXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813830; c=relaxed/simple;
	bh=g5yoWAeI6B+Hq6uFpd5VYzuzbkHx364OrxTfRWx0d1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkXT1k8TCvEqxIeMZeQRfnjUy+7BXA14Y59EINn9jzfVBpd3tLypypejsMPtFRdGotjKdQThIDjT3Ua9MZg52IPSC18ai0PXcshe/VB1QZzzUAF5DCJy7Uruq6UraI19oj/ZANv/h7oUtwGTbGcF+2xrFj6i/55OKBmBkkJFV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lm5JKiuQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lm5JKiuQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6269G17K1965535;
	Fri, 6 Mar 2026 16:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dtoi6WxsFBpQPnnI4
	jiQWys6zQsSpfXOxB+meQZaJfo=; b=lm5JKiuQRboh8NPEoa3HrlDaGlOELi+eH
	9+Uvph+D6qPDcdUEwdE2ADbINDvXTdM008wSy4JfujZPtygbO8bTPFiw6h4TbMOl
	tc3feKlFUuCLbZ/dYogG11t+99aonAk7p2zRlXQNEay6sMex2Gy17u0UZz1YgOJi
	QbSemDDQY5yCpd6gbge2aAiN/KMZsSK5GcymchWZ1bcmO+c5KLv3NozUUvkeaWRj
	60cMMxmkY6zFB/LX0tCBY3FmtzPgB/4grL2ww5AShrOs9Ow4BtO6vYsKiOyQ8awB
	/ArqGnsvZ/jt67qI0cXHdJgFdaCfGh8Q2IpEfEd47M8dGSLSm44Nw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk48udg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:16:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626CPjMo003210;
	Fri, 6 Mar 2026 16:16:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2ygp11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:16:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626GGXFg31195482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 16:16:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ADEC2004B;
	Fri,  6 Mar 2026 16:16:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 347D820043;
	Fri,  6 Mar 2026 16:16:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  6 Mar 2026 16:16:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 19938E078A; Fri, 06 Mar 2026 17:16:33 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: [PATCH v2 2/4] s390/pgtable: Use set_pmd_bit() to invalidate PMD entry
Date: Fri,  6 Mar 2026 17:16:31 +0100
Message-ID: <a9248694a38cc898d3f0628f59b8abb57d56a416.1772812343.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772812343.git.agordeev@linux.ibm.com>
References: <cover.1772812343.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IBq9j_EnUwKftO-EgMlfxi2jZe0HPHem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1MyBTYWx0ZWRfX9vUxORZnUkRh
 6GHxzk5WJbK1mY14Wo9QYa72IqTa1p8g+klas9euEzt2CV0T1C6SPO8kHQ7btajT0vaaAjFoNu1
 CIIzg3yiaOASW74bzhZM0ni6NEgs7332rHmxMfpxt4x+ow1ac8OZNzdm1ysUZ2dfaXOmGjck+A5
 6Dvk3YAo2/+1fmh59BJxr7Rpnil7e1Ot2yqnueAf256Yx7hgZwZEpfEW0GlntPo/MQxbqlkJOrZ
 yo+DeWhJBIbR14xgcyYvRlINetk9UWU8nSRouQVpOIopnAhXw8Yx/EKbEmjTr4UcLzFpz3iVM10
 3kjhOeMAJx4Xq8amjnZMNtOHgKyoO4BzLBjNwOueS5jNjqK4MF7pZr0abZgqWWexUogoYQ7y6z4
 ke8W49kGfdueKR/x+OgsyIBN4h4KVuvJGjFyX3tRCeQssNjJikLj+Zrmf7KPScWqwRrT0uFFdBe
 ME8EUmGDwbmNfjzVwkw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69aafde6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Wwf5FGOAHR2iKIFYnxsA:9
X-Proofpoint-GUID: IBq9j_EnUwKftO-EgMlfxi2jZe0HPHem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060153

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

