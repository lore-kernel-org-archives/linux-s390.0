Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7DA3FF1B9
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588947; cv=none; b=XqwDHn3TQRPMI87yHHHkWz2cYG9ub4JgJLcPTLQmNC3gDXECR6t8VTV5zWaRpVfMqLBWXRzufP+kX2Fa9KTJPGi9CcTfKIR58F+x4B7xGC1woaLAChtFCfjUnnlCv7LCNW4DAF1h5Q4GVoWfDlB1fQmD4M1GN9pK2pp4Uo8fz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588947; c=relaxed/simple;
	bh=iO7eSdzujKY1a7uG1tywqYljxcu3X1LQqWwpmGvnjp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1kfT5OiO7b9ZzahAlkfNd+zb/J7dRVmJp4XBtzX3sDStQpr125wmCPLNJEkngIYxL7SC+/QyDF0TPJUMKu1fn7zjUSHh3LAEy92x149LB6U5vr/3xe7QS1dKlimT9w7PTLtM/6llHFMYh9oanr1DutTWEB+OSDzXNGgy/iw7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ibu5djx0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ibu5djx0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696JSKN1537210
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 09:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2MYBoAo6KeO3UbJUlxwVj00P+WoHJi08G3zNRLJti
	RU=; b=Ibu5djx0u+SlWMC6qjSP7PzSbFDE25UTiEPgviYh5hbGJo2usUs7NX7S/
	P/bIDJTyUF3qz4f53NzCOL12W+kjKTMTTges3iOZFHUH4cth5KPJXSqcbQNzHVRt
	vZYMJxqRpfnzR+ak5KyMfunKSFOJEU+TI1Cqw12wepR5T+uByzDxVPFsYrbo2slO
	gEefX4y5KND6wYhOvxGrRDqUZw9TTPBmRT5cDpdPBKdnoxCbQSdLKxHJH9cJIV+i
	CvmskILL0PhQNPCz/jUn7aQPBq0tvz5j0h5NccpDxABvmVJ/DvAxPtOAPBKB2SYI
	SiVgTL+p21rCl1+8IAfXOOsZ5Odbg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknre6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 09:22:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699Jd1Q005267
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 09:22:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yc4wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 09:22:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699MJZe62259576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:22:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA952004D;
	Thu,  9 Jul 2026 09:22:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF66A20040;
	Thu,  9 Jul 2026 09:22:19 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:22:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, dengler@linux.ibm.com
Subject: [PATCH v3 0/1] Improve zcrypt reply message verification checks
Date: Thu,  9 Jul 2026 11:22:18 +0200
Message-ID: <20260709092219.57356-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4f6850 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=M69AuJIJpQA_EsNVqMYA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: IvWaaVWpAaW-pW-rmzzuSGHnaTSmrcK7
X-Proofpoint-ORIG-GUID: IvWaaVWpAaW-pW-rmzzuSGHnaTSmrcK7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfXwRlx5C38Z5q4
 USJxK39E+oNidzKSLyU7eFdpIGDI4n5/CY1Zw+P+2gettbchGSB7XUOAVGF8qitjxUMxLNfMTge
 jjR8Jd/7A4107mZdpIRDRNxasUekYkg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX7++3CaiBFkA1
 bemtI8QxoNw3PYIJCeUlLf4WrSwfZUXMnbJoYsTM5Yj+2q1rPthEKYwc2pWMlfRDxUuoW7GOLDy
 /VP8vMksH4Jc1y1+wHK3ODwT8FqQQoDSL2ROjEVNnAdkEJc4MgAN4/A/0j0jsK6BHPOmMjuvr8F
 1b+S5IGyAY4OpDXsTr0HqPHSQeKx1rZ8CSgNWj77QbLpf3RmV0DweyloqRtMNem2TG/zmXAUORJ
 x+PkWrTr26V0ZBcnamu3F/Z6i8yHTUbtmScydZlfwdWtiV0shCoWY+Dgo/2wTgmR566zXU/J5LD
 TZcN0ljykTETWX9S74JSTwXuakJ9DkBIX7xXXTUuxaveUtj3W081X5VTX4qzhHheLawcIZ1c/oM
 MiWCAQHq/1+73OEPPXdgCMlJ0WW33ds7s7r6sM7iZWxP20fRpocJZf2TRabMPn0jMMixagCgG7C
 ftnnsct2KqBqiBNdHwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090089

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA and EP11 (AP message
type 6) messages. The verification code related to reply field length
was not designed well and thus firmware deficiencies could lead to
unexpected behavior in the zcrypt device driver. Thus improve the code
to more closely inspect especially length fields at message replies.

Changelog:
v1 - initial patch
v2 - fixed typo in header check_for_overflow -> check_add_overflow.
v3 - rephrased and smoothed subject and text of the patch. It is now
     "s390/zcrypt: Improve zcrypt reply message verification checks"
     and the text does not talk about malicious cards any more.
     Updated Reviewed-by tags

Harald Freudenberger (1):
  s390/zcrypt: Improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype6.c | 39 ++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
2.43.0

