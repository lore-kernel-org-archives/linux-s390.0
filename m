Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321F3D902E;
	Mon,  8 Jun 2026 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942523; cv=none; b=NcAQrwlBrld9a118AN5WSdr0glj+O3VK/3rWQb3CgxXWpd/SKrcWsgKHxV8lTk2nd8Qqz9DWgq+oCf90FmcJlXwDsoDNS603qk8VRirI1yKrhJ3VJ9jl18o5U9UP1o1PTKAYnHiRoFD2gbowJjPdmjzmPPvxIwriWwjIl7xY2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942523; c=relaxed/simple;
	bh=e/Y03LBy/L3QuoTNE39smIF2TehKkDH9+WKA6S3mVCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgKfK7nfCgLhrT/nE0jl78c4A+7jDc38LOnSLG/F2whZTyWcMGtsgcm4A2thSh4fmBMwRl3cKi50Axy73HyrixLcZCMQDGsYYcp+KOn5c+xQ06rvsA3Jv+e4uCgi57gHmLL6gJB0IeP06w3mCAdRdbusHGH5JB7gBv2kCfeHv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SaucGNGA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SaucGNGA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658ESm8N3068563;
	Mon, 8 Jun 2026 18:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZqymuVZQ//aZVK2xqxkkI6bp6YdGSWtqhl0bhiMjT
	pk=; b=SaucGNGAQwDw6Cvr124JTS4RRxHfcqhQJVA7XTcKyu0g6GjSw7n3sJmTU
	dA/ogKTMBrcqXF/Mad7eb3VdtR76Y//ij3VUdLP0MyMKHkycaTR2XKQZlJ8HZCcG
	NYn2vcppxnhLTDREI8pE+AuL0RJLFy9Of5bUU5U8h16PmjbO8y4/AHyzXooObkto
	BXfFbweUOguPlSXXI2Z6wywvt6gknGwNvGv9OXKwU8Y5J/HIDGeb6y8dWUCDCoKG
	ij+vUBcc5DQQeM6/X4XenGvIWt4MmBhpashl91lhdrf2jyT/eRwnE2Z3uUV7FsAu
	NSEkzqn546MsDcPiV9jNE5zskaBnw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb958nrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:14:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658I4cFW003171;
	Mon, 8 Jun 2026 18:14:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgxfhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:14:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658IEsWt40304924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:14:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C15F020043;
	Mon,  8 Jun 2026 18:14:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7696820040;
	Mon,  8 Jun 2026 18:14:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 18:14:54 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        japo@linux.ibm.com (Jan Polensky)
Subject: [PATCH v6 0/6] s390: Enable Rust support and add required arch glue
Date: Mon,  8 Jun 2026 20:14:45 +0200
Message-ID: <20260608181451.3734956-1-japo@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a2706a4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=YnCZDFda9O9yJGHsuikA:9
X-Proofpoint-ORIG-GUID: 01H1zZYYPU8nnj5ey-4FN3AYxcXHklLz
X-Proofpoint-GUID: OCiFYHcYBNzq_QgprlJRqsDqBaHSDi9e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MCBTYWx0ZWRfX9Y3c39f9Eu+b
 IdvnmcDFXowae26XwkJMhSO6PJTMSU29BpJ6NCpF2EgYbl4Gwdb2t1tfMTFUO4yfYHYj1I1xyNE
 JP/S1OGSPmI0cPsQ1J49Go5JyL8Q6vluaCTE4qcV+fnNujn4qjsO2NePj8sgeh8Fx7FGGTeZcV4
 YJT1tRWue31yfce9dXTt6CbNh9yIEIcwJzeENyWnyFCt2+ukwkWts7s+R2HiC+VTuAAraFHuzaM
 WCpzGn7ft/JKMeWq3e53Dg03ghAc/SYy7go+6Dvk25671wOck16teL7OZYv1XK1WInJeA6+6NB6
 S79hHO85SPAHJfJB8AHTyqNau6fbNtLciP8HbfwuzkxjbjoFPRh/Mt94rylEi7IGSxwWSeVmI4f
 dv25GKEzRkhAm13609hbVr6HO/8MyK4ucORkPLuwvhs5caSYqUFsio85hH6ZYLsZ0v+4gTU2Mj4
 H+Nx8BUx4MoyJLB0OYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080170

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

Tested against: rustc 1.96.0 (ac68faa20 2026-05-25)

Changes since v5:
- Fix indent in bug.h
- Add __rust_helper to rust_helper_memchr() (thanks Gary)

Changes since v4:
- Patch 4/6: Use kernel's memchr() instead of __builtin_memchr (Sashiko AI)

Changes since v3:
- Added patch 4/6: Add memchr wrapper preserving KASAN/FORTIFY_SOURCE (reported by Sashiko AI)
- Added patch 5/6: Fix KASAN stack-out-of-bounds in atomic helpers (reported by Miguel, suggested by Gary)
- Patch 6/6: Document CONFIG_EXPOLINE constraint in arch-support.rst (Sashiko AI feedback)
- Patch 6/6: Added Acked-by from Miguel Ojeda

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
  rust: helpers: Add memchr wrapper for string operations
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
 rust/helpers/helpers.c              |  1 +
 rust/helpers/string.c               |  8 +++++++
 scripts/generate_rust_target.rs     |  2 ++
 scripts/min-tool-version.sh         |  6 +++++-
 12 files changed, 78 insertions(+), 30 deletions(-)
 create mode 100644 rust/helpers/string.c


base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
--
2.53.0

