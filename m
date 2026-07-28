Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B439FCD8;
	Tue, 28 Jul 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258449; cv=none; b=XGzbvRE3ws2Z+/9L0WRws+fTYEL7YOyTSseJBODod7iPtFanlqoLCtUJ62HaUQ9kI4dRRb+aCPR4kudHKzf9kZ3AcqNKVYOGlX1ijLPEZy/nZ50SUNOF2g3OFOr5umZPtKZezZLY05bhpIq+dKEmqrei3UA3n9yjZDS5Wtw2FZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258449; c=relaxed/simple;
	bh=SavW2FQmcz+ZulUlDcCqYlUUPWtcavP+ZTaUFEhdc50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjff0AbwRupBlmiR8k2OTB9NOFwkLxPzwgyLJAA+8YoRusvrjMt5ikaVFbSJW1VfRTqVD9Rtjpo/6rZ8TmmtbFUvgDwnnKOq0hBklZvDKf1QikxnsPu/61+ezZkj5BKYBY11MTEFrLObKAW3mfJf5P/bjg6ruHsfNmL/zCngOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XKasl35F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XKasl35F"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElnfR1380297;
	Tue, 28 Jul 2026 17:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NlXGO6GQXSKXFToKj
	Ye2Ycmw2/xZl8cG5rCgXKxqedY=; b=XKasl35F2vNtqdDnRLCENqM9SgdH/Egcc
	jEgRMvIckxLMsqFYkLImKgpdd5lxywsAD7MWIkPtoHniD5F7tOpJJK1VCnBAW2bL
	9pIFIvfhsksBFsvpEyFwsTUDWYBIM2JoHDd/iU+Am+z0q8oczZwyjEBJyUfF80Se
	zA2dLRZlLgKRYPpfndRoyhr7AW7D5C0H6SGJWYaLG6MOLJQF7HRFQpphuexQdYZz
	5mEbqDktltwym5bUim/B93+ujohjza3qixgOtX1Sub9qTmCrV0hqvR0aiLjpV7lc
	9VEgwkqu/JxgY+vwOiy9r0LfPB1YkCv+2JCbaqpuoyAVU9gLiG2eg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj5wbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuKfr030028;
	Tue, 28 Jul 2026 17:07:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhav90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7Iw229819442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2056720049;
	Tue, 28 Jul 2026 17:07:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD9F20040;
	Tue, 28 Jul 2026 17:07:17 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:17 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 09/13] KVM: s390: Fix ordering when adding to SCA
Date: Tue, 28 Jul 2026 19:07:04 +0200
Message-ID: <20260728170708.294400-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX2QlDWUa7jEDg
 2TdukdfB6QW6h6Xl1Nkua1xAxrM/Hi7WY9d23PmadZbqs1wR2NryBsP9/xAI5CxIqz4YPEFjbXp
 uOnuPPC9317uRv7GSLxFpDgwfC8zUyk=
X-Proofpoint-GUID: n01vEH_gxl0lNM2LUakM0Fn6IFFC2d6q
X-Proofpoint-ORIG-GUID: n01vEH_gxl0lNM2LUakM0Fn6IFFC2d6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX8B/CRz4SqcOc
 ovFqbnHhwSSw+UqF4060WA01Mefpb6iuJU6lWl96eHzFKwLoS/nmI5CrcAOFXuLFYi2KJjwYEd5
 8IAwB83cMdf5aI+PJRovVZ5cysvmwtnxaohr4IPO7meB0D7dvNAbwILDe6xgGYYUV1n8w3qU73/
 kZ7CuxiMPhcNo1EFFQaBmrOJQGW+USEq32lsPJR4OKfaLZnA3SWV9a6UnD0ttnvuhgEqHOcJyKA
 WP2c5tU0E9gCXnz3gu9Vac4v/FLDeLnVM0BuEo9UrFIP+6A4tszMgKvwLnSXKfFKxM/smP97Foj
 f5uJbDis+SVrOP4BnExtNIpETlcNyu/uE6+Up7NvylRLfE8Vp51kQz37QKWhXCNhDGyAp3kGyuw
 TsLWmk3RqSBh8mngynsGq+J/wxnDRvpQn9now5XcNLr5qHbvYuWXoRUCdAymIka5Fyj9StG3KIY
 WU93gOjLujBaupX/9wQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a68e1cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DpaZzcUc-R7GdRs0254A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280149

When adding a new vCPU to the SCA area, the validity bit in the MCN was
set before the pointer to the state description, potentially allowing
for a race.

Fix by setting the pointer before setting the bit.

Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 776dfa0ef970..59f784f8c01b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3481,8 +3481,8 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_s390_use_sca_entries())
 		return;
 
+	WRITE_ONCE(sca->cpu[vcpu->vcpu_id].sda, virt_to_phys(vcpu->arch.sie_block));
 	set_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-	sca->cpu[vcpu->vcpu_id].sda = virt_to_phys(vcpu->arch.sie_block);
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
-- 
2.55.0

