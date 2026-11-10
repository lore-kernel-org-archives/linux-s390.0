Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309396;
	b=XjtS6KYOBa1nR99iHP5cHBcS+sf+myeXH3QOBhSfih4DKLuzDNtdkxhKam0gJZlbsblv
	 /ys/0a6Jzcy/Xk72pAmoKDDQW6H3Jq/L1S+skQZWpi3AZYc/qvVv9fAPdZUbwJMS3O+2C
	 UMvyzAfFft+oW5HNAkoHbjPFQkvX6Fyd7uIsDPu38kJJ+ckGq6p70nxJKoFbmgjmKVJRH
	 S7RLPZUEXQXynnhCdeQ+5IhvlvqC8XqcsJx0FuP8l2o6bzorUAjKbuv2+QcI4PVHX1vFK
	 N20vldcX56gfNUAtw7t4Nf0ndNVL5qgiW36u69kSzItbPHKbEG7JQEDlaHLVbu2jzgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309396;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9dAQlyUOWdshIOD2JvnBNS8+ih2RabZL8aTZLs9IfLA=;
	b=VIbmeIwFaN2pELP4v5u3uKssZNEZCu5GcivBe/pFllEgV+7AQe51P9fBbOLw06VvWwJS
	 VcsNgtyDT6mEGGd6jS96C++jKwZJ05wQBNsmq0cxU0r9Ts01f4RLVnqZ0rBC8KFe3kiT4
	 Wucbs1FOowA6UuIzZeQg2lIwyzafaXPHlF37jNyKMHMk3raYXSId0ZGpZywTcX1TrG/NZ
	 wtK59HkL55Swq6glPcqdvCYTe7m0nAdcWbXTLV1+FeBBdSIXgIkeI22SmmkGkr8pZCfLg
	 rbpcavfft/i79vyklYY7XUSH6cBppl4DbSBQF7d3W8BdftAmBUGiqC2UF39GKo4mtYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MYspPCHJ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD9606A31C;
	Tue, 10 Nov 2026 11:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68AD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MYspPCHJ
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEVhS2109638;
	Tue, 10 Nov 2026 11:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9dAQlyUOWdshIOD2JvnBNS8+ih2RabZL8aTZLs9If
	LA=; b=MYspPCHJKBksLBUNH+GworxCvUC5wPxqeOMXjvNWIpZZGC4JMDgmq4yPJ
	4rIi0umYfNcXVpEvLUgNDHpCWf/tawqqGSimBOECQf1Y4zrgZeygVMrhzamd5B4g
	esBq9JBMP9YD9k0E3E6HBLxIkSeAnwQcAZXn5NEm897Qpc/JbqTc+x74AnAOfdt2
	uFexSR4ZRax1n3S3KzsMg2S2VIFGXQSJokNhRyfIb7VrpiGIb6wi/812hsTonMNL
	ak075c23upobsyKQh0gcFEVChVZpEF6CfOBcZXYaXwEM/ELpb2dwKdSqieBhai7o
	BxYZEWOWWJKjoNd+fDNp9f8jXAkIQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkmntm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7o3t5331882;
	Tue, 10 Nov 2026 11:16:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg6177-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABGUtG30409450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:16:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C8B15805A;
	Tue, 10 Nov 2026 11:16:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E69D58060;
	Tue, 10 Nov 2026 11:16:30 +0000 (GMT)
Received: from MacBookPro.localdomain (unknown [9.61.241.43])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:16:29 +0000 (GMT)
From: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
Subject: [PATCH 0/6] KVM: s390: selftests: Add selftests for KVM exits on s390x
Date: Tue, 10 Nov 2026 06:16:13 -0500
Message-ID: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af2fd12 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=bgxZqNnTwVNF5JVGVmQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX5A+qu6Z5PrS5
 j0f+2ovelekZ9wFngw3r8sbteB5ZaE9NbUbU2xJwlEUOSf9H23u7/uKxy5VLeCXeAoNljxe7kAZ
 UzwqsukhYUl3R7L4UjstdVqGll+qxtnEQJECM2Ot045SAr1uAahz9o4r+CCQTR/m4egB5/W3UP3
 C2Zmz+faxHWI5oiYMWaser3nI4vXUibQhjAGz5g5CP1+buILA/NIzbWZIDsP76IGRIFARAtdaiC
 KP2xCs+IQ7a+82rap7dGBgIiAJxwlRhAf/f7wdhrLN41WGnIARrd2hk2GCxCjD7vQpz/CXspBAg
 pJo/eLXI1TXsU+0289xsWwEOJu4LAzSCJem+DvW/eovlu3qiNOPQJBkqgcrGJHpiPDbt7VoHzoR
 OqNnnFNa9GepXlHFGYn72xnlrvzkvXdsCKPknCvY3TWm2jX0vWnFQVjBsJdDTCNy3nQVMrpIXri
 cEze5Ho68cBodMriIRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfXzeQh4Oxwqv6u
 uUy3MlMF5KLr2qrs2jXomdXBH2Em7aQn/JrFsoUYhfpXTQqfdysz1sIoXpk59+hl1xjLsYYucVE
 76SF7TncorerELypHdJuzgPXAezGKhg=
X-Proofpoint-ORIG-GUID: e8pOSlGPquN3MKJdfqOe8uRhyi5uXjsz
X-Proofpoint-GUID: e8pOSlGPquN3MKJdfqOe8uRhyi5uXjsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

This series adds a selftest for the exits that KVM reports to userspace
on s390x, mainly KVM_EXIT_S390_SIEIC. The existing s390 selftests do not
check what userspace sees when a guest causes an intercept, for example
a DIAG, a SIGP order, a program exception or a wait state.

The tests checks the intercept code, the instruction and program data,
and the register state reported in struct kvm_run.

The series is split so that every patch adds tests on top
of the previous one:

 1: test harness and instruction intercepts (DIAG 0x500 and 0x501)
 2: SIGP stop and program exceptions (addressing, segment translation)
 3: wait state and VM create/destroy
 4: ucontrol helpers, STSI, TSCH and STSCH intercepts
 5: ucontrol storage key (KSS) and immediate_exit
 6: clock comparator interrupt on a ucontrol VM

The ucontrol tests require KVM_CAP_S390_UCONTROL and CAP_SYS_ADMIN, and the
storage key test also requires CPUSTAT_KSS. When one of these is missing,
only the affected tests are skipped, with a reason, and the others
still run.

These tests were co-developed with Nitya Khamar <nkhamar@linux.ibm.com>

Testing: built with "make -C tools/testing/selftests/kvm ARCH=s390" and
ran on a s390x z15 lpar with CONFIG_KVM_S390_UCONTROL=y

 as root:         pass:13 fail:0 skip:0
 as unprivileged: pass:8  fail:0 skip:5 (the five ucontrol tests)

Aaron M. Brown (6):
  KVM: s390: selftests: Add kvm_exit test for instruction intercepts
  KVM: s390: selftests: Add SIGP and program exception tests
  KVM: s390: selftests: Add wait state and VM lifecycle tests
  KVM: s390: selftests: Add ucontrol helpers and instruction tests
  KVM: s390: selftests: Add ucontrol storage key and immediate exit
    tests
  KVM: s390: selftests: Add clock comparator interrupt test

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/include/s390/kvm_lifecycle.h          |  43 +
 tools/testing/selftests/kvm/s390/kvm_exit.c   | 835 ++++++++++++++++++
 3 files changed, 879 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
 create mode 100644 tools/testing/selftests/kvm/s390/kvm_exit.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--
2.50.1 (Apple Git-155)
