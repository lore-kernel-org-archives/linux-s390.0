Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800632AAA0
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071985; cv=none; b=tX5Wj5aTvQs+i7QX65eyL2sbpR6pBxk/KFLQolPNQOppgvYGRZUX3GDVyF+1jrWzrGTnO/J0/gEN7WnwqYu2FGnRFDfe0Al7MYw/bMxBUUtkJ2NggyspEfxa/jmhzp8AHtVVvXSRmTddeyrknH+HqgR3HAJomRE1KLg/RokSAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071985; c=relaxed/simple;
	bh=lvwFpqjY2d9KWKlLOufo/X5wU7lZCutBovq8RLc9cM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pG2Tb/ISgV1BJuaDrVcw8Dk/2Q/mngH+YK9V4W2YrSFLxQDI47B1COqMBKmFZsWcZpOz2HSKRgD14JGLWIIiNMRtpoQwjEOitWqbJOvXxmkZq56uI1cviebODa+HHCclGEeyYH65+O3yhHfnku9NM8HfQ0CuNIp6UXBfHAjzF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JQhpCUZj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JQhpCUZj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IHZY1813622
	for <linux-s390@vger.kernel.org>; Fri, 3 Jul 2026 09:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5zlVFefe+6X4QCSA4m1+7OkE//5yLSFTTT3P0PhTh
	1c=; b=JQhpCUZjQlp80yYYWr3ZylS1wgj/D5TjwRYWuLFDS1sMMjAd1sREkX6FG
	y5bh4aDI7W+4un64O+UUF7MSd9JAAvvxsWAfJTCKadW2Ylykj8YTxQ9IqCEPZZBk
	ErjpDioHOwFiFscaw3tTsmuufgk41bflIAs768R0aP3OzCNUG1CHhJi51vF/VAZ7
	V38bQQD7BDFzve6lXF1FzMORi+CcYMXuPSluv394cygMPVKx1Eeuj6z/AYxEbIK+
	tWQZG6mAMCjC65WcyakAXszuHf7LIa5V/Kd8spfn1haTjCSyU6MiefF7oVuXbYOK
	tHtm4Ra6qV51sTCdUWAkZGfcHttJQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfdx95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 03 Jul 2026 09:46:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6639JnXM003119
	for <linux-s390@vger.kernel.org>; Fri, 3 Jul 2026 09:46:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukg6s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 03 Jul 2026 09:46:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6639kHDe23527934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:46:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1278C2004B;
	Fri,  3 Jul 2026 09:46:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E83D420043;
	Fri,  3 Jul 2026 09:46:16 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.193.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 09:46:16 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 0/1] Rework pkey ioctl functions error pathes
Date: Fri,  3 Jul 2026 11:46:17 +0200
Message-ID: <20260703094618.5916-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4784ef cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=yKOuWFisgHkgl6CRz08A:9
X-Proofpoint-ORIG-GUID: HyFRFaCwrZb9KUFnPhDBpfciQFDMhtTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX3nds7OgIR8Wv
 78qb+kHC0bSNGs71isc7buGI1QGxEapOrVmFhhpr7fAZekp6FIgUmudBZQGCMMvoNr8PNEjPVW0
 k8VZM35znmaudIZk2ljDxwz/fGQJDUw/VmX/FuPVvPD70dwJQpUD5uV+gpXdTbpeEDgh2zScObd
 v6YnB7OlUSt7p50I/Fq9GIGxl18asWsk6aPJu+EVYZRMhcD3USKw/nZF6IpLCMViZoPM2BTic38
 ybwQWvwcRGyApKCDSZtIwJS4yW0AH2O2W7UKBp1i7zmXTwDwyHRPueNfdsWercz81gOHgeABveb
 hTYkB5ZsdYcJm96InceZdxN2pQOta51WnLM46aQLQeBw5ehLl3BaWS7yA23MMmRcuP925pesoes
 A8LrctCfk8d1yLvMXxoFwHGcE8f6zgNYCf+cAuc2KVPnhgRDOHYrXEZvaM5oXfkfqzifsCyH9f0
 Hbagj0ju0GLrsSj/f2g==
X-Proofpoint-GUID: HyFRFaCwrZb9KUFnPhDBpfciQFDMhtTh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX+Q3ubOfGXrZc
 n2Y6A7Qcl3Fj1UE0ohS6bziCEf9UY63HPkRWcbGkdJdRqytSyHFH+GXXEBLNtw/TT6BrdPDjwOH
 mykQyJG+41bKJ02XsbddgSiCllVN7/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030088

Slight rework for all the pkey ioctl functions, especially related to
the error paths with regard to free memory. This patch removes all
this duplicated code and introduces one code block at the end of the
functions which is jumped into via goto out or executed on regular
exit.

Changelog:
v1 - first version
v2 - just a rebase of the v1 patch as the original patch did not apply
     any more.

Harald Freudenberger (1):
  s390/pkey: Rework ioctl functions error pathes

 drivers/s390/crypto/pkey_api.c | 272 +++++++++++++++++----------------
 1 file changed, 143 insertions(+), 129 deletions(-)

--
2.43.0

