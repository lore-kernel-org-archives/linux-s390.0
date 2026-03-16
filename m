Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653E33EB01;
	Mon, 16 Mar 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684268; cv=none; b=MuMaFdE8ICjBGMzbo7No+KWYLaF1PBm5YBHseVM9lUjcDvln/EFaA+A37qE+ZPKe17Mqlb9jmsEhBQckSUqdnycG2eV+N4CLBkIcvcLYsU0WhO5+OH1PYtl/shnWvLM8I4+Zpuq6hykkZPonfFDlHLA5ZJNT9+B4VRSHX+3ptJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684268; c=relaxed/simple;
	bh=EGOsVjRRPXuhtwsjnoEYaedFsPvKSkGLqnumo1lXyis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNI4W6Uesh9y7SGzMgmPLgyjZ7mwHKV2Nfi0TWXuZDfu5APTYqYBLs3tA4flkGH9kMo/WEr9n83n25+snmxzb0f75U3+stzA7jfBSHQJS0dL28BfnOAQZamrPC020F594unlNalWvVnSnh5V5jNDVa/UwDyyu01Fjd2OW1VHnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O7P/LqsE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O7P/LqsE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GCQ43L150222;
	Mon, 16 Mar 2026 18:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=76prJy1OsrB4VXy9i
	YRAkOgo4PdWlXcYQVIrvSsf5z8=; b=O7P/LqsEh/m2J4eyLpiLgXwZuaEza0S06
	fztsqYz6dLvFYA1fibWJh4gLVlhKUEwwMBbJJKlvNuHSf6ZVrwZpfpDTOEUhonj+
	GvMR1NT7kvEd4a0teDv1mC32I0aoj7C0PM4sAkhwFUzRidNyns3X/e22cRzrQqIt
	+D7V7R/x45wBBz/mWbu/CVJnGnPqJHzmF8+yTVDzSlfAlFQ3FJzRclQTPTP0AJbP
	Pc2Sb5ZreJAe84df0wyWYM1jCD2Es6jWH3kDHDeOKL7A2SQlRIoAc3MT51rRFuDT
	FvA+uurVw4TMup8SdEgSySMojKIdv72w+6DUhMHX+0pBqJq2jITaw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64h7gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFtjpd032327;
	Mon, 16 Mar 2026 18:04:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jnp16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4LpA49414620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA0120043;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB3620040;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 10/10] KVM: s390: Cleanup kvm_s390_store_status_unloaded
Date: Mon, 16 Mar 2026 16:23:57 +0000
Message-ID: <20260316180310.17765-11-frankja@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZpzmuAIWeimGyA4siccu5ZfGZye7pkYg
X-Proofpoint-GUID: ZpzmuAIWeimGyA4siccu5ZfGZye7pkYg
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b8462a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dbs0DsuvigENhVsErcEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX0+j9VYVviNmk
 uV3WjbmGMXCvBJb4NgFreul5zQsNU3fHcDdib29PxSo/leudItZcdqjxvOIHEhvC5pUyJFq27++
 FoPeV1C/LePMKRkeIj3c9OP9gozCKHAAecgCsbh7dCw/6XR2fQSw3hzVmYK7Ys/LLFdnXiOxcqb
 2YEYzUYp1dvIlzPfMk47r2zKfBzaXm+7I5OrKp7MLX1n0uAv+Ywy3DCZFy2IP87d6fVYbgnxmD9
 ngZhLAdc9HF0IPSozEPNqku3+GzkEzUJHqGXBbT7qE8jxd9BL3s2HFwyLWh1etaoIYjJUXS35Ui
 iZy/q8XHDHGc749NAgt/n7uBrfL+fkf8nSkRe9AakIflTqcYA/KboypQe98jqsGGMrRc/9Qjl0B
 5n/OALt7HOKcHCjoEoCFpCOU+J/aG/34qpcQOiatC2P728pH92i7cqfsUMidbIPwklDX1Z0fqP4
 JT9xSPyO96Q43fyFKxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160139

Fixup comments, use gpa_t and replace magic constants.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 24 ++++++++++++++++--------
 arch/s390/kvm/kvm-s390.h |  4 ++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1668580008c6..c76f83b38d27 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4993,11 +4993,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 /*
  * store status at address
- * we use have two special cases:
- * KVM_S390_STORE_STATUS_NOADDR: -> 0x1200 on 64 bit
- * KVM_S390_STORE_STATUS_PREFIXED: -> prefix
+ *
+ * We have two special cases:
+ * - KVM_S390_STORE_STATUS_NOADDR: -> 0x1200 on 64 bit
+ * - KVM_S390_STORE_STATUS_PREFIXED: -> prefix
  */
-int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
+int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	unsigned char archmode = 1;
 	freg_t fprs[NUM_FPRS];
@@ -5007,15 +5008,22 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
 
 	px = kvm_s390_get_prefix(vcpu);
 	if (gpa == KVM_S390_STORE_STATUS_NOADDR) {
-		if (write_guest_abs(vcpu, 163, &archmode, 1))
+		if (write_guest_abs(vcpu, __LC_AR_MODE_ID, &archmode, 1))
 			return -EFAULT;
 		gpa = 0;
 	} else if (gpa == KVM_S390_STORE_STATUS_PREFIXED) {
-		if (write_guest_real(vcpu, 163, &archmode, 1))
+		if (write_guest_real(vcpu, __LC_AR_MODE_ID, &archmode, 1))
 			return -EFAULT;
 		gpa = px;
-	} else
+	} else {
+		/*
+		 * Store status at address does NOT store vrs and arch
+		 * indication. Since we add __LC_FPREGS_SAVE_AREA to
+		 * the address when writing, we need to subtract it
+		 * here.
+		 */
 		gpa -= __LC_FPREGS_SAVE_AREA;
+	}
 
 	/* manually convert vector registers if necessary */
 	if (cpu_has_vx()) {
@@ -5049,7 +5057,7 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
 	return rc ? -EFAULT : 0;
 }
 
-int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
+int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, gpa_t addr)
 {
 	/*
 	 * The guest FPRS and ACRS are in the host FPRS/ACRS due to the lazy
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1ffaec723a30..9cfc3caee334 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -450,8 +450,8 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
 /* implemented in kvm-s390.c */
 int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
-int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
-int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
+int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, gpa_t addr);
+int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, gpa_t addr);
 int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
 int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
-- 
2.51.0

