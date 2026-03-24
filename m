Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48C410D1E;
	Tue, 24 Mar 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374209; cv=none; b=OUQoXbnUgOoBHFcXmEAeEJuk6Am5g6tVzxqTOch9Uoe6JhW8Rnwnh147CwL0INWzDp+7OmGgb88DvTEUmaeHPYNg5bnKxqI5t5+df3Ey28SEf4voyHfpqbSAz9mvL7reGzHH59BA0WUkt3mXHUvVipqd6Spm0hSVTVuNNBn82QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374209; c=relaxed/simple;
	bh=bYiwJyv2dcqDhI7H+Ch1gE5Ig9VLthdVcmh1o5HAfLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoUGiFBPwhxMKpssHNb4JgD8/e61K6lmh2UIWdHTMvwDTtQJKiLLv3xcyrYTq5ZV+kCz/gLmTWwtdN/8Mp7lZ266xYJyee/IEQm94sd5MJ4Wm1tju5T7vCHIFzTGTk2pcr489TZ+Fkyf46mvAhkJzsgZn7nnyxSw6xKHvyLvFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vb4vrWuq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vb4vrWuq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9TaDo632924;
	Tue, 24 Mar 2026 17:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2LfC/9+FnL+kzqIPA
	vUKlrsfNdWWN69vrQfjhiOfWvk=; b=Vb4vrWuqbQmvlN6duk4Zb45Loy4N3MJ2v
	TkoKFtmMXM1tlI4+62uCz6/8217aHu7y97FxI5Kpr0NICI7NJLlorqrIu1wy3DAy
	0QFu0koRVwfaVZiwuuGbwhbwIU4RhGL7p0vvpe5hmBEmMYak2TPI783bp/0K0uTV
	RWJcaHnZyNAQXseYxlwyFqnPXrD7DlBp8Cz+HTJrCzr61X47n8HBuUT1oSmGEmVv
	o6ukDOTJDLeBj3/JqM4JxtojpzMMezFOAlhSSeVrGaiGN1AMDRICohFY8Ymnz3rv
	00fD6dr0bh0mMxd4Y5A24iLAmdrvFPl4g3Ej6gTZanS4Bz6SEzvqw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kummb3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OH55ev004369;
	Tue, 24 Mar 2026 17:43:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c22ujg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHhEb024969472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1260E20043;
	Tue, 24 Mar 2026 17:43:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E599620040;
	Tue, 24 Mar 2026 17:43:12 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 8/9] KVM: s390: vsie: Fix guest page tables protection
Date: Tue, 24 Mar 2026 18:43:00 +0100
Message-ID: <20260324174301.232921-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324174301.232921-1-imbrenda@linux.ibm.com>
References: <20260324174301.232921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _6Zn4SVFFUFxhLih2Wf7tBwYtc9DrWl4
X-Proofpoint-ORIG-GUID: _6Zn4SVFFUFxhLih2Wf7tBwYtc9DrWl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfX9D9bcrpNHNKM
 ttuCW1BqDgVmw0WvVDeSj9z9hJH94BZV1H/gwqR7bydihGmOILTF40EMR9MDoFubrVXJeYU7YXo
 mlZXGMZYEJGH44h9sIskV2vjX/U+JZqBypAX7ypnnWcSykO/Ru2/TsSgz/3sqbww+yovUlZxZOD
 2O4hrqbd6qZWmpIJ95ceJGiYm9ZkjRI+ark18BWOaGGEVuooPJA+EPQQSnpy74YUK3PpGpTmq0o
 tzLx0toJtsSgCvRE4sS74iOhxyuDXyxxszH3NJYa7DVle8+Nd1fBHdErxTVFOAaxvOTptTNTTVV
 afl+Yhyw6yZh6E11VrO0xBdmIXpUppThT4Qy0qpRikLhQTWlObUgFHa+SDq2wFPfnLhC4jvT4qO
 uByDZmtG+GX8sGAzJpMkLjuifXWKnC67yEFJ4a1Zs0xow8uHmm+akU0EupSN0kGWGiccZoU87HZ
 yt0nWdjHpvRMAi78kSg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2cd36 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=oWLg5jHnNaD6DMA7ueYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134

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
index 0ac2d775d4c0..93a757749a6e 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1518,6 +1518,13 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
 		return 0;
 
+	/* In case of a real address space */
+	if (w->level <= LEVEL_MEM) {
+		l = TABLE_TYPE_PAGE_TABLE;
+		hl = TABLE_TYPE_REGION1;
+		goto real_address_space;
+	}
+
 	gl = get_level(table, ptep);
 
 	/*
@@ -1525,8 +1532,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
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
@@ -1542,6 +1549,7 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	/* Get the smallest granularity */
 	l = min3(gl, hl, w->level);
 
+real_address_space:
 	flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
 	/* If necessary, create the shadow mapping */
 	if (l < gl) {
-- 
2.53.0

