Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B003ED5DB;
	Tue,  2 Jun 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410249; cv=none; b=tgSK5rWcu4j2S2Tv3zb5OXl2790Pos3QZrTtcTpsIGiWtUOf7J1e5W+EOUACEdKTij4UMugzyyLlRiYPk4ugty3qrj27znnEmwzTyj8k+xety7Mo9hkEsaP+Mjpo7DQzy3VM3BrJvTyakKlcFQVfhLealnIB2lqJTSjOzoEJe8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410249; c=relaxed/simple;
	bh=rxEq+p7FKrkLf08DNMOVsPgtR8katGipcUDE50aUb6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6NPnlUrKiAPA8g1s9pRN7A1DcXajbWzCKgqJcjtnduRBS5ssBtptld7uY4eLFjPNcOPJCk2reZftLn8qjB8yMI53r4PGBQ5SVRNz8OIyd712cquOejg7O8MKYKrQCYWWlXqxdrI18+6eapZkg+A2fNfYQdbldfk/DhISK6tmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r6b5Y1sV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r6b5Y1sV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6524o71M1956882;
	Tue, 2 Jun 2026 14:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f/WU64V7khT8NQeX/
	zbiYQ9Mor4o7IeReycbOeZvsm0=; b=r6b5Y1sVHTfnORDui5UhhMJj29eBR9g9c
	NAjOqjERI4uvKQ8MPdSno3Ax71ysWdFecNozZJ9zJUN5d1hTT7zYz+A0G71IrtN6
	wA0lmT5m3WbInTaDRRSmQBBrFwhr4U5h2thUib4APeccsDDB3pWlW5gvKfUXKzXY
	tciklmk/uYnlrIaLI2hT5UyaBBznuIG2kJF9rwBwt6xZpy88lPyhTkm3l3fx7AGp
	7Po5RutbTwaCVjILZPJLpT/niun2FLs8fW6P7K8khfKpD+ZJKC5b7thB5RvPGbt0
	uHAHvxRBmwG9PqDKgsTDvnX1l/ROFHO23ljMmlsTJSxNBETdGVtlg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahp4gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652DOIWw007350;
	Tue, 2 Jun 2026 14:24:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k3mpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENvPT47776024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D77A820040;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC6002004B;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 05/10] KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
Date: Tue,  2 Jun 2026 16:23:51 +0200
Message-ID: <20260602142356.169458-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602142356.169458-1-imbrenda@linux.ibm.com>
References: <20260602142356.169458-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfX40vZu1iuwCEv
 MmQ7Pi5fwX6hhJeSLL7JJYfXUs+I/7i/hrdR+tDboPREEsLybvU+NtJJsacNhYRrF3KIP6yIkEb
 cjFyaVSnW+u5VVfawzw1ChNWGPHNTkeDTiAyGWkKGyBtTlrHDFd0OhlYrLpRujNW362CKQ5E80n
 Xu77drxQOkolZTY3ZRhuS7UfX8ozxdlFOBmhGwUVcb++fDMnC4NkwkBbf8bcSPFYmxy4m5terMG
 3RQjT/zEejYLaJMeo5HTiDabwKAgVjpneU5CzPGDrn1dqewGHbayNnY/RIqHYPwJJPeeI2IMxnq
 FxzOjeEXRobMOTrVKe/0VcuhFuU/Fx10SJ+adxHgHJ32SFfQ3H9g4s6AoCf0HGKCebR1hP9WA/R
 sl4nu7wQV+5WioTwlctQgW5aocPflPMEDZAXaNqYSzTgpdcHrI/gcfhleFdfphm0oVbh8QhYMaP
 8bGKVSH1YY/uDoXVQIw==
X-Proofpoint-ORIG-GUID: vzR4yEZjC9kAnVCHbdkvJx2WIbKnShHi
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ee784 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=sChW5zZnIGAfqb-v-YwA:9
X-Proofpoint-GUID: vzR4yEZjC9kAnVCHbdkvJx2WIbKnShHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136

Fix _do_shadow_crste() to also apply a mask on the reverse address, to
prevent spurious entries from being created, like already done in
gmap_protect_rmap().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4f8d5592c9a9..20e28b183c1a 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1466,15 +1466,17 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 			    struct guest_fault *f, bool p)
 {
 	union crste newcrste, oldcrste;
-	gfn_t gfn;
+	unsigned long mask;
+	gfn_t r_gfn;
 	int rc;
 
 	lockdep_assert_held(&sg->kvm->mmu_lock);
 	lockdep_assert_held(&sg->parent->children_lock);
 
-	gfn = f->gfn & (is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK);
+	mask = is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK;
+	r_gfn = gpa_to_gfn(raddr) & mask;
 	scoped_guard(spinlock, &sg->host_to_rmap_lock)
-		rc = gmap_insert_rmap(sg, gfn, gpa_to_gfn(raddr), host->h.tt);
+		rc = gmap_insert_rmap(sg, f->gfn & mask, r_gfn, host->h.tt);
 	if (rc)
 		return rc;
 
@@ -1497,8 +1499,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		return -EAGAIN;
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
-	gfn = gpa_to_gfn(raddr);
-	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, gfn, sg->asce))
+	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, r_gfn, sg->asce))
 		;
 	return 0;
 }
-- 
2.54.0

