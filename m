Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674F44CAC6;
	Wed, 26 Aug 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756732; cv=none; b=C4H5cSMCy6dzHzPmr1BOKJIaSg2WK6Npsyx7nkCHL3az2ExWuNaLFqA/yuP+LVP5zYD/JY1VA859CQcP7HjQ2Ut9mgaCU99euZX2E3ReFjVRdIxL5c784dH3rRMPhaJAvkfymnpjfrCBntn/bq6HcIupvOFtCrebt+MYCgWdoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756732; c=relaxed/simple;
	bh=hCe95FF+seVRSwZ1P13haw5HXwc9uZ9Aj1DI3j5vaGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq2A7NkqP+TdJIBh+DoWVVoSwwzrqhTWB+c2zJcW/OS+57uhVkLlUXxIAJRYfi4Faql+XkJaINbbuwZUtD2lXGzgKyGthyXqrd244ui5+4fXzr2YMEyk3xDRgjFxL5sEazhS50u/7q/dEbp56ipDvImmkT/F6brTW+5Q4TY0g08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKy+iOL3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKy+iOL3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1eKH4099668;
	Wed, 26 Aug 2026 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PptSfh
	joTnhSmgC0hHjVcEuJMv6Z+IU9jOXNx4Stk38=; b=VKy+iOL3LvYAQdvDtlisRS
	GULbCXU5nIWjmfaWHkt6b7La1UBRQjuEyNJVYXQxooyzwD9H1ugqrATXzlI7ldBW
	pnbnr+pfeqQt+LciIJMiwkAzHJNdJXJMBRcFrWAhbidvxmC5nLWKzGLDYSaGWV4z
	RLNdMbLX8d6YARForbIYjjp/RMWKaotlQSZA3fqD6jseyvZMe21T+6IS3a/YQPWB
	U2sYXQCrSRsl0gYYycOIHWu72Zf1ry/YNWHizY0rLtgvXGdN3nFsYUP6DAgyz54E
	yE21Oc+YAKQDM3X9HaynPbDf8GVb75DtISDEbE7y7rwntr5UmVoqqveVEP4KNsSQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyhkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHUi017908;
	Wed, 26 Aug 2026 15:05:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k2k8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5IsJ39977240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF48B20043;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9092A2004E;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:11 +0200
Subject: [PATCH v5 09/21] KVM: s390: vsie: Replace radix_tree with xarray
 addr_to_page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-9-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKsfFUZazv3OJKTX2cZ2tEv00DfHxnM2/QEiD6YbX
 ry5eI5ARykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABPJa2ZkmLDvnIsGQ8upF8eU
 dAucX85IbTm77xb/J59+Qf+inXpt3YwMXx7n7hDlVa6vfc1wauL1W/eOy9Zmb7u/6/oxBqZ3i1g
 bGQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX1fIKhfiJPub5
 Syg+5RfY2GL101yp4BNy2yGw7yqatUGxLl0nvVcLTwkrFOg3Zq1TDEIQk4bGyvfvOoL7Q4+uBIm
 nEBDdVBoYm9xlPAcJ+HU8AQiIpOsJvE=
X-Proofpoint-GUID: khns7zMpw54ftXSE6yoN5Kb3If0tkNeo
X-Proofpoint-ORIG-GUID: tCismRrVgVl3aFGpMMJlqrc9gXGKJ8zN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX2vl6YXTZRcGz
 7qgkbJusuk6Bnpu0YqlLlJVtGf+G3gKRRZMdc/F7snjiIFkDaP0iA3XEfmPTq3cG3FdW59bOBXt
 tJwxRDcrMWgyy1/PucyQz6JECrFjvX25HUq5fe9jDGHhTR0F3C3ev2gYRV6Foggn4KYdtlsn7A8
 iGissUBkHc7OGF1jmjdfiW/iqx2/pJMqwWPoG06CrBRBcNVd9jzfVOQttG9ePREIyX3voJI8a+i
 yduvXm4b8pOFcLkMO/Qtz5PWIsLr/l1Bh9TpHUI3sNkG2gnRVUrK0bIeYgzIc4fC2aHVfBiDpDT
 5zF3KWsfoAGwuFiHDvTAXefCK8MasX3UvutEOgH+b7lO5a/KkzAuKa0caHZCknEOLF7kuqrZOL2
 tf8/8v2SAxh3vH6X/T/d7shM3TvEFGtv6e3UWLc5I+mJbsQ4+9MNdptgqEViKJie/ndBB84bTNw
 /5Q+lU01Du8AljSExyQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f00b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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

