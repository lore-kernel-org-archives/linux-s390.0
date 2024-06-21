Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103212C48B;
	Fri, 21 Jun 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929646; cv=none; b=TJ3crbaZdD43hCKGmH7pKeu4ozbnsQ+H1tV1wqKyiXHDpT61w/MWu8fGmnz0KN/snfesqu/usI9yAFrQsQGf6OmtDi9hX088GEf3ApT9VNCv5OthJ3MPrKCVH+Ey1nmxg9q+GZLn2YVB7WgAaRj4xyeOOd3r6nIL9TQTTBpunWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929646; c=relaxed/simple;
	bh=ZE4s9vXdBqS6M4ueN2Ozq7zT4w7ShtK+n52RYLf16ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPPfPueugyRvFAbuj7y6PylX6+77lZ9BCbQhAAa3F8E77x0yVsNcWjaJzQcWWZArA1FFmUpJhYvvoawP4FAtogranwUjX1UyA7fzHd/21TZFrLcigXqF8C9agt0umCddEkWYdYIsqDAIdp4397q7pnZcw91eK9mqSLb5pwXkvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WOG9KwPy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WOG9KwPy"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0QQck007775;
	Fri, 21 Jun 2024 00:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=tPY2/xfj0WoIT
	wfgq4isE+nahUee+x7RgpdrRutXdLc=; b=WOG9KwPy5lW6w/HKd3bM98s4XlbG/
	HxT0Fdi4dg1Af4TILtilSApJ0ddc1DxxKQpmUovmxZbyfnpR4gJgxyqqZ2/DbVm7
	6+AZ/8JNvxo4BmDNdEB1HnznDFfALsynkALE9mF3kQls/8WtGJZ+KLBM/Z/2cKcp
	fYI3n0+iQEpEYUEbIHAzCClNpgpCPPkvRLvPlpVA2Fqgk6dmMbuyuGuWg7n10vMM
	aI63AsdOkM2geaHldKvk1F12M4T9sLo/3T4s01K6qJwqaTElkuGmIA7hpmpUTkjg
	xhh8zW/qQEi9SDNWXqVJqDWKBnQjkVoV6prfVRLE1W5ZMS1xAU5+gr43A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c8769-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:00 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0QxAf007945;
	Fri, 21 Jun 2024 00:26:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c8766-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KLeEAh032326;
	Fri, 21 Jun 2024 00:26:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspjn0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QrZi54067482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1160D20040;
	Fri, 21 Jun 2024 00:26:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFBFF20043;
	Fri, 21 Jun 2024 00:26:51 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:51 +0000 (GMT)
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
Subject: [PATCH v6 27/39] s390/cpumf: Unpoison STCCTM output buffer
Date: Fri, 21 Jun 2024 02:25:01 +0200
Message-ID: <20240621002616.40684-28-iii@linux.ibm.com>
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
X-Proofpoint-GUID: ZyRH2cM2a1ar3ozL6AHjMGtgyGHBGmOh
X-Proofpoint-ORIG-GUID: ikkOvxFQ4wm1Gq2BQy-mlkcEGMDjF1s5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxlogscore=958 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

stcctm() uses the "Q" constraint for dest, therefore KMSAN does not
understand that it fills multiple doublewords pointed to by dest, not
just one. This results in false positives.

Unpoison the whole dest manually with kmsan_unpoison_memory().

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/cpu_mf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index a0de5b9b02ea..9e4bbc3e53f8 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -10,6 +10,7 @@
 #define _ASM_S390_CPU_MF_H
 
 #include <linux/errno.h>
+#include <linux/kmsan-checks.h>
 #include <asm/asm-extable.h>
 #include <asm/facility.h>
 
@@ -239,6 +240,11 @@ static __always_inline int stcctm(enum stcctm_ctr_set set, u64 range, u64 *dest)
 		: "=d" (cc)
 		: "Q" (*dest), "d" (range), "i" (set)
 		: "cc", "memory");
+	/*
+	 * If cc == 2, less than RANGE counters are stored, but it's not easy
+	 * to tell how many. Always unpoison the whole range for simplicity.
+	 */
+	kmsan_unpoison_memory(dest, range * sizeof(u64));
 	return cc;
 }
 
-- 
2.45.1

