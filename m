Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5F3CBE75;
	Thu, 21 May 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368752; cv=none; b=jM0AlTnHvsGCp8lmMLoQo/gEA2B8PlUuPfKyndmmI7wfnpBOYl8Ky+rGHJE6JkjELvHq2DsxvnKHDrcmDXzIEM1QqNJGenqZoan6YajJE3l92d09bCt6wZmtRxWLz/7Ah5twOHv0qcDg/A5RgcVnmROpo4rGzbeQgVV/6rXKXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368752; c=relaxed/simple;
	bh=YdIr01snKSzmFlp9LP6OPTRhldh7kvvMzqWydJKkvpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6RZw30Vw0QtSqNagg323ZqvjsKtTdvhFINiSH4g6FUkmnw+u7gxAFIoCLxF4nLbuaE+crpO4RlKrafFAIeM58KOPbU+gqcCX5UiepATvNV9ba7VMKfdosFxx+BPCtgVv/7P9UoNiOg7e9JUPGt43xhcWN1y1A74SSbi4mkdWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PSQP8lGz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PSQP8lGz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L3JbIt3120487;
	Thu, 21 May 2026 13:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bMvknIx1kl8Rz0sr2zymZf8pZpFGAJUAa1y7xSNLq
	po=; b=PSQP8lGzEq8iRSUrHUIeBx7+pYk6OBhmnDj5VNXKOt9zCJVgxoJs6Yc2x
	vaoB1qH9dOAaqntmwUqb11XK7yeQIrvacp1Mr6Ef/g1Np1FHbnXydAqMSm/4RJRP
	6ormfIVtqcURSo77XQvyqtZXTvoQo0DFzp12QgmRseSYCV3EZQ9fzoSisCjbosq6
	Rh9xSEX0HlXHphQPraWrQRX07lB0sfl6MfRauEJBZJG5bsCrU7IdCbfWh6U0Voaa
	f84muOPgZ753pc+G98bSuMec7cvWHngBZtvxhxSDQeQIwfqjPXKfxZ9c7LJrPHDA
	lkMIQeElYJQYnvHci/JzaYYjIhnrA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mxycw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCsAsL022535;
	Thu, 21 May 2026 13:05:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhv45p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LD5YgW22544884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 13:05:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AFA420049;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08BD120040;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 13:05:33 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v2 0/5] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Date: Thu, 21 May 2026 15:05:28 +0200
Message-ID: <20260521130533.156491-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7qv8vNSzxmqMV5uJMcHrr7-a_9_HecEr
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0f0325 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=WwTxizZw8kVH9eZwR8QA:9
X-Proofpoint-ORIG-GUID: CFnWpwBOo1FQJS5YlwRGqxhwHX4esIWC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX1PM7Tg5Dg9bw
 //RPHwWqAykHwOFpgtX4WFE0PHTc6P54lHUGUoEX9dI45dLePCRD4t3zKgDGKsnqel/wjdawV+h
 IQojFZ44C5zdtVzeqg/D424OFAJkD5p7JrjUSMImQ4o/abLt0lBDksElVb/K8Lj+iSCsIJGRDD/
 wbmlDNgUY6hug3lfVkd7mpG/DQgXPDK4wT3Dnllw+mR3tzm1SZyd4jYiNg3TnN+jR9I+EtwYFwC
 xV98LrZ0fsapXZ+Kz1l2b+argdNOuVBMELa/6x+Bf5jNVN26ng2PocxFDiBkiraJD2yynR3LTp5
 iNcl9gERlOPrvURLJsuXe9vD/umpU6JRmdvsYCxIF3Vwl+jC3euHBIlKKmvKAW6GHG9iN1ukPFW
 QIoC2UWcElo6M7rL6Gb5A0OA/1d8VjEX6JEtvjXugNGmcgUUzoZuhi7AoZgZCA0SEhugjXiDDsp
 W/Bhu6D4arI2IJ5T92Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

Implement KVM_PRE_FAULT_MEMORY on s390, and update documentation and
selftests accordingly.

Faulted-in pages will be marked as accessed, unlike x86, otherwise they
will trigger a minor fault when accessed. Avoiding such faults is one of
the points of KVM_PRE_FAULT_MEMORY.

CCing x86 people due to changes in the documentation and the selftests

v1->v2:
* Add the crste_region3 flag in struct guest_fault to keep track of the
  page size used to solve a fault.
* Rewrite the s390 version of kvm_arch_vcpu_pre_fault_memory() so it
  looks and behaves similarly to the x86 version. No more loops, better
  handling of hugepage mappings, and more correct error handling.
* Remove the assertion vcpu->run->exit_reason == KVM_EXIT_IO from the
  selftest, as it is redundant and x86-specific.

Claudio Imbrenda (5):
  KVM: s390: Track page size in struct guest_fault
  KVM: s390: Implement KVM_PRE_FAULT_MEMORY
  KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
  KVM: selftests: Fix pre_fault_memory_test to run on s390
  KVM: selftests: Enable pre_fault_memory_test for s390

 Documentation/virt/kvm/api.rst                |  5 ++-
 arch/s390/kvm/Kconfig                         |  1 +
 arch/s390/kvm/dat.h                           |  1 +
 arch/s390/kvm/gmap.c                          |  2 +
 arch/s390/kvm/kvm-s390.c                      | 45 +++++++++++++++++++
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/pre_fault_memory_test.c     |  7 +--
 7 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.54.0

