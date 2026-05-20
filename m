Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52A3BF67A;
	Wed, 20 May 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268982; cv=none; b=YNXel2JmKdXhoLbVNSwW6QGTHjoUA4Jt4nBmxkSvOYqDt/5ByrIUhIgTq+Td9++OkvqjhJqx9H7OWZozYPtYoiin9lITAUOJACeQ8iJSuE/+yyGRvtU8u0lqzKXbqn9agWbwcfXF3ytes4bG0lTnZa+Uo8m/CkZLHvB4TyU4xew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268982; c=relaxed/simple;
	bh=NK+6vbofr75aKt/BHup9RBCtvaVedcUrgp4zmxiMUaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nK7vEh+DXJP0DR1VzCTOEgUhvhuB+tuxJrmXC2bHaews2PHTjmiE6BdUPLOgW2VhuV0r963HTRddRLwXJ6H1KBok8ksnizprsXRsGW06+qBavVcDvYJkH6oWn8OCKEJEHHYI+LKfvCm//B2FO9vAAEFMJSCRs/K7y7O8cYQBQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MtbBDYRm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MtbBDYRm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6mYG41522114;
	Wed, 20 May 2026 09:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8fPvVyXaWPChPzMtg
	UrBINFyjiKpfEVImi8OFhjKjNg=; b=MtbBDYRmJKFpCFJlkWOH8C2r2aaeAXtXF
	uiCraUF5/G3JrBOPdpNHzk7XTpMCHiEmolD2ueTmSi6aTM2QSHjyiZ6vjiTkuRZ6
	lfshnljLf1RoFKOHtBx/WbjIXxbQffzICxyIBbR91s/BB8m3zv82OFAwnDJMCKhe
	hBPetOqE5LcZ6EiF8gvk9adqeQ6j1DqhU8tOslmE25HFclblK5zzQvT83zIQHGDF
	jtaRmh6xpsMhw5fVdRufec5/ATzTuIq7nmFPWsa2K2Kr4ivDnHVT3hR8hq1N2rcO
	1UD15TaPWKJUf84+6ND3VJDIG43TiZZAJz3k7MLiX9BLRZQgCIe8Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y1c1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K99DUl021766;
	Wed, 20 May 2026 09:22:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhpkur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9Mkcx15597984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D61A20040;
	Wed, 20 May 2026 09:22:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D52B12004B;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 8/9] s390/percpu: Provide arch_this_cpu_write() implementation
Date: Wed, 20 May 2026 11:22:42 +0200
Message-ID: <20260520092243.264847-9-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfX2HIBWq0WOVWh
 1UVbyETMYcDuT7vvKP+uPvpbiNnW08ifeKJ+sOXDbNFm5dWn7M85ByD0cVZVvkzuJe9EOL8VnN+
 yEsxyVhYNg8WxRl0gkcuiVHgBf4TZyHGA4wan3nYpBt9qyztjFgWrdqz5ZVZphvInzIFN9rN/qn
 izrfpyqy+3dOy5Kr6rea/s3qN+9ExMfSNQNOBoejQJ9cR1vMGKtYEsqy+mKK/LlQa5l70FPDxL4
 lNGP9+ilJBfjHAH6vNtKe2rEY34v4wpj7pk+h7ABNE2UAaTjuNHNhFZu4/PTBkFnCwjaMvGyBLY
 Tqyk5h6t7zirnsCkFWniZ2rKKh6iRXyiBbvNVZ4Ybyi3tXRXhtH1aa3APDQZvDPjEN4K+Xj5neh
 vyYTZpR9RApTZaxIHsFABjUOzAaB8dbnXZ6//D9U3PrnQriYUJC7lnl0z540egFJf+Wl25cYem4
 IGrIW7LZ7lrbcs0+hZw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0d7d6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ObmbXjF690NQJU6EaucA:9
X-Proofpoint-ORIG-GUID: xnxRidgd9SIKD7Ohgg76JL6KU12IulxN
X-Proofpoint-GUID: xnxRidgd9SIKD7Ohgg76JL6KU12IulxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200087

Provide an s390 specific implementation of arch_this_cpu_write()
instead of the generic variant. The generic variant uses a quite
expensive raw_local_irq_save() / raw_local_irq_restore() pair.

Get rid of this by providing an own variant which makes use of the new
percpu code section infrastructure.

With this the text size of the kernel image is reduced by ~1k (defconfig).

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index abd774fdd73a..44867e7ed0df 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -271,6 +271,36 @@ do {									\
 #define this_cpu_read_4(pcp) arch_this_cpu_read(pcp, "l")
 #define this_cpu_read_8(pcp) arch_this_cpu_read(pcp, "lg")
 
+#define arch_this_cpu_write(pcp, val, op)				\
+do {									\
+	unsigned long lc_pcpr, lc_pcpo;					\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ *ptr__, val__ = (val);				\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "    %[val__],0(%[ptr__])\n"				\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+		: [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [val__] "d" (val__),					\
+		  [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "cc");						\
+} while (0)
+
+#define this_cpu_write_1(pcp, val) arch_this_cpu_write(pcp, val, "stc")
+#define this_cpu_write_2(pcp, val) arch_this_cpu_write(pcp, val, "sth")
+#define this_cpu_write_4(pcp, val) arch_this_cpu_write(pcp, val, "st")
+#define this_cpu_write_8(pcp, val) arch_this_cpu_write(pcp, val, "stg")
+
 #define arch_this_cpu_cmpxchg(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-- 
2.51.0

