Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883EA49E134;
	Wed,  7 Oct 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373358; cv=none; b=mv+ecxq5N6+a5tnXAtAOI6ezCd4nGJnztjDQ5zWj7J8k4N7eFcmm8jtA3aujMmUELMK6UC4o+7CFdP8X2eV2Cd9XsWOVqxUKY3uH3/JqimwIjzXe1eH5471vDxnfBz4quuq0Em0gsJBnzvdfViJJBZOfUZtT31S8POAAK3khTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373358; c=relaxed/simple;
	bh=5JMBWkngR8qOar1RwMpXsbEPhBrWW75aVI4mHwd28DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svF6cNA4w/AASpK9mmrIelhsfExJOH/2zCKcWkX2nxqK5ZW+r9yWzYr+kdP/5hkhq1Va0RM+jFpK0PsxL4hikY+/r5OI9CdH9OT05PzCxvni4Wxosyqeimekp+AyZKiwx9SjJW51aixzYpD/X4MXmg7qYV4ZFfRvMUjk7aFG8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pa08uGVV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pa08uGVV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZScl2463039;
	Wed, 7 Oct 2026 11:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=utiFsN1G7ZKnL1J/V
	Az4Xwn+3Jw/a7oG34qw4D3r6aQ=; b=Pa08uGVV9QuJSvxXwr0AvlzsCcv8ZRX/E
	qR333Xewl/dRFBVAu7a3/117cFbSPjReCeHhWxLh3JdLBso4LFRFad7mC+cCfnnw
	e02V/tTjCzZRJG2MEGOAB2gr4p0anJVSsmoXc3IsWNj7Fteuog/v1JYuwXe1KL3w
	363GacB+rLYtjBfIDo0NVUafJxNi+4P49wExecJodC/t2/HtHmRWZRJ8LCoauz/w
	rgTgACLl/JFmWn/gx/seiTjpKrXgw7K4ACsKb3Qw3c9Oj+V1IULh04QJYJXsCNip
	r5Z/9gV9TsLm0Mwxpehtix4E8vLZHPTBkybhrMgYn3QzUrqyHmPMw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74w8c2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BX7nn1852610;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgxaue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Bfx796619448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F26992004D;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A659920049;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8213B16096B; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v8 04/15] mm: convert PTE table entries in ptep_get()
Date: Wed,  7 Oct 2026 13:41:47 +0200
Message-ID: <edaee657070484a21e96f315c374ccc4d8922936.1791365932.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pyMhgOO0v4VOCAydqbCm361HgIudXaK4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX746I6PsUZf6m
 2KOHP1izwyd3Twp1WG5Gdqp9uWUpoxNGb9pNRaGXndxQN1kl11mP+OT06Xx+ZKhiJLN+jRYi/it
 EqpFmj+o8oGofctWkdhHka8gpsx+XpQ=
X-Proofpoint-GUID: DPZO_1nAXLrxW5zj_E8Vg6VFQ0Zlpp4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+VVGuGhQD3aI
 kECgZ0qTFliNsk7gq2E3XP+in4f+/4fs6hwB2TLkjYo3t813wgwjW+G5jlRb0uLr/vsunCg+W0k
 h7VIW85e10pokcOICbP0ffr+fIrAbyzWBiAkaEeArpEODJgfrYajMps2ete9qvdD2uGBiBTrGcu
 hABd/wFU3rMlIxKXYMBQeJH0+1n4zqLuRA8ZOvedxXtXBLyVNu5flMqQgAXZaBJjda2EbYANQL9
 2Ub1tMqsUxMeYnX1cEkDROM577lmvqO6vdrM1vJp3nJDO2hrCKD8rKDeU5YQbyA3w6OhTLBIdWF
 d34AwHydekZaDoKi55fTpHbhft65m6M6TFrzLiVs539Vy1UprXOeGedgRBHB7D417NqLbxw3Ehu
 WvG4mCcG1g8UwIqkp+GhXcLuyO3nLQlfZlyfqSQb5OR30MFjcmZjKJotvCcn+n2eaUntwW81s3+
 3EmmoBrjn76SguQw5Aw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7CQSdrXTAAAA:8 a=2R5SyWd6415lt-ZHj5AA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
definitions. Read the hw_pte_t table element atomically before converting
it to pte_t.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/pgtable.h       | 2 +-
 include/linux/pgtable_types.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index dad80d264aac..1768421755a9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_are=
a_struct *vma,
 #ifndef ptep_get
 static inline pte_t ptep_get(hw_pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	return __pte_from_hw(READ_ONCE(*ptep));
 }
 #endif
=20
diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.=
h
index 07da05d375c2..d6c5a7548550 100644
--- a/include/linux/pgtable_types.h
+++ b/include/linux/pgtable_types.h
@@ -8,8 +8,10 @@
=20
 #ifdef CONFIG_ARCH_HAS_HW_PTE_T
 typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
+#define __pte_from_hw(pte)	((pte).__pte)
 #else
 #define hw_pte_t pte_t
+#define __pte_from_hw(pte)	(pte)
 #endif
=20
 #endif /* !__ASSEMBLY__ */
--=20
2.53.0

