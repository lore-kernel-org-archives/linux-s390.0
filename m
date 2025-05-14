Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F11F03C0
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213804; cv=none; b=vDE/LobOL2aVd3FovFCLVfdlK1mSO+MgomeY7v3MYqMT0jq8Zlt2G/T6JhBj9CxwL85lCfoMapURDGWQaFBpT69qpkkHdw0OMaudD6PStlM64bXY7A6a7orO+p4/5TBotb5sKzK9AlVTPFFU2sJaA8U7nD00Dz+DXth1Ld5/E6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213804; c=relaxed/simple;
	bh=w2aWgUhrNQ5FGWAqyRn8akhGfsPYV6X6wYXpafDvaBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l07CZCsQ+pafw4zHdn5DUnkdNpNxgLtcg0rt25XZJbCDcTuUeCwk73lW7YBG3ciGwotmK7nbBCw0J6wXi2rV/Q1NlKB9V+gsEXpgYOUuAVehEB+NtgpZw/+NH1UVSNiXzU+Ze5UbpkIPlaNa4vWQJssuGpcn2k1joAqGleyFNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=adYbbxzm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="adYbbxzm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E7ar5N019818
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6UpFWORUw3W7kX4Ik
	08GHcJZL/3DTBhhEf8Ja31wSNw=; b=adYbbxzmtboLYu55aek7Jfb8qjI2dFQHN
	/Bcf03LNJ1iRmH3gjKg38ETptvXrjMA3XhKVD7aSEU5/W/QV2NF9bHpikJwjs5oa
	k4gepyMgzIwr8N3H3E0QX0av1C6+gRof6yYYlehMMOWOdPd41nDMUeBSNAWfcrxP
	NDdQbcXXpbHjvTqndzwDe4vHDGbLVPWnkl29kWSfOsWQ+Kniduvwv7fKXntfldtQ
	lJFAImkxXwyKpmGMJBS5x0s/fkcm20zn/EvHuIxTxf3Rha4mk0sHY4Sj2oL6DzGq
	pP7agdWEk2XxpXGL7HfkyJsU38PWIiLxFWDMc9Llc6PKqaSqKjq6g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbh7b8cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E66N4U015354
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpubfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54E99veS20578646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:09:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1712B2007A;
	Wed, 14 May 2025 09:09:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C06B520090;
	Wed, 14 May 2025 09:09:56 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.111.35.98])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 09:09:56 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v5 1/2] s390/cpacf: Rework cpacf_pcc() to return condition code
Date: Wed, 14 May 2025 11:09:54 +0200
Message-ID: <20250514090955.72370-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514090955.72370-1-freude@linux.ibm.com>
References: <20250514090955.72370-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YbW95xRf c=1 sm=1 tr=0 ts=68245de9 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=qASoqWdS5SWMYHgLSAQA:9
X-Proofpoint-GUID: bRLuUS4JHiBHJXHF5LIAefmu1aOf5iOW
X-Proofpoint-ORIG-GUID: bRLuUS4JHiBHJXHF5LIAefmu1aOf5iOW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA3OSBTYWx0ZWRfX/OQDdEI3cWUi ozK+Lzt/MPpzxkQ4ZYDyxFDDsFq2b5TXDrE+FTlgu5XP7eWnweV9GvvwM0MU0s2K6fe7v0EnFRI I+m60LiRaZV/3JQWbJEuMx2rd7VGNVKzcongaU0dTU1kJE2hX50qmcSwU4LPC3r44YNpcds21tg
 wo3fs+ApErfyzJGQcDXayI8JZAq8tdPBWHWAS1zx5Z6CVgXIaUy0L7vqg3HyuVJ3Q89DdIDfzuo tdXqmGTgY8YU7tCujvtUNUF6SyAh5hR4sSSjh4DDCbE3nb9dxu21L/s7RuozXxkWfsl/e62q0Gn UwmwjvZqDyQJOBFJ+5UHWjD6Tbse4XcZGw6mIyyDKSKWOrzTHXm9g3YbRLXlnxj+WgiDKWtycAN
 qV1CKqmmf8p6FBxGQxVorQ1x+VQRd6c/GTiQBX7meHiorxkuLgo9M0dG9Hhj+PMkqM8JPM+o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=759 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140079

Some of the pcc sub-functions have a protected key as
input and thus may run into the situation that this
key may be invalid for example due to live guest migration
to another physical hardware.

Rework the inline assembler function cpacf_pcc() to
return the condition code (cc) as return value:
  0 - cc code 0 (normal completion)
  1 - cc code 1 (prot key wkvp mismatch or src op out of range)
  2 - cc code 2 (something invalid, scalar multiply infinity, ...)
Note that cc 3 (partial completion) is handled within the asm code
and never returned.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 arch/s390/include/asm/cpacf.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 59ab1192e2d5..54cb97603ec0 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -649,18 +649,30 @@ static inline void cpacf_trng(u8 *ucbuf, unsigned long ucbuf_len,
  *		 instruction
  * @func: the function code passed to PCC; see CPACF_KM_xxx defines
  * @param: address of parameter block; see POP for details on each func
+ *
+ * Returns the condition code, this is
+ * 0 - cc code 0 (normal completion)
+ * 1 - cc code 1 (protected key wkvp mismatch or src operand out of range)
+ * 2 - cc code 2 (something invalid, scalar multiply infinity, ...)
+ * Condition code 3 (partial completion) is handled within the asm code
+ * and never returned.
  */
-static inline void cpacf_pcc(unsigned long func, void *param)
+static inline int cpacf_pcc(unsigned long func, void *param)
 {
+	int cc;
+
 	asm volatile(
 		"	lgr	0,%[fc]\n"
 		"	lgr	1,%[pba]\n"
 		"0:	.insn	rre,%[opc] << 16,0,0\n" /* PCC opcode */
 		"	brc	1,0b\n" /* handle partial completion */
-		:
+		CC_IPM(cc)
+		: CC_OUT(cc, cc)
 		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
 		  [opc] "i" (CPACF_PCC)
-		: "cc", "memory", "0", "1");
+		: CC_CLOBBER_LIST("memory", "0", "1"));
+
+	return CC_TRANSFORM(cc);
 }
 
 /**
-- 
2.43.0

