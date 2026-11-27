Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791883;
	b=XRfroa6QlwsL5bA17aulMZsaxS010016HeMWDTv1qssXzmwTNt+8euZZws3QXeKP3Kq1
	 kL9idxtTDmSwq3RrmAkax2JJjwq1+BNIrnoJlJcKqig5OFXbT33d1Ae+5OwcTeeCm6kX2
	 T0uctxpJHQ2La991/cFGIZiWRTipuUO4OB0PBZmLEEHMtOecyrM02p7zW2HsvbriVBhnn
	 BZ+R8OYnCnTXrdkAn38G2M1yuRvmspjXJfCw62T81fWIAdJW4xF72IrCpRcEn/2QzqESJ
	 Z5RQmX1F8VV0tjR0FxkR2ia7zn8VtGUXJ/iwFuHj4O7JuyB7VC8IMDU27GsGR9J6cwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791883;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TELhXf/I3L+VHLapyCSxFVqeXQuKdErmPvaeiMll2ko=;
	b=fXRP3N/RWMjQWG9/k5VY+tDVmaotyBmLFBO2+TiePD6wjKsuhTlKuWGShNivnTY5P3v0
	 uBelPe/f02qILfE0cuULVPrbcSYbYseomZT0yAaw3bfRoFMUNG9Bvine+X+CnFqmGIv2E
	 4WojrpVEP6AnpbcrMmKJm8kjsFS4/ZEiY3NkIaPf7xg67Mr4V96yzI/n8Tjvc08qFGXic
	 zIrkzUUmZslEyDgEWI4n2U85WMah6LzpuF1iorTVBGEtp8WdxeJUCdrT1zqh8sUWEaVz+
	 T2lpGaneySJaVEhv0ZigfsDhpgYyV5+NhGZcddGwpegZPuxwMOT+dvIBzn2DidDOesQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eNIhfvxM;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70341606A323;
	Fri, 27 Nov 2026 15:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70341606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eNIhfvxM
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4t033266041;
	Fri, 27 Nov 2026 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TELhXf/I3L+VHLapy
	CSxFVqeXQuKdErmPvaeiMll2ko=; b=eNIhfvxMs/3vvspZzvx/FkeSo3x3hsne4
	vufO9LdDJ4UQV2IcfmQJ1ebb7Ez0B/ILFepNcsilRjlVEdjrKSFErGZt8UnIgLNv
	JqKk5BhWmc1DHKsARANmzRUAw222A5wgVfoaKZqtSu7RYN7tHMejhAKkIRcpCVln
	CGu4+1Zndy/uYqhD84yYvHdX+tBkH2lF9F8qNyVjmn0ny85E2ZICb+MaxLkOer+M
	3MI7ZrL2xLRqlhK7VNoGa83ge64r0fwEJGVe9fjZS5tESQMpDwScsaV+TpYgw2tI
	pVMT5/NOjixqBKQyf0ecrnfh1FEtSEJqtibCOG1xg25CopWKGhN5w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1njc4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4HXQ2819251;
	Fri, 27 Nov 2026 15:04:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaanmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4NQ046530914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66EA820040;
	Fri, 27 Nov 2026 15:04:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B4FE2004B;
	Fri, 27 Nov 2026 15:04:22 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:22 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 09/12] KVM: s390: Fix *_test_and_clear_softdirty() functions
Date: Fri, 27 Nov 2026 16:04:08 +0100
Message-ID: <20261127150411.221072-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: XgeRNtcB6Me4X2Y6P0f8DwmyC33YmEyC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX0j85JKq0MXVr
 R/tamob9naOVlGZaBfvZdkdq4rNl3mLIUYNsdhoGuEVF+SPva11TjWOxjjYdu2XeSLfuqiBtqrp
 SR9MI/K2uEP7iTQYMaSQPZqjEI6xgzw=
X-Proofpoint-GUID: XgeRNtcB6Me4X2Y6P0f8DwmyC33YmEyC
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b099bfd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=976DjLjq2lOgM8JfavkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX+dlgPeIgP7Xy
 AlWvqLeL4ifEMXIPrbjsLqzNdpLiawolqjtT1Y8NzVoKt5/H5f1jOjcgvfJYQNRBkQs5+WS8IVs
 wzRfV0ORvy8tDnqBVB1s8GTpqNso497DqYNVPFGC/wfyDnik3nvEpKiM3vUPB+fWMNlfBc66Rzt
 H3u5Wo5TN5qXw/YsBh1IGpdV1K+hOdfzFPKAUQYm0nK461fNPCnw2dODj3uYd+be/5XWKQzO1lt
 sjg0fnA7LpBdEAe1xRRQWyf2TxYq+riJSvEjbsMCkZcey4DK92S25bP021IUTB6kIN749Udvkie
 C6ctE1g6zSwoGvpfwxxpJmE9Esv4mq30yQaern2M3FiV3/BIW9gzHCyatMVncyniDPZi2isbSZr
 Dmsp6rPzL6MNOUbVvLtBu+TfpO0wabNhWMmjFXJ4X6dJZUlvQ9RG71bDSYaMPPBEVOMeVuqmQqn
 y6JeAUkEapuRZJ41gwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270060

Do not skip non-present entries, as they can be soft-dirty, and need to
be accounted as such.

Check for the invalid bit together with the protected bit when
determining whether to skip an entry.

Do not set the protected bit if the invalid bit is still set; the
invalid bit is enough.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 5a40f411bcc1..ad2d815cf9c4 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -585,7 +585,7 @@ static union pgste __pte_test_and_clear_softdirty(union pte *ptep, union pgste p
 {
 	union pte pte = READ_ONCE(*ptep);
 
-	if (!pte.s.pr || (pte.h.p && !pte.s.sd))
+	if ((pte.h.p || pte.h.i) && !pte.s.sd)
 		return pgste;
 
 	/*
@@ -593,7 +593,8 @@ static union pgste __pte_test_and_clear_softdirty(union pte *ptep, union pgste p
 	 * running, do not reset the protection, leave it marked as dirty.
 	 */
 	if (!pgste.prefix_notif || gmap_mkold_prefix(gmap, gfn, gfn + 1)) {
-		pte.h.p = 1;
+		if (!pte.h.i)
+			pte.h.p = 1;
 		pte.s.sd = 0;
 		pgste = gmap_ptep_xchg(gmap, ptep, pte, pgste, gfn);
 	}
@@ -625,9 +626,9 @@ static long _crste_test_and_clear_softdirty(union crste *table, gfn_t gfn, gfn_t
 		return 1;
 	do {
 		crste = READ_ONCE(*table);
-		if (!crste.h.fc)
+		if (!crste.h.fc && !crste.h.i)
 			return 0;
-		if (crste.h.p && !crste.s.fc1.sd)
+		if ((crste.h.p || crste.h.i) && !crste.s.fc1.sd)
 			return 0;
 
 		/*
@@ -635,10 +636,11 @@ static long _crste_test_and_clear_softdirty(union crste *table, gfn_t gfn, gfn_t
 		 * currently running, do not reset the protection, leave it marked as
 		 * dirty.
 		 */
-		if (crste.s.fc1.prefix_notif && !gmap_mkold_prefix(gmap, gfn, end))
+		if (crste.h.fc && crste.s.fc1.prefix_notif && !gmap_mkold_prefix(gmap, gfn, end))
 			break;
 		new = crste;
-		new.h.p = 1;
+		if (!crste.h.i)
+			new.h.p = 1;
 		new.s.fc1.sd = 0;
 	} while (!gmap_crstep_xchg_atomic(gmap, table, crste, new, gfn));
 
-- 
2.56.1

