Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8360408614;
	Mon,  3 Aug 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760857; cv=none; b=RqbOt0FXCzAkEEPQ2js2kuGcddx5NaecE9UYGPHt9ntZ2YXijVxbo2FsgkZBnAtfkq8cI738HjqIYgkLh2sbaB1sDDVFup9ucpSc0+cEOXigISUsuSVc/C22IeyxQOLzNenBZeaCPR0jccgcQYP35iyJb/UpnYiTnZ9BK4ehL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760857; c=relaxed/simple;
	bh=KnM1KVGK0kPBQvu6Ryfhsr51MIdNqKkHhP5SbM2+pPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfG1EJkY4MtxbLNhPSc3uWW9a4+nM/37r4bUTH2IHrkQf6WaZoh8T9ZwxcmFh7hOSSAAfIeCr87ipzM0+5NLELwba6Gh0RhfpnHQ27YZdaKYR1b41ySI+hX7JnU++MjBKPyOdI6qvMclCkk3HP1gmtVB5jjIdlJAExiT0wYHzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rhm6slfv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rhm6slfv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CIHmO1939178;
	Mon, 3 Aug 2026 12:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fxrGJO7BUkEjBuJE6
	4dhCca2Om+6ZKwB7ScUtkxDJhU=; b=Rhm6slfvBdQF64yC4wJJgcWVTxCVYH9Ph
	M2Yefs3tmsuiYNYdjK/ZfZBVSyhuzghKxKoZxEXQ241jR/4wpf+aw+cPaxWZM2Rd
	Id70Dnzye5X7UqZ0uQsuzWqufAZiFzl2sk8bOQRkGzsBdJOku2raAb3Wn/cl3AHy
	TZIlHxBfNtfCkq03TWl+DoNNgz0TKOEtaCaQ5X63oqRkcr49g0D43u2XgCu4OGzd
	axLqvNEG4FqZPyuSD3eCWZPyaCqPNNjks4EpbM+YzHpDxTGRWrphX/ivI3iAE0oY
	2PTHiCMpvoFQINoSsopbjMXmpchZjBxX2pXEilbOuzgQ4I04zWbUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgqd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQJH7009771;
	Mon, 3 Aug 2026 12:40:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh59t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CeknE31457648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A00320040;
	Mon,  3 Aug 2026 12:40:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BED0E20043;
	Mon,  3 Aug 2026 12:40:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 10/13] KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
Date: Mon,  3 Aug 2026 14:40:37 +0200
Message-ID: <20260803124040.126471-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX4WP/AzUiHL9o
 sKUbQdVRnHgc761fI+LO2iC//aPyeb27QfhvWs/35s1dMBWo5ePqeeHbl1kXEZyLvIo9GG/MI9x
 mrwJzVwDSKSJGJDPDdypUhfpkJriKA4=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a708c55 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=owYgaZMeOewOGYH0y6gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX70VrFm+MOlko
 XYh+f+qlZn5QWGN9ngUNviFWUzvNRFI3cFsu4N9MroGb7+QXYAqZoFMdHWFyWkg6uV/rBA69V5f
 NLYr/oFmbmcyWvf7YHikJ9T4Z7eukTR4gEnYXAo21TQueub6SySbhsR31n8BRmHvl48mLdx4m7g
 zNEANDV+n4rf2XlswLMQW1RFkFhsQq61l3AZf7G9ePvNbFIfJxELjr4g86kg+CW/E4Bl1wGGN1W
 9m19LezxLwMupS5t1SdNfdB5Lr38ckeeHa2c9eUheTqBMRDhbZj8vmkH1mATzPSgjgsXTCPkPiC
 AW5DIN5NQfsWYHlZ8x0pA2T81EEfHo8ViVxTPN1GciID+SHd8+mXZkOYyhV2cs9oz71vcNqEkxD
 /syHarINBR1hixoevXZQkmPMxwo9M1iok6hQxLaLYvWFZIin/clEbLz+RWzyctNH9uAlPpoHPJ1
 OsZkl/E6ssf+1R3XSqg==
X-Proofpoint-ORIG-GUID: w3K0Ccb5LDz1Nj4dyYkHOk_uqkF2Z5VL
X-Proofpoint-GUID: w3K0Ccb5LDz1Nj4dyYkHOk_uqkF2Z5VL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

The mmu cache is the first thing that is allocated in
kvm_arch_vcpu_create(), but in case of failure it was not freed.

Fix by freeing the mmu cache in case of failure.

Refactor kvm_arch_vcpu_create() to use scope-based cleanup instead of
gotos.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/kvm-s390.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2741ca323ede..9b8a35e7dc82 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3800,21 +3800,21 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	return 0;
 }
 
+DEFINE_FREE(sie_page, struct sie_page *, if (_T) free_page((unsigned long)(_T)))
+
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
-	struct sie_page *sie_page;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	struct sie_page *sie_page __free(sie_page) = NULL;
 	int rc;
 
 	BUILD_BUG_ON(sizeof(struct sie_page) != 4096);
-	vcpu->arch.mc = kvm_s390_new_mmu_cache();
-	if (!vcpu->arch.mc)
+	mc = kvm_s390_new_mmu_cache();
+	if (!mc)
 		return -ENOMEM;
 	sie_page = (struct sie_page *) get_zeroed_page(GFP_KERNEL_ACCOUNT);
-	if (!sie_page) {
-		kvm_s390_free_mmu_cache(vcpu->arch.mc);
-		vcpu->arch.mc = NULL;
+	if (!sie_page)
 		return -ENOMEM;
-	}
 
 	vcpu->arch.sie_block = &sie_page->sie_block;
 	vcpu->arch.sie_block->itdba = virt_to_phys(&sie_page->itdb);
@@ -3856,10 +3856,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_FPRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm)) {
-		rc = -ENOMEM;
 		vcpu->arch.gmap = gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
 		if (!vcpu->arch.gmap)
-			goto out_free_sie_block;
+			return -ENOMEM;
 	}
 
 	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
@@ -3867,22 +3866,19 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_create_vcpu(vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
 
 	rc = kvm_s390_vcpu_setup(vcpu);
-	if (rc)
-		goto out_ucontrol_uninit;
+	if (rc) {
+		if (kvm_is_ucontrol(vcpu->kvm)) {
+			scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock)
+				gmap_remove_child(vcpu->arch.gmap);
+			vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
+		}
+		return rc;
+	}
 
+	vcpu->arch.mc = no_free_ptr(mc);
+	sie_page = NULL;
 	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
 	return 0;
-
-out_ucontrol_uninit:
-	if (kvm_is_ucontrol(vcpu->kvm)) {
-		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
-		gmap_remove_child(vcpu->arch.gmap);
-		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
-		vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
-	}
-out_free_sie_block:
-	free_page((unsigned long)(vcpu->arch.sie_block));
-	return rc;
 }
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
-- 
2.55.0

