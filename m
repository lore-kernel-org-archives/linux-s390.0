Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D040FD9A;
	Tue, 24 Mar 2026 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374206; cv=none; b=brKu036emZIpHmLJ4jraNJsMbJpKnNgA0/WQd7hOAuLQPM6gpj1EPIgslbqEAVKfl8QX4+mIvqcu+sCh1i+YuBKgxM6Ot6VEwc1RI5Ca2kTDsPv4MaLrJBWhddnzvGEQisy9cZxFZUzKpcjuXMgobOXFF6HcrD2NqWfeZCb5dtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374206; c=relaxed/simple;
	bh=LywnmmB1veD9IRuqCGaNQJXejNEdWWcrOxFCfSTG8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo8XqSSzLUCIZW7QO41MB5LHdkdQJWZ8xlWs+AHxqTd3Q3vZStbdSDkdU1DICt7GmEqlg75qD7fO8tY9BvGGK82RniburV2NDUA7YkhTPn5/SlXX0ik7nX9+RDEAcqHxLwVYnXCzKCiG9wAUXdcaN2IjBXD8pQ0alvEYlO/+EaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=abCAboMl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="abCAboMl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OEbKNA3223936;
	Tue, 24 Mar 2026 17:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=la853ipfp+/zOew13
	qvgs29vLW1YDNF0T4uyG2fCJAU=; b=abCAboMl1JrDUiF6HVNKlEiVc3bxuyQeA
	QN5Wwkl8KsMJdy0XcURQxvAN3f6lUNnRWWbYxToQ8yxBd2K9vJV+/g9Zyhezu41I
	upGBRvs8tLqryRcVLlxHEGID2s0od0s3HQZpBKPs3z4I0y/bC5CsfDNN0uyDdIp2
	ICT7hnezxMmkR3BYySMz4mSydMfY0hN7SdecoikQuFIUJShl4dAytD08qnfINtNs
	c9cdwiGLedctZABErDI1H9zf2tWQh1Cd8oJrx8MsMV23KKLpPS/+lacMc74GLz1t
	SLd++8cAnKk+R02HToKyBIaseaIvp+3j/RKg+xvo96GVquLGob4jA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kummb3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFYu23005964;
	Tue, 24 Mar 2026 17:43:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yk701-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHhCVj51446168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2E4120043;
	Tue, 24 Mar 2026 17:43:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C0020040;
	Tue, 24 Mar 2026 17:43:11 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 7/9] KVM: s390: vsie: Fix unshadowing while shadowing
Date: Tue, 24 Mar 2026 18:42:59 +0100
Message-ID: <20260324174301.232921-8-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: Im_QXWuSV8fmVcba3XpL-GAVlnqPMVyO
X-Proofpoint-ORIG-GUID: Im_QXWuSV8fmVcba3XpL-GAVlnqPMVyO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfXzWtDT5sw1Yfi
 7njYnGSCJW2cR0fIPM5FDwm1jV3fU+VeYEyEHA+tZz0GJkk105Se6dvZNl8gfw7DHmHdNhDLUks
 fs0wgD7gtd67G8sVCpj/E/zpuDCy9R3FHVku2a8NG8hu8tVWG5XkvBwQbbK1NMbqCuNdNVkc2MW
 2DZ9wMN8wiBE8dDCeHVDFCgVI57OXPFaddOFAq2oOJ3qse758NqKEo8XHcLEKkUDDNqpWiVyZys
 JL7vRTLa+dRp9K0IaLWTT+0R1ul02qYv+SUuq02LgtMVe3dIsKEz3FHqLKwOpS0ZYZT5WepV3LH
 5LD8wxqDtKFHF5zAmZlcgTeSBm7Soz2lUC+kOfhMr3fFPphIuXsEYW9Z2LK9HJRTwdYDw/pUKeF
 VA4ZqJKq04eR+16Za/UHf+xNyZGNij6xXmeddwJFQSazWlYDgE4jyvwEGcReqcSDR4YZF535ejS
 tmhX/039slSJQzspdZw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2cd35 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rP4LS0jab8kgWfQMVEcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134

If shadowing causes the shadow gmap to get unshadowed, exit early to
prevent an attempt to dereference the parent pointer, which at this
point is NULL.

Opportunistically add some more checks to prevent NULL parents.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c |  5 +++++
 arch/s390/kvm/gmap.c    | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 70703bf866db..0ac2d775d4c0 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1472,6 +1472,9 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		return rc;
 
 	do {
+		/* _gmap_crstep_xchg_atomic() could have unshadowed this shadow gmap */
+		if (!sg->parent)
+			return -EAGAIN;
 		oldcrste = READ_ONCE(*host);
 		newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, f->writable, !p);
 		newcrste.s.fc1.d |= oldcrste.s.fc1.d;
@@ -1526,6 +1529,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 				       entries[i - 1].pfn, i, entries[i - 1].writable);
 		if (rc)
 			return rc;
+		if (!sg->parent)
+			return -EAGAIN;
 	}
 
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 03e15b5e0b9a..fb9cc40e919c 100644
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

