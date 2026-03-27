Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE23246F8;
	Fri, 27 Mar 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625069; cv=none; b=Czt0nzaCjTDqnEymMiqTtyRprM1TbhrIKktu1fcOSzl0tUUmtpa+wuorabSCbMfDpaR7+W1yW2VHES/cvBkzfWj+5siraKqiJl4lx0IgH4ENya0eW51BSFyLLwUztQmotiJ+/yOH1/YDX3W0mylHRYcjiRPOh4R+dhe/pGLW3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625069; c=relaxed/simple;
	bh=NNys26+LrOykoA9xFiBXcjnEe4hDkifLn2bvyYFNWs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZOG8pH9u/bZvfEZbMu+KeVYVkNe2JZF7Ulkgf2HEyCJL9vHbIzcrrc2KIzA+/HVvND9KEGnGNGOVMzGgeGhlIrTdFkMW6kvwBICuVNybffHWXfBQBJdM6GPks/GQFbwDmKIbS3PePAcyVJB/rf14BPVzQGkPjnszKNxmsvI810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J5e6BPxs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J5e6BPxs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62REtsbQ3448655;
	Fri, 27 Mar 2026 15:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+gIsJcLAoRvEudIK7
	6TVSDq8LkQDLZbRhc2rzU+q4Jg=; b=J5e6BPxs78JWaea3FRr+BctqKslq4PPVo
	zc+nVWO5mRyMSsia2igHpRbBoSKD1MXl8wRYUHNm6B5A86el0f2OkQ9WCZdlHnR2
	vqhExkNdPVOiTRv3Trz5aRMbCsKanIudOjZHFLEHHJv/dZ5XIZ69eCPg8gN65eDi
	LsJNs97+LZ4VdAixkKgN0CIJfV/ZiE5uVWx37abhE4i9Bm51znoXiyyzx6jCwlQd
	OlVGLguQXigN35l7mmyLHTQEQUB7p1hz/vz4R1cMOR73oOyCHQcP/bwPlGBhVRd7
	9YOsrFQo/Ry8LfW/23aF9uC8W/W0p8e4s8G0NZY7mHofst4/vHfrA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwaatxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RBcoVZ012185;
	Fri, 27 Mar 2026 15:24:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkfu7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFO2df50921896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E8220043;
	Fri, 27 Mar 2026 15:24:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E542004B;
	Fri, 27 Mar 2026 15:24:01 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:24:01 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 06/10] KVM: s390: vsie: Fix nested guest memory shadowing
Date: Fri, 27 Mar 2026 16:23:52 +0100
Message-ID: <20260327152356.250625-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aSgcganTa0hazpD_i9Qojqs61Q6TmH0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX5qPCNtKCby/K
 gBU4HFsxvhtsOW3I/8ZPJmkv1yXVsCw6QX1Fg29M/chPfCw5yOE+L/Zg25Nq09kL9tOVgVI2FPw
 p2UC5l1sn6UdL240lQzPasLG6kgktyYecjUgPzJ2D6EuSmdfkSwhdj1QCJ5KM3LmOSxRTM6vA/f
 dGKnNphah2D0JqB77vE53iK4GLy5j7EgwxziuN8GXWFlw8oYr08QfRMJM6M9Irm1u8K1E66Z8Vb
 tKI087YL3HDDbDUgnDp7K4UZItqR4hJCrOB1eEN4Ac8XLEPXTJQcv5rhwvBwjyFhL1VEJ222+OS
 0Y/TNpVgK32JURBh3b/YlWhUwfA4nC5S0EqtuFZwYvmQMaW1SI5yGhBqZhenkEWs9uTqh6CB66+
 tcQw9sizhs7bwcBOKPzXH6ueeLUDXkJdt3jIQhZdpN71wHsbtdkzDhS8X3JRKuV9v7gTPoZ1rQt
 r8I3fHMtGs/5+LScqQw==
X-Proofpoint-GUID: aSgcganTa0hazpD_i9Qojqs61Q6TmH0Y
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c6a119 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=qWq0Kag4T7NBTqZ9-FgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105

Fix _do_shadow_pte() to use the correct pointer (guest pte instead of
nested guest) to set up the new pte.

Add a check to return -EOPNOTSUPP if the mapping for the nested guest
is writeable but the same page in the guest is only read-only.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

