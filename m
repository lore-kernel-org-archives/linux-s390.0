Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750503CFF53;
	Fri, 20 Mar 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023353; cv=none; b=nAM4Eoqugb0Dds1vFXD9529aME8Pb43utEgiKf6VxgnBFyGj+6FjTNpWd3CEa2o1z14sRpk+AJmuEn1M8zMv1zupsAqgG6VM30LflPP37/CsLer+SHxuv8qo2Kyyil8k4SWQV6vz5xMrb7FKbNC3bC98mOvbm4xC56k7vJBvk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023353; c=relaxed/simple;
	bh=Bbbonkg13c/N+CBkpYpoyzaFNRZsv8IZKmcmG2FXU8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cfz3Iqo8ZemLFLLtjpQxNG/vofnXmjclDxONvrzyW7KVM1FASpL/W7xyFHrsyCsc/7JOZNZZxAY4IdwFVY8hFe3T7yrVCXWh4mrpaNa1GyT7dn/ERFb4xZrpMEKlJr3CLKByJrZZhSZo+2nmPPxl/N4UU/WQA/xpEQ0WrNrrJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rZzjnU8M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rZzjnU8M"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K1kV0C1011167;
	Fri, 20 Mar 2026 16:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RYGWKz+LPaT7GzyTg
	5Yoo4nMEXdD6i6APinR5zJ6bcs=; b=rZzjnU8ManUklOlDQuvdT9bnpFZXaT/sR
	mZivMwNpzo/oz3ze2oVuBFqHyjt/awm0rtnWCVPvOUikPJvAfAYroLxLW2Eo2i+b
	Ws3x7FS7a2bQqBp9kjCpet271Zu10bcwQ10Jnb7BWHrQrnjGIuJ9V7gmsU52jvQq
	ryba9g+Mb9xc9D57thHZDXd4QijbshxdnxEswVRVA0xvjG9noyMZbLKTPWH6TSRN
	8mceCAtIf/yYE3qk7pUB6Tng9WLRGKAysL4PyIT6g1lGvbpA56RSNAhNPa75bGAR
	YJlUSwiC4LDRGt6+tWBRlrxDbEQDwrLNwWXZafS6NTvh/4hxriV6A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3jbk8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KDAZNm032404;
	Fri, 20 Mar 2026 16:15:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7k7pnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFhqS25821646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A61B2004B;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649B420043;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 6/8] KVM: s390: vsie: Fix unshadowing while shadowing
Date: Fri, 20 Mar 2026 17:15:40 +0100
Message-ID: <20260320161542.202913-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320161542.202913-1-imbrenda@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9YCiHEd2Q6O0kvEZ-iKg5wfzTsoBfyct
X-Proofpoint-ORIG-GUID: 9YCiHEd2Q6O0kvEZ-iKg5wfzTsoBfyct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfXxsHXMQPb4nCX
 H+RLctohXC+2nDQl5Fj9nKz41PCDKt+3C/7cygxLJ3xdzQlLJEcsMtn+lPPFYLWT/cM0fyR4YBB
 vPGLedqxKIV0dY+gAjjCJW1nGyMQLG5QsJkQ1utazD/KP4kelfGKzScpWhJlcGw1+k9BOy8I64N
 6XfyGNQhOUboSklqKRJuDvPBARImbncMFl/B7iuJ87IR0odkivB0+Fhrx7/GLuXW064e6zwbInz
 nLQWluZIfKqQvpeY40YaFR+gjBHtUDrDXbdL7j+CVxsM3irTHVoELhFB9ksn3FJd5aOkmM/sTZ/
 xRzrr0T4dsswI6NFKveIHDJDKpXQvikm1RP/DfNhYT0yKXlEvpGaUJYRk/ZN1gaDFcBqUzJdVUH
 meKJ9HFKvd28wPuFAi27Au+u7zspqoHn4AhXL5B99DS75aRhfP88Z2V2QrXdZUopzD7dIa2jhhb
 ZApr/cSzvsHe8UbVfZQ==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bd72b4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=rP4LS0jab8kgWfQMVEcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200130

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
index dad02f7f90f1..1054f9bd107f 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1522,6 +1522,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 				       entries[i - 1].pfn, i, entries[i - 1].writable);
 		if (rc)
 			return rc;
+		if (!sg->parent)
+			return -EAGAIN;
 	}
 
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index e9cac6dce48b..6e490735265e 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1163,6 +1163,7 @@ struct gmap_protect_asce_top_level {
 static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 						struct gmap_protect_asce_top_level *context)
 {
+	struct gmap *parent;
 	int rc, i;
 
 	guard(write_lock)(&sg->kvm->mmu_lock);
@@ -1170,7 +1171,12 @@ static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, s
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
@@ -1253,6 +1259,9 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
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

