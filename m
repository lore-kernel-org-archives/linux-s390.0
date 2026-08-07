Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23C345751;
	Fri,  7 Aug 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096675; cv=none; b=MzjjaEpiCzH4XSjqAida3ZNOaJSTagXqxpVZ15cOTwVHlS5TThK+gwTO5I/nvnvkhZenvr6H405InzFEl+C1X4ChcAM37kqyS7ZLU4DttSMPyAJ4+Eq0TGaCCJNp2LkfrMN6KbmcK0xHZP1vs5uuG6ZOsUKFiILkIp+8U8LFKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096675; c=relaxed/simple;
	bh=bnOrft0/N+eg2mVsCr2SFChRVKCecATxzyPnmxAGYjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RszPIwuSE5AfUGXbcF4T4fWUDwfHsw+XU7hX+Le0oCCm0o1+tBoYAEcIiZeMNN1FMjEx1o+erYn8WddJKIQ3zIm4Wsv4tybC9EyeBvUBpF5vvLey0ArMY/fr5q1hXMKBsvJmVIF+smD4i+uMO/NX9b9hJCBt+VKIjIi2ZYL+j1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEu/arV8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEu/arV8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HXIG2275979;
	Fri, 7 Aug 2026 09:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7V4tu5
	CVl9+SYfG4ovXDeFYyjUFzwLWngPl1yiNNqB8=; b=mEu/arV8HVDtQmZTgTDiEl
	E+DcvAJbNirvgs5Y8+57eYSo0X3sDiviU0X9v9mrJFRkfHHEjCNOToyU05kE0BnP
	YYFUmUiP4wm11yCn0UJ/1Vdxz8fonY+1afSrT5JsYBHCte/SXyyPL97FZt11dY29
	tz+jVHa6xQjKNIQMUIq/PeCwOMLn03o0KqzXOReu07lMWd9ffB0rVcxGFTtT1tfA
	iatPdu715nJrENAUg0OBx0Qs04uFZ4aT1XuCe/xK+NT+7hGjQTNW7ueS/TOaPzKV
	VMyfiUd6XB+JaQlqNwKKbeeDxNVMnjZwX7ocpiq7QfYLUjeACtvLhO1ozqoccx4Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01k9wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779uFgu014347;
	Fri, 7 Aug 2026 09:57:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgpyw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779vlvb38011278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:57:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48C0D2004B;
	Fri,  7 Aug 2026 09:57:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C320E20040;
	Fri,  7 Aug 2026 09:57:46 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.87.136.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:57:46 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:57:44 +0200
Subject: [PATCH 3/6] KVM: s390: vsie: Convert shift to phys_to_pfn()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=818;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=bnOrft0/N+eg2mVsCr2SFChRVKCecATxzyPnmxAGYjk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmlayRsZjzu+LpsWtKOvfIvjGZkT43fzlr+aPFZp58q/
 2vynhue6ShlYRDjYpAVU2SpFrfOq+prXTrnoOU1mDmsTCBDGLg4BWAicSYM/yP2f07JfSdszS/s
 +HWuKHctY+kzdr4fRs9nbBAy7vpyYgEjw/lZs5N7JwvvXZbbtZhb7d/JNauiXyTtSFR9fMFMaNu
 8LRwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tAPBcvL8gW4qY4nWsPqS-0inz90nf8Cj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX/x7152ns9nfD
 Hb7berQqk+HQUuH+5zMGD1hqhZFa+iPk3GCX0NVrFtUe4XXp93dVrTUCWy4ZUwiZ5mJ2NTBWISh
 r22d3f7tgKJyE6ffvmUuROg++qcpSes=
X-Proofpoint-ORIG-GUID: tAPBcvL8gW4qY4nWsPqS-0inz90nf8Cj
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75ac20 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=TjNmkj8DtC1qGl0FwqUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX+N7VlMXCuiZo
 2ZMhLdRXxfZ4SC74jocDxlSJfUXvUAUxweha692BSCDHg0DWOe4YyCDwW/O5vES3YCRvG2UKiXt
 LbniXgz65Iiq4dYF0Mx2/p6cAgHsiuVMEc43ChD7NGa4MacCzH1YZzhNyxiXHJ9/l/Z5+f63SCT
 eaN/PDxi364aKGzLhkRDrwghJ60xqYrKPfyGa8ahXNUK/8zhX+3Uq6fpkOEjnL2C5Z/6zDFlCKe
 E+pLlihLOFGfQVEarAnQkua+UyT3Je6y9B6nUOVtvdCF24gYb5MdgsxLssj+nqGMcYDaUjW3YMW
 kej33fweg8FKGqnyWo+zBBKbCxmipwYl+Q/XpOtv/auYHj8QDhqlbQ/3MZxg6vS0ulnfI0NUoix
 0GhGW7qQ4UobGXdCewjqxi4RD3HFzcz5lz9F8CyI6/wTMoz9T4naecv56L349mBIK9oVkny7ae2
 suRq4JmCiAOeVI+g89Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070074

Make the code slightly more readable.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 3e956c7faa4b..937f9c99bc00 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -701,7 +701,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
 /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
 static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 {
-	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
+	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
 	/* mark the page always as dirty for migration */
 	mark_page_dirty(kvm, gpa_to_gfn(gpa));
 }

-- 
2.55.0

