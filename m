Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DA348C72;
	Tue, 19 May 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202891; cv=none; b=ZyFzHe7VoVyjCBg8Y3kuqMbmbjeFparutestjjkujPtZAWHTY1pk/psIlohxJYvD8/Fd3LK8NLj0V2SJ58RDXDs21wWt/ejFjrJo4qqTH5IwuIj/zfzvh/w99A1RBaKwB37sFKaaPn9UzYeeztqfP1d0KGKDcelgspkcqF2oNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202891; c=relaxed/simple;
	bh=7zAusMvF7A0Kah0Nyjp/0JGPmq1dgtvtDlHTe3qb1JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr2A3/fiYC5aAbYKqhcf2qoQlndbr7SC2xgnq743FG8iPg0U8cdHo6S2Ih3XUhDbXuqmgz4iarls9S4pDk+ZhonwBbOI8v6O06EO1fHttHh9KUN2hdjqaXyv/SLT0GKGY1FQnEq41/b5k6tTcYMmrZN6r8eLnMhOM1WpYNk91Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rR93V2SF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rR93V2SF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JAVCCP4037410;
	Tue, 19 May 2026 15:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4WXgmEsZK4uKDY2ej
	ENxaTGbCUJ2G1lGDFmIIfrqyKM=; b=rR93V2SFwTjCGNR7ui4eiMFY6ol7nz9Aj
	cjwKqPJmpvOnY8bopgr0s06QLXozA8pM3x94hf5yrEm22Au8lxv7iVGcNSuVAuSK
	kRHJ7N8uN7Du+nBglG2rh1wQ5EKN7oKJ5lyXuvvsY0rRZR4WGTdA9hX5EGMBML35
	dol0tSQ6zOJpmAzD3SXq/XWhUdhgrYyP+C/6S23clu3NEzbPB+K2Fpd5XVYxYIVR
	vZinViTff1HBbKhqYEqmnmpKWwsiK2Bntt7/IRGXXUGAfr2gmXWF58Kr6rhj/81F
	JIhLo1Z1xcRw0xJHLkBh8E3YOG/qQa+0g9sjJswmB8TN7tWzuW/qw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74wmyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JEs424025304;
	Tue, 19 May 2026 15:01:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gaxvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JF1LDs56885580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:01:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 047F020043;
	Tue, 19 May 2026 15:01:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD152004B;
	Tue, 19 May 2026 15:01:19 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:01:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 5/5] KVM: s390: Properly reset zero bit in PGSTE
Date: Tue, 19 May 2026 17:01:14 +0200
Message-ID: <20260519150114.264309-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519150114.264309-1-imbrenda@linux.ibm.com>
References: <20260519150114.264309-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0c7b47 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=P9Cbi09riAs7zLUs0OgA:9
X-Proofpoint-ORIG-GUID: i2IOlo9PbEkCjJiw3HyI6rtS6TboBsm1
X-Proofpoint-GUID: i2IOlo9PbEkCjJiw3HyI6rtS6TboBsm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0NSBTYWx0ZWRfX5naYB3cp8ZXA
 vnMRgpKmJ3O1Vp/u4iRuizLv0vPO9MduVDIuLESoRLkFgPjBJ1SLEfdJwzqVdZvUxg2NN/tgMYn
 o6hmCwnzC9bLX3mPb1hhxm5eOWLtqYH5ujNVI7zz5npNWk7nM4pQrU8hQnHWXgd2PLOyKeprrdB
 /GpFJd+oB868e833m919TygulR3lvXtyMBc12Q1Dmd9K58CNakLh62OtSQv5qZ+GkUSrf76Pvur
 WOW6XYlzx7n1sYLZEzBKuBvrDh1K10SN7JOni8vFtoA7L4OW64wT45vFQZxMjpEeAPw3Zgnsvos
 4HUoMjaW2e7ym/aJrG3woK9OA6YIyRg3L90VyivRNMRLe9QPdxZ7qJcx0Og6EqUYMtei7+MCFc7
 l8TodYEPrgE6cU693rd1h8TJWQxV1p5m0z9hpC6OQbXX3+lzHOstOHXuvMwTzMpNneG2ZkGxyzb
 Ntbb+YA32nL135la9YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190145

In case of memory pressure, it's possible that a guest page gets freed
and then almost immediately reused by the guest. If CMMA is enabled,
_essa_clear_cbrl() will discard all pages that are either unused or
zero. If a discarded page is reused before _essa_clear_cbrl() is called,
and the pgste.zero bit is not cleared, the page will be discarded
despite not being unused.

When calling _gmap_ptep_xchg(), always clear the pgste.zero bit. This
prevents the page from being accidentally discarded when not unused.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 6e51ec6066b4..742e42a31744 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -220,6 +220,7 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 	}
 	if (!ptep->s.d && newpte.s.d && !newpte.s.s)
 		SetPageDirty(pfn_to_page(newpte.h.pfra));
+	pgste.zero = 0;
 	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
 }
 
-- 
2.54.0

