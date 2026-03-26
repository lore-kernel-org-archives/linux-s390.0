Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF931F987;
	Thu, 26 Mar 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531067; cv=none; b=anV4KabhDiHOv3CvDyTUFkqPzuFPn/DuSq5WwGANw/BpjCa6dEtS/FrdajCYThaKAIBG7rANYNNyLtCFBYNvcby43A+p0TsQwU75sAYTGqKME4Xl0xHInqG/I0ORR0mxbv3Bo/U2I5hfY7q9uYj21afafmLzZla8hdfSBwcstjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531067; c=relaxed/simple;
	bh=4YvQrlAPtmyy9nHrH33xmBmKGZf67ZbjsSaFj8cuQVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bssn/cAukaGmyd+gBFqjYj9GdeRKjR6TRVsiBCMVUafaPWkt6T1frvV3VxyK2QPhFa+oX8IMwf6rM54ec10/OkKCgfJrl5FlaPt+A8yczfH8tTZOd7uqwChdbLDHK3g76iPpYJ9JZ0eeA6us5RqplzSHP1YqY6gExUHPpGb66J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K492sBRD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K492sBRD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PMb9A5415280;
	Thu, 26 Mar 2026 13:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AvguOzHMXTpjhhD6T
	F8/TjFg+mCN4KBzXh8tEjFzrow=; b=K492sBRDCKpbcrBV6TwBAb4FCDIjAEJ0a
	CoaWQVpfTPcboFh+HLVLgB0E+hWzyymS4dpiK3SpOfdXZ+3nmIGeNkAPNDqhi0v/
	fV+RewfQo4MSe9B52lx6hSqHMv5eBOaBid5k9zf7wh0y/WD97cVz5TFuHWYyYsMe
	MiLJSvkg1+vpXoivrmOdr+nAxzaLOZzAAW8FTecofCm2ldBdgw/qCGxwl4xp8qzT
	RiBYcL3uhg01GqdBjbvMOHjUYNq60BGdDAEKvF0K57W4xysSAISfeBptlIcseJcB
	vDtNTu8X/XB4UTbQI+sE77TkSoXCTosWpnAP1xN89K2J8mvC9ZnXw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumvd6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QAWCiN031592;
	Thu, 26 Mar 2026 13:17:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt36u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHTEX34799990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A5F20043;
	Thu, 26 Mar 2026 13:17:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A1212004F;
	Thu, 26 Mar 2026 13:17:28 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 06/10] KVM: s390: vsie: Fix nested guest memory shadowing
Date: Thu, 26 Mar 2026 14:17:15 +0100
Message-ID: <20260326131719.98229-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CjAxtl4CLEis2YSUzC8bNH5cbZIMxNzE
X-Proofpoint-ORIG-GUID: CjAxtl4CLEis2YSUzC8bNH5cbZIMxNzE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfX+UREqn4SmtkA
 v4+wVVWqCaQHhAqtpAKo0jFIY6X8hgQXLpejPKyQuzAmxXaXgozgKVx/Xup2/2+TIo87xJtNINo
 EB0NDrEhRgphOIcYzy9iqcE07c1KqkX1OeX+TgmhZB6iDfVBiwOMmWGapJRSjAAZ/hsa3G39MV8
 0g34S9i36jprLa89Gk3KKt+GXzeY34xeDrYxO4YH/ujNTXNmq09H7/nHDkcCWG92n7GUf3UkPIJ
 Z45k92vngvLX+oMC//cOnSHo2RDglYGTcARLY6N+lOmN3gPLfV21kMxIZ65hPvmjTnoyDVo5+Tz
 mzPSKu9/XMpFJgqmP5n3V2iAZZfag/T/AHUdZG1pPAMAp1ONX69h+T5je39YES3Tho2ufbycebF
 4mIFdQ4rLmGlMD+LNfo1UwFjUby9iMoJhkaFGeOkArZHgs5wvISyglTf8oUXdrhPMCD2H89+d0r
 OQg5VBorI1qh8xIlGVQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c531ee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qWq0Kag4T7NBTqZ9-FgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260093

Fix _do_shadow_pte() to use the correct pointer (guest pte instead of
nested guest) to set up the new pte.

Add a check to return -EOPNOTSUPP if the mapping for the nested guest
is writeable but the same page in the guest is only read-only.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 8fd690255e1b..6bc30f678921 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1436,13 +1436,19 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 
 	if (!pgste_get_trylock(ptep_h, &pgste))
 		return -EAGAIN;
-	newpte = _pte(f->pfn, f->writable, !p, 0);
-	newpte.s.d |= ptep->s.d;
-	newpte.s.sd |= ptep->s.sd;
-	newpte.h.p &= ptep->h.p;
-	pgste = _gmap_ptep_xchg(sg->parent, ptep_h, newpte, pgste, f->gfn, false);
-	pgste.vsie_notif = 1;
+	newpte = _pte(f->pfn, f->writable, !p, ptep_h->s.s);
+	newpte.s.d |= ptep_h->s.d;
+	newpte.s.sd |= ptep_h->s.sd;
+	newpte.h.p &= ptep_h->h.p;
+	if (!newpte.h.p && !f->writable) {
+		rc = -EOPNOTSUPP;
+	} else {
+		pgste = _gmap_ptep_xchg(sg->parent, ptep_h, newpte, pgste, f->gfn, false);
+		pgste.vsie_notif = 1;
+	}
 	pgste_set_unlock(ptep_h, pgste);
+	if (rc)
+		return rc;
 
 	newpte = _pte(f->pfn, 0, !p, 0);
 	if (!pgste_get_trylock(ptep, &pgste))
@@ -1477,6 +1483,9 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		newcrste.h.p &= oldcrste.h.p;
 		newcrste.s.fc1.vsie_notif = 1;
 		newcrste.s.fc1.prefix_notif = oldcrste.s.fc1.prefix_notif;
+		newcrste.s.fc1.s = oldcrste.s.fc1.s;
+		if (!newcrste.h.p && !f->writable)
+			return -EOPNOTSUPP;
 	} while (!_gmap_crstep_xchg_atomic(sg->parent, host, oldcrste, newcrste, f->gfn, false));
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
-- 
2.53.0

