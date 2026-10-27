Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122376;
	b=wC0meHqYSjy4zFueFANg0+GWwyiwV8a6R8k8fcBoxys6eEfpVI2mM13ziQYnAkEEXHOs
	 WE5Dm2mQijEjMlK5lqKnYQePPUsM+U+CC+VOUo0yFDo3nlX4DxKXiMLVAms+Ur2auUhLZ
	 C9diwPUQtPhXGqP8pkj1kN0Yi5hsUesTxgowlkG1VAlVCrHVildDtvbBGwu3Sh+b/UwoC
	 ntGlAaBgo/iLIw2Qu6Lg+DdNXunv5YanwAvu2mIHZqehRq1qH3RY2iJ4UhW8AeaNrLQ0n
	 m647T8EI7AgjOqSkd9BqDODfeAS7o5cWvwBccmiINt/e8MTYItfVvKIyJlDCjLuPgKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122376;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XPx+MzKeB9qLnTVnixk2YaeG3jHrXh85h5Xkh4G8R68=;
	b=P/QZTD+nN6Ds3xiXXyx0sO54CLqne8CEMNHsWkBkMGsL7aEcrKpVUeQsTMK2gta+q4Ol
	 KwuWcDITPDSi0MFrLCwuUhHU18atNiLzsiJPCcGc7sqESeUhl9r5vUhaS+HWAAfPDS3do
	 MIDsVxqqVSaKCirJewhmCXiJYs2d/4if46vbLF9DMmclWNC0A9L28yQHqC2uPtVhicgDO
	 3M4Ac7kjImeYvABcP3RXHKo364sxWMvgiP7jgn+MSUEFMtVfTAw9yXU1gPHQ2Tzk1xbK5
	 YJxEh7PogU0jDdg9minBq+gXY/kAUWBKpX6h90opKsky+eZV+bhnixuNKHjWARQKanQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="qb2S/9K1";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB260A2603;
	Tue, 27 Oct 2026 17:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FB260A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qb2S/9K1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHEAh23331219;
	Tue, 27 Oct 2026 17:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XPx+MzKeB9qLnTVni
	xk2YaeG3jHrXh85h5Xkh4G8R68=; b=qb2S/9K1Cl/QoVnqrDGHDpwDvK6ifN/IJ
	pjH+6WKZQG2x9kVhxRcd2TFoF7vXHc0cRlE81yPVB4uQrDMWn2ERO7mwRx1EB0UY
	MBv5aJsTRRCHMYoxasFM4CInby66YalIwcnxaJebN1s5pUWefFYjXY9FwukOermr
	4cvYw8AhnMiA49YshiGlYvUOgtkiSI7SauN5RxytlaF3B7Zg+Du94bb17gK3vOvq
	MMYolp02XcSfVf+J1WYcAzfBm0FG7PwlXz7RtVNgfyAZhNfdoT3PjZj4uT17ak/i
	JD8/0DSST85TyGOGA1PAmA2dFMX14zfUd+/ZCYjgclvFb+Pa+viAg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm640xmg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RH54ag3288284;
	Tue, 27 Oct 2026 17:32:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010g4nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RHWekT48955890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 17:32:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF8F72004B;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF29F2004E;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 2/4] KVM: s390: Move some skey functions to headers
Date: Tue, 27 Oct 2026 18:32:37 +0100
Message-ID: <20261027173239.224849-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027173239.224849-1-imbrenda@linux.ibm.com>
References: <20261027173239.224849-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX6VP7yfPQV3g7
 7E8QjVACR2Q1FU8+8Bn3vHdEAndnRKn+uzhL0cx7kUqYiM7DoEJMlPgiW+SuYdmw7T1xZffeYM+
 NUAvKJQBCpPVbbDgGziUfqgenXpK3X4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX9guA+kYIw0+0
 fTfrfr7aSa1rdF4B6xkLjvG8LAwy/sb1D26YDwhI9zIm4nlF1nGbtlO4mEdOM113cfKWqo4+5AV
 4Tl9gMgIvYe8jly8RvydxHXKCgTPZGUoDwCqbK/Xn2ECqdiae6VmLeqQiFM3F8JualNbLl9n/fX
 wyaSCYh75RofhVfDt4ND8VCrmDIw6xbA2DlLiGWuF+KLKvXdWiuH6M6NwiRM+FpiqGQXe3HA0Sg
 M6jCGTBHR4MWPPMF6OOciVsrHe+pg9K0BSgOLa+zaLqq/EBYMNFYnfqd0AbSXYFVlzVlhbqERBR
 x20frly46+JL5UsWLxEZ/SLGE+0Qjk9qJetfTU4OuyuJm62vIeYH4DfG5UwJajnO36Rlla6sq1/
 oyH6kk+JYetWdrON/2KrBO5OCn+xDG/W7c8BS7Ivhevqr8E5dEwW5wDLTZW7OyAJM2JOQpBnUqp
 /uDiPXu46bfaC4Auftw==
X-Proofpoint-ORIG-GUID: YJbmJK5ii74Uo32NdPgSHH7vk9cIh2Vf
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae0e040 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HEUQaSvOCpYZseJEH4QA:9
X-Proofpoint-GUID: YJbmJK5ii74Uo32NdPgSHH7vk9cIh2Vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270068

Move some storage key handling functions to headers, since they will be
needed from outside, and they are small, so inlining is acceptable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
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
index 4665c1112bb9..687e1fa904d6 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -1002,4 +1002,30 @@ static inline bool crste_is_ucas(union crste crste)
 	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
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

