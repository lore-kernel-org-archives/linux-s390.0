Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04993F9F30;
	Fri, 29 May 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066700; cv=none; b=bE6AUrN4Md8VsZI062g8HmpZdN4fgb2y5XpM0+SwCPCMBh+RtUuF8kl94AucJ2eR7Daa1pcaNhpIo1J3gYPqHgcGX2kqHfxMzyMoRBUvNQ/flDZ+p5xeKf0kK0kLgfj1BTPKWUJPX7ng3iIRSIFJhZPLr7L45rTLemlqRg8rDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066700; c=relaxed/simple;
	bh=uFmM9/MujduMgX1TlMIHtZIiet2qp3cnp/wLbXCAzIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mux/0Rp9RSHaCYfa4Tlm2fNbu/ilHrQqxLnHgqXbaf2T4mAW75OI4XS4g4hK0GNTfEakib+2trJSADMB634+OHOYkF0aKEfateJutK5KoJEFyMttdIhea/TYakdEKRvGsBWvtIAcqsjcI95lgAgUDJQOd3oC/Eueg9B1T0DM+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=inbPN1GC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="inbPN1GC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TB37fE2418445;
	Fri, 29 May 2026 14:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J27WqBdhkRI43dPq1hhk7X4p2zllBkQBZBCjMrYk8
	BU=; b=inbPN1GCihQvm8xcXZRveaa+76jrOoXzmJjtqOMT5oqkldj3++NEZYYPu
	BPnV7BbxqEv0CrhfNOaCnzt96DmOiX4nYNBLZqhLZmn10heHUJsFNP8GYJ0s1ySk
	wPSBOGDPenSuLHX9raQI4aqpZd4dC9QRx0SuI5MQJZidt/aUPmWrzPh/2NgIpZuj
	27c+98Q+zg0XKywpP/GzBUB16acla7HNDLGBmKvUwIYB588uNZSN9qEm3JSx2OqO
	mMBLixkeEGPLtQ/WHuyLFFqWpzylpckWM6bKelfZezk+QGIADyCZ1krjoGwwrPSZ
	G/j0xDKwZmz1wS81Z9jjx5+KnOxfQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884tnv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TEs7D5011905;
	Fri, 29 May 2026 14:57:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbf5qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEvseW46268924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:57:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E7912004B;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 029FE20043;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:57:53 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] s390: Enable Rust support and add required arch glue
Date: Fri, 29 May 2026 16:57:46 +0200
Message-ID: <20260529145752.1209016-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19a977 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8 a=YnCZDFda9O9yJGHsuikA:9
X-Proofpoint-ORIG-GUID: EFjkK0QHlUJaB7UQQpI8ZoQGc5bM94Ti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NiBTYWx0ZWRfX2ygMsJXkfxSw
 Z3G1cIHPDvfKfToeExdrYbkRsvPY32YMD79loX+Q5FYMKFiAYXepEVCuZGVdLvwLrHroJC0xz7J
 zqwJVobKoGG//gGsjlmYAyU7eRfAC5KJ8fUUOwKrk6n4u05D0VpiNNgM8oBVqQYuYBWbSE+jiPY
 d/kcrySvyv4sMDbVSx0QG3QT0ntts7EMfYBM1ELnZgBsI8fZSA0LpNrEX9uL+mFScceCLL4EIaG
 CEAZwzzW1/Gmw438fbFwHwnqBTvaAP0Y3B9Ih5A89RckQwGcYMQyH3HjX97PDn/wF6nDXRMmk5N
 xaRr8xmMI54H+5jBe35EHKay2SO3/orOh77D0cwJso3322ugAFbLz/YKlY8upyIN72kvZWR9WSU
 lIq/vqudujbxIMmycsEsz2JKjfO94CUGbI9acjEk9RSEE2OqEx15dIpniPFESfRvR/ysR9crwMo
 u5V83VFxiapmPqN5wqw==
X-Proofpoint-GUID: 53XEEZ3hTAlYqpLI7fEHhJPfvk2_pduP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290146

Rust support on s390 requires a small set of architecture-specific pieces
before the generic Rust kernel infrastructure can be used.

The series wires up s390 as a Rust-capable 64-bit architecture, adds the
missing assembly interfaces needed by Rust for WARN/BUG reporting and for
static branches, adjusts bindgen parameters to avoid repr layout conflicts
caused by packed and aligned s390 structures, and fixes issues discovered
during testing.

s390 currently requires rustc with support for -Zpacked-stack, and the
minimum tool version gating is adjusted accordingly.

Link: https://github.com/Rust-for-Linux/linux/issues/2

Tested against: rustc 1.96.0-beta.7 (6be5f81e1 2026-05-17)

Changes since v3:
- Added patch 4/6: Fix __underlying_memchr macro expansion on s390 (reported by Miguel)
- Added patch 5/6: Fix KASAN stack-out-of-bounds in atomic helpers (reported by Miguel, suggested by Gary)
- Patch 6/6: Document CONFIG_EXPOLINE constraint in arch-support.rst (Sashiko AI feedback)

Changes since v2:
- mflags: cleanup (thanks Gary)

Changes since v1:
- strip the -nightly suffix in min-tool-version.sh (thanks Miguel and Alice)
- ARCH_JUMP_TABLE_ENTRY() moved up to align comments properly (thanks Gary)
- removed MONCODE_BUG to prevent 0U in non-C context in assembler (noted by Sashiko - AI)
- prevent environment pollution by explicit initialization mflag := (noted by Sashiko - AI)

Jan Polensky (6):
  s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
  s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and
    ARCH_STATIC_BRANCH_ASM macros
  rust/bindgen_parameters: Mark s390 types as opaque to prevent repr
    conflicts
  rust: helpers: Use __builtin_memchr directly on s390
  s390/cmpxchg: Fix KASAN stack-out-of-bounds in atomic helpers
  s390: Enable Rust support

 Documentation/rust/arch-support.rst |  1 +
 arch/s390/Kconfig                   |  1 +
 arch/s390/Makefile                  | 28 ++++++++++++++----------
 arch/s390/include/asm/bug.h         | 12 +++++++++++
 arch/s390/include/asm/cmpxchg.h     |  8 +++----
 arch/s390/include/asm/jump_label.h  | 33 +++++++++++++++++------------
 rust/Makefile                       |  1 +
 rust/bindgen_parameters             |  7 ++++++
 rust/helpers/uaccess.c              |  7 ++++++
 scripts/generate_rust_target.rs     |  2 ++
 scripts/min-tool-version.sh         |  6 +++++-
 11 files changed, 76 insertions(+), 30 deletions(-)


base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
--
2.53.0

