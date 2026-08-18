Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AA187346
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069922; cv=none; b=QldIlUWYunEC1ObVAdaEZsRqbMMQuRkF3bWn26gs0sG218MeJI0vhChzyRzDwb6WbkSOJSxXOHHCUqJI99le778G8XWr21mgZy0APz9pnJxCWr+3zCgDuXSDqGzIPOLtSoO6USQgHrgekVj/cWrfOL0uHRnKTppnsjpf9BpE57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069922; c=relaxed/simple;
	bh=RpXwNl6pkvFQFt2u2t9qFklAXtvk+VqdblFHqZwwnlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPf6FWlbqSVHNkauFokKUXsI35IfLzJp9hdZ4qtfy5APOJ0HiSbC87T8G0qRSDt2yIhN6A5HAAn4+WHc35Tnjcuqezwu+5OKZvVVQtJSB34nbioW16MTsrloibH3VZnbFNZJ8b1np8ec0tEb8qLED24hDSPKgGNcgd+iC4LRGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QP1xQHFu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QP1xQHFu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3vEA2831852;
	Tue, 18 Aug 2026 16:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P3R2CJTeV5wkQovcm
	RGTdM4GZu1zsPmlr0Vw58s86a4=; b=QP1xQHFu1g4maS00v/klyHasvQhhVkbyI
	vxTcdl1WgfYCsuA/sKz+EQbC0SRVL1ZCR7C9M3ld1ddHnHVoBwrOthHLkZuHGk3a
	N3hfive+6lxybBv5KHENfocGKkD3ZI5wHtwyYSjV05/U+dekNZdj/sx20JExNqyp
	JCgHQ1WFcipBl5C0J5yJlyDvIY0/Jxi4/JxB7L2hQC1oL9ejlVVSIexoSef7k4nD
	67cqk3wXjyI7RibARhGcDuX8/8vVO6mDbwWBJtNccoAEqPgGUG8tDPcdfuFIwFk6
	rEGfYRLMeIHq+C4todwATrXaC0XLEW5UP1oP1dmN5gKy6QAlJ47dQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqscjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBOqk015212;
	Tue, 18 Aug 2026 16:18:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbx9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGIPS041091418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC0D420043;
	Tue, 18 Aug 2026 16:18:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD7A12004D;
	Tue, 18 Aug 2026 16:18:24 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.161.134])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:18:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v15 01/20] target/s390x: Fix missing privileged flag at PCKMO instruction
Date: Tue, 18 Aug 2026 18:18:05 +0200
Message-ID: <20260818161824.100746-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818161824.100746-1-freude@linux.ibm.com>
References: <20260818161824.100746-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX0BdWnaGJMIqF
 +MLvAUeVQL6w8qrfbhbxBhih0eMqxmfNAypdLORZLbyknf+uRZTLvABaZ3AKdqLC6WR/AWgBUAk
 jxAYO5YbKD0tBshie30a9YXG1OqGIe3pk3v1/q7nMh7jnTGEAee3aA60Z2aQV3ix/c+cyDcRduR
 RQv6hbvcbIh9tKHZCB4UpWs5zkgfAUtlxeunlwqABUyby4hgZeTxnCbfg23d5X2a+vv6mhfaHhO
 oaB8TKrJDVF1kVCQ2ZnbVYAuEeIhsi5vVm4CLpniiNfROfpnpUDlRCNU6mx/AXxanSNM2fOYKSq
 ysGKfhMSSfNAbDq6RiFkGXLq1HeTc7FPDJ9Fc1j+NwPwIsBHOqdPI/gXZGXm3gai8ZpB1XRW4s/
 SeRIYMPPCOt4xthcGl5rk9Qfk/HlLZcR1dK0ueSAi4sfZL+wiE9VHNLqjxlLeHuMcUnT3PJO0/D
 3jLf9a/+rYYzufBwGWg==
X-Proofpoint-ORIG-GUID: eL3vIBS5A4n3-YIIkqsZwDGJc16MGBq2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX8+0n431dMP1R
 Lqh04ZmTff1VP9BnUXIg6Beyv1aHhUS2+MfQ+v2ojnfgEWW+q/BIlX17OZOMbb9vHLMDbFJqArK
 dztC5lfMZ1Xnr4nsbcocZtZOWnpplE0=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a8485d5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=B7scKulbZj0pNRMJRCIA:9
X-Proofpoint-GUID: eL3vIBS5A4n3-YIIkqsZwDGJc16MGBq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

The CPACF instruction PCKMO is a privileged instruction. So set the
IF_PRIV flag in insn-data.h.inc to reflect this.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 1ea72248a6..b2e402216b 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1007,7 +1007,7 @@
 
 /* MSA Instructions */
     D(0xb91e, KMAC,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMAC)
-    D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO)
+    E(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO, IF_PRIV)
     D(0xb92a, KMF,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMF)
     D(0xb92b, KMO,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMO)
     D(0xb92c, PCC,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCC)
-- 
2.43.0

