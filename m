Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A146367B74
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854975; cv=none; b=gEYuEdSQX0SRqeyY/DVAySwb2mXr/DaCw35aIBynF/X1rueIwlISeX36vRC9DWYHg+3QhuomqueS0OqFWRx2PhyKDB+hlobh0OvHNLO1IkRB99OAnmxsu0C2mV9BInKnoUYxm4bTp/fTJPoB4NX11914Ri/t5q/2VlXuCQ4jMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854975; c=relaxed/simple;
	bh=M459v4XnQyxJ1o4yXvG34HgnsVP+ohPEd2qV5Rm7LOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxFmdctW9aTkIg/6rpHTa3WeozhS/xIQ8Yvkaz/OP6Cu4OFHztNkm7s/WpzWetP5fViWdrTS25CHnJAWMZBEb0NkEDQBgC59l0dkaj7Tb1HUqC0uu8NPyqkwAvoDXbBjRmLDjLiOhLr3t1e3zBxa2SWVE9FQ1FNiDT/2sXCyxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L2bWqrKx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L2bWqrKx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CpZ9n808709
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 14:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SXLGMr2atNMJOz7sYCTPcLIc/WFcwqYQv1S8EcT5/
	Uk=; b=L2bWqrKxK/cH6G6rRWqOdTq0eAALcm5XqNN7NNLnFRKyjjxuwunBPvFon
	1HBNXCkSCoCZ8X6zrzbAI1T89kJ6KnFahBy9z7yWbdshUa/Lei3gij2oburc4qWW
	xZbwGkcUh+o7rf23oO4h4tS8Z+zWx97SSDEwmAt2pcNAKRGhtLmqGAvaNtR6cG5F
	jMInA3eEa8a8NGwMUjVHbKwiIu1I1yLoWXoupFEKKUv2UJ/S9r5ZDTpli//k/ZUw
	vv4J5VuOC3l7kBr18Hq4PNQbQVNqqiwriO+olqPh7xwzOZ8hyfptJypaCYzNqaBP
	iO+ELZudHCFoygD0cCFwMGCHPezfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hp7nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 14:49:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EfI2F021690
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 14:49:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbga603-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 14:49:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674EnPf315532328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:49:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58A6E2004D;
	Tue,  4 Aug 2026 14:49:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3521220040;
	Tue,  4 Aug 2026 14:49:25 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:49:25 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v6 0/1] Improve zcrypt reply message verification checks
Date: Tue,  4 Aug 2026 16:49:25 +0200
Message-ID: <20260804144926.241039-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX+sDiftnCZu21
 m5Ku0Yvp43R8XqZBNJoorHlLPm9NpveesAkShmSjjbXb6hyM2AT2x5BkNiGeoO4nozTEyekExzK
 mAa0tG7VclJmnLKe0gq3UkaGsj3tY6Y=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a71fbfa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=d48roj0Ss7RZprFRA_AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX+Y2B22t4LO2s
 d8kBTdHnhJypTwfNQNvGx7UAtv+MeHyi1lMW2hA+M8EXdADWcakhYtILd0jnoBovgy+cpKh6N/B
 QDbanCDFiWpx2LhyQz3nT+Qst+F09BpSSpNjuJC6OMZ3vnR00zyZMxN4tjJn/Jw1nP4a3hpPzeC
 FboyxVCGyLnkqK9laOEJVdMca+r8s2YE/72vp02ZzTHGoBW3fb6M8sQyBtyjLl1zEPWYxuzGwE8
 O0IBDcKHeD5BSfu8T+ne6qlGh/6pgYjlsxKIOl1LPhIgbyIJLPepXwO6FOclVPQyU/y4U5/GiCH
 yAvphaw8edSzmXZTHL9rXjgesVCSxmFByaHse9465YFdiftyzA/AF5t/1jad/f+tEEPgz2wKUfi
 J9aCa/x+BbGZ9KV3qDahsrrUfD81YMe87zT5mRsTFQR52mOPMEjly+rkaypiyedtP70OuQX4x5/
 Yrsr5cg/7YL9QP5Xvow==
X-Proofpoint-ORIG-GUID: ex2RhR5GfYkxX7YQKySTxZ0HipdhHfAL
X-Proofpoint-GUID: ex2RhR5GfYkxX7YQKySTxZ0HipdhHfAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040120

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA, EP11 (AP message
type 6) and ICA (AP type 50) messages. The verification code related
to reply field length was not designed well and thus firmware
deficiencies could lead to unexpected behavior in the zcrypt device
driver. Thus improve the code to more closely inspect especially
length fields at message replies.

Rework zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11() and
zcrypt_msgtype50_receive() to validate reply lengths more carefully
before copying data back into the request buffer. Use size_t for
length calculations, reject inconsistent reply sizes, and add
defensive handling for short invalid replies. For XCRB replies,
validate both reply segments and derive the effective message length
from the covered range instead of trusting only the second segment.

Changelog:
v1 - initial patch
v2 - fixed typo in header check_for_overflow -> check_add_overflow.
v3 - rephrased and smoothed subject and text of the patch. It is now
     "s390/zcrypt: Improve zcrypt reply message verification checks"
     and the text does not talk about malicious cards any more.
     Updated Reviewed-by tags
v4 - As sashiko clearly states the addition of two 32 bit values can
     mathematically never overflow a 64 bit value and thus the
     check_add_overflow() was total overkill - removed.
v5 - Sashiko had a by-catch related to the very same fields. Under
     some circumstances the fields count1 and offset1 of the CPRB
     where not checked but used for a memcpy to userspace. So again a
     rework of the check of these x86 header fields in the receiving
     function before the CPRB is processed to be copied in parts to
     userspace. Removed all reviewed-by as I want to have another
     developer look onto this patch again.
v6 - Again reworked and re-structured the code. As the very same
     pattern appears with message type 50 also reworked the receive
     function there.

Harald Freudenberger (1):
  s390/zcrypt: Improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype50.c |  39 ++++---
 drivers/s390/crypto/zcrypt_msgtype6.c  | 151 ++++++++++++++++---------
 2 files changed, 126 insertions(+), 64 deletions(-)

-- 
2.43.0

