Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC03EDE73;
	Tue, 12 May 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608384; cv=none; b=HQ2b2xnVKdeOZUWLPo2yonp/AxoJXTsL35AJoBQj/8EMcHJX7gtfSd9ukpUqYeMaT/B1oQ2I/WkHPf9E0+xGjqcaIzAIE2fCfG+fN0dJOjBYULD+pl65uK3viI9rDLqzSVW/21MVuhGWtRKIOQQu4mQmwHwoiolqbuNK+y5SD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608384; c=relaxed/simple;
	bh=RIY6GwkrqyQv23R5UR0OT8M+rigIakcNkUtfdqAKx2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDPIBPANdXS1MZFaN3gDOFHMNwp+Z99c2fssl35siUOtNNeM6Au22fTQPnD0PexCCxxlUDx1bzsJ+BNsz3H5PuSSgFPZVTcAk4PBi6yW9nhrz+2TOgcnYfQaH3NZh2XY3E5JuV1w5ofZ/mZrZ9r/6sLC2//lAHeeNu9SxE7oO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EV7rpy7s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EV7rpy7s"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCoEoN3775953;
	Tue, 12 May 2026 17:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lNiN1bS/xqdkk1xq5
	vhcjU2y2iaAEdCZmIhapixQ94c=; b=EV7rpy7sjjxkMjOruOFYJFuUJK/9sqh0e
	tkHSywBU8k/lFJhFZcYJ/r6Uff0kYXMIg5lW5GU7NKbFn45LzFffFtD3lIA3AFz5
	a9WI2k4EwcaYVufzbCvo9Oeh64pcUd1QUU0DXXNDXzWqzdwqQWg+BOeZjK0DKbWe
	iuNYGUHZZ95bSUhhXSWakqSevf1CVu7AlCuDNqMa3EylpElaWb3ULlHVpHMTKLyJ
	CJES0Hwq4lJrYQfshIHlyYQaZjJZvtSvzivkSXRV4PgeaMRr0eNgCgZrgOzGTuvN
	91Cd94rfEMGSWHOgHEJ5MVMkgSA24f80+xb+qswwFtlFHNlWHw1WA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6m52t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHdeHS020268;
	Tue, 12 May 2026 17:52:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgc8rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHqrU661538628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:52:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49CEF20040;
	Tue, 12 May 2026 17:52:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 164F220049;
	Tue, 12 May 2026 17:52:53 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:52:53 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 5/5] KVM: s390: Properly reset zero bit in PGSTE
Date: Tue, 12 May 2026 19:52:51 +0200
Message-ID: <20260512175251.300882-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512175251.300882-1-imbrenda@linux.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a0368fb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qr9DHn0TZOiEmrbJNPYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfX1vFq4jFiZugj
 Li5NVIcLe7ZLWLEx+NPkMh0Qa/JBd13yyv0tLIIPrmW48jyjfgMJihGAytMQxAw9usllt1WU8T7
 4dERQ5/FJsbq+SPowZIer6aMcuKECBOAQH63lXDNFZ1fM7HyGb79kqBHBOQr3MzC9hFrRF1FZxq
 UQ3jodytlHSHo6UtkW0AVOBM7IE8lVoDTNua8jWmzzAm3rCDTHiGuldjUQ1vmbes3VN017eR5sk
 tm5XBCPRjsn1kJlq/hCaUQ5gSNsiqSAUjwfsPcNuXElsym4JUo4H/TOcBh9v9glr5z7fduphJGC
 VjzvOjhNlRFmIlZ5KZs0eHLAaCaKv/pw7kPen46a7LRI2W6M70S+EBCgD0FWirqa3QbwbGUYIkY
 ///o7JtMnUynALW26V1qC/eWCexdc0o0v7YHnRtlyq91pvXxdgLLhOsLzgdSkdpK9ue2lh2PKpI
 /M53ndr3SBLk42gx8HQ==
X-Proofpoint-GUID: 5T6wxvpYxQmgyavdGosQkrEGQYC-6Y6_
X-Proofpoint-ORIG-GUID: 5T6wxvpYxQmgyavdGosQkrEGQYC-6Y6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120183

When calling _gmap_ptep_xchg(), always clear the pgste.zero bit. This
prevents the page from being accidentally discarded when getting
unmapped.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index e490f2995a26..4de9ed8d58ba 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -199,6 +199,7 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 	}
 	if (!ptep->s.d && newpte.s.d && !newpte.s.s)
 		SetPageDirty(pfn_to_page(newpte.h.pfra));
+	pgste.zero = 0;
 	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
 }
 
-- 
2.54.0

