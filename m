Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29848A2BF;
	Wed,  7 Oct 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373357; cv=none; b=Oebe/gyZy1TXjbFn/2ILdFryqKl2i5MdXrXBHcDfDQuqf9rTklpnxKfMhxxNMome+ij8gl0KcrhAJ0NpXYpOPBSX9yoSkdyXpbUx0/3zq39mBVV27S+nvTXtggCax7ztMOUIo3kNLX9bubnsYOe213JqMTuxrOUgsyxqKK8J+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373357; c=relaxed/simple;
	bh=P2pbFqjhkKFzj1N45GsymfMY3gfsD4ioVqtL0/GsCGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZuuF2tK/ZNUGI5K/YYq0TfVJu1t3/A0rJT0tU3UNy8X+2Pz88UlG0/tO9W8abm7XpKLjfjPNbu+PTuNhjv3dtn2MSDzt+NQFRBPTmRRdO1GMSYNX+7BYUHLBHe6eJAxe7C+89rxWRtuT1IWawJEQXF4tjHTXS0asw8yOc9b2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zgvt3ctw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zgvt3ctw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZwUw597197;
	Wed, 7 Oct 2026 11:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aqypqc+l/OqAfcEQC
	4OZjmmHbg7ldU+PpmJE6Skx8i4=; b=Zgvt3ctwgw39rI6FDeb/+dsryMIWUsE1c
	QZMYF9SyvJOZveo+bHhsHOmUBCXg8mUdXzyErX7sY5bxBMJlrO8UHQXCLlZZKO/c
	3lm0C7hkT3Czi/m7MZyxPEXNXzUVYHHCQ3GTt6FTDoJjxlJKKhTpJVRWwXA8wRMu
	DePhENtazvZVwpng2NHXn++qYhafCtvQKiscZ6h0zOhOFNLBmqU3jrK+YOH04/QF
	c/0OufjiwJ9FPFI4xyFiScOBWycN2M2aDbvn71m/D6HoXyEh64IG0gmoHlBAXOBJ
	zaTGaY3PkFhr4D17d1+ZPD3ce6blfmPQTInCW1d4iDpSjZ4EZBJWA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrn5kj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWcPa1810428;
	Wed, 7 Oct 2026 11:42:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek2ka1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BfxAC44106128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A1E2004D;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EC252004B;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 7BDEB1608CE; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 02/15] mm: rename pointers to software PTE values as ptentp
Date: Wed,  7 Oct 2026 13:41:45 +0200
Message-ID: <76c38f9eea5132fe56aafffc68d5c499f423a705.1791365932.git.agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+fY+IgbOtwY4
 OpWN2uLcMS28bfINiICBAFqzw8N2KoMRVI1O67Qa26y5BAPl3x7GBPqtQIjvtXWIE04fbCGeP1A
 pmy4uXb33mlBk3VFxZ84h4LFFaKjGDc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXzkPi73YV188+
 dawf8MKfaiyv2YWKW8lmnEV/r0RIh00DTVLSBVODNT8rHvC8wI0XPpv8ngVYpnPUcFy+pTr25Pj
 964jSF5Z9lkIPTt/liYP9RYKt6ZchYGR2uZGmWCTqLcjtj4CMr4uCOtL75UyBgJC1Y4fZerQHoH
 E3Mm64xDcVo9yHMsDO7/oe+eRSIT+lNwI6bIZXJ5WNxe6R84pHEDvjPpP1CnHQtp6/NMhCKwb1e
 c4RRw0MKWck4YNj4KW5OiVjMh45E9wKEJqRPOzh49dZZFGL6yCdYLv96f1ctS13XJA9TJca2HxM
 lJyKKLGdVLbewxC68Xc/nDTNJx7wkZEx5Ll37Pw70I0HsQ9uAf8zN0uIDGMT7GB1xEF4Ms/qM30
 EugUdkE2Q6nnbfjAvW9b5ZwNBKPp/CQNTK7yQrc47nirVLYn3D6aM0DBssWbonQKi8YfT3BmRQd
 W+9bCKt4gXhjJr4NrSg==
X-Proofpoint-GUID: Eue0-3r4Z0cAnjS8exp06yeH6pO9gDCl
X-Proofpoint-ORIG-GUID: T9jWbWBEm7D-IWe0zqIMM0rFSjO0bvE7
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=DykVs9dKbHxkzX7wQTQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

Some interfaces use pte_t * for a software PTE value rather than for an
entry stored in a PTE table. These pointers must remain pte_t * when
pointers to PTE table storage are converted to hw_pte_t *.

Rename these parameters in the install_pte callback,
write_protect_page(), and guard_install_set_pte() to ptentp. The later
Coccinelle conversion skips pointers named ptentp, allowing it to convert
the remaining PTE table pointers without changing these interfaces.

Some functions already use ptentp for such pointers, including:
- madvise_folio_pte_batch()
- folio_pte_batch_flags()
No need to rename them.

This patch only renames parameters and makes no functional change.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/pagewalk.h | 2 +-
 mm/ksm.c                 | 4 ++--
 mm/madvise.c             | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index b41d7265c01b..c34d826c5e4a 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -89,7 +89,7 @@ struct mm_walk_ops {
 		       struct mm_walk *walk);
 	void (*post_vma)(struct mm_walk *walk);
 	int (*install_pte)(unsigned long addr, unsigned long next,
-			   pte_t *ptep, struct mm_walk *walk);
+			   pte_t *ptentp, struct mm_walk *walk);
 	enum page_walk_lock walk_lock;
 };
=20
diff --git a/mm/ksm.c b/mm/ksm.c
index 49d48d1e0998..892bf4a0d6e4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1291,7 +1291,7 @@ static u32 calc_checksum(struct page *page)
 }
=20
 static int write_protect_page(struct vm_area_struct *vma, struct folio *=
folio,
-			      pte_t *orig_pte)
+			      pte_t *ptentp)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
@@ -1370,7 +1370,7 @@ static int write_protect_page(struct vm_area_struct=
 *vma, struct folio *folio,
=20
 		set_pte_at(mm, pvmw.address, pvmw.pte, entry);
 	}
-	*orig_pte =3D entry;
+	*ptentp =3D entry;
 	err =3D 0;
=20
 out_unlock:
diff --git a/mm/madvise.c b/mm/madvise.c
index eeee82cf2b3f..c2133b36b24a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1110,12 +1110,12 @@ static int guard_install_pte_entry(pte_t *pte, un=
signed long addr,
 }
=20
 static int guard_install_set_pte(unsigned long addr, unsigned long next,
-				 pte_t *ptep, struct mm_walk *walk)
+				 pte_t *ptentp, struct mm_walk *walk)
 {
 	unsigned long *nr_pages =3D (unsigned long *)walk->private;
=20
 	/* Simply install a PTE marker, this causes segfault on access. */
-	*ptep =3D make_pte_marker(PTE_MARKER_GUARD);
+	*ptentp =3D make_pte_marker(PTE_MARKER_GUARD);
 	(*nr_pages)++;
=20
 	return 0;
--=20
2.53.0

