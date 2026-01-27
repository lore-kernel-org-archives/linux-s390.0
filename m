Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685D361665;
	Tue, 27 Jan 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527207; cv=none; b=CAL3x4dTGliARF3Y26kZ4Djf4to+iuN3g0SR5dHK1VFWk+phNYQeidHD+CP6gNvIViHOjop6+JGMG5OQdFKmXbIKrHqXuoMYBRQVC8RufuKpVpFMXUFPDAXWTgxSd1eh9p0TIYlhpNZLpJr0RBPrBb6vDrk75JCXwy8yJqdfj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527207; c=relaxed/simple;
	bh=PZHIpBGCcmOjceWawsZqoargbzKlkSzOGaAf9rH/SFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNbdjr9+EcrYiaapFrUtoIDSOHqZa1gYNY+umcWRLraPcKGe9y2TuCAV+uK3DAVIb6x+nEGoSKK5aFW146S6eFW6tx7BwhBKDU99EHvNCFTiE1ego5ulA7LjsgmhuRByp07J29GXjNFihhY1JuynysCy2r0oapDtC1Y3weCB1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0vVIQZo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0vVIQZo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R8eKXl012953;
	Tue, 27 Jan 2026 15:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CT5Yzhhna9QHI+XdQ
	9N05jfgb2pmqt4zaAgcbfvxQUA=; b=r0vVIQZocOIFPJ5TKPc5oKqHjmfy6i1bA
	+Sc85M+57ycKuuoZZQzNHchKu9+Gh/iWHRyYHO3Mc/P27OBtXZpuYJu3o5B4j/Cw
	oCMYkHUfT5eZq3kkPI2wfvWPZ6114oQ706uNA29qY8jQCamUAKBU0byNWhSvW++9
	ABzRMwZ+uH0oWshKlPjA207p46oxhnlwLZMH/VE3h/zG84rP/6GHng13TMUf9gNR
	rnb+Bce6YqtpUkxlJslEl2v/6j41lwZyLT77ZjH4UVMCfywDg6TP0SaGbqZwo7Ck
	3i0KvSEmYc8cTjT2KlHDsK9iBtx81PKSbNvJCVGmYbJVCapAC1Lkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmkpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFDub6019789;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmkp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD0BbC006711;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy97xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJYat38404442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E83D320040;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A42F22004E;
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
Subject: [PATCH v4 08/12] s390/ptrace: Provide frame_pointer()
Date: Tue, 27 Jan 2026 16:19:21 +0100
Message-ID: <20260127151926.2805123-9-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978d78b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=qpzfwOR0HA9Q5Rrae1MA:9
X-Proofpoint-GUID: IOw5bD2h0m9jWjw8gNZmyNkz3GINDcA-
X-Proofpoint-ORIG-GUID: N9u8KjS7k6vBnqvMoArQJBk1byJqa5tM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfXynKNwWCmOQ7h
 sOwsj49HXJczAzUjwjeZnwuk2sVFIiryzHKdOJIVXZuKB4X68W7jKCjnu2EgKYiJMpbI50WvGRm
 IaIBFz4N+3+0paxms/vQh/2U5sB281jHIWkOZ6DYOVAOoyVzeQthcqmyT1/KuQxfLjm7nEB4v1Q
 n+uRp7a7hAUB5wsjD6+uhZzbc1xzZ8dSyrCCYGXOHKkTv7z1tW2jJMtb17tUllV3/ZfX8iyj708
 SJ21nNWIE8ACvWfrB5f1tPtnk8Va1zYuwWDLNE/IYDxvLdI9MYBAEIYLDhZfdLdknyeEScgN4ni
 CuYFYASMy8Epl+fWH6iqMhlPlEXXIKVgRTENj4YBjLDJ6dKmoXokPdKZS3fUTz/VyJHY+HkXAiA
 4st5S0IbNmje8v0rYBu/A2w9c78+lN+NbCDT8lnVoW5IHVfUzvw/PopbJrK1uRj8emq212ZrnVx
 c9ewJ/6dWWBQ2/BliSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

On s390 64-bit the s390x ELF ABI [1] designates register 11 as the
"preferred" frame pointer (FP) register in user space.

[1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v4:
    - Split out "while at it" changes into separate commit that can go
      upstream independently. (Heiko)
    
    Changes in RFC v2:
    - Separate provide frame_pointer() into this new commit.

 arch/s390/include/asm/ptrace.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index e6ec0ccf3d73..8f18d00b5fdb 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -250,6 +250,12 @@ static __always_inline unsigned long user_stack_pointer(const struct pt_regs *re
 	return regs->gprs[15];
 }
 
+static __always_inline unsigned long frame_pointer(const struct pt_regs *regs)
+{
+	/* Return ABI-designated "preferred" frame-pointer register value. */
+	return regs->gprs[11];
+}
+
 static __always_inline unsigned long regs_get_register(const struct pt_regs *regs,
 						       unsigned int offset)
 {
-- 
2.51.0

