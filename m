Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D363A6EF0;
	Mon, 13 Jul 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931434; cv=none; b=p4PhFtLpqKnAtzlUfad1/0I18UaIb8cFenG5TLVMKv3jAV+3oL4D/h9RrerbRoIJAhYtu9ZQDooV8siZJlULJAIKvM9mFY3yDSmYyjg/xfwiRviIWb+TplDS3pX5TQA271Jjwk3mrSQNrT54riUQJWi68Agofppy8HTlzaEfaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931434; c=relaxed/simple;
	bh=TcfohSlnxGxGElzsaQQwPO2hOPdHEBvo6tJ1jCjU0s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxN2123HxIbw/LsEcj+X2JNbYzZwPm0PBmkZI+NR9m7Hl9mBdX26U9+GwpTOIVcBiYXZqABW1tYLjouAv0mZXehIqgYxqKzGbCruuuXDELSDfPHZkNEOfRDgaWh9qsvdrOv6DpWnILUUmKnkeQvBE4zFDqFc3x8uyAE74QwJ4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z0IiE9QJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z0IiE9QJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fg401740265;
	Mon, 13 Jul 2026 08:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zGsuZLSWQ7kYKXeF1
	UjNkhMThZU/W7y9eynfabFde40=; b=Z0IiE9QJ6BHJLmVzAqnOC4ZCdcWqVwFbo
	2l0722Q+WhkBCWiny9bqlnPsPzOgKrC+c0Y1rEOjVoofrbxFjsjkXykJf47+OrME
	m2HlECqIxo1Ir/XUjijfRt+uV5r+pGtbk7v5sS8jONhOuLkFTTmw9+sB7GZe/hQy
	t/4mxg9p/BGJ+DbWnbL+Fii18wEItTQgDgH1EvdCwKpHSQvRnD6ee+5fSpqdutcx
	S69iJYYR6eUnlIr76kA4oWFoXULPYRSKVPs+ueCpvKllGISt9xp76Dy/5Xp2xG4F
	LxVXj9f54HQkNJcwgc3f0Cv6ueTQy5aQKPSgrKaa7FvQGEWGlXnbA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegsynaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D8JZC2030713;
	Mon, 13 Jul 2026 08:30:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh4q0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D8UQ2G21299862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 08:30:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A06158059;
	Mon, 13 Jul 2026 08:30:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA99558067;
	Mon, 13 Jul 2026 08:30:22 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 08:30:22 +0000 (GMT)
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
        Sven Schnelle <svens@linux.ibm.com>
Subject: [GIT PULL 4/5] KVM: s390: Improve kvm_s390_vm_stop_migration()
Date: Mon, 13 Jul 2026 10:30:06 +0200
Message-ID: <20260713083007.65863-5-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713083007.65863-1-borntraeger@de.ibm.com>
References: <20260713083007.65863-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W1RFAoLVfDvhA0P7fiEALqPIjZGLBD7R
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX8ITK9t8gvL6o
 JU3Ofw2lNkPgvOqpJ0Zdu36m3/SIlIk237IZMekKpTxWWIBzdoQKPf2aFj86bJvtZZgkI/ZYnwp
 bohUFZS8ExwEXdI9HIf3qBbH5CAl1Wc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX+loXfo/t/LTx
 +Np1nK8BhO3g3GAvV42q7l5pZHzjSKEXRkz43KtXggxS9VM6xT3M2fK+UNJ90U3dJWkpk3oEQR2
 wDJuoi63dxv+y/X7Tp3hbgCAyEnzka1aVfenED6Dmrq/nhPLJMli+lygB9xkkuxuz46DetEQd2R
 ZWDShVec07masYr0EUyx5ZHe8m1t6+rR47LlMUGgSViV/4F/VpvV8HXUlfXZU1H2nGkK+soqnt2
 6BZwWm9UJRFHZnLXs0nX8m4OiyLPsZfqpHW3TLzeA3Axm3UoXcNK9Wd6rKGEMxkWUTtPj3S4wsi
 QPprkB2g5mUDUJxRVfs6BinSeOPgtBr5OGisEvJQVM6h3eyhlwi/zDBnaWVeEBi9l6q0JBXDCvZ
 c4JmE/w2WiT2QtNRs4IzZ1vfQTTfB82NhSXr1UvKKJGSu2FE0NZ3jhU0Dyvglbsi5mO2cmgep1u
 H5O7PwRYWqwOAmOEy8Q==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a54a224 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rYcZ_IOZh9ftmSSm4-EA:9
X-Proofpoint-GUID: W1RFAoLVfDvhA0P7fiEALqPIjZGLBD7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130084

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

