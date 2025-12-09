Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DB322A29;
	Tue,  9 Dec 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282648; cv=none; b=gsNqLkcAqfdIC7e274O9rHKvv4O6iD/EC+vmiIFOjEQVwclN8H+qxbybnKURbQG2F9dkK87n8x79q6MlSgCeA+TqJtB+BasdVMbJTp37Xd6AGzKKBcPCA+aO8glhdmegRGhHMjgJ4HRhxXB+Sp+JjDIrIcDnQrXdlrn1+YFpoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282648; c=relaxed/simple;
	bh=eJsX2ajUY1R9ap8oO4VM4sfu4Q5sWjTKSLpebgAr5L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5T9jxwRr9UCbKO2FKUgA11w+UnYSnv7en/MzOzx+KGyqXz+c5GBaZgYRyFtcq4mrrWMJNVs2BavSBOrBn3qn+UiME5lzPpS2kptwXumu06A2lGWT+KmZzcAaiRzcdgSnlZwvobvu/VQOA30WW/NVyHDBREtYkn9V2xx/n1GaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BluYHvoi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BluYHvoi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B94LL4O025464;
	Tue, 9 Dec 2025 12:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p5vgbocIzfu4UqJeE
	Zdzk+Ne/jsAz1Mol1zk9wTpmRA=; b=BluYHvoiEw8D6glRgCOo4isi0X9++U0cV
	XYMSjkiuCvFmELENhS6fQoLqbGpXzXlEBVgbEC7BMXiLgDdrNCavEOYW4pe3RvqU
	Ti26qG9kgQ4TBbsba1BfFrGacRvfNvv6k2lhBvUclcPqEa97dWFprsa5pN13K39P
	qkfmBCxjMRXMT/LCX23ot2N/Q1N8Tp7lEj3zIB4IOdr4nU2gO4ZPKf9pRsHxINm3
	jFZ9hNoJZ+g+5t6ggR03Nq8+33JKQQqYRuHuLlLkDUaA8lmCEVypHWfscH7BZGIa
	hPX6X/GSy+4Xb4uTtMcy/XZg/eawXbvCUIP8fQVLc1zAGD5aS3lCQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61crdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9BS77J009026;
	Tue, 9 Dec 2025 12:17:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmtskw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH3YY57475482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18FEF2004E;
	Tue,  9 Dec 2025 12:17:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7B802004B;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 7/9] s390/bug: Implement WARN_ONCE()
Date: Tue,  9 Dec 2025 13:16:59 +0100
Message-ID: <20251209121701.1856271-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX7/bSsKL1Xx/k
 K6EPWhYqJx6kXcdAhy/K3No6tXbIGDyD8WX720VONDaecoMgTfc98n5i3Sqz8rIvItW3Dvv/yrP
 Vop1dd3OBYqL4xfX5N/lKDP4g56eOfF+NJceNFelAjd/o2xOEXI9OOgowKK7jlZuPNopHJVtYp2
 2gqn1RzzWgUu8fpna7KG5uBiZafl3cCNWA2FSgqV476y9LZMkH1rQTLQMgImJL2x1dfw30gkq51
 Yu2T8FdKUxo7+gT3NfWA5GtIYR2cELiahAC3CkUJc0mznH07Rcg9KfJN/RPobOg/yRujO/cYo1Y
 U3gKLAbd4Nd+/iXVx9WAUHaKkEMhg7+1+hsDvjQ1ewu9egVchwQ73+WvuXgNifSaWHyAXOKhLVR
 Ob0Ihuvfmc0kSpr3nwipmULFvO97/Q==
X-Proofpoint-GUID: LFjeLZkUtCH5z27GGhCBu6JxWCYAAHzs
X-Proofpoint-ORIG-GUID: LFjeLZkUtCH5z27GGhCBu6JxWCYAAHzs
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69381344 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=t9L4_B14UcOybPqeXt4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

This is the s390 variant of commit 11bb4944f014 ("x86/bug: Implement
WARN_ONCE()").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index f3aca691bae2..e6e8b492c0e7 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -104,6 +104,17 @@ do {									\
 #define __WARN_printf(taint, fmt, arg...) \
 	__WARN_print_arg(BUGFLAG_TAINT(taint), fmt, ## arg)
 
+#define WARN_ONCE(cond, format, arg...)					\
+({									\
+	int __ret_warn_on = !!(cond);					\
+									\
+	if (unlikely(__ret_warn_on)) {					\
+		__WARN_print_arg(BUGFLAG_ONCE|BUGFLAG_TAINT(TAINT_WARN),\
+				format, ## arg);			\
+	}								\
+	__ret_warn_on;							\
+})
+
 #define HAVE_ARCH_BUG
 #define HAVE_ARCH_BUG_FORMAT
 #define HAVE_ARCH_BUG_FORMAT_ARGS
-- 
2.51.0

