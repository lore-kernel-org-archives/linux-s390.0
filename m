Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB13306768;
	Mon, 20 Jul 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537923; cv=none; b=n70AB3nY7MtbjV6piNDqUAEnblHmBUxFoe+kRfY+WS2o/6JsIt0pb54kDMDml3SiSn0KyzAV8OYDrrIkIfoXBTJWpj2sYEmhx1jjLrNx6QIJu/WQuW07bbJxP5/Sgk4oS2oLYrC+fF8v57VUxrZbyarOqOCZEepuXYvV/Nrcwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537923; c=relaxed/simple;
	bh=kt/IaOFVul557FqevKqMSkljaUYBNNzywr8px+IDhvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn5DWcC+IP7DFyXNqisvQgW8gXAN0nIgkDCKTCsbmdWTSLvDgz58jZ+iYqz6Fe65KjMUOCFYypPGch4zRSj5UTecA6TIioVwUdLpdFOn7VyM0WqtFsra1U9nMTORFzyXhsGGsgbT6x3dVrRzs2BLtal2Vjj1gyrGdSeSZ/Dr70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WmT/oAcE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WmT/oAcE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fnlI3777390;
	Mon, 20 Jul 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t4ZnftpYbbLC2ucKQ
	zkh5yaupKRJNl/rZPqRGt4bVm0=; b=WmT/oAcEpJ80VfW4piAZ5uJYHeKWQOkkv
	RBPOhmeTkFSJnDvmRkb+1OTXQhb1TtCk58ST58gBLOBJjUw/EBTGAOw8K8f4JCcI
	ob68+ji3foN3Qy/nFLWlXw4MuF2Fb1WlE0bXJX3ldfhoSIpj62FlIqPy4CD1KYZo
	Ooy1aTvj60fa2sIdup0tP3cAk6ynlRKPnm/sDku1Jm2170VC0VM/4FY2ICQAcwm/
	/eyYpOz92xyYa74doEglfIC3DspEgoVTVUBadw2WAEDm+ypT3DaAkMDxOy2OTqSz
	iCPzUJbSS7k3F5PiA0JFmd9e3Ucr8WbisdfTidIqXtVIAIWG3uOKA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a6m83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8Ygnn030004;
	Mon, 20 Jul 2026 08:58:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpw0h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wZpr42664428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD83720040;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7CF2005A;
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
Subject: [PATCH v4 5/8] s390/mm: Remove folio handling for kernel faults in do_secure_storage_access()
Date: Mon, 20 Jul 2026 10:58:31 +0200
Message-ID: <20260720085834.898025-6-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: IoJiaYt6Ppk79OyiKpVJiNY1eP2jEqPN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX1AbA0DpWOZWV
 okNoKHSSPIa/jNG6wkd9HWfGC+C+lDxeV097DB6SWtpb5dKYVKO/lJpN2z2SlnpN/rlHFRKvh8W
 +J6M69PkTyDnS+8SVuT4ronHpeQaUmA=
X-Proofpoint-GUID: IoJiaYt6Ppk79OyiKpVJiNY1eP2jEqPN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX3PjVCAYStjig
 0fMou9BDPWrPoG66WlHscZXVDW4dmNZEIYPzQF1F641F0MKs1M7nOJjn9ND/Coxue7Oab/3+LUe
 Sc9DeIX2g4PVUGDAc0VdnOzJXAUir15XEPZ1EjfLEIw1ls+1OUpA7DN6XNcwsrBCNcRZkyVjxqh
 llSW397gdrHtPKe/JZmQ1U2dO8bxGmB0H5b9X8VgA0J3slSvLLnDvyiRuvWW1IGRM84WsgZLQLE
 UDd+kylKXwf0jMr8Gh96pgpgibZXP4jD2QYfuWk9O4As9L1zovw1D28vhuRQMZ6bsD7RQkX+zvP
 ZWMixLZ4v7/lT0UGTpFnAn27U1hAwLXAfcl40ZRPRenw6hcq7b84pMSZtUGnNgfiI0SERF3Ks8a
 c+wFGYkYfvVGqIWhVjoOwqyIE/tOLgdb7k6eZhRfsMaojFOigPbdGiLwvMVd8u2gAXqQVbb7wpv
 E3OH62+bkVTn4o3gCIg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5de340 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=3bIF1FMAx5P9TMvWi0MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200096

Remove folio handling for secure storage access exceptions that happen
via the kernel mapping. Using folio_try_get() for exceptions via the
kernel mapping is racy: for example such an exception may happen on one
CPU, while a different CPU frees the corresponding page. Subsequently the
page can be part of a folio of different size, before the faulting CPU
executes folio_try_get(). This may lead to data corruption.

As of now this scenario does not seem to be possible, however with the
upcoming load_unaligned_zeropad() this is possible.

As a side effect PG_arch_1 is not cleared anymore for such faults via the
kernel mapping. However given that this bit is over-indicating it
shouldn't matter.

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index e650cdfa2523..776549d55c94 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -440,13 +440,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 	if (is_kernel_fault(regs)) {
 		if (is_vmalloc_addr((void *)addr))
 			return handle_fault_error_nolock(regs, 0);
-		folio = virt_to_folio((void *)addr);
-		if (unlikely(!folio_try_get(folio)))
-			return;
-		rc = uv_convert_from_secure(folio_to_phys(folio));
-		if (!rc)
-			clear_bit(PG_arch_1, &folio->flags.f);
-		folio_put(folio);
+		rc = uv_convert_from_secure(__pa(addr));
 		/*
 		 * There are some valid fixup types for kernel
 		 * accesses to donated secure memory. zeropad is one
-- 
2.53.0

