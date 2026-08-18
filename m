Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BF3AAF6C;
	Tue, 18 Aug 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064636; cv=none; b=hnzZ31u6pFF3DkTEX+g9SGwpseDhGCSfkpdKHlKfUy8WNtS/Wk+qCtRPAiA5PPqpm9pfnbKtoTLUB9NKd6A8tX0bK2pjreXcrqQJk0661hp0m+hAMcUpvl9nQ/W1JVnabEb+MUCVeaPeDSq4dB+hDO5yHD86N563zcPPfEjJgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064636; c=relaxed/simple;
	bh=mjbWeWD3RUaWpcMHYgyfz+r6AYmiuuZS0pbMDMiJ9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7iRvClHsHQqi6t9kklm6C0g1T2J4NawWsRO9zASRSVkbIzjwdxtnwEuwNj4Znl1fffCCf08U9zfC+cT7PllaeECubV3Ei0bbtFqPmOwmQcxFJVSP/Afi3e15fjCQ8U1RwVxjxeOuPCTEn9AlGazy+w+DXyrny5oDI9wszHMov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j9wfh/EF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j9wfh/EF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3YcA505135;
	Tue, 18 Aug 2026 14:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wTG9wejM/V/WA1RuS
	E0To9d2sm5WdPohRXqZOazd4ak=; b=j9wfh/EFpQ7qoximmbUU5XTQgP/aUZ2/u
	4Wyzz1SCvCbmjFJSyykbkgUtYi02D6sEqxGKYXSXqnaEVJ1jVEF4MZ9FIn6GwmSb
	lW0QtpFdCESHa18dRXvoLW6KrSfJNZW6oUAMyiemaRjV4asG2LLPjqA/RGC76nan
	piu98n97ptp9Btnswyt7KnzAdPCnjn0YRt46UQlNvOVfPbAZWFAZroeOcgwsECxJ
	+OQkEpqzzmn9pHrUv64u+9nLwoloW+3d7fsyCVzwfJtW18tmXtJhhy/PT4D4z9ZA
	rrLkiAyzxnliDRiV5fxtzKVCmnl/aSaS1AM67F+eNu95ue5NQLCew==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4rx29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfKbW005458;
	Tue, 18 Aug 2026 14:50:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq3w3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo1hw46989594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CDD020040;
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C073E2004B;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
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
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 12/25] unwind_user/eh_frame: Remove .eh_frame[_hdr] section on detected corruption
Date: Tue, 18 Aug 2026 16:49:41 +0200
Message-ID: <20260818144954.2320378-13-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: der1r54IzDIcCZZ2V4d6xZ3mG-8Gga8K
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84711e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=sOSzolwKFyyup9Hw6m8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX2REDRasiGSI+
 b2CWYTfUT2QE2BH4zvYpcjbT57m2gOai8IfbVprBf5h54ejJ+KstLZUaMm0Qd7k7MFAAzN9dpuk
 x/i3/wNW4YI6494glQOTLmDFedbRKpk=
X-Proofpoint-ORIG-GUID: WesP5HBmGJMvL8wanLE9UTqFywAvJrON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXzZpoiAI9FLve
 zFD8Ca4Odz6KO7HLaiRs98xdC+7fpXXn/FbFIMfNzemPnAPZAzRoKW53XRxFaN8XI/mRiESCP7v
 gg3BQRrAl0E0iQG67Rq3PepqYVXMMRUPcSEUlPoJEWwb3vwJO6FBItBaGJMYkiBkdPUUoG8PcRZ
 +98t0TpLe1fXqBxGIlOW1+ezbN81k9AcYbk2OY0fVOMTHaG63dNuF5VAIr5qJfAapeCdet0gIxS
 M6UdPuDlsaSO/yQUca5u5Tsla1SmFtBc5Tp3B5+AUcZeniEWxu8qgSv3LgHYsXxjmNbFT2xwsPw
 zAHWFPGtdxbnUkE2ty6hkB3JucYeqp7prQLy9t4NxnXpeHZAbxn5tq1pkXxpjfpJIwjjf3VsCEt
 YU89ESZzWaW5vYLessLGz7QCbV0Uk2AOUiKOWGYFzq50rWx7XXCa+A4l4YM8nad6XpWi3A5k5yW
 ycKedISrcjYtGC55WjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

To avoid continued attempted use of a bad .eh_frame[_hdr] sections, remove
them on demand when the first sign of corruption is detected.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/eh_frame.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 5ef8fef06a80..7657291324c0 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1149,6 +1149,15 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
 	if (!ret)
 		ret = __find_frame_row(sec, &fde, ip, frame);
 
+	/*
+	 * Unregister .eh_frame[_hdr] in case of an error,
+	 * e.g. EINVAL (corrupted) or EFAULT (inaccessible).
+	 * Keep if ENOENT (not found) or EOPNOTSUPP (unsupported CFI).
+	 */
+	if (ret && (ret != -ENOENT && ret != -EOPNOTSUPP))
+		if (eh_frame_remove_section(sec->eh_frame_hdr_start))
+			dbg("eh_frame_remove_section() failed\n");
+
 	return ret;
 }
 
-- 
2.53.0

