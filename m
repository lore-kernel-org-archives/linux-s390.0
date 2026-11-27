Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789453;
	b=wSYX/7Jbu4FuaE5MyOAL4IM2BDX1KcMb/qNeQw6w+9WCAhjO9TCduAq0AvOawU6zswNV
	 DxLOOL2cjvFIef0PIOraxxjDXZF0AXCV5maTAjVPCHBX6UUFJ4tNS+c8kZgdLQWBuT8mX
	 B9ZGOV4yf+5Fil2dSDBpI2ay1uaILRbRub11c8DFp7LvjsHm1O+hvcvAHUKGkfqlPJ+qr
	 taX5MLXrpucyKU3IlYKNW/tX1N62L9hFobXY24yjUWHTBOFEvtbm27sXqfl8UZkYVmLFs
	 tnVKm+1XmEA5JAyfj6RiH7g6It1twtWrTQZ6Scs8F5rhnW+1/Q56VluFXBeldTBDcnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789453;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yq1d2a+wSB1ioVQbR6h4uBkPy/b2kLL3saOY+G9hsS0=;
	b=WyjIBAaqGs6MJlho9FSlpTf+6IQMKsT7rAXFOBZYklvrcrKyUcGfpmv4cbtD1thBJL3q
	 Vvyt7qp16vIndO1lLOzlLgmHMyBRWxUU5EqYiGSBXs5YfvICtY/YVprZtsSM7LP2CMu2w
	 sWPQ0FWcZzeDzCUlQZKQ9I4UtZyunIl/YaJTgt5OcWLKHkDdLXADCqQVCGT2rveqEW2jN
	 yTRbXaPDFWXmOFYTcbtkahFipIXaS+LhtsSYOU/u5K+6HhEu9D/SWjgjQQBxWgHhxoIFS
	 qsusN2NP8ljGlJ/zhV/it5+1FWMN7oqRtir9s9G3KgabhoZOICaBiAXhKcHqSxWxvTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CXu2EVkl;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B360A5BE0;
	Fri, 27 Nov 2026 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F12B360A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CXu2EVkl
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4fla3234322;
	Fri, 27 Nov 2026 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yq1d2a
	+wSB1ioVQbR6h4uBkPy/b2kLL3saOY+G9hsS0=; b=CXu2EVklyIkxALhz/NxQL7
	KM0VRcP9FcycSvNQkqF+K9W6kXVEjSC2wZ4vGZXCCHXnlkQVVHQZbUz+oCZK5vlL
	mbQ9THochDycl8byc3Qf9XjBQXjLs9iw0gQdwsXJrIcYbtqGSR6aCdN7PUhttJBV
	6wcRAId8gKAmL5wSTWdQwl9SwseZH7+vu0XDqyU/AYn3FDerIk7lQMuKnTCJiznK
	UgEedo1RED0efbcKGlcNTNznj6G2PwppNRTXnqI3OHnq56A7ogux41X+FPOtL10i
	m6ZmQp+rzQqr2XoQQ6aBBYaH9pZhW5VF1slDt6Cdmrmma11WM5iPMVfwGf2pxkOQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvng5g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4FZ71180986;
	Fri, 27 Nov 2026 14:23:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6rhckj8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENKHL33161650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4AD72004F;
	Fri, 27 Nov 2026 14:23:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 603442006A;
	Fri, 27 Nov 2026 14:23:20 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:20 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:17 +0100
Subject: [PATCH v4 14/25] s390: Query arm guest time
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-sysreg-v4-14-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b09925e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=m6ce-YdoQendD5wNNHUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX+1yBc43zlEAv
 DcYekWXUqiDpmfCrX03Zcoo4L2+EYrdM/fBsAAKW2aOh9tz060488bF0bVuCIKV/QC/L1jRyWGj
 6weVBadfNhbdOaVQd09p2F2pkmIzapM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX6AblJOSwEY7j
 98RNuAByCrNYcSgpCqyBm1YJookGwi4w26TFCwOdQjsd2BvlLnuSJ8fBh0sgPWroKFMnQBPAfWA
 ovGEWCtracc4XQRkzz+HFsrTNTllNuOCBBTOxIcHTGKShnAS6aYVl3gZ13uUQA68T/r5eJYRPGJ
 zaJGYwXcc4SrQHWZGD63TYmL72gutM/lqm41xEVV9Fe3WwzBVWcFapf7mODZZyebnMUEL5e8p5l
 H8snCe5xZjrLZkgOwgEkXqw/UdnEWSFa5wv/uCamOa1YiV4waMAWonhMaEYc/YwZddubhU/HsSP
 6AQ/NHEHr4iFwRCAxOrCUrsYrwRd35hS3gjtOPg+SrWO94ZftU7ZrI0fiPWX9ROJAjKgXG/VXJJ
 CZV0DqxTHdzlh+yjG6Or35pkoIjsKqKw5t9PycgeyRQZZG5TeoLwQ/vB6jbRNSDR1CQs57l2lrq
 bFLXtkhDRcgb3e2b7yw==
X-Proofpoint-ORIG-GUID: wE3q3bIdUgn1P2Jf1Qz0QM7XOpezY5_B
X-Proofpoint-GUID: wE3q3bIdUgn1P2Jf1Qz0QM7XOpezY5_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270056

Add functions to convert between ARM guest time (LSB0) and s390 host
time (MSB0) using new ptff function codes.

Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/timex.h | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 23421b6eb225..8ee69fa3c3a1 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -81,6 +81,8 @@ extern unsigned char ptff_function_mask[16];
 #define PTFF_QSI	0x02	/* query steering information */
 #define PTFF_QPT	0x03	/* query physical clock */
 #define PTFF_QUI	0x04	/* query UTC information */
+#define PTFF_QAGTO	0x10	/* query arm guest time offset */
+#define PTFF_QAGPT	0x11	/* query arm guest physical time */
 #define PTFF_ATO	0x40	/* adjust tod offset */
 #define PTFF_STO	0x41	/* set tod offset */
 #define PTFF_SFS	0x42	/* set fine steering rate */
@@ -118,6 +120,17 @@ struct ptff_qui {
 	unsigned int pad_0x5c[41];
 } __packed;
 
+/*
+ * Query Arm Guest Time
+ * used for:
+ *	- Query Arm Guest Time Offset
+ *	- Query Arm Guest Physical Time
+ */
+struct ptff_qagt {
+	u64 in;
+	u64 out;
+};
+
 /*
  * ptff - Perform timing facility function
  * @ptff_block: Pointer to ptff parameter block
@@ -266,4 +279,44 @@ static inline int tod_after_eq(unsigned long a, unsigned long b)
 	return a >= b;
 }
 
+/*
+ * ptff_qagto() - Query Arm Guest Time Offset
+ *
+ * @physical_time: Arm guest physical time
+ *
+ * Converts the Arm guest physical time into the Arm guest time offset.
+ *
+ * The caller must ensure that this PTFF function is available,
+ * before calling this function. The condition code is discarded.
+ *
+ * Return: Arm guest time offset
+ */
+static inline u64 ptff_qagto(u64 physical_time)
+{
+	struct ptff_qagt qagto = { .in = physical_time };
+
+	ptff(&qagto, sizeof(qagto), PTFF_QAGTO);
+	return qagto.out;
+}
+
+/*
+ * ptff_qagpt() - Query Arm Guest Physical Time
+ *
+ * @guest_time_offset: Arm guest time offset
+ *
+ * Converts the Arm guest time offset into the Arm guest physical time.
+ *
+ * The caller must ensure that this PTFF function is available,
+ * before calling this function. The condition code is discarded.
+ *
+ * Return: Arm guest physical time
+ */
+static inline u64 ptff_qagpt(u64 guest_time_offset)
+{
+	struct ptff_qagt qagpt = { .in = guest_time_offset };
+
+	ptff(&qagpt, sizeof(qagpt), PTFF_QAGPT);
+	return qagpt.out;
+}
+
 #endif

-- 
2.56.1

