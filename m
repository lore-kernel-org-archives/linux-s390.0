Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE333BED5C;
	Wed, 20 May 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268981; cv=none; b=Uv0zg9w+LsccGfybyIzuEt+NvfzNiLf7hMs3TftUoZ52EaBFcChIauY4QqcP3XrQaa7Vx26zMFl7UWgp+M4KzrjfHnhOCwvcxgg4iGJY91wzfci+iXGQO1mU5bqpIVSVe0aOuNs32GcacmMVgPdav9ISbYdV0o5vKYISAeW5n/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268981; c=relaxed/simple;
	bh=BzayYQmn6krl5L89iOH64pLU+6QjEDmdFo4YUxmhDuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1OJL2A/hxV4DOokkxNkzB5QySR1QTUpAg0x1OmVOwLsHVA1z+nnW5nJJoWaE/SogYwLzmmPIy0VeIYAVoofOYXF/W91/03tE1ZKDZLmHIw0zzM92FZxWTAEpnJL7q8EhqHrlhVrZROJcKDl2mVTQlEzs7da01L6rRaF3xwooyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dPFinNop; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dPFinNop"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6k2Hd513145;
	Wed, 20 May 2026 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FvXcslh19P7qgkCvd
	upIof8+0RzjLylKgqHtlxcqnfI=; b=dPFinNopQRuj+hlQRiUaQexMyBT9uL66Q
	KmB+FMo23m9aRsMnfiawZ5ujAstUffYduCCBS4JgAmd++vR0ggNa3igKOwlhmmJw
	V04J6VJlTZDRQz9mr+zkFIMGMNUBTEtIC0i/RI7Lss6VQUYmEqgMYuSIuWydRULt
	S+H0sotIPaHzTGlVX8Jdic7pE3cDQ2tQxyN6aEs7vsoNfYie57uFIJTKkR2zrYCz
	pQ0eY2aVD3e3YjVZREkhv/I7QgI8DItnTKCDXu2R1gYAK6kuvHcOifwhzyx7BTKe
	9d4tVDx+gVtn+PIrKCvmJSQCm6EraNu3ZBtd1kuS8KiK6So6GojEQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h751a35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K99As2022921;
	Wed, 20 May 2026 09:22:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gef67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9MkO430016176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4063820040;
	Wed, 20 May 2026 09:22:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1394F20043;
	Wed, 20 May 2026 09:22:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:46 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 9/9] s390/percpu: Remove one and two byte this_cpu operation implementation
Date: Wed, 20 May 2026 11:22:43 +0200
Message-ID: <20260520092243.264847-10-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0d7d6a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=e14ZIUwkndthOOMI8LgA:9
X-Proofpoint-ORIG-GUID: TTftSxFEt0VrS1p77gwSjAo5GlvmhOX8
X-Proofpoint-GUID: TTftSxFEt0VrS1p77gwSjAo5GlvmhOX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfX7lN1wnvAceLM
 tnCyD0VkTZxULFlz7Bi7VHoW6LHrgdoFu1kzlteEF/4zQEoElV2XJIpb6DmkbXXOrQarP/lBuJJ
 l0rmJqpPA6Q+04wsdPteYrWWFhg3rlC5S/7Hpu9UYFfQBwd/RLeiAlKjCnMF+dQWVfm4WhYuhM9
 v50xt291JU+GfyPbG/z3wqyxnAsdr3UnupzfSAvCeUWP7Cye+QQpG1Pc3jaeFMhnqc407byhDU6
 6uBVz5+cptKnuq8WRwVvqB2+2AwkklgM/XwezIePgQvOlQyfRe6kkzz2UDpW9DiY0ETLrcNk4oJ
 VTAXmR25LByW8yXQuLKqt32COckAPCcmme9Y+Ds+H/n2abKfuZAUKtqKQR+KnkAzbCIIbcAizyz
 GZcQ5mHTh43wSPUI4fOyYwOMXvWgshDR403m1VoT/aBejUhyQW+SudysxBX3TG109M4yQzY9n4B
 WsDqBxq3q+ioYaRZckQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200087

There are no one and two byte this_cpu operations within the kernel
(defconfig). However even if there would be, the s390 implementation, which
uses a cmpxchg loop, generates a very large code sequence due to the lack
of native one and two byte cmpxchg instructions.

Remove the s390 implementation and use the generic implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 44867e7ed0df..72237cb962c2 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -51,15 +51,6 @@
 	new__;								\
 })
 
-#define this_cpu_add_1(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_2(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_return_1(pcp, val) arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_return_2(pcp, val) arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_and_1(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, &)
-#define this_cpu_and_2(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, &)
-#define this_cpu_or_1(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
-#define this_cpu_or_2(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
-
 /*
  * Macros to be used for percpu code section based on atomic instructions.
  *
@@ -313,8 +304,6 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_cmpxchg_1(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 
@@ -345,8 +334,6 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 #define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 #define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 
-- 
2.51.0

