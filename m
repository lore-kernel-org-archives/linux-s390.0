Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F13370FF;
	Mon, 13 Apr 2026 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077276; cv=none; b=kFJJofC6vvNn6/Y//k2PuN+UJgUeqt4+V5LFZmQ6/mSiVAGI+5w6mpL+tNssaBm+FHnhie5Wu7nO0224DOwcPa6JyDz3Al8f7ckEVfU6qxyWnw5DOtQbMQgULkEQ41uRUZQFMdkPCHSt7aXUWLDO88AXi8VdY/gC7ICAbjuyrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077276; c=relaxed/simple;
	bh=uRs4ViJdcHOCkzbz1j3OWAZE6zxxldcegFPD+5XrPd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjlTCIYOcFm4tGan9qPhSmr89q2zvDk2xIBSxJLJ3AjOuhDJgz+FKhVWZ/0StmBqwbeApBPtPDWpqUh6nrr16Roi9BVQNMHRF1/foJ/yYkll2n9/2lqWku7PPegXONR9SaJ6S6IsknX1xXV7JT2SqUZf8/1chDpbrYJ/Ufp71Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K85t+bKd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K85t+bKd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CNOHei3350052;
	Mon, 13 Apr 2026 10:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hbWsGi7/0YiqiRtIlTJSeUkbE1nkT9Kpj7U/KUuTc
	k8=; b=K85t+bKd0D8yZuvL4/Rva5MgvfxZH1hCuBgDxktBQkG8pXerbrCgsvPZi
	NgnRFAkB+vVvfOWcTL98yf0PfQ7ZcGWSma5AwVLowsoDZY/1Rw9gL95kNMVRp44Z
	fhjMzDMpXYfCskApJLbneAu+Ezd/rQaZL8XrghDPlt+v7zJH3vBMEsBYjqXqup5T
	DK0qPeg6N7taLzQJniaoNZTTRb7zgRQsHAErzumccU0iD49r7cztbWCfyZ0O/lt4
	IMpBMYvxC4J3NY2Ydwpr+Q53c/YKQCyR7xWoMacQU8xQrhLzKqYtyqS//M+jm/T1
	5dEfHQRi03ju68WHTUkJ44aDiCj6w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17q6t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D8cEjG030721;
	Mon, 13 Apr 2026 10:47:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y4wgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAljmh50200898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 342142004B;
	Mon, 13 Apr 2026 10:47:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C382D20040;
	Mon, 13 Apr 2026 10:47:44 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:44 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Subject: [GIT PULL 00/12] KVM: s390: Changes for 7.1
Date: Mon, 13 Apr 2026 12:46:28 +0200
Message-ID: <20260413104721.203024-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX5nqPabWxxeOv
 IgqdNkFZA1xjiQrhJ5AZAvTAUlQkOTPllhDFFHDzLCkpwp3EUM+1McAEpR/uBKszvgyIDz3jtRI
 0CKNKb/GsrgW3poxTuSLnwho86uXbcHBkkERTJgWP+RNdx4DFYdIqTkXwzGfyhyg4HmnZsuou9B
 p9GyH6ZdjnXCIgObEB8eWiQ9rX0YN185KUU0ktt66/8W5x6kotjfLfuhMtojptGSj/9sszMUaYd
 9bIHweQ475KsLp/pZUO6tQGFWXrOKqrCAEC9BLlmNUp34P0fLi9VQ2C950+flUrSoH36uYKVFmW
 Ehl2IsJpttQQlgiv0wlj3Womux5hfcexpk/7ctJZ7LJtxS12I0elEVrPge3qxa/q/UIZvgg2Llk
 /ftr6jXl4A+UIdcuqLLH7p8HApnWwgyt6fyewbrRwGAQDWYGuFuvmnZ4xWvaarIL0Ve9AZpjL3l
 B2fFduxZoVx5OIFZUAw==
X-Proofpoint-ORIG-GUID: QOWF2BkIRRyYPGwadYmHnPTiQc7OyEju
X-Proofpoint-GUID: QOWF2BkIRRyYPGwadYmHnPTiQc7OyEju
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69dcc9d6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=vPUu-RJ6-liXp4XtDbIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130106

Hey Paolo,

here are our changes for 7.1:
- Claudio is finishing up gmap work by allowing 4k memslots
- Eric and Hendrik added nesting ESA support
- I've fixed up LPSW/E emulation, going through next as I don't expect
  us to ever hit this

There's been two conflicts because 7.0 received a number of gmap fixes.

Please pull


The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-7.1-1

for you to fetch changes up to 9b8e8aad5896d66005d29920cb1643076a20b172:

  KVM: s390: ucontrol: Fix memslot handling (2026-04-07 17:20:42 +0200)

----------------------------------------------------------------
- ESA nesting support
- 4k memslots
- LPSW/E fix
----------------------------------------------------------------

Claudio Imbrenda (6):
  KVM: s390: Add some useful mask macros
  KVM: s390: Add alignment checks for hugepages
  KVM: s390: Allow 4k granularity for memslots
  KVM: selftests: Remove 1M alignment requirement for s390
  KVM: s390: selftests: enable some common memory-related tests
  KVM: s390: ucontrol: Fix memslot handling

Eric Farman (4):
  KVM: s390: only deliver service interrupt with payload
  KVM: s390: vsie: Allow non-zarch guests
  KVM: s390: vsie: Disable some bits when in ESA mode
  KVM: s390: vsie: Accommodate ESA prefix pages

Hendrik Brueckner (1):
  KVM: s390: Add KVM capability for ESA mode guests

Janosch Frank (1):
  KVM: s390: Fix lpsw/e breaking event handling

 Documentation/virt/kvm/api.rst                |  8 +++++
 arch/s390/include/asm/kvm_host.h              |  1 +
 arch/s390/include/asm/kvm_host_types.h        |  3 +-
 arch/s390/kvm/dat.h                           |  5 +++
 arch/s390/kvm/faultin.c                       |  2 +-
 arch/s390/kvm/gaccess.c                       |  2 +-
 arch/s390/kvm/gmap.c                          | 32 +++++++++++++++----
 arch/s390/kvm/gmap.h                          |  3 +-
 arch/s390/kvm/interrupt.c                     |  3 ++
 arch/s390/kvm/kvm-s390.c                      | 28 ++++++++--------
 arch/s390/kvm/kvm-s390.h                      |  5 ++-
 arch/s390/kvm/priv.c                          |  8 +++--
 arch/s390/kvm/vsie.c                          | 29 ++++++++++++++---
 include/uapi/linux/kvm.h                      |  1 +
 tools/testing/selftests/kvm/Makefile.kvm      |  9 ++----
 tools/testing/selftests/kvm/dirty_log_test.c  |  3 --
 .../testing/selftests/kvm/include/kvm_util.h  |  4 ---
 .../selftests/kvm/kvm_page_table_test.c       |  3 --
 tools/testing/selftests/kvm/lib/kvm_util.c    |  9 +-----
 tools/testing/selftests/kvm/lib/memstress.c   |  4 ---
 .../selftests/kvm/pre_fault_memory_test.c     |  4 ---
 .../selftests/kvm/set_memory_region_test.c    |  9 +-----
 22 files changed, 102 insertions(+), 73 deletions(-)

-- 
2.53.0

