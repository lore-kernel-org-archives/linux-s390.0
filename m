Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684541;
	b=OCGnRMgTETQTQ/AdbOUZwT0Oz+iALYq7xsZP2qVnI5dmZhnYdKyvO3N0bP7C75bNCCE/
	 NtznNShOjO18ZBFUPwgn6agNjb1A4MZp7xYq/w28cKa+FsIoWDbVBOsdLgwbnyEHUkZr2
	 09ApgATHhRuIMs5T9i1o1VSqq14Rid+LMjj9m8nTEwztaUrpDu2auY49iLJKRWGzS+C07
	 w4jLUqSe3JorvtxIMye24F1LqZJbB4yltbwrHObRi6fUUl/uK+pcwvZLNaihvyMJjxuFC
	 6aCm4Vu7nbJkkhS+zsrnZG7k3/PqqbTG9eg43ou3zK1NLDogVjiiwndCCvFHadKJ7uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684541;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GzDT0H9gqpV+k6XBmpb1Gc2FAVECsDExjYUaF6UfxRA=;
	b=vStVDgthk42wsqJU1jx+mVJ9tuwxz1dCyNTgyy6nBEDzUydFmEYIOy3LmnXGfrobhvKJ
	 rLlewwzKgk2KDM+eXU6E4+N4s0LFWkneHRRbnhYkxAbw/9jrCwGmYvVDxjHlaz/pjFJGB
	 DScL1r3DSQU7AofvnHSAE/h7JNXdq7naWZ8hABjNcDB5JaVIAfv6PlO/oMYpxWreuyqCi
	 Yigh7wQqMIpGUdIaQ4MRJI1M9xg4HRux+jMM/E2tblXxGdtnU/EvYleFgIuD5bCUbA3EA
	 KfFBMu9d0Fpjxw1rg4oH/nsAPDt4yYGtr37xDzFZ8LUsgscMo3oT0OztNbSa9asCs2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="J/yPRie3";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCA606A319;
	Thu, 22 Oct 2026 15:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29DCA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J/yPRie3
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEExli058455;
	Thu, 22 Oct 2026 15:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GzDT0H9gqpV+k6XBm
	pb1Gc2FAVECsDExjYUaF6UfxRA=; b=J/yPRie3bE2PkcUpimV/PLw+stfulYJeq
	rPU46TcTbRBwKppMvranatxfp9GG7T0HaufWvdBtFQZ+vuUdGbeh9cO3w0byEaxB
	/x9bPp1RiJAZx+ObxsD+v1uIulMh4hveRVUrgwDt4DdTsM6odcgM+vG5eZnxovNh
	Nt6bBUHGmmCggJz8QjR3k75QNggY6ycKNXeDXw0IQGRL3gEUUO4a/F2OWW/POCli
	qxAUoCTAQT43/HNhV6KsKW12Ir+KEXd1RI5yPBZL0gtn8O4m1Cq2ptMF8aLl+7j/
	GoExoXam/nQDNXidp688nagP4F1ZFEVZR51b+s+flsIDfTIZPFBAQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5aynph-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJuQb3612495;
	Thu, 22 Oct 2026 15:55:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss8ert-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtVHi47382874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91CB420040;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 716DC2004D;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 01/10] KVM: s390: Move some skey functions to headers
Date: Thu, 22 Oct 2026 17:55:22 +0200
Message-ID: <20261022155531.204593-2-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ada31fa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=HEUQaSvOCpYZseJEH4QA:9
X-Proofpoint-ORIG-GUID: kTJU95en2ouLOqXKIhM-CFhXt-utsrXd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX+3C83oU2b+0i
 /i7JoCVLHH4ghh23L+YloSwMiPzNYwUQLxNBaH2DOLmtuCqv3AjPKIcSFai/sW8rOJOhYqkwDAJ
 FRGYLiS4vmpX7HghQ2SPUpCCjVgipg2ARQie74/wAFK2pcvat9T3dag/4yLamjKeZjW1kG9KkBx
 h0PzglpdN+BBFreDYqBzb8Hn9wvgNuj3pfnpDoQsBnfLif+LB/VDWcK+1nUBqcmcojRyfPQgldc
 cKH/jKQun6L9JVFtfj77IT7kmgrR6iIW3DuXHXskffLqlQhHQapw2LXnxoO7/13hQ8IAiTV9YQQ
 pm8YRvAfO6ZfWratN96664fLOioHn5WjmvJyFheMeMTuoOxy2grk6t6tDGD4Drueo+g49utw/hg
 1zMYzVVSYz2OR0UShlhFFHEP3vlyxRKWMguEdtp7+d0SYWmIboL8akeMYNtWf64y/ykcTiQR48x
 15ePaBCMmLb0INhD/UA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX18/8go9unRZe
 dkbbGOZlqNqvo7vcYsN8H7fJDiIbLfCdgcWCcXxd1TtFqLZwxoPqGtLZF2xKkaOysh7M/UA7Y4T
 p5r2f5FkRYP3J5htGG3mCBFU+af+hNA=
X-Proofpoint-GUID: kTJU95en2ouLOqXKIhM-CFhXt-utsrXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

Move some storage key handling functions to headers, since they will be
needed from outside, and they are small, so inlining is acceptable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c | 26 --------------------------
 arch/s390/kvm/gmap/dat.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index ff80d02c9f56..b9507daaf327 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -159,32 +159,6 @@ bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste old, u
 	return cspg_crste(crstep, old, new);
 }
 
-static void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
-{
-	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
-
-	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
-}
-
-static void dat_move_storage_key(union pte old, union pte new)
-{
-	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
-}
-
-static union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
-{
-	union skey skey;
-
-	skey.skey = page_get_storage_key(pte_origin(pte));
-
-	pgste.acc = skey.acc;
-	pgste.fp = skey.fp;
-	pgste.gr |= skey.r;
-	pgste.gc |= skey.c;
-
-	return pgste;
-}
-
 union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, gfn_t gfn,
 			    union asce asce, bool uses_skeys)
 {
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 90389d47ba4e..3167543bf2cc 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -988,4 +988,30 @@ static inline bool crste_is_ucas(union crste crste)
 	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
 }
 
+static inline void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
+{
+	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
+
+	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
+}
+
+static inline void dat_move_storage_key(union pte old, union pte new)
+{
+	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
+}
+
+static inline union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
+{
+	union skey skey;
+
+	skey.skey = page_get_storage_key(pte_origin(pte));
+
+	pgste.acc = skey.acc;
+	pgste.fp = skey.fp;
+	pgste.gr |= skey.r;
+	pgste.gc |= skey.c;
+
+	return pgste;
+}
+
 #endif /* ARCH_KVM_GMAP_DAT_H */
-- 
2.56.0

