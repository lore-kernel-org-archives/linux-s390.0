Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093347ECFC
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031601; cv=none; b=pmy5TuBRdYmxYnzXHKl2/5OnlvBv/dk7ogalr4iXRaspn0ljeDqPSdMQT1Ep29RM9Q2jYUDQkgaDQxc+BFncnOF8nt1hTawErzG4fk7PLLrtgqEsW15fDvHwG3gOWrluzRlGfyy2Es0Frg1V71XopxH8rsoZ0o7SvxDJbiv+Wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031601; c=relaxed/simple;
	bh=iaKviYXPi647a2u+vpZKEkaMZzfs69gxeVOEgxnbbys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZSDrNh9XERRVyVOzdqjCuqlY9yZu5KqKacLtBWSFCAow3NdJ70Wu/4SDoEbWo1baqrB3ULRRxtor79WhKI2wNi356XZuf0VlUCLXj3RAnXiCnu1wTLcOIQ89pbzUt+1n5k/0OaUUKSHpGelLVnSGmHsOpusMJ9AgVSvRaB+Ih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m89E9BxY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m89E9BxY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnJBS2964499
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nn7Wbc6xnFPAhKz2C
	TzIBoTzoEoJU22YpZb8xjDBr74=; b=m89E9BxY3EjEHl6pJ1kzKbUiCgRTB4/AX
	ln+prMeVMB5iwAP2x3ze3LfPKD8qAguX5qtQOcy0Fm87DslZvCHybBjxY5awUM3y
	nYCYhks7ZF+QN2ul0V3KoykmwTkkXS7iQmOvORDBBzdOOCfyEjpsGv86kC5ztv6X
	thGJSsDIWR+AAjmob3HsuR1X3T7mKnvwApv/58ehHVQxSHN/sOwLeFDCpxiWSPLJ
	GbgAHMKXCdabdbZYo6yJxhcNz59C+FXV8vMe28zGnY/ZTNTHO9hr1A9YwzlJliOH
	IOhx0lE4KZc3ozxgOHIyhQ1p0tJHB0GRcWBAgeT6b3h9GE6sQD3mw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h594jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:53:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FfH0g001496
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:53:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4quxte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:53:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676Fr3JY47972750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:53:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D393D20040;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B02332004B;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 1/2] s390/con3215: Add __must_hold() attribute to raw3215_make_room()
Date: Thu,  6 Aug 2026 17:53:02 +0200
Message-ID: <20260806155303.2675932-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806155303.2675932-1-hca@linux.ibm.com>
References: <20260806155303.2675932-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfXz4RJAm5KjJJ9
 MnKbu35I9XQhjZc0sqIbN6U7rza+f3AxBqjsJULWF/foRgLP71VuXbjwSZnbl/mrsdNc8Glds8Z
 dDeMhZS/omN28hWoESCnwMnUeaslJsw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX4AzVDAeAj1LQ
 OODFL4gZSd65zXqd+40ttq/Xrq/q9V2eRfyl4/te3p5zVlH3fKhx/pi2PB0ak3RUiWaQn+44vWz
 OWm+GbF3jzAaCzjmqNzfln2BHIi2Iv1Ncyd0oGVNn4p9HhOk35kVpSldcj7pv+B54yXcBF5vbQG
 jsXCIBSAhQhZGmT0ZCsfuu5Qk6oX/Z5XeZV2wXCNNeSL37rRuywwTomTvz50Zi5dT1BYN1eS4oZ
 m0vjRltl3pVRk804oMQZWVjsG0EhNhp3o/r42sLTUzaesuFMKEF9FJUpA/BfNf+DuUrCfcp23jV
 AzMFuSqJbk88jKD9ZfY8Nvd1kXkkp7digrLiIriTZyBvPPR4YXX58prBaqdf+bO11KR1wr44aTq
 pF5BhSUtk/S4jjhZj+UJmjY+0FlIx2JI4hAvQwwugBwM1OiJSYagWcpnYTTdgBOB2MjtxFox3GT
 nmimREY5fC4orP8Xdpg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74ade4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Mbp7PQ1WAxvEsW75D4sA:9
X-Proofpoint-ORIG-GUID: XagUVhHaKvxQ5Fi4n_o7pHGo74eTL3_1
X-Proofpoint-GUID: XagUVhHaKvxQ5Fi4n_o7pHGo74eTL3_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060122

Add __must_hold() attribute to raw3215_make_room() in order to let
clang's context analysis know that "get_ccwdev_lock(raw->cdev)" must be
held on function entry. This can also be easily verified when inspecting
the function.

Without this annotation this leads to a valid warning when context
analysis is enabled:

drivers/s390/char/con3215.c:485:9: warning:
  expecting spinlock 'raw->cdev->ccwlock' to be held at start of each loop [-Wthread-safety-analysis]
  485 |         while (RAW3215_BUFFER_SIZE - raw->count < length) {

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/char/con3215.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 46265f4fbfd8..57fefa8986d6 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -481,6 +481,7 @@ static unsigned int raw3215_drop(struct raw3215_info *raw)
  */
 static unsigned int raw3215_make_room(struct raw3215_info *raw,
 				      unsigned int length, bool drop)
+	__must_hold(get_ccwdev_lock(raw->cdev))
 {
 	while (RAW3215_BUFFER_SIZE - raw->count < length) {
 		if (drop)
-- 
2.53.0

