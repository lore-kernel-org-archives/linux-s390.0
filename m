Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680938B7D9;
	Tue, 18 Aug 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064635; cv=none; b=YLiG7e/KlwofXaUefzJL1RlJtXtevP+rajH87E6inLKWXxeBXUg6AwPyCQ9dCEKqp9WR6/RvOiYeYyZgkbuqE4DNBA/9LvMItQhl3TeIldTeNXyDKIFC832omCeqAWYsAcrGyG5Pp0NemYpUVeo/skWyexOeEAE0uTVL+2fwVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064635; c=relaxed/simple;
	bh=QWiO/oVjltZVMmCOotSP7wKcIueRwp06oxRRGGodGAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRyXqXj+i+4urjIHeyO5rA9YX3aZSLrlIIoHedSMbnyiTu0ZW/WwD1yO1Apby2X1cxDGQxpel9fe/9AmTO3Eylf95qGCeE+0XjYck0HbvnOQfIWkol5apkTD9UjpAy0fVqz5UtYCFBbvhftk7xJNDXzbceYHwPXVq6yA408BGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ykx/QzoM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ykx/QzoM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3oCJ401813;
	Tue, 18 Aug 2026 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y+euVRI6M/Fa6YfSr
	8B9MiMOGuuw4vVLdiMUtQIZdas=; b=Ykx/QzoMkTXoNNmvcg3oUw2mpBYPf8enx
	0UPFuRpI9lPZgHgXT84ndz+l0DBuTI7CCqHH5bxIWcO2tDVXxU8w590NHaqUsqEO
	hp4FF9oHzyZY1Rmoszo8F/MCrN5YNg7OfW3Atds5ykqfrEYbXbWVF6fewqIbGUjW
	93ErUoc3Ls4zCAyyvd+HWkBZG7rQ3dFr30NMqEevgTR45LQ+Lp59khMhi1xVl4Yt
	WCytzi108MookoehKFU0BjAmeLGPXbiHbz1B5nPVMZx+uJqL7VfCeo7SFYAY3nn7
	9XV4P+WqBJxVE9ASqyCIwatY7fXufr2pMPy48wnjn8ND9DVqIEPKA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm0qng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfKdp005462;
	Tue, 18 Aug 2026 14:50:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq3w4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo4RT47317476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBF7C20043;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B0CC2004E;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
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
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 23/25] s390/ptrace: Provide frame_pointer()
Date: Tue, 18 Aug 2026 16:49:52 +0200
Message-ID: <20260818144954.2320378-24-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX+UXG7ZvKiwxT
 YH4ZZnBFA/zfTx7Y0FoYRFxuOBghkJkKAgvL9PxAD7e/nM59WaFaAcBEcunR95NKzFdFeqnvJiz
 QYiO2opTMZTB267fDe2btwD7j4yZDeBto4MXaSe5RPHdSV9BFsaBY4Z/Bjif89ZuluBdoUybs8S
 whF3y96eLZVlcbQUTcVHCaZJ14O1aX00B17Y8ExrTQw0ywoOKTTnqS84eC+LyUD5sY17pRzZ1Lr
 oZmTvj83uId8pxjWBvLNTicamsFf7dQaaOYOB91Aj62Llnr8JTDnNyUZ+kz9OlP6tE3QVC5vSiP
 qC3atWpT3RcfPRL2vIgM/3EO9dSQE3OFj8ICd5RVUnYQ9J+YKrbSF25ecm8Npw6SNiopa7sGcl5
 uWy8QldFSIGCV7fq+3ziJRvzzZR+Ef85kKQ7Z3in8ZSfX1gnI7HGWogEzNR48ATwx6a8tvZrMgZ
 wkrTtRmJqhrSNDWoLLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXztlaixwly7Xw
 8ICfhstMuf/XBRkTOenWnhp50g5T4xHyltik5j5OZIM4nP3IK1RylGEK7w1eWj4Ocf5Y25Q+gwA
 7zY4mOY4EglWxgUzbVTUGnv06PtiJ7c=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a847121 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_uadzYZ_BUT95G4SQMEA:9
X-Proofpoint-ORIG-GUID: J0cydBPEqobJU7znXVoBFXy7bmr0rvK9
X-Proofpoint-GUID: GNqhp0ySPe9BgUf1URAWsMhu9AkWXpKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180107

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

