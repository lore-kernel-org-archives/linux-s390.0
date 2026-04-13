Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FA3BB9F5;
	Mon, 13 Apr 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077280; cv=none; b=Ywgzq3zZEVUnrBldgrzdv623XIHqOURnzixkmtH7oQUAkd47dLOJShk4y1jTeHRS8+nxTgKzZhfKpUOvGhjJ42rzK9H/y73srbwe+r/cl6sVZ4CyyWKUfpPaefhg3+ZsmfPX86G2me22+8XOJNOdES5h1z6tJRYkrj7Y1X0jNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077280; c=relaxed/simple;
	bh=lC2qiiv59sKtR0ieD3AE9VTeUTrdLN8mrKMZXn+JUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhkSEaIPi5PAYo8/0TbbCdm41RnEqqCBMOogSqcZ8tCYBbykIK9LbldaDLdMyvsLIpp7DbT6bBcTM9+Nq8zmJawMQqOd+3iLLWUgvHWnXJNLKtL3qDayaLE9wo44GERi0ernsNU6xikjie4ELmw+ocZWgXYr/rXIxLb1Hwc6x8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A2TEpB7F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A2TEpB7F"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CLtMrh3188928;
	Mon, 13 Apr 2026 10:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sgdmn330S+oNVeJrP
	zQg9qsDiErn/iGElCDQcMGUE/U=; b=A2TEpB7Fh/Om3XQqBzZjaAKBCulC1Pzu8
	FCBcnE8SP4Den3R/HPGo2S4eHHeDq8jgN10d4C2VDgOlWglOZQxgD3CIuWR0Lc8R
	fCNsKZxliuzgcWO8ucU7iGlssMO2QhFr5q4MC0J3CKCumhl4/lSmVF18X+b/R0Az
	ImVPtgas1l6uvh6i0sFAZAiJzBJLhwqORgvHkRX2OurZb5Fk5e8Qqy2zZLhdrrOO
	TxpzouYJq17Mo1pkaaYe2RqoEkWZjsBqo6JTJ/LLmoaXFXtRJMbv7UuslBnpuE1/
	t1P7vMcd8/DtzFnPpR5xSPUx5uvjF7sPawDc4AGatflUv7FRiBcQA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17q6tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D9AA4c004179;
	Mon, 13 Apr 2026 10:47:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k4q6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlpA717891762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C1182004B;
	Mon, 13 Apr 2026 10:47:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B47752004E;
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [GIT PULL 11/12] KVM: s390: selftests: enable some common memory-related tests
Date: Mon, 13 Apr 2026 12:46:39 +0200
Message-ID: <20260413104721.203024-12-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX4jEq4Jf242gV
 pYgFBzegCxV7cc7G+d1ytfcgYsiI6YClmvs4PJQhSltb7H6FBvglSugQ3aCjHt/twboIRooVSjj
 7FxDXTXA/c8kARSsiCpPB1gtMWuYXw9mK6keqVBE/SD+8pZwrqLJtZn1shs7iZe8fTjSlBzdpH4
 x2ekmwiy2I8gC2v8lhrEj1At+1vn1pvqq6Nde9S/q6I8m84ptC5K0mR91xii1sUWyZ+6MAQIHLv
 X5tqjMQPizQXYVTREMeKyDD+eh0bC8Oz1NGXC/yC9xgIS01ZuE+8ZkNKIwiTpwLH1YWcJyLXuVg
 zib0gd4Zx2iiKoHoN0ZC69fWruIANkKvDj9bHSADIRnGAyANkgINwnct989+yFJd9prKnasPkW0
 +kvGAQBPyOWhsbEVWX5mHavG1p8MYfQFEAT9PmA29Q1BIMCMQhL4pX+Dx4wxaF0nnOjt60tSwWl
 7pHPcuKqgYo998rABmQ==
X-Proofpoint-ORIG-GUID: qy6-PHdpQPu9rHzL6RJnJhUAcFA7I3Uv
X-Proofpoint-GUID: qy6-PHdpQPu9rHzL6RJnJhUAcFA7I3Uv
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69dcc9dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=TmFg2SzGmbXOhQH8FJgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130106

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Enable the following tests on s390:
* memslot_modification_stress_test
* memslot_perf_test
* mmu_stress_test

Since the first two tests are now supported on all architectures, move
them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fdec90e85467..057f17d6b896 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -64,6 +64,8 @@ TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
 TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
 TEST_GEN_PROGS_COMMON += kvm_page_table_test
 TEST_GEN_PROGS_COMMON += set_memory_region_test
+TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
+TEST_GEN_PROGS_COMMON += memslot_perf_test
 
 # Compiled test targets
 TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
@@ -147,8 +149,6 @@ TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
 TEST_GEN_PROGS_x86 += guest_memfd_test
 TEST_GEN_PROGS_x86 += hardware_disable_test
-TEST_GEN_PROGS_x86 += memslot_modification_stress_test
-TEST_GEN_PROGS_x86 += memslot_perf_test
 TEST_GEN_PROGS_x86 += mmu_stress_test
 TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
@@ -186,8 +186,6 @@ TEST_GEN_PROGS_arm64 += coalesced_io_test
 TEST_GEN_PROGS_arm64 += dirty_log_perf_test
 TEST_GEN_PROGS_arm64 += get-reg-list
 TEST_GEN_PROGS_arm64 += guest_memfd_test
-TEST_GEN_PROGS_arm64 += memslot_modification_stress_test
-TEST_GEN_PROGS_arm64 += memslot_perf_test
 TEST_GEN_PROGS_arm64 += mmu_stress_test
 TEST_GEN_PROGS_arm64 += rseq_test
 TEST_GEN_PROGS_arm64 += steal_time
@@ -205,6 +203,7 @@ TEST_GEN_PROGS_s390 += s390/ucontrol_test
 TEST_GEN_PROGS_s390 += s390/user_operexec
 TEST_GEN_PROGS_s390 += s390/keyop
 TEST_GEN_PROGS_s390 += rseq_test
+TEST_GEN_PROGS_s390 += mmu_stress_test
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
@@ -214,8 +213,6 @@ TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += coalesced_io_test
 TEST_GEN_PROGS_riscv += dirty_log_perf_test
 TEST_GEN_PROGS_riscv += get-reg-list
-TEST_GEN_PROGS_riscv += memslot_modification_stress_test
-TEST_GEN_PROGS_riscv += memslot_perf_test
 TEST_GEN_PROGS_riscv += mmu_stress_test
 TEST_GEN_PROGS_riscv += rseq_test
 TEST_GEN_PROGS_riscv += steal_time
-- 
2.53.0

