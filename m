Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F974A1396
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209676; cv=none; b=sNdrxErJF32HgJmhR3F8+qOc8QzE68MpD8t6dvs3+tW2lIvE7+4PZzuFA+PRdnz4b0FkIG03BdRFPdJF97JBb3H2XaIGTMHeJ/7h5hgkzVAD5zu0HI+7Q456JvDd02h765Z74hOmeB4qXmBK1NDIdjPRaAfxMw0MTiYEXR6fWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209676; c=relaxed/simple;
	bh=Dkix//V2HR5bbR9R3shpWFQx6gsGfjPv2eF4/RicBBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/VlXrQyDKO3jkYdNdKfEctqJA2AY3rZwgjW+XMhfalhZG2inVx9u2G+24FQeirhEyIekUx6HWT92N2AlJNbfqh1FmaZoNexBzgP424LdtaRJspxbmfxAqQXWj/naXofoDENPCL7bi4xhnqFCM0URVXHdCR3xX58ToDsjZn+n2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VjJX1OIv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VjJX1OIv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CZdkc632496
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 14:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IP7dFVyuqZLCjxtxe
	byP+yYn82hi2H31G+NNtZvr08Y=; b=VjJX1OIvcyFj0ex1Sxx5fSKnxNSmGYnqf
	6VKKFStgBlW8EFsh7+RdiMKzWrH3odpru+v8uSCZrSRIYx59bPbJaVinEUxnnIVw
	NqsRy6PbFJcqMWmvPdCGMi/44Hz6KiUfsOvV8bdmHFz9ughfoQtYF9T3QW82b/J/
	W3qmobg+Dt7iSO50sxd2oGN4K20V7/gaeu+h8/Vfk1GYvPYMCn5QcR2Rx1cNnx4w
	lRUPCMOsQgbXo4CkMcHe7/Ifoy9KazSqAtZNXtuNhHOrw/wTJOGSMM6uX/CZViFk
	lX2KH4A+SRuXSLiOjETqEKNxA1dE2c27lH0yJgC2uu+XyGZkktIog==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5anp9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 14:14:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695CHxq42874735
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 14:14:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jnsh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 14:14:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695EEHeY55705946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 14:14:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67AAF20040;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4989D2004B;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.168])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 1/2] s390/cpacf: Rework cpacf_kma() to return condition code
Date: Mon,  5 Oct 2026 16:14:15 +0200
Message-ID: <20261005141417.65822-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005141417.65822-1-freude@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfX176Y2vLKgspB
 bkveuAlHgkOWj/pdC96llcXkWw2dv1WJWN3Sa6HKbWoz0cIS2DkdETKlJYaAjU9m5zLt9gPmIgI
 X4batmOcQ1xjyD8BUia996Ool10ftak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfX76rrE64/rRyK
 kOv1E0QamJX4ThLcrIuMvc2NxQI+8kv/Adh1yw7lYAtcmQNk7ESuVTxh913JD3ZpL3PN+aaY5by
 +ebNfj92xPgffp8pnKfzop0Ba1ROAnNgJirqqMsiSjF4NrewDlDgyALXMeIle8PfWcs+N2xOzLC
 ANABSx1xGsu0GZn49HcJEd6FysCGjCHZdSFiIr6eKuvyIb2wBwi9iBWzQ+u9nrjkvnJBG1VKKTL
 58FcDGZbMXK3+oscvRp7Bok4XMz020R4TUXNsg9Iol5s2h9LXUK84GD2GCfFjomNqr5i/5QNnKX
 ewlaUZsfXND4C7J3Pvr/qpi83jBzxmGJ80wIA2y4IPelTXbloHTbKQYc5mM+ouaARA6ZW+6pCvw
 IqEbcB9X3rh1j1s+VfQ1gkJJzgP5h1OiG529CN+Hae3FVqYk3CQz3InnJbqF6MnRo6tOgfivq9J
 Kzmuh18CBfSkRS1mbCw==
X-Proofpoint-GUID: -HoXwhG9cDezWf-iMgc6AgGZOjssnvZE
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac3b0be cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=uZ4CQENtAJyrMlTU58MA:9
X-Proofpoint-ORIG-GUID: -HoXwhG9cDezWf-iMgc6AgGZOjssnvZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050055

The KMA instruction can signal a verification-pattern mismatch (CC 1)
when a protected key is used, or incomplete processing (CC 2) when a
sub-block-size chunk is submitted without the appropriate LAAD/LPC
flag. Both conditions shall be visible to the caller similar like the
other CPACF instructions.

So rework the cpacf_kma() inline function to return the condition code
instead of void. However, CC 3 (partial completion) continues to be
handled internally. Also improve the function to use the CC macros for
better readability. Additionally add an kmsan_unpoison_memory()
statement to reflect the updated memory by hardware.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/include/asm/cpacf.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 6174552d856d..00aca3194b67 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -715,12 +715,20 @@ static inline void cpacf_pckmo(long func, void *param)
  * @src_len: length of src operand in bytes
  * @aad: address of additional authenticated data memory area
  * @aad_len: length of aad operand in bytes
+ *
+ * Returns the condition code:
+ *  0 - normal completion
+ *  1 - verification-pattern mismatch
+ *  2 - incomplete processing (see POP for details)
+ * Condition code 3 (partial completion) is handled within the asm code
+ * and never returned.
  */
-static inline void cpacf_kma(unsigned long func, void *param, u8 *dest,
-			     const u8 *src, unsigned long src_len,
-			     const u8 *aad, unsigned long aad_len)
+static inline int cpacf_kma(unsigned long func, void *param, u8 *dest,
+			    const u8 *src, unsigned long src_len,
+			    const u8 *aad, unsigned long aad_len)
 {
 	union register_pair d, s, a;
+	int cc;
 
 	d.even = (unsigned long)dest;
 	s.even = (unsigned long)src;
@@ -731,12 +739,16 @@ static inline void cpacf_kma(unsigned long func, void *param, u8 *dest,
 		"	lgr	0,%[fc]\n"
 		"	lgr	1,%[pba]\n"
 		"0:	.insn	rrf,%[opc] << 16,%[dst],%[src],%[aad],0\n"
-		"	brc	1,0b"	/* handle partial completion */
-		: [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
+		"	brc	1,0b\n"	/* handle partial completion */
+		CC_IPM(cc)
+		: CC_OUT(cc, cc), [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
 		  [aad] "+&d" (a.pair)
 		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
 		  [opc] "i" (CPACF_KMA)
-		: "cc", "memory", "0", "1");
+		: CC_CLOBBER_LIST("memory", "0", "1"));
+
+	kmsan_unpoison_memory(dest, src_len - s.odd);
+	return CC_TRANSFORM(cc);
 }
 
 #endif	/* _ASM_S390_CPACF_H */
-- 
2.43.0

