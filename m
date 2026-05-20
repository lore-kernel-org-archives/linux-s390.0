Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCB3BFE4C;
	Wed, 20 May 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268994; cv=none; b=BV4StmmnA9p4duR6vHbilgNfHcwVWhRrdY4F84GlMVpU+WmHpb0UYK2MQMYqaeoXvPIW5J8JmAaVZgeyKswSiPgFZrHCOWNM1/N+DUm0ZfvH5+nrz2xqcUzGIE0g4TE8CBtSEmEgUjwMCGF9aKr4w2R/9cXVE18ikF40UPXF67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268994; c=relaxed/simple;
	bh=LK/9+eVDGDlX+wVK9pqJWT+ZFJOaNa7xi51Ag4LlZYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge99nuiosD//7Tke7p0rCDERF+wSUqXPmsmIwo/FikkDSh+DK6c2CiSKzPF6WkD1vVTvtDulAfw0aWzb6ExaU3g6NcYXiPKqoUPFgu6egRIubxcfCUHdUMnOwh1ufeFgI6RswCK11X7+uH2C6rbPhGFCr9H4ooQU4gmTJ4Fp9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sUazi2aU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sUazi2aU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K2YJ5Z733638;
	Wed, 20 May 2026 09:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vxdFKml+j9Y8jaQUN
	SlogzILQtLAndqgJwMrzL8AbWI=; b=sUazi2aUERxEGkPFh8f0sTcKCxd6Boyw0
	eD+1pYmeXDFHDceo/GE9JyX4r7NqQlyw3bKsGbPwOUEJmYbBYqUxYEmsOvRi4tvp
	XPFe31giUKkDaNPHaHW+9NBw4roK3zyDqa56W8d4qrtAGOzxUQvZVVLb8QpXJ7bs
	TSjyTSK+4Q4esVUDM012gvloOFP+LdWE3L70wzDVP5T5pHVwmRGh15wEMtXPb6lt
	BCp/675IjmqgBIdnVdyXph3CR2Ftibsa6FzBb+QlprHh92VcO4uUhW6cJYFsokl5
	ryZ9P5m5VXEw84HbiiKtKsI62KEtIr3i5E7OitO5jgbioOX3Kx6Og==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8gb2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K99E8i021778;
	Wed, 20 May 2026 09:22:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhpkup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9MjM356885606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02A5720043;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA6F32004B;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 3/9] s390/percpu: Add missing do { } while (0) constructs
Date: Wed, 20 May 2026 11:22:37 +0200
Message-ID: <20260520092243.264847-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520092243.264847-1-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfX4eH/AtowW13D
 bRxE9/nZ4crh4tapHrYvSqBzHNhPv5AG1IYVB7DBpuKuEDj24Ao6iGWdoBvAgCK6ZObl6q21muv
 ljlgAel/IeEKP2YXkqobvJ8Z7XSTBEOhsXMc/Vf/7SPaYfR1IJ9llhRQ6f888icHzueSc1ImP4+
 BsbJw38DSBOvulEt7gvIxZupYefmWjYYLHByuQNxma0OJD4H9cuxhgR2YpO+h0qEuOf7f+wrRKs
 mdBOXlFxUjrJSYbGbBANlNpQFHzc8NKNlVJ2VFMBYCDYdST9t0tIplQAL3iDV6v+x2AQb+YjNGQ
 Bf7t3RgORfQH2fFaEKsOUmxIx9kJhBpjJkqGdD5oh1H8hPpVoksWBBLbx2bORCcI/2wHLzj2ZfZ
 tttrc72Q9fyLI2ICyzBdB4l2BMshC0oZeBSjvC8bK0zSYq0Spq69t9d5TC407gZAvj7HzR4uGv5
 otZ/+Hk9MSKXx7tGSmA==
X-Proofpoint-GUID: VDvhlEaP8o7DTnx5Gc5nR-mYkrpCqZkx
X-Proofpoint-ORIG-GUID: VDvhlEaP8o7DTnx5Gc5nR-mYkrpCqZkx
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0d7d69 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=V-yoBbGPs5LSgb0Mvs4A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200087

Add missing do { } while (0) constructs in order to avoid potential
build failures.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca%40linux.ibm.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 1af622a8aa67..c8fc8b320a86 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -128,7 +128,7 @@
 #else /* MARCH_HAS_Z196_FEATURES */
 
 #define arch_this_cpu_add(pcp, val, op1, op2, szcast)			\
-{									\
+do {									\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
@@ -149,7 +149,7 @@
 			: "cc");					\
 	}								\
 	preempt_enable_notrace();					\
-}
+} while (0)
 
 #define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
 #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
@@ -174,7 +174,7 @@
 #define this_cpu_add_return_8(pcp, val) arch_this_cpu_add_return(pcp, val, "laag")
 
 #define arch_this_cpu_to_op(pcp, val, op)				\
-{									\
+do {									\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
@@ -186,7 +186,7 @@
 		: [val__] "d" (val__)					\
 		: "cc");						\
 	preempt_enable_notrace();					\
-}
+} while (0)
 
 #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
 #define this_cpu_and_8(pcp, val)	arch_this_cpu_to_op(pcp, val, "lang")
-- 
2.51.0

