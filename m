Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAA328635;
	Mon, 21 Sep 2026 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992989; cv=none; b=XaqcwVJHAWX/gpI3SvN/W6b1JG6ARdicuBl0b0H6UP+riZ5x9eN0mG7uEDzsJ/Wv68Yg4yS+R5rmkv7NUnBYb8FTdbrKUW1l8Srzb9lGBmkI22UtkT5B8eVQPC8F7neNtJckgUcpzXO6+gEiEFi6awa8Go9bIPZ3FKvzaMIbDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992989; c=relaxed/simple;
	bh=9XYKjEOkX7J6hXWyTpHjOaXXVrd/SMKSiSZexkBkjqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auu1WSHKB6RiumeuY58cpNfncIzV6q1V1NkkxUHdaZogD2gJCGIkabx9cd/ptoEg/YoBAzhdr1AyAXiOaW8627b9HSfXIzM/PVHtNTASn0iduA4SzCs9OwKj/SDjkvI/UFgSLPBEoSmqoXamO+fxJTtkOAPRDxHNDbOaIJ0uW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iL/J4nLW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iL/J4nLW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5Qrh1316629;
	Mon, 21 Sep 2026 12:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=W/VnKOe6YUBNvQ844ynPtFGRYiHN0RCnZ060k8g9Q
	fA=; b=iL/J4nLWIXZTd88UIsA+rfJhoViPrqwGZtoI5vDqBQ+fDpo3FcbyAKQ7d
	ehEfR3E92OdIYBB1qrJS3HO2SAYeRh+5faR/oQGdMQQae+AeQLeQu7PksczhsHxH
	qFXNogjcQieVYi8UiVUCLWLqMDuzto5Pc/2BU20VLb7qukHJK/LZzQH4GRsZpdYe
	7NjBsS76hbxmRhHWwt+6Lea8HQMiFpZWOM9Hgz1DalsSQvo0xrQo6T90ZFgX03Ek
	djpj2vVN1HK4T8tuY1h51UKEGiEZgDRHz61Lpxs2f17W13YxsitlpQHnnnWfaEg3
	kcGMgzpSECz4C4ESNKo504MXMuAbw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg28ea7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:16:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlYVl1153734;
	Mon, 21 Sep 2026 12:16:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq5b76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:16:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LCGLxr37945666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 12:16:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C38420043;
	Mon, 21 Sep 2026 12:16:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4BB20040;
	Mon, 21 Sep 2026 12:16:20 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 12:16:20 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console
Date: Mon, 21 Sep 2026 14:16:17 +0200
Message-ID: <20260921121619.1354611-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8X7mR5G2GBFt3bkO63bAaxafBy0-NHwK
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab12019 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=GzOeRJ5xjq7qDkULuJkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfXwwdAxuRR7apl
 rtfKL3wJP6Nd1TGcGztQdhLXLJpu5R5ayxgegaU82ZNfKwBTxTzu8nPNGFWcUzQeQDKgQaa6CBC
 PDQ/byIElQOBYKJapzYk5E75AL4MMEwbsJW834deEZcYP1wxXmA6xRhBfyU5lePh/fuyedxN78U
 XAbtsV+lUySdS5B4EdmQYrY6NxBv/guBy50ThGwL8/IO0RD/5RxTt0HpaXPL7GTCGe3yNZgk7HI
 7UDHZu4RJJia1oDSHoMqLOEWtdwgYREpb5yJ18TyDazY3n5Euq5p/n72V0TZ/ZMl4OjFXCc/Zcy
 SEU+YcjLjpLzXsZrB9pOv5e9lB8GroKKBdMgNenO7bzzbExH59SP1KBgAI35qe720FEoYghAXFa
 LvgJtz7ULSimpOlWQY9LDr+tXjbJqdHeBq1EaxPxrjmWbQjNVFbT79lVVUq7m0hvEiIO6YYjdt5
 pxw034l0olQRww2cnsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfXzUro2OG9roH+
 zdevRReEjO7HngxFuqZ4PQxDXNyTVbE6coKfOh1j+N7Afm1z8H4w9gwngZx83tFUO7bFP218BO3
 cwoG2xxnoeMmnQFIpsfj3J6EPFRlAU0=
X-Proofpoint-GUID: tH5Yg-FN_Ij7JS_rIz90zQTAFlpQPIMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175

This patch-set implements resize event handling for the sclp-vt220
console and refactors some of the surrounding code.

---
Testing:
- Tested on QEMU: commit 38879a667f with the following patches applied:
    [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
    [PATCH v7 00/12] virtio-console: notify about the terminal size
    (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)
 - Tested on linux-next (commit c1f49dea2b8f)

Maximilian Immanuel Brandtner (2):
  s390/sclp: Introduce dedicated sclp-vt220 event buffer type
  s390/sclp: Implement resize for sclp-vt220 console

 drivers/s390/char/sclp_vt220.c | 77 ++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 12 deletions(-)

-- 
2.54.0

