Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213679;
	b=NtSunQ9Rc4fOmJcklb0AY8XJeru3ryquCXmlsKUE3FB0LZ7/gB2MghsaOuTFYsy7Zihf
	 /4NGUVNmJYfAlZ940YS6T+qWMr4erY7ygvJNbv3jvEZ75+n3NSkuJqVZw40y7+C/Q/ZYG
	 MtagqASADPl6yuHyVPyvEwR7EmKAX9eg4++JvspGCDeLbZXuqe8tkrFk1JcTICylPs1pR
	 YKKq3wUKRnIVcVVHrT+uS/4gcOZCCkpIQ7Rnylfk0YKLuz1iJKYud2GUC8EaW5u0pScCk
	 /6/Ic0P+DUENmdLYOqR/AkovNorJY7Cb9FVakJ1NhE6LHogos9/4MkqO6lI6kl17i/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213679;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/ibvL0bX4hMSm5S1USUuTve353L5v56kVP7NHnnPEWQ=;
	b=hfPU3jywwugXasyiE0p0SgYRMHTiHs4f6OJ94ofrVjN1GdvL3xoSbSsoH+NNd2rYlXO9
	 7ppoEY8++tzRXqp7dGZ5Zxmif4UiaKoAgZGgHX0px2loCANhbiLFF3QHoiPnvsaEPZMqh
	 /VQheJooL+r2fC1tK9v9rGoNRB/L1E0I14gS1fodQ6tUyGXRNXGEvmG/7uLUNa4bcxkW4
	 fRyj0K9Gs8/3E4j+nuj6GxWBbCwkcyxsgdMly+5FYjt4MmChvy4qWKIXJZuBYKee2aj6K
	 IiDcJRHH9ZHRZTRM/eVMF87fA56GuA9buW/7g7nVqwmnHbF22HC6uSKO3f2URI+h1mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7pW4El4;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD55606A331;
	Wed, 28 Oct 2026 18:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD55606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7pW4El4
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIiDlI2021378;
	Wed, 28 Oct 2026 18:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/ibvL0bX4hMSm5S1U
	SUuTve353L5v56kVP7NHnnPEWQ=; b=s7pW4El4G6MEH5eAuKk3ZZTEHnMI+SkIm
	yWTNynpXHU1blkEEA84E6mkolQ3jBYc9OJ6RQO0nIxoSVe4yQ2Q2B/KlP2ZZev3k
	QrczvH8yFIXN+keFsStTA2v4KNg9FUWshVGQF08bm/d3se5t04UMEBeEB8VFWQz0
	oJtkIHW2Fx8pJSpCANA0e/453AFMxAThqoSv8h79XM3niCDaDk6kkbKnL8BOcQX+
	k5a80nDmV00tY4wwezmT4M9VmsZ58M836mvSpZ7OL0Gw90ipslkMdkPAs9vbQlfC
	Z+LrVzBQyi1TNTAALvdQrdqgY88qx7GziEgQj7K0/yQ30cqssuzXg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd76gha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIYmnd2009640;
	Wed, 28 Oct 2026 18:54:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1x0ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SIsNqe41091368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 18:54:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A43920043;
	Wed, 28 Oct 2026 18:54:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AA042004D;
	Wed, 28 Oct 2026 18:54:23 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 18:54:23 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v4 7/7] KVM: s390: Allocate page tables when CMMA is used
Date: Wed, 28 Oct 2026 19:54:22 +0100
Message-ID: <20261028185422.272146-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028185422.272146-1-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae244e6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=buFASAnLycCB2EmeI30A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfX6Msa17JHE7vG
 iIevjNyVSzwqbtVlE8T0oPlIMAmGgvt7acPNHL0Jyetqom07PHJEGjEJFF5BQ3ML94/rBEMO1NF
 9Ra9l9kJf7J54v4g8/VwqBuaqACZlVCVZfZn7iQPZD6a12sNbrOBdcbEo1xRICnVj4p1dpUsqij
 PSbc3diPwOxE+ovbH6Cf8/cAzFtmT+KfN2B4r+CcRGQaruKyP3aR305My8BKdE8SJGw7wDutsV4
 yBVV/xaBRFDnBOzc6kG4cqOAfY9ZLK2mhie0v/lD/feG8q44JEGmou8tYDALnB8Wy+ySUSwbrvb
 HlkIXmQcaz6MxLot5UELE4cylk8FWAOt1PgfGAoYQ9QFOh05+zWRGtSWUi4m1+sXU+q3oMGeW16
 LeSbvVGbpSzq56edpvpa+G4+I0UbsqNcinnNH87LbWWghVkADFDxr/l2a2DGSKX9F9P4jTG5Qz0
 65kdPwLZapU7Qtiqd5g==
X-Proofpoint-GUID: x826Y4v-wQCxlePBE9U2kR-_195AAWX4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfXxu3pAl8HYTzG
 QsF6mZ5+zo9ri28K3S3wqyvhNW1nt/PVDTZj6fuiYbEcC5XwGip6t6rctidJQY3Kjme8Cgv7XjJ
 3ZXycz8pe8194KPDsHyVBF7WBvbndqo=
X-Proofpoint-ORIG-GUID: x826Y4v-wQCxlePBE9U2kR-_195AAWX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280074

When ESSA is executed in the guest for the first time, allocate all
page tables and split all existing large page mappings, regardless of
the hpage parameter.

With the page tables present (even if all the entries within are not
present), ESSA will not cause page faults.

Without this fix, ESSA will cause a fault on the first page of each
segment (1M block). If userspace is backing the guest with huge pages
(hugetlbfs or THP), the page fault will be resolved by faulting in the
whole huge page. The result is that at startup the whole guest memory
is faulted in, since the guest will mark all of its memory at boot.

With this fix, no extra guest memory is allocated. This will also
prevent the first page in each segment from being faulted in, regardless
of hugepages.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/priv.c | 5 ++++-
 arch/s390/kvm/s390/s390.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index 856939acf012..4f0dd3173ab9 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -1248,7 +1248,10 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		 * value really needs to be written to; if the value is
 		 * already correct, we do nothing and avoid the lock.
 		 */
-		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
+		if (!uses_cmm(vcpu->arch.gmap)) {
+			set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
+			gmap_allocate_all_page_tables_best_effort(vcpu->arch.gmap);
+		}
 		/*
 		 * If we are here, we are supposed to have CMMA enabled in
 		 * the SIE block. Enabling CMMA works on a per-CPU basis,
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 18fb200f854a..739e8c23c3ae 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -2359,7 +2359,10 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 		}
 	} while (r == -ENOMEM);
 
-	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
+	if (!uses_cmm(kvm->arch.gmap)) {
+		set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
+		gmap_allocate_all_page_tables_best_effort(kvm->arch.gmap);
+	}
 
 	return r <= 0 ? r : -EFAULT;
 }
-- 
2.56.0

