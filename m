Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E1376A01;
	Tue, 19 May 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203573; cv=none; b=VFkQYxrUHeXyWMxO/2REyciIAw2KSiiSI7pKbHf2nEM9EKEqm6R+3m6HrHaICinEzJOZbstmhtW68jJUQihGO9L0OmeChfyyIAmyBLJgCnmNOjpjAPeyC3h6P2mCCCe0Q3OTd/0Sk2a8IpARhi/b62vyZ11Zdp7aOY0MXsQAh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203573; c=relaxed/simple;
	bh=IVdLJsQjBz6TtZ11ShMCwToPLmHVyUG/SMGYgFK4T3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=De/+rn41oBqoJaVip19IvelLjpEUrjJn/LC/bfKARHgj9RvnyfWvVp3Ka2C/jP38NhQdb/kvGvb4ccl0DyyYLiaAHD/p01NvWN4IcYJbIce2DRaMZLInpxtywDxzGzFdxm0h1Zvs1PDEahsz9xHQOLMk2+4f7qbVjVk2zQCu3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iRbztHjI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iRbztHjI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JDfw672386827;
	Tue, 19 May 2026 15:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GMCwQutqUISQS9sIfvD1OJU6yiwtEMNu0tbE41pFp
	kU=; b=iRbztHjIrekiDmoy+xjb860/sf14TA2iX1g0WTHobzYmWCowzNMVRfFqS
	pmvF/tH7a2nQRzDct2ulcToEiA5kOAHV0dQQeQyS9KOjqGF8RbgFMVDBxk+TuVbZ
	WLqI7uj5BCJlubohD22v/ZhvcQXGzBbMh3TbGELOWl8GcCFnXKK9JOPjscs1tC0u
	OrwpdNoqg5Yopzx6Cik8JnGUi2bHEcYUVy2QWQPMoavfD6G4eemUcgWyXt9jUNRP
	KJHAb1v1x3OJbThCtI4IYUoVANeXlneZpe9whnh0iJC8eh5yE+jM734MEkhqOOft
	jrRlDWeRJjrW8utG2CpJv2bjZJqQw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8cxb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JF96C1015947;
	Tue, 19 May 2026 15:12:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky2xb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JFCTbd46465430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:12:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 244242004B;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCF2A20043;
	Tue, 19 May 2026 15:12:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:12:28 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] s390: enable Rust support and add required arch glue
Date: Tue, 19 May 2026 17:12:10 +0200
Message-ID: <20260519151215.1611802-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1MCBTYWx0ZWRfX/fS8GrSPcyxn
 70FnRew01ejcxWbR5F3NIh3Q1bZq/FEFGJkU/62qx9MpZRc9q9Xtd2SOrFhqSrytpj4PtiXyTlK
 TofPQg/eQDLe6ygy1SaW6s9Td/xFWDET3nkSMzyitiNYkJGBuelhkjTOY2qEVck/A30RNIlFTVx
 8CsCV3rHm4CXiK8sHrPulZnSephyiyLy0LD5CsTbtduxQZW6MLCCegc4bnheXV3sEZ4JuL6ogy8
 Msu3M2SrZ1izF0tDLAP8qqujICUONEuxH2/0VDRK+eoW8J3k82jtHpqCiIAlXKPMDlKMQRvfK4e
 wSzPaNaIPNpvRKPrUYNB9UXi08VoEdIQamWcX8lqBX0Qphae9FOTHkzC+niwp8oqAasbXn6C1sm
 61h46dXYvuaGTjQDM1+gXVzOMi55IVtNzQbNiFIHq0Wx339i9M5NsPbnkCxUOLPK8zT3vryR5tc
 mqdG+XUMpI0aPLkHeXg==
X-Proofpoint-GUID: 431JvpuIJaNBeHdEDFGl4OrE2p5-eF3C
X-Proofpoint-ORIG-GUID: XGQuKXRkba10PzmjIOpD9nX8zg6W0Vko
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0c7de2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8 a=ynQKOEzQyDeFR-uBsnYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190150

Rust support on s390 requires a small set of architecture-specific pieces
before the generic Rust kernel infrastructure can be used.

The series wires up s390 as a Rust-capable 64-bit architecture, adds the
missing assembly interfaces needed by Rust for WARN/BUG reporting and for
static branches, and adjusts bindgen parameters to avoid repr layout
conflicts caused by packed and aligned s390 structures.

s390 currently requires a rustc due to -Zpacked-stack, and the
minimum tool version gating is adjusted accordingly.

Link: https://github.com/Rust-for-Linux/linux/issues/2

Tested against: rustc 1.96.0-beta.7 (6be5f81e1 2026-05-17)

Changes since v1:
- strip the -nightly suffix in min-tool-version.sh (thanks miguel and alice)
- ARCH_JUMP_TABLE_ENTRY() moved up to align comments properly (thanks Gary)
- removed MONCODE_BUG to prevent 0U in non-C context in assembler (noted by Sashiko - AI)
- prevent environment pollution by explicit initialization mflag := (noted by Sashiko - AI)

Jan Polensky (4):
  s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
  s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and
    ARCH_STATIC_BRANCH_ASM macros
  rust/bindgen_parameters: Mark s390 types as opaque to prevent repr
    conflicts
  s390: enable Rust support

 Documentation/rust/arch-support.rst |  1 +
 arch/s390/Kconfig                   |  1 +
 arch/s390/Makefile                  | 29 +++++++++++++++----------
 arch/s390/include/asm/bug.h         | 12 +++++++++++
 arch/s390/include/asm/jump_label.h  | 33 +++++++++++++++++------------
 rust/Makefile                       |  1 +
 rust/bindgen_parameters             |  7 ++++++
 scripts/generate_rust_target.rs     |  2 ++
 scripts/min-tool-version.sh         |  6 +++++-
 9 files changed, 66 insertions(+), 26 deletions(-)


base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
--
2.51.0
