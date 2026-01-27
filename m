Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E52264A9;
	Tue, 27 Jan 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528039; cv=none; b=niW5z7WXtciRZYuwtM3JQU6YvER02AaXqGw7KN1RpXt/GAqpLO8GKW2AdPDN/e9eAmywQOvRwMcoCDGIXCKdlJRzl151S9XK9gDNAveWc+zsrnhY+XzxQC7nav2pgdQkl9Cu279mME/SL3f/pZHkqGafgmyE9GVZihEcWxz2w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528039; c=relaxed/simple;
	bh=EpBc2FHK0ffhGaF7mlkEoIDtruuvX2HXLqlLkNSETBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYZ//+Bpj2AqKHHamujV98hUfXJNeRBpZMFm4GKJo/vOs1u1CjxYS/5h8nozaaQoTgEXEO2po/lCRNDK9JtYn9d7rrXOvqIKLyZ0yjBFwtsb57YrlvfUF5hH178KvrN67Ze9XMUYFgdyQJItI25ovhFpKlztZmIdJTFeEqDjx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dkhvy9d+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dkhvy9d+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6m8QM025155;
	Tue, 27 Jan 2026 15:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Mc6r+iYMRgrberR8CGrWZbZ9Aa1SEBxztvMl/a8Z4
	C4=; b=Dkhvy9d+NcOe4hKzfdaNVYVvOCMPx7Q7EgqhXBjz9fRFHB1YaK0asD2lp
	CSLRY6PhWCah86tb9LvGMYPDiMDVGpvQf4lxvb1QOslAry+4zodWK6S3iWDeruuc
	aJtTwWkA/h5Z7QKESVs7S9G+N6hBJ+VMWBJgfZBjZtL6+2wMHjeIj4NW2p9ghjVa
	oGdkah4rCFy6W3yR2WjrehbC9eA78HFbcgxzLhNotB/kWFupSxwg+dW0ax67IKQU
	cJxwvl78TClzxLcfd8EihkXh3qKWfFGq/TPz0rCth0iV/wnEui55jrrJxmS3YplC
	RyQzJprtduIRB7/oPspiq8cAnaDQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmnmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFPkQR011392;
	Tue, 27 Jan 2026 15:33:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmnms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REAE6p023722;
	Tue, 27 Jan 2026 15:33:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjs0db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFXXtC37421338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:33:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD992004B;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F9BB20043;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v1 0/5] s390: Signal frame user space unwinding
Date: Tue, 27 Jan 2026 16:33:26 +0100
Message-ID: <20260127153331.2902504-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978dad2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-DFb8COQO-JfHJnukBIA:9
X-Proofpoint-GUID: Ys0p0zHHAEV67WKyQHCGn2m5psb3utxh
X-Proofpoint-ORIG-GUID: mIfIllVlH_-SlIOkQm4Vg7DE0Yvfz1tw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX8atlURJtagx7
 Z5yPL4TLRF3BbfGaXFPkWDZvHiR4r+QLofL2Y2TRrVz7gK2KqRjqtGLpcBNp47/1vqmQWM1m57m
 lOJ9Kv58VcWSJ/GWfOxSaIIJhG9y9SVYspYUQQBxZbNqwEeay8RrHkOivurCKOta6mhZYcAYOeQ
 SczoBUCE4edlS3kg0CfztfCyjs0ibtMbbyGyr1ohmcIuccK/NSUej5WFf4LnaRDHgqM3f+wEuLZ
 ojKqFe6x3cLfoOEkb0+dk8ttuTFlOFo1YiU6Xa7rmdZMU3oq6o1mDnDV0Jj45/fgUYyDOKgNnc3
 EZiKMCLr/LPJtbcwy+IzYbUCgPuTbiUwBxD5RVJMsoQqw7bZyCN66tMmys8PDXk4teDMSuCbzT1
 j53ihPmrWI5Dcy8GhTTwgbHNQtpu5n2Dh17AxReWxh37qLHo4YCV/8Hkd39XQCzTE2faAMb63/P
 jhmk6ZlyAqpHbphZX5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

This RFC series adds s390 support for unwinding of signal frames in user
space using SFrame V3's indication of signal frames.


Prerequirements:

This series applies on top of the latest unwind user sframe s390 series
"[PATCH v4 00/12] s390: SFrame user space unwinding":
https://lore.kernel.org/all/20260127151926.2805123-1-jremus@linux.ibm.com/

on top of the latest unwind user sframe series
"[PATCH v13 00/18] unwind_deferred: Implement sframe handling":
https://lore.kernel.org/all/20260127150554.2760964-1-jremus@linux.ibm.com/

Like above series it depends on the upcoming binutils 2.46 release to
be used to build executables and libraries (e.g. vDSO) with SFrame V3
on s390 (using the assembler option --gsframe-3).


Overview:

Patches 1 and 2 enables the common unwind user (sframe) frameworks to
support signal frames:

- Patch 1 enables unwind user to resort to an architecture-specific
  signal frame unwinder, if a frame is a signal frame.

- Patch 2 adds support to unwind user sframe to provide the signal
  frame indication represented in SFrame V3.

Patch 3 annotates the s390 vDSO functions __kernel_[rt_]sigreturn()
as signal frames.

Patch 4 moves the s390 struct [rt_]sigframe to asm/sigframe.h so that
it can be used in unwind user.

Patch 5 enables signal frame unwinding in user space on s390.

Regards,
Jens


Jens Remus (5):
  unwind_user: Enable arch-specific signal frame unwinders
  unwind_user/sframe: Add support for signal frame indication
  s390/vdso: Annotate __kernel_[rt_]sigreturn as signal frames
  s390/signal: Move struct [rt_]sigframe to asm/sigframe.h
  s390/unwind_user: Enable signal frame unwinding of user space

 arch/s390/include/asm/dwarf.h             |  3 +
 arch/s390/include/asm/sigframe.h          | 78 +++++++++++++++++++++++
 arch/s390/include/asm/unwind_user.h       | 57 +++++++++++++++++
 arch/s390/kernel/signal.c                 | 71 +--------------------
 arch/s390/kernel/vdso/vdso_user_wrapper.S | 15 ++++-
 arch/x86/include/asm/unwind_user.h        |  6 +-
 include/linux/unwind_user.h               |  9 +++
 include/linux/unwind_user_types.h         |  1 +
 kernel/unwind/sframe.c                    |  8 ++-
 kernel/unwind/sframe.h                    |  1 +
 kernel/unwind/user.c                      |  4 ++
 11 files changed, 178 insertions(+), 75 deletions(-)
 create mode 100644 arch/s390/include/asm/sigframe.h

-- 
2.51.0

