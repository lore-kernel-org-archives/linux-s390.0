Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791878;
	b=5FOLog20MMmp1BuQzirqU/o0pQ/tdq0jPWxVcZVsYNy6Y+Az+i/HSHellh63dRbg1LcQ
	 Z0vQdztiHuuEt5KBgangCMb9wpdBt1xARGsIfN7XN6sZ/MRNaEoOzhOUOFXtUroWOgsMV
	 jNDbe/mQci4Ms/jKPEJlBP7mpWB4tHbPlFSyflJTRKv+YyeJBZjUw+VUoiSK+sx3VkibA
	 t47NwORBUrhy1j/jFMrFU3dPD0xUI9hYcGkPZr/9khROgGbGXuwpoYAJPHRD7O4uw8sgy
	 QTjzg7phnaHLZh2vnkssdwu+h1WdDwJhtwCBfkir7J1kfuXPh02bgGV2WpFYmnWjI1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9seY4if/31KNvW9zimLZIlMhEKe16SP/yflz0ThvMTk=;
	b=Frb/sjI8Zx+o9PHQC4vx9SqPrj5w7J1FQodN8utdimW/9jC+Jt4v5MlHSBA+84eakiQt
	 BNpDMxEeflR4MgnCaNGdwokmF//ci1aY3eKvOSgnnZsCevbvEbiMFScdENIfROv5/U0r8
	 ckxjuLbPa1D4jRUoAlsSHuf1TKJvIjs5fCffbUz5bZZrXmutElglBBbUjXef+ndUQR37D
	 zxqi+jh/iCvBqpfr2EQYa1sVN09B1Lnd8+eYNLvmCkToN9h4wBGVZ1w4ghHOljPyyVdg8
	 D3OoU6VUjV7k6Pe6CQof5wiL8iSa0YnvSWwb9e2xngrrHUNNPivszzEaYi2/ZD6pOqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TsPIascs;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE4606A327;
	Fri, 27 Nov 2026 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFE4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TsPIascs
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4ZBf3266060;
	Fri, 27 Nov 2026 15:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9seY4if/31KNvW9zi
	mLZIlMhEKe16SP/yflz0ThvMTk=; b=TsPIascsxdGPGLYZCLCV6AxNMBTNtyp69
	Ee3RKWKFW00yigpFD0WaEOtHqYabCn09DOTh5r7IVBmytVct6EdO66Afqoo8CMBZ
	2jijqqJiKVtrTvZ7JTNamCdvpTEZu6LVBqRYg+8EVXooZgHruJS2Z1spmTIe1RbG
	cyP/Y8nfz9YG3exmnHI6TLxDqS9WFCRNUFTHmFMOB+8LetVuCeYBu66x2Mh3BBxe
	Gr8yZxw1OGhroML7qryLKN9vLusn6DvsOJRqvJ/RIJ4ObRz5qDV+tfi+OkhG3Azs
	jFxfPLCKhwg8KQY2o/yvwM5q0sCPp6v3uAmml6OyJUh+ybNRGnc6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkxbb1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4Ihh1181012;
	Fri, 27 Nov 2026 15:04:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6rhckpb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4MrN26804572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F2BA20063;
	Fri, 27 Nov 2026 15:04:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 213A52004B;
	Fri, 27 Nov 2026 15:04:21 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:21 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 08/12] KVM: s390: Properly adjust page size before calling _gmap_link()
Date: Fri, 27 Nov 2026 16:04:07 +0100
Message-ID: <20261127150411.221072-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX7uipnMngsSpz
 EeQFF+RZFfJBwg7+soS6lXcEs6NfBejLIBz4zfnV59MjlPcKdWqPGTpKNSJYto8hwSLg9iRqd0d
 KqKx0rxUm0tUfBnNC2cwHpoZdtlTzA3/odTZb9TJ9rD2cswwbnpQm5s+IxBWQEuDogB3tnRjobQ
 vkqV7O6NgXrxE+yr9HDSgX6NBJ3DezpZ+1Rs9BN+mHVO89d+q8gbiqARRLj4yue8haUEpXk6GHi
 LuNDIzu/cBVqGJOSYkjoNhSGge8Foui/+ZnVR9Zy3mD9ZEe7huFhX9Tk8bfOIWP0sLOIjkltzuC
 FKAHRIPmecPAw1q9nSlpeG71oDfXoFPX4uHCPXcTNYCJeLnBXLCnP9HLxJpij2sviuZLTvFVouz
 kEcNYJKlPrRPmXt4BU0fpM+bnIn9363NDfH4UVvP2FXyrKvm8dk5yRKasTEiUX5dhxuk/gHSd8T
 P7qHVsPxKDPozt+ugyg==
X-Proofpoint-ORIG-GUID: DOi1DxYaze1MbnP_BGEinS4xD6Ng0WTJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX5LsxMybfsTT8
 ZuObdY7ULyAMNORV0BVORfYwmr23/OM1dFs5ve0cUHl67kTWgsaOi8fG60vg8PxyTMIsIzpgcXM
 L7C7PKvqWwpU+oY3lVa0KJ0vBKlj624=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b099bfb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=nfh56TxcyHWkIauMi1EA:9
X-Proofpoint-GUID: DOi1DxYaze1MbnP_BGEinS4xD6Ng0WTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

Checking the size of the folio alone is not enough to determine the
maximum allowed page size for a mapping. Multiple vmas with different
permissions could be sharing a single large folio.

Fix by checking the actual size of the userspace mapping if the folio
was large enough, and adjust the size accordingly before attempting to
use large pmds or puds.

This reflects the behaviour on other architectures.

Fixes: 4204067f9982 ("KVM: s390: Add alignment checks for hugepages")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 88 +++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 837815a7dffa..5a40f411bcc1 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -858,22 +858,92 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 	return rc;
 }
 
+/**
+ * gmap_get_userspace_page_size() - Check the actual page size of the mapping
+ * @kvm: the guest
+ * @gfn: the guest address whose page size is to be checked
+ * @slot: the KVM memslot containing @gfn
+ *
+ * Manually walk the userspace page tables to find out the page size.
+ *
+ * This is safe because kvm->mmu_lock is being held; being a (r/w) spinlock,
+ * preemption is disabled while it is being held.
+ * Due to RCU-deferred freeing of page tables, that is enough to guarantee
+ * that the userspace tables won't disappear while being walked.
+ *
+ * Context: kvm->mmu_lock must be held.
+ * Return:
+ * * TABLE_TYPE_REGION3 if userspace is mapping with a large pud,
+ * * TABLE_TYPE_SEGMENT if userspace is mapping with a large pmd,
+ * * TABLE_TYPE_PAGE_TABLE otherwise, including missing mappings.
+ */
+static int gmap_get_userspace_page_size(struct kvm *kvm, gfn_t gfn, struct kvm_memory_slot *slot)
+{
+	hva_t hva;
+	pgd_t pgd;
+	p4d_t p4d;
+	pud_t pud;
+	pmd_t pmd;
+
+	lockdep_assert_held(&kvm->mmu_lock);
+
+	hva = __gfn_to_hva_memslot(slot, gfn);
+
+	pgd = READ_ONCE(*pgd_offset(kvm->mm, hva));
+	if (pgd_none(pgd))
+		return TABLE_TYPE_PAGE_TABLE;
+
+	p4d = READ_ONCE(*p4d_offset(&pgd, hva));
+	if (p4d_none(p4d) || !p4d_present(p4d))
+		return TABLE_TYPE_PAGE_TABLE;
+
+	pud = READ_ONCE(*pud_offset(&p4d, hva));
+	if (pud_none(pud) || !pud_present(pud))
+		return TABLE_TYPE_PAGE_TABLE;
+	if (pud_leaf(pud))
+		return TABLE_TYPE_REGION3;
+
+	pmd = READ_ONCE(*pmd_offset(&pud, hva));
+	if (pmd_none(pmd) || !pmd_present(pmd))
+		return TABLE_TYPE_PAGE_TABLE;
+	if (pmd_leaf(pmd))
+		return TABLE_TYPE_SEGMENT;
+
+	return TABLE_TYPE_PAGE_TABLE;
+}
+
+static int gmap_determine_fault_page_size(struct gmap *gmap, struct guest_fault *f,
+					  struct kvm_memory_slot *slot)
+{
+	unsigned int order;
+	int level;
+
+	if (!f->page)
+		return TABLE_TYPE_PAGE_TABLE;
+
+	order = folio_order(page_folio(f->page));
+	level = TABLE_TYPE_PAGE_TABLE;
+
+	if (order >= get_order(_REGION3_SIZE) && gmap_2g_allowed(gmap, f, slot))
+		level = TABLE_TYPE_REGION3;
+	else if (order >= get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f, slot))
+		level = TABLE_TYPE_SEGMENT;
+
+	if (level == TABLE_TYPE_PAGE_TABLE)
+		return level;
+
+	return min(level, gmap_get_userspace_page_size(gmap->kvm, f->gfn, slot));
+}
+
 int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fault *f,
 	      struct kvm_memory_slot *slot)
 {
-	unsigned int order;
 	int level;
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 
-	level = TABLE_TYPE_PAGE_TABLE;
-	if (f->page) {
-		order = folio_order(page_folio(f->page));
-		if (order >= get_order(_REGION3_SIZE) && gmap_2g_allowed(gmap, f, slot))
-			level = TABLE_TYPE_REGION3;
-		else if (order >= get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f, slot))
-			level = TABLE_TYPE_SEGMENT;
-	}
+	level = gmap_determine_fault_page_size(gmap, f, slot);
+
 	return _gmap_link(mc, gmap, level, f);
 }
 
-- 
2.56.1

