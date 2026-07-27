Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF630F531;
	Mon, 27 Jul 2026 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146071; cv=none; b=kaDkzA3hZd7Fb1qj5WJsKU3jD8yaoAs8ueLf21ei/+wedcUMdz89hDqdMVOiNmzFvi4XpP/xOEZyxGzEORpy+Os+cacww1vR8v5lvQbNfcg7FlptEGg59ypU2pr9AlYMlrsTXhMtQA0KUQ5Cb3ZQ7aAGySIv3ETFl33pR+MU2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146071; c=relaxed/simple;
	bh=TcfohSlnxGxGElzsaQQwPO2hOPdHEBvo6tJ1jCjU0s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kemabvxQrcqg9K3jPOm70nqnHGqHy2doqqMpnRfh5fKBYFmXHlsLLEfxM1NV/UAB1P5nUaBlMbYg/XJVzhvgXtfPL9edK91pnD5CDxkqu0cJpR88C/bgfViwwP/Ab7AhrCjA/HrpzTYBNUsEojTBAFziLs+WZSK7C26fbjGB8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r1TDWuDY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r1TDWuDY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Udnu1821189;
	Mon, 27 Jul 2026 09:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zGsuZLSWQ7kYKXeF1
	UjNkhMThZU/W7y9eynfabFde40=; b=r1TDWuDYh3+hilKjSjYS8JIlX7ZWBtXVz
	QndY0cqHAIxJkDBMniB/e+va/kSG9sChk/q6zksGlFMfhEESguM7cg9SIMdm/4gj
	j0dg+PnDgcITnpj+jMT3F/zB0jsFz5vHlAv1gsFXGktJ80bFzMVeqBviXjr/u8i/
	f6AjFzUvBz5aatJePDt0gPjp04ZysGISnwm63mTR/+PPweIGy9VwpI3bY7pSqjMG
	O+A34Lrunko9trZsRfiyY9CirIzCNyWZjdXK0qtZjGDRFT/emwD19m0JDInJfTM3
	IcOVWf9eV1M76pgHX26y4xP34NlGtEbkPJubGuOjha6/F7u+6V+IA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77brk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9fEiP032297;
	Mon, 27 Jul 2026 09:54:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq50cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9sHVD15925888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:54:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A36C5805C;
	Mon, 27 Jul 2026 09:54:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A3B458051;
	Mon, 27 Jul 2026 09:54:14 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:54:14 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [GIT PULL 4/5] KVM: s390: Improve kvm_s390_vm_stop_migration()
Date: Mon, 27 Jul 2026 11:53:58 +0200
Message-ID: <20260727095359.107671-5-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727095359.107671-1-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RO42ZJQe2-fiIqYVyioEpvtKSkUVsllj
X-Proofpoint-ORIG-GUID: RO42ZJQe2-fiIqYVyioEpvtKSkUVsllj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXwKEPo8v0ro+/
 b4QBwFnETwUMjiU4kyxDxdgJJCKz+6h2LltugJVJWWoEC1mJFuz5VLqMnteehPeq7//Sz5EPFno
 OORKW6xdtiJIzR7v2Mo8xTgaJFujAI/Q5ZGwuK1FImcvP38AVpJ3Cl0tH+2/08t5arXI2TbGduU
 G61JMoAWHAFNNMG+3E1cl6OgJapTjC3UeQwBXdZ9QEwQpAF5a+197QlJix+YB06cDKq4TV2SATf
 7YaR6Ls9KLqlNmaPASF0Bu3O9rgThJbzBKPDM+rS/pBYtp93R+aD1VsKCJ5yICD+f5jKtPfGcUy
 ut59zs5Ur3gDwh4sD2ukZQxzdqfB6rP3TW04EdhTN8gxoDI+Mv+fUH4HiuJsoDgARtUIKBdXZoG
 0WIFVEjLSJqIhAv9hKTwbAfyelRixafW/gpCdvvtFxvC04nc4SZuRoqosYCXaf0GbHVHHoOq7uN
 oZnuTJUcpeBjDz9h2uQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a672acc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=rYcZ_IOZh9ftmSSm4-EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX6iHyZzxAkaar
 lQzgNIJ70FDZNVWeZnvkyaSApTa5dfvoAjGjHomTfBIdaK6tTlP2kEn03T8uxC2If1ERU+DMq71
 G68ZHVJ1SBpSeHxxa8FoUzGwZhiV5iA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270096

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

There is no need to clear cmma-dirty state if the VM is not using CMMA.

Skip the CMMA-related code if CMMA is not in use.

Fixes: 6cfd47f91f6a ("KVM: s390: Fix cmma dirty tracking")
Fixes: 190df4a212a7 ("KVM: s390: CMMA tracking, ESSA emulation, migration mode")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 23c817595e28d..150b5dd2170e2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1280,8 +1280,10 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 	 * PGSTEs might have cmma_d set.
 	 */
 	WRITE_ONCE(kvm->arch.migration_mode, 0);
-	if (kvm->arch.use_cmma)
-		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
+	if (!kvm->arch.use_cmma)
+		return 0;
+
+	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
 	/* Clear cmma_d on all existing PGSTEs and set cmma_dirty_pages to 0. */
 	gmap_set_cmma_all_clean(kvm->arch.gmap);
 	atomic64_set(&kvm->arch.cmma_dirty_pages, 0);
-- 
2.55.0

