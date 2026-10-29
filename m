Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278855;
	b=lNHw76JwLn6l//XC9Jzeo4rlzskLmejnk8uhjENvStAKY14rea26di2eVnO+b//vptvT
	 De85UIlusaKl/fM0Hmkc02ATg0JUDZ2yw/ryQglSbb/6mArhY0X6S3YL3IB3GQWINDpCY
	 GFcWvXWzQZMutvt1DaDlYxqY44Jw6gEVGgYnIaQ5NH9arbqpoEH29PZ/IeA+65fjWXhAL
	 aFjwcWGA9ag6dWT/UYS5cgx1HR3bFHyMGba5nRgReJvcDJnX1RcZVDhazu8T5bdjwdppb
	 vEuicVZzslgMwiuzwyq6FiVWrSi1KzAF1nOr+xH0GwbnxXsTPYdvkG2WSRNqyb37/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HY/HSRE0pnBowEHOzd7uVi73DZdKs1VQgThRZDXeB3s=;
	b=fq5WxDxUXzn5mFI1DlmSVR/kNJatPO+Gjr2n/9u9fB3HfoZGJsmP1qosreR6JnQcGVVc
	 xnMH4nQbhI/3iEHDObjq8riBWwiclW1lvbaTJC6kIaQO0yJjH0SeInxj18dZQyWZGNc/o
	 wijJgL5h8ZxJsJxjV4E8HJzL/0cmBZwblwR/165r1HVW03oSzKVy3B+rldJoxRxZv2z+A
	 yqlO3b1tka8MYD/dQF5ezYxnhqyhmpc6MxM/oDtWY29OHbP0XFq5VUVGYVyVociaFYOgf
	 twdZzIFnPZj3F/mfc+B3+XeVTzmO5gMxCrP60wK1L0papALVpqOt3NbQG44ayp9Tflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PKzOmQoI;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73593606A31E;
	Thu, 29 Oct 2026 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73593606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PKzOmQoI
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCiG0S2580881;
	Thu, 29 Oct 2026 13:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HY/HSRE0pnBowEHOz
	d7uVi73DZdKs1VQgThRZDXeB3s=; b=PKzOmQoIpjtrCIxR2KWeuxMVi5S1B70fA
	Zq6tSIVpWbC6MdPqBTWxSsaX1YJk66snEVLsEs/0gqfEJJf8W/sY1K+Mubn2fOoj
	MQmwcleLNhaeRk6XfMEKAoxHsnXGmQam2AtYVQL8t8JBF+p5M1F5CWZChIkcOu4J
	1xZjjwNQhqhC4raeTpf0CyaLlgvR+e0uGDUYqmthNBbpDR3Xjk5Ua/s+ra4ewnGE
	MymhiF7jcpDB6kSm17sGIGzX4hridkHwwMAD39+0e5pBZh66kxe1pyblH3fEHuyP
	/zGuMDSM3y7i8Ef3id5+XGnCwpDeHqc2x9IRhcsIzG1COP2By7k7w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbtaa4t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCnsIH3148145;
	Thu, 29 Oct 2026 13:00:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e039v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0kYW51708178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9CC920040;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB4652004E;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 7/7] KVM: s390: Allocate page tables when CMMA is used
Date: Thu, 29 Oct 2026 14:00:44 +0100
Message-ID: <20261029130044.125032-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029130044.125032-1-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX+40yaL6b/eb2
 s34rBaW/nIcG8A5iYMGMq5ztw05liBi0Z+/W6fmfb7rvGEjUOwkOzeqSdfqiegYry5PatKu+WTy
 +PlolAo60fddgr4qDvAKu2SQcSy9yoF0UOm2f0tYQYIxadCa2rmVmm4wEgLLuqg7wOyDqCkkXRA
 VZeu+BLhSSOVz6NRrazPmstcFG4XqhqjEQhsWgvOiHaRiunAA/O+w4pQYaYsilznToT/sTpwsXV
 gYPII12otgmptBlIqg7HPN51xvdsw4G49KRtrKPg08e+NyD1ol5P+Db59sOCZ81TUz0qMGybl2h
 fhj+IJuiKAXqghTmQVxApp5kbEZPxaPCDpun/eAYnmzyCZ/GHgA3Iwgi6zuSnKZ9VtIxrr7Dsha
 iX1AKxKsizU78JGGV31takpjZqqdHEACKwuJRBiTZeUspRfFl7Q6/9bg2xLLin2krr6hJ6QPVEx
 +MkEUvs5B3fLv+HZ9Eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX/uRIjcGupfYz
 NWdj3b12O5xypcz9IqPZtjLCPk40EzFm60eidY3H2wT7bSgD4g8e/0+QdZ17flcyxy3FV5ppm+N
 WJnga+RCfpgrV5gDH4GjGt4gRrr+b2Q=
X-Proofpoint-ORIG-GUID: C3PsemHECvapNslMg9IpnslJzU1a11FT
X-Proofpoint-GUID: C3PsemHECvapNslMg9IpnslJzU1a11FT
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae34384 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=5-3MTohZz_1BHyESM-oA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290049

When ESSA is executed in the guest for the first time, allocate all
page tables and split all existing large page mappings, regardless of
the hpage parameter.

With the page tables present (even if all the entries within are not
present), ESSA will not cause page faults.

Without this fix, ESSA will cause a fault on the first page of each
segment (1M block). If userspace is backing the guest with huge pages
(hugetlbfs or THP), the page fault will be resolved by faulting in the
whole huge page. The result is that at startup the whole guest memory
is faulted in, since the guest will mark all of its memory at boot.

With this fix, no extra guest memory is allocated. This will also
prevent the first page in each segment from being faulted in, regardless
of hugepages.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/priv.c | 8 ++++----
 arch/s390/kvm/s390/s390.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index 856939acf012..f7f49c2338b6 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -1241,14 +1241,14 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
 		/*
 		 * CMMA is enabled in the KVM settings, but is disabled in
-		 * the SIE block and in the mm_context, and we are not doing
-		 * a migration. Enable CMMA in the mm_context.
-		 * Since we need to take a write lock to write to the context
+		 * the SIE block and in the gmap, and we are not doing a
+		 * migration. Enable CMMA in the gmap.
+		 * Since we need to take a mutex to write to the gmap
 		 * to avoid races with storage keys handling, we check if the
 		 * value really needs to be written to; if the value is
 		 * already correct, we do nothing and avoid the lock.
 		 */
-		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
+		gmap_enable_cmm(vcpu->arch.mc, vcpu->arch.gmap);
 		/*
 		 * If we are here, we are supposed to have CMMA enabled in
 		 * the SIE block. Enabling CMMA works on a per-CPU basis,
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 18fb200f854a..23be83c0c0d8 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -2349,6 +2349,8 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 	if (r)
 		return -EFAULT;
 
+	gmap_enable_cmm_already_locked(mc, kvm->arch.gmap);
+
 	do {
 		r = kvm_s390_mmu_cache_topup(mc);
 		if (r)
@@ -2359,8 +2361,6 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 		}
 	} while (r == -ENOMEM);
 
-	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
-
 	return r <= 0 ? r : -EFAULT;
 }
 
-- 
2.56.0

