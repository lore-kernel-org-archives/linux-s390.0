Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1263DD86A
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581907; cv=none; b=fOzPozfXhkpTnW9xUowxDPltHvTvHuJve4Qud0rWRfq/8CBtTdwQtFQIfLd2A5h0S05F9RJgaAh/l5ppVP8x+Y3skTLNcvvDBQk6RXQ6223/pzu12boV9nKSR+kjCt+TsimhWrRyR+ooklYr82AB52x2T5EtYbD5PAh9fMAu3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581907; c=relaxed/simple;
	bh=AcrT9CSCqaxNu0h7z+tfQ88GEOri0/RWyla9hQlJ28A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LW/qKtxrDwql6bntGM+NBD6HIcYqFR2Rnoh8/MAoEO6S75yACGLPbngN39cgFDEHseagNvWlsRiWrv/yQs2whpSiId4giyYfTB1m+zMGeUZsyD6GLQOCNKLp9W7bab5vVEDUin8ZAINBjiznvzvKs3+3PKnBQjWz8NbhECmAr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fZ/sbYnd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fZ/sbYnd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696INFF1535411
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 07:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5BKD41HDnKz626GiiomXyavlj120wKJjkRhVpMXo9
	nE=; b=fZ/sbYndhZrVVOPsz4H9N8oC9jIQm1zVzhlxPSI8PIAQYeOpNH302v8eV
	sxrEsUCOqSX+4KsyMgOyK4DZ8wwTZUFRPHtAtk05htm3gH/MlAgOAVuefZAp40Zk
	hEgpT6NwT7IzyXGPAJSu5X2gzcFFsgD5x1zeGLe2dgZnWr1DACkOk/k6I7rvbP8F
	ixp/da0scx0Wun2j4BrIgIq/qzwh/vmdEuvdEpCnY+rYoj/82ZSfevp1Ek94aPeB
	XLkWKHVqhyT8kSaXUJGkVKgB1g2tLyNfN3WhuvH9JMQLPNjMquiFAbxInmoioGXY
	j5EMD7Xt+9NJHGtdpfa8p85Fq58sQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknr0jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 07:25:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6697Jl51021580
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 07:25:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hky7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 07:25:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6697P0Js27263410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 07:25:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 852F62004E;
	Thu,  9 Jul 2026 07:25:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65AED2004D;
	Thu,  9 Jul 2026 07:25:00 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 07:25:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, fcallies@linux.ibm.com
Subject: [PATCH v4 0/1] Use mutex_lock_killable() in ap_bus_force_rescan()
Date: Thu,  9 Jul 2026 09:24:59 +0200
Message-ID: <20260709072500.55706-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4f4cd1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Q3fI1I3nFb4Q5P0WJzsA:9
X-Proofpoint-GUID: 6EiGPZUA9lcpEPVNugbudrGvVdApPhVV
X-Proofpoint-ORIG-GUID: 6EiGPZUA9lcpEPVNugbudrGvVdApPhVV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX/2hBKD9Wbmbr
 1x2plOSPwiJ9RRpkN/KxS4O9+nsy2r7aB6aFBwCLkYsthojJXEkYvP4+CA+rEBZF4tnCuKNT10B
 zUSZpIKObwnvFk390PbP32m7k3+5U94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX4Zi01ah4iTn2
 KDc08Wyx+1cnbEbNp6WNo0ZdCqhBiIiBf7iIk6/l6aYoZGed8L/ajWJYRLOJvF6TUjHQkH5r3pj
 /jLZjTs1noFdO7UgWQyAjyPyglObpgLZwvoo0KBasbWIDQ2GdRS+Da60iXjempl1zsBTK5XoQs5
 HW3Sv/rlAej2FX93eOfQ1hRL1ushf5iPz0XcXlYjYIagKLVaGLE0YSOjwehQnoWa0NgXcZEXAHO
 nqGKVYwLwVddLo07XxPPwwvHDr/sdKSGUQrgjx3LRdvnozbAa5sx6mYu5HoUOKlk2ZVdX5Ps/2O
 6usbgzNPfGSx9HQU3l41dghRIFv/5noZTDlmldYsZaEpeKf2/LwFPEazBUrp52uWkf3fWAJQHd8
 JJvfOb02koUaR4kl1OYCNQ/qMMkIgCM4ZqNy5Q/tpO8c3XoT+gIfW139usjuCQ7avJOL3Qrp387
 Jhk34tlBuWbBI3CKMjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090068

A deep dive into the AP bus code and zcrypt device driver about the
usage of mutex locking showed that there is one questionable call in
ap_bus.c in function ap_bus_force_rescan(). This function may be
called in kernel and process context. In both contexts only one info
is important: was there a AP bus scan running and did it result in
some updates on the AP devices. So only true/false is returned but no
info like -EINTR. But still the mutex lock call should be
interruptible to be able to kill a user space program blocked forever
on this. So this patch replaces mutex_lock_interruptible() with
mutex_lock_killable() to  be able to handle SIGKILL especially in user
space process context.

v1 - initial version
v2 - with v1 came up some discussion from Holger and Heiko. Heiko especially
     wanted me to rephrase the header of the patch.
     However v2 went out with a rewrite of the code as discussed and suggested
     by Holger but Heikos complain were not addressed.
v3 - now and finally I rephrased the patch header. Let's see what feedback
     I'll get for this now.
v4 - Rephrased the subject, Reviewed-by updated

Harald Freudenberger (1):
  s390/ap: Use mutex_lock_killable() in ap_bus_force_rescan()

 drivers/s390/crypto/ap_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

