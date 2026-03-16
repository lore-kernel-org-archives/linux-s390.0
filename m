Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BA33E379;
	Mon, 16 Mar 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684270; cv=none; b=T8RMNhbqdMRC1MI0SAGt4lgpgRDNQ/Uyoiw8cqb/CK02m3+AYtuy3HJh4SgrptcBi/uNJmWACocCpHiwCgCzUM/Qhdz6JOxGIQFGr+cIyFBQBRg7jqEF4xA35Dyev0F86UQezZGR2eQEZulhDalD6wOIyVJ1Bi7N2dSV0Yyh6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684270; c=relaxed/simple;
	bh=96nnvuqMXUa4dBToyjoYOI6pQJnGlJbosromeRQtODM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggoRKRa19PJiaobNM1f/8QO2y7LDfnFOT58cicZtnKD6Lp0tHj/n9Ec5H0sV5cjr3j3nRUJwcAWfBmoaJohktz0As0le1+smJ9YNm194lmRN10fsgLa/S5pPiu4I3c7Yx2Mo+fe3fyGTDIcMz6S1u7lTek90tChpYAHFrPC5Dbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LOPaMN7I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LOPaMN7I"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GGwuQe1290637;
	Mon, 16 Mar 2026 18:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+GagIJWS08fdvP4FO
	bFTOhHw/N35xyExW7gmaXKopb0=; b=LOPaMN7I836Y8Lc1WBjB8SwLnF7dMAu+u
	Xe8FqWFsSvgzfHUOPzzcxbr13jKZKQVn77XoAJg0i9h6rO6Mc0A2iIltQtGvY2HJ
	SVxv3wro0Z+GDDSTDqVqs43ZboD/wn1IE7T5s77Jm7hkeOmUxI5UtTN9IaFJwmMs
	oeEc08Ese5JCEU0WHNFXLzqwW2j/eFwz3kzx8NjewG7bO1A/sIApHP24i0gGkDh8
	FDG6+gRsK4hRGdeKfIQNMDwACAb7J5iXI8M7DPB9uZr5FqPFjwZtQSk/N+xV7hV5
	T4XvMBzepk+B3XKzJ2h+5kGgM2694UZBBJU8kQ7NDTvCwBgrYtM4Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau8r3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEjFtZ004581;
	Mon, 16 Mar 2026 18:04:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s5xx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4Lpq28705218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E9192004B;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F12C2004D;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 07/10] KVM: s390: Use gpa_t and gva_t in gaccess files
Date: Mon, 16 Mar 2026 16:23:54 +0000
Message-ID: <20260316180310.17765-8-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316180310.17765-1-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX89823DvhCQ0t
 FLcD8b4MADAjHTxg6El27I0UQiWNh1yI0XPVnEGCJl7SeVs+xX2gOBPjRfdk7tlJ27bggZAaiwd
 rR1c10Yo7eU256FwaCIy+Y0trqRLUNUruNMOPR+mTwVlPzNmdJvAomnjHf72nuJLmxHZCKU9QbB
 LEIv+OqOLUb4m1eE9EpRg2M1g85uTrm1mkslYR3Qu31G6PD08tjuuOsAFUoL/yuJJ8RmpassQnW
 r5ESlW/A6tqxDGX13W+AHe/yYVFYZYoY1/I6mSHSewQox51hVpfLGbmCHT8tKxPwDd9IBvM8dGz
 AVRDZnGfX5DEoiSey5ZawZgX2G4UDQBjgU8oV0GRiUJ0uppQA5pH/oOHR9zjyUS1zK/G+4Z5zkT
 KNRnFq89dYbyIMq5jMiEmBojQso7FNwl9mpm78JybX6tKcTUx74UgxJMy3BG6W2KI4eQudFAD/H
 +rA+Kh7Tm+OSi980e7w==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b8462a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UUohbZ3EcX_Z-pxAeXsA:9
X-Proofpoint-ORIG-GUID: 9fu4Pg4axj591FqpKktnNl0r2bEl06fc
X-Proofpoint-GUID: 9fu4Pg4axj591FqpKktnNl0r2bEl06fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160139

A lot of addresses are being passed around as u64 or unsigned long
instead of gpa_t and gva_t. Some of the variables are already called
gva or gpa anyway.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 20 ++++++++++----------
 arch/s390/kvm/gaccess.h |  3 +--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 7275854ee68e..b2e83f6e16ab 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -441,7 +441,7 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 	return 0;
 }
 
-static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
+static int deref_table(struct kvm *kvm, gpa_t gpa, unsigned long *val)
 {
 	return kvm_read_guest(kvm, gpa, val, sizeof(*val));
 }
@@ -467,8 +467,8 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  *	      the returned value is the program interruption code as defined
  *	      by the architecture
  */
-static unsigned long guest_translate_gva(struct kvm_vcpu *vcpu, unsigned long gva,
-					 unsigned long *gpa, const union asce asce,
+static unsigned long guest_translate_gva(struct kvm_vcpu *vcpu, gva_t gva,
+					 gpa_t *gpa, const union asce asce,
 					 enum gacc_mode mode, enum prot_type *prot)
 {
 	union vaddress vaddr = {.addr = gva};
@@ -477,8 +477,8 @@ static unsigned long guest_translate_gva(struct kvm_vcpu *vcpu, unsigned long gv
 	int dat_protection = 0;
 	int iep_protection = 0;
 	union ctlreg0 ctlreg0;
-	unsigned long ptr;
 	int edat1, edat2, iep;
+	gpa_t ptr;
 
 	ctlreg0.val = vcpu->arch.sie_block->gcr[0];
 	edat1 = ctlreg0.edat && test_kvm_facility(vcpu->kvm, 8);
@@ -772,7 +772,7 @@ static int vcpu_check_access_key_gpa(struct kvm_vcpu *vcpu, u8 access_key,
  *		  be used to inject an exception into the guest.
  */
 static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
-			       unsigned long *gpas, unsigned long len,
+			       gpa_t *gpas, unsigned long len,
 			       const union asce asce, enum gacc_mode mode,
 			       u8 access_key)
 {
@@ -781,7 +781,7 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 	unsigned int fragment_len;
 	int lap_enabled, rc = 0;
 	enum prot_type prot;
-	unsigned long gpa;
+	gpa_t gpa;
 
 	lap_enabled = low_address_protection_enabled(vcpu, asce);
 	while (min(PAGE_SIZE - offset, len) > 0) {
@@ -932,11 +932,11 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
 	unsigned long nr_pages, idx;
-	unsigned long gpa_array[2];
 	unsigned int fragment_len;
-	unsigned long *gpas;
 	enum prot_type prot;
+	gpa_t gpa_array[2];
 	int need_ipte_lock;
+	gpa_t *gpas;
 	union asce asce;
 	bool try_storage_prot_override;
 	bool try_fetch_prot_override;
@@ -1182,7 +1182,7 @@ int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len, union kvm_s3
  * has to take care of this.
  */
 int guest_translate_address_with_key(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
-				     unsigned long *gpa, enum gacc_mode mode,
+				     gpa_t *gpa, enum gacc_mode mode,
 				     u8 access_key)
 {
 	union asce asce;
@@ -1282,9 +1282,9 @@ static int walk_guest_tables(struct gmap *sg, unsigned long saddr, struct pgtwal
 	struct guest_fault *entries;
 	union dat_table_entry table;
 	union vaddress vaddr;
-	unsigned long ptr;
 	struct kvm *kvm;
 	union asce asce;
+	gpa_t ptr;
 	int rc;
 
 	if (!parent)
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 086da7b040b5..f23dc0729649 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -199,8 +199,7 @@ enum gacc_mode {
 };
 
 int guest_translate_address_with_key(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
-				     unsigned long *gpa, enum gacc_mode mode,
-				     u8 access_key);
+				     gpa_t *gpa, enum gacc_mode mode, u8 access_key);
 
 int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 		    unsigned long length, enum gacc_mode mode, u8 access_key);
-- 
2.51.0

