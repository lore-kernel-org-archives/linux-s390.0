Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C084D29;
	Fri, 21 Jun 2024 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929641; cv=none; b=H7tiyW3n/vpbZe21egXqiW9K0TD1j/u+PLGI1JEO/Uezg9IEwU/9MXOu7W2DM6r4pSpcHbVm+B/6moW8AIznpsd2gz0amUjWdrn8Rd+OPinyMcc2/tBwFn9J93eGHBGAJBZz+Cf55alSVI+zTpn4emR1oJ/fsEwjQH/DneYmnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929641; c=relaxed/simple;
	bh=93I0DpW7vBHhALniPtqGUbqbmlZPAa0esu20HJ7Lw98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZh/T8RJoX4UomtlXDMS2PB+sCaeDh3hov8Z288AcNiEn/eIaG49hkoxmzyfwtKcUlL/t7XYsFTMjRgSpqZ4aUE2+38Uz7OQocLjS/7S+2v3c52WP+tV1lF7m2/kGZ9OUz3yzpnJeSllTeYbBmCcgg136XwxE0SfXF5ewD3DR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PNF7gbL2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PNF7gbL2"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNtjEU028042;
	Fri, 21 Jun 2024 00:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=//0Kc+3BL5cKz
	p2INWy7uHqYWutu2bfhjte7hQD65vA=; b=PNF7gbL2puZuQ+js/w+zDJTHu/+C9
	CEQ/m504q8i3T4mqudfRdya9hSrjEodUkeke8DarSdwPD3jceJAWgB1D6VM/VpVp
	j7Kh5D9FGaWDsB2l5a1Dg+8PDV7LtkTh07U59cN+55mDRMMlmPN5Nnf7Kp3+C+6q
	rcgz2nDLzulci9yeR/yZUCsshoXuoIycM4u0mCrRV8C6aXTWrlFLfW/AmMBymZz4
	sJJbfFwA3DVQAgVxt7n0Jfhnh9mZb93BSTkcP64eDCNMtyEYTzAWz3FXt53UkSte
	wad5R6D+6i2GzvX8qwURobdjfNG8AW6WQ8y6sfGxTbfvYHJbsajRLOcUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c876e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:01 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0R1Ns007963;
	Fri, 21 Jun 2024 00:27:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c876a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0GVt1025708;
	Fri, 21 Jun 2024 00:26:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrqv2np5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0Qsuj16253276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46D862004B;
	Fri, 21 Jun 2024 00:26:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 257B420043;
	Fri, 21 Jun 2024 00:26:53 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:53 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 28/39] s390/diag: Unpoison diag224() output buffer
Date: Fri, 21 Jun 2024 02:25:02 +0200
Message-ID: <20240621002616.40684-29-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621002616.40684-1-iii@linux.ibm.com>
References: <20240621002616.40684-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dR-59j4Kk4tyD4-uSWRXBGdaB4Fdihzm
X-Proofpoint-ORIG-GUID: UqQveLdo15GSMG0ihOGcB2yNIYG0gRJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

Diagnose 224 stores 4k bytes, which currently cannot be deduced from
the inline assembly constraints. This leads to KMSAN false positives.

Fix the constraints by using a 4k-sized struct instead of a raw
pointer. While at it, prettify them too.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/kernel/diag.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index 8dee9aa0ec95..8a7009618ba7 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -278,12 +278,14 @@ int diag224(void *ptr)
 	int rc = -EOPNOTSUPP;
 
 	diag_stat_inc(DIAG_STAT_X224);
-	asm volatile(
-		"	diag	%1,%2,0x224\n"
-		"0:	lhi	%0,0x0\n"
+	asm volatile("\n"
+		"	diag	%[type],%[addr],0x224\n"
+		"0:	lhi	%[rc],0\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "+d" (rc) :"d" (0), "d" (addr) : "memory");
+		: [rc] "+d" (rc)
+		, "=m" (*(struct { char buf[PAGE_SIZE]; } *)ptr)
+		: [type] "d" (0), [addr] "d" (addr));
 	return rc;
 }
 EXPORT_SYMBOL(diag224);
-- 
2.45.1

