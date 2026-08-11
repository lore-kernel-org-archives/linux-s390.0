Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9223BE62A;
	Tue, 11 Aug 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463815; cv=none; b=SFVVt69Wevx+0sUaoZKuT3wtzkYMjlB7cnkD1c2kksvPRywuMUTVjpwEQGYmbgzHlIdvMMvnqnKWi2v/A63tQvCJFsTElMXuLu+HvTN4XRnvo1O064JuyuAiK9MXYJYHrRYiCQhhsHhoorxBmuVzhOIcwIR4PSObbKdCKIOpHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463815; c=relaxed/simple;
	bh=fwxLwTIGUHdZrrfxqv+nFUBC16NLoM98V6NjTs87gf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg74aAppOAIfFEvaeMWj8ZMcSU9QUats9aKjoxBllVLX3lAYjBe+Mdqi9GXUiYrUIjl+Ac7LbBU5i1A9wJozKUz7VTAZnkKbN+Xwzf4o+riDIe1Hr1bMdFLJElCvCIhtOWAqKI3KAJc6ttnM6Byw56BcjzcTSQA2EdU5vHh5Wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anVWOATn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anVWOATn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXJRX570120;
	Tue, 11 Aug 2026 15:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L5D/1TQfcEiN1EqcL
	6njigH2LUHnlfcrdSPFwsjFGLg=; b=anVWOATnOERahOEkAHKjQDl8f4dpyrD/L
	0yweOjBnKRNv5fvEjmCQYMrhFHRkSaUHm6N/lpB2LPx0ivQaZ4X9vcogeBlW2AIb
	+NxJRO1cN36wB3Q+arBOOHgbxSg8eR4AtH7zY/MamZWBzUJW9hpyGfvhy4vrRTlh
	Nqfb0J+MGj1At5Ocqk1WRZX4osrdsPgs671GPI4KbcwyllMPsyHyJ+kGQ31nel3w
	Xq8m2N7NC7wVaVGO1FWVLiaorQWwymvuY8R9xEieO6Z2zYJWD0Kf0G1Go2nsWpe7
	+vmHyNMha+SJcfj6Qn+ihvek8NmXuX3mjeEUogk5nX6gKOKVrVwTA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw54mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuKJ9018953;
	Tue, 11 Aug 2026 15:56:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1j0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuhAc37290340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5460E2004D;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4AC20043;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 05/11] KVM: s390: Fix pgste_get_trylock_multiple()
Date: Tue, 11 Aug 2026 17:56:35 +0200
Message-ID: <20260811155641.219777-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=sS5RpU0ZaWfbfMIWq_AA:9
X-Proofpoint-GUID: 5QoEAhTPAiYdO1IlYh3GdDgcfDliLk2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX2cln+tp0bXdt
 VYvEY0uO5WBSzJ1H2YmJdy4y/1+K0doRBZOkkcMBdg9KaD26o1D8QIOqL/ZQuULhI/DhKW9aAV8
 apiYJVvgdToIViiQHJSvH+kPE5Hfn0+QluTQz45awXFe8OsOZeXPvUKup6kvJ5zKNTYknUmHnfy
 WWLYx7d62JGInTPbQDL0ZutEuuimeissdLQXS5z4aME3xXLSFs3CIdoLv9UUQZhg6d3Q1q6RQa7
 FT0w2y9ceUb+Ev17n5DyT5urpPI9pJssXfOgj/pyoSmvDQWdyznJIhEeqIIYGF5sNygmXBPfuIn
 uubXZj2nKNkxdAWDHBz2KDpR7gNS3VHkvHZdRjtpw2nrdykjQ3Uz4vyhw7kh49AKtIH3KLzVfmo
 VNbyD+scRvhsFylgOYi3b+a9TtMlp31bnM0SNK7kYzCIyOBlhiqORZyWKWurCZMK7yUrC6sT8ZI
 x/T3Ge25LN4Of2CNTYg==
X-Proofpoint-ORIG-GUID: 5QoEAhTPAiYdO1IlYh3GdDgcfDliLk2w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX+5sU1osuoFTm
 5n0G+GPmaiVn3uNzvbmAoyVQ+gPcn4nwau3y845T0uXPE3xGiHJcHvbhRBaNriy6cmON6hH832J
 tkBucQJc5aVX70nYG5SubJ4vDHQ/BpA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

In case of failure, pgste_get_trylock_multiple() will attempt to unlock
the locked PGSTEs based on whether the PCL is set. In some
circumstances this can lead to unlocking PGSTEs that were locked by
other threads.

Fix by unlocking the amount of PGSTEs that were actually locked,
ignoring the PCL bit in the array.

Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 165c704fcf29..f4dd6f783417 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -923,11 +923,8 @@ static void pgste_set_unlock_multiple(union pte *first, int n, union pgste *pgst
 {
 	int i;
 
-	for (i = 0; i < n; i++) {
-		if (!pgstes[i].pcl)
-			break;
+	for (i = 0; i < n; i++)
 		pgste_set_unlock(first + i, pgstes[i]);
-	}
 }
 
 static bool pgste_get_trylock_multiple(union pte *first, int n, union pgste *pgstes)
@@ -940,7 +937,7 @@ static bool pgste_get_trylock_multiple(union pte *first, int n, union pgste *pgs
 	}
 	if (i == n)
 		return true;
-	pgste_set_unlock_multiple(first, n, pgstes);
+	pgste_set_unlock_multiple(first, i, pgstes);
 	return false;
 }
 
-- 
2.55.0

