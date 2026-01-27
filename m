Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAA35FF4B;
	Tue, 27 Jan 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527203; cv=none; b=VPX8iA3m5XPdwN2guhU3rVd3yptjTg//3w+HkhkpEoT+pwKePPXtkQkHSKT4m4NlWr8NSKQZngmgPxCaaHt8+o4/huZB2VtTS+uxQqXPMMp3NBQpfFrqq+lf1+7Vb9QqWNpimVSKE6LxGIKj/OiqQNyqd7I/Xa5lDl6iuApkbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527203; c=relaxed/simple;
	bh=ssH4QO23h+UP0S6GwfDDv6/M4ysuLYiQn+dNM/0nlEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MP94VugVXQHnn9VxmTvtyDeoEkhaIKRX00twV2pLg7+KGIK4rAVeaYxK6wVFAsIcLVmqT0LD0SK3GNN+tLnH1qaOUS25dgTVJro/EsqMS2NffrmcGATvIRxYwYa8RzpL3rbcGVzRVQqHwmuB7SPVBSRf9VWpZCWInEjSLH6lNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cmbfAhlz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cmbfAhlz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R5mfuP027227;
	Tue, 27 Jan 2026 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UxlPh/BRlvAOcC0/c
	WMxCf7Av6zcp28QATZWh5Nh3SQ=; b=cmbfAhlz1uswpATUc0m6/Mh10h6lucG92
	Gi7sO1grxAU4T2pjpLl8MCDMaQZnbtOUjplDm3OvO1wZ2tLfwj2BDuV3q1Bme6LP
	Gakzxe6ELzqK8LXp6yETbl72NIVJDXxEwBjZB5At4XuzYe3DteLlCluKrebw6Y56
	eIn2AqUjlIBOrfaWl5E2Kieuk6su5PNTOJsF7Kl8Y5tWsOvTcvvLrjO+Py6aJ8Du
	0yuPCK9yoQxOa+rub5xnQGDFtENBq2bUhfQ17oFBaqlH99YsV4Mcgt4OYFeBD99c
	bcN6Pg1Zovebdno7okhdinXt2eArC5x4EhqiYjPMvDPDtQOtZxnQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60REscNb019500;
	Tue, 27 Jan 2026 15:19:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDR0eY026357;
	Tue, 27 Jan 2026 15:19:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk930v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJX9V24904256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BBA20040;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1134C2004B;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
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
Subject: [PATCH v4 06/12] unwind_user/sframe: Enable archs with encoded SFrame CFA offsets
Date: Tue, 27 Jan 2026 16:19:19 +0100
Message-ID: <20260127151926.2805123-7-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GJU1NxnSV8_CkvJAce5SPPsF0ls5J7q8
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978d78b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=F2OLnndEFUwyb2Hjky0A:9
X-Proofpoint-ORIG-GUID: szHCqXrRk7xpKVwgi1SdQYceHPmsBHLo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX7DJExOXoYzwt
 7bAAezZpIYG375vGLCZoHpTOLkOCivXD3I3CwJ1PrVakrSozMBuFfqo5X3cfvVO6e86Ocqt76bR
 2TE7l6jd2pI1hP6Hd7ZfXUO+TgpL/m3gewtC7Ki5cbXh/zGot0kGQTb/jynVGQcdC1ESZCBVuIT
 a9AYs3Vntv48qUq+JZC827TS59DbK1/LfY/JQ3e+DkOp9xcFf2hK+djIOtfZt66uhcZLrERqi29
 B9jBxX0cBllN/UIv+yrE+T1maRUTTthdmA8e9XkTDWaw293ejfSvugrN+lZwemLKfqWBflOcY0S
 drPMQI7Pzn4HTs3eCqRdnDKY7/2221j7bGdINSj/Lon3UFbfQqa3CwL+1ApsMt9JV9GqakhdriD
 lZkCtWcUbNg9khA4Q6PpGHLymDNp+VnrejLcNNIu3VGtMF9zxpqqcHGL1lO19na2H5PtxdNtJtJ
 +QClNmWRte3j5ZTTMJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

Enable architectures, such as s390, which store SFrame CFA offset values
encoded, to e.g. make (better) use of unsigned 8-bit SFrame offsets.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Rename generic_sframe_cfa_offset_decode() to
      sframe_cfa_offset_decode(). (Josh)

 include/asm-generic/unwind_user_sframe.h | 8 ++++++++
 kernel/unwind/sframe.c                   | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
index 8c9ac47bc8bd..117b05e1dcab 100644
--- a/include/asm-generic/unwind_user_sframe.h
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -9,4 +9,12 @@
 #define SFRAME_SP_OFFSET 0
 #endif
 
+#ifndef sframe_cfa_offset_decode
+static inline s32 sframe_cfa_offset_decode(s32 offset)
+{
+	return offset;
+}
+#define sframe_cfa_offset_decode sframe_cfa_offset_decode
+#endif
+
 #endif /* _ASM_GENERIC_UNWIND_USER_SFRAME_H */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 6a6221ce6d12..5ac502f16bad 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -209,6 +209,7 @@ __read_regular_fre_datawords(struct sframe_section *sec,
 
 	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
 	dataword_count--;
+	cfa_off = sframe_cfa_offset_decode(cfa_off);
 
 	ra_off = sec->ra_off;
 	if (!ra_off && dataword_count) {
@@ -258,6 +259,7 @@ __read_flex_fde_fre_datawords(struct sframe_section *sec,
 	UNSAFE_GET_USER_INC(cfa_ctl, cur, dataword_size, Efault);
 	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
 	dataword_count -= 2;
+	cfa_off = sframe_cfa_offset_decode(cfa_off);
 
 	ra_off = sec->ra_off;
 	ra_ctl = ra_off ? 2 : 0; /* regnum=0, deref_p=(ra_off != 0), reg_p=0 */
-- 
2.51.0

