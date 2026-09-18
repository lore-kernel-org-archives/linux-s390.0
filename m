Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688F501288;
	Fri, 18 Sep 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744184; cv=none; b=R7s+j1OEVU4AyUX04aTUEdqH9hB92QjvJIigT+JCkjq/UCTd2AtwxW9AIx2+YU7505Id2sw4SPrSK/xwS1RWkTvQvl3uDhzfaNEAXtequ72lN/1ayjlfWE7ZcLwL5jWDWEYKDdRlKcUqViidUwJqkqOipNVcsYSWN6uTcFNDTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744184; c=relaxed/simple;
	bh=hCe95FF+seVRSwZ1P13haw5HXwc9uZ9Aj1DI3j5vaGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHai9oGuoZ42p5sOIfs/6R+WLqx6QDNeJXxAeJ5oP7yFD1jDcPfZhWhOsEVmCbywsE76Q+CL/4Ck3uv70TxwCXa5Bilt0W7aZ25xd3bxtUzRUt02SZIS8AJARnumYQgQLSsGErqt1X4U9l+bO0CsM/SNsRbqnQhufTuIJ+Dw/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b9AKBerN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b9AKBerN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVdIf1235847;
	Fri, 18 Sep 2026 15:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PptSfh
	joTnhSmgC0hHjVcEuJMv6Z+IU9jOXNx4Stk38=; b=b9AKBerNzPv7/Vn3Sjdxfg
	Sv/AcNLoJHZqEbjo6NEpDeqp9aT604ZZuhCpJ+whdXjV7jkKwmXGlH0N2G65FxeJ
	3xqYJhySW2/TA/wFw/j/dO4/q1TII/oHY1E3tHRnesciYBHI4ITANA4+kPl4BoJ/
	fm5m8ZUISn5XiKw0fIPYKQxYv7ZBJU7oXE3fNzB8JEPvT4esGAZyw1otUBJPQQTO
	4ZXPF/FuDGajQLDW1cP4o8BqiqkHAlXBWDuMnO/nvEJ3ZBVbYB51djk6xX9ANgzW
	QGSg8mPS/pZr3R5HoQ362jbfhiJtbOup8ZL7Wlv47iQsfserpRYRIyPoRNzOgo8A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j8gem-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO9ge771962;
	Fri, 18 Sep 2026 15:09:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffvrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9SLb47120788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E6E720040;
	Fri, 18 Sep 2026 15:09:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09CCC2004B;
	Fri, 18 Sep 2026 15:09:28 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:27 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:26 +0200
Subject: [PATCH v7 09/21] KVM: s390: vsie: Replace radix_tree with xarray
 addr_to_page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-9-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4178;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=hCe95FF+seVRSwZ1P13haw5HXwc9uZ9Aj1DI3j5vaGI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxRzah1eHlQ6v9/WNmi1f6bQSR1TF+85215ssL9o0
 fE+pImno5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIlsjGf4Hy4UcS1IZhXnuVeV
 fk52vD1HnZTXd069+T5HgDk2pX1NCMM/e7MzHSYsl9IceHlFnvrbbvqxr23jtyutvl1dV6Lv64l
 xAwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX09Nf0z9nfWPv
 t8zcmaF/+p2M6t50GBiDvFll8zMSB91DmhlI4NKVDkDA8piUOVj23FbacnLY/yYdEJwLU3Ncvv8
 WG+P09EpiyRkjMk1fces3Quvhj7EBzyNkmczvAbUyvUHXqy0hinIQ1VVsyUQwONlnh6Rg6h7Acj
 cxzUXpugSW9lpPHM9ZpXBB/xtUxmKizZbDswTLH72eJp9jLPO3noGGkpS8Yb3MT59PY38dMEwvK
 IDHMEzRC7T8biXUw01R8tHiZCVzU40naVh8QkZQZeNoNs+QOrKxkRABcsyvhHatsLakaYbdOKc4
 W1HunbYlanhp+ppuobXB77LtcIUb7vY1WVMad55E0adEFAoPvJ19WWsNpxeBQHGuPvMORP+rpVp
 AaA33BSrqx2GfZ3sMvjfSO4PJwNAVKlWpzhzoPDzp+NZvQqZTKsLIb70TqWpTOw2Bn57TBby4Ps
 uGeKoWKmZaBp8z92bXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXzWI1XDRCzqeR
 PCSo+Xdox7yxCZ+84yXHMyowEtHGU03lNOXoTZuM0KAodhpbTq3F0whjsPiXPKKaqSN63IitY7Y
 qXS7oB5rZaA0hH/mvoBN/IkHHBWth4Y=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad542d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JYDRXDsdSH5mXaOJs2kDp1oHfm-Q2IrY
X-Proofpoint-GUID: NpO1cd3U_rrCQ6jM1PIbSHFbgP7Tw7Gu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

The underlying implementation of radix_tree is xarray since v4.20.
Changing to the xarray API directly relaxes some of the locking
obligations and provides more symmetry with the next vsie changes in
the series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  2 +-
 arch/s390/kvm/s390/vsie.c             | 40 ++++++++++++++---------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 6fdac144ca3a..82bfcc2bec74 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -575,7 +575,7 @@ struct vsie_page;
 
 struct kvm_s390_vsie {
 	struct mutex mutex;
-	struct radix_tree_root addr_to_page;
+	struct xarray addr_to_page;
 	int page_count;
 	int next;
 	struct vsie_page *pages[KVM_MAX_VCPUS];
diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index e7005bade757..75676f493ab2 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -56,8 +56,7 @@ struct vsie_page {
 	gpa_t sdnx_gpa;				/* 0x0250 */
 	/*
 	 * guest address of the original SCB. Remains set for free vsie
-	 * pages, so we can properly look them up in our addr_to_page
-	 * radix tree.
+	 * pages, so we can properly look them up in our addr_to_page map.
 	 */
 	gpa_t scb_gpa;				/* 0x0258 */
 	/* the shadow gmap in use by the vsie_page */
@@ -1532,19 +1531,15 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	struct vsie_page *vsie_page;
 	int nr_vcpus;
 
-	rcu_read_lock();
-	vsie_page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
-	rcu_read_unlock();
-	if (vsie_page) {
-		if (try_get_vsie_page(vsie_page)) {
-			if (vsie_page->scb_gpa == addr)
-				return vsie_page;
-			/*
-			 * We raced with someone reusing + putting this vsie
-			 * page before we grabbed it.
-			 */
-			put_vsie_page(vsie_page);
-		}
+	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
+	if (vsie_page && try_get_vsie_page(vsie_page)) {
+		if (vsie_page->scb_gpa == addr)
+			return vsie_page;
+		/*
+		 * We raced with someone reusing + putting this vsie
+		 * page before we grabbed it.
+		 */
+		put_vsie_page(vsie_page);
 	}
 
 	/*
@@ -1573,15 +1568,15 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
 		if (vsie_page->scb_gpa != ULONG_MAX)
-			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
+			xa_erase(&kvm->arch.vsie.addr_to_page,
+				 vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
 		/* Mark it as invalid until it resides in the tree. */
 		vsie_page->scb_gpa = ULONG_MAX;
 	}
 
 	/* Double use of the same address or allocation failure. */
-	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT,
-			      vsie_page)) {
+	if (xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vsie_page,
+		      GFP_KERNEL_ACCOUNT)) {
 		put_vsie_page(vsie_page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
@@ -1660,7 +1655,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 void kvm_s390_vsie_init(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.vsie.mutex);
-	INIT_RADIX_TREE(&kvm->arch.vsie.addr_to_page, GFP_KERNEL_ACCOUNT);
+	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
 }
 
 /* Destroy the vsie data structures. To be called when a vm is destroyed. */
@@ -1676,12 +1671,9 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 			if (vsie_page->gmap_cache.gmap)
 				release_gmap_shadow(vsie_page);
 		kvm->arch.vsie.pages[i] = NULL;
-		/* free the radix tree entry */
-		if (vsie_page->scb_gpa != ULONG_MAX)
-			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
 		free_vsie_page(vsie_page);
 	}
+	xa_destroy(&kvm->arch.vsie.addr_to_page);
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 }

-- 
2.55.0

