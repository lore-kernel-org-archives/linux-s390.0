Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C23D1AB7;
	Thu, 21 May 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383013; cv=none; b=GnLhal39njnlfBiGy+AvKO8o6VzuLr+BuhxK2v++V6OOLH7osWjDtt1hb79ne0CiFeuedcT7sI3kBSUDY9qgj8rHIurNcp2fXxv7wziTqqueI13dUepht+QuIyih0nBXruit7BOWA1i4d1ieIN1Nzy/Tu9GAYeaF2mvInTXv4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383013; c=relaxed/simple;
	bh=HY10VD7oWXvc7cyaoJ4AJuGF15+lES6ZTfCnvFIIMbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFDVJXnafBYfRrXUqgbOXolRKTgzlMwOqPDMdZKaxN6pzpUDagW5EpmiftQbcWF6943f+1Iuw1otrJ4SlejQbDZkZLFAQne64WVfANPdb+oGE1yOWbKqHFNYPJgNN5eQc/3sxGVe2JVN4fgGGPmOI0mL+/7sWD4ft9KtpSfTlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SuAQwS0p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SuAQwS0p"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L7KLfS3727812;
	Thu, 21 May 2026 17:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=52hvEANRK8RdzKxsEREuLbPOfReZJg0uDDBkFbLYg
	3k=; b=SuAQwS0pv2bvZpxmbCqJ9FmoKaGTSEwkC9aAcfNV4n/uDHkIeBW9XG0EV
	qXoBxSwlTXY9eqXU50YTVITNN44KlshavgiDpEaL/mdl4UxSSBOBlxHfegsgD4tk
	3R6nt/iKo0gVK4G25q4lv+sgNybljcVL/4w5e6q2gbf4kjiEAn1l+2s+Hz56kU7Z
	n9WHhLJR8SLErSLN94qu78QzJpIWzbg0e5D3plAksyeto4mJiwEAuZ57bqsyeJRi
	13RP6CoGMpd7N35yHVrAF7vXPtCV9pu3EGkFGUNhw+a19P+6wK/DyNmKQcZesSZC
	yObrHLNlg4jajdO+cd7h+hK6IOOaA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h7586cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LGsBNL013529;
	Thu, 21 May 2026 17:03:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhw7dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LH359R44368348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 17:03:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1C8A20040;
	Thu, 21 May 2026 17:03:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9555B2004E;
	Thu, 21 May 2026 17:03:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 17:03:05 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
Date: Thu, 21 May 2026 18:56:18 +0200
Message-ID: <20260521165622.279953-1-japo@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0f3acf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=ynQKOEzQyDeFR-uBsnYA:9
X-Proofpoint-ORIG-GUID: FcvH7iTmKM25oyrjW4HWmxY3jfSDcnk5
X-Proofpoint-GUID: SUHkONwSPJ2WK3eMzTh8Jf32T3gK1kQ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2NyBTYWx0ZWRfX+lee+y1lkyeO
 iDQgricShLtqW/RjxgSHydHyeJ5O31rJJYWqHsuyVn93Sw/VG3XORTu3vHKTnOc4TsGxJDMuX0b
 M4L/mJHqgdp8EJzqWnt9IJaq1GbvLtLBCbPIfumrZf+CITrlGKOnVelvdpzZNFupTwD8TKtkV7e
 2PsmrZE8mcC7ZJPKOx7m1JHswr1kZheAt6s22UAYjTQa/bcmot0iXLSReHh24xLMNGgmwJks7Rc
 eylCNcJMk19DvCST00pwmBor3BlL7Ji+ZBqh+6Oty+X3TVe+aAzDE3Gy8xiCCnD6yPzd3ABJqE9
 05PMvZF/lO5F63o+EXH7pAh0nZtFXO2EFRYiiflQD0PBk2YMxsOj+XK86NZqwOxDbUp5i+Wti5p
 S5DBKnRi21RZvQarv1zFX+jyESY22COZaemBLk4qjlI51hPFQz5TuIwizYIvKISfMhWS18cK0HX
 WkW65AnlwCcl8zbD8qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210167

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

Changes since v2:
- mflags: cleanup (thanks Gary)
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
  s390: Enable Rust support

 Documentation/rust/arch-support.rst |  1 +
 arch/s390/Kconfig                   |  1 +
 arch/s390/Makefile                  | 28 ++++++++++++++----------
 arch/s390/include/asm/bug.h         | 12 +++++++++++
 arch/s390/include/asm/jump_label.h  | 33 +++++++++++++++++------------
 rust/Makefile                       |  1 +
 rust/bindgen_parameters             |  7 ++++++
 scripts/generate_rust_target.rs     |  2 ++
 scripts/min-tool-version.sh         |  6 +++++-
 9 files changed, 65 insertions(+), 26 deletions(-)


base-commit: 758c807bb943138f887d42d986b645e12446ba9c
--
2.51.0

