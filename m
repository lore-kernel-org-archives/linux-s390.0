Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FD3F54D0;
	Thu, 26 Mar 2026 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531063; cv=none; b=A0LzTNQdMg7d+YOfECa06qle/iGMYXKi1oBvB7PSKJDl0PcsBHCqV7jILbNu131yAz+UErSSompBFVh9UVhquQNgK8Q77BfOmFiMtR+pbQF56zS6ZmFnRz8nltG5i2N4uyYlC8D+E7hKo83Y/GBerMNGqCnCu54dLViP2ob2/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531063; c=relaxed/simple;
	bh=CF6OzJVaObW1uo4D09pha6CNc+28ifIe73AysbpKqHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z31gSshlUbQD0m+u6UgWXDmu5ENJC23jHGezyaVW3FE5XDBLH4EhP0HdWL/TevzhTwr6koTPDkKnli5B7coUnhgNWOnu3ffF29UeZC/vrXt+OP5qUMg2JjCBpgWkwhqmP4iMJnUaZQzOp6m+uFV6Wmo3jPg8CK6nC+H88Dao1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uy8AuRNt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uy8AuRNt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q2MqO7486107;
	Thu, 26 Mar 2026 13:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M23Itk6fuMRcABNzx
	Vx0p//9H4wV5f0Pk3BylfCJegQ=; b=Uy8AuRNtDWl6g5hEMmbcs9T1lfM4OQQp7
	CXBnspE7oqNa+VC6C/df437C6EqvjXJW7sAQ8Z0ZO9EqST0Zy4wi5Fn25oyTaiLo
	xVjwspSCrxmf8LAvrwwrsqTi7zumYteXNEiI41eWKl12AJatoTF4sow+vIr+kmBy
	+R6cFRPlrMLNN/bdgnbd7BJuEin1RbYDYYt6PEfBnYcVeArOeAgXXH+PnOrqxFRN
	y4lnungMFBSIVxLSF9OjaPBrYUqqGvvgQ3aLW4rBIDIG4SBgR8KqVq+tBAASuiBt
	ZWj5ewh7wj6X0tpK5b8/HofyxnAoVE6A06ive3STFVLRaUQ25nUNA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumvd75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QCpZfa004398;
	Thu, 26 Mar 2026 13:17:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2aty9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHYok34734506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165962004E;
	Thu, 26 Mar 2026 13:17:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE1AC20043;
	Thu, 26 Mar 2026 13:17:32 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 09/10] KVM: s390: vsie: Fix guest page tables protection
Date: Thu, 26 Mar 2026 14:17:18 +0100
Message-ID: <20260326131719.98229-10-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: RMTEQR4QlTCf6cDeFKJ2anJk2TAjgB6T
X-Proofpoint-ORIG-GUID: RMTEQR4QlTCf6cDeFKJ2anJk2TAjgB6T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfX4TbaHMBtgSKA
 5xc2xkhFYKAjQ2N23bG5NnJaRzBKdx5jlTMB0HmfdNrH1gXKlGOi7jQwJ6HQLUVwxVOdYLYwCT3
 HTcTUT0839VfwOgUEEICpqwK3bQnhN4koYGG/XYhZTk6TCuuoykBbEaVo1PomunWoVE+/hoRt4o
 9LkIYgrQevcjxV6cWFV80FKNaleFs8yQZbRN6W+YFf52reIOyPHnEVstp6rpQ3HvKVRrAZeNK3L
 BmSA0OqXnCqo8VfTf0rcu7U4b/yBNmYADVnUcL6ib0BWpTdaSydhp6BsxmjmNmj1+gPApbsqOvl
 wRZCPAsVa9H9MSBIXRP/ZHOYNzxXNxxy60gofxChqhgbKIT3DbuCkleKblvt4VRbFlhGTyEkRkf
 sfDzF1HCJ1pUVY2MM1gIEskQcaQ4M0x0y+HhBbSsTuFAmf6qTms9v9MVc1nqjqyPKZXDbbuovMG
 2woBjFFF3OYDh8lsCEg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c531f2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=oWLg5jHnNaD6DMA7ueYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260093

When shadowing, the guest page tables are write-protected, in order to
trap changes and properly unshadow the shadow mapping for the nested
guest. Already shadowed levels are skipped, so that only the needed
levels are write protected.

Currently the levels that get write protected are exactly one level too
deep: the last level (nested guest memory) gets protected in the wrong
way, and will be protected again correctly a few lines afterwards; most
importantly, the highest non-shadowed level does *not* get write
protected.

Moreover, if the nested guest is running in a real address space, there
are no DAT tables to shadow.

Write protect the correct levels, so that all the levels that need to
be protected are protected, and avoid double protecting the last level;
skip attempting to shadow the DAT tables when the nested guest is
running in a real address space.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 8d99667e7d34..53a8550e7102 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1529,13 +1529,20 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 
 	gl = get_level(table, ptep);
 
+	/* In case of a real address space */
+	if (w->level <= LEVEL_MEM) {
+		l = TABLE_TYPE_PAGE_TABLE;
+		hl = TABLE_TYPE_REGION1;
+		goto real_address_space;
+	}
+
 	/*
 	 * Skip levels that are already protected. For each level, protect
 	 * only the page containing the entry, not the whole table.
 	 */
 	for (i = gl ; i >= w->level; i--) {
-		rc = gmap_protect_rmap(mc, sg, entries[i - 1].gfn, gpa_to_gfn(saddr),
-				       entries[i - 1].pfn, i, entries[i - 1].writable);
+		rc = gmap_protect_rmap(mc, sg, entries[i].gfn, gpa_to_gfn(saddr),
+				       entries[i].pfn, i + 1, entries[i].writable);
 		if (rc)
 			return rc;
 		if (!sg->parent)
@@ -1551,6 +1558,7 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	/* Get the smallest granularity */
 	l = min3(gl, hl, w->level);
 
+real_address_space:
 	flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
 	/* If necessary, create the shadow mapping */
 	if (l < gl) {
-- 
2.53.0

