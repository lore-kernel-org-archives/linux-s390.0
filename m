Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC5824B0;
	Fri, 21 Jun 2024 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929636; cv=none; b=JLW6Slc7VdKyeNPzBUdxmpwCaRqiZ4k7rH716qWNGHEmA4b5bBkd7zNBIVfdSwePrGwejn4Pk3GplkzISyGzT3hQTUg1t40xrOgBFmmDPVXMyQWxn/zNXS8PQjADcoiggkRwB1h4P4xoln84Ww656XQvmcNVMhfj7KNwKwznoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929636; c=relaxed/simple;
	bh=yLODR424wN6Si5VovUTqGqI4qtFKEFKhgXFK6cJfh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP2ZXR1fG9nPVJd+dXuci5ruYML+Ip1s6MyiQGCJE1kMwTBczX3HPCxlRb2PMtGkgLdUI4G+eBmuCsv8iU41WZ9nEodiTg7jEIQAsSTIGPn0Pfd1B4SbZR57WksP+Kcs8hdFsSmUz4D6eZuNqS7Kp9MVn+sAhMxBWeWW+XAxP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KYKLp6Lc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KYKLp6Lc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNunGB003964;
	Fri, 21 Jun 2024 00:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=OrFUkNCKCdyNk
	ojULrcA9z04Ys3K5qGxpLIcxQ1wcAk=; b=KYKLp6LcUz3nqZ+RW7ovC2z1c/N5b
	QtagkMsmAEhbv4tgv8QzYU5enY2uNvP0ZTzFqd+e+Pd6bUOdcZNXFcOEJ5fdGNGe
	Cx6q1Vm/EdWPSWAcBJUusbUipW9kiTyDOiEinqIbjaM7t5mMxyMqnRLlGL8ww2mC
	l4gsyO+98X3xAE31y+rmCP7fLnlHwIl9wRo6DlzFVCHPpillFZ6fJgUoSz7JDd1A
	kp4LpkEVpYwi6ocKgNJsgt/kP8kRYaC6Mps4w4bp2FR/PXgWf+2yg8O6qI9fKTTX
	rFIeB1sGYUVk90P5E2Y5JBBLxaDiAJiL9AGbu6FVVwUWfcjwTXgWlVs1A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvrr07tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0Qrn4016999;
	Fri, 21 Jun 2024 00:26:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvrr07tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0LpV7025805;
	Fri, 21 Jun 2024 00:26:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrqv2nnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QkkW54329664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0EEA20040;
	Fri, 21 Jun 2024 00:26:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC62020043;
	Fri, 21 Jun 2024 00:26:45 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:45 +0000 (GMT)
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
Subject: [PATCH v6 22/39] s390/boot: Turn off KMSAN
Date: Fri, 21 Jun 2024 02:24:56 +0200
Message-ID: <20240621002616.40684-23-iii@linux.ibm.com>
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
X-Proofpoint-GUID: KqfiPqK70_1rV1P1C1Gy61-oQxzvQyn8
X-Proofpoint-ORIG-GUID: ZAgRwklkhYOmeFVehQ1O8m4QPib-ljUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=742 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

All other sanitizers are disabled for boot as well. While at it, add a
comment explaining why we need this.

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 070c9b2e905f..526ed20b9d31 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -3,11 +3,13 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
+# Tooling runtimes are unavailable and cannot be linked for early boot code
 KCOV_INSTRUMENT := n
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
+KMSAN_SANITIZE := n
 
 KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
 KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
-- 
2.45.1

