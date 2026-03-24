Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC23FF8A4;
	Tue, 24 Mar 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366137; cv=none; b=Rg3PcmsjAji90fmKCJX4G+yqnvifmpAMtp7kEMCZdhSHqJdNYBy+6iG0Xmb5t1aVWlXlOcoSOjXrj/Bc2hpdTlku+Q8i9VjcQt2s6snNUdUKyMqy7KzILnTrjClnOdQMmkabzVGoGB1MZRNL6v7+khgGSVcv7buO5wApaTtMpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366137; c=relaxed/simple;
	bh=9vy7W2fu8hHH6CXHjattdY9RlyyS85wBHOadJqbgWnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siQv74XRfQQpqMJLWViqTShGeJUKPfA0jM0RMA2BORm31GsJyCfc6SKpLWb9LxOKqOcrHbFYZNAdutDAZXS0X2QbC4RbLHQZPeQXJl1aO3491yJCj8zsVdUQQ+OSJQ+8w6czPMMf1DtBKjBdFqTGvIt6jHB0rwr8o1Yji309rJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QiHhg8Ay; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QiHhg8Ay"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OFOYSG3819926;
	Tue, 24 Mar 2026 15:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZkMluc
	Ak+JKGuraumUD9AUxwoWEhUQE4q/Nx36yF0rk=; b=QiHhg8AyU+4qthO9ZxgxfK
	sYN4dILSZBY/jR01KaiAVJsPqFc9cIB/euAs8XVLFQ4iadopDiEcGS56d99CKqXk
	GGD2S0txmY9ZnRWnrr0i6JciRHLz1HnCPmUixh6Lb0y315oPZs/+ac8ynrECR3Gp
	4Tp0xd4Lk77GD8ul+zlao7vJVfCQjipfu/ARtXr6MsYfLE3NYXIa9WRemDmgwSW9
	ATVbZWNExX3T+PgAjKSse3dOYD/ciLJMPlvvbAoe11ZrxQ8w+oyrty0h0WJpp1ax
	Yzbz3jR0uyoUGwihBx9EVkUrXbqx3XubnXEk9mexs6Upj+lkaWEQ6WVRcUoiSm6g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxv7u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCRgdk026695;
	Tue, 24 Mar 2026 15:28:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kte6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFSlps12321202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:28:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6260520043;
	Tue, 24 Mar 2026 15:28:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB17F20040;
	Tue, 24 Mar 2026 15:28:46 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:28:46 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:28:06 +0100
Subject: [kvm-unit-tests PATCH v2 2/5] s390x: sclp: Remove unnecessary
 padding from struct sclp_facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-vsie-stfle-fac-v2-2-5e52be2e4081@linux.ibm.com>
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=748;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=9vy7W2fu8hHH6CXHjattdY9RlyyS85wBHOadJqbgWnc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmH1q6ZzPfl96p52+eu7Q9KkrjQ9+rwcUbtzJC3XCnuG
 w3khYJFOkpZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZiIxBuG/z6F79crvP+WuU5d
 0EHJ8V2gtveR2byRlucv/3LZHhO/XpqRYcLHj4d0LSfkHXLbr39x87YvL5sXWXpMvbcuxlZjefr
 b9xwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c2adb4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=LqyZBc1Dag7_ZHf_o-UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfXz9tBD2Mx0lSt
 vroioarvBh0u4NrT+7MH7ASF2FdNQntAfGX63vGzLurGzuA9YoaSxqaUXHjIP2p6OXHP0/x9vWd
 dlKG6KtLnMiKI3YU63aalc/Ku1QWAMBk40J7C5IkZ8LhwjGifxBaz/joOiBFlvfpYmJ4Ibpej78
 2bmICQ8MUagdqL4r7arT0VUIM6IdyIRA1AT6YdNdc56X1dQLUoVxyA3bNT7PqRz4lRILXcErWoK
 yUuLzCBkpxsPoAfAQJCREAfkkL+RYh9yFDtfKdfkm0TaZAv5L4pTkQRYAjkzP+tTeiY8LeiUyOt
 D3HMJeQv6jMa0g3w14Vzh49NHoAUz5wYANkN6GY+sLjGbhWsHAhcc1XgR5PLPQM87ZkeCWWZhGL
 UzB62Lbj+zBGN0vaLneH+6eCumL4EJj9xR8Qqpo/aDf1nlhU1hlnmfOZ3wtYjSY27cJ01czcb93
 8WYoomugKhA7CFCzhwg==
X-Proofpoint-GUID: JX48zSok0m-Z2axGu_VIw_6uZS0EJUrk
X-Proofpoint-ORIG-GUID: JX48zSok0m-Z2axGu_VIw_6uZS0EJUrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

Struct sclp_facilities is only used within the guest to keep the facility
information. Nothing bad should happen when the struct size changes in the
future.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 22f120d1b7ea7d1c3fe822385d0c689e5b3459fe..42a2f2e9f25a45d3ebd71729df0d9d6d93a4fb50 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -132,7 +132,6 @@ struct sclp_facilities {
 	uint64_t has_kss : 1;
 	uint64_t has_pfmfi : 1;
 	uint64_t has_ibs : 1;
-	uint64_t : 64 - 15;
 };
 
 /* bit number within a certain byte */

-- 
2.53.0

