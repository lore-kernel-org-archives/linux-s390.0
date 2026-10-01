Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1263D5673;
	Thu,  1 Oct 2026 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850778; cv=none; b=DJ1NMSggInePwU+DXu7d70fWeeFbwjiBTNAu3zyal0Sw9GEJrGSX8yZ+EwKrF0V5/sldjcIQLgQY3MA6UKxfcAqv7u0h2zGd6+2RymNXeKeDbLReq5DAnl5K+FpWJfy/5XN7SLnYCsZINZK//fusgJ022SZIUp+m8gIelQTSxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850778; c=relaxed/simple;
	bh=8elAthJn3tOqUiHulP+c4KrLbQvQzHSE/FuM1ejuB8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ET3dYw5IA9I0HPLESwMoDXfVV9Om+HV0+OVJu7z7wObU6kMgPScSMdP4g9SMpq9JDlFiEIi06yAUp318O37TmA/INqtbXSjDfTd4O90cskjgE1x4lbXJ0Q7KEB3P/xv2NWny+wjmaoYW6K/3gXx7khbkF005U7X9OT1M5e2klko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oz/Ne9RB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oz/Ne9RB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Wcx1086340;
	Thu, 1 Oct 2026 10:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CXe88aj87pdLSpWQb
	tsXGqhOJKkqIX8TDwYa3IZzNAY=; b=Oz/Ne9RBH3i38u5tqE6W9aSlWdptNOtVa
	DFUpu81bykNQ5G4sCpEs0mmbb0W7GMHGpQ/dePDHEYh/jjKxhRa4LPwew2XlG4UG
	aul9RW5+9DIzci4UqQwtCrmyKtGOjBCqxAisE07yTcrwRl9nGEyg3CeMowTEWtba
	0CFLDCecrHA2/G2SHIlhYXKttMlOpxO1kI/bVI5D3YKt037ObU6n8UtCmuYOgTM4
	ABAPIM05xwYfsv+R/DGxZ1JprGcgX+FkG+g7EdNyFdcioxTUqt+grgyRARkXGvxw
	LuJ5auR93lxbsgo4kXlgse1RyOt4O+seh8ceKF6h1rr5HqbeOp0Jw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5jk23-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172tm43460494;
	Thu, 1 Oct 2026 10:32:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pexar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWmsa47448354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84F7520043;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D1492004E;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
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
Subject: [PATCH 01/32] s390/kprobes: Prevent kprobes on instructions with exception table entry
Date: Thu,  1 Oct 2026 12:32:16 +0200
Message-ID: <20261001103247.1989111-2-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX9heVKXW6Ty7X
 IYPGCY8abzCJox7azmmfNoKnC+jHuFOfaz56oWI204jpV3/XLSe5o3xjVVn0a+0jPOQSd8wlyUO
 Dg5vq4h4fLlwViiGMudpacy9ESI67No=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe36d5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3K4JMSNACPa9h271a24A:9
X-Proofpoint-GUID: onMcPsZWrYpmfPd4pGa9ZgZjrONRjBDl
X-Proofpoint-ORIG-GUID: onMcPsZWrYpmfPd4pGa9ZgZjrONRjBDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXyRyfrxkykIvo
 ya9wGVjnaxQwgBfKkczueN/C/Nfp2TNjlRum+J4lajmI29MFiOy6v79DdLCYSExvHdImNsG0NH/
 AXvQfv5W6lJinxCih1oqppwd6Mtltp/Zc1TNzzTv37p+QZPlAL0A+xIoXsN/dGY8LrmTIitm6+r
 gxpFtcbrTNi2/zT+uTR31GT4Y9ssF79MVPHye6EvcrInTByU49YMWF7XAtMAJ1nUxQ2iQ5LdRor
 izuvjExL1Cxcg1slNwosVEvVFTe6iVz57unJ46GNjaYuUqHlUOgfN02qRJ64DG5Duz2T8R9Ly51
 5tFCCpEwBvdlbOyTyEe0alGpEjrjeg60UKS3vDzwT5OQyum5FjpjxGtNzmwF5Ja67eeMV41Ojep
 942votih55IhkZQ8NLAHGXUOiRPj0wu151rYXPBwrca7DoXPSXxweRhJve3xrYaNYzwc6UbqrXO
 l1puuwxnLYHeC7ioEmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

The mvcos exception handler ex_handler_ua_mvcos() decodes the faulting
instruction, assuming it is an mvcos instruction. In case the instruction
is kprobed the decoded instruction is a breakpoint instruction instead,
which leads to incorrect instruction decoding and potential register
corruption.

Fix this by simply preventing to set a kprobe on such instructions,
similar like arm64 is doing it.

Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index c450120b4474..e806b124e4ba 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -85,6 +85,9 @@ static bool can_probe(unsigned long paddr)
 	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
 		return false;
 
+	if (s390_search_extables(paddr))
+		return false;
+
 	/* Decode instructions */
 	addr = paddr - offset;
 	while (addr < paddr) {
-- 
2.53.0

