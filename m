Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE53A83BF;
	Tue, 18 Aug 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064631; cv=none; b=AOcpsCZSm6ELFaUEB+03or2ll4NLgXz9Xp+KWQWwzWLtnBMSrLmBkNFHANA21XxUa9ePg6NwfTAY/mp6FstSM9PesUBx0zeUYyOITbnOV7Kp9mTz4GpXYSM1fknb+EE/VFghww/Fz/XpBV7CndvKHobcpCgmThR10vav79s5NFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064631; c=relaxed/simple;
	bh=CXyGtsG81Jje362NCcX1DJbpQJ04vztCnyVvNnO2UEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC9aBljn14WTHrIkdqNvvW2JNCbGgkbrDTXvbhmaGN90xmSenRPBf7ZfHyDu5hoQISohAMPb3Nx0jAr884bS0NEDiu7r57h7qB3Lx3+ToNRP4yfQ17Wax5wZ1D5+MjTQwa4JI6lc7XXhEcq5tBfwunf3+D8Dwpmkw+iJUfslBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fnWD5jLX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fnWD5jLX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3akj542384;
	Tue, 18 Aug 2026 14:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nr3NDJBPuN6JMZiT2
	70FS3PTS8cjMVDUb7jnJwSlxDk=; b=fnWD5jLXufQ9nlTjKRgdAQdzBwDOlYFl4
	52Pr5o5UGSwQk6VmJ8BwJJHgm2cbUxrwgYR9Rk9umqvu+uU1quKZnaQkdzscSAU5
	B0UYYeVV08l9MFiWefkORQTdrkEc4yMO03e8IQiPgjD67MxrZW8we56sl/oBAMwg
	1rswb1eGgc9F9ynchR3YkBN5zjBAuwkPa+spvWFNp0NMk70PNdYMiPy71jvk/z7l
	AjcWdnqUUcd0I/liBgHpf6JkVcw7Y43WnUlJDZERyinXoMwww5lEffkLoEz9pSKD
	2fLr+fagfhfgIDm7y0juFwjY/El5gG05P8TvmcnxxYgr2kA7O3T9Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8bs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfK9V029618;
	Tue, 18 Aug 2026 14:50:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbhge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEnvaT47448324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:49:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D66420040;
	Tue, 18 Aug 2026 14:49:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 002372004B;
	Tue, 18 Aug 2026 14:49:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:49:56 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v1 01/25] unwind_user: Add generic and arch-specific headers to MAINTAINERS
Date: Tue, 18 Aug 2026 16:49:30 +0200
Message-ID: <20260818144954.2320378-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84711a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=meVymXHHAAAA:8 a=bzoO1hpTG78L7GYmDxgA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX4CG38aez3I14
 7JFjNNMkq3aTGejANgcaCSauLftyhhpwzg9raaMbfpfyK3PQt02BWmGpvPuh/oEJcp4zvi685J1
 oGU6KXisEKqGhpBjggknjdjAHThKTvs=
X-Proofpoint-GUID: p6qFDlKRo-LvSHFTcB6etbf3_AKBGgZc
X-Proofpoint-ORIG-GUID: zE0OTYiw_Vjwwm_HHtEpUUKZXLOH4HIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX0OMewfk2ifSy
 3JWnW8UAhshJbXE0eqUNJrZpDUE+OXlV7ZgK8NOdazL4DODi9To1/WPq6MV/pQv4Z5UIbN9/mCA
 eTT49e6Fdl1Sg4Mk5LhelkGXrn7rugSXpdttxlyMGyDEgkr7WGyGK+N4EnAhHPSqFX40eymfdOz
 4F0wJ+H9vP6U+0FG3zOAdS4SIRe6HuH5AVBymF2nEboQsCpN1DenWjK4tFl3smkDup6L6FzMQbb
 ATkVeWpK2eOmsekJ3iIZkRJM4Z5vWcMuDOnhkhwzFi5Yq5YlwMOrljDLB4W8tcFad4hyucvNjum
 1ITif0I5vedtrOF6GlJKeJmIzLEruvtE/OTozIJcG5j9RqfoBXbWMLj98gJx6bzfIaoRmAAkmHJ
 n1JKNfm/UMYbDAtCBP751SEgB8+IC41FyHZJC1BlSniYfxoRqvKbdKAjlT192BeIrbecE3XwMP4
 vvzTIKP1SQyjvMuErkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

Commit 71753c6ed2bf ("unwind_user: Add user space unwinding API with
frame pointer support") introduced include/asm-generic/unwind_user.h
without adding it to MAINTAINERS, as well as any future arch-specific
versions such as the one added by commit 49cf34c0815f
("unwind_user/x86: Enable frame pointer unwinding on x86") which
introduced arch/x86/include/asm/unwind_user.h.

Suggested-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v16 00/20] unwind_deferred: Implement sframe
    handling" series:
    https://lore.kernel.org/all/20260521142546.3908498-2-jremus@linux.ibm.com/

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..e5738a250d63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28201,6 +28201,8 @@ USERSPACE STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	arch/*/include/asm/unwind_user.h
+F:	include/asm-generic/unwind_user.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
-- 
2.53.0

