Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879E3EEACB;
	Wed, 20 May 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290245; cv=none; b=ItcavuW5uaEsxtQiIszlcSomYQlZA3DWZaIMk38oQSO14+7luNMAXJ9vPMD8416+ShIYn2quwIQlYSrgdpCCmVN5jNUdg4gBB9z65t9IwVQONDUCVwc0f3mydazj06ovYuxqJW/W+9pV/iX04AOIBjYtAYuexBuOVaKSXQ9oYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290245; c=relaxed/simple;
	bh=cU0xorK2ua1kep2b1OWcJuac0RINbn0aDFuJbUaNTYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws6j/nWL2oJN/97m6mYY05KcUc43VMkxmL26fO0Hnt4J55SkWCKTDWmxD6Ue6Am8gBh8tSmXYYjFMi63XckOvQ346IZqil6fIiBr8SQkB2mPTJ+qDKWQ5HYzAdgY8VFSHt85I6Cy5/KMFOE/rfuj7EEzOZxh4rRgM4pkJ5bVao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P8aZpJBr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P8aZpJBr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDLJPh032105;
	Wed, 20 May 2026 15:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AJYMLGH/fWC7uqxjk
	aiAtJCxKimPjCHxKmmQv86PRQw=; b=P8aZpJBrAWd3Q0pUvv6j7QMpbwl1I4tL1
	WHH+Zc35BjTUAcl2ua4BFK44fCqWVk0OJauAj2u+UGhT8enkh2ejihu99FfzBkc6
	xD5Dd7qSSQlL+zhexCPME/WXUEItuDdl9uIyCEZY1IBVWNXq3I94N446DGxkaSqk
	29EHI/H/9CnvCdjWSHZT6IHNmqBm9Z0tCTOW7AsiIlsjMCRyVFqdxlTwO1C+bDsg
	OF3bZ6P46xCtabK7hwKchfToDPJ2FPRkRHePyY45o+jIBvWI+bCAnVX6+MKm+sIb
	chdLYL6USqsCaPbG/d5jxHU3bUWtpK3U6TEfIs2O6jBV3fXcBV98A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y2sf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KF951d000922;
	Wed, 20 May 2026 15:17:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk7wr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFHCtu47579642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:17:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E4FD20040;
	Wed, 20 May 2026 15:17:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2259B20049;
	Wed, 20 May 2026 15:17:12 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:17:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v1 4/4] KVM: selftests: Enable pre_fault_memory_test for s390
Date: Wed, 20 May 2026 17:17:10 +0200
Message-ID: <20260520151710.231788-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520151710.231788-1-imbrenda@linux.ibm.com>
References: <20260520151710.231788-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NyBTYWx0ZWRfXwuMcBLNdC1ra
 UDaSzoziQzVVrY9dSb4BrMfKV/r9zYygiN36gHe3SHK/mMDYQJomjjQTbrPfPWlUAtmbxgxce+B
 h4aOC5sdX+frBw0DbJS9fnzLcVW5PqsuFG1AjILj4WjCHzMFF22KtnCJIt21KbpHxFr06l0n0zG
 4jnXtNNwFYrjzpSE3jCcEHBi0nhdR/5+LKt+TFUZI8O9HeboP43H97R6Q+HJ77yinKGjeWha4tN
 ThmXN7r8EgMxlChKhHC04hXp73e1ftD3BBpi37Q4MMH2LP4BJuybUybbP/XWPD7zCyDn5l9lDu2
 +zy4LLFCk70l9z+I5ucmfh7qDZN3HvC9+F5pQ7jVqur9TrtvW382bMlPd3UPJH3ds4fFrIDKd9k
 j/J6Qz4TMZJhrf4C5r44U2E6u6vlhTOEdZNTNVY4uO3qkKredeOOcKN9jia8ZDtGpBVej+jLNef
 P41M67vvcspTrXDPjtg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0dd07f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=f1nrkDJSyVtqXGSnAM4A:9
X-Proofpoint-ORIG-GUID: 0KiCPF5BDNMVb7K_ELzAcETeQHF3wJmp
X-Proofpoint-GUID: jWd_XV936zk5KGJJNb-Yi6DiF_C1dhp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200147

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

