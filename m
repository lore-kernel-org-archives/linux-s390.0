Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658C3B813D
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030738; cv=none; b=Y6UVoDG5I+3MU7jy+XotRfd18pk1wgGxjZPKoiM5EWnglBhn7Fe/GjbY9CFz3Gg2zeqk/RSIS9lsA/9Zs87eEyk86+4Bb9unjPym9NRQANH8EmaeVvriJRCIznDDYQW5vNETfDLpTpGnu7MWyclYd8Bct+4oDN8q2pQw6PRyaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030738; c=relaxed/simple;
	bh=/XDODQdtfzC0ietjeHbMHztUUWR7k81dpykMraacLHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thUMTdvCRlBGJfhMJQ9VwsYmQtIP5EPEG2qqsfF4t7OmqAkqAJn5n2d2rmDAw0BwmMHZvMgpCyYrG7dNElLRU0ohV5XW+G7nC5FQYvJFoSDbJ/6X2g7347rACP35SyPYyoDOEIMNBpgBWHaAKCDt/qMzijjIlPk65NRxADAbXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QuLzJKrn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QuLzJKrn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676En77n1079214
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FVGtxrtjmmoh7ABx2
	aHWUBjtO8LiX/VcP1yXa5Io3qg=; b=QuLzJKrnNi6RIxTwsrFEHbsII0Wyp9N2p
	LxuyNAGxSUcehZI956+ZCYgXnYcKKgCB8hv1qfNdq6uUzKf2lw4gHRlLp+mvERz7
	5+mrd0F75tfZifA21knT3Xa2NR3XfpCabFVHzN9EfRCM2/HimckbepcP9mlNH8t4
	geV+lxyd+KemQ3/8TaRh3hq5dnIRVKt3qpwxCwfg49tguk/iXXmGGeu3QbbNLvLG
	7tDYLdgmbFDyKYi5K9CHc3YlpVtFDx7O6Cu/TGdm5pmnboOm3Sy2CBvcCMz+WGAd
	Zaw8gMeaqvVnJEFD5DhajUziC+bHyrPEp4vzXOYdk/AWiShIW8IjA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr0y0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FQGOu023101
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kbsj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676FcoOp44368246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:38:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DD1F20040;
	Thu,  6 Aug 2026 15:38:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AEBE20043;
	Thu,  6 Aug 2026 15:38:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:38:49 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 2/3] s390/cio: Enable CONTEXT_ANALYSIS
Date: Thu,  6 Aug 2026 17:38:48 +0200
Message-ID: <20260806153849.2622576-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806153849.2622576-1-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aKmgVfRK0jd7NKUbnCWnB1pQ8_WtjHsc
X-Proofpoint-ORIG-GUID: aKmgVfRK0jd7NKUbnCWnB1pQ8_WtjHsc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfXyk/m4pUrUDC3
 KMH5mL9eOu/+A/L66UK5Vx7n1kSXp2dHWuVuYUN94ccbKhJI4NiSnJyAIoCa9wjBIxWgXRcqJtF
 dCXanVFw2BRNKT8dHFaGp2XJQQlhqK4=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a74aa8f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=9HfrCLXfzGtzVfHy6aYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfX1r6nuSd/9g62
 xOOs3zlqjcEgqfhYoVLZ7fkbHHZ72FuYfOoAIgP6CJWeKJpSz+BLBAFpb9cUsnk8o9lhkF1wuI0
 GC+1wd78YCA2T888PEmZSNAkvVijUUNrPNYUrJoOKtY1xOyQs1LFj3eJQ9BQG6kcJEt20GG6anf
 qihpyorZ+S9s04Sqd15LPZgD6/3EF4Lg+i+/a58yfpdPolMV3pZIAZ6ZierdjTq7pLwoQAwwbe9
 8z+vMeR4ET9gS4ecYD/DimYjZSERZR8XCIwxDUsNvvPSbn+lbNE4OnvdcvRhss7GgIoP6wt39RD
 HE71xYntbexV3dhwoGrNTHpAtyd00D/M0HFfnIVLiPcuves9OQ4UWD9ML22l46D0BfQYJDE8dsj
 zS7zV8taDLhG/VnVyYMcNb4911Jz5cbHoK+OJvV1gY17vK3YUxRP4/fHeJ2EYCa0Y0/m7/0Wgb1
 7c/OFu/7EX2sq254UWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060119

All cio code passes clang's compile time context analysis.
Therefore enable CONTEXT_ANALYSIS.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/cio/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index 3bd1c245183f..611a39103df9 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the S/390 common i/o drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # The following is required for define_trace.h to find ./trace.h
 CFLAGS_trace.o := -I$(src)
 CFLAGS_vfio_ccw_trace.o := -I$(src)
-- 
2.53.0

