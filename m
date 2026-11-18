Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013253;
	b=30+NSEnwBDZJHf9QMua/Jv3GMVZkGYznoXj7NpPMzvfwEFHYA0BgiAU2UfodK9yZebHW
	 n+cBx7JIxxVjSR/khlBvNRiiQVmN1ANZeUi5paXelM3EabxBT5sirdWE6EyKJofXd4tVr
	 oqlcWCiQZZZwf7mbL3TlNeNV2W71XK/ZP11afEEnliSRHNztsWOFRQL+BwPMsTdI3NrhB
	 5/PgQoiSZ7IP90ZF3SYJ738ElLoCbp6MHnb1rSRIq0ipPa/E8MiYzE5JvL/p2cE90gV89
	 avS0bjG3KFsXk6Bb95/2+9evKt2N6mo/VVAQFbyAAK0Q2+2r1z2L1AbG132b6y/reCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013253;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=X0MGiG8/C/z4k56I/+tK9zm4IYuupc7bWFTBJoQpKIw=;
	b=ryicsl0D9c5/flZNrET+QtAMgMMed48D1aaGVl/z/NAm0vwfCvx2yhmZPx3C2RsqhmfP
	 2006zAYvffcmxk6TSI2VQj6qXDh62baIE2ujOTYwtAzqbTGgOIhjHO/MO6SKEaI+OBEUF
	 orROfuwTEXpMV+ag+jxzqbbiz/O8maFwOxGTRjPAL5z4DLUUAmR2kHkrKutDMBvnRPjhd
	 Wu9DmhSKeXAzcKskReXN2F0VH7SS5zujkzunJH9efT641NX49lNZLAplJ9YUmqLKF47Kl
	 VFObbUZ+pbcmLm9Bm2Kp6slQpEgGo7MbAFxd0bMPnFZQQhQwq0+2uH+RVM7KjX+Hgxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l4yWKlb3;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2A60A3804;
	Wed, 18 Nov 2026 14:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F2A60A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l4yWKlb3
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQfvb1196306;
	Wed, 18 Nov 2026 14:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X0MGiG8/C/z4k56I/
	+tK9zm4IYuupc7bWFTBJoQpKIw=; b=l4yWKlb3LHU0xg/VhwbOqWrqplDsXhyye
	OpYoFRQBQYsPcorhFVnfmr2vXrvXaRZC9ZpvIARae4yXQVOnirzRk9N3f9wEy2un
	mVbAlf00qG/UxjWOutxQPbW4qdshnCXsc2s9qC2OvY8s5COTyf3LCfi02bLfcYCq
	UPpsq+QPNxJ2kuwYJhfGeaNcl78Pwg1oAXvs6NghCTf/42Y5l/TwzbbaJHeRLkbj
	ubl00GyOPzthMg6yxUdhrHFD/irgVRgq8WtB87QawnyfNjq97HJoIrhyb7IkNaVt
	fNQTIbVzsM7I3KGpVbX+9VefqYm7QLuTFuZ0VM+yE8vuPyZnoKh1A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wtuxc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYvFV975383;
	Wed, 18 Nov 2026 14:47:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ng6av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElBJH34341246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 643E420040;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A9702004D;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 6/8] s390/mm: Add error handling to mark_rodata_ro()
Date: Wed, 18 Nov 2026 15:47:07 +0100
Message-ID: <20261118144709.202520-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uXgoWa1bTlSiLHcQx48p9g6Iv-3j_4xC
X-Proofpoint-GUID: uXgoWa1bTlSiLHcQx48p9g6Iv-3j_4xC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX8ECN1zIfdNJS
 HEHMy89ECvxbz1bj7Y6SukbJDM4SBXxSVR99Dys53idljD/SCcu88HHxGx5a50/zC9+mjbj+MmA
 9UxCUMs672jIauslHJBmZGvTj5h77DFSvDdFcCeUK4j6JAEgc5BvxtcJrN5gJ/cf6+iuml0PIVZ
 74zS4CKV0MrixaUem2Q0YA6Ev97mr7cTXyjTJ7/oVKePbgaHzWjyKiMH2zRb7HfhKOHazw3WYaf
 q5wRDYAWXWm/hEhokNcbi+qyYZYJWEZJ707hm5tZIQ9Q1/bFrE37A6Gd0n+2wg3CNml0X4aIqaJ
 cUIpYuKPYka+3m+Xs+3LdL9pNtwGo6zhtXOGIkysqrmJCp4Ou7oDIFM46Ga4ntGGguVkSkclHpX
 k6t8S+usFGxqPDwdhTm7BIRiGw3j19Tnj91dQVd0lRejg/jg8f47W3WG6VHLd152UYvAG0aj8t+
 I7d6QvWyeqcUP0rT8Rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX9UGPbZ80UrQj
 pCpbjRUZE+P+ZpY99FBiLMa+fBEOmJGMf6dfPO1KqecUwC54qrQiC1dimW5tZ0Ao5QI9XhLrcZt
 2LAAitvfkSW2I/cn+EPmlT+uiZTQ0L8=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afdba73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ykA0mLqrmMDSWFB_v88A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180057

If __set_memory_ro() fails early in mark_rodata_ro() just panic.
This should never happen.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 4d5a13b19dca..18ce7ea2f653 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -110,10 +110,13 @@ void __init paging_init(void)
 void mark_rodata_ro(void)
 {
 	unsigned long size = __end_ro_after_init - __start_ro_after_init;
+	int rc;
 
 	if (cpu_has_nx())
 		system_ctl_set_bit(0, CR0_INSTRUCTION_EXEC_PROTECTION_BIT);
-	__set_memory_ro(__start_ro_after_init, __end_ro_after_init);
+	rc = __set_memory_ro(__start_ro_after_init, __end_ro_after_init);
+	if (rc)
+		panic("%s() failed, err = %d\n", __func__, rc);
 	pr_info("Write protected read-only-after-init data: %luk\n", size >> 10);
 }
 
-- 
2.56.1

