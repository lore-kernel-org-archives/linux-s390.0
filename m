Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47A388377
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030737; cv=none; b=BT4xw7QVHnFePTmjueNuqXt3BOw6QfKMk+huMmIjIh6uhkizvEnzfI8ehcVIQ0FDB0B47lCv7frRVvFu8mEZX10HTRku5anXe5GUnORXLIZh4/vY5u6nazHCaD7fiGTHHqlD7r2GxGRmFsO8Uoun2ChqC+W/QVmd8Ht5Rq7JMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030737; c=relaxed/simple;
	bh=ew/tdCe9z4Kp3/oH3ES1KgSX8AwSn05/9VZQwzO8fhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=em1OE//DX15UWUdW+84qCYtb1nPNcK3q6M/Asha5CvBftqfrHhVHYJZYu2g+Xua8abdljgcdFHKTL6ca7m/CbkqkbJY/mHAoGL85Nrl0z9sqqd2OJFKf3P4S/10V+vP7DuNy1cVNLMaFPFW5g8OXrEPEoJFpfEQzMKP6H/rW2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mCQB5vfS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mCQB5vfS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676En7m12939480
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=X5cf+sl5YkqGXtNE9R/5Kal8DEp0i8zxG4K4CAgfe
	go=; b=mCQB5vfSVdiryO5vssEa8TlW7mpqP251sXkaN3+Tq7DS+XqmItGocrg9g
	s/O0834baBefF0IvfUpS1/lEuPRxjMqyb2Mt7J6VwVlgjSDJlcNEvLcpdICm/QbS
	JN1tZ0Ot9dZnHGfaDRkl7RFCke97hkeYGIJtVnf0+8yLD/o9IjBzya0aPkg3TKPf
	aHKEDEfs3/DBUKVAS1/MQ9B/JY3wEnUISuCmwsuGFpZE+di0l876AwrzzYf7/2A+
	iH1rNXA0/FCvNDOtoka/1Zd3AFwfDeJCky5UwUwkYzf3MfIawJ4F6AA0gx6ThjaT
	qNoBuJiy1WZpocfxZO5hKqEvVXvjA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a4918v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FQJo8023187
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kbsj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676Fcn9432637416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:38:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6D1C2004B;
	Thu,  6 Aug 2026 15:38:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91D8B20040;
	Thu,  6 Aug 2026 15:38:49 +0000 (GMT)
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
Subject: [PATCH 0/3] s390: Enable CONTEXT_ANALYSIS for cio and virtio
Date: Thu,  6 Aug 2026 17:38:46 +0200
Message-ID: <20260806153849.2622576-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a74aa8f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=HEItrW3CptduLfhL1qYA:9
X-Proofpoint-ORIG-GUID: -tm7iCJ2osT45cSoQD7nqr2iFa-GpBBk
X-Proofpoint-GUID: -tm7iCJ2osT45cSoQD7nqr2iFa-GpBBk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfX6ddNHpqm7MrU
 QXzLpiE8toeZSftxQon/ptrFZ6wtKKUbv5c6SIeuqXgR6WeP4mKoswSwSj1ObPnqO38cJkXnKAR
 ZVTigbTiik0XM6v2puVXVBJjQFGPC/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfX3tHous/RTBUW
 FsSOlU4W0dtXS3qOQQJ1epGM1hpSWzevH5QWlC2XQ0LD5F2u95NfS+DgFgQacoV7c+rpMaTTdFQ
 71G146IQZM/0aCnuaNzg/4+eAWDYTfHz1i87gda8xdAwSjMabBt4tZlBl8w9lUNKxL2fzA2bUtJ
 YlXFxG1lvwyaZcD5HHssNLW9XwQTbwknTvhtDYPbSG/v7pCuoCXvr1eJ4eeleoWm3qA/XBu+TCU
 +WYcprU8h3ElE6aSvVUF+XOMKfFt5BHu2frAcOVK1kMscSkYjjYHrdqLyGJ1tR4zUBVvqVTcBz5
 apHrsz96TXRS57yV39Teyfm45ksaaa0m7ioXfkXueVBTMsFplhUZDMgicilAoffGvuFKfs1GcWb
 UolM8RUz/K1qNdufgXsSralW5PITJQ83aXG99Cfl/FLBXF2oe7jSLjGs3CVzFVDQpT1wa73M4Qf
 ccgUalJKpEXMKKb2Tnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060119

Enable CONTEXT_ANALYSYS for cio and virtio.

Static code checking for acquiring and releasing locks used to be done
with sparse. That was removed with [1] and replaced with a clang based
approach [2]. The new approach requires that each subsystem needs to be
explicitly enabled for checking.

Do that for cio and virtio. Add a __must_hold() attribute to
vfio_ccw_sch_quiesce() to address the only valid warning.

Then enable CONTEXT_ANALYSIS for both cio and virtio.

Christian, Claudio, Janosch, I think it would make most sense if this
goes via kvms390.

Thanks,
Heiko

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")

Heiko Carstens (3):
  s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce()
  s390/cio: Enable CONTEXT_ANALYSIS
  s390/virtio: Enable CONTEXT_ANALYSIS

 drivers/s390/cio/Makefile           | 2 ++
 drivers/s390/cio/vfio_ccw_drv.c     | 1 +
 drivers/s390/cio/vfio_ccw_private.h | 3 ++-
 drivers/s390/virtio/Makefile        | 2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.53.0

