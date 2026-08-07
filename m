Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FC33C1BE
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097966; cv=none; b=rTjBM9r7QOtVKDPL4JKnFQ2W2wRlvZ41R+gkPIUZivTemebRxjs9vBZsdhF88Fly2LW3vkG1ahhIeGatNJOmC22tiuEyl/yRDOVFnkpwFgBl9esZM0pdY/RMLwmWz1jti43RDq1T6+p7PDmLkxdvP0/+EpVbiip1DzDGaBoBhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097966; c=relaxed/simple;
	bh=/Nwqi5euCi0eSOaeCV6WyMBZTQaX/Dfx1z5zGSTpTmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SclCbTEITwyXFbyEdo8KgpR7vmXDXhukGTnaiuJKmSG14SOfMLwFgtvOH1OQWcSnWuQzaIdHf/kahFTMxiAINaJIeczdpF6dCOK5FQ++zlHUIdgYtX1gOiRXhxLYga8SxEhJQPfX49jdd7R0OX4NfZ+yXwJWPK5xRLaExtCx5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZsyASC4O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZsyASC4O"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Iv0P4136485
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2m384xRg/k50IYh6e/vQ9T88R8fX7kPSnTeNPvZIO
	wI=; b=ZsyASC4OlVQ1icjiYYTXpyG4SXL71nZJZFctdHLNKaVpQmrKC1Ojfn19w
	J5DjdfcBnhtoRPmMxGLhvPRNFfxjgfF1kUQBsdDa9KY77gYeL0Top2TKQJu+EEr0
	TiquqlBwI0/QJ5VERPoeYiadFpFTYpR+a5EHsv3vVfS/QcLWwo7C2K0sQRpFOnhn
	pL0eh/Om8o8NMvEAKTfl+7XmXgaZnaxHAxcOopF121rLPcfPfLxiy5PxjFurEGo4
	ESGnc0EK689Qw8FKlJ+xE0Ht1lE60RAf39ym3oqMKleMBdKX9WomT2V2bWMYdQ65
	pUoJls7CylDyaUug+9eR0V/2LuE4w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043cv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:19:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677ABJ9F013819
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:19:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwfc1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:19:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AJIkU30474600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:19:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AA2020076;
	Fri,  7 Aug 2026 10:19:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66D2720074;
	Fri,  7 Aug 2026 10:19:18 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.146.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:19:18 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v7 0/1] Improve zcrypt reply message verification checks
Date: Fri,  7 Aug 2026 12:19:17 +0200
Message-ID: <20260807101918.31482-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfXxkH4RCg4irQs
 9AyRORFgQcabuTLiROchyfCDlTjdJuiJ4WrkwD4IXfBVkcsWu6HA4o5GENp7hVYs0rPp0dG17Lw
 Q8sEKJTTlFXNsdVvvGSP6yRYSOWfOdT/E+koLdXF5b7qGajgfmQXpz+ZlxmeFHR3Qx9kCYSARPU
 ZTiC/u8/Rcm5RWKtZQjtA4neMwISu1VFCiXUPIU+McydLShgOxrMR8dfJbwZdUT+siUWngqHj65
 GTui7O3mqY7/75xfDTdTrx+5mmgWB2+yefT0/0L7mc5FehMOiqkgKjgrFlTIdyq3XrA+q2iuX78
 qHrvZ5nx2K/jT7R/UUPsMWNJjgKBrJSLQNgImfz6EhsKvkGZG0KyYQ9zFkvbaNizURxV9XsWMHz
 OlW6OdZPw9dQeTPBGoHGDyGAZTwNNo93CeJqpQF3ONnOeWfnyaSH+4xBBKhAhaUmuZTY+2D+X67
 2mzJ0Z76UGydd+k65sw==
X-Proofpoint-ORIG-GUID: -s7lKWjSYa8R4OEMurEkFvCxZH4LmJeM
X-Proofpoint-GUID: -s7lKWjSYa8R4OEMurEkFvCxZH4LmJeM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfXw7TKS67QugvZ
 2vHH2UNmx/NJTNzAwKmCN2LeT39QnCXAEyXVLm5N+x6T7oHLc+uMsBM2qwxlyubpEZHVY56WS1c
 znCYpHU1FGQwSTrAOWzAsy8wNIWbs/U=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75b12c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=d48roj0Ss7RZprFRA_AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070078

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
v7 - Reworked the debug messages based on feedback from Finn. These
     messages should be real debug messages (so use pr_debug) as the
     intended consumer is a developer. Thus the somehow cryptic debug
     message text. Picked Finn's suggestion to avoid hard coded ERRNO
     message strings and use %d with the real rc instead.

Harald Freudenberger (1):
  s390/zcrypt: Improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype50.c |  39 ++++---
 drivers/s390/crypto/zcrypt_msgtype6.c  | 149 ++++++++++++++++---------
 2 files changed, 124 insertions(+), 64 deletions(-)

--
2.43.0

