Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7756366074;
	Wed, 24 Jun 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299981; cv=none; b=ZwY1y+XDpcyEQSlQMHv8KfdPlq5YfhSK21bTbj4ZRTr9wDCNytkCIaTni7XTzAyWpSuZ0hrCECNXFCPGoji0Qrc7lep56bK42o9+T+EciHBT4h+63t61jSbpKlrnCcmBkKaJJQy2JFX0jmQOsUFfNMUn6yhXRL3rH36kUrY7TA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299981; c=relaxed/simple;
	bh=5TdQ9T4SYACo/WyyvMyuJ+NgiGSLt9/IU3z2rWzJoLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmfUtpCfN5WHs2A4sIWHfSBPpMzAgADQBKPx6jdxMHn+nmYJVKAXVTd+tmFOd9YteX5SUS+iCtdPdSuM9o6c0Q0ZBsT3rvGxreSr9hJu8M1ublSgw2okNZITarhthMCBI0AnF4aiUyfPvW3G7aNoPoGses+/hIPU2zYLirfu6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pOIMVlh7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pOIMVlh7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmf4O644659;
	Wed, 24 Jun 2026 11:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hJyTmdkeIiTDjEAdA
	eVnhtH3KgegJCdo+1nUMHPtk6s=; b=pOIMVlh7G3eDv5lpejR2maVGv2K1bYa5N
	ivYqrWJ5LvKV7mlyhIvNkaMUdixCXjJNb8BrWIl6rS1xUKkh0CV9zp36GyucQEHG
	GDvEIm1D0qYLnOfJN2nGf4yisQSPmyNmsL0d1EO7E34vs17jyjLWYHNBsFbyjlnC
	flS1L4akjm875yKcssUE3adj0RKW7rckRtAWGyBpvXIU/plecgzZiHYYB6K+WRDN
	8hsjm+UAGBSc/5sKIo2us7N0fiPkJpvpulDQXFOeOjrcqP6l2jswxUQjZmcnpx3A
	5EI5dRNRh2mknwhsUUoeQ2rGdazk9Jm+7bF0aDhpIgtwn1bKjCGdg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4kscs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4iVV013456;
	Wed, 24 Jun 2026 11:19:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phg67w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJV4Y26149324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1759D20040;
	Wed, 24 Jun 2026 11:19:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D7D2004D;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 09/12] KVM: s390: Fix locking in kvm_s390_set_mem_control()
Date: Wed, 24 Jun 2026 13:19:25 +0200
Message-ID: <20260624111928.144283-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX0CoL1ABdjfF6
 cm7DJ5rtp2rKUD05jNSzOLisFuUuLB/sF7iLo7A2xI9SdVp9yMKIRePPvx2cnflsP8jC9Ed3tju
 1QahEjWesP64P7fElKy/w4ZCKZhbXX0=
X-Proofpoint-ORIG-GUID: 7e-8rERbmSAkNQD3aAL3-3oMnDgISOi_
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3bbd4a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=st8l7k6PkLdDMgjZYwIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX+aHqTig1Gf0z
 sdnD+EED7HrSJGy8tAHVuHvKPf09crrzi/AyKqPCJseFXfXyDM+vHOwWDJOqpWC/PV4e8wY0QZ6
 EJCBpBl20AYjedisA1xOI4Pr5aKRKh09z7ZJKYOir0MPN3L2nSirDWKuRHhirs7s3jnabc/kmse
 aY64947aUr2xYsUWUCztI4wiSt/znZHKY5bqAqBRXzSXO+au/jVVqyjAW9UVOXqoMonFXrtbNIO
 NyWs0Y3+xcquOcGaZ8Ct67F1vFM3RBqA0lygVhGQPXoG90knwH8fYeTsvjXZfV/ZLwfYYniUhY3
 WLyy/2QdUrLajcJxQgXTGVra2/Fc4MqOym0THgAyIb8sBhThzthQNm6HFQy/5P9Nft8LG3mBoXd
 UqeSnli3MeRVdxhs2Po7j7hOaZdspqZuAtA9lSsQ8Vqj7N095iLUV2dKce2MhsBovos3Jxfrmxx
 +7cXeYyAOybjcXfmlGw==
X-Proofpoint-GUID: 7e-8rERbmSAkNQD3aAL3-3oMnDgISOi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240094

Add the missing locking around dat_reset_cmma().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-7-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8a3d55410f06..221b2fb199d4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -990,9 +990,11 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!kvm->arch.use_cmma)
 			break;
 
+		guard(mutex)(&kvm->lock);
 		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
 		do {
-			start_gfn = dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);
+			scoped_guard(read_lock, &kvm->mmu_lock)
+				start_gfn = dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);
 			cond_resched();
 		} while (start_gfn);
 		ret = 0;
-- 
2.54.0

