Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BF3D810D;
	Thu, 21 May 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368754; cv=none; b=FQcMK2uhcvNM6/Wj1T4JWbHPalC6W2VNiG/b+qvZkuAGoa3z1t0UXGB8Vk7/gjo7rPmCCrkjyG13gostEg1mjxLtTBwRq29vFKbcLH5dkkiicZTuD4RsaGf8WXQIyap9OsL56g6E8/BA92fDqP7m0DWMcfwD0DKFRs9bHISFAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368754; c=relaxed/simple;
	bh=cU0xorK2ua1kep2b1OWcJuac0RINbn0aDFuJbUaNTYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgMU8qogXbp37uj1amJ4hOeKp9lCl2Us8d5S3rfo7HB/zoNznfO3QMJUPj9+3wjGoDraB8P1SG9vKIZxZ2xOZv128V2ZVkIqEYEwlG2pKA5pvydquqMNWY2IA3ndks/u/3zu8HzU8kekzcGT1zsP9Sar3Vy9xLCypIdlFp2Mddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R5yAdBp5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R5yAdBp5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L3JbIu3120487;
	Thu, 21 May 2026 13:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AJYMLGH/fWC7uqxjk
	aiAtJCxKimPjCHxKmmQv86PRQw=; b=R5yAdBp5aHgPAq5gbJxHNGxYMe+tS4aFM
	+IGGqLQjp4KxoeAQ2iIEogVFKwxY4Yl+N50UnQEvDMnpHSBb09Ldlfcm9k+P4VLX
	lyys0LesNDzP71B+iqM7z2d98fWBQzHSJ2d0aT4scycSPUL1DJ92ijfpI1glJvEt
	Vsirsvyn0TF+rukTSbNrB+66g2J772212lKzwusysLdifp7ddDQm4U+RdJZjLjnc
	hXJGy0y7c3jfmSOdYtqF1WSiM7hUb3/1TyzSKMPv0j5Glcn/DKBWj8/KBFP0ruzn
	XDT5M0/BiqSQGDXWj6J9xtk9NV899T0Bnj8czJmQHJ7ZleOx9Mpuw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mxyd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCs6Ze008450;
	Thu, 21 May 2026 13:05:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkc6cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LD5ZiO48824692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 13:05:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45A7020040;
	Thu, 21 May 2026 13:05:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 128E820049;
	Thu, 21 May 2026 13:05:35 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 13:05:35 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v2 5/5] KVM: selftests: Enable pre_fault_memory_test for s390
Date: Thu, 21 May 2026 15:05:33 +0200
Message-ID: <20260521130533.156491-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130533.156491-1-imbrenda@linux.ibm.com>
References: <20260521130533.156491-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -3JIbU22fbh94AbY2C4z7LRzg7GEUlri
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0f0326 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=f1nrkDJSyVtqXGSnAM4A:9
X-Proofpoint-ORIG-GUID: 61X_DxRFDMljHfU0ZZa-7bzvJuDMbgnJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX9apm6pb1dP3X
 sA3y2w3L4WLfvSGOj3oYGb7MzL739lLkeUTBtm1OzWfS1kfLVAXiPfGH0HBVmVVNCe8yFvGcl1b
 NXGxEcqnBj5KE5fD9O/fMlEZJwo1ZX4B7PR736oMP71OiqQ4caVaA15J36wAyxqytuxUyZxCTtt
 k6WnE4gYkw5ptNZFthNuaHl5kVCWklboCgJysckjzkOlQ44QXBGVpO7x9iKYaQWCmYaPR4K6+I5
 KGJAGJ+LxT4hO8ruyUiDxu8DPIWTkFLqB3L6HjhaG9yCHAvX7jrmqIYW30oHD2OM+aYLXgBL1n+
 0VsH+3o4sroh8/Nlt1cTydhVlw6Kl7cs5vdR0uoiZU0YQ0yAfA03WsI3W+X0ytecnl8HC9KBxg1
 7ZipgrA3dlYkMt65EAI/RN4bM3W9EIkTYeJtS8sLlq6WKpu5S+ri3kvAJjf27KkcitSHg6rkhm+
 ebK26tt33MAr10mwQoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

Enable the pre_fault_memory_test to run on s390.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..fff939db89cd 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -210,6 +210,7 @@ TEST_GEN_PROGS_s390 += s390/keyop
 TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
+TEST_GEN_PROGS_s390 += pre_fault_memory_test
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
-- 
2.54.0

