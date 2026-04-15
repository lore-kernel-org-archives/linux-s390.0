Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1293D904E;
	Wed, 15 Apr 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265309; cv=none; b=X1ab48zZx9HPh+VByVYFIfHXjhBynX6s+X9DHSbim1cOj/oPHmeGbOB0o0QwjKB71cJV6U26yyd9vGOXMXxGKA9+yz3+ClrpLYsMBFvKdA8vupMlDj0IWispHN7vYKfc03N1mzhikZUsSuW7z/XK//IUZg3sgWq/yU/7WAgWAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265309; c=relaxed/simple;
	bh=O8KqLUAexmqy8P7wryHinLDdgy8mSZhSqxenRvfmHOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIMyRbVAYwqJyYb+ot9yvkxG50O16ECgMSzIY602kEFuHHIqzNmq7BaBz4o6X+l9j9+1NCahYL/38Rk+5VqJvAxkk7cNb/piIRIz22/xTSmePqVw+yVBOUP4FfcwSVJ3ySgY/j3o1BkfErXQz1N6oPbKBo7idRGZGF380vroTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L18ep5zs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L18ep5zs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F5bDiH2030542;
	Wed, 15 Apr 2026 15:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kh5NIg
	+tCmgqxLw712whetL2DfIqpUdC//9g+2sX4n4=; b=L18ep5zsRU1smJtlyFqlcv
	xNtx5kAeRPqHhgeZJa4T5G8c7OTcJZiImxJsD66YkrM6ll0DtytPQSaTYiNEG0nH
	lDbpHcadoG8LpUjTb7uWE2y4ZAucc022YBkqFuJmKm4KZmcSWprxc09ouPrDnYDj
	gJmPthmYeU/yFlBlPTzxq6lKdKbJX+1I78gqYCNnsnIvbyLwzu/WNrcPzTS7ldKd
	sdB2mxt4mGgjORK6d5xbBdhea2sYjxyn5V3iSN2pTCnsJXNQydyEmWGyfEp6Mtxc
	jHpnKsjK2Jd15cry7NdUMGRPKqZlIGFnQK09vkQLgXaQNFA4SGEKt75Hyr1xAMpw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m8688-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FDNpoP003256;
	Wed, 15 Apr 2026 15:01:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh90aud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FF1PgC45482368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:01:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DA072004D;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF4020040;
	Wed, 15 Apr 2026 15:01:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Apr 2026 15:01:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id D6DF0E080A; Wed, 15 Apr 2026 17:01:24 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] s390/mm: Make PTC and UV call order consistent
Date: Wed, 15 Apr 2026 17:01:22 +0200
Message-ID: <7b0e73e3c6f4000f9bf7cb161d8ca9a9f2312d70.1776264097.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776264097.git.agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69dfa849 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=sUKjrkhoaZ6cYlpXR9kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GfE48YsPTVl7zllCgjvdRH7LvPfm3xJ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEzNyBTYWx0ZWRfX/07hu9qNKP6r
 QKBNomPZz7UzONVTmNLDO6fQfAVZXFHJanLyTBj2i0kFfvFq2UNXrVvdqnKAcoo2/GcL4SdpAQQ
 AXozAvUogB+Pe9q0CGDVMcWCj/EXM29fpbEjGlTQOY4FdDAPYc0UAb4xn+aQe2brSsABBLwW201
 kLSfPhT1yb/yCQ63+n6v7NG2fn3JPnQvTro5PxSwVHGbCJWkDCs1XUuS5/Rn/rKq/1/bOGDSH88
 OguXmlwtb+HLzNMSlLtAdlwjaURiicwb9R04uMNpVEEHIfbpHVHaJbVlvI2P08pu1PMxR6cv4zT
 5KAoVv/9L/rogs6OsHtXmXTjc9I8JBeS5qF5o96HiaCkIQePHjj9F1CX0n6EZMPx6OWzl/4IJV+
 zKeCEsUGQocNjSgLj/66IXDNyCGlFRVTHV0Z5YhsQhzOeYhglOJogNpLrHc4xPKUBS7m46oJTcC
 1ZFKrO+lToDUc9n4M1A==
X-Proofpoint-ORIG-GUID: GfE48YsPTVl7zllCgjvdRH7LvPfm3xJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150137

In various code paths, page_table_check_pte_clear() is called
before converting a secure page, while in others it is called
after. Make this consistent and always perform the conversion
after the PTC hook has been called. Also make all conversion=E2=80=91
eligibility condition checks look the same, and rework the one
in ptep_get_and_clear_full() slightly.

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 39 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index 42688ea4337f..010a33fec867 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1219,10 +1219,10 @@ static inline pte_t ptep_get_and_clear(struct mm_=
struct *mm,
 	pte_t res;
=20
 	res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+	page_table_check_pte_clear(mm, addr, res);
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
 		WARN_ON_ONCE(uv_convert_from_secure_pte(res));
-	page_table_check_pte_clear(mm, addr, res);
 	return res;
 }
=20
@@ -1238,10 +1238,10 @@ static inline pte_t ptep_clear_flush(struct vm_ar=
ea_struct *vma,
 	pte_t res;
=20
 	res =3D ptep_xchg_direct(vma->vm_mm, addr, ptep, __pte(_PAGE_INVALID));
+	page_table_check_pte_clear(vma->vm_mm, addr, res);
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(vma->vm_mm) && pte_present(res))
 		WARN_ON_ONCE(uv_convert_from_secure_pte(res));
-	page_table_check_pte_clear(vma->vm_mm, addr, res);
 	return res;
 }
=20
@@ -1265,26 +1265,23 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
 	} else {
 		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	}
-
 	page_table_check_pte_clear(mm, addr, res);
-
-	/* Nothing to do */
-	if (!mm_is_protected(mm) || !pte_present(res))
-		return res;
-	/*
-	 * At this point the reference through the mapping is still present.
-	 * The notifier should have destroyed all protected vCPUs at this
-	 * point, so the destroy should be successful.
-	 */
-	if (full && !uv_destroy_pte(res))
-		return res;
-	/*
-	 * If something went wrong and the page could not be destroyed, or
-	 * if this is not a mm teardown, the slower export is used as
-	 * fallback instead. If even that fails, print a warning and leak
-	 * the page, to avoid crashing the whole system.
-	 */
-	WARN_ON_ONCE(uv_convert_from_secure_pte(res));
+	/* At this point the reference through the mapping is still present */
+	if (mm_is_protected(mm) && pte_present(res)) {
+		/*
+		 * The notifier should have destroyed all protected vCPUs at
+		 * this point, so the destroy should be successful.
+		 */
+		if (full && !uv_destroy_pte(res))
+			return res;
+		/*
+		 * If something went wrong and the page could not be destroyed,
+		 * or if this is not a mm teardown, the slower export is used
+		 * as fallback instead. If even that fails, print a warning and
+		 * leak the page, to avoid crashing the whole system.
+		 */
+		WARN_ON_ONCE(uv_convert_from_secure_pte(res));
+	}
 	return res;
 }
=20
--=20
2.51.0

