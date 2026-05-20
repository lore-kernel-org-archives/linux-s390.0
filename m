Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690763C0606;
	Wed, 20 May 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268993; cv=none; b=Lo3pjOOUWouZxPZsDTW2Bcqeh06JWJs925+NcDOfHwrnujJ3qStB5TWuyp3zP86KMj9ulaIb5MielukW36aShDvs44uKN79W5VDhBMXJi70ydOYOWCrhMbgEO/LbncevOxh+TlJ3/dbDab+xHu+GNTMBylJuRDZvNKSDxAdXdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268993; c=relaxed/simple;
	bh=nbr5dP1YOyyVLUxt7iV3D1/g+/nZYc1UjbTdnhs+sd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSFpCSv584xtVsTQtsU2ETWw09EnU9SZBivc6v4khnUKiw3XaTDYXQA415C02SVQ6abSZub2cMeAiWw19tc+jpcZZngXPKTqxGUJ3CL+09ZFDDGG3EPHj9j7pC0h8FA0Yl7fZzmHss4fyQFwhkDk8ch/GHRsxpoeJYnPp9GH7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lrmZy2Q3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lrmZy2Q3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K09WNM935604;
	Wed, 20 May 2026 09:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=516jMG73Ak/9zh4f1
	47ayfk2V9oKc/KnWcfL8ZufVrE=; b=lrmZy2Q3IS6azqc76ITQrTmLacxj0t/iO
	kssmjktESVxcQ+R1fWgVQHuMKagXgdQ76M6ut2DRGZWOLg6BtuB9PZbU6RwAC16s
	Og+Xii8hZ5E474gXnrxIzQnPoVZNLf7BMtNl5Tvmkf5pMBkfmR28bzJQKRuFi2b/
	XECTJW62Scg8FNgcduyWngW0SSRosOqVNdg0rLE0s3Ym2Vf6cl6gALMMOae71wDx
	rALgUtW3idFMq3BZdaEZuIeJ6vjvEYAG5cw6yXHZM+GGXQFsBz9ie2C/uve9ze5J
	aSLpk9FVaGz2AJVUz2Fu6Ey9FqhtaHfioph3tzH3I+zFA5tltqe4A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88gbjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K994jx032267;
	Wed, 20 May 2026 09:22:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq6vwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9MilN49480052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8062620040;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 525C22004B;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 1/9] s390/alternatives: Add new ALT_TYPE_PERCPU type
Date: Wed, 20 May 2026 11:22:35 +0200
Message-ID: <20260520092243.264847-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520092243.264847-1-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rdFkMtFyexIomHqUgmwR83tsTiIl8ssw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfXxTzdQgw2jX5V
 AnH+WzvDNpkTBtRmmcmEIMz04JJ+YPdtHJW5rlnb7NtuTOjP/5MZOyjgfut10i3Qzba7pfHwkJX
 dKyIlvszJ3UPmuBTeLdPS2+PtiN8OBsz0TZLxsZmSfEqA7ksbRgHcV7r2fyrJEonnf3fmx5WxuM
 2zG/k49+TAzmhiq5mSyBKTrVJh2YibIeNVT7DqibP/CcH/ASDWmAWmTy+sBwtA6C2pueZU2yFOz
 1cCGp4f5CN/2OlJbgBXfysCTv+No/2uTstTOnOEzQf7HMWEmle1NnztUBZmelmGNmtoNAPRxMQs
 fbuYd66AkfZrRr5Nne8AJsrBcQAFwo5vZVCShEf4r85bILa2hjjE/0ZbnYMkWeatHs3LR4wbXTG
 6DkR6opaU6DOHgRvTdnDEandzDG2ND07NB59PvScunhnAehY9zlN6eOcPxQsyIS8taJoEszOCFo
 EwBitfQ+sGMX1dMve9g==
X-Proofpoint-GUID: rdFkMtFyexIomHqUgmwR83tsTiIl8ssw
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0d7d68 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=XZhbzCa44lJJqUdH0vgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200087

The upcoming percpu section code uses two mviy instructions to guard the
beginning and end of a percpu code section.

The first mviy instruction writes the register number, which contains the
percpu address to lowcore. This indicates both the beginning of a percpu
code section and which register contains the percpu address.

During compile time the mviy instruction is generated in a way that its
base register contains the percpu register, and the immediate field is
zero. This needs to be patched so that the base register is zero, and the
immediate field contains the register number. For example

  101424:       eb 00 23 c0 00 52       mviy    960(%r2),0

needs to be patched to

  101424:       eb 20 03 c0 00 52       mviy    960(%r0),2

Provide a new ALT_TYPE_PERCPU alternative type which handles this specific
instruction patching. In addition it also handles the relocated lowcore
case, where the displacement of the mviy instruction has a different value.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/alternative.c        |  7 +++++++
 arch/s390/include/asm/alternative.h |  5 +++++
 arch/s390/kernel/alternative.c      | 25 +++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/alternative.c b/arch/s390/boot/alternative.c
index 19ea7934b918..ad078a2b1192 100644
--- a/arch/s390/boot/alternative.c
+++ b/arch/s390/boot/alternative.c
@@ -22,6 +22,9 @@ static void alt_debug_all(int type)
 	case ALT_TYPE_SPEC:
 		alt_debug.spec = 1;
 		break;
+	case ALT_TYPE_PERCPU:
+		alt_debug.percpu = 1;
+		break;
 	}
 }
 
@@ -115,6 +118,7 @@ void alt_debug_setup(char *str)
 		alt_debug_all(ALT_TYPE_FACILITY);
 		alt_debug_all(ALT_TYPE_FEATURE);
 		alt_debug_all(ALT_TYPE_SPEC);
+		alt_debug_all(ALT_TYPE_PERCPU);
 		return;
 	}
 	while (*str) {
@@ -130,6 +134,9 @@ void alt_debug_setup(char *str)
 		case ALT_TYPE_SPEC:
 			alt_debug_all(ALT_TYPE_SPEC);
 			break;
+		case ALT_TYPE_PERCPU:
+			alt_debug_all(ALT_TYPE_PERCPU);
+			break;
 		}
 		if (*str != ';')
 			break;
diff --git a/arch/s390/include/asm/alternative.h b/arch/s390/include/asm/alternative.h
index 1c56480def9e..9ca2e49338a2 100644
--- a/arch/s390/include/asm/alternative.h
+++ b/arch/s390/include/asm/alternative.h
@@ -34,6 +34,7 @@
 #define ALT_TYPE_FACILITY	0
 #define ALT_TYPE_FEATURE	1
 #define ALT_TYPE_SPEC		2
+#define ALT_TYPE_PERCPU		3
 
 #define ALT_DATA_SHIFT		0
 #define ALT_TYPE_SHIFT		20
@@ -51,6 +52,10 @@
 					 ALT_TYPE_SPEC << ALT_TYPE_SHIFT	| \
 					 (facility) << ALT_DATA_SHIFT)
 
+#define ALT_PERCPU(num)			(ALT_CTX_EARLY << ALT_CTX_SHIFT		| \
+					 ALT_TYPE_PERCPU << ALT_TYPE_SHIFT	| \
+					 (num) << ALT_DATA_SHIFT)
+
 #ifndef __ASSEMBLER__
 
 #include <linux/types.h>
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 02d04ae621ba..a79a11879c2f 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -28,6 +28,7 @@ struct alt_debug {
 	unsigned long facilities[MAX_FACILITY_BIT / BITS_PER_LONG];
 	unsigned long mfeatures[MAX_MFEATURE_BIT / BITS_PER_LONG];
 	int spec;
+	int percpu;
 };
 
 static struct alt_debug __bootdata_preserved(alt_debug);
@@ -48,8 +49,18 @@ static void alternative_dump(u8 *old, u8 *new, unsigned int len, unsigned int ty
 	a_debug("[%d/%3d] %016lx: %s -> %s\n", type, data, kptr, oinsn, ninsn);
 }
 
+struct insn_siy {
+	u64	opc1 : 8;
+	u64	i2   : 8;
+	u64	b1   : 4;
+	u64	dl1  : 12;
+	u64	dh1  : 8;
+	u64	opc2 : 8;
+} __packed;
+
 void __apply_alternatives(struct alt_instr *start, struct alt_instr *end, unsigned int ctx)
 {
+	struct insn_siy insn_siy;
 	struct alt_debug *d;
 	struct alt_instr *a;
 	bool debug, replace;
@@ -63,6 +74,8 @@ void __apply_alternatives(struct alt_instr *start, struct alt_instr *end, unsign
 	for (a = start; a < end; a++) {
 		if (!(a->ctx & ctx))
 			continue;
+		old = (u8 *)&a->instr_offset + a->instr_offset;
+		new = (u8 *)&a->repl_offset + a->repl_offset;
 		switch (a->type) {
 		case ALT_TYPE_FACILITY:
 			replace = test_facility(a->data);
@@ -76,14 +89,22 @@ void __apply_alternatives(struct alt_instr *start, struct alt_instr *end, unsign
 			replace = nobp_enabled();
 			debug = d->spec;
 			break;
+		case ALT_TYPE_PERCPU:
+			replace = true;
+			insn_siy = *(struct insn_siy *)old;
+			if (test_machine_feature(MFEATURE_LOWCORE))
+				insn_siy = *(struct insn_siy *)new;
+			insn_siy.i2 = insn_siy.b1;
+			insn_siy.b1 = 0;
+			new = (u8 *)&insn_siy;
+			debug = d->percpu;
+			break;
 		default:
 			replace = false;
 			debug = false;
 		}
 		if (!replace)
 			continue;
-		old = (u8 *)&a->instr_offset + a->instr_offset;
-		new = (u8 *)&a->repl_offset + a->repl_offset;
 		if (debug)
 			alternative_dump(old, new, a->instrlen, a->type, a->data);
 		s390_kernel_write(old, new, a->instrlen);
-- 
2.51.0

