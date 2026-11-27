Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791874;
	b=UX3VSxMX/y7twX+1ACTPWBexv32DyVNXIgtD24AE7RfxUpITM0W9qZzcCJMCNJSHBFtb
	 TiIxSPoGkKItX3fGvshOIeiUL4FSAJDFTtn04bvRv6Ve5eEkLXQo0g2hlOEdJTAHNH63p
	 U7DUQe6UN1+kEW+lHwHwO3aRw62SZh+Mdu9DNWmkHRTCvh0dL3rXjc9L2r4bYYfYb0hPk
	 gl4PU9dwOSex9gJzwifiwhLzOoFJUe4XCwdjIAIWYQf9zbH/U/DWFiPliNyJ6XSi1nYBK
	 SsJ3p+GXGpKhuJfe/MZa/RR4Sh4UhqzLRm70XRtdqmdCDBuvKoSmH7H7kloIVF2r1Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791874;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NxE0EMxWzUvYkoExlX2Z1rSYBAgS2KR3NAqH0XrBAos=;
	b=1qfwx8d8Z+v9QTGQ1uGWSsHKIT8CT9VNZWVMfvGXSelH9QjCJvmY1t8WrDlcSyXknAEz
	 EWYSuWvE4YvAZ2M2Vd+pc2oq6I1EfolGgSiL91qlOReg931yvwfYdqkfE9Y8snhnjmOPx
	 8owBl4tND6iBVZbglJTigu2Lpz1v5fbMm/3QQ3aE5ImclToLJ88/ugoe6y/zCJAiclT4a
	 uug01AshTNsbiXIr9buTLcZNNJ8Z2zVk+MZimjLMoXprwKz6ne/Y0CeGB2nwdNiH15rsD
	 m+6CAHco69j4IAbym8c2kA3wxEqpl2+gG6uolWLcHLk7l6Q6V5ckZtCVHOc83OPf4TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XY8Ll6Vc;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B5606A31E;
	Fri, 27 Nov 2026 15:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6B5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XY8Ll6Vc
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4UQs3419219;
	Fri, 27 Nov 2026 15:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NxE0EMxWzUvYkoExl
	X2Z1rSYBAgS2KR3NAqH0XrBAos=; b=XY8Ll6VcDEvVeiHvJpgVUG3achKgh9M22
	M5k4dv/j41/48C+goa9+Hv+uIUbTVk6joKTnY9bUn584Qqi4G2KP98Lo0RyzdyfO
	kIH89PUZNVBCmnahB3D+erVvorfwUWvURbwlSYVDkhf70+3psFzowg5eUiP92rxb
	mCBHBCxmLZrzUU1JYZUzOaej1y43RCJfHAVLwp2Yv0TLc668/3UmrTRpkPdqrry7
	jRL+5J0kVrzpwAl4OuSJsVORt9ST0MPlVs3/MzG2K4Njro81xXOKzW/n518DjjY6
	XNvO2W8ZbELwU0yGHBe2RXY4sfwaDTJExOMdNRKN9WHVM73vj+1vw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fapd62-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4GsJ3892982;
	Fri, 27 Nov 2026 15:04:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6uccu24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4GeC49742324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE2E20065;
	Fri, 27 Nov 2026 15:04:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34F3520040;
	Fri, 27 Nov 2026 15:04:15 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 03/12] KVM: s390: Introduce gmap_enable_cmm()
Date: Fri, 27 Nov 2026 16:04:02 +0100
Message-ID: <20261127150411.221072-4-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXxbPf7vETh1Er
 /yaDO39fdqaX5JldY7I4003sIDECAu81JTCM3mf5s8zrybymh7TVH9yltAM/YYKatKtTd2zBWuz
 3PABkvAYaDtLNJJij1sK3vyktGLZYRH5IxrEeXrLDBy+YEg5qQjACpSMcW6b/KGx6f4x+N1Ahwj
 XhkKsvEC/x3Sg1MlsC8WU/vLUf6rOam3p1xKLCXylVcsCgdYW9oMJrThAsXlPbRqKVq57Wvx0ow
 tOK+WTtuQK1Da19TJD6spOf4bsbtiogvAPvqLtSfzKIvSg78XhhDbeeaEW1yrnQuD+V5vU84m+N
 RcTYUXG9yHikB5qXwQKmQWS/FfbHRovw1z1DLwuP6EEK3peNoatV4mlHWAg0fr46LYOXpatNOO4
 AOnxFNY4x4MOrx82DWa9MBVAWp5SzdTCE4GRoyJPWMPqLhePZ9rOTzEi/OC4H1tgpKNXqOoNKUX
 Qs76DWIZ05meWXspo+A==
X-Proofpoint-ORIG-GUID: hb_DxDxpy5fNBSaNCLYRCxn16KtGwbwo
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b099bf5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RYenmbwOtGmHXC-y7nAA:9
X-Proofpoint-GUID: hb_DxDxpy5fNBSaNCLYRCxn16KtGwbwo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX6Pn85YWuNdTR
 C2yy6NFVg0iFIV05toupfokJJ/pam9M7Jz/CoymSG7cL4dZ0GBAtSsxdiY5t+MVNf1uIDSqEVEq
 k/eZzUhL21J+L8NpnQtNs5QAw8tzB9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270058

Introduce gmap_enable_cmm_already_locked() and its locking wrapper
gmap_enable_cmm() to attempt to allocate all page tables of a running
guest. This means that all hugepages will be mapped with 4k pages
regardless of the hpage parameter.

Existing mappings with large pages will be split.

If any memory allocation fails, ignore the error and give up. This is
only a best effort.

Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 48 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gmap/gmap.h | 14 ++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index ef1243ad4e54..c7af1ad9f7c1 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -1527,3 +1527,51 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 	}
 	return new;
 }
+
+#if KVM_S390_MANAGES_S390_GUEST
+/* Bail out for any allocation failure. This is only a best effort to allocate all page tables. */
+void gmap_enable_cmm_already_locked(struct kvm_s390_mmu_cache *mc, struct gmap *gmap)
+{
+	struct kvm_memory_slot *ms;
+	struct kvm_memslots *slots;
+	gfn_t gfn, start, end;
+	union crste *crstep;
+	union pte *ptep;
+	int flags, bkt;
+
+	lockdep_assert_held(&gmap->kvm->srcu);
+	lockdep_assert_held(&gmap->kvm->slots_arch_lock);
+
+	if (uses_cmm(gmap))
+		return;
+
+	set_bit(GMAP_FLAG_USES_CMM, &gmap->flags);
+
+	slots = kvm_memslots(gmap->kvm);
+	if (!slots || kvm_memslots_empty(slots))
+		return;
+
+	if (WARN_ON_ONCE(is_ucontrol(gmap)))
+		return;
+
+	flags = DAT_WALK_ALLOC | DAT_WALK_SPLIT;
+
+	kvm_for_each_memslot(ms, bkt, slots) {
+		start = ALIGN(ms->base_gfn, _PAGE_ENTRIES);
+		end = ALIGN_DOWN(ms->base_gfn + ms->npages, _PAGE_ENTRIES);
+
+		for (gfn = start; gfn < end; gfn += _PAGE_ENTRIES) {
+			if (kvm_s390_mmu_cache_topup(mc))
+				return;
+
+			guard(write_lock)(&gmap->kvm->mmu_lock);
+
+			if (uses_skeys(gmap))
+				flags |= DAT_WALK_USES_SKEYS;
+
+			dat_entry_walk(mc, gfn, gmap->asce, flags, TABLE_TYPE_PAGE_TABLE,
+				       &crstep, &ptep);
+		}
+	}
+}
+#endif /* KVM_S390_MANAGES_S390_GUEST */
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index 8f47f29c89fd..fe96268b6de7 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -102,6 +102,7 @@ void gmap_ucas_unmap(struct gmap *gmap, gfn_t c_gfn, unsigned long count);
 
 #if KVM_S390_MANAGES_S390_GUEST
 int gmap_enable_skeys(struct gmap *gmap);
+void gmap_enable_cmm_already_locked(struct kvm_s390_mmu_cache *mc, struct gmap *gmap);
 #endif /* KVM_S390_MANAGES_S390_GUEST */
 
 int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, bool interruptible);
@@ -345,4 +346,17 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
 	return sg->guest_asce.val == asce.val && sg->edat_level == edat_level;
 }
 
+#if KVM_S390_MANAGES_S390_GUEST
+static inline void gmap_enable_cmm(struct kvm_s390_mmu_cache *mc, struct gmap *gmap)
+{
+	/* CMMA already enabled, nothing to do */
+	if (uses_cmm(gmap))
+		return;
+
+	guard(srcu)(&gmap->kvm->srcu);
+	guard(mutex)(&gmap->kvm->slots_arch_lock);
+
+	gmap_enable_cmm_already_locked(mc, gmap);
+}
+#endif /* KVM_S390_MANAGES_S390_GUEST */
 #endif /* ARCH_KVM_GMAP_GMAP_H */
-- 
2.56.1

