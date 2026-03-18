Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8735C1B7;
	Wed, 18 Mar 2026 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821182; cv=none; b=cqkH6je4B+qRgPIXJrmWJGCJM04nnV/6corE+I45L7Les6Y+YvOMuwHhDS7aKa18ebbBSTctuIcU3jgJ+mVfcwLMO/Rya3b+0I00PO07ZNQMVl1SpThSXs5IfeKSAN/TGlFTT5AiqEvFp/BpQYHe+Ig+Cr0zwp+JG0+z7wIdfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821182; c=relaxed/simple;
	bh=GfKSh/H35VPyhHXDKYT+xONf8KxW+VGuOpwlhVIlQJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EseNIpWDNTO28zOmUdneIwQBq4d6TIWm+NiO8Ib0djW76+AMjYKhS53GyescgivpkBo7tGVL/KN6lA0QziBzCANtYVS8sIiDXCCfANbJOrCnnHXUpW3HFoEA4TJtNdxuKvRScI0fJ+1Zbr9b0cWgaVh+D5vWTUvO6ktiXZVIhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BRR22ED0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BRR22ED0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HJAkPX967663;
	Wed, 18 Mar 2026 08:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/N/wUX6qQf8u92BAG
	ZvPpM7jC/6f4SkVuemvQDRaVpc=; b=BRR22ED0nzXtxKVxLIHozIMPctgihcy7J
	0LkAKGRl2wI1Z3Yg7lpuoB0p3C+fd5Xf/pZqnjhY3w7LGNifiSeAIV03VEMLbGDA
	t3wrUtU9+SCORFZbi9Ccl7deaah8GYxyGp37W8Rcegtg+uU8BXgNgOVEzL/QtdlN
	tFL9/X0Ho7aKw/AnbExkQpPV83Dh7FJZVVyRQvCexvJJ87+zc8CpcJTJ9htlZ9yI
	QYC0re7hhrsT4q7+Jo1tzjOBGdY5Ok9bTh4FBj+VWPd9rGuBcrEhJcHTIorBLnGU
	y5+NMAlZvoIgOpHtjBF8PuFywFjcx8P1oqsJzgtl2ccvKcrBDTGCg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d08ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I630Ch032448;
	Wed, 18 Mar 2026 08:06:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jvvfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I86EoO27919008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:06:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92A7558064;
	Wed, 18 Mar 2026 08:06:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CD3458063;
	Wed, 18 Mar 2026 08:06:12 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ibm.com.com (unknown [9.111.93.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:06:12 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [GIT PULL 2/6] s390/mm: Add missing secure storage access fixups for donated memory
Date: Wed, 18 Mar 2026 09:06:02 +0100
Message-ID: <20260318080606.2450514-3-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318080606.2450514-1-borntraeger@de.ibm.com>
References: <20260318080606.2450514-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba5cf9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LBl2HirfCwePz792YYsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX4f9EZZf7qONj
 U2UlV4JVZEoZSKjst3DZtDbJ28uQkWka6uXRw8JUWfgwJzgmnv4lTVHgSdD9lYjlL7JgjyX1Yn3
 Co8dS4bVo5twmdX7DC7tYGFb/UUfjcunnpHUgrkbwiCcR/nX/0f2x+l5upI00kBX7Tj8tiPRfVY
 2N2PJm1vtWD4M1fIxIjM86QUhaKzMoPmHgK4shLne7PjR+Hp3nvppm0dlbDCB7THH2UICRHVjXt
 BJwaAS15ezp4bNmUcRjbjZlNBh3KVvWvH9Fb6fpSYDITYnah/iFqb9inVW3TMhHZZ/vCjpxPqL3
 BqaKUcrO8o7rXnCvmGOseK5Y1iGrX/fkPdxBXi1BLabZaeUJU4OmtCxIdHgH6jQsH9PTjVLT4OD
 nvBBfch6DLHklxtbZlCO+vQsHKtZqNd/0rnqinfjfbKpaDx5QhnxWeOYh+QZLhTlP+uB8W4w0vK
 vELUoJegyPiZyaK6uRQ==
X-Proofpoint-GUID: aUDSTRGtXdUhnfh5wLPnoCA0Ko0bJ6S3
X-Proofpoint-ORIG-GUID: aUDSTRGtXdUhnfh5wLPnoCA0Ko0bJ6S3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180064

From: Janosch Frank <frankja@linux.ibm.com>

There are special cases where secure storage access exceptions happen
in a kernel context for pages that don't have the PG_arch_1 bit
set. That bit is set for non-exported guest secure storage (memory)
but is absent on storage donated to the Ultravisor since the kernel
isn't allowed to export donated pages.

Prior to this patch we would try to export the page by calling
arch_make_folio_accessible() which would instantly return since the
arch bit is absent signifying that the page was already exported and
no further action is necessary. This leads to secure storage access
exception loops which can never be resolved.

With this patch we unconditionally try to export and if that fails we
fixup.

Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/mm/fault.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index a52aa7a99b6bf..191cc53caead3 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -441,10 +441,17 @@ void do_secure_storage_access(struct pt_regs *regs)
 		folio = phys_to_folio(addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
-		rc = arch_make_folio_accessible(folio);
+		rc = uv_convert_from_secure(folio_to_phys(folio));
+		if (!rc)
+			clear_bit(PG_arch_1, &folio->flags.f);
 		folio_put(folio);
+		/*
+		 * There are some valid fixup types for kernel
+		 * accesses to donated secure memory. zeropad is one
+		 * of them.
+		 */
 		if (rc)
-			BUG();
+			return handle_fault_error_nolock(regs, 0);
 	} else {
 		if (faulthandler_disabled())
 			return handle_fault_error_nolock(regs, 0);
-- 
2.53.0

