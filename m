Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2F3EAC6E;
	Wed, 25 Mar 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458803; cv=none; b=cIRAzQA/Oznnsim7bl9y7UJUDQ7qWEriSPJHcTTT4StikRnuZ+wmuGgzx2QGX33xKLoc7BpucecfWnR9RVNLszskjXxVF1QHmLBeoXzRcWjvestT9hOOetYOpPf+rQ3edODSKyHfUYjdZ7SQqUhkjkK7L+FD4+1ouU/NIHZrlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458803; c=relaxed/simple;
	bh=BfFDQhRZDrv4l0o+P3Cy0EH03udwA6HONdyDCIFFhcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X244FXC5dHDosUBQBdrcrLvPxbRpAcqm7q2HJzgLTX8DPCYY/rNUO90+a+RQ2NcYk2ksw6Nd709hmLhx7ngVI/AzWLR8S5votRUZpZaSzz82kIsXJE4MwDCNNEgyd2230K42Fk/Myu3vxFmx4K1LGgYJyVHpy9+VhPp8cXIvcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TwvxVy59; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TwvxVy59"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P79cpr3658690;
	Wed, 25 Mar 2026 17:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NdwMd3nY6aIO9OYui
	lud7peguS/0BsSYLd82BEoMteo=; b=TwvxVy59ZD7Dsfe8Oufhzq4P/QVEvjmvc
	X+X0CTjwdxvIGMJXZQjbOKaE/3Pw3594n2gjlTsPKHknIWxjEQx6L3ZuErVvKI6O
	992IStT3PwHC61kZqSt5fDExmhGdxVFnPlCyRXE9ttPtwebvh35asOwJ1ox+ExOu
	+LqDsoJmFF8Z1zrzORlD2SxjZXATdx03gbInJ3kjkw1UoPfWM6xcslQZ1ajCPekl
	uw37CLO6MW+5L1zaE5LbeK3uDvleeld5qWvHeukWx4uaIqk4a5NQ73hX6HfaX4j/
	fH0IzqblP+Y3SyQMqsSpHxEM9OVrD4X2JCmG19yXu+xriYGDNFtWw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty1hkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PGVb8K011778;
	Wed, 25 Mar 2026 17:13:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk79c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDEkk50987414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F77320043;
	Wed, 25 Mar 2026 17:13:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13B8720040;
	Wed, 25 Mar 2026 17:13:14 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 09/10] KVM: s390: vsie: Fix guest page tables protection
Date: Wed, 25 Mar 2026 18:13:10 +0100
Message-ID: <20260325171311.182210-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c417ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=oWLg5jHnNaD6DMA7ueYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX0YUk2ITb0ocv
 v8D+vaUFwkv45+Ri0xJTU6ylvpIRI2+wcnAgNb4F61DPTt1idv8ovh7+h7FYM2HdJGoLz4pTt8O
 XfnfgaLUlfj4p+8/NzP8R5C/4/U9pJwzJE4Yfzq3CH8Dh5s0rryfgO9TjJqOgmcPbD2zDvQabyq
 v2TfG+9JU3LCOG/pjFCZ8Po1B2lpQ/lQV00x/HAL928ghRJRekrkjmJs6RGdkpPqHUZkST6DHe4
 JTNerUvdF+9pd6iFWFjt3kaSx6afAo/r0NVijV//CC/kJZRWO4UCAFC1RLGeBxkaGUlpaQfHjw8
 tlWHxATKR77oWx925YEil4kvO12y2Cmrk/V0Qh0M1FGUzlAOzipUcytjCwL/gDtk+yN93h1Yzr+
 09GYPwqXv9KxtlWdrnYRhgEUw6jnxTUBPfX/Z+s9cxsnwj1W2RRXRbNSmxPXNe7utv4Bv0TyL7l
 rZkdGfdmUhKGNSwGizg==
X-Proofpoint-GUID: iwooQRwca2NKRELhoSLK7ibiyv_Ssu7I
X-Proofpoint-ORIG-GUID: iwooQRwca2NKRELhoSLK7ibiyv_Ssu7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

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
index d14c2b40a5f6..93d03e0fd704 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1521,13 +1521,20 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 
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
@@ -1543,6 +1550,7 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	/* Get the smallest granularity */
 	l = min3(gl, hl, w->level);
 
+real_address_space:
 	flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
 	/* If necessary, create the shadow mapping */
 	if (l < gl) {
-- 
2.53.0

