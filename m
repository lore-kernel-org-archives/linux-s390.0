Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B927474276
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825069; cv=none; b=QJZO4dV+HEBdp5WYT/6kEIhX3eIN4FAhSAq8bkZsz0A1RW266JT1/cQymJdtSS0+ERJKqO0cfI90jQgBuZ//lzILiM/liU7DJSxgviyzrLsuYUkRnivr2oZjPx4bHpYTcm/V9ugFuq9iiMRkFRhy2i9M05NNVh3WDSkn2AlO4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825069; c=relaxed/simple;
	bh=k6Xhiw3DQ1J5s58Y2FtyG1gJP9QduxoPiyOdKgMZLDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsj+1QWWbvscH8OuTGC6lEcQsf3mru8S7n32mBJ87k4jEmK800B1F1/y2ALAw4FhxPk8T2VP8vOi4qt+tJ8KrPju1SBOxNcV/BrLKfbXsSu/TlcQ6uQxVSTVPE77cH2eB4M901OHRnMtxlp001ns5MCiFGY3yZtgNTIPopkJkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bbEmAHj5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bbEmAHj5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC8Yd3015810
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XRlwpidBaX8ckhIfm1vG5nUlB1ejyIpO/8r13J54k
	Pc=; b=bbEmAHj5bPZjSKM/jmsShI7Nc/I/DGuhtZYjlj4WJRU6fS6U+Lu1aMBtl
	m+tsKWms7Ah3eJaw6xMAYc45s3fgG/TDV7gau81Gjwbm5j9DBaN46R0L9KyKLKhd
	MgHVwg8bv1nzWEQcEItueM3KpMbpo/Jml2kpVQLYIcwdSLUpseBjzQ7jH8uZadP5
	aTadAR0kLCW+/5iRONShJkaY4UggXUBDRNhj2cCOV4ReZhTKjc5R2HkqcvF2kjcJ
	U3+L/6uK3ZPhkxrUwoUnWGO5/Cw5903fdYaJHCXbGtyGSmSg0eW0QakJDortp49d
	ldkIDcdZFYo0xKJviSm2TWqu1LVQQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kg24v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NGYZIE017783
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wd69r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NGiJEr49218010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:44:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85DC12004E;
	Thu, 23 Jul 2026 16:44:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AC5120043;
	Thu, 23 Jul 2026 16:44:19 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.142.235])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:44:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/1] Improve code in zcrypt msg type 6 handling
Date: Thu, 23 Jul 2026 18:44:11 +0200
Message-ID: <20260723164412.134500-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6244e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=lBdAcpDw1wAZ-li3s1EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX1hdPmxd7mPz8
 u6olgVTtciox9AyjGtaBkCB5MH8e10euo+rDCnWTasZVuxMGFy2I28C4gjg6IHLGaMaI5t9PwM7
 Tu3XkcWcK+mRRneSB4+uSB37JVQRfePRTW4QLIcuY2SbxgMoB7d2GtUwx+nUV7ANFCcEUBMz8p5
 pG5rC9UrODrAQj4h6aEbAxtf0WJsnsSm4jMSpnUuy3Uo3644jWt0Y+wz8wJgTqVwgO/OX0XZKR6
 6SkliXJtAWYx1yIOzMSRcvj23UJrwlgjBwWbiQIUAyI6VPchJ25hFX9xIbSvJgK1tHZschdPzBr
 IhCVQvmPjQBMaXiv5mzP0jVtM/a4i+5zye1faWFXfkTxS1lQefPhiP+x6gwGPbdzzyv11iOY0sc
 Y4GICGZRNP0j2lmlrZFkXAVIbbWGN1QmBAlxagKIJz38kJSyO6fV1BtF8Hzc8SYr9CHqhGLgVLb
 fwsGCOeqU+XX9SyagkQ==
X-Proofpoint-ORIG-GUID: Dt3pZXlXaKdVudrMqTyOiwqe4gJDPv2F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX6Bw/57Q3p8CQ
 o6eOHgVxrmypTDleyj+mYnm0h7c9szVl23Zx/WdeSkiS6S+Nw9NNRSsOJR1JTKewIkkrzw3bwvV
 qWKY42i6NJQZuZe8/OKhwxjdKqXGvH0=
X-Proofpoint-GUID: Dt3pZXlXaKdVudrMqTyOiwqe4gJDPv2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230164

Changelog:

v1: initial version, one patch dealing with overflow checks around
    the use of the CEIL4 macro in zcrypt_msgtype6.c
v2: Sashiko found a regression: The check
      if (ap_msg->len > ap_msg->bufsize)
    was missing in the rework. Added again this important check.

Harald Freudenberger (1):
  s390/zcrypt: Improve length check and overflow detection at zcrypt msg
    type 6

 drivers/s390/crypto/zcrypt_msgtype6.c | 83 +++++++++++++++------------
 1 file changed, 45 insertions(+), 38 deletions(-)

-- 
2.43.0

