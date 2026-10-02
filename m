Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD653E49D2;
	Fri,  2 Oct 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954465; cv=none; b=rzM2A1mFHCgZJShC/fwmZn2oEFl7u+dYC5G6P745gm8DMS280g1sQwbNqaEjQjRISBxksb5jsOckTLpiypZBzyyK6Iy+iJNXCm9DhRtwgjiv1fLuabGGgXdLyvy6S5LD/ViOQt2hO/Ki4qrVcUW+s9Doe2XYjjBWrERVEc2PHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954465; c=relaxed/simple;
	bh=T1oL11WEu/R84JKMcsGq9LJmXZaeaunn19iR9CqWxhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTO0kPZFKeYWjP8YPE5WNEVXAoDH297q1QI9HOc3dml83kRSXQYqYzTMR8ZtGNN+Lp3Ai4cP1cyYsYGI6l0ecX2fklKggMnAVV7Bp1KVoLSkfWFfE6NsiDhsLEKNu/Fhp+hEtXLQp9f8meiqfQuHX6CbugHvu6qyJsnu7ooSdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QBupsEUh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QBupsEUh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DZf4q2996597;
	Fri, 2 Oct 2026 15:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pB2Amn0HqUKCDI3x5
	Qs5gu2ApyiPsByzwM4gv+ZRGRI=; b=QBupsEUhUBLFaEo5iO9ktmCygixVMkgq4
	O/Y9kx7F+MwNha46pQ8FITb+X+6YK2cwy+i3dtUZFsc9zDuTjyp/pG//OO0i+cCf
	OtPxPTFPRA3g6D2mDxGUqBpWfSEP6eQxn5IKizr7z+///5kxOwptm5ebZj19X+xc
	RYaq2+eQC+D9JR3UvWorI13XOH3eeT5TVHkvg1588VjennX4aABog8fS6revdhbK
	3j2vZIbdUKl4KM/sqh2x2U/02GrmdOldQy8M/HFNnU9GWlX8y0jy6kWoT9+tfmp1
	fivJ8VZQ2VDcfK9HtCiDpy7vvMfev6yTE88o211vxnke2Eb20hT/A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrsxa0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 15:21:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692FHlTc1429264;
	Fri, 2 Oct 2026 15:21:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pmr8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 15:21:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692FKujE37749134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 15:20:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D64D20040;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37E3F2004B;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/2] s390/entry: Last breaking event vs invalid kernel stack
Date: Fri,  2 Oct 2026 17:20:54 +0200
Message-ID: <20261002152055.3305184-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002152055.3305184-1-hca@linux.ibm.com>
References: <20261002152055.3305184-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MCBTYWx0ZWRfX69nLP5RmxWwA
 TWeZUdqm4pzdvZBtsoC6F6CVk3vmoxStXYsSMMIk6rc/6KiHgGbcQr0EKzjdxVcnHMlgvImYjJ5
 DQ5BySUaMEP0RG7mD/G7zk5A/rK5gUnmbGglJ0XjB29kybCEzUz+k40f1gA3u2/2k7usjkLwyDH
 8ExOZVa21lEYzLdRaw70CwrlX4da9hqsvXWbVdbxeItpHCuku+pvXDA9lzPIP2uvkuHdYVoPgdi
 aLlGen+O3SE1ffRVVE91lsqpRDcSADI8ZY6JdVxuZTNc5I+CWScBz9X18pWod91Af/kSqjZgO7c
 8AoOBWsY7Y2ZjBJhxX8e6BJnGp21NHL3ry2b80rF9f4PlQDuu2hORCFVjWWmx5AP/eTZOnTL0zV
 YroZ/FwJg1LaC1uy9AwNSxYRGumizPOx5ifoFF2LMuAkDDuRP2LqJfSyQ646EaZsw7bwC+cyrj9
 y6VlLkdXjVOCnFEuAjg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abfcbdc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SfYm7YZ3WyxsqpxWyRYA:9
X-Proofpoint-ORIG-GUID: 2j0hqEB59-7KA0nFxxh67Y6y2Do09QBD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MCBTYWx0ZWRfXwIWRL+C0FXKe
 mHT0ORi94292cSk5vkT7KWSBEVkXspfgqEJk+ryAfhF3qG2aG+lLBIf+XdM+jA0shALdwyUJLKU
 sHI4qNgC3kVBpIQ8dZGW3gSFC7sIYLI=
X-Proofpoint-GUID: 2j0hqEB59-7KA0nFxxh67Y6y2Do09QBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020060

In case an invalid kernel stack is detected the last breaking event
address is copied to the orig_gpr2 member of the generated pt_regs
structure. Correct location would be last_break. Fix this.

This adds help information to the printed messages:

Before:
Kernel stack pointer invalid
...
Last Breaking-Event-Address:
 [<0000000000000000>] 0x0

After:
Kernel stack pointer invalid
...
Last Breaking-Event-Address:
 [<000001b802c1ae1c>] proc_reg_write+0x5c/0xd0

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 10dd9bbdf985..4e99ed559dbd 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -622,7 +622,7 @@ SYM_CODE_START(stack_invalid)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_R8(64,%r11),0(%r14)
 	GET_LC	%r2
-	mvc	__PT_ORIG_GPR2(8,%r11),__LC_PGM_LAST_BREAK(%r2)
+	mvc	__PT_LAST_BREAK(8,%r11),__LC_PGM_LAST_BREAK(%r2)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	jg	kernel_stack_invalid
-- 
2.53.0

