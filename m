Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684542;
	b=BnYjDFnIZCkdlMtK5EYidtECTT0Ica/qLJQrLpGb9XSEjnNbdSUesuOwP7nSPyJAq1HW
	 pFD8rFduzCUJSnXVEZE7jVtLcPSCP77CJKgXcDctU/e/RCZb67X55XaBoOYiqyaab12vg
	 tr+kcXsrpeuV5m9JvaZ9txwDJKdmf/A/Zr/I4kEhnzWDFtG+zTQpPyPP7PwaWZuJm2xRh
	 VZvOlriYwOnD0zkd7z2ryfluKjL0HFDtORKuBdAo4//wXlMebETMvSBplb/dq8E1pgkSb
	 p6Mo0KNYTwHLr+lLrD34ckan3ml+T/nIl2Qou284KXR7MJYGKzMOr6HMVpkGpqqYzHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gme1D6KaSjuykXViFrNAudx1w+FGp2xJgKly3H/xHe0=;
	b=MZxt3T1tnu8DHxO7ClIIkYHRltCONMJvIDIuVMBnXzouKWPrPq28qsw6c4YFcPl5Kjgj
	 d0QIftgKaLtfVhRpmDj/kNE2shRGhP+CMYRvgcCVKJUiOU5xW9YjjUXPKWYZmzTiaFRuy
	 cOLghRhpTqSlTCj/mSBRjaGrKYpmO9uuhXcCV3DlLzQ/WMBQVwp3gyXf69D3bD67TedM+
	 FGld+3JErsrCRG5iqRGyXzm++QdrvpYdJsSuhQfLuLW8ca3l7dDBe2KBv6ThEfWoYLZOy
	 dqsU+8d4gk7ib+4jK7pEOCJP+sse62KXtpJI5xHHMP5NTH4AdNygMyfUwn5xvMTEI4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Upft6lUO;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E6606A31E;
	Thu, 22 Oct 2026 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE8E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Upft6lUO
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEcHs140875;
	Thu, 22 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gme1D6KaSjuykXViF
	rNAudx1w+FGp2xJgKly3H/xHe0=; b=Upft6lUOHFVdJvPZYGEYEYnQFpFBXwLSe
	LteBQJbijwveqCiHB5hW/W0JUZPJZd58BbpnIP8YHFY3BUd/0q9nY3/1OfzSSyWy
	BJHlBK//965LrlKmmxIhHis/CtmAM5RWERiuVhcnshVV0RcMQvGAFbwYk7kHImVF
	IcBxvf/eieZjXEYKmibg2/ShnJ0SLMAZYFhUOMi8JHAjw9zC83gHiEgjep7zbZs5
	l0aTq0iPAB8OZgWfo+UH1L5iNTsOmVI5z9J2eouEoH428Sp2fnNcwnBxETDIEdbl
	DtcTHWSnWxkJx1TAud34UIqdaRuqkg6PuweNwTkqBTgHhTVZlmO6w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a7jfq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJtmF3612475;
	Thu, 22 Oct 2026 15:55:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss8erw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtWY140763860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1FE2004B;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E07CB2004E;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 04/10] KVM: s390: Automatically enable storage keys for UCONTROL VMs
Date: Thu, 22 Oct 2026 17:55:25 +0200
Message-ID: <20261022155531.204593-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022155531.204593-1-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX6/ViwHzv8J9n
 czeN68VuedPHOhWKr14x3nOL3y3A6LB9RSomI9W2yaKsTbadA7tGpPFQxWhX15iPtojV1B6aQRP
 9prDLEJA2E0NAGhfMV0fWAcMPoWzGONFcSlFznOfgnc3NXBUYdOvmcpZC3gCYz15+4lzcocf5fW
 aQiHkrQ9dTsc0oBptDn4/oMsp+U+BjC92ZfX90ARjmkFAX2gktxftnE6DgAmDmNhGTK811lf0Ko
 Y0NYobWv4Vra2JJmwUX2Ji76ubbE43lx8+9Ss8TR0In0nwloBGGSUWPY7oqMd2atqu820b7bmq4
 1nlNSp6TJkewuGsmStb590VnFvSxGIQio1fFN1nNDo22FsEu1Nk5asdP2SFoQtXPNS2ZrsDVpWN
 EUSlbYmdE6rjfpjHpW7bTZe3FtfWdniUnSwV7XPTclKvTDyyoeCUf5VOxE+iGXBaTPoqyIyAgUX
 7CSkU4d9aA5w7RjiIyg==
X-Proofpoint-ORIG-GUID: hzZCs6O7UChCK6g5cnbWVKrAoyHF-dvC
X-Proofpoint-GUID: hzZCs6O7UChCK6g5cnbWVKrAoyHF-dvC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX15p14LZaXPim
 CpZ3O47asAixo9SSmMEzqvqwc6nzF4Cc5L7Zbb0KyRYNqtPsaR6OJqi4OQbZIOmZHHpRVuyQ0mO
 S0eeWYsbFi6CPDMSz2IJX4HaUdjFPIU=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ada31fb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=YbjXXk8-Ty8lgCeYkKMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

Automatically enable storage keys for UCONTROL VMs upon creation. There
is no point in leaving it to the lazy initialization, as storage keys
will almost surely be used very early in the boot process of a UCONTROL
guest. Furthermore, if storage keys initialization fails, it will
prevent the VM from starting, instead of failing at runtime.

Opportunistically improve error handling if the fake memslot cannot be
initialized properly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index e4912db67adc..dafcd104d316 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3346,10 +3346,15 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 			.flags = 0,
 		};
 
+		rc = gmap_enable_skeys(kvm->arch.gmap);
+		if (rc)
+			goto out_err;
 		/* one flat fake memslot covering the whole address-space */
 		mutex_lock(&kvm->slots_lock);
-		KVM_BUG_ON(kvm_set_internal_memslot(kvm, &fake_memslot), kvm);
+		rc = kvm_set_internal_memslot(kvm, &fake_memslot);
 		mutex_unlock(&kvm->slots_lock);
+		if (KVM_BUG_ON(rc, kvm))
+			goto out_err;
 		set_bit(GMAP_FLAG_IS_UCONTROL, &kvm->arch.gmap->flags);
 	} else {
 		struct crst_table *table = dereference_asce(kvm->arch.gmap->asce);
@@ -3369,6 +3374,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	return 0;
 out_err:
+	if (kvm->arch.gmap)
+		kvm->arch.gmap = gmap_put(kvm->arch.gmap);
 	free_page((unsigned long)kvm->arch.sie_page2);
 	debug_unregister(kvm->arch.dbf);
 	sca_dispose(kvm);
-- 
2.56.0

