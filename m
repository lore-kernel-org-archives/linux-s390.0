Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A435F8AA;
	Tue, 27 Jan 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527202; cv=none; b=Uzv0h12FyZvXgNDXvIwdD6G4un+WLqkDl/RaSLUt34/5yXrh1Z7Job7Hnh8Hr4DbrRrR3YUKu8hlXjf0eVlBovV1BJaL8zAasnqkvFq8gMBRWGMjLmClrLtJ+md+sKua7icq6E4xT/J6wepqxRd2RMSEGV0eS0xw8paQI9rFSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527202; c=relaxed/simple;
	bh=H7n+PXjV8neMsqTuIFC/9Axcasrr7i/IkPwnMszgmMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVinttglADn3Zkyrt3Ot9JqvVsBZyspqvlnHMsfV79ns77uyIcCVgZEd8X/tJYFbYCt/ArblTkUoyLY2KNO1uiv8qzZN75jDRlSsamEIcMc/WINsl77U2fThEKatvQeLPc9pjUoizu7tTzoDluI65vbuaIQyaCfz+CulYGT6DzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I5lyJoiW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I5lyJoiW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R5RUYZ015650;
	Tue, 27 Jan 2026 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VVguAxILxTzSbNQu5
	WbhO4HZgS7zsxcqLOGbA4iC9kQ=; b=I5lyJoiWqfflGSV50GESF32joTAKgeD6y
	uDdL+CRQrntl6H9iRseeipo9Z9NOfjKBRN4w5fQNITJpcuV/mZkOW1re4HiDrzC4
	+eQ/+UKoCKWLq/jJjOYv4Umhs5f0L/cd8ZjhyUhhyUC73+Rst0V8kHVepzIiFjzQ
	jmD3I1Y/gAKFZ+8+TMfQsVNTesWpOPYUslbJJOpGIXH6+dJhNO9+dM1xb2hJCK2k
	/gdgo++98UMcssSj+ddqO4F7DIhZ+Ptsi/7kG7n10yGeImgdzdIEueliNjNM8aP6
	VkM4c/Y6bBXBVrgQ3gOi78489tbox81sioOS/29nuSw+2eSwHHHUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvfg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFI9iu018687;
	Tue, 27 Jan 2026 15:19:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvffv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REPhrk023625;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjrxxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJY5W38404446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F95A20040;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B5382004B;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
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
Subject: [PATCH v4 10/12] unwind_user: Introduce FP/RA recovery rule unknown
Date: Tue, 27 Jan 2026 16:19:23 +0100
Message-ID: <20260127151926.2805123-11-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6978d78c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=x_8ZRXsrtd9nfFZNwNsA:9
X-Proofpoint-GUID: 2liHwGDL35txcMt1JbMxG85YwdANNyhk
X-Proofpoint-ORIG-GUID: SNQ0rbTEN4EF7Ncey7g7ggyMk8JeUV3m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX/IpkcQvkBXRt
 TR7vEfeM+NzVU5yTDtU3SrLfGK90BVlTaBBPog5Ek3lUYhD5O/x4EK8QmNWx5Rk80eMu6KSm73b
 5743IYUxo6KU9ZR8HXFlQl7zF3rwWjwsC1PbZH227RceMLeuWXFaE3OB5QUKilBAB6CoRU8zbaO
 7LtsQ3Due9IHam/lq+7PRZYdmGp7IBpIc+984x40DdiWXS6vjI0MesMciCwVMZYxaLtSSauIjen
 T+6zmBzc+Q9IXGIzicYUrCNRcRuHPsYsPZVH0R+Ld+sVM/jaFezgn1gDzx99lZx5VxK0B2lbZGf
 WlIker8vV/heDP9TP3Azd1LGWBGR71DFHaqYZh+9Ie72cT7WEaUcmq2jk0AhXPSEo68LNdXPCfO
 EMIXrTvl4vSHRW1JHQwfin3ZeyuXBw/oOb9DivPuWow9M31YpOMSx2vp4JbLsGWOc4SItGY4Gzz
 vM7LzhjHbc7RP9ZJbug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270125

Add support for the unwind user FP/RA recovery rule "unknown".  For the
frame pointer (FP) set the FP value to zero, so that subsequent unwind
next frame that rely on FP fail.  For the return address (RA) treat as
error.

This enables to implement support for unwinding of user space using back
chain on s390 with a subsequent commit, which can only unwind SP and RA,
but not FP.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v3:
    - New patch.  Prerequirement to implement unwind user fp using back
      chain on s390.

 include/linux/unwind_user_types.h | 1 +
 kernel/unwind/user.c              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 89c71a4553b2..fac8f470b597 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -45,6 +45,7 @@ struct unwind_user_cfa_rule_data {
 };
 
 enum unwind_user_rule {
+	UNWIND_USER_RULE_ZERO,			/* entity = 0 */
 	UNWIND_USER_RULE_RETAIN,		/* entity = entity */
 	UNWIND_USER_RULE_CFA_OFFSET,		/* entity = CFA + offset */
 	UNWIND_USER_RULE_REG_OFFSET,		/* entity = register + offset */
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index e21d088f7543..036328cb9ee8 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -114,6 +114,10 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 			return -EINVAL;
 		fp += frame->fp.offset;
 		break;
+	case UNWIND_USER_RULE_ZERO:
+		/* FP cannot be unwound. Not an error. Set to zero. */
+		fp = 0;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -EINVAL;
-- 
2.51.0

