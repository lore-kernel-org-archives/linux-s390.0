Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB445563A;
	Mon, 21 Sep 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980029; cv=none; b=UbBrBTrFAzvYP3nFvCjXI9C9cJEnja467H1jSIDwdgmLfYb22VEPhPavAtLaL6GPhe3ZPLAsAWvFyRAI26aaWPn1rGDCaOPxj/Q229CmVCHaXRTx/6gGYqtjGfkKJxNP8jguapfE6nGAAeBUFatwc2Ks9LGMmrhP5abFqgarDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980029; c=relaxed/simple;
	bh=QuLPXVAFgIJ9fPxmYJemmPvdwZIjvEMVor4YZEw3MJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3OOyc5Ydx9c7SoLbGw+T3vcoswZVmJ6dU1a/kFxb/8HcI6znIPeo/kgPRDAZ8PHOg7xXATPRJRirZcb24z0PV0mwALrUB85+tFGZk6ocUvfU5deAlqCYMKX66DLH2o3s8Bo32NLMRoUUFzNCVFKjySGtM78/jQ8+HqgE22jnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JoIbgXNc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JoIbgXNc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZPMk3153652;
	Mon, 21 Sep 2026 08:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UbSM4J6q9wHJGxcag
	Fzwg95TRKRs0Sfalw4VwKXSGug=; b=JoIbgXNcfrPnmrxZMWw7m4zjP8IMlmkpi
	33x9WRmx6H+AHtkM2mN41bwMJJFyvLhBYyKHr2PsZi7GSFoPN2+NLQz89JKUtpQg
	B3H41fqDTZ74nf5XqhNgDHqqkuprJDwp8iem6qK+C8qIS5VKoRDRVeTgNMIHuQYD
	DasXqGQz/Zpp6pg/OX6yhGRGAK5xdLQtx4iCdO3RM8txn+XERSB72hth5NNq3/2A
	16TjDtIqftwlLDB/QZfMDxWbND39FlF6njxb/AIQeDQY+zT16wCEU36xbR5A1R8O
	Lur8tsKl7DPkQoba6uhqTMXEEDB6yViWBR1XDNoV/WifHnb3/0Hvw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fjub-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HTk1924403;
	Mon, 21 Sep 2026 08:40:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq4mrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e7pp53281126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A13E20040;
	Mon, 21 Sep 2026 08:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E82E72004B;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:40:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 03/11] s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
Date: Mon, 21 Sep 2026 10:39:57 +0200
Message-ID: <20260921084005.4022574-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921084005.4022574-1-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Oa59B8snKXqc0Ry8RQnCFj-sGAZWM9rU
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab0ed6b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=phCDqYjOjFlr_q_ZZjMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX/3ScFtneG3jb
 WUu6pxxevmcXN6c6pQJIyBOmfdQxr/4K8jGG7/LpAkJNWfWHCbJiomwqQtYQiFy+fbcVOhSzszt
 LKFBN27FbfgL/Lz6ivaLFEBHwQUSBYo=
X-Proofpoint-GUID: Oa59B8snKXqc0Ry8RQnCFj-sGAZWM9rU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfXwdkk+HgSLPqY
 Bq1kBdOmxAxvrg3Exbn8I45Jj4qq/+tvMozlljXde2PqdI+5WmlO0k2+2eHEsWTve6fa1sgAyUF
 O0y19AHiyK2h5eeC8hsJUNq3sRA/NoVCah7+FsXIuNEUn4rfXdqvtj1w6USJnqH8riqBOqIcnIs
 pRk4+aeMuxgHvoH/x57iHFQ7N6eRSnItQMjMzUgqOj6TRg5WkHUDP5zPhh6Xae3PZUY2Ts/c8W1
 ZkeJphc9lzd0IOenqSW+upRGgSJ+AO/5iAjsVAjO6l7dQbL+3MUl6NTo3vMNEPiig4JsiMWAthh
 7wbxgK+Png2dm4rJRzNZNHC2VvPXh2Mbk8oDbkqry8vKqvYn9Ew38Kv4N3VD8TZhd8CYp6XMKQr
 CQTeExpeNpdtsFBZo+UDVNQuXI3/r1S3+wGUdWhCsmxT3pXLXBAuXxUkN5xbc7j77LdRMRhCpYp
 1uVp6m4a1m8FbsE78Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

Remove the _AC() conversion from LOWCORE_ALT_ADDRESS. This changes the
type of LOWCORE_ALT_ADDRESS from unsigned long to int in C code, however
looking at the current users this should not cause any changes.

This allows to use __stringify(LOWCORE_ALT_ADDRESS) for inline
assemblies, which otherwise wouldn't work because of the UL suffix.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/lowcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 5cef215d30e7..f0364a9f8a19 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -21,7 +21,7 @@
 #define LC_ORDER 1
 #define LC_PAGES 2
 
-#define LOWCORE_ALT_ADDRESS	_AC(0x70000, UL)
+#define LOWCORE_ALT_ADDRESS	0x70000
 
 #ifndef __ASSEMBLER__
 
-- 
2.53.0

