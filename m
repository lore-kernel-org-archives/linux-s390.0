Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9303349CDC;
	Tue, 12 May 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583620; cv=none; b=YkxMUL+qD34+RJvBwN1cJ+9IDBG0Xee3dIkNQTB4qSuoxoRHc1Q78KMzPK/lbco7U5d07bFuZioVInaBDPiDnRInKWWGdcuvr1I0HR3UHg5v8D2QTM7LRuYlECHS2S5svWvjnGFKqAbuFjSYJSUT+vj58VwMTf+c0C49k5YslGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583620; c=relaxed/simple;
	bh=2WZRHH3i6vd9FPVc4SCN4ujkqJ9+Lh9O05zxKfV3EUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpkeaUqe8LwMH+ULPJzMSm+IbZYyBrWGdG0UnNc6MXh4q+9P/qyLiUr87KBzm3aCT/DE4CEQv59MyILsersYGNGy42wXEYN1AfDFQ033Zh6gmtrBwo803ZwwyrwwK3I3sM2W/YClgRlBuJcnY8XoZlO4/RJNK34GMOfoNjGQ3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hXD5tPMc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hXD5tPMc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK71453775506;
	Tue, 12 May 2026 10:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YB1Y7LeDn6e6LQB6WrC0Z59vbL9EfNPMvRXMXYiKZ
	2o=; b=hXD5tPMcgIxmfK8duDkLRqgPtAabL7WR/Lyjk4muFCjqU5cTppL/wJF0B
	hnWDhCBS7rMnWbYTM/HhFdUvm6Lk1Gh40tR167HK9Y3/1WwvFwGZScDpK+22uQB7
	LZ/6leGeiBbVP1efZLTin7PZ63isTSPP+JWOXU5HaoafpeQU1CUcctVT6NJcLo7R
	gf8rRmhzQhH8JkHM1xvjLmoUGLs+5Wq2bQKZPhk1VGZjclPmBaFxrKTXjuda3mLu
	d8lCoaHVVnSRgNwYOwOBEgHXrLeaX592BDY7v5Ggwqo9nk5WMGu+y47bIusPJ1ll
	cjOrVq+/Vsvc0T6jEjQavS5Hq5Ezw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6jhcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CAdTi2007015;
	Tue, 12 May 2026 10:59:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjtcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CAxWUl38470134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 10:59:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6978220043;
	Tue, 12 May 2026 10:59:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 162952004D;
	Tue, 12 May 2026 10:59:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 10:59:32 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] s390: enable Rust support and add required arch glue
Date: Tue, 12 May 2026 12:59:16 +0200
Message-ID: <20260512105920.2426293-1-japo@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a030819 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ynQKOEzQyDeFR-uBsnYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwOSBTYWx0ZWRfX/qPZRpjmmYUk
 KuO2sZLFr1mqkxwBL2JZaLMq8UY32EBrxeQYjif/EbOXVYW9K/gn2nZqnqvMRvuleAfjW0sQPX1
 7YR0X6S6BxIirhJkZQ7p0tyTVV8/M0x+5gyaR0C9YhR9CLu68wdPZNPcxfsMSDKluJ7a6V//OLc
 lmXT6PWC7BOJiaP/jHtzOGmt3j8fLC8uw0NZiQxm4dqubyM/LDkl9EjOIrUUrkj7znGe7fcCTyC
 rLzdPESPJsCCs2IVJCjY+uhAo6m/M9+7ZYxmeflkpKgfdE/B98TllgKhQD6UHBlljShlf8kNRkS
 98thTqqFKz4Gyebrs2ZIMMLiH147keXXl6KY7SoYu/R0/VdakRSyzYdewtSXse/7buwIKABr4D1
 8rZ6bk6j72TA6G9h4iGQcEvHzcHbR00aGhoaN12dE7PBVBTL/TZ1UvjmsD4cDD4PXdxz6+j6x4p
 951+ldvmdPYRwg/KbNQ==
X-Proofpoint-GUID: qjLQhv3-yRCwkDk2h5BUEEXtm_L7zWbz
X-Proofpoint-ORIG-GUID: AUJve3NagHTtBeM4bmA8gPFUp2ZD2y0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120109

Rust support on s390 requires a small set of architecture-specific pieces
before the generic Rust kernel infrastructure can be used.

The series wires up s390 as a Rust-capable 64-bit architecture, adds the
missing assembly interfaces needed by Rust for WARN/BUG reporting and for
static branches, and adjusts bindgen parameters to avoid repr layout
conflicts caused by packed and aligned s390 structures.

s390 currently requires a nightly rustc due to -Zpacked-stack, and the
minimum tool version gating is adjusted accordingly.

Jan Polensky (4):
  s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
  s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and
    ARCH_STATIC_BRANCH_ASM macros
  rust/bindgen_parameters: Mark s390 types as opaque to prevent repr
    conflicts
  s390: enable Rust support

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


base-commit: 50897c955902c93ae71c38698abb910525ebdc89
--
2.51.0

