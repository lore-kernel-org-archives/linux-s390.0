Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849531DD97;
	Mon, 13 Jul 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955351; cv=none; b=oHzL3mx0myVWyCoCvingznFdt+plmIEdwa8UhpVXHwZA09bP0/rind+UTyktMo1mFGzpoxRa9nlt6gdG4UN0V/Ll2zbWsX0qYveAfXGPSVvoEyRddz/OO+8ccUuS4h4zdNRPY81YWom4WHAQQM1rXSSSAJgkExK3pBhR4STUp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955351; c=relaxed/simple;
	bh=MMlhbPxOpeprbrS6Q6+Za+3fz514wtI0K7hWiQb2WGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8fVVBC+6uG5q86XuyUwhGDjUiy8DnoIWwALBFfnIm7tuSWEfqkd01hT7WWTg2yYkQf8uTmpt+a+tA1F1SgIFDE8LmvihnbFqCLuHtcRzTEcEkMQpaxa7e3MOtGOlptB6lshgLxe9bMHmCCXtQ9lk/vyHhTxKhsw7VUpFnkX2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WObBDm5l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WObBDm5l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCCvwW2436851;
	Mon, 13 Jul 2026 15:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1ydwYp7qIDT0IiImF
	QeRoxlrSRWdWkPaR5oemlJ4to8=; b=WObBDm5lwYWqPYl9u9U892rkXvhCEiBCW
	ZLgffzEfB7DUYkgNa8+vCUnDZ/iT/1M3OYdFoRZee5H389yMpv7B7L4OOYXdR4J2
	3CGYCXqXGDMiljuxVu7wpDcIsPxCRK4ac+Ee3fIVVVqYCIQ0dBVNrTsH6PrgFV8o
	m3ZK0i5X8RSpjXRiBwG+sj3XN6UzTd41DfkpWcrwA6rxuqyyFXBHBCvG++uaCff5
	KfeMbORPUzoD0IjghfGLd6FVik8BAnT6xBTVxbv0fu0ezD7Nf+wq94FR7DbAGprM
	gA1Aov6CNP19qQqTyXgq51wh9A6zemJpehwbrVJal1sqVzrnwymcw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx9ah9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4kF7006328;
	Mon, 13 Jul 2026 15:09:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh654c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF90xK15270376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:09:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 791D22004B;
	Mon, 13 Jul 2026 15:09:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B01E120040;
	Mon, 13 Jul 2026 15:08:59 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:08:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 2/7] KVM: s390: Return -EFAULT instead of PGM_ADDRESSING
Date: Mon, 13 Jul 2026 17:08:52 +0200
Message-ID: <20260713150857.269954-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713150857.269954-1-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rfoma1cf2KEgm3vt6COPOEIkNDo-GcUK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX90qbjCSV7uUr
 IIp21Bze6WyaqZmjyzl4zec1/z2jDIMaCrv+g41ixMfc/vnCK3DfWSOBDL4h4XcPmZ1PlznaJLI
 w+LIK/ySP73bZVbP+W4Q5xfWWYgIeAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfXyyYJAaOE5G9C
 ADFOOd5M9w4d2TZS2PlHM82iUW8kVdh6WRAXinpzs+7dmQiQhcG/eAyBMTuljWyPEaWGvv/ZGl/
 XO3OROWBGmVpEoSdyg5j6yJD4ymz6/1XA0W1Z0DruCNu71xH2duPXkXzZj3ACnXwaJm9/nmB+/D
 9gYletbE5JCb96v9MEHrHHEIE11Ec4/09DxM6abrJhBb8VaRBFihatIUyU6gaEouNZwa4G6gwT9
 80LruIT53z+gXsS3mRdz9xQsx7Xm6eGKP+o6Ub2Hon+GGCDzKhU3/ek6NdK5dDGFSxd1TLPtM09
 CIrNgAfXfCi652RUTvInxez8tUdgMwIUi2H9FitBqGTbp/3mefbGOA1fDQyRTsVu8EFtDAzDU5F
 INZaUNkekdAYzYqoDm9bG+pwYTqEeNlO/2VfQU1D/277Kgaty/GIWmL0J8+OWqro9m3Z4+NMVO/
 lbEpFBjl/lZ3fftY+1A==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54ff93 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=hOzztX8ZSV9-bidYd0MA:9
X-Proofpoint-ORIG-GUID: rfoma1cf2KEgm3vt6COPOEIkNDo-GcUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
value. Same issue with kvm_s390_{g,s}et_skeys().

Fix by returning -EFAULT whenever the return value would be > 0, which
is consistent with the behaviour before the gmap rewrite.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 374dae6dae81..53691aaf6534 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2212,7 +2212,7 @@ static int kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	}
 
 	kvfree(keys);
-	return r;
+	return r <= 0 ? r : -EFAULT;
 }
 
 static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
@@ -2274,7 +2274,7 @@ static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	kvm_s390_free_mmu_cache(mc);
 out:
 	kvfree(keys);
-	return r;
+	return r <= 0 ? r : -EFAULT;
 }
 
 /*
@@ -2384,7 +2384,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 
 	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
 
-	return r;
+	return r <= 0 ? r : -EFAULT;
 }
 
 /**
-- 
2.55.0

