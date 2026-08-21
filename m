Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE140926C;
	Fri, 21 Aug 2026 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342021; cv=none; b=eL5UmItAB0fI/RL2SB9v8n9T73CVanjDaDVb3RrRn5nGj6MUGtvWwix9BQ+ppN5n23nDGTSq5ZXGZapgzOwntosj1pcsIhFuF3eUt1fy5dYxqs2CgjGDCQhiA/bPxvJiIqbdLi01G6wBMu/mEeNHY75FEWySU0kft3yb9Z0JixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342021; c=relaxed/simple;
	bh=CXyGtsG81Jje362NCcX1DJbpQJ04vztCnyVvNnO2UEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNcLlmMahWwcdHLQIHlMdp+ImC+yCHVt/QJVh7X8/RNNp/zEqRWkeIdiODtadOUp2v/hxKQ2/Az2IybXJdvSdojsCReQcyM9uKE+LkNlKruv+rtdM6+OTgLrVEeW8pVFSbt2t6nKEi15sTWHcdp1f2f0RY1c3FyV8P2T4W8wgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TIoNWO2p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TIoNWO2p"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVYr22363665;
	Fri, 21 Aug 2026 19:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nr3NDJBPuN6JMZiT2
	70FS3PTS8cjMVDUb7jnJwSlxDk=; b=TIoNWO2pXEQQcx41cG6G1cZc6AsIDSIGn
	Wb6VvrB85FB8kZ7ovAwdGGphjCJid3rnhHlEMn+Bp+fuTnGJrejFhF3yRm52cKs6
	iICVYtlLYoxdjgFpfaqbXio70MXg605Ob2kmx2RGVvkoMg6zaoaXxa5RWvVoDHRA
	aBNy6a9FV+bX43A1EbVxh8uxl88u3UQef8cwBrEcFCakVw38nVNHx/M+T3gD1ux3
	nVlbUNg/xLQ5YYYgYh4qGvd9jJDYcFPtk3i4fqcOW/3/iB2CzI9ctwtNG7BoxRoM
	tNo4KG7NDYekoZIgt3rGOS6iihYsx0xyA8TE/UTkbyrI6jtDMa3zw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0uxke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfGQ8006048;
	Fri, 21 Aug 2026 19:53:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngxff6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr5pE41746866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60A1220040;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D6652004E;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
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
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v2 01/24] unwind_user: Add generic and arch-specific headers to MAINTAINERS
Date: Fri, 21 Aug 2026 21:52:36 +0200
Message-ID: <20260821195259.2688377-2-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88aca6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=meVymXHHAAAA:8 a=bzoO1hpTG78L7GYmDxgA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: SDI9-EQ6q2zXx7KhuSOxwYIW8s8LHpr7
X-Proofpoint-GUID: 98p9ebAjyeYBcw4dCaW3l22uQLA9C8rx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX+KHyiTHHWc6k
 r+4czlToVkZUn3bf6sW7iYZsjct9bCLlG873nuru3BwZ7k6bNmOKbUaR7bue+bOGwRf1rQo2LwQ
 TSWWOfngO6F0Lj2kHBe6/Gj2Jf+PxmQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX7f8sPk2P6Kmm
 BMmgb58gY2DWezemeHzZ+82U0mQB9iY9/0Rk2t80YXZraB6ezuryEV9Phe/uJBaolOWp1sqfQd3
 MY7gM/Vawl6ulEcjl+nGyJCcNuQGDMEyRwnf8FRqXnT9Jm5UKFPaZsn2UcC7OaYpiWnKko4TgEW
 CGObfbw9FJg5K+MZZeK/G+OeQQrlMpRHyJp0+Oj5ElbxfO7cq0h3ArtWJHGq1Td9dpfBUuAcuGx
 BfZOEMbDduIjjTsbT9dr66MtxPacdnrImE8PL6O+lvJpAqBwRXxqL8eJXOAiZeZ3KMldmkg8oPm
 jfGV9x61TQHMkDxs8K+ARuvSrfBNHswYQUMmTaVBlbV4WEm/bJsz6LsIksXjbFwUDXAf0J/nSt7
 qMWusBx1fgOfgnJGX7NX+O9y08Ru1AGdygjLVqTLh5KKNkEUIjoYcYNbdzHmPr0mL2STgn08mLD
 cJB2rfV6QWBkotTWgfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

Commit 71753c6ed2bf ("unwind_user: Add user space unwinding API with
frame pointer support") introduced include/asm-generic/unwind_user.h
without adding it to MAINTAINERS, as well as any future arch-specific
versions such as the one added by commit 49cf34c0815f
("unwind_user/x86: Enable frame pointer unwinding on x86") which
introduced arch/x86/include/asm/unwind_user.h.

Suggested-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v16 00/20] unwind_deferred: Implement sframe
    handling" series:
    https://lore.kernel.org/all/20260521142546.3908498-2-jremus@linux.ibm.com/

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..e5738a250d63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28201,6 +28201,8 @@ USERSPACE STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	arch/*/include/asm/unwind_user.h
+F:	include/asm-generic/unwind_user.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
-- 
2.53.0

