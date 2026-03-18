Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB2149C6F;
	Wed, 18 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842944; cv=none; b=LPm4CCXalCdN4lls3S3tVMpj7KOQtVKEAvQkZkRUkjm8mdr2Uyihq0yrFblkzeUatOztxjXMc2YamWSSUMV6rTvQQdFKa9KqF0R6M6NADurKdw4OY6k1JdtD01L740w1l89KfHc+M+9xFEUfURMr2GqqHrqZRARUXQeF5L/Tyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842944; c=relaxed/simple;
	bh=SQJT5P89+5nPIIz/1Gc8eBUUUTdm2xmtHPkONaNcEak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWCtVnjke4gCQuD9buSGImbi/9IP1qHM33o2s+afldINeQFJZARu8N5QENdhA4sn+9BcFyriZTG7WetY3hhDvjXPQmzEyEmkMcvbtmLw14mEq86Emw/T9wwL3g+awoMP2gycC/WUrdhpQDFlr+V27uX6lcvLFN/IlMHE2Hi2/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=syl+Xijw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="syl+Xijw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I88E9a4040401;
	Wed, 18 Mar 2026 14:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w5CvRlgR1IwcPfDlW
	V/arL+S2Y6gS+sNdoLgNqrnA4I=; b=syl+XijwgJcJx83yLXiMPSAnAIMHV+lII
	JUovWbCHs1s9Y9Xg+JjwdTKtcE7VsW7IadFdDj1X1GN6oqjUvaZNgNUHcoqWGPo5
	mjzgS4bISUrPSvpXOe5rVuS19gIhaqNCjFqNR+K/J3buQdth8DDGbebbeX40D0Qf
	TEtrNm8AzHUG1rB9eC1S0UDAFmMrCJ2BY1GaMrej8K9/4aaOGa+i0lI/CIA7FyO3
	vsjYHV5klLVB6uD9dMrVEezdCIg+v0UygGchGc45CfcZ4nyahAdqnjQnZWwqKmBy
	NNq0DBZ2+obgzYUBGmFpDAgcEDN8mkD90D4TIGXKV5wEH0Dj3m6yw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsaaj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:09:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDs9nd013996;
	Wed, 18 Mar 2026 14:08:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy6cav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8t4a24773044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F85120040;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A1E720043;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v1 5/7] KVM: s390: vsie: Fix unshadowing while shadowing
Date: Wed, 18 Mar 2026 15:08:51 +0100
Message-ID: <20260318140853.119460-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140853.119460-1-imbrenda@linux.ibm.com>
References: <20260318140853.119460-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bab1fc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rP4LS0jab8kgWfQMVEcA:9
X-Proofpoint-ORIG-GUID: jY4JhPcz5ytzNhUKxg-EhWJVNOM8mSdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfXyu1oQIkMWxBN
 sjEVVBeo8ssExIVxBls09xT/WPyf04sE7nRy+N8t1OZ9MyndnyzweIgqM6Gxa71PK25Jd2hzofK
 dpBWbbq2kONrW0q/O1N/cICq7PKeroO8fQr7gYqw4x8XFdWQzHsTFFpJtEEt+qjQEDi2mDbueQH
 NTL0elU3fcQZL8XZDPa00vKYMtp8hh7Ga8tIe+ooH4LWRQGDk6LZMWazwM9fjeJ+6p5R6r4xWWj
 qxQmsUvj7KCUZ3WSHHYKE9eKWH8qf84a3RVD8GDQvCSINrVebRPg+1xFBjEjbcun6237Ky1M3vL
 4kKpGQgPTmjnGGGWQQoUO/dflfSF12UkL2L9VVoUNlYAOgt3Jk69xVr1jPiEM0xvVXEQGdqWR17
 yoIFc1KD94DEOZl0+o3EJfWeRvhKvxjV392inQaHJ9LGK0epazgTPl9fOxJrqw9UiNUvEshq2V3
 6yAgeUCKI/F/9ejpWLw==
X-Proofpoint-GUID: jY4JhPcz5ytzNhUKxg-EhWJVNOM8mSdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180116

If shadowing causes the shadow gmap to get unshadowed, exit early to
prevent an attempt to dereference the parent pointer, which at this
point is NULL.

Opportunistically add some more checks to prevent NULL parents.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c |  2 ++
 arch/s390/kvm/gmap.c    | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index f5ffb11c8ef9..3bcf988d6faa 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1520,6 +1520,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 				       entries[i - 1].pfn, i, entries[i - 1].writable);
 		if (rc)
 			return rc;
+		if (!sg->parent)
+			return -EAGAIN;
 	}
 
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 759a2ed17038..ba921da48019 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1154,6 +1154,7 @@ struct gmap_protect_asce_top_level {
 static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 						struct gmap_protect_asce_top_level *context)
 {
+	struct gmap *parent;
 	int rc, i;
 
 	guard(write_lock)(&sg->kvm->mmu_lock);
@@ -1161,7 +1162,12 @@ static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, s
 	if (kvm_s390_array_needs_retry_safe(sg->kvm, context->seq, context->f))
 		return -EAGAIN;
 
-	scoped_guard(spinlock, &sg->parent->children_lock) {
+	parent = READ_ONCE(sg->parent);
+	if (!parent)
+		return -EAGAIN;
+	scoped_guard(spinlock, &parent->children_lock) {
+		if (READ_ONCE(sg->parent) != parent)
+			return -EAGAIN;
 		for (i = 0; i < CRST_TABLE_PAGES; i++) {
 			if (!context->f[i].valid)
 				continue;
@@ -1244,6 +1250,9 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 	struct gmap *sg, *new;
 	int rc;
 
+	if (WARN_ON(!parent))
+		return ERR_PTR(-EINVAL);
+
 	scoped_guard(spinlock, &parent->children_lock) {
 		sg = gmap_find_shadow(parent, asce, edat_level);
 		if (sg) {
-- 
2.53.0

