Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE6824B1;
	Fri, 21 Jun 2024 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929636; cv=none; b=n7Pm44K85/tkA4ZRgtTfDPJt9wOdm1GqZ0CgzttuaC3LseDLh3Mg4f9HEEfoZKmMmWclzzLk0uadY0ELLDsM+hmlWpRRcy0f4W60dCNKFgmH3XGnQsVSXBYDYskinhXknsUJKJulAsGv81ZwMl75bXj5rrlroq1H7PkemWJ+AAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929636; c=relaxed/simple;
	bh=jj2ie0mXDZXoykKheI+Ydx9F7sMDJBXe5guY5dRi5RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsnTlDi3zH9zeTZCPMHrrm5TVL37hTcYMsCIUPjT+chBGHE7eCkWXjNURY+101WjMLBkz6TYHND9CTr0HeiKQofNAWPhDrH7yFjZF1FhMGKg6Eu+ePncQ7XaeR2aYri8ysYk5n/xJrnpPyArmtw/0GODZA7gaRwaURpl4TKzIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cy2g/IQJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cy2g/IQJ"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0QxwU023263;
	Fri, 21 Jun 2024 00:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=K/viBy/PeNICI
	TSZpD3tBAO/npQA3ucnq3Zo5JONrlk=; b=cy2g/IQJ/rIC37eXKJgyjCiCGbIyu
	tKRrrpl7nuQQiFJlc60Y2DCFhvK+PLKi44YCFJbMvtAjwlWiPFKYltlIIlqOMCtt
	apOdrkBvxP7xc4GeTA9BzQ6JurhS2n0M26WmiHIbRV7VmdxRmxAABkgIe6jp2eKS
	irqQGxXyvB21z8fT3F+O2kF2un7qUzrmPn8oKQBidhQwMrQx5kd9o1gOsIVL7Fyn
	KiUSY/KupVXdQp72xf3m2yIC6cwX17/4e90+4IF+0tYNAiUfsW0rgy9RIcwl7N+4
	xp8iT00GDd3vq5s0wvYdPdHNo2v00OrILQF4pRSUuClEIt/lALkkXqasQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvs6g7sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:59 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0QwpX023250;
	Fri, 21 Jun 2024 00:26:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvs6g7sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0Mhnm030888;
	Fri, 21 Jun 2024 00:26:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrsstn39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0Qp3M52756748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB30E2004D;
	Fri, 21 Jun 2024 00:26:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA86420043;
	Fri, 21 Jun 2024 00:26:50 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:50 +0000 (GMT)
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
Subject: [PATCH v6 26/39] s390/cpacf: Unpoison the results of cpacf_trng()
Date: Fri, 21 Jun 2024 02:25:00 +0200
Message-ID: <20240621002616.40684-27-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: pFMJ3VX5eByn_XhL8lU2OEpij4dBIlvJ
X-Proofpoint-GUID: RTniQi-mQ5NH7pBqPS4RncFDW36QzFEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=780
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

Prevent KMSAN from complaining about buffers filled by cpacf_trng()
being uninitialized.

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/cpacf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index c786538e397c..dae8843b164f 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -12,6 +12,7 @@
 #define _ASM_S390_CPACF_H
 
 #include <asm/facility.h>
+#include <linux/kmsan-checks.h>
 
 /*
  * Instruction opcodes for the CPACF instructions
@@ -542,6 +543,8 @@ static inline void cpacf_trng(u8 *ucbuf, unsigned long ucbuf_len,
 		: [ucbuf] "+&d" (u.pair), [cbuf] "+&d" (c.pair)
 		: [fc] "K" (CPACF_PRNO_TRNG), [opc] "i" (CPACF_PRNO)
 		: "cc", "memory", "0");
+	kmsan_unpoison_memory(ucbuf, ucbuf_len);
+	kmsan_unpoison_memory(cbuf, cbuf_len);
 }
 
 /**
-- 
2.45.1

