Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F7317161;
	Mon,  2 Mar 2026 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458510; cv=none; b=LC85PAUVhrkY1BWkyp0sE8wii9r/0cquq8lRGsleb62/B7ZSKfD4eOhf9ToUnEj8FIFE6TqzoDyoJg12DzowWxlGhSiIiZ5F/GqBpd1dOLlGvE1z1c7dgTPxNspN/XHHPuFgADARPADtcFR9VLZzZPhKXE4p7qd1jtFw8s5uFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458510; c=relaxed/simple;
	bh=SOGIauOk88mrfn8yXklOZF3aznXRw4n6r4MTmW5K3DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5pNX7BUjlaEHAOL9YjakQGMsosYM2bLQls8YKT+RkKvEIxV1eVwa34jy1ylWYhlWC/ayLbLQjIwaCO9ORPKSHJ2hNcjp54ajJdo1G2oWD8EovrUvVXH3/wI72D++bNOqhIeYqQ5TtGu7OwdfsPIlXNgcNK3UgZxX6WImrEta4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LIljlwSB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LIljlwSB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621NmYZR2167523;
	Mon, 2 Mar 2026 13:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3v6c1/bfj0dpDL8gx
	Wv3j4PgfmzXN++VKv+INi0F+B8=; b=LIljlwSB1jyOHXNWskfFZazmQKXrPFp2p
	cfjdlI/NXvvQ5DHNVirH/73jc4e7cBo/IgblcKBy0I6BuTWvRGohLCyX27MOnIQr
	mJCZODMlUJ0h9DMCtEfGYWAifHBlZ5Gf6OJ0D2khNfJWT76cRRjg1YLAss4VNVVy
	DCdMlKi0Ax5tKOfjDWZ6WPmBV8VwkXRuW83EsWle819BF+v3aA8xqzg4sZsSJNGh
	LmjGLnkPvFniZN2rEVR+3vcYj4cP+hUMfW304RKyah1kKxNmmCWjGkTC/c25Z5SJ
	kX0GCdQZz/V3KUTuj1nTESIjE32zoN8+V4e9mbV26vKuTfqNdSpIA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbpkfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622Awd4Q008779;
	Mon, 2 Mar 2026 13:35:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd160q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622DZ04W41878004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 13:35:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB83C20043;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAAFC2004D;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/3] s390/xor: Improve inline assembly constraints
Date: Mon,  2 Mar 2026 14:34:59 +0100
Message-ID: <20260302133500.1560531-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302133500.1560531-1-hca@linux.ibm.com>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Upj0Fze_RZ6dYiwcviQJGrm3XaKe1N6I
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a59209 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1N6LMg1rhyF-opLkvXMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExMSBTYWx0ZWRfXyrFClpTyK9Ha
 oQAuSnpkkEi/dWdvM74wJ15Q3qPQcqsdycJraOOwEUBCEydSPBYPkxrb6rOIgOmrqkIgXFjL/xc
 bl8oy8pyAcSL4nwBtSYxSuSIRzeP+VP7lgHleYPDv04E8f5HdEK0EWZrmppaw4tU20yDMvMrKw9
 eRVJJmLJCMFCZb0dXeUgEpVgceJplYwghV3TF9RugSmKTG8Ob/xvxRB3x6SjPmBdog/wbF6ht4p
 3U5hfhDbodZEujIOn79GKKAgj9ZbtVT1G1BA1j4tYzsZMtwl7eZk/Jq8ekNY4MUuVCoosTktuKD
 01JPIQHlnfUhOyH1ZJTiaQLnXWw63e/MTQxw5Ax7E0MpvuM1UFEQVBcoaBie2DJji09EE+nmQhf
 kaDLnAJ5i5GZ8mTmn6J74e35wD0tLwBBxI0Y6umdb1qgWYEeq8Kq6FFTsEKMSYSwFt84QUA1o/3
 oV6wFeoIV//w8KUuk5g==
X-Proofpoint-GUID: Upj0Fze_RZ6dYiwcviQJGrm3XaKe1N6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020111

The inline assembly constraint for the "bytes" operand is "d" for all xor()
inline assemblies. "d" means that any register from 0 to 15 can be used. If
the compiler would use register 0 then the exrl instruction would not or
the value of "bytes" into the executed instruction - resulting in an
incorrect result.

However all the xor() inline assemblies make hard-coded use of register 0,
and it is correctly listed in the clobber list, so that this cannot happen.

Given that this is quite subtle use the better "a" constraint, which
excludes register 0 from register allocation in any case.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/xor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index d703c44d5fd6..da134c7d89a6 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -28,7 +28,7 @@ static void xor_xc_2(unsigned long bytes, unsigned long * __restrict p1,
 		"	j	3f\n"
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:"
-		: "+d" (bytes), "+a" (p1), "+a" (p2)
+		: "+a" (bytes), "+a" (p1), "+a" (p2)
 		: : "0", "cc", "memory");
 }
 
@@ -54,7 +54,7 @@ static void xor_xc_3(unsigned long bytes, unsigned long * __restrict p1,
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:	xc	0(1,%1),0(%3)\n"
 		"4:"
-		: "+d" (bytes), "+a" (p1), "+a" (p2), "+a" (p3)
+		: "+a" (bytes), "+a" (p1), "+a" (p2), "+a" (p3)
 		: : "0", "cc", "memory");
 }
 
@@ -85,7 +85,7 @@ static void xor_xc_4(unsigned long bytes, unsigned long * __restrict p1,
 		"3:	xc	0(1,%1),0(%3)\n"
 		"4:	xc	0(1,%1),0(%4)\n"
 		"5:"
-		: "+d" (bytes), "+a" (p1), "+a" (p2), "+a" (p3), "+a" (p4)
+		: "+a" (bytes), "+a" (p1), "+a" (p2), "+a" (p3), "+a" (p4)
 		: : "0", "cc", "memory");
 }
 
@@ -122,7 +122,7 @@ static void xor_xc_5(unsigned long bytes, unsigned long * __restrict p1,
 		"4:	xc	0(1,%1),0(%4)\n"
 		"5:	xc	0(1,%1),0(%5)\n"
 		"6:"
-		: "+d" (bytes), "+a" (p1), "+a" (p2), "+a" (p3), "+a" (p4),
+		: "+a" (bytes), "+a" (p1), "+a" (p2), "+a" (p3), "+a" (p4),
 		  "+a" (p5)
 		: : "0", "cc", "memory");
 }
-- 
2.51.0

