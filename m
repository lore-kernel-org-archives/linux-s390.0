Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75249E5E5
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301573; cv=none; b=LKecaoC/Ph4cji6PliydOAUP8TYrjyP57qF5IROqjRuwmX8bL0e9kEV++7ZlnXwueQJglAhWGbEa11fotMV3UcBJ/1iC6pfkHLXELVlRVi15ZKJ0RNcbHbXJdEk1Vqr6/Ii9hVO9SePDMyk2pE9a4sKjKqEaOBRZDij9iJ0mXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301573; c=relaxed/simple;
	bh=o8+JnlAG1JflDnlM3dPUC7VAK+qqWBxPFlVp//ZgynQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoCmzyYIcySwcdh56gVZM9VrhBHpaiRpszK0J6hEjm9VrDiUxalKz5Q+XF6nSDZuWjfpouEX2R7dJFDNkoaQMXwLHVolC/fHixExliWu0G9TBdhZoyrb5LJfgIfqiAXr5IQHgO1jURLxgjpQ+ODubCkHm8s4RaahrIICt1MZJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wty2lljO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wty2lljO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZZTP3851973
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1O0C9CJt4x2pzlhPbtd7EstKNyTNtr0vz4kIDWEM4
	jw=; b=Wty2lljOLtJwyXLYdfgiDTdSxQlPjHeVpx8G1nyuBvt3E7xx/15cN+E0p
	uRT729WbgxZkw6ezG5bl//LwFquehDUBQqWOi+T4vqUS9lQntyd95Q06Fv7SRpyf
	LP/UyAn+CApNfnJZen6NsjnEGaLI+K1imy3tr2ntpIh+KJmcidSnwWMTVZKkX73w
	+t+uB9qxl678B/mCCXqD+l14BroVMZaMkd+RdUtDD8eYGBiygkyyQCe5xsoqROkY
	6rcOk7/sW1YHHyFU/YQ4QxtAF/slfnJJ4OzZVzEbSkg+8vxOKYDDuCvVGNnxhCxT
	GcsiOwcvTtyUv2rVP7OM54lbsfAng==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jrasm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:46:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHUSD410988
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:46:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1ptr9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:46:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696Fk3cV32178732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:46:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9A002004D;
	Tue,  6 Oct 2026 15:46:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE232004B;
	Tue,  6 Oct 2026 15:46:03 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 15:46:03 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 0/2] Fix minor LLM findings in zcrypt dd
Date: Tue,  6 Oct 2026 17:46:01 +0200
Message-ID: <20261006154603.9699-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q4Zxafc1WKnSVPqwnxWywOUATGr5U_M6
X-Proofpoint-GUID: Q4Zxafc1WKnSVPqwnxWywOUATGr5U_M6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfXxHme51FdDHpw
 r+D/rj2XN62fAVGHW39Xyv5yc/cJopipHAfkbjx1CpXqd+k1kZCFeNawRh3+qqKJsnaEAgEOluh
 qg0oA5ghDRkADt+ScZyPlnGyIx0sxsE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfXwylCFPukQ9pz
 IeDJD8Wa57rvHwgQ2QL99PXLfzh1YvUXp9zTB8K6glZOlZdx0HkmZtcGQ8U1hTcSImWiuTUYy8N
 FUeXb5gI4LwHKsUdTTv2jVBbJobhMJN1co/skOsirP+yuxEw1vWWaFXJUH7Wxapf84ALf1Iq3w5
 kMh2y2V+GBmS+VUjbzZCpMHLvvpvk+JSkUOZNQM07bT99L6Ij8l9p29NCeJmxYgsZv8OFd/Caxv
 /jHOSe52N+PbIpEuOP1uVnizy9/ZyhtKkf4JpfAo9ewxiITU9MTt55Bgi/PpPIOuHdxRY8VCk7L
 803qs/qgYTdOuUlhkACQ39odP9jM4IOkkn9MOrGaydN8x9oeZF5IKbg9zW1vRbxxoaGMddaue5+
 k3k9Gz+voKNyRpWg8aDSTFwwMb0K9KoLtscnOIf3pJ8BSpkT4C4k6ZNwmB8b+hXgXdxoarOfEsx
 sDdVESOyQ7M8aAWgLpQ==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac517c0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=h2qVecyevSGYt6gzuLQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060062

Fix some minor LLM findings related to the zcrypt device driver.

Changelog:
v1: Two patches:
    - The first patch fixes a gap related to speculative execution
      with the domain index.
    - The second patch fixes a length/pointer check with parsing the
      FQ reply from a CCA card.
v2: Fix a complain from Sashiko about silently dropping invalid
    domains down to domain value 0. So now a explicit check makes
    sure domain is either AUTOSEL_DOM or in range 0...255.
    2nd patch unchanged.
v3: Well this spectre thing points out to be really wired. So here is
    again a rework claiming it shall protect against speculative
    execution with respect to the domain value.
    2nd patch unchanged.

Harald Freudenberger (2):
  s390/zcrypt: Guard domain index uses against speculative bypass
  s390/zcrypt: Fix out-of-bounds ptr advance in
    cca_query_crypto_facility()

 drivers/s390/crypto/zcrypt_api.c     | 35 ++++++++++++++++++++--------
 drivers/s390/crypto/zcrypt_ccamisc.c | 22 +++++++++++++++--
 2 files changed, 45 insertions(+), 12 deletions(-)

--
2.43.0

