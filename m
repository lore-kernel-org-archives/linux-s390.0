Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D6430B96;
	Mon,  2 Mar 2026 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458510; cv=none; b=NdK3drcdYBXNkAat8tyYazBDFMEJE1J4enMIsJs0WgdR+eKIqdsiiSfz32yIm4ynmiMZixdrjqA6KbzqLKvPygZmctLLRHKSoLRNpj2QOzgDLNMiDGIv0jbUVKRfVShpjrlmnMx6anyhyvtFeAkT3kmFbdkwmEUa2qiPbHUt4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458510; c=relaxed/simple;
	bh=mv5+7kt5HV0bzU0mezn7Lju8IMvn15UcRueGYkkBYx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSJ/aqMdZjaJbJY+YfQCzVuGT58sFxDM3vblebzUXUk4Vcl7c9g+eFkO6MDkMcaoru07mGWhEwWG09iL0Jc2XffwxPVypXuJ3TtfAcjP0TcDMMBiJWZ42F4UDgjZnt1WBrtLSsviXHyG31e9xS7FbxFscXATM184b68oUjQ/pqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MspKK53q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MspKK53q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621LsAB32069251;
	Mon, 2 Mar 2026 13:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DGz3KL/JZwemoigN4erBxCPJY6d8y1yUWZmTcKezM
	wY=; b=MspKK53qWQ92mmUA/zp8gid/ooDMp92HFauZnethCwx3RyNTDkIrfGfwn
	8d32KPiZRnzOAi35eY1evLCCWXHmq6sDbgS4zp0ZEY74Z+jv97/tkceYEw5hpklA
	IJoRhUjKA3I1vfRQ5r+C/UWio+K1qVrfZjByPi9Eqw3bvEG0FYSxdk6bklYu4uE0
	6ogTx2pKR6A0r43COqtGbFGMcG4q09yGNg77gA1wKY494eVhonkEB+TS73cS5TSY
	ByMfBitP5XYAnlTcTwTOEoSprfpeS9XvxTwVyTrGwJ8uS5/F13TBQ9zVWfxpDxSr
	9obgdCd8QxevwGspormpMf1c4xs4A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmemdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622AsCV2027710;
	Mon, 2 Mar 2026 13:35:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj62gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 13:35:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622DZ0ml43123030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 13:35:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8619F20043;
	Mon,  2 Mar 2026 13:35:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A3DF20040;
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
Subject: [PATCH 0/3] s390: Fix and improve inline assembly constraints
Date: Mon,  2 Mar 2026 14:34:57 +0100
Message-ID: <20260302133500.1560531-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExMSBTYWx0ZWRfX5IZacGB8lFNe
 P5ZDX5E4lCOcZSfYS3AgCwJ3lsF5T3lQvekms2mVcYfnpW3RvmtrQWTyYRdqJHcMB3/VZ0nD3de
 HYMw9Kud39fAxjQyWGhcywplMuSSMPDKLq/YmBLtd3rN8vrh9SNsQGgxeHU6iyHLH65AiTVNny7
 Y4vCa8xkq1grn9Ha00RKWkbfG8LPHs3FWAISQJqumK+eFOGkvrYt6YlWTSJ6al+hX0jh2/jxToG
 gg4xD9jORQOyDPD9rxoCaQPCQXz0d0nhfZZwDE/6wHB6mCoXdbYUbfq4tVsR9Ap2sU58fl1I5xj
 5/ByDQL6qqqZDzmb6NV9/cnOXbO5NF5k94eQCJaol46YCHHuLs8pnQgbHDmEMr9CedeWoSpfCA7
 YNJyr++jeykwvXNVpc0KvlgSijHQr0cHwPvyG5rAgBfYfXl422aSzJ3slLCbAuVbabWGk8OWon9
 vUrwooGqkji6rMLw3CA==
X-Proofpoint-ORIG-GUID: AITsK1aQkeYe_LfGYA2TUXVgrt-E-HKz
X-Proofpoint-GUID: AITsK1aQkeYe_LfGYA2TUXVgrt-E-HKz
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a59209 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=e5nQhbaxdBwKb3TcQO4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020111

While looking at xor_xc_2() I realized that its inline assembly constraints
are incorrect. Also the inline assembly constraints for the other xor()
function look incorrect, but are not (execute instruction vs register
zero). However that revealed another real bug on __stackleak_poison() with
another incorrect inline assembly constraint.

Fix and improve all of them.

Heiko Carstens (3):
  s390/xor: Fix xor_xc_2() inline assembly constraints
  s390/xor: Improve inline assembly constraints
  s390/stackleak: Fix __stackleak_poison() inline assembly constraint

 arch/s390/include/asm/processor.h |  2 +-
 arch/s390/lib/xor.c               | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.51.0

