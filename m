Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CA34BA28
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731118; cv=none; b=Zs2S2ABG6E6JfLLfJEZn1zjGhOctqynbqkjtcb34cJ5FP+s2ukGPn72jadXDpAS2MQvSMh+Fn1xIUNZCxHIuS7pSwQ2u7CR4C0t+nA+bZFuQ8ilo7k9CvN8AP2dxPODMF2LWTPXCqMZ2KP7smwzbeIO0WrA1eM7VfM/ViKo9igw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731118; c=relaxed/simple;
	bh=iD8hK+lNAKg8nhNT9pU9AIDJe8L6OX3z3tqxBvtYeUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pf+YnTZWnuHPD3uX72e2n3DnM+Ny331crqKIE+yK/+cWvSQxBMoowR/uAvO3QxNDZFG8rRH9prtVbwTFtYIE0aJOMIsO63nblaHS5URmuOXiUy1N+GZUgqM2mSHROc9DN+NfuA+Z/48ci+jgNpjnc8UpDcGgv7f7DMiG3yOP7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wt1l76ht; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wt1l76ht"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDfn8G4182132
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AKvqo1iTtq2Jffx5VvlHVCjp3L911Tf9gcg1+0gQx
	Bc=; b=Wt1l76htRma5KmYEbjdAVK//LVMq7nu5ST9GHt9AoKpBVLwfz99y8ryo+
	wcz9FARTSIX0/0d+BtSaYYqRS5dvgpgDRpvXkrTMWNLVSEJGTcAbcH4hSUvjbH/Z
	X2/astkUzFCzBTWKm3Q2RnNpUoTSXRDMcyJYgdAMPvAS0Q9CCP+IAxyznL8lM9WH
	ntGII1Y1KiqyIKuvQojdI1ZDM/LF5FzBxY/qBRNJ1t/jgn8675Uen8TERS+OOvHl
	7nvh9FV6BB/9YRV7TfJriJ4tyRIp1v/902koGFBR7CGfYx8CkjH08TUVJnN18QNT
	oOd8OXUEwnvo9Kwp42FiUJN8zXyuQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78ga73c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:38:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MEYcJb009672
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:38:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq7x6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:38:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MEcVKO60227950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 14:38:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70E4D20274;
	Wed, 22 Jul 2026 14:38:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5618620273;
	Wed, 22 Jul 2026 14:38:31 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.200.113])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 14:38:31 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/1] Fix wrong domain value verification with EP11 cards
Date: Wed, 22 Jul 2026 16:38:30 +0200
Message-ID: <20260722143831.109929-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzOSBTYWx0ZWRfX+RA2TMPTcIW1
 cPrgP1Vi10kOwEQgfVz9bUVB10nfIC6WVjGwJ+s8+pC1Y9vmVmVI/X77/XUXgHOj7f6yHtbcU2D
 1tp28f/fIw/58iDfQNWXxEFXCVGJGwElb12ZLs931Ub5wAy4IfJiILLdeBn4ERw0d7+ws9UNRs8
 eEVTFleV+9agno16iS4jlJNyVTZK0jzb+Xoyx16tm9d5E8l9DgJ90VYz5XC7T7/iqLRn+3Pdqry
 cMklBK0gLAeJdmvS5tmJoY+6MgsPtsPdz34maJvZo+vWEMXmp/Qh8FtEhcxCKHHOmJZPypAx/an
 zaQ7iQxzScZ9o9QMB8vCvdhX+9CWcQXRU6mmE5iudOdM1iSirbjxB/L5HfMKUqIwXckdp0H0BwQ
 wP0U60jBN/gNmPoX0AVh3fe5iJ+mxojoDiFJRybxDTqjnrN2zBiXtQWDcEPPi79W3NkTTrAYKhH
 H/kk4xdhe3i6m0ozmcg==
X-Proofpoint-GUID: nXQRY_1EAp0mkDTeBGEV7yJnxGh80f3s
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a60d5ec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=CM-y2MPe4wPWvEBP-aQA:9 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzOSBTYWx0ZWRfX7eshs79rpzA/
 3Afv6HdZ1Yiqa29tvIltC2y/zB79LLUHWTqPh1is3g5CKuot2JYrLgOpMd1FCuenIf1cexK0gYZ
 ethUGtjHSqreAxvrHDRcRUBqboKmqM8=
X-Proofpoint-ORIG-GUID: nXQRY_1EAp0mkDTeBGEV7yJnxGh80f3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220139

There is a wrong upper limit check for the domain value when an EP11
CPRB is processed for sending to a crypto card. This check is only
active on custom device nodes but may lead to access heap memory
behind perms->adm when an administrative CPRB is sent.
Add correct limit (AP_DOMAINS = 256) checking to fix this.

v1: initial version
v2: Resend without any code changes, just Finn's reviewed by added.

Harald Freudenberger (1):
  s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs

 drivers/s390/crypto/zcrypt_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

