Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F982E2852;
	Mon,  3 Aug 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767355; cv=none; b=hFjv+SIfvjcAwZkzfVgL5pLYdjHBSMZdAox4efOAk3H4nKe2ZU+zOryiosLdZf9sxNhf8pZ0VcYoZy3MhXr2PPMxevfMCtN2RAm1qHAZMqNpoN2YGO3HlRlMGenR/fmaOqjRIEzoJwP++6JCD/uaa8rbArFjgUgW8l+sdgzmIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767355; c=relaxed/simple;
	bh=Uh8U2G6Z/yPEiIbN8PX+qBhcNii0qjI23U2seWLQWNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axhX5V7RaNAsPq7N0BnnQLBYYw0Oll78KxPBQ8iaiE+5NW5HSz9VS6sERlxnjNWYTX/qouNWSF/sWd9iExAL4iEEnFLjBJHB742W0fhGkfnJzDdbs/dufwC2fzYc9u0Km5bkk3liU2roXxtD7viI8aqBHMzUeq8pYdfM8xxSccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n944bEVD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n944bEVD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHr2s2341591;
	Mon, 3 Aug 2026 14:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=M8ZHqgDji8/KqPlrIIxihA+CVQlnlC51H1nD5IfZp
	UQ=; b=n944bEVD0ThkgxLDV4dLm/uflVaissV2Laow7LbtUvrLFsRdJloLknvDh
	oymFlUC5QkvkuCNbiym+8w6Doa5QvpewNtWpXHarv2/+ehi7l9LpPn6BbnfLknwB
	b3ABhYeHb/4s8Gn/5s1vsyfrmrCdfW+Pu4M+TEVvgFLBJNc09IiiUx3kXT8rFsUC
	jPl7yw6SzOUiDjQuy+7TXbQ8wjdXPIT6Y6kg0v8m+2PQlcTIJ6NAgu6RTyk+oXV0
	veXqc/AkwnYZ94OHZ1+cVEY5s7/8u0iL6Yd/cIZeisxp/WTPxStzXXJUlXWA4LNi
	vv8zuN/T4Cc1eByUxcTp8o4U3/W0A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eugwjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EQFBM009288;
	Mon, 3 Aug 2026 14:29:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5jvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673ET8n227656708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:29:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4736920043;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EACB20040;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] s390/pci: Enable CONTEXT_ANALYSIS
Date: Mon,  3 Aug 2026 16:29:04 +0200
Message-ID: <20260803142907.1771509-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VG7hvzJlFNE7TuPL4-ZvszD6TSDSG0Ee
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfX0IDf6oCI+bp9
 bUfWCWw57jHtAx+Q2GofuDshy1o4aPXsuIwAQj+D+AF7RxbrdpVNO9JWyt8n1+iLeMJY5GvOOj6
 i5S9HwTDlq772Th0LEN7AImjt0Ki1Z0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfXyoeP71NbrQJI
 SkkB6CjO2OGLe/KLLNE5wWE10vMIM3+I8GkJ2T9GGL70GVSJqfKqQxpHuiV2vcJM+hhqQc1TkkK
 oozGygeIQEwCQdHJEFBUDoiAnXKujYp0vDRxgL9vzmxdDQzB9it2FW3lH6ppmxVFCVfxCMpXoGo
 uRN6SFi+VvrvtuZL0s+PzYGvBdBm+3MLY10tK9cd7ULZJA/S/abFxEm7zMRiNZNE47wEpBGE47F
 g+fZ7xrPUuuq27z8KSbAFnOdhOhweHIw+JzIswJF3uAifQ/ATBO6lRiiIYCiEDg8WuxwAorxk09
 Dnn1Zkzc0i+VstehlOicsLjCdyYVEW8W4bX1x3m6Uc3FAYUSekA9hBEOLgKLFyBOEzng9+zVlzO
 sTs3DRoeFX/YdRAToqZsDngzuxUFzO1HLW1WOIXpC1C8NZopignUqAHVm4jF7tB7Pfx1u0zkcLn
 0+CqMfAbQKqervZuVug==
X-Proofpoint-GUID: VG7hvzJlFNE7TuPL4-ZvszD6TSDSG0Ee
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70a5b9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=nvFg73JcvTBpR_9UBFoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030128

v2:

- Address potential zdev reference leak (false positive) by adding a
  comment, and moving get_zdev_by_fid() [Sashiko, Niklas]

- Note: this reveals a pre-existing bug: zpci_remove_reserved_devices()
  calls zpci_device_reserved() without holding locks. It looks like
  this can be fixed easily by adding a mutex_lock()/mutex_unlock()
  pair in zpci_remove_reserved_devices(), but that is not within
  the scope of this series, and up to the pci maintainers

v1:
Enable CONTEXT_ANALYSYS for s390's pci code.

Static code checking for acquiring and releasing locks used to be done
with sparse. That was removed with [1] and replaced with a clang based
approach [2]. The new approach requires that each subsystem needs to be
explicitly enabled for checking.

Do that for s390's pci code. In order to avoid false positives the code
has to be slightly reworked, since conditionally acquiring and releasing
locks does not work with the checker (besides that this is sub optimal
coding style).

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")

Notes:

- More patches for other s390 specific subsystems will follow

- "Pre-existing issues" reported by AI will not be addressed in the
  context of this series

Heiko Carstens (3):
  s390/pci: Rework __zpci_event_error() to remove conditional locking
  s390/pci: Rework__zpci_event_availability() to remove conditional locking
  s390/pci: Enable CONTEXT_ANALYSIS

 arch/s390/pci/Makefile    |   2 +
 arch/s390/pci/pci_event.c | 151 +++++++++++++++++++-------------------
 2 files changed, 79 insertions(+), 74 deletions(-)

-- 
2.53.0

