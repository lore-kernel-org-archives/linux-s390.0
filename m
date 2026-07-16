Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E23F482E;
	Thu, 16 Jul 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211286; cv=none; b=aPRp4wM0MofcBTeWD5h2ajfXnh4GlPCP2u3VipkoeVoG3cBWJ45cvQgHqQk/VXiXWlOL0rH9ctAqnAiodMMTn4PEy1Y4c+mbd/7ykQH83z1X/GXyAQJiDqBcuowepoUKaWdurTHRS3FguyK4J9Pef1fFK4DWtpctMl/pLoQsRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211286; c=relaxed/simple;
	bh=nCBnP0pOnJQlo6E6BFjw7Gts6aQqIaZ/ZGXDg8wrSMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjuS7KEXgqzBMT1WEwBNYgM//NEVXsFaOJWc17UufsWRVS/WBfMH9o6qjves+qoU8G/pUdSD5ZWDLZyEu0XyWif2DaICHR5Nn7mps4LeV1uyc/ZIDdcVlP46AwdbpX1HhZvKqk7B1PMUpYhCD6NEi/ufNgUujrixYO41mnZxmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fVY+rK5t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fVY+rK5t"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfjc63284473;
	Thu, 16 Jul 2026 14:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nxFeAPIZEhenzqh1F
	UCHdB2mNGb6NeQE4O3cleETzqU=; b=fVY+rK5tSVXbOG4UAN07GJ9NYqCWWOxq3
	1FGC/d5R6F55adK+uzjs55UadrhcFx+hKEAfk4HelozcWxavw0OD1DGudpnmOEzD
	9NaPBN2vbhhR/JyPVJ7/k1qC3ksvUK7H7/Q8EyQWyAufuvT+wKIg1CVcOaczdw2V
	aMr+SIXVrIdHA7FqVVIsTRyQ/z3lHaJKyGCPcQDbJk+x16dVz9h6L8EuqepD/HiS
	T8L12Gy0rkveMxpGkvYHw+B6GZuLHYP7+j/VKpN3WxBn70RgDz9bde3XyGqFsGEd
	m7atWT74IBBp4XnjVLBjKtPi+LJrGDMoeo1YjZY5c07tpiZ4i6B8g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2agh5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GE4Z1X017889;
	Thu, 16 Jul 2026 14:14:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qdhv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GEEbg249414634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 14:14:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE77620040;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8601620043;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] s390/mm: Remove folio handling for secure storage access exceptions
Date: Thu, 16 Jul 2026 16:14:35 +0200
Message-ID: <20260716141436.2125703-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716141436.2125703-1-hca@linux.ibm.com>
References: <20260716141436.2125703-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX7a2vdxXwEFSa
 givBYgCmevmlG3wewSgOKeViGrjnLaQqYi3vfyQDzdjxHxP62SKCrUT5b0O3DCkBHpf+lQCzpUj
 CxJKZihPMssqzDrxpXxe/1fJ32bptZA=
X-Proofpoint-GUID: QfvXIZfe5VWC5jOP-41HNMArRV-baNjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX3dQXIoLJyVMe
 ow3gGbvfPID2AaZl6qXtpV9L3yEnAerzsx/6NlLTkEAK+dhZZX7rCwz4oKURiAsrNSDbbDCcNN7
 jPE7JtHRivkM12UlLbfUzckglrKSn7tnTZ6NO6O/tVd4uzB1Ky9biFrqPZ9qWbqsonYeBNmezO9
 Atux9luhX1ozNaAFXdcnOxE5uY7pJBDLDxxR96qBw3r7ab/vS6EZlX76E69dcnfxwGSqTObkdrw
 U+7vXb33w7/ciNRJQLwOdvOV9OJuQ3j6YdAPx1dGNRPLaH25vvAB3GFNCZDwCywMeRkj9z9yBn/
 AGpUymEO9M+nvU8ua+ujoXVFnTeuPObBNpeIgprJNKd21bniTSL4Czc+dQn6S5AE/IncM2dQRAA
 XZlTqPwBEwA2PtfMs0m+zVWhxmF29o6yhRUXAMxPN3eQwd5tpX+8IivA/tA/yfof5c2jH1FTNOp
 rBBEJDALi4juHpQB44Q==
X-Proofpoint-ORIG-GUID: QfvXIZfe5VWC5jOP-41HNMArRV-baNjy
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a58e752 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3bIF1FMAx5P9TMvWi0MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160146

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

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 392e46742039..db77c8c0023e 100644
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

