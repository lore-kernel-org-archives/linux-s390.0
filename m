Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E13EFD05;
	Wed, 20 May 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290245; cv=none; b=DeMRhWTbvA9pieUYVlQOoqIBz3IMQGSE4M5xuR1kLvBqsU6qFs/NtgZVRMIW5GL+Y7wrcu0U3bFfv5GjH7/voGXimz4cJZJegFuTn5eeOymD1f0kdB5YteHkSx3XVPcwVxWtcpLWeE7SwDXZJ4Frx2aB/cbBZAMBB976EOXpqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290245; c=relaxed/simple;
	bh=B670asqeJMuES8W7NKo5or9JrUiqjIlSmg6O2bXv8Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIDiu3iZ84HJd5t8knMjsV5PYieSAklluf9DtEOyWuiVunE5Un8lQ02iCFsBjbUGAbmEWCof1PUWPrVAxvBR1cPcSCg2SdyHuAukNZ7oo9UE0mph4z/7dNipdRIbSJlx3kQaAHwycKMeT7t/soCY/JdoCHgINbDmSi4nPcIJzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K76GzQIX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K76GzQIX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KA6IwU2070048;
	Wed, 20 May 2026 15:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IhtKsaVctiX+1AW6f
	UVgkWil2lKxnVi0fN26eUQycX4=; b=K76GzQIXETIN91ZuV20SlvFmHWvEBkDvP
	PVCxFXYUJ5TOZpDMc7TNa6ShCFPuXz1Sangu6+kM6a3UNLD7/TL7GkQ2l3z4D6DC
	Ou65PE3jlm5PkBDzOqZXyLRxcxP/tjbelpbQQI6XE5xGW6PKemxM95xXdb0eQalE
	ymr2RUy66fUEkbjaB2I5g7WOxwFglm0sIczUA2VsIlLUEKfbX2tbHXxiPrLjODyK
	N2qwCsOzuEdr1LZGjrY1i8QG0lRAsksdK4y2WAIFHSH1CKC9lFl2UXGadfTXz67O
	Cy1zpnh3kYCnuLw1SkVerudjdmdbFnyR/4i2l0DbFO5SgV9WmrymA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88hqdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KF9AuR009459;
	Wed, 20 May 2026 15:17:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w00yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFHCBv47579640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:17:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B39220040;
	Wed, 20 May 2026 15:17:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9DB2004B;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v1 3/4] KVM: selftests: Fix pre_fault_memory_test to run on s390
Date: Wed, 20 May 2026 17:17:09 +0200
Message-ID: <20260520151710.231788-4-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: WR7Ap7zf4eJEhr8v46hMIduIJqOkwuMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NyBTYWx0ZWRfX16chXr5/p737
 XV4zMRjgwRIkO8/x1n6Hvg+rLv/vkr1o2iYvK2St0mS80jWjUOZ1gzjjZrOAzy2Zfi9O9XjzWOB
 eqm3LgNjDE8v+sFZsrUXQtFANXZu16h0yWRDe83zzDt8YhH7mQ6vvXFwjEdY/evE07Lg6WoPkjI
 XjhEUZScdfd66776ie9oQK6nSZV5jUWQtdkrrML1Rq0yCDZCmSRSdZmO+ZZcNxm/VAX5k/tT93p
 SkRs768rhqu8PYiC418IFKVSW2FHgy6kTvJyLoppInzIaMJ7ahV0GRrsRU6wcgbO074x73rWCc9
 u0nBSthUGP2J0RhenxgMCYByOUDjgqUP7qG6VPoVLx2UzX5JlK16EIJFXUpRNf5jwUNyXNgSYMX
 gs1uUDN1Rlwq7qBIJhB7QTnZ69WImLzlwud6B0kIo4kLcrkyy2z33CmZxoULeeCjjoqoD0ghiYO
 2hNLGdfai6uIxqN/uYg==
X-Proofpoint-GUID: E4XdTsyIuJ0Fh7PmLg7lPkWAyWY5em6n
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0dd07f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LqbLTa_TKMQyRjCc8hQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200147

Add a missing #include <ucall_common.h> which is needed and otherwise
not included on s390.

Fence the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  so that it
is only checked on x86. On s390 the UCALL will return with a different
code.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/pre_fault_memory_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index fcb57fd034e6..42794892e902 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -11,6 +11,7 @@
 #include <kvm_util.h>
 #include <processor.h>
 #include <pthread.h>
+#include <ucall_common.h>
 
 /* Arbitrarily chosen values */
 #define TEST_SIZE		(SZ_2M + PAGE_SIZE)
@@ -167,7 +168,6 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 		.type = vm_type,
 	};
 	struct kvm_vcpu *vcpu;
-	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
@@ -193,10 +193,11 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 	vcpu_args_set(vcpu, 1, gva);
 	vcpu_run(vcpu);
 
-	run = vcpu->run;
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+#ifdef __x86_64__
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO,
 		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
 		    run->exit_reason, exit_reason_str(run->exit_reason));
+#endif
 
 	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_ABORT:
-- 
2.54.0

