Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500D4A0F02
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873512; cv=none; b=ilxe4LHJrNNCoM1abUd7OgFsUHir1b162W/Ol73p1yThBv8N6Hd256Og4RXOfyutDcJuTNGjTLU+iQHUigbd8GjwXIrkxqUZRdsjEy9W5nK1tMr+i7pFo7Fe5wCNhc5e+zIIZdjvw+0I1YeQtVHcrP8nqwjjPl3Ku0s6+AHqfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873512; c=relaxed/simple;
	bh=Q/OUkrOUA+PnNQCF0bfTvl3tdhqL2qeLjP6PYE3EEVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6yXxazuVq3PUbffP6XPYc2D7OOsophGiKqU9qmNBj+jOcIKNhCyxk9Opa46+QbDRd5iy5JUhQtJ3sPGvu/HE9AhpxLqe83iyybL8XKLpjS89df32HV9MQq2ibBMxQFuoCSKc2VzRYgDDDEpAKtsSOzBQCqAH2S05j+EhGSLyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P8+1SkMm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P8+1SkMm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688D1YDv1003558
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 13:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SWkbX65IJw+YpInJsNU6I0ACoqYC963iwUA7XhSnB
	Rc=; b=P8+1SkMmaMF/akQ93jW4ldh3PXhYE0hCmRz03Y/WuylW6QtfP1xxvqBVD
	oiX7dL4ILopN2UgqdoSoiG4mSk/dzfuwKH9nNJDgkZfdpi+zpYkziRDdqfDGOeXM
	NAP8vNrQSb4pZw5noveZOJC64pfttmDKv9e3wLgKT2E62iDZztka4bCWUb4WQKXx
	cO7svF4jpaoJ7nJfuXvrtyYZetnFYCP6FofDK2sUo1xsHggm1TQlWc5405WJ34n7
	0kih4POPrukDkZ7f5a41zEtllXI+K8s4lYVGqebtj7QLZ0iPE9GfIuhsgbe7wwQB
	YBegUq1OSBCYd9vq9Bl5O/tBdZHWQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhexv08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 13:18:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688DBG12009374
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 13:18:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqc4wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 13:18:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688DIHG328246538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 13:18:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 937C120043;
	Tue,  8 Sep 2026 13:18:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3679420040;
	Tue,  8 Sep 2026 13:18:17 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.138.252])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 13:18:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 0/1] Fix and improve zcrypt reply message checks
Date: Tue,  8 Sep 2026 15:18:15 +0200
Message-ID: <20260908131817.17644-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IzIR0S7oeuHxEwWPUFlxLF3leCzODZzu
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa00b1e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=A0JRhSI_t6n0dhEY3XcA:9 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0MCBTYWx0ZWRfX24eMeE98UBY3
 NuFu1AGG+Kg/HrvSqej9p4o1PZMOIaYCjjI5VySgkQj32ffq5Zr7BL2OlBpc8F65LbrAwuhgQAq
 hALoWvN5zROC58NF4N2/QCgF5xsVdN0=
X-Proofpoint-ORIG-GUID: IzIR0S7oeuHxEwWPUFlxLF3leCzODZzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0MCBTYWx0ZWRfXyeKn4ZFS0fe2
 JyuKGoU24kqNyCzU0MwV2WLLvnU5Pyp4Qv7EXz2o404J6C0wL/+WWoHNURf9rllD7yhCZw4pdg/
 JsCO7vJ6oiARGUthR0uJOkDrE3sWVffs8WMU9NV7BDVjxyA36hmahR8/+J1omq2O99zEplE175q
 6PFJow09459NKcuTg0BASc58ZWCEo0Tn5BgDQTvEwc+gcvSWRq1oFKkUouUj9XO/eDEnjWLhYrV
 Vro7Pi7z+UoXObYkrCeg4LHLhpOU2r23T8O4WmZ4BNrVZ1f4UOVXpDUN9kHRyJDlMYmE6ihOBTo
 hEQr4pV0fQqIbS6i36Kz4ZxWf6r0EmF7LzAcJTAm8R6exOFq7Ohc2XjQ4JiJ7O7wK7nYX9da3EP
 pktKgj9wEu5orx13jufeiqyL74kZXQPgxboDzADg5xvYi0VHUE4fpsQCjmBOBfoagUCciuwFJZU
 fR4J5yOX4C3Tbg2BaEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080140

Fix and improve zcrypt reply messages checks of type 6 - CCA and EP11
- and type 50 - ICA.

Changelog:
v1: Initial version
v2: Sashiko complained about not checking offset1/count1 at all if
    count2 for an CCA type6 reply is given. And a check like this was
    in place before the rework. So now offset1/count1 is always
    checked and only if count2 is non zero offset2/count2 is
    additionally checked.

Harald Freudenberger (1):
  s390/zcrypt: Fix and improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype50.c |  40 +++++--
 drivers/s390/crypto/zcrypt_msgtype6.c  | 160 +++++++++++++++++--------
 2 files changed, 136 insertions(+), 64 deletions(-)

--
2.43.0

