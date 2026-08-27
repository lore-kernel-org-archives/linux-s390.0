Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C3489866;
	Thu, 27 Aug 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845997; cv=none; b=h7ASgMTaC7t6kQ4Vjx65MeyvwXmDc0BROzOny2U/aK651aFwRV2tGtF2D8i4WFj1i9TwFQmfOqP2czel/SK/4H5xIPzk/ZhWR2555eYkcx5gwS8EvxbWTkQQvH8kf20jPwZyHN6JivDdaZt7VSjPUY2wSnNBwHbh7kUqadg4HZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845997; c=relaxed/simple;
	bh=hCe95FF+seVRSwZ1P13haw5HXwc9uZ9Aj1DI3j5vaGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhoqx/LnGB1vWUpJX7tUHM9qa+7bGmBKhTEgY9ynoiWWGf9mTtEymMlvnHDz+s/FWp3kv4KZ5AUqOjCtGvNT7VYI/uDLAdvAF+be6Y/dNrHWUyc9mTEd34iVVb11CbokNoiNZ2Y3I3MIdFJ0l9qEU3I2w/G4NddKdfDhoshSQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ei5jLXSz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ei5jLXSz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5FC53409626;
	Thu, 27 Aug 2026 15:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PptSfh
	joTnhSmgC0hHjVcEuJMv6Z+IU9jOXNx4Stk38=; b=Ei5jLXSz6Y3bvUZz9jX29G
	KHctOgB+cxu9b2A/s8Z5GZZ3DI9QkwrqmAcrk20NGDLj+51rW7psoRJWqas3ilQx
	jsC2BpzCXa511vRO85gmQMMwEpjqCKyRNjii1twEj5629PmkoUWa1AxpPR876crx
	KWXlfrchI8VZZFEPUHGhKuxy78IeIIkfRXOrBCJaauNRCR0IDKC8Z+zZWj3QCXjF
	V1FuKPokRDCSHOwwPjUL60lpqdsdyaHEYLf6sfwiTdasF3jzsZksfwqGh+iijrc1
	1/Lh3SGkscWgjJAVUcTvXo4EDzIrWurjOiu0FMCnpTsQcwn51g6ru+ic+ONViwiA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxp0xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfjFT019722;
	Thu, 27 Aug 2026 15:53:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhgts6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr3T941353626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30C342004B;
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77AB420040;
	Thu, 27 Aug 2026 15:53:00 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:00 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:49 +0200
Subject: [PATCH v6 09/21] KVM: s390: vsie: Replace radix_tree with xarray
 addr_to_page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-9-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoMva1tdUtp045Zg97s4/Y27rrzf3dfjrMno3ddbJ
 /IvzfdpRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABOJ4GFkeF3OcVjxWsSE9AnP
 8+M3vD5fsfr/IiUHMYUA9pReB+03JYwMi9NSc89F68yfueFc+I+HWdXlbvGqQgdvivXZdF5ZsOE
 9AwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX8hOFjlSaZL6c
 Vot0//ZhNwYO21kO48RyiE49pIu7zwbbe67D3qTx6uidJWU0j6hfZH8GM8oqew4Vt7x6NfCdTlK
 HufHD4nDPOFshxB4ZgyC3/Gp/qIzs+w=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a905d67 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 647TNIh2GkI6ZBanhMOB2ipN2cV3WWBh
X-Proofpoint-GUID: wRC8LguHu_6XIJI0cCv9CSq8c-tUxTbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXyag2j4uSY+AJ
 I8KP/Cd4UxqXtbH2ngQbvhjX3unmpid+GUADoPVTx8iumSdYiCOFDtbuxPgJnpUWIO19we+Vcyl
 0YYkP+jcHssan9YyF+5lw3sOGzsMGSEsPLabmIHFB3bn9GIfOqNcM2YHitMNwB+VgDUA3qD0qx+
 Ve6r/jr3gSN31YLHylUx37QrMIy2dHp3csp2U9QPcHxQtJLOi92GXLxUI5ptiKNlNpZO8p+AswS
 OoUy5p6PP/LxrhT4m3SaQzPyz5WKAggRKH5SaXQ2HgMwNAJ37zKdKXg2r9q9Rq7fRDLQP2IGhDW
 tPUOTnoOHFB7QNa+S0CiUM0pUZteNK2yqZk2IARJcC40DU4mG3hBBlCB4BJnPR+TN3JG7hWvhbd
 UvEq0OFLiJ/PQGaEeu3hbYr070wzn4jigddmr4yLlp8Gtv5sH+a3AQ+fzlLLRdyfxVTMSxSJIix
 ZvzO+blTQb8OC8sqW+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270131

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

