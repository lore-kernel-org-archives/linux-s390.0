Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CD33A005;
	Mon, 16 Mar 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684269; cv=none; b=Mx4Ne0CJbk0/zH2M7euJPRmiTcBM8H7EzFeB/fQwUdIsMJ9Rs5R7bkXr/9cwCh1fm3F0FXUFpCWnIJQpW2rQMr4ohUrxjicEpBMwH6ipo1ThzsFhAsGfh3xtWTVEmbLVIXLj9H7RrwrsEOGZOOx5n4FqrLKprD7YYbLASkY/BTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684269; c=relaxed/simple;
	bh=vvFDh0UsJLi1RCNYagnxexkpCisI92UCFc2LJ3pPsCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sz86e+84H/YoC/IXAhFH5ejZ2TAlPcW+NyJPO2l3AWC43Abip2qlhHAK2t2Mrr96yf3e/fz0I2bgL4RpZfQ7h1RWn2UCZ8esIIUq/n5ctRaK/sjIiZ4dW8iDt+9rM/t3+LP/kmEuTp4ifjkvEyTpQJUwzSz11L3S81XjJWCrPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XSzjWEFl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSzjWEFl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GABFW73402882;
	Mon, 16 Mar 2026 18:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7d9/cywIRc16ypJZp
	r1lCbDpL1cVf4airbXN1681KaM=; b=XSzjWEFlfrSzuuFlSEC64YS5UkzjdHf4q
	T3z4z/X545BIX3diheLLrLCGEGL3dAJzdWLzsDqi7ZQ83TRz8tMehGZN6yvp9UJI
	8E+HLCAEeUz1NibxQeGTUYe/RxG62HvZqJyeaFhhtrs7MJwPgDrFrjT0xIj4gIDu
	trPQnFJhAGS5I9nPF136pSiszyj20T2bvp2FpB6cUZ/UoCD6eNE55WhvPP3B9vPt
	paYtHzyoRCARDRNkf/mfJLWOReATTYPA+eJlYjYK9iLBwmS2RZiTh0S2ocyeG+3v
	ZadpFBuCQsGTV9L6HY+TZuFhuyDEwPMcdcj8jwVAKmIBQbz5DMAUA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau8r3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEP3iU005380;
	Mon, 16 Mar 2026 18:04:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s5xx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4LpZ49414618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8F5C2004E;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99D9E2004D;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 09/10] KVM: s390: Use gpa_t in pv.c
Date: Mon, 16 Mar 2026 16:23:56 +0000
Message-ID: <20260316180310.17765-10-frankja@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfXw6qmKKsHyWJX
 gEJ5lOKtUv2bhxIVv9p+rc+rA/SUSVJcSKBO9u/ChBLKM76Azsf4ZYXSoPLNlKuCtOc7Lguw3M/
 j8ako1lUvHH+HDN0ZkNEm5lgvW4Zc2o8uwGkujd8rdq5viNrCG8sdYE+F0lqAhde4M45+/+tjBE
 6PRE7OHdqKxdKZhEx3aDmdIqHF6lorYOMLRJWR4kPt8Z4cSJ5LftIlfwRqmAS0Lt0W1Qem5gj/r
 YEEg633MRezNaA1e7xAgNJIT+ktMgtMVu6zmX5EC7QhUb7ulUJ3plwCQCRrtl1jzkQ5M1VYqD+f
 TnvDhIbNeZr8MBVAITNoJfjHr7Y1OTvnzs2MhAaUpOTtvVISMtpowHRVDbKWP5qYmLj1uZN9oJf
 +eCaNVtuS50gUyaA3OK8xh6p0YV2IscJhW9GO9nbX74sSFIbJXXNQiqq1HHomiuEdFurbvTX781
 THYP0OCJtsnK4IgmVCA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b8462a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=WlIdnnGHkEhPYRtFktUA:9
X-Proofpoint-ORIG-GUID: Kw_mBj8JaN5rs9H-6lfoTolW_dqygzbx
X-Proofpoint-GUID: Kw_mBj8JaN5rs9H-6lfoTolW_dqygzbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160139

Lot's of locations where we could've used gpa_t but used u64/unsigned
long.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.h |  8 ++++----
 arch/s390/kvm/pv.c       | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index bf1d7798c1af..1ffaec723a30 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -308,17 +308,17 @@ int kvm_s390_pv_deinit_vm(struct kvm *kvm, u16 *rc, u16 *rrc);
 int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc);
 int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
 			      u16 *rrc);
-int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
+int kvm_s390_pv_unpack(struct kvm *kvm, gpa_t addr, unsigned long size,
 		       unsigned long tweak, u16 *rc, u16 *rrc);
 int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
 int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc);
 int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
-				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
+				gpa_t *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
 int kvm_s390_pv_dump_complete(struct kvm *kvm, void __user *buff_user,
 			      u16 *rc, u16 *rrc);
 int kvm_s390_pv_destroy_page(struct kvm *kvm, unsigned long gaddr);
-int kvm_s390_pv_convert_to_secure(struct kvm *kvm, unsigned long gaddr);
-int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *uvcb);
+int kvm_s390_pv_convert_to_secure(struct kvm *kvm, gpa_t gaddr);
+int kvm_s390_pv_make_secure(struct kvm *kvm, gpa_t gaddr, void *uvcb);
 
 static inline u64 kvm_s390_pv_get_handle(struct kvm *kvm)
 {
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index c2dafd812a3b..a86469507309 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -125,7 +125,7 @@ static void _kvm_s390_pv_make_secure(struct guest_fault *f)
  * Context: needs to be called with kvm->srcu held.
  * Return: 0 on success, < 0 in case of error.
  */
-int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *uvcb)
+int kvm_s390_pv_make_secure(struct kvm *kvm, gpa_t gaddr, void *uvcb)
 {
 	struct pv_make_secure priv = { .uvcb = uvcb };
 	struct guest_fault f = {
@@ -157,7 +157,7 @@ int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *uvcb)
 	return rc;
 }
 
-int kvm_s390_pv_convert_to_secure(struct kvm *kvm, unsigned long gaddr)
+int kvm_s390_pv_convert_to_secure(struct kvm *kvm, gpa_t gaddr)
 {
 	struct uv_cb_cts uvcb = {
 		.header.cmd = UVC_CMD_CONV_TO_SEC_STOR,
@@ -765,7 +765,7 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
 	return cc ? -EINVAL : 0;
 }
 
-static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
+static int unpack_one(struct kvm *kvm, gpa_t addr, u64 tweak,
 		      u64 offset, u16 *rc, u16 *rrc)
 {
 	struct uv_cb_unp uvcb = {
@@ -793,7 +793,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
 	return ret;
 }
 
-int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
+int kvm_s390_pv_unpack(struct kvm *kvm, gpa_t addr, unsigned long size,
 		       unsigned long tweak, u16 *rc, u16 *rrc)
 {
 	u64 offset = 0;
@@ -802,7 +802,7 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 	if (addr & ~PAGE_MASK || !size || size & ~PAGE_MASK)
 		return -EINVAL;
 
-	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
+	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %llx size %lx",
 		     addr, size);
 
 	guard(srcu)(&kvm->srcu);
@@ -891,7 +891,7 @@ int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc)
  *  -EFAULT if copying the result to buff_user failed
  */
 int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
-				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
+				gpa_t *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
 {
 	struct uv_cb_dump_stor_state uvcb = {
 		.header.cmd = UVC_CMD_DUMP_CONF_STOR_STATE,
-- 
2.51.0

