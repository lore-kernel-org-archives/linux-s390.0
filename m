Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21B13A3F7;
	Mon,  1 Jun 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336039; cv=none; b=Gpu5C60enTqopYkC+fR9Di85e7lpKog+u0tC9fj77HnyDlHUguY8G4ThX25NCyE6ND+7RxUQYcQH47KL7mt/COPCxFGbUfXRprd80sLe/VuZwPy8+D0QPhl++tZbvY7jJaUZNwHIuhI3yb/zNYbAoGYhv+vsCLyDD30+v4imOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336039; c=relaxed/simple;
	bh=12Ulb+bLrNJoDk+LtXMs0PsDnt4dAYjLlcrarlaThQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDPOYU3fo+g1g4pEp3m9yL832mWbJD95G2pxOjHzGGLaLxcGx+zojQIdXzeKqUfTQ+yUyU98N9XtWyPegU0qQgErsaWI1KpRw7K8m19bkCBIYTyT91Vj9Y4Q0VqwUxHRoAXw/ol1rsVcQcUP5jqeSimJXOLOeyUwIvpxhTic6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPrIrvhH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPrIrvhH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651HPWDB2223981;
	Mon, 1 Jun 2026 17:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ploDqWExWTLyife9LX8UtceI8x0K9B5b6MEIsDKE0
	c0=; b=lPrIrvhH161dxlBQLvQwjC3y8NFzCFp4FrKvNJul9cCLZZWhugfxe5BbU
	ynYuDx/8RYKMXzguDsmoDyOAw8oYmPIrPtLxm3Nb9QzjZzERtNfx8EloNcbuEUrj
	7SjxhrkquO3bxrDVBp4ROyXo8J0wcVjL1P+/XTCaGecNDEFzxum3opNwnNx0P2t/
	1Q/ASIPYOYgw5tx+mBVorpJFTjNXOR6y+tkynu1Dqty1ToGJ79MnRsZPOI18yGFD
	8nMg2BIZRJhuj/fd8xxzn1rkDbXeoMbfXRTMC3BV8Jz/v1AWA2NYbCIFYAz8Ghgv
	hdnTAbNwsyZUmqUuYi6CWnH2fgBXQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd427sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651HdAKb022643;
	Mon, 1 Jun 2026 17:46:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh7abj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651HkkoY16777676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:46:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66ED20043;
	Mon,  1 Jun 2026 17:46:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A62B20040;
	Mon,  1 Jun 2026 17:46:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 17:46:46 +0000 (GMT)
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
Subject: [PATCH v5 0/6] s390: Enable Rust support and add required arch glue
Date: Mon,  1 Jun 2026 19:46:19 +0200
Message-ID: <20260601174625.2910233-1-japo@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfX8Dwa4TUsyWpt
 5u3joflQNjWPutCM2u61bZcp5niIFH/HfyeAJEXPrOVQQsXkNzx5/gFj0YoLDAh0RbumjZaMD4I
 lu8ajfIHS1SDw0wpeiBWcp/sE25jN7S6apg/z209oQro7CTTtK3M79HHyFLLqkZCUnUq3ha8RJ6
 ssYlwXeUHQmJoyH+JIYMzxCs9qW0K/R/9NciddqP6jHCNgJKrgGyW2VLGoa46ckoyGdxJp+UUVi
 PCTBuNKFNoYDpLlI+5QeNJS/RRrKh/wjDWnhnBQEduHPjGTr/ulQgRtqD2Ty4CCN+cQ55Qe70eF
 K3Y/8Czf3hztT+3rBfHxoMs6YqUBHo5KaasJQaz9NheK0srJKKm4hGswwDynUsXEYXaYXKPYLPg
 CQMcbdAqsS0N2uXx/6G7ZYLKUDWgbP6CyMmW6mav0LZvSJJbpZ+dkPbs1/DsRBNW3G9F2o6IGbD
 C+JtSwk7+GEfY+G7BWg==
X-Proofpoint-GUID: 0xPeSk_kBnetVaZoeI_CRkGnCTwqRzML
X-Proofpoint-ORIG-GUID: N3AHrXCRoESrVEuX6rI4x_27S-w_FYlq
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1dc58c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8 a=YnCZDFda9O9yJGHsuikA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

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


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
--
2.53.0
