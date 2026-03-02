Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D57375ACB;
	Mon,  2 Mar 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458570; cv=none; b=n1/7k1KIJUiSdZVI+ksvmT/AiTNnXCM5p7qqq+i6obbhXlcmLfME+87+JsOR/ZnRhqL1mx58k6oHr5XwcuV4u7TD/3DCk/sBbXnMJ130tzSgMsB0OPkPOzrgyTRz1vseBOFQ49heJDarXzjGsMHiO26zlQfbyDkVD7lCFV7p1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458570; c=relaxed/simple;
	bh=eWEsqa+Hqbl2BLfYt47lMIeJThxi1ZNA8Kr4PWBpVAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAIZf52yASCHY9wsWKLM0YDM5V2Q/exYIdqSOPa8oNf5U+MM/UY52SHHbRQGBRTFQAfHPA8SbhufAWgDIzREkyZTz6iPSAAlyyLqQS8sdfeIg2RMMZTencyKxPsMzXrjGVifgtoSzWRCPuHbj5PDUgl2mgCJe6dGRg5GdFmCKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bP643gxw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bP643gxw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622ApVSg1171368;
	Mon, 2 Mar 2026 13:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+KtYzLWSMqWWMhL/E
	tsTIxA/huTGyFpsfcBG3GoiINk=; b=bP643gxw7GxXRf2q/dAWmjhCsDd88KoBy
	7NErygqre/7nBgHYGyMyPzaegVyR9TTTTNCMUeigvWI1kaGuFn3xu5Oclm1o423/
	xW/ZSK1nnPflRyiEDVSKROEIfmGQrhpp+YHP2o3OGFb9SbiDs9uuEEc6I0UNtPi+
	G1f/+NJZBs290/Nh+zyfTIqrsIHrOPC7VDiP3K4kS5ZIUqtOk5KKW6SwRJO7y4Xd
	t9rq+rx7IaieCT2HB7l+1VooEk8RPvxloHOx8pK8BmvZUrX4Cgb7g+dh8x8YoPvE
	PBIU5I0irPTeVPlNFfX9j2EiCoyKzZwOnakcz7Suk8QfMsAueXQNw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3pmek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622CtBcP016409;
	Mon, 2 Mar 2026 13:35:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpmxahe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622DZ1Bl25821568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 13:35:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B7B620040;
	Mon,  2 Mar 2026 13:35:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF9702004F;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/3] s390/stackleak: Fix __stackleak_poison() inline assembly constraint
Date: Mon,  2 Mar 2026 14:35:00 +0100
Message-ID: <20260302133500.1560531-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302133500.1560531-1-hca@linux.ibm.com>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e0afCxtGkLlKBiVfpNhCd2jWnrF7dWf1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExMSBTYWx0ZWRfX0pkOu5X2yY/A
 Tj4EaK1N7qaMQeLGda8pShoWuZN7+F2M3Den3qP9dzifCwuv4i83dToIpGWLNrvQm3+wRP498JJ
 zNYlRUnmgUtArhb93xyY9gwTlL6CuqUZ7/fiL0GP72GR8uaxStqma+59YcA2J6LHIEY3UlHaYFI
 eMKo+Iqum1MTH1byVA/Ok6G6AKUwXP4/SEhAZVT41KUejP84U+Z8gB2EoyMDtftI5LtKzzRDU6A
 1GFncDv7GtWfmM8mgn9zRX1X5tMdwiqNDJ/MVSanFf3Kfj1E9lKVScvfO9PBi+EVciTt3gV5DBV
 +S+YWax3vg+PHQqR8lJEuQvOZVzxckRjYuVm4a2lNKemrSaoN+iOm9Kl8RME903N17Sjj4nmZRQ
 G3G4J8WEAZeI8lO9zqvr+5gKqKQ4JCqE9EhYcQ3oWrfh79BuhEloM6cTzGxyd2Qaj/rrwDoh6xG
 TXXtCYFajvnrH2bXfJg==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a59209 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dh6oAghXbX3gNeQxLKgA:9
X-Proofpoint-GUID: e0afCxtGkLlKBiVfpNhCd2jWnrF7dWf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020111

The __stackleak_poison() inline assembly comes with a "count" operand where
the "d" constraint is used. "count" is used with the exrl instruction and
"d" means that the compiler may allocate any register from 0 to 15.

If the compiler would allocate register 0 then the exrl instruction would
not or the value of "count" into the executed instruction - resulting in a
stackframe which is only partially poisoned.

Use the correct "a" constraint, which excludes register 0 from register
allocation.

Fixes: 2a405f6bb3a5 ("s390/stackleak: provide fast __stackleak_poison() implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index cc187afa07b3..78195ee5e99f 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -159,7 +159,7 @@ static __always_inline void __stackleak_poison(unsigned long erase_low,
 		"	j	4f\n"
 		"3:	mvc	8(1,%[addr]),0(%[addr])\n"
 		"4:"
-		: [addr] "+&a" (erase_low), [count] "+&d" (count), [tmp] "=&a" (tmp)
+		: [addr] "+&a" (erase_low), [count] "+&a" (count), [tmp] "=&a" (tmp)
 		: [poison] "d" (poison)
 		: "memory", "cc"
 		);
-- 
2.51.0

