Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA52E7379;
	Thu,  6 Aug 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021268; cv=none; b=orciTyDmgyh3PizeIURlOXleiV5GoTyXmS0036MxyZuHUenAo/GlEU7oGO/93EsMZOno7wgaRKJoHrq1ruThACJHNUX8g3Obc4/DH1WqGzheUBG5wTsSlSgHWsZD5ErGPaCGwyZXiRsKid6rvWwWwWYT+OBuseyxODZTOKaadiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021268; c=relaxed/simple;
	bh=F5GT9Rbi4d327sLl1rJzXVEy00YxfbgFm1shPDeOcQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZagqFUzpLjXsMExTyWmszVtwlTZ4ylP4fuzK4Rcq5RdVf2xukhqx/sQrowuFNsdLoFHEtly1zkhnCCMmXM3IW8Y60u8DKb2xwrm3HmCX2cDXkwnM9rob7nNfXER+EyM0mR7qeUs6fMZI9w1R/yGEEKpqctuQ1rv52/Cu1aZD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=snTDP46+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="snTDP46+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Cu8Zb994634;
	Thu, 6 Aug 2026 13:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PLx0ia4AR18ACU1k2Aycyrdqbb3tHyhTo6UR488Kf
	uo=; b=snTDP46+vnJI6g7R62KdOKg7HtgGZ7iHXh4dArwgb4Vc0XvXGmMAWUT7H
	VLwZQcnA/wJctpYKzRbvrdCkCBEQZF/3PYU8bGdelIZs+hNtjUJfa0zsahVGKdOY
	rqaKjKRC0GP1xbwU7TkC7TPjxRDtEwJUtryO6B2j/1HPoT42dNacHeXc7/kTRwqO
	nChRnXJef7mBbih9bAtPKxgLFk4FbB4G7qN83gFT2JwaPSdbpqPr1wdJLchBlrL6
	KGuFyqaU+BQalBvyBjRdUN7Rr/OGUVnWAALVcIMTujFsphx1gRwE7pVGx6IFTF5P
	ymms4C4p3tca4kX8P1IWwe5Knib6g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gfskh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:00:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CuIjj002189;
	Thu, 6 Aug 2026 13:00:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgk111-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:00:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676D0ofG32375156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:00:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C729F20063;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A34BE2004D;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 0/2] s390/block: Enable CONTEXT_ANALYSIS
Date: Thu,  6 Aug 2026 15:00:48 +0200
Message-ID: <20260806130050.2057443-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX/s+Q/XKfUaSW
 clUK8M9S1H5jsz4P6DUN6+WVNa+RkFpMy03phQ+qyy9CXYFteJH/1TZRtHaQ0L03coxj6pP5XwW
 Wqh6Oenz4XQhVFAyVLD2hH8IkEynCbc6jACUN2TaS6Q7VjyG5NdX12skyZEVowqN+ol3mAIkkpG
 xNIeQdfxaNO8yGJT6yvNroJT85TTIJ+v9/Uw2rA9CEpoB/gzfho6v3hEZY9HKHmawPlrNenyNqg
 qcBr+8//boxB8PA1u4qD0j6tvwKpVghJycO3S0x2UsmqiQysFTdO82Jq95n3ql6f9uhHjpM/kYR
 6sBj7SCkUkRlDgZfx+oHPJ75Gedb3tGOvVs1CTGYIqM37VlsFJhwPXxDMdoyL5lkCv6TjtWFq/n
 GmFkgn9XNlLRmiK8i8AkV0NTHQ+AuHgK1z2ErMq3pgJi0t73yium2Dg//qLHziJI30Qa8Fj5/Q+
 1nJRY747Ha0rKVeiG0g==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a748587 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=jW6YlCM5X9v_IRLvDUIA:9
X-Proofpoint-GUID: in4MxkECu7ofGjLIy2Rgsrz2I1pvSTsD
X-Proofpoint-ORIG-GUID: in4MxkECu7ofGjLIy2Rgsrz2I1pvSTsD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfXzWArk5LBUgIM
 fpUpt958P1jDS+Q//e5ZYrmLH4qlKVADpDUmo+nGWpmxDsKaLAoEInLPjZE9FTK0fCD8VnSj9m3
 Ej4kOdmi6tgFyD9+jUV38sND492fuBc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060101

Enable CONTEXT_ANALYSYS for drivers/s390/block.

Static code checking for acquiring and releasing locks used to be done
with sparse. That was removed with [1] and replaced with a clang based
approach [2]. The new approach requires that each subsystem needs to be
explicitly enabled for checking.

Do that for drivers/s390/block. In order to avoid false positives due to
conditional locking, disable context analysis for specific functions of
the dasd driver.

Disabling context analysis for specific functions keeps analysis enabled
for the rest of a file.

Jens, if you and Stefan agree to the dasd patches, I think it would be
best if this would be routed via your tree.

Thanks,
Heiko

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")

Heiko Carstens (2):
  s390/dasd: Add __context_unsafe() attribute to various functions
  s390/block: Enable CONTEXT_ANALYSIS

 drivers/s390/block/Makefile    | 2 ++
 drivers/s390/block/dasd_eckd.c | 7 +++++++
 2 files changed, 9 insertions(+)

-- 
2.53.0

