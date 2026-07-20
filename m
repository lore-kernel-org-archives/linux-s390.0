Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA03D6478;
	Mon, 20 Jul 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537930; cv=none; b=H5wdHCMbOULt89X8knR0g0ioOvzjeOr+2P3mGxPxywe8VjhD8TcKMyzuJVwI1YlMMbC3uHz9UjVSwY8xOdA3/ViIeQHMQ9+V+aPz2++nj2GWjPdFWqEeSzQySCyJzHFmiH9y6MN+dhdkAcnmRExyboYBTk3IcRLcRiTaJzA5d30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537930; c=relaxed/simple;
	bh=MWTPZS5lx0atrLjiEqr3hlHJCq2JP9RkV1czBmu0Vgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBrXHRMGAqg5pjjdcw51HeCQC4Uy/3YhbmvlvV0QiHpkKO1OcteWXm8GRgykH95FLHRumxvX5a5DXe/MvwKbL+0cNtPR1DvKhpbEBNKBEWmT4TOutnYXCK9hECF7Tvel7HPDrdABcSx0CTPPtVFYziC3psKyZVIF5n0pG8xrEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WaxeHtlh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WaxeHtlh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6hM3u1468890;
	Mon, 20 Jul 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Rx96jILEkXTyn7zof
	u7vcAVAXb1hJZc/0eVKU1nhskE=; b=WaxeHtlhlBoLAV6y5aQDcwDB0kxUxp3PF
	p0+0z4VCVtd54/5UTLQqXZe6m/1r6ZnbPQGVW8zKXwqmWuE59AdO5NN52gtPCFls
	SHfdzfGcp0IFRiZnx9GNz+d6oXfdErIAY39GoH/rhUTufnI6q3JdVsYE+Y1O9glM
	Uqgp83xfMiLF0dR2+yapx30Mx+M7hwXYJjkfgMO81nosWOYg8fB2aLuWJ0ydeKvl
	bRbrg3oB5scu8wc/o86NBJQG2/DKai4Pbce2v3vyY2+foLAaSa2Ns3Q7rQ4YJGXL
	RUqKJsottyrASpSIoN3ZBkKQhdazhUhxsSXNr/BvCMJFEYvzoHTwQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7agxc4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8ncUI012958;
	Mon, 20 Jul 2026 08:58:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy4hsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wZjF48103696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC002004E;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CCB520040;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] s390/mm: Fix handling of vmalloc area in do_secure_storage_access()
Date: Mon, 20 Jul 2026 10:58:30 +0200
Message-ID: <20260720085834.898025-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720085834.898025-1-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ii27NQZkLbIc3OV6nmq6aVacUYtbZdbs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX0ObMi2BZ33oT
 7KUJsxGnRwR5w6kclFyiLKiqSeTYaq3f9OkBiYIp3qXxB/nCFWiWhFrDyCvK0gpujezw6BTfEXb
 eN8fHYPMNoVoq2a8zwPVyzqBU0Nr0OBSzBVjm3BBtS8NBq88GriLrlTqOUWj+peVC83yl+ST18X
 UPEotqAh4bf075wvkVeXckxleKWuzvLom5HWzeEAlvQ2U4OabqMU3hVAeJGfMFv+Y1ajKsvPGn+
 COuI983tNfY0v5pviXReRmGfkuuYj+bFk9sMlHhnRTrSP/AzgrBbWO0MOu1sRy4MtrUQ9EW9M/v
 G1SHBKJjtIQvgM0yzAx8f2Ots5e4dA+69VOwVDJ/I9RrwE2EYcPy+c8YX7EmCa+GDRfSg4Ssb50
 EcdpxaHK6sTDkmi4wotBMu2G6FojSByCklxdVa2Ui0sZpN6ua3wjQwDLVIY1J+0nouhk6hlBzCX
 Ejkty0LLUSUfkcLvhaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX4zDbmKDKoBT/
 +H2CDvzun3y/tzcOo93tzQ8iMjt97pZ0rS5yzV5VWruCE6m4BOoYH2CNu127/wzjEsXxJoRXkW+
 oj51cZJ9IAybc7w+bUdePyvKAOsTJTg=
X-Proofpoint-GUID: Ii27NQZkLbIc3OV6nmq6aVacUYtbZdbs
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5de340 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=aTeQ_7Lur19LOBhsqlcA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096

Secure storage access exceptions in vmalloc area need to be handled
separately since folio_try_get() or virt_to_phys() do not work on such
addresses. Given that there cannot be a valid access let such exceptions
fail immediately. The kernel will either fixup or crash.

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index f150d97cac2e..e650cdfa2523 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		panic("Unexpected PGM 0x3d with TEID bit 61=0");
 	}
 	if (is_kernel_fault(regs)) {
+		if (is_vmalloc_addr((void *)addr))
+			return handle_fault_error_nolock(regs, 0);
 		folio = virt_to_folio((void *)addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
-- 
2.53.0

