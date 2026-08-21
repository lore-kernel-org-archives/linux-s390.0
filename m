Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17440F736;
	Fri, 21 Aug 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342083; cv=none; b=hgg5njbIiDuD4VtEgGytlJR4Btvrv//Y4+rzRb52eAOFrZmCPYbq6V/9RNOBO31/O6WDMUOC3V82xDJkQijU/rgkepkSytHegBzS5EFTr1wkSDmrERHCcro4glbhI/TCejC6GULe4yDojx6Azr/R+ljWntVxqcAyJlGd6EMmkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342083; c=relaxed/simple;
	bh=QWiO/oVjltZVMmCOotSP7wKcIueRwp06oxRRGGodGAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/Kk7Qb8HDie0FhMqrLziO1wmfRUP5YjhDVKE0lpPs7U9QSMKbGOPHIHMXLzjGMUxAXzseV4hnFJawAM40dy7kZtCodc8rVlH4kJOI+PNGazqxjNB9n8Yay+MpqeMBLUD4shrXQUZmhn7WcoPRqS+ezzBYNIt7uzIhLXkUgTmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TOhtz60v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TOhtz60v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVYdr491713;
	Fri, 21 Aug 2026 19:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y+euVRI6M/Fa6YfSr
	8B9MiMOGuuw4vVLdiMUtQIZdas=; b=TOhtz60vQ41nFEGwl5CIRg0ZJ+l35cTqm
	3xvsdIJCcRMND7kmKAekXMHUrUcgx8hYHkcWv1YVDGIH6QtEJCeOQkbcWG1/4mi+
	iQpQe9LvBqcFEJET0fH7/HPlP/0z/u52c19ESPS3CrY8Av/GE1r0NYywq7VOXCxZ
	QALuLeyGOMf2Z1JmrS4op1WqME9HH82Um9vfnkswgMfupfJsVvdydw2zjUh/8inM
	c5CbhlYMrCWVTG2wY3QSXHR2jZM5DldUni8gXpxArmSNPuKPDDtVA3/tT/3cv7Xv
	dryoae9Tmb4AXIyG3pZoNtYgJomIkk17JY8KoSCZ8NqhRWFU447sg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0kvdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfJOM021077;
	Fri, 21 Aug 2026 19:53:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekpnyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJrBP550331922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7262120040;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BB0020043;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 22/24] s390/ptrace: Provide frame_pointer()
Date: Fri, 21 Aug 2026 21:52:57 +0200
Message-ID: <20260821195259.2688377-23-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3nzV6AOfPHHCbrxy4rmssFcpqvGzTx28
X-Proofpoint-GUID: sJV3iXG8PI9gma7BYgItxWlsQCi4IpV3
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88acaf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_uadzYZ_BUT95G4SQMEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX4VPgQYp+Bj7v
 ZqENTHps6NKG3o8wU3nVz8F/tgfhaQI8wvjBOckho17DsCdrV51WX8O0BUBb+IqjtpWesb3bPCn
 5C/pz4OAHkz+3T443Kx1uLt2XBM0Qkg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX2oYEHYbnYwdE
 q/nppDQnWaC7gII1SOCPuHlbehvP3+uFpi+TYrMquEIhxYcHMLVHE9e1pZyfqIsdeZZ1p40tJHN
 jGOjo5ryALhXNg7qvB0i9oEsqj/SHr2ysQoxll+fmJJkbFUFYDDr8/HlnS26iUv1MQSj2p3lJbI
 A1h3aFZdCPdNZ7/1h6wzDw20pHiFeD4HnV6Se7k4cu+HU7x/Nd1yXQiNaN3n7xHFC6ZHlM8B+US
 nrfqc1+3nmxQ8xMLFQtWVJh7b7o16NOb+Ttoob3DnhQYPvCd47vUj5KyZu6+swyOVVTu1XSzMoL
 A8yKHgxJcweARhBBKXQA3Ymt2sqD33NuDBDdqkQ0qM3zwDSrz3XyCf25eP2DRXLDm2+RX0IKRMa
 shHSJZSbEVzUfF+GoO5w6wYlmemLDM5UQ/PVSlNfCAVvezlIecin04YmGPsp0dfvrc8HiFsfnaq
 HL6z3Iv/ju/s2sN4n3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On s390 64-bit the s390x ELF ABI [1] designates register 11 as the
"preferred" frame pointer (FP) register in user space.

[1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v4 00/12] s390: SFrame user space unwinding"
    series and adjusted to .eh_frame:
    https://lore.kernel.org/all/20260127151926.2805123-9-jremus@linux.ibm.com/

 arch/s390/include/asm/ptrace.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 495e310c3d6d..85765979a595 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -255,6 +255,12 @@ static __always_inline unsigned long user_stack_pointer(const struct pt_regs *re
 	return regs->gprs[15];
 }
 
+static __always_inline unsigned long frame_pointer(const struct pt_regs *regs)
+{
+	/* Return ABI-designated "preferred" frame-pointer register value. */
+	return regs->gprs[11];
+}
+
 static __always_inline unsigned long regs_get_register(const struct pt_regs *regs,
 						       unsigned int offset)
 {
-- 
2.53.0

