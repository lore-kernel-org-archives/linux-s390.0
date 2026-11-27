Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791895;
	b=TCvTWePt3yJoPtLbh9YxI5MjkoWwBOr805A0vHKzVlIpK3K6HzkYzgtjeAr8rLA9IOz/
	 3jZ5H+wI3nrJjxSaxhKYrbvxd8je3uus0lM632XOiIDASivDTjpfQz6fE/tONWG7Mk8pQ
	 gzCd5PMattg2JZ5UCqR8oKplzHfwzMujzf9uX5bA0wHs3VoJwTbkXJejRTvCBQ4KLcCae
	 fcWnmMgyaNtHWGpp2RjFdKdRoys3PzcIOsJq7Tl/STYQn0tIgo+YuzBEfj9oie8A0OYUc
	 71JQ2c6GkfCjrq2CZXqIFGcBFSmeqtja5vU6eT8PszGDpLslB++/pH3IXaUTSYrSvpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791895;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Lz5bee5LX0IkmYoKEPaNG3hBrIE4VgOTc0ZGzirO3H0=;
	b=au7ZqpX2W44aKfxk9EGiNEG7GXjwKt+GRyGQYXh95mMIC1s1lcvsawX0pj4tONTO8G1M
	 WxW+nxAYiCx/+/EbkGxotVhOgC/EarFLtEmXErZfp59eqQ3D6Yf2KJPHIVJj2AAzq2o2B
	 QTKBHG5UQvZJRRDwyLi9dNF7ThQQX4enXVPCaT2OfFp49PnQ0/2zp/es1DL0wXUYkzISH
	 WTwMh4+7oy+wvE5zvUV1vhFncDYwyDJAUlOrq8Bk9WePT7v00NfnGxDwTQvSN72xYFwP7
	 Iyw3K1CV0Rm/685vveTmYmjDLgqE+qods1TFUQ7082BYX74jtgqQw5zDQYRkZjNPxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=huLfU9si;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41146606A31E;
	Fri, 27 Nov 2026 15:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41146606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=huLfU9si
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4mL73266195;
	Fri, 27 Nov 2026 15:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Lz5bee5LX0IkmYoKE
	PaNG3hBrIE4VgOTc0ZGzirO3H0=; b=huLfU9si4X9ToW+SyE72xDl3lTWbzT7PG
	iCJxJ/CcGdYmJB2jeqDYdtjHdfYI17RvG/pO1Cz2t0T5oW0bHODThtCP6eEv/tuR
	z5o2wDBYte8Z8zjILMUKsNZadVcgFv35Nyn/+TT1npww+Uql4z5DeKk3Hk41RMI9
	2VfRvtSqCOBKkEVhQBcDvCd3lNhnU/mWAUEveH9LUCIn/fTy5xHSwr3NtMowP+x7
	uYlhXQARavHyyVarVnVmnX5Dznl5F4wSojrF0qVLGiPAcGG87Vv6lm93rxnnogOz
	cb0rLzz6cC4ZbXLSggpu7nZQZRUP9ZLqpp8wxK7rgLVUT5Iu3Lsig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkxbbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4EV63998998;
	Fri, 27 Nov 2026 15:04:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h2jw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4Rpn39518644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E6420063;
	Fri, 27 Nov 2026 15:04:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3182006C;
	Fri, 27 Nov 2026 15:04:24 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:24 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 11/12] KVM: s390: Disallow 2G pages for guests up to 2G
Date: Fri, 27 Nov 2026 16:04:10 +0100
Message-ID: <20261127150411.221072-12-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX/AILeyvWY+5z
 lMFNL9HwlnMmXllX7uuaf6sdUh6CqqK8YTkXa32aK12OhVjP9+hGBCtQJ5qwK1rS4USFDlpYWRo
 mY3/SxuTbRIHFx9tg72EU8DXPxLpcXEHw+R42FBNXWObKjQWVKHMTS2dr7rL/CJP3fjlvLVLfRe
 lWz2FdkYJAAB/xOWQy3lhOtwjNZLyQMEYeWXPMvS2KSlaAqmQotTC4bEqXL3qsTWTA4sjvoeyLM
 imSToz/+X/UWKJNrdc+PGchpxzVHACSux9JHJS0QDsz2csuxvEH1hFuZhTzrHfbQWuMWpSLBYz7
 nKQMDuXdGfJ42LezRw+SINGaWIC1uWlI0ra6UzQco0TPoif5TOeVVM3WdPk8fK6FH/qjcx7n1/g
 oQmyE8i8BlGqFD2gD/JduFmJp1QDAuccyiDmvMU8xnAKPx3LMISCOXkGxa7pIqvjetrHiUfMuoS
 Nh3VXxg4PpbYnKU0ZvA==
X-Proofpoint-ORIG-GUID: gW7jWqRNrYc0hxgNdvC3CI3Ucv8Q2NWj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX4Z1rcQkB330z
 h0dZZftROJtk0tuuDH0wRqQHs1ATI6RCCT+Zeuyv8fdbPgobQ17J01eytnewyUPlyoGWz87sNfx
 T8tK+MTOIi9qrqOjHfJ0gpt3CqGy5DQ=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b099c02 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=0wzihvzkjKV-SC02:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cSz8bIq6rPpAfU98cMMA:9
X-Proofpoint-GUID: gW7jWqRNrYc0hxgNdvC3CI3Ucv8Q2NWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

If a guest of size exactly 2G is being backed with a 2G page by
userspace, gmap will try to use a 2G page (large pud).
But due to the address space being <= 2G, a segment-type ASCE is used,
which means that there are no puds. This causes some checks to fail and
ultimately kill the VM.

Fix by disallowing 2G large pages for guests with a segment-type ASCE.

Fixes: 46756c086310 ("KVM: s390: Allow for 2G hugepages")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 410226cf4dd0..6a6376a840fe 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -798,7 +798,8 @@ static inline bool gmap_2g_allowed(struct gmap *gmap, struct guest_fault *f,
 	return test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &gmap->flags) &&
 	       !((f->gfn ^ f->pfn) & ~_REGION3_FR_MASK) &&
 	       slot->base_gfn <= ALIGN_DOWN(f->gfn, _PAGES_PER_REGION3) &&
-	       slot->base_gfn + slot->npages >= ALIGN(f->gfn + 1, _PAGES_PER_REGION3);
+	       slot->base_gfn + slot->npages >= ALIGN(f->gfn + 1, _PAGES_PER_REGION3) &&
+	       gmap->asce.dt > ASCE_TYPE_SEGMENT;
 }
 
 /**
-- 
2.56.1

