Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9F471246;
	Wed,  5 Aug 2026 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936995; cv=none; b=FwcZZzi+WhsqCIttVJ0jTHKV3NSsNLR9icRrwvwcdYQZUTl+tz/31mEz2hw1IZxmRVMhIqKukHUjLAzWAdKDTXxUqhWoU0tsvH+hQn55oc/xson2Wuxt8ySk2kTIzki44SPwjX3e+saPMkr9+atYBusmrbzf9fSXq91qQr96AaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936995; c=relaxed/simple;
	bh=WvWwluAbsDqLOkSW/ErGAusNFGzENLU55LhzlQkmwW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEBZYtH+areQOyfVvxqWt1n44gDs6MaJKuDG7tsIZ8mLCDkalKvjAujNDDIwOriffyiakK5q9aWXA/MQnnJLU2oZ8GBS5mEas5uCysY/98vH4DnzH9dCfJGXvMvNSIcfxo0qCHaP12oVQ6OVN9CIt5Do9qRXp8xq7wAsympD2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iGKY/1vs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iGKY/1vs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHv1f3725168;
	Wed, 5 Aug 2026 13:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=inefpos6pSiVn4XNrBI2MQDQnuGs2eia0DsLqDzsu
	E0=; b=iGKY/1vsYOnFKsNnfYPI+RLsFaZX4mGuFMbupRY3qPKLrJ0iwS6HBa12D
	rUaHF0dCQJp4BRhk2aEpqXm+I1rEzConGIvGNHvxG22h3qj5jx41WxjSWO92iecR
	zqY4qmHLgUiJgKAhzYsJbCkp6rranki+jzDnnBRa0HZ2glAHnO3QXW1oBRPf6R38
	kJzwx9w6IIV2VNQzXf1c0QnZMsruMTOEihMaNdJhNxUXoOrHsTocpfTgUVQHcSQj
	yhwVlngvE3PaI/bhVDItpsvKm/cL2xL1frQTIRKlemY1qpNHFTBAN0TdJAY9dgTR
	Z6aO8ekm3EkFReAMjvtLfxYHPm7kg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gavqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DQJI1019674;
	Wed, 5 Aug 2026 13:36:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6ums-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DaR8R11272642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:36:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFDFD2004D;
	Wed,  5 Aug 2026 13:36:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3FAD2004B;
	Wed,  5 Aug 2026 13:36:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 13:36:27 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] s390/pci: Enable CONTEXT_ANALYSIS
Date: Wed,  5 Aug 2026 15:36:24 +0200
Message-ID: <20260805133627.1216607-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfXwIW3UXWqH+Rc
 arBJiI0O/pRlPWh8QnUX5TCEaI5ZvHbckH2vcDoJNCDHtOW21B/ql/d+JfVGb5DIAkb+w7JUzdT
 LG++k/JVFPIsva+56Amc8GfsJagYP4DwvPo2eyGLzgd7Admx5ceUo6zpC3Pl8CDir5qinxx6k9H
 9F3CGN/x4ITZIiTM8TIZjFMWaDytgSE7Z2YpaBoReH3FoFws11Eul0VrhF035Ye34rySPnGUIG4
 WNaeSpFc7enyl17CVfPH93SS77RZPYz7mpy2oWetEXYcNTqstFwaUZlWYZkHZUB22D0IN8mtMB0
 DuDzlmnQaO705wPR/z8syb+0rWkKjl+qOINkCpBtVCaJbg2zlQ3FJy5eePB/2mIwc3z4hZfP66l
 Vne72xCRsaefKIvWELk93EkmjWjm94dQtLk6S6DrjIhOb3QJCqzmfFLB0Sou77SHPW1WSaGxuyH
 uiDc2o8yOO/nYcSj6gw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a733c60 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=-iZ07J-bdX_FhSQpWTsA:9
X-Proofpoint-GUID: zVcL2zbQHvaNl8my5rCIW1SmxM1ck_CQ
X-Proofpoint-ORIG-GUID: zVcL2zbQHvaNl8my5rCIW1SmxM1ck_CQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX6pH6gyH+4rI+
 fxN3rLAjFvP8vZzI653Kye/BE6JTvX6owZxkLLASKAO5uONrzuNWHnerpv/ba9q7dO5CjAF4DXP
 mR7tKYdK2L2H2358JPA+ltTUN3FTFRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050107

v3:

- Add Reviewed-by tags from Niklas to first and third patch and address
  nits [Niklas]

- Refactor second patch again to make it hopefully more readable [Niklas]

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

Heiko Carstens (3):
  s390/pci: Rework __zpci_event_error() to remove conditional locking
  s390/pci: Rework __zpci_event_availability() to remove conditional locking
  s390/pci: Enable CONTEXT_ANALYSIS

 arch/s390/pci/Makefile    |   2 +
 arch/s390/pci/pci_event.c | 205 ++++++++++++++++++++------------------
 2 files changed, 111 insertions(+), 96 deletions(-)

-- 
2.53.0

