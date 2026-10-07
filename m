Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0D48EC9D;
	Wed,  7 Oct 2026 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373364; cv=none; b=tm6pz8CSrFnT/xxmTOrPHz45KYbrV/CPvhM4vgY/pb3WUm8kU6v8U1f1cx6cqA9iw2omX9Io0d0SlkiEYiD3uqdLhTFp8VrBVz6KmHeXnp61jUiEwVup7xV5fKDOE8nhDBgL1A9huCvAqWqj7yce3uBOs1cacUmz1AOGKbn6XuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373364; c=relaxed/simple;
	bh=qvMUlpfSNzbmXbMrubQk9VFayp5qcNaghgkORQd3CTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTvds91YgxXYb0XTVZ56OMkB4V2DaG1IFJNMD2oWv9Tw+LyxsJNWgKB/S9MoLCsEg75389jH1KWxz3SkpvEe+h13b2oLBdGKd+3YJU+5bgaRjsM8jToCesmBjMXFFw6mWhSuQHuXzcUBP4gFFpCiaVcAly3cbpcfDvOHZLW9dd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VSJA+KEJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VSJA+KEJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZM2L2462974;
	Wed, 7 Oct 2026 11:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BCSxOsbf6mTGc3Suo
	571XSJ3055Q+qHtEMLZCspKi1U=; b=VSJA+KEJTI5St1ezey7W1kocMIuF3ot3N
	IVIUG7Ql3kubS++O3fWDgRDYSI3Nc3IgDjFaW6k3JP/7FHf9r8J84xerEC4Mp4DU
	3E5CLyzA7Q1W4xmf23I0uobW0SYwufdTbK7oeHSZyG5dwHC9TDEOuLyEnd6QvfO+
	ItvO9gTbX+bzLv/yfdsgPdRmbkCdsL/tOsBM8JBnjAdnXjC68poqSxOCcpup9ylI
	fNAJ63PsGfunK1q5mLJbba2ImxV6f0nAZ31/ildo+BRzXEhE0/xIIfeasXqH/V8u
	z9+EpxPoTZoPisrE9jQTOC9ESmj02jbzkk5usEiSVQTYGr+fnPlgw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74w8c3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWgPB567482;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tsb5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Bfxvo19595962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D12C2004B;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A4202004E;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8DF56160A46; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 10/15] s390/mm: Cleanup pXXp_flush_lazy() routines
Date: Wed,  7 Oct 2026 13:41:53 +0200
Message-ID: <964adeedfd20d4dbcc9a6341f57ec7aaac6c6adc.1791365932.git.agordeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -rbscqX-jlGyEG1AjE7JMIlN7cz_bdzY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXyf4C5x7d7mrL
 bQiLAzVu04XuOI8WvL7nmG0N+YoIn5yGAb5tfzuZ0S0SElWCkCSIe/THZKu1FUKBatCJ6Sc0Div
 WkLEMz4aWC7tnp7bx05YHtTARMm/S1g=
X-Proofpoint-GUID: 7uuXtvi7iNGngb0u1UfDGoO-xLVZzrkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX52B+fyo9B4lN
 SM2fiicShdIOuyWmcSOKzZX5jWY1uQkPzXQ7FXWgKEZjCwsq144DsEoixzr4mBYl3ZxufAar/Lp
 ODC5K1FYtsocbx9flsyL6wTACVw4J9Yt3a6Wo4uiVd0mTUu977MG42Hv5n6xwNi7NfD3ILsExqA
 AUOV3WysEdy+YjDOFWmNtybc2e/x7YqtoYaJLl0t2GSfK5/PP7/0+m7DQnZB2u7p36Rn/jongr/
 rYwyrJ49reXkz0ZISy8iWXbVJNKk8NGeuCgA+UYX/5XkHUjfvyFXzrKlU3vPeTejnTWTr88LS2m
 sL65ipV1IldtB6w8HB8o2R4dlvP1cPCPd6J26+c5NI7vHqHEm0phCKkUPyv3gPWZ+3pPRkrBcwN
 gx0rZ9CN0VV0k0Yur8pyM4zxqrL5ZqoHZ0eTsBEjJyKhoTnNs+ZxsZ4mjrS9tfh9+/mJjWe6hHT
 33Ll/46Szzub02b1UyQ==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jYzbKW4fU5_uXXChEaUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

Avoid unnecessary pgtable entry read in ptep_flush_lazy() and
pmdp_flush_lazy() routines. Use the already obtained value of
a pgtable entry instead of dereferencing it again.

It might appear that the optimized out second dereferencing happens
under mm_context_t::flush_count lock and therefore a race condition
is possible. However, both routines write invalid entry bits to the
pgtable entries and therefore no reader is allowed to interpret the
rest of the value afterwards.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4acd8b140c4b..da076928b63b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -107,7 +107,7 @@ static inline pte_t ptep_flush_lazy(struct mm_struct =
*mm,
 	atomic_inc(&mm->context.flush_count);
 	if (cpumask_equal(&mm->context.cpu_attach_mask,
 			  cpumask_of(smp_processor_id()))) {
-		set_pte(ptep, set_pte_bit(*ptep, __pgprot(_PAGE_INVALID)));
+		set_pte(ptep, set_pte_bit(old, __pgprot(_PAGE_INVALID)));
 		mm->context.flush_mm =3D 1;
 	} else
 		ptep_ipte_global(mm, addr, ptep, nodat);
@@ -227,7 +227,7 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct =
*mm,
 	atomic_inc(&mm->context.flush_count);
 	if (cpumask_equal(&mm->context.cpu_attach_mask,
 			  cpumask_of(smp_processor_id()))) {
-		set_pmd(pmdp, set_pmd_bit(*pmdp, __pgprot(_SEGMENT_ENTRY_INVALID)));
+		set_pmd(pmdp, set_pmd_bit(old, __pgprot(_SEGMENT_ENTRY_INVALID)));
 		mm->context.flush_mm =3D 1;
 	} else {
 		pmdp_idte_global(mm, addr, pmdp);
--=20
2.53.0

