Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0B41C314;
	Fri, 22 May 2026 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459197; cv=none; b=qjuVLLrda8506X3CqTBIkwHIU49btwXYGF586mzYY50xR/RJD82N1nGXa2iviNcb0X0+r69gMMe/NPy5xyYteIL+l1caGE7h3TARa3VMd4bPcOLVGqBM7UMJKEx43+rcMdTnC9Zvwwuh2BT39xPu7GYxd/BZcfMzb7GrrTiyEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459197; c=relaxed/simple;
	bh=xLUxNolFlbS4tE5XTJ7TIi1oz4ejVGIRGBiVBHuWrdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRNYW5Pnr4xl7EtJak7EG2bYhSdkutXsZXOcbQBEe+1xVpztRCbBq+j+ZBnYstD2oae5LFlo0X2XH+z23YF+ssc7mcto9ynnEeDa2utxGEwbr/nf2QN51JJbVijRuC2WcsCMCICJrOneWfuxVrJ8EGi6RpP/TE51bcwX+wzc8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKVpPapW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKVpPapW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M0Ebu02799624;
	Fri, 22 May 2026 14:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FRAEkWgvcd1absBO4
	csZpf4VqU5+MWG23iClBSffMLo=; b=BKVpPapW9ptMjeaAo4E1kw8hJrbSdxGVH
	HQfjROnCWREW8zCXHoX4IV0XCjrfc6UKh2OpjvdOOqLl4VCDg0GWiVPZKY87LUqm
	8OoXjc82R6umaFz0u9HWUTMpIP79SAP5VGH3TPyzP5YsHFxUQz1GaIYwEyfKuk0i
	cJIrfVH3tJBz3V7o2IPAAFltZKVAa1EjjdJ/8g3Dke6jpwNfT5GvY+Uk6Y3ptT4O
	AuqJO/xML28l0+YSBITAXKg8DI2M5AS2TWCOyYXEyWcDsezyE4pRFCC9AJS+pI+I
	QNZy/bIy3XKoYMt2jqGpFG0ecxzkD3m7KxeoaH8VTx4yRv6BKP2gw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawjwbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME9ExA015396;
	Fri, 22 May 2026 14:13:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkh6kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MECxsg30409106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:12:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A925A20040;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79E1220043;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        David Laight <david.laight.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 7/8] s390/percpu: Provide arch_this_cpu_write() implementation
Date: Fri, 22 May 2026 16:12:56 +0200
Message-ID: <20260522141257.303617-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522141257.303617-1-hca@linux.ibm.com>
References: <20260522141257.303617-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfXwu6Srjl5mHNE
 vlHk1xyCxUjRQlHmy/GRQRNSXVYzKElqDqtiCykE2vE4Rq5uyWPsFYTFE8mkoqilyLff4jhYRgV
 FmNZoVHsQg8KpPQIZVNStBxjZ7NfMxvGikJEOD2SbBhMu+X7MeIrA0BIq003LTd0MCCNhMxSw7b
 8LzsX+g7SnrWYIcDvQRpifcyrjMZQK3SleEofuwYjpZPG2rrqk0qan8cER/Ib2HK1MC1kYavQ39
 nyqQOi3d76boMKnPedBjibI+/JSOoy+9jKDBfb1iXq9pS1DDKfKgWRVkG0zsJGtjrRosOuE3sEw
 I9Ec0zyN7XvOhjjUuYJ0695ZC0c/F5e64jUBEJEwFhNqID4gjgMoWvutGuBNdQA1APUkN1R4SM5
 Uf0v2LYg15Kej35x9I6yXjDgNA7lZwdMqoeTb6+G+PjizBxyYTRBeknv9HexJQpZr0YPndxyx5l
 M0ObH3VObBdydeSqUng==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a106470 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ObmbXjF690NQJU6EaucA:9
X-Proofpoint-ORIG-GUID: UXZK0JT4O3yXL1L5d4b2mhKGQYuWJ2hF
X-Proofpoint-GUID: y4vvrk-xHt8tD_bE3I0BEBMfmg5rgTRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220141

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
index 2b6c2c5606b1..667b165b4c0e 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -279,6 +279,36 @@ do {									\
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
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
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

