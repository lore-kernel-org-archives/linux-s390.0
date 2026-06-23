Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C92D7DF1;
	Tue, 23 Jun 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228821; cv=none; b=C7xQtVa5ygTXIdNPSp28URb6W98imZ8q+HpvaKEXvAT5GLI4G9WkFeJ1L6l92qQIS+cse+LKOWHiezyWWK+Ikgw6wkclY+RN8lmxqwVK+ovnL/259/6zFsGbhV3XIRe0lCoIUI5MklqLcGoD6Jc15HQvD+xgkdB/837neCgmRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228821; c=relaxed/simple;
	bh=BS4AkfomZ/3RkmHppjrwqx0vx7N057HSQFUY68c9ctk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0c7Lv9uQq7R+h1Ipv9ZaehoISlGI8ofojMuAbcDLAls4gtY4V9mtbfQIeGsAN3cbRYc7PCb6HXX6Znl54EjbUOM+VwoBWInP5+Q+yZOGPw0NGDak8TtN3VQWjlFuhG7aWTtMXYFkNXx5LFxS+4j0k1MkWKJ98o86fhKa7A7MOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=alB0laen; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="alB0laen"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmlUZ1858081;
	Tue, 23 Jun 2026 15:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=InX3Cbu3nWF6y6LI1
	uc3rHAaBVskkEAT/oMe6tKkb+o=; b=alB0laenUZF0zAk9Zi8rj8f4QASJbGJjY
	0oQzVzpRkzE6rHtXETgImFcLIIXPKPG5xX0wpcBrianJlNgRr9lmo6/K/U8rlpwF
	VAXiRjOVWn+2H/mrnLIjhNfQOppHguwwORmSkUdZmhmnjRpLPpZaLeRXCi30prf+
	BSd9kzz4DdAWfdYzY2jriU2F3sKkkgXYCa2a2szFK2EAW5UWagGv3T5vwKMZCmpT
	egUazob7F7JmSNAy4P1Dcmvf9VoB9u0tZ2l/OMkBGnO4DfotyYoS7obcFzs4uI72
	RZc3PS+54slLOFBKWUUA5sWGo6r2zh6/6KoIvhBYV/YslW3ura0jg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hqmpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NF4dUR012773;
	Tue, 23 Jun 2026 15:33:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwc4d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXXWI37290466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED34220040;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5A762004B;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 06/10] KVM: s390: Fix locking in kvm_s390_set_mem_control()
Date: Tue, 23 Jun 2026 17:33:27 +0200
Message-ID: <20260623153331.233784-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LEb-ZvxrLOsi0ev9pOLUhuv4tIfRpkXP
X-Proofpoint-GUID: LEb-ZvxrLOsi0ev9pOLUhuv4tIfRpkXP
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3aa751 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=PtZEWvFzR6fUmEpCCNYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX8sVjrOkvZOTM
 O3Bs66m3UHS9vD9Mb5ggV8IozZbsujjsHO6wZEzgbgpGKlTcsmCwO364jHPpuq8hUVg/HoI9O6q
 FeBDvnQOxMpQlXGHxDp+wNEi0f2ZdfY0uU3ttC01OqdkSem9ISTav8KfOmn0+asg06eFpYUxuRR
 wvn2kFKdNyvwU9sPmGqXYXK7SHkWcu6rsWLhF9tKvPPPMU09cFLLTlnRcOdD+a+5H/bYEF2LCl2
 BfbY8jTLVL20sQR+hXvkRUZPl6/NlgKcAFQmKSlMqnXWXxtYpLE3d4jqm5/fbYRbsxLJxRlatN4
 H23tSBaPveJH5ZtTlLrYs6S06Mvb4jQMoK1g08mBQRjs+QsSClrGyCPM0HTFGYMo4y6RpZFtxNJ
 N1kPJrNCvmYov4clCkVGIPUBlxQ52pkn0ZxE1JPgH6lJn+qD91Nec9RKjXzMoPgP+l93Ovjoq9o
 kdLCjbf4px1ubyOU2iQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX6uKPrkhxBSvf
 k80aKxw2DVoAymISFMadoVoowiiVZHwyBn+Pmgqpo3W6RdV90VhfIrW2YcMAAUPpTnAG/gxuRIR
 JeMLdaW9Z2fiwJjo8eJ5zzYhgGWBXb8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126

Add the missing locking around dat_reset_cmma().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ffb20a64d328..fe0ae15e5ad0 100644
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

