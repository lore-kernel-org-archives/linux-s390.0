Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE53596F8;
	Fri, 12 Jun 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275823; cv=none; b=BC9d2rP42TU1XBNZUiL8WaREkzfUPVMheyMoUZEwty1EQf5xST6tTyD/N0092Y/FSScn9jLB7cneTCltwh4pIBfrgsplV1k47u64R9ux0QXCJfxCDjrKuLE1BH8JqmQ5T61KtIYzxG4/zPskG6FtMMpn5QRtd2tEv9JkcyZiaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275823; c=relaxed/simple;
	bh=4GNULYf7soNlcGRLtPUwODeu5MO6effIyaAJAufYvZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0gOUBztS3D7/9m9PuikTqD6ZSq/7X7z62/VWP7FWdbEVlWfoUe2ulAt9UwbtM1VUOxvrMWwLaDV5Tzk8xxCRwE6GIuw70lVwKArQuFD1OaBgTNctJTgWqLporjP5Crf9VmsJyR8h5Yd8o/ejj6gqQZUdOzHwdrZmzojyrurIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EjtZj422; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EjtZj422"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BNeN3C1742452;
	Fri, 12 Jun 2026 14:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OMRe7iXTc2UBI4hEL2hLgPP0iCU9HsNxLvO9Vxb4D
	8o=; b=EjtZj4227bqvdH8M1nnEFLNSilolcx7Jc7JwOAATBnkWwW4lrsreXLqHm
	nTSLoa4pbJsU+lMGyviXqGTyO/MhcAgj668LpWjnFopVlfEIxYivic0oW0DlprQV
	nHdSoGwn20Toty3wsKtovOgDI0ozJ97ueH4qxdiRlCDgrOrxQNSct1jWzm3X9X6z
	8I5PYyigASfFi2v1sUQPfPjPtDgf0UPCHAaSu4Sqe4S79snSFkfhq5ckmBPz8X9R
	8Lsw3SqXpsqWFxE6lblVpZJnOIjjoNUd46NjIjONrK+vpTHtNQ7/2753B7Fe7HdO
	hGIKu0No/o/m3uu7z7JSU9xaOfOIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bs42h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 14:50:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CEnh0c027214;
	Fri, 12 Jun 2026 14:50:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a8a1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 14:50:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CEoEkR10748230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 14:50:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7159F20049;
	Fri, 12 Jun 2026 14:50:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36DD220040;
	Fri, 12 Jun 2026 14:50:14 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 14:50:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v1 1/1] s390/pgtable: Unconditionally clear _PAGE_UNUSED
Date: Fri, 12 Jun 2026 16:50:14 +0200
Message-ID: <20260612145014.217102-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2c1cab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=mOJq8Y0DGHbhJsF8cz8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEzNCBTYWx0ZWRfXyAaEpsgXyTmh
 rDBHEZ5wwn2lppdBNAhxsdcoLgk+gAMpyUFmFFKU0SC8eEqXq1ONuWIj5UKhaSoGmrM3CieRZRE
 QvFz2jU4uFG3/Iv9ZIivV19JoZ3yUn7gl4yGrErnIWAGkhGtRTVQ1w9tHKYv/nwWWTHth+w7egq
 6F9laM+E5V7tXXDUC2h36SvVrylb2sHSK0lZo65p73RDd0MDb3oqcij/ls62asmj12rfZnmasL6
 zng3L2MLwskuKWEmL8PaJXtGADgkWP8n0LxDvOMTLVLjQzTq2XLeEoUrOu1t42J8FJIL6HJNZXC
 lx/4ygF9R4shF01nT34DcpKCM91J9Rumjg6GdIjcGXMTR2UJt8ma/0xDMVWgEMs8sk8Bi8X/Htc
 lo48ITi2iigtrXYiomQtz+2gZ6sNkXBVkbF7V/pmxIIP0ZFME2i71Ndv4UdJAIVuqvNDWqd/h3W
 b+mRNZpj5R2uG4luj1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEzNCBTYWx0ZWRfX3J0SZN8/Qtda
 oZDsItUf1D+G+kfLmWO0wSNbwqGE2R+qWpmD3EEWEjUqfeefRZfoeBsCGTYeKtrdjANRxMiJKnh
 t1MwfA4nIz91YMgakCJk23LW8m/xQ4w=
X-Proofpoint-ORIG-GUID: USSBqugVIMzo3YqHtHIvtRg9HLh9wnbE
X-Proofpoint-GUID: USSBqugVIMzo3YqHtHIvtRg9HLh9wnbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120134

When setting ptes with set_ptes(), unconditionally clear the
_PAGE_UNUSED flag.

The flag has only sense when the pte is being unmapped to be swapped,
it will be set by KVM when unmapping unused pages.  Setting it in any
other way does not make sense and can lead to guest corruption.

Fixes: c98175b7917f ("KVM: s390: Add gmap_helper_set_unused()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2c6cee8241e0..9174aa02b699 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1332,8 +1332,7 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t entry, unsigned int nr)
 {
-	if (pte_present(entry))
-		entry = clear_pte_bit(entry, __pgprot(_PAGE_UNUSED));
+	entry = clear_pte_bit(entry, __pgprot(_PAGE_UNUSED));
 	page_table_check_ptes_set(mm, addr, ptep, entry, nr);
 	for (;;) {
 		set_pte(ptep, entry);
-- 
2.54.0

