Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FA451990;
	Mon, 21 Sep 2026 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980025; cv=none; b=XNsC/8GWycP3iBqeHCObvhwM73PuXnPT5T2rMl57scdzPbknTynzbcsgqUn/b4F8/LjZut8sXSr2Kfy6ABg1B91pz/OPjvU75HNK6wFhY4yKJVfsX0SQqxWBBtgI46ZnqMKV7pGisKcWuauuMPbd8eiKJn5rbT+K38u7inUZAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980025; c=relaxed/simple;
	bh=o9hPxOU9kHloIARfub1Nrx5KK2t//Hd+uRzDHhtzPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLK+4qAlppHok+UnkUi9yAXyLGN+0ZlpMKqalwYftNMSgkxuxPWSE+cWwlTCKBFFhEZPnjZWfk2J240OFcO5rzrVFsM0h6fWaOZN8EmQgWFvNH16oV9ttVW5SxPzHSR6k2odZntdXzae6n1h5qftIc8YgSIHewS3Ts6f/WXr9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BRbqd+rI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BRbqd+rI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZNvM3153438;
	Mon, 21 Sep 2026 08:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vfh+Ku1qHAtSrYARs
	L7UNTW+AGUl1eoke7UXxnSuWjU=; b=BRbqd+rIabIzd6jzaeJLaphHobiklG4ls
	noRzipbpRRykLXWMBimY8wr4ncgI7SgZL0aOnNYyMd5766zNi+eIltrbe4S1Y5Mz
	WuncA+d+Fy/ZuQ4bAipEKQR1SatJLJg/sCGyos1ME3dW41cR2+WWXHVoMUQy8PYP
	Uqj8I4El3rzCcKzn02rnD6p0g+03t/pgkQFmg5vCsIdKg3GEYARUwUTliGXPS6tA
	oPokWWZXfQZgBvgrxUkUZGcS2zaes/GUIKn9yVKMsCphKrJcpA3w6SytSsSyM6EZ
	avf/aqY1EoqfaM+1bhBXSfosCPWGv7bOR5PCK7mwu/Uo/jNfboOCA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fjuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HeRF887375;
	Mon, 21 Sep 2026 08:40:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gme75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:40:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8e8nW51380558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:40:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39BD920040;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F8CA2004B;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:40:08 +0000 (GMT)
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
Subject: [PATCH v3 08/11] s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
Date: Mon, 21 Sep 2026 10:40:02 +0200
Message-ID: <20260921084005.4022574-9-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: POnO64eVDEZ0F2Z9j4LBDF-npJcED5IB
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab0ed6d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sJK1A0fQ-n6IDXIElG0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX3JxhYmxeMC0Z
 AqE7zPXEA/6NSS3wFp0ir+CHSqqZAYwNIa3plzkbBCQBGpGUf4JtgIAoyBB2KSlp2Ird7K/L6KP
 tk1TQSgmPVZaxnhWr4eY8ns55qTN7to=
X-Proofpoint-GUID: POnO64eVDEZ0F2Z9j4LBDF-npJcED5IB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfXyUp4e4/ShmJb
 kB2Zi1WRtvbug0C9s/DaNNmGJmuNzmH9gYBvJu2HBcoHVltWbNqAUwn7C7L5exb1JPezimE2iJH
 e8Rt7YFfCLhPApVSVUGzFok8SDfFhThxHe/5AHH+z2d4Vwnn5tsO+3DJwDf0o5Dzs080MiHD0ug
 eLplSdOZYGUQ1lG2AN3RGX8x6dQcPie5GoLRFVu9jc+AVMWerg3ZY5F0pKVQwdaCEIh2HxM0iVJ
 /KzF+Vws5yDC5GsBHvnq1ZqSdbJpqCXtL6+K/G334s7rHcAX99DwJU+oAuTg4Cj03R7S9X/rW40
 yhQJH17mRoaXgphsFJvtbTELwQ/kasJIXoSzAOC0LkxsT/RNJJ+kHVpTisJZzpX0wSzC3CMhU7f
 E0meCoILX7bkb9Q/8HHT9uwrDcS0nIzQk5BwUSSMFa7uMvghu4/PvLtgSG8CXbXthHg1+jnSTGv
 y5Z3pHDJ9yqFoRnkFXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

Convert this_cpu_cmpxchg128() to make use of percpu code section
functionality. This is just for the sake of completeness, since
currently there is no in-kernel user of this_cpu_cmpxchg128().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 78c3aaa138f7..0eae65937c0d 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -312,15 +312,23 @@ do {									\
 #define this_cpu_cmpxchg128(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-	u128 old__, new__, ret__;					\
+	u128 old__ = (oval), new__ = (nval);				\
 	pcp_op_T__ *ptr__;						\
-	old__ = oval;							\
-	new__ = nval;							\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp));					\
-	ret__ = cmpxchg128((void *)ptr__, old__, new__);		\
-	preempt_enable_notrace();					\
-	ret__;								\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		"	cdsg	%[old__],%[new__],0(%[ptr__])\n"	\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "+&d" (old__), [ptr__] "+&a" (ptr__),		\
+		  "+m" (*ptr__),					\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [new__] "d" (new__),					\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "memory", "cc");					\
+	old__;								\
 })
 
 #define arch_this_cpu_xchg(pcp, nval)					\
-- 
2.53.0

