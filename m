Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7740F720;
	Fri, 21 Aug 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342026; cv=none; b=EoWRHcD237qNvhW9w9DkAfsyLz9pH5k3GSC36XA97W/xWlLSqGCPfhy01bxYyLF0a19t0zz8NIBLwkx80VB27lb7WDQTpkL9eUbiR8CsLMQOdnFgg90801I6WjgaclIGZ01tSs2BtqumrZ9TtGlirXjpz3EHU1s9C7lqEZAQxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342026; c=relaxed/simple;
	bh=M1KvrJ6D665U2O1Y4c7wBpDUGn1F8NtBsXmty/EIsrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/ORKktICKZIsA3rDrFUTXe7ftErYCl0hPyltCG90Pr1/Nw/GeTRGsc9q9phxngzsff2XSTroDVBvRRnlFPTTQMeioHKiUhTIMMZ0WMEPGAwHvWXZ7ThBvuvtj55uyVJoNZJ/ubmhJMEutXI3mRnlOacl/ZM5+Mas5NwwD0SxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eLzh3U+I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eLzh3U+I"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVf3d2387540;
	Fri, 21 Aug 2026 19:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a08TLJkK4tjV5RcUT
	N7phu2xyYTSc6ax/xOBLLidlG4=; b=eLzh3U+I4vclSHrbeeVQWJaxPsAIc6z6x
	pO3ROgDn/8GiKyaGtegTiHAHsGVN+uHBDG2zIlE7d7Fk8W2+7W0OWSRCQ+8grsUx
	J2Ls9CajgofVHwXXCKsKA3zDwwLaqTIaN6L9A1EeE2TrTa0ne4bUOMPgvdE/QSJy
	8m1vfUhsoMdR+O68/6Zo5UDIo7c3cauiMwrRJBVstVRWTWsU0um/3CUmasNl5caZ
	PUI1/B53xYAzfvnkQEnE9FTnb7f8WmaVjCGdtM4ozWJzbq0VKRHaMbTt77gD0eXG
	iZHEaiN558oRwETLxcchScriwv8gL8zx08dwmtuXg7mRFr/XQiPdA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4kns1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfHGU023473;
	Fri, 21 Aug 2026 19:53:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twpraw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr8L842861030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D2920043;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5772D20040;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
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
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 12/24] unwind_user/eh_frame: Remove .eh_frame[_hdr] section on detected corruption
Date: Fri, 21 Aug 2026 21:52:47 +0200
Message-ID: <20260821195259.2688377-13-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88aca9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=sOSzolwKFyyup9Hw6m8A:9
X-Proofpoint-ORIG-GUID: YytZiVDjTCLnHUHldcwXwuOsSv6yH0Wq
X-Proofpoint-GUID: WVqLuEpqhkkV7vsNZsNV71jZIU6aYfwM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX3IkZ1tJvYvJQ
 RIzE9ax/Gg+fFx9w7JOsCaQTnhW6LH+cfYFnGHbYIP98oIZZFMBWSfZPIjqtg1DO/psyCfu6Wq8
 0uXWr7h/8vZ2n/S7PIOxsA4blX1yjiQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX9S1ylM4qJrQ3
 OMoyuzRuNXK8jyJfUGPDv1Zj8t5hwWzFPLw8+PJMtmsnZEPrjWAMDC4oHqzhb2c2ROY13kYEPEb
 bgR9Pm4BjRhdoBFImQRb6P41WegoLfJYj8hU+O1LFNGhCMfZYHepCFd6no2LulcjcL02ksDn2cF
 VDNhPDJ/RtjE2TbMhAxHEyTFfdG4kMxnQ57dWiJ0+eSLeteIZcZJ8GEABs/HjO4ZvVXwcUuD3cr
 hSSPM0hKjthy+JtUu2i9kMDe5YRDmlHEg6JSuoUVbbVXl87wO2Pnj7CiHFWNgh30LCOuPwyN7uo
 vdDFI01SIe//xy9ZznXyYtcL74HppLHvfkzt8S65XV1NghEZzEtJdoChP3wa3d7u/NzLS3hCJvE
 H4vlY6RpReLWZ8XtTkxW8DkvrH7Q4QdhRBV2pNCPUKqE7o5YXIRPuj3aTO/1rVF4g0YefPR0g0c
 UYxw1zebLYEq5d5uhEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

To avoid continued attempted use of a bad .eh_frame[_hdr] sections, remove
them on demand when the first sign of corruption is detected.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/eh_frame.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 21f40805b417..327849ea4a69 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1202,6 +1202,15 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
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

