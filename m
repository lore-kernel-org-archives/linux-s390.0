Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017815335BB;
	Wed, 30 Sep 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790022; cv=none; b=V2+e271bUxFyyv7xhyFnJA8XU+tlHRdm0YQ1D6eiU7kSbUEMexbYGOIAlN65VcAd1Vfy/mCUVPFissYRzNGd4ZCI56SY98MnOn6x5avHtXYqPyrGrpYcsxdfRJuGUHqbxj+cOzQfLoYVRLDpduhNIYVvFrMvJ0l7tBjJNbAaXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790022; c=relaxed/simple;
	bh=CboH7O3PWcoQvB+LFC9L0mCPzp44okOrxvWOvAc+bEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IT9VmijxruRKs4+v1bXuFo4JPkPDc7BeefSD001D66WXzudK3ktYcSBpt31Vf2TdhdBwXSoyavjI+A+wVWXF1U7Hwg81yhOMc46WFYifqgBCKAwShWm9jRY9XfumNYkW+vQ/7i/+Y2PnpqyiiU8Y19ANUMcqP1cHhQ6wF8AdT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dX8MeEt5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dX8MeEt5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5aNs1335962;
	Wed, 30 Sep 2026 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dpj1xdiSYmBVD2mZo
	G/uajyoZR60+eYA8soe6s9W9ZE=; b=dX8MeEt5tFMEd/dIfspLcRxIrn+fOXy1w
	Tac3u2s3H4QeNzlw73iJBwGTCEptmaTPyipTpaeDrRV2LyQ3XVOuQVxj4XR5PzVr
	TeFjSYklX5RMVHRiMmx+poUCKAWs9W7Nr4SvPnGIdDxkLqO/9Be/X1YQX1WHyqEI
	dGmXhifcPL/l5831PtZgb3tZbVSpsSu/D5Rx1krm6/3dgYp2erOFT5BfWP2mCT+o
	xnKnyKFnuPARjVR3cnkQh3c0krBosg2b/Xu9vNM3vumXmhf9jnLpee0rmwAoTWYs
	Yv612u4unoGtoxDvh907QvoxtfPhzx2jHQ8JjweWkl3EY9fDrpXSQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrehbn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE35O03583597;
	Wed, 30 Sep 2026 17:34:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e59rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYkXH35389744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B223E20049;
	Wed, 30 Sep 2026 17:34:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 646B32004E;
	Wed, 30 Sep 2026 17:34:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:46 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v9 13/24] KVM: s390: Use dedicated function for migration mode
Date: Wed, 30 Sep 2026 19:34:28 +0200
Message-ID: <20260930173441.66762-14-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX0mImgFHyodry
 IDe3DUMPYfLKyfY+VeOa//UHYXGX4r/X1dlW3/Z6upUb471cOmeiEvoCKUGl5YP9cB52hzLfm05
 6pNxiG9Fj7SZySfR1QTEovcswrH/6o4P69QZcYMGDHxIgTyN/XEhcmYu572EbKYMY+AY7VQgBxD
 Zcm0HQLpepvyCdfpKQkGKk5/iuCkoChcYuU78MNaBYjlBtB4JIeUItbKfB//R9xfaxPI6GlVC6F
 Zr1G9nnwzaBRzayPUNqTCGnAmq8j1Y49peRrpu3rHVTcm5LThC7SqOe/t2OqxMQbqDkQNzxQ1u9
 UzNcx5lpbzMbCS3Es/avpdnwEBF3BkUVUlHqpboefwf4aa+i2iyREll6bezbo69OXIEiHoVbam6
 P7r0PFOBEH/mkRPsXW9tln9yQxqS+ab1iyaYDYMn/GwLXO0fxyPFTykYcI2WiE7rimlMOWnj2SR
 1qrwg3H2MXcpJF7SiDw==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abd483b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=BPKNEzTBeHxawKP70jYA:9
X-Proofpoint-ORIG-GUID: yop6eIuiVu9cJ0vzWuHapJqy8J5Aeqgu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX/sh2PPm24v6l
 1Wz7yjPXqifXOQJbB0HibJFDnMZm+KQUTJsM9Ozkt1Bw9fgiIdOW0vvOmwaAcYaCKIcrI+w7QZc
 B9AKOKX2oJ6TSu7CNLFba++I6jtAi/w=
X-Proofpoint-GUID: VcmRYXghQ6GAo9k1zQLMvtOBiORLwEvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300068

Use kvm_s390_is_migration_mode() instead of kvm.arch->migration_mode.
The function is independent of the actual kvm_arch implementation which
is different for the second parallel KVM module..

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/kvm_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index c2ffb5e59ec6..24e618f77be1 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -76,7 +76,7 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 	}
 
-	if (kvm->arch.migration_mode) {
+	if (kvm_s390_is_migration_mode(kvm)) {
 		/*
 		 * Turn off migration mode when:
 		 * - userspace creates a new memslot with dirty logging off,
-- 
2.53.0

