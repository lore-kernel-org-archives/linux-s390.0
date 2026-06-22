Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E03CB2F0;
	Mon, 22 Jun 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144469; cv=none; b=nDjDvS4D+M/iP7zxkNC6wLpmVaAvGBhuN7NBrICntw00ybNBl2nUcmau9ODDS9ngMs39LItDqYXjHw77AqA8hW7JFRclDGjM2BIABEeYKvvmc9jqeGtJ5+od0NGlwMdL+UBtGPOI7MoCM/ss6Fe8xFXtsr36qng5SuhwADnQiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144469; c=relaxed/simple;
	bh=oPjOyf3Hgbx6tuk6sQAUVHzo31rRBbp8eiOdKXU7eDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZuq6Z1MyBJnNNDgHoDQdtIHwpp9vjTDBWtFcHYI5oHnjz4UzFFGX1S+gYrtxXcFAW3ZAAdrZqJaMN5GDa2LnvV75kclMt10/Ez6aeHhgGr4657nFFTvMVGTmeTMR+mGI4g8MZdPalkXvCfu9cS65asrXpLwt5c14xu0qt8ooI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p/V542TC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p/V542TC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmHna3447113;
	Mon, 22 Jun 2026 16:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eXfq10rdjq2dwJz74
	2ligmWaaqJDzL3+tscnHm/Avgo=; b=p/V542TCsid3RnqNCmWIoChP1sSZmwLly
	LbOIi0WOhsp3338++9pW3TBQgQhyiXHblRR3W79qR5PCHNbICTNjLetVvzSSW18c
	J6rBglXG+NgDxZQjsoeXD6pQr5rFtkzJKmGOOBvvJBWz22Eu/5mWhAbxy6MZizja
	nmsVph/8xHBWrnyA/jjEaaUWSid5eV4lvXBYjrvoWJnHe6dKL1Ugmvd6onXMSGms
	QkWTZjMkJNdFUUZfY6dysh+bGl7XtIsMHTOe9aP5ed5JsVqxkr7SYEF7tD9QWD94
	52OCM6xnAdRKxEmzTkuQtZPhKC5IPaVS89qIPSDQ1sSIsJ1f12guQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3a6f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4bSZ008743;
	Mon, 22 Jun 2026 16:07:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyep3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7fwt11403548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3007120040;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDB6C2004B;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 4/9] KVM: s390: Fix code typo in gmap_protect_asce_top_level()
Date: Mon, 22 Jun 2026 18:07:34 +0200
Message-ID: <20260622160739.202044-5-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a395dd1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9Lu97PCYw38bWmK0XoMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfXxZ3YYxo6RQQ5
 LemQ9y8thzADnFLqAbS0+m1NV1cyeWlJw10HAkwceC+nKCo2YZyTH4e2ezH0Z/ofECNMo/fvjC8
 NX4+KxUuZiPRTC2HWFR09y2bCnqFrAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX6Cijgm0ZDY2B
 jknJ/dzGFfdMsj5QX/omS9WEoj76e8NyEPiBHiV00ZbO+CF+5wDC387bzHy10tMODQuvP6Ut87f
 SoAvICAW50PM/fhzCHNCBuW0TZCLYLV9BDslSWHzamh96t6+OW6yTloxObBsGT2OuwbdKb9zAAj
 bV4SYGmzDuV4ABsXnYIjQwjb+pQwOMn+04t5qCAoDC8hLg/ERTleOtDfM+XGwwhLCIUEa3EkRgU
 GjG+15dupzMudpV3UuCZ+NmCbGOhiygZyYng/bq4qn0BYcTLE9ZrjQbq6xt5GX1ZDkpM6ArrxRx
 0V9FvCzdJ3veLXu40aDn+VYmelgR/C5aP7dLTurhJjXce2c5LFQwStW/gWuRi3Ppn6nrumRwhWj
 2wYccpCXSE9Lqpd+DK6CsWqKFoexRAI8IEZFVLZZTRJtmyFjourWmo0SAGO3DtiJGCLyBouB58U
 jGNZ80TxAyc38b5n84Q==
X-Proofpoint-ORIG-GUID: lC5ktbIEjat_17ydO0Z6W305AC1A9OfZ
X-Proofpoint-GUID: lC5ktbIEjat_17ydO0Z6W305AC1A9OfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

The correct length to pass to kvm_s390_get_guest_pages() is asce.tl + 1,
not asce.dt + 1. It was a typo, which, due to fortuitous circumstances,
did not cause bugs. It should nonetheless be fixed.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3192f610f696..e6e786811db8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1262,7 +1262,7 @@ static int gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gma
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt + 1, false);
+	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl + 1, false);
 	if (rc > 0)
 		rc = -EFAULT;
 	if (!rc)
-- 
2.54.0

