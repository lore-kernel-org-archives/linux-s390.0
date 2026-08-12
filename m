Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1742AF82;
	Wed, 12 Aug 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531489; cv=none; b=HnvwJqpPtxxg0OcUr5iprPnJlPQkc35ZMaJ++5jV/cfzqGHBpy9vmKCjASj05LpeT9SrRsudNQOV8Yfszlb4oKz2p1XfW/wTptVQUBSrBgy6cDuG9T8OvfSadnk6C7t1jaSHo4RAXZpbIRoxsPZQt/no3NB/AY2cvYpIr8BBYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531489; c=relaxed/simple;
	bh=TODtbCC3cth5fnzucKCWcEe+7zIDmmAaKQMpubzKM58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8QUTenxNcGkXd+bnU51zNcuava16DC5yyk0fPUZmJml2ogQrQhYgMxMqzmt4albgyLXwKy7x9zQYwyG22MaeTUSLc2bTgRzYyv0JaxMmdDNV/q36OPSirkfbdKu1UhDDIPu5YSrQ6i9ph5oPnS+9li/zXkSbD4QUrGLTUUunMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CY92Iydt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CY92Iydt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1cqf1306654;
	Wed, 12 Aug 2026 10:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SHMfE6tZjaWLRVp1X
	Nlc0KPBLh0pkFrmLT7g5aBRxqc=; b=CY92Iydt4Rkk+KIkQIZdCTNKOUBzP0kA+
	BeMoROwkIV2q0TQ7hqT4WsztXbkBvpFQ5CJa9/JFIFa0M+bFF0cemrB29s6IVc1c
	YxGbYG2EfMdA111uhxPgkZR6y3g4L+At2XK5RxZVFSONB9HK1Km+dS4vPdCBJAh+
	zz4KhShdFPfkKwb/1z/Y5nllgVYUZ2iOE1n4BjlENUPNWqRzcaeAChli9yLx5YQ4
	ZnhhGqdSFo9HzbEYv0DMRzRoj3hF+c09J2R55L0yIVi8P8tr+UwciVtj76vfyY7a
	aSE3L6haBSl17IyNCk9SnegiH8NPDVfHVcVNunIx2tAOglFr8GYxg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk01ynt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfIJ9025117;
	Wed, 12 Aug 2026 10:44:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5hy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAic2447448566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B481720043;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 911DF20040;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 9/9] KVM: s390: Fix _gaccess_shadow_fault()
Date: Wed, 12 Aug 2026 12:44:36 +0200
Message-ID: <20260812104436.109741-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXwLF4Fs0B74qH
 +LwV0hAFl6WUHsPpE5XubL2l2lKF772LnhWTAv6EzkVOr1Wq7tEkWaSB4a7823hNDqTZ+xtzpCu
 IahJwsaVZF0fpGY36ab1pk/Gulr1TAqaFl2T4CdcS5r3N8OpfVU06IVZ5XRRx04115BRCizK1yp
 xDK6Lih5iTf3iLoNyamnyBcVtgbLWMXLdFfs06bbuNTTUM5bZc0uZn4Pd4iV3/Qxm0RjimVyvAN
 53pqtf8b8+k8tbMafX2vUMAF+j4I4SGRKRx1RWlvh3xpntfblUC0yoF4DPo5WtJ0RYn15DN/Xfv
 c3Vrgh/KHPy0TftTdjhN65K61gFgYNZWHGghimBE6v2SD/Bym1bpdRbPn/bY32XutJEQvI7NZOU
 Xtg1WeuSzgcHclz36Eo7W3x4HCgq6vJU6cFklNMhJsC4MxFguoF+19h9RsUT3klTdamfg/y+VBV
 gpLihxOzZcCzPXfAy/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX4Mb6TM+VHRae
 9zgutF0KeSd9uHhHS1csPEkJpMPJYug6JwZNa/qJJe0tOhjAH2qWfAOlmLVhUXDgYWRpMT/QM92
 0dus1kn2xbZpjGp9on+AP1Ot/yvfKN0=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c4e9c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=E-UwkBRaFZ51XR-txJMA:9
X-Proofpoint-GUID: n3pp338sCFzIjwFHl1bibhBnoMV71W_N
X-Proofpoint-ORIG-GUID: n3pp338sCFzIjwFHl1bibhBnoMV71W_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

In some circumstances, it is possible that the page of nested guest
memory that is being shadowed is not present at all in the parent guest
gmap. dat_entry_walk() will not find any leaf entry and return with
-ENOENT, which will erroneously be propagated all the way to userspace.

Fix by manually calling gmap_link() on the memory of the nested guest
that is being shadowed if the mapping was not already present.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 36102b2727fb..f3a889988cdb 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1507,6 +1507,7 @@ static int _do_shadow_crste(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_
 static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 			      unsigned long saddr, struct pgtwalk *w)
 {
+	struct kvm_memory_slot *slot;
 	struct guest_fault *entries;
 	int flags, i, hl, gl, l, rc;
 	union crste *table, *host;
@@ -1551,8 +1552,17 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 			return -EAGAIN;
 	}
 
+retry:
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
 			    TABLE_TYPE_PAGE_TABLE, &host, &ptep_h);
+	if (rc == -ENOENT) {
+		slot = gfn_to_memslot(sg->kvm, entries[LEVEL_MEM].gfn);
+		if (!slot)
+			return PGM_ADDRESSING;
+		rc = gmap_link(mc, sg->parent, entries + LEVEL_MEM, slot);
+		if (!rc)
+			goto retry;
+	}
 	if (rc)
 		return rc;
 
-- 
2.55.0

