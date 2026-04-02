Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F19E3F1650;
	Thu,  2 Apr 2026 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142113; cv=none; b=srqP5dMNWXGYpXjlG8m9Yjbmnl3vjQgNYx/CieBrS2YcP1rlinnHuHKzKA+mNKM1B2xgBJeQat/UCct8V0TNVbY3T1Q37LOSoOY/O+4AdQAEG/KbbL7bDuXUK7qNn4P15ypGWNvxJQAKyJzKjsaMUH6V1pwGMVgRCQp/jMRfQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142113; c=relaxed/simple;
	bh=JXIgmI0n5CV1WvJXMcHfz7xo/Elo1dyN+EFIIing0xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHk7bHOxdJmTkFxn3a4PVhzXYfE5n3yK7rv+qhbyevxONFyPzNtSlwJ9PQblTdlxRwQ4vAkF5s430z1TDs7mfAkMA0aKr61g4djBic5vf/PSWgPm0pEoXdXtBeAKQuOLtqaaz/GuJIE2L+qSJu72ud0Y5p7N4xXReCF8gHDfO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BOAspQ3h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BOAspQ3h"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63273RSA3012799;
	Thu, 2 Apr 2026 15:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dXIo9TEva+lx0OuPh
	FWjI/CKatZUSTWTqdW8Xi6YZQ4=; b=BOAspQ3hCzgsbu7S0y3N3cILcNmqRFadJ
	8OVJGOE4DEIiYjmqyUNiaCngh4wfUV9UQg6Zv7R6gpKRZ+YFf3+Uxa63X7Gv+gVo
	6ECDBCdH4RlIoaKEFU4ogG2m6O43pLZqUfgJh3EBNZh4YJApe2No8GBAhehQ5tMj
	n1x9aqMyWRsNlxwGrFAz104wD30OLPNEpUMd2kYbRcM1+Y/XhUV14y6kSNRfbT4I
	dTUdGqmOGYpHS6vNzmYKevlAaCCArkPqRRU/+gLyKnOXsElW1q4XblJVfgWRS9ZC
	qbiWzqZHEJqQAgr0+yCRV6HAY5xjTbMODUJ7Bayl3wGk2QBG+vodQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g25bur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632CCEuQ013932;
	Thu, 2 Apr 2026 15:01:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttktd28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632F1erD58327382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:01:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D73C020043;
	Thu,  2 Apr 2026 15:01:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2362220040;
	Thu,  2 Apr 2026 15:01:40 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.129.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 15:01:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 5/6] KVM: s390: selftests: enable some common memory-related tests
Date: Thu,  2 Apr 2026 17:01:34 +0200
Message-ID: <20260402150135.196943-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402150135.196943-1-imbrenda@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ce84dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=TmFg2SzGmbXOhQH8FJgA:9
X-Proofpoint-ORIG-GUID: NCCTNkINBYwM7BGKRYqRB6WgHOHLdhEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMyBTYWx0ZWRfXyjahlVPi949r
 Ci+kx0rS9gD+PpaRUEcpyKizFZRNCoc2E6gv1DGv/NSYVm+wmwXtWmu81mvOe1NPrj+f55LDHk2
 4dGr9ic0zUhGd37KB7ZjV8VUP7JmVbv7y51c6TrW1N1TDNXPIS3xmGX5am/oVOHZqT3pyKXGo7h
 sXeLS5Et1C5+SglgiX240XzDbu+ugrOHXXQSjnEOMX8NBLgEgsRWY5RXl8V1LxW1yCv1Is7N34Z
 lrW4S646t2+e6Rz/3anPnB1S2ZI8STxuLLqvD/tvbyrOByZyYQvPqxcV1KnViPFApvW1z4TMhjC
 xo6CkynPdiXGwxgjDYzqdY7wVbYjYJWaafpAJlHXJxae9XDSf25eUBNlYkcOsTz4gNdY2c37Yt+
 ILo74lYj2KKvnAPAWqdy43/SFFcAnA==
X-Proofpoint-GUID: NCCTNkINBYwM7BGKRYqRB6WgHOHLdhEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2603050001 definitions=main-2604020133

Enable the following tests on s390:
* memslot_modification_stress_test
* memslot_perf_test
* mmu_stress_test

Since the first two tests are now supported on all architectures, move
them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.

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

