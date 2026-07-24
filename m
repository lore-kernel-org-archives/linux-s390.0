Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C03314C3
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906182; cv=none; b=CAyAHSlW/q8bH8/6zTTxN9WNovRvwFgmiDAs2LP/gtWeFkvS9nKJOxUGVdJaM83QlvrHHuLqnTaVDTBPVM0mJuqygq/2zgugAnhB85YZF/Vf7CSu3aBLvyTsKjl8BsVwxg0xQ19A8/AyR1N4PVGL2U0aZkEOdt9X3P+owREriQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906182; c=relaxed/simple;
	bh=m9mXpB7flXKbRtln0LvHeLxVPLugekHPUuaC75vOraA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHi2DbsyDkSsD6j6UtGhnLVOsMWCJHbIVC98apF19r/h2uxs7X83x52wZ9v9xyY4Hf1rf9j8tUFf5EnMqKzyBbe5NzBAsRIu8Phpnd5HoELItZjabMaP1ZZ6YWvQgBOvREoPZn/KCRKYPn24IetNWlSAmV5s2MxhP4qa5F9TxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jt1I+oU6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jt1I+oU6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODflEG1869204
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oN9xH7T5sw2TR5jXWxP1ck9mhW4dW0ofio6fCo33n
	A4=; b=Jt1I+oU66zmMiUcGXEihP0z0tCUP7OOrT+f1bhYJ+Nc6EiRIiQ4RhQQ3P
	GbkIKfnDA6Il53i5AUi9SEpNo7O3ofY0xkHQ/CTzPEhMIzZVzF9dpzOCYh+vJwYZ
	AnCYAO/5yAR2WophkMOeJ4tqKVMdbKjIm2FzbYg8TpF2Mhtgy2VfPF+IfYTntdTo
	dB3ewaejnMjwApkktby9CnHyUTj/qXTwJy7AMOpOU2XuySAiIxEtWjiKBXHGFnQj
	yf1ynE6YB5h7G9cfczraiJyJU4XCH3+/c9IuCX6TAwCZ7ed/jf8DJTjmWdxEeHvb
	QWQG72CBJRvlPwLZ9BM8UI0BVBwLA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gmn0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OF4bga015890
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgys652-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OFGEvZ32899498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 15:16:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971FE200A9;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AF7E2004E;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 0/2] Improve code in zcrypt msg type 6 handling
Date: Fri, 24 Jul 2026 17:16:14 +0200
Message-ID: <20260724151616.147765-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX5s8syrUqJh3o
 dDLeltAwceoB5RSNPmBgGX956Zq5PCBwb4bwNAt+sZ+loyXCn3cjAjA957bkuDiAKka+BW2x2Wy
 V9Qx4baTwWeoicgt5AO8UEO7WAm/UZBeqTsT5O7Gj1lJpWIE5asYr2NJmPrgW1J7ajJNUBSPaB6
 GwKtAofs2Y3EHyIEqvx3jU7cGyp5vVaSM45fzMabdKAER0irPTWhhD8IlJhqR0JI7Eana/6BVzE
 aupWY7lorxRUkjgCRbTRikYUtY1DyiXEte5E08ztaN2UKsMlJTxhg5skUgoS0Q/TNmNyE7NloA9
 jgW8/8fsalBvVOYG+Vyby08AiAtmLTkubWUA09EhlAby0Yk1eCI8FVwEmoJRMKRqHXsl45p7naJ
 4+rUmlFl5rGN64yfy30bZ4w48puIs04Bpgb64oc9i99MT2XAbmsGtSVZYO6oYQpNXfm6bcKbCf2
 5RY/rqXK+O7QdKPO4Lw==
X-Proofpoint-GUID: AqWaWmIg_mfP5Zg6thLtEz7WszUaabht
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a6381c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=LWQEhQUvDEEWaAVg7TkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX4usj4DkHqhge
 AfT/HX7jH6oxMzmyJhr6HL6grRSwze1J9YkADHluX58ypNEjQ7zgaFO7xItaeYL30x52CGoCGwq
 zVKN/rIl3F/R5Mm6Bsqvxe7P8sifUm0=
X-Proofpoint-ORIG-GUID: AqWaWmIg_mfP5Zg6thLtEz7WszUaabht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

Rework the limit and overflow checks in the both functions
xcrb_msg_to_type6_ep11cprb_msgx() and xcrb_msg_to_type6cprb_msgx().

Changelog:

v1: initial version, one patch dealing with overflow checks around
    the use of the CEIL4 macro in zcrypt_msgtype6.c
v2: Sashiko found a regression: The check
      if (ap_msg->len > ap_msg->bufsize)
    was missing in the rework. Added again this important check.
v3: - Split into two patches  - one for CCA one for EP11
    - rework upper limit/overflow check 
    - add lower limit check
v4: - tried to address all the remaining complains from sashiko.
v5: - Yea, sashiko still found out that the min req size needs
      to take the minimal payload header into account. Fixed.

Harald Freudenberger (2):
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks

 drivers/s390/crypto/zcrypt_msgtype6.c | 98 ++++++++++++++-------------
 1 file changed, 52 insertions(+), 46 deletions(-)

-- 
2.43.0

