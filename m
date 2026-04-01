Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D947ECD0;
	Wed,  1 Apr 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065220; cv=none; b=Z4OyhPVXSafIiSbDjdJP+hOcP2brt8WW38JmgCLvpI1SHoGeRU0AKhEXe05KaMTy73gugXnegbw5DfpyMzqTdEG3+0cDe4krjScP0rFNwXF7LIx2GkyyYKojukutQRqPPYdFKcRTCaEcbiIG3+p5Q0Zqk5zEOswMQ4HBUcUvbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065220; c=relaxed/simple;
	bh=OZkTKksphmUcQcwebXL1oZnWFw6Vwl2QcS4Gw75qxVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S73almA9lSda5bCqyQz4A8671G3xgRjTyYtg2287gZJiNeFvM95FMRlSb4UsVkg0Bn7NYAIn2JIBr3odAVpGX/b/Nbl851wq/yD+09hFyPjBDpCGGBT02zapoelp6eCIf1t4FDcqEnqbnGYW1jroGkZhRzzXPKNZks4Kwz0Xtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oodgGYS5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oodgGYS5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631801cZ3551491;
	Wed, 1 Apr 2026 17:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FVdNftKXVYlsMwXQw
	Tw9p/OWnVGP/380ZQIOoxEV21s=; b=oodgGYS5hSz7Hea2YUVNuRg2LRBfDAsFK
	mHMgXKfbkb66UVo9vGA6u74Kghv9rWfb2Zql8+gRiI86ZacwUGQNDfu4zDbJE+q8
	/TcqmzAncHDLVWeRHpyMkWhmwYVYuoDR2krE8WoVzch4v5bYcg3AlB67dMbiVC4L
	YBv0E8YcFYdILbCnqHSMmu7fTL4QeCRg4s1r7W1/X2ZGaSPW0XfV9xRJZermZTVk
	qyM3a7/8DPnsIR4wrIVPNJKEDXo7mvwf6xJ6826bgS6PsLv2xZ9SEj99OHUeR67i
	vSUGeUcD1fm01xRfZBGaispHxhXhWnE6SfDhyPv0L5lhX15QZySXw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgrupa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631GNNfk030947;
	Wed, 1 Apr 2026 17:40:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjxk7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631He0cU43450872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:40:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C675B2004B;
	Wed,  1 Apr 2026 17:40:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 271C520043;
	Wed,  1 Apr 2026 17:40:00 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.24.224])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 17:40:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 5/5] KVM: s390: selftests: enable some common memory-related tests
Date: Wed,  1 Apr 2026 19:39:55 +0200
Message-ID: <20260401173955.314821-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401173955.314821-1-imbrenda@linux.ibm.com>
References: <20260401173955.314821-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfX1YFBzsG8EqgD
 3476x41h5nH3WfIA2zdbSe5uCt/RfDm4EAnvr+clAiuzTjoB8BehujKJfmc8xXObuE+1U47S/HH
 JYGDB5G7Tuyvr561byzPJVAct9Qsl9tItrSZmOOVVxSF4z5p0O80zsMh8QNkbgtRfMWcQk4unsY
 xbbbMhEEvCz0rKqlte61D6fcJ7qbUS3sSTc8r5Z1CNiZlYpMg0LCyDa1ITL7Us7agjUXkmGZq59
 hBCgewI5+4OVytEfaRMslE7FyLq4nc1jjZH5c+11QpyD+N/d47hsKZIrXBoSn81E08lU4uoPPci
 WGSqNj52CiYhTmUfzwOx0ZwyGePRJ0rOkyiEhGkgw6mOCwrtZ1Xevc7I2/qxxA28Uav49DAjqyM
 jFP+O+l0Y2YhDGBKo+wpBkhiKvorXmKz3Y404Z/6tplBCGrBLyLYlbK8/j76DYAjjzZbHDjOyZA
 AW/+ManVrrqQEEyDyhw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cd5877 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TmFg2SzGmbXOhQH8FJgA:9
X-Proofpoint-GUID: 1m3HkYx8HaSgE6FHPjEdxYJ_FfrSQ558
X-Proofpoint-ORIG-GUID: 1m3HkYx8HaSgE6FHPjEdxYJ_FfrSQ558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010162

Enable the following tests on s390:
* memslot_modification_stress_test
* memslot_perf_test
* mmu_stress_test

Since the first two tests are now supported on all architectures, move
them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fdec90e85467..765a51599668 100644
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
@@ -230,8 +227,6 @@ TEST_GEN_PROGS_loongarch += hardware_disable_test
 TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
 TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
 TEST_GEN_PROGS_loongarch += kvm_page_table_test
-TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
-TEST_GEN_PROGS_loongarch += memslot_perf_test
 TEST_GEN_PROGS_loongarch += set_memory_region_test
 TEST_GEN_PROGS_loongarch += steal_time
 
-- 
2.53.0

