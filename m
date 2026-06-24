Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462142F5487;
	Wed, 24 Jun 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299982; cv=none; b=PR5s+pgd+DNzfZ74hgtMsgTbgOdjVqYHSkBPfvL9YWsb1DZy+WZ9ChhxvVMtQJUpmE84KlvUWOXxzkW2FjNXc7WP3Wb87IZOUE9ATi3Iml7UmsI0zNHLzoRYCrRh9lY0EuugZG2P2SEb+lHmJvzYEcO0ZATvN+HlZ90YGLmCOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299982; c=relaxed/simple;
	bh=TBtvbd6pdlui7oeUh6QlHk/22zouvsEuZ4sepNywB2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKUnhI3E7VgqQ+1lvxkPiuNDtVL+ol6rnEdEj76y3/6DI/MMNCs+tR2NuEoHlO/54xX4QKBNltoTZ/R7SLd05t4k1ZqCenwGRyGH10xiAOsLmi4a0YfPSn83mL3dxsNxQ4cbFSseVXtNYTR0O7saJ+tK6qcQb+cZ2MWVKhdbNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HqOWM9xz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HqOWM9xz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmO9V550310;
	Wed, 24 Jun 2026 11:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=srZW1/IYNBlS9Weko
	/RHk+OYA+pIUiPlgeHpYYubb54=; b=HqOWM9xzl1EmlzWQmdhx/XEq3rqa91z+b
	4oPvet6fCt/pq+e9ZrJ0llmtNLPpCBgfndh10qutlII9QwjYPyU9NM5TmJbVNpDa
	xgTUDLZLHACdOaiTOv+PsoPg80YTm7x0NKbu7bxZymVQGNrZcSvNYzO3B0QcHhT7
	Bbi5/phdCY1UnmPaN8+xJFbP731XKp6nbIUDHKC+AXFcN+wThNpZ/lOmMLiMXfcF
	Wk3JuGkow8e+DqzZQkT0r3RO9ZrIllRPONhZuL0aAq1l/UhxIIeFsQywO9Vobjmm
	Uoc+WnTEHhCKl74AcGAQEQU3MPdm+EzkWY3YzvVbGHHO+koi54hzw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gkna5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4hou001561;
	Wed, 24 Jun 2026 11:19:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k88b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJV9C26149330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78D8020040;
	Wed, 24 Jun 2026 11:19:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EEA52004D;
	Wed, 24 Jun 2026 11:19:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 12/12] KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits()
Date: Wed, 24 Jun 2026 13:19:28 +0200
Message-ID: <20260624111928.144283-13-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3bbd4a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=xmMRMRw_lv4QeeJnpVYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX4z0hEXgjwWRj
 PXbJw0Qz+aSug4akWDiOhQmVrRt+dkzaKF4QyHG4p26zWGbFRlaUmZuyHjS+egbV/ARb1uD4aJZ
 iuceys2P6J1l/ZpIe6wcZF/F7fFjST3Q5TW5L3tJMna58XZwfs91pxtPGQXhrLyeNPU3g0Di/5B
 BCxObZIDJSDRLIHwBzlP0XW74McbB7nCmFPatRQDs+tWhUdvjF6+L6GruswE9rTXEYG8RZADd7j
 2HQXqJAgoeApEYsDixaEEeD8r9Mq/8+N3jyKm58Z06Lo3KOx9gWS9RPHhy7kuOPSj5Ag8Ail6id
 MDnIk7qaRS020+p+sri5iEKbcbq/tWRUM1Raec2j0K4NfjHyQNgE+yFH+tSwP94XSSJg0NCspy0
 +UdJEBYML3CWPkiz3EmJEMiuYFQ99Q==
X-Proofpoint-GUID: yf7EWx1S26Z4zrwErG8_DCjO5Ydk-CGm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX5pBvp5ZS3fBz
 uViCcTc6aC2IjbFgEDo1KkVNilv2IrcJokSBq2TwAnC1h9UrnT5/tNnDsYicTU8BvJe3qioImwc
 842Sh374MsCIL0UtDKiI/BlXlADFYWo=
X-Proofpoint-ORIG-GUID: yf7EWx1S26Z4zrwErG8_DCjO5Ydk-CGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240094

If the allocation of the bits array failed, kvm_s390_set_cmma_bits()
would return 0 instead of an error code.

Rework the function to use the __free() macros and thus simplify the
code flow; when the above mentioned allocation fails, simply return
-ENOMEM.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-10-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9ad6bd4edbce..3b26c909ad0f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2313,8 +2313,8 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 				  const struct kvm_s390_cmma_log *args)
 {
-	struct kvm_s390_mmu_cache *mc;
-	u8 *bits = NULL;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	u8 *bits __free(kvfree) = NULL;
 	int r = 0;
 
 	if (!kvm->arch.use_cmma)
@@ -2334,18 +2334,16 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 		return -ENOMEM;
 	bits = vmalloc(array_size(sizeof(*bits), args->count));
 	if (!bits)
-		goto out;
+		return -ENOMEM;
 
 	r = copy_from_user(bits, (void __user *)args->values, args->count);
-	if (r) {
-		r = -EFAULT;
-		goto out;
-	}
+	if (r)
+		return -EFAULT;
 
 	do {
 		r = kvm_s390_mmu_cache_topup(mc);
 		if (r)
-			break;
+			return r;
 		scoped_guard(read_lock, &kvm->mmu_lock) {
 			r = dat_set_cmma_bits(mc, kvm->arch.gmap->asce, args->start_gfn,
 					      args->count, args->mask, bits);
@@ -2353,9 +2351,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 	} while (r == -ENOMEM);
 
 	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
-out:
-	kvm_s390_free_mmu_cache(mc);
-	vfree(bits);
+
 	return r;
 }
 
-- 
2.54.0

