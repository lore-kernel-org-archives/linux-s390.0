Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B846AEF1
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295975; cv=none; b=KBtAToCWwyqEn3LlrSqU0l1tUagNlwTe4GMJedc/sHImPHySCuzQuLVtPlrOfSaqmYUi5S0RETNGVaqoHgmnDKIy0xzEHAs4TsfV1YuDvlMmb6R42dUn2GVYUW+jWG/MPlPp48Y3eRWSOQP2ZjHRwpxv7SuHOedF57lHZZSYJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295975; c=relaxed/simple;
	bh=91Arrknwy5CPl8klhEYKkUtFOKCW+l+56OJ1lQIHMAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlIj02DPbDZtC0qJ4rTpHZiuj8dFz/GzdKY8iMcvD8rRep0pconds/Uh9Fc5mTSfFs7WwKjGTrA7QQV41EbbB4TGxJIUt0aPF14Dhp4uByrTDniLtWBYjFP30nDCdgHH7Zg7HoFKANxNOi7erEPunX8OopRtUQgKLn+BVXAQXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J55P+sqZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J55P+sqZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DZTIh2651202
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XdccG4s8oZ1QYcMyGVUn/KWhqt9xEW+mBPoASEK5q
	zQ=; b=J55P+sqZkqLbVKnd7ntybykJ/f9UJAgAjD+sGeG+Q/eFCeRT7shSq0XU0
	mmXxAwevAxUy1E0I67xJpwKM1aSukuxTE0f10pxxDsvaTZxq2wj27tJzQiNbF3X9
	YvNy/5RWjm10h1rnYm5GXuhE3KWKdLZpYnXiVOgrBgGb4NAUz/VWQ+iTy1qpYVv2
	/3NMMP77BfT6HHWudc0D7rHqybeo3x7y01sLNAdYjv/04+lrUhhxEhBMJVQnPZQj
	xCTOhFnM69GV0rc/PoYZ47anWLZMO0MzifZfE1mSq5hLhixCu5ch/0gtEWW32bXG
	9dBQ3VKtYX12ekWQcqEgahvYNGJmw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fymtg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:12:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWm4u403709
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:12:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgt58r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:12:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696ECmLd26346128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:12:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06A832004E;
	Tue,  6 Oct 2026 14:12:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8780720043;
	Tue,  6 Oct 2026 14:12:47 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:12:47 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 0/2] Fix minor LLM findings in zcrypt dd
Date: Tue,  6 Oct 2026 16:12:43 +0200
Message-ID: <20261006141245.7558-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac501e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=oUbw4gChD8HM-A63p1sA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfXwcsfca2JD5Xj
 LTRs+A4aKkNJnBTH4fXIuuZbpEBA3IMUpfnTQL7qL4oj0Cb9FVLQwwOQMhx0D5MVUwjAckRLspq
 Zg1JvDtlNgPd28mHvRyWYFzkbphTigCRBjd7glJxW+LnlokyrVppQrAxRamR2PCHg+1OJc34QGj
 asDAJ8ijI+o/04usCy3dK7cN3mYFhocitSTg4gLfmI7MDBrPWsV71u/m5GiPu3nSZK2fnt3ggvx
 tkSvFDqe3t+koUahLF4IFfdnuHP95SMvBbAW6dj9ai0YJJULd1VtGOtSTiXn/2f/0XuoInWuonG
 vZxpRatMSmPizgW/1g82dIetsaR2CRL1BPVVqnS6V+bSnzmRnZ1ZIbHamqajFRBrWLurMVfHw1C
 VyG9pOdDn84JudnP6NhNhn/G2tLSIvDm9oZdAr+vZMtwQO6wSW9JDseptCXBFG2X5jwAXYR9+qa
 VMYxLjHdkr5JtpHM7aQ==
X-Proofpoint-GUID: -v-skuEdAf4tlL6Tu1anhBxxoGvxWWVx
X-Proofpoint-ORIG-GUID: -v-skuEdAf4tlL6Tu1anhBxxoGvxWWVx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX9iLf0DmB4Rmj
 oGSHWt+SPGIuww22QmjQtguFFVcn92t7LoW31SA7x2Up1UDw/DyZyesmsOrN6XVsE1rqu/iOED8
 JxePilerz0REd5IBgmVspPKhIxh4mKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060056

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

Harald Freudenberger (2):
  s390/zcrypt: Guard domain index uses against speculative bypass
  s390/zcrypt: Fix out-of-bounds ptr advance in
    cca_query_crypto_facility()

 drivers/s390/crypto/zcrypt_api.c     | 20 ++++++++++++++++++--
 drivers/s390/crypto/zcrypt_ccamisc.c | 22 ++++++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

--
2.43.0

