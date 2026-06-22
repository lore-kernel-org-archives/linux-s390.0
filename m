Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FB3CBE91;
	Mon, 22 Jun 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144471; cv=none; b=C3CvANhY0qDRFYc/FCWx05GwxqEsGMAsbLUjDycYTYBQMFK8GbFXAvCpmb+4sjK2HRoPtjtOlT+qKd9gMKxraLlQExUXIysOmdVhdMWP3wxGa8wWftf5s988DlzRm+Q1JhuYTPnY3UyTLh7VvatBJQgolz7jJMGSqyHyUzVep28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144471; c=relaxed/simple;
	bh=bmFblwBf/+4l8gbJcsPBz6nOsVUnAdh+6dpaqcKbgyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D154Knn6MrYcE4PvdcWsxJaUn1kvoKMgOVCFQ95b/Xji8l5V+x41bjrElJKYqtvHOd6Sj/G+5ND4P+CvvJtLXizXr3v/hI10/kj7qeyuu61IrJTrm6OYxrEgqpusuMBFUdInWQFisihKfYZmKDAhW9vdmD6v3YkfOltOdp0POb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eQTymIN6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eQTymIN6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmVEW3331790;
	Mon, 22 Jun 2026 16:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ghNLbNysLPiTgTDEP
	v2z+YKuPYPbZdBL1jENcZmXlYc=; b=eQTymIN6nqLEgcoo74fDRzLyKNRkVnVEa
	eaK/Dh9luLAAsbtVbnYHF8Q892QrSErTjv//dQh6D5YddYYJvarkLzqdZhsRFnar
	AS6S2xMV9pX9HxJeQdJAu2u9KDOOsyJnullrsvOmVZ7A7SHnJg3e6ut+r1iJPdIg
	vIDCS7Evx8lZHjKIzHEPr2/RDD3C3vqb09QvFEuhtBZ2x6O4vwKKlAjqs48aeIsO
	p2Jht5hkM2QQ65f0GKueE0QJhAyocX0bOWPojvz/wGdZpBk/1FsKTJyfeKTu++q4
	fLnm2aiex03+IGWsX795Ng+8wWX0FHXt97FLa/Z8Mxrn+GQPptJ5w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsj2jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4cPV022711;
	Mon, 22 Jun 2026 16:07:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66jy0ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7gcH34865554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA5B20040;
	Mon, 22 Jun 2026 16:07:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD7D2004D;
	Mon, 22 Jun 2026 16:07:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 9/9] KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits()
Date: Mon, 22 Jun 2026 18:07:39 +0200
Message-ID: <20260622160739.202044-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfXzAomtwFpEfeI
 rDlMNRLuAezdUS7KED6GQVOddBl5B800/uppNhAAvc+f4QH8kmL5t7WWSES9252XJ04hIFMvMih
 FVWy8ESzp1cdoZxLdH4RsjsmVJNSfPDI7t17Vf+d2sOxxlY+zorLKR4DHB6L65R2qFXHoyWFtfI
 uVvHYHCfFG0FKyaCbWPLQsNgkynZjCw54GwbyPd/Q4ZXfIfXzRxpL4SYZhFtwhU35nBNw6XBq5G
 fAbRDDOoMTVNKytNWhbpEJX/dGajd6H/sbJ3v2ikBRJ8FJTDf/hEz0OIllu3/m9f+tfa9q8Uyvw
 yKu8UWO3Xt1tTVXA1dB49vdsoQMEt4Y/egL9OsCcDJzPC8eg/SjpDOjS0cUiQldVjMBgpa5n3rU
 hBUD8Yr8A+JAn9aiw9kqbRPlzgVVeGdmYs732P72pIQbwpcVpOnl7sRaKNw0LKrb697yH9U3Lsh
 GCQSgrLxG8LXZWdGk6g==
X-Proofpoint-GUID: DNzrEbFca_0-TEu7WeyPJsXjK5suQ8Ym
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfXyV7THrpXFsYb
 Vs7ySsHgjGuhCOajXC/Ig6DOdznbFOLi1lkIwg1WlkfgKtcY5736dmzL3obVXt7i/R2KegFlxlV
 ruvM8QBcZT0qEGlkzgnmIJ8MG3cvnLQ=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a395dd2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=xmMRMRw_lv4QeeJnpVYA:9
X-Proofpoint-ORIG-GUID: DNzrEbFca_0-TEu7WeyPJsXjK5suQ8Ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

If the allocation of the bits array failed, kvm_s390_set_cmma_bits()
would return 0 instead of an error code.

Rework the function to use the __free() macros and thus simplify the
code flow; when the above mentioned allocation fails, simply return
-ENOMEM.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index cdd8b41d24ed..27d6004132d2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2282,8 +2282,8 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 				  const struct kvm_s390_cmma_log *args)
 {
-	struct kvm_s390_mmu_cache *mc;
-	u8 *bits = NULL;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	u8 *bits __free(kvfree) = NULL;
 	int r = 0;
 
 	if (!kvm->arch.use_cmma)
@@ -2303,18 +2303,16 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 		return -ENOMEM;
 	bits = vmalloc(array_size(sizeof(*bits), args->count));
 	if (!bits)
-		goto out;
+		return -ENOMEM;
 
 	r = copy_from_user(bits, (void __user *)args->values, args->count);
-	if (r) {
-		r = -EFAULT;
-		goto out;
-	}
+	if (r)
+		return -EFAULT;
 
 	do {
 		r = kvm_s390_mmu_cache_topup(mc);
 		if (r)
-			break;
+			return r;
 		scoped_guard(read_lock, &kvm->mmu_lock) {
 			r = dat_set_cmma_bits(mc, kvm->arch.gmap->asce, args->start_gfn,
 					      args->count, args->mask, bits);
@@ -2322,9 +2320,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 	} while (r == -ENOMEM);
 
 	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
-out:
-	kvm_s390_free_mmu_cache(mc);
-	vfree(bits);
+
 	return r;
 }
 
-- 
2.54.0

