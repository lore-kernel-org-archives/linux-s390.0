Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47893C276E;
	Mon, 12 Oct 2026 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805377; cv=none; b=aYVj+kBsZRBVAinqtwRu7xda5jagpK8MHqbQZhpTANm7FlEg1qCRvCfL7Oy50biHkSM3mQCU1qNH1zmE0rLA9uAV0/Tn2EguxQTtThMTb0slv43H9SmE10csa8V89ZJiA2XPlM6WTe+BNBlUueF2VSZUsInUedXnOW8wcwrGNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805377; c=relaxed/simple;
	bh=jjfPRB1LTvQvGYhcOr2YX9xU0ZH9fE3CjQ9s28aFMc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6ECjamCNsojCB9fzYCYE3J7gDgnN6doBsGp+fhrR91QN/1d8h/8bMmyhQ9QfhTjU36GmKRPahiQWYIxz7RpH/E2Bwm6xNHoeeiePYdLR9HA2Juvu+Hb9gdZORgQv1pALBT+9H/1z91Xu7l0nx1rXga8A/SkN24mOcyHblNqQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gQVYaLIL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gQVYaLIL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iAAP2183677;
	Mon, 12 Oct 2026 11:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zzIx4dG8Sesc4TmBZ
	9ajtIumKg1ISk7MCHF1bJIPEaw=; b=gQVYaLILjN5iApjuuocXg8O+cRjAhPXbu
	r4A1sQFUYhvfMIveep9DsKKUblLuvMR0dDIQSElORDU1EZ+R6SHmaiGodQyAXnj2
	y7AjdwcKramC6cytSYJowjIDacJueG75srDbovoePA6A0uNIVm33vHz5Jy3N55c0
	bIO4sZMZLSXFuivXMDfEj/mpxMcCOoWVNIVsexcqrYazfGBNk0xPrVMztODk5uji
	RNG49y0kVAUU9FJ938vqA8Iyd/WUFzqxISw7+ubnovhhPOXNn5m6tee+RK6mqCQf
	PBWf446hnab7V0ubZ/11bDImXmpVfkom/nAxs2J1rx1GAqxKjadVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh8n6f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K2e03934747;
	Mon, 12 Oct 2026 11:42:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfvsgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CBgnqf44368250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 11:42:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B643A20049;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1462004D;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/4] s390/percpu: Use asm_inline for arch_this_cpu_add()
Date: Mon, 12 Oct 2026 13:42:46 +0200
Message-ID: <20261012114249.2898572-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012114249.2898572-1-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXz1CQQqexjZNN
 g7Kdl6Gv/cAceJAG/2FOu8T/P1oSBpdL2BjEVt/l8I8IpkcWOQspc1+Q8p1bpVlkUaxFJuEy1qN
 +FUqOw12oZ8V3R1N3ydXM//90Ng9EkQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX9IfaeeZiXKaa
 Gqj1nDMrAQVnxPn0XInOAmOQHsXJe7+gQzkFR3twqfhzQu3pu1Erw8xdqoHQQhPROJznI1YYV4v
 2w7i4/yPKJdvtgPL3v3AaBR4nKYsSXL0Qks9IFapsPCQY+18xu9ToY1oIkOHnMJG9ly394oyzP8
 Ero5BClhO5ut0ER6EwebR8wYXBpDq7fm6bfnxsKcaLXLSbuWyXsPFV068E38RhH+GwIH7z96OjP
 jbUPhpfBL7dMOBWkjpGQGDMFiPu5sC/fGY3RYQXF/a5r8qIF8sj4AFvx2uFbSsmnJxQUmi/0kWL
 jtp+lHms9h0wGehEbh8I8/M2QlJWVre3RZ5PJmSvHIf9+4rdhi+y+QWIxHKuo+4EG7AmRpc2/VV
 fo3/AVb/sd8DSQWc5fgJP9piXqZ/dBGQ3FhyJYLhmswsze4DHRDL6hDpXA06ARxZhF/BHziw6KZ
 7E/vniLcapDQjOqdgNg==
X-Proofpoint-GUID: rqK2QZQ4iUQNnlShZqoWiXA6s2zDVZjO
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6accc7be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=0tra2-jyaZPPyAxV69oA:9
X-Proofpoint-ORIG-GUID: rqK2QZQ4iUQNnlShZqoWiXA6s2zDVZjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120044

When converting to preemptible percpu operations the arch_this_cpu_add()
inline assemblies were not converted to use asm_inline instead of a plain
asm statement.

With all the macro usage the inline assemblies grow significantly, and
the compiler may decide to not inline even small functions. This can be
observed with gcc16 and a defconfig build where many calls to
__srcu_read_lock_fast() are not inlined anymore, even though it is
basically only a this_cpu_inc().

Use asm_inline to address this.

Fixes: 18ec6c5d7ec6 ("s390/percpu: Use new percpu code section for arch_this_cpu_add()")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index c3995bd8d1de..dfab41b43b8b 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -193,7 +193,7 @@ do {										\
 	ptr__ = PERCPU_PTR(&(pcp));						\
 	if (__builtin_constant_p(val__) &&					\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
-		asm volatile(							\
+		asm_inline volatile(						\
 			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
 				      "%[pair__]","%N[pair__]")			\
 			op2 "   0(%N[pair__]),%[val__]\n"			\
@@ -206,7 +206,7 @@ do {										\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	} else {								\
-		asm volatile(							\
+		asm_inline volatile(						\
 			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
 				     "%[pair__]","%N[pair__]")			\
 			op1 "   %[old__],%[val__],0(%N[pair__])\n"		\
-- 
2.53.0

