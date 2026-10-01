Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07913DAAC2;
	Thu,  1 Oct 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850797; cv=none; b=XR7NAdCpe7ap/MO6sFaEi3ZKdbQa6dbxfTK+YNMwO7/xhj863Mv96zQnG07GrCUv+juu+oL3tcNv7LZ1QdY6Mhz+jg0SFNHZlM6Lh3qdssCk8FA1OXwQE67dvVFRRdahzwMy6qm/88LdSxexvWpkC4PBCAC7ttcuTdMbszjk79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850797; c=relaxed/simple;
	bh=okABa28gjgRBRA1xCNETLqEddnHukT9RQd1Gk7+1RUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlu8s/Xys8bMNHc7jo4EKnNLZNVNryaJvlQNHAHBwTEkhl5ykxcS2PPACUarl1k5XcralpgUCibucCPw3ECbIiWr3XU0cXo97C3v04Rz6QN0yYNO6uQTc5zrnKzT7ofg6aIFTS8eoOWb9k8LcHfOiS3gpaXSp8WMtFtwusFwejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FVBo7FfY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FVBo7FfY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Ulu1086044;
	Thu, 1 Oct 2026 10:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JbNx8so3xWZLQFDPh
	ECK8AOhE0zq1ejSlky4EIyOq/k=; b=FVBo7FfYMpLudwjFRq6BleH3LoiV8lYrN
	1BtLjKgJV/uNswQmFuxyTo8WkVhB+OaZV/xkkZxUnq/raM2orOs+1FVqtCBYF7FB
	FkxqQR2V99y5DNUe8ELiZCqssqSLgbBwHo/CKoIw6is/b4HFas0OSPnEBEsY+wMy
	U0IMich0ojGaQbUJLF8Oqy84H5ypcDZE/LnXJiCKedifUgWuQ/2SLcRfkiQ1BELt
	0lbAlwzWP3STJTId/h3dss6NOYe2k+b7a7Fd8L7ZpSJyLaEr80CC2W+Qk1l1h2eg
	AFR3lpsoIIqsUANSK0AnkPS5f9fkLGLoVBFxZDoNN9wMN0d3VS8hA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthchc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172aiF520749;
	Thu, 1 Oct 2026 10:33:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpga60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWuCQ49545584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6C8920040;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81F5A2004E;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 30/32] s390/sclp: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:45 +0200
Message-ID: <20261001103247.1989111-31-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 97sbzTnIxvhFWOqy5zH_i4tjmzQeGmTz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXzwmWCIY0QnhH
 sR6VNJFr9CGrr+oU/W/DFfbicSBhmML1ydB8RYyNAzIRMgl+skJKBv6J68KZ+eNkxvg2VfB5qMq
 vu7JweApvIJ+J+5IE3ypiEql/oORoxru96teqt+i+jknDMqmd5K8h4eooJFbsNaakyHW52NiawV
 Hw+lZ07BZ54bLNwBWq55rrJM7tyIPUv5ehXbk5YpLwZ2/a+yIlU7aeC5mGdUNq0hW1vtWcwHz7N
 Y5sK6XK29nFZ5h7BN+LdNIU40fuEoIrlMOPXV7S19yvrfhOEuvQrUvbVXre4DR+QtOiOzNy0Fri
 MiqozhMf5K2UYC8mZZEre7VS2vsw5Z3Ltqq2fjj9Ng9O1kfdU+WxehmwNxx6iGI7etJL/8DwhcL
 /TIiob/ratORKvUSIEOjwZU3xJMZlYBo/g6p0BMJo+LNZYoTz4msNWFlC/y8rVAQUIZwZgb3yJW
 vJ4tIXUHb7TTSKJ84kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX9E1XrM0TTuzA
 qHFKzdvCf/sutn7aTiMwGAN00vdmJqB8RzHWwEVRLLWCt4ZS0V0g8fBwK5cGXL3ygCVEqMs+RYR
 0fgVvKo0rY4sffqiyfKme3kKUh8oBBk=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=AB0-fAUhRVCwOXPndrkA:9
X-Proofpoint-GUID: 97sbzTnIxvhFWOqy5zH_i4tjmzQeGmTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert the sclp_service_call exception table entries to use
EX_TABLE_INSN.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/char/sclp.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index b31a680e0871..b91d31f8e0ef 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -320,11 +320,10 @@ static inline int sclp_service_call(sclp_cmdw_t command, void *sccb)
 	exception = 1;
 	asm_inline volatile(
 		"0:	.insn	rre,0xb2200000,%[cmd],%[sccb]\n" /* servc */
-		"1:	lhi	%[exc],0\n"
-		"2:\n"
+		"	lhi	%[exc],0\n"
+		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 2b)
-		EX_TABLE(1b, 2b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [exc] "+d" (exception)
 		: [cmd] "d" (command), [sccb] "a" (__pa(sccb))
 		: CC_CLOBBER_LIST("memory"));
-- 
2.53.0

