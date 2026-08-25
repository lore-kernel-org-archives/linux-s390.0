Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C833C198
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673722; cv=none; b=LDEY/ik2ZHdi4nQ8f04M05w2aN62rHdiRRgztwplXK+5jTVgbMW+dc3pQi+ELkTyxinrnjGLeB+cDu2JV9kwqgrp5De1ecAQK6EsTXWi1YbAVcpNBuvYPze98/RwYvt4cZPKx+mXQ1/jbAN5hhf3LYqSDT8MLInMLkiWAvZzjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673722; c=relaxed/simple;
	bh=EVQ2AcfQMPnCQU0CgvOOiyJmBF7cm5Tq5Hc77uf5n/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYBaaKHZPyivcYydoOgAkleabHMTb2Xv6xpmMAv2HeqmPQoGc/4/5ahI0DuQj1/b7H6UZvGzzJ/HCJN31VSEIQC0qzlyG1zGr/ke9gtF8Qp9fn7sArmXhwq2BiHw9FHr8T+ehpUWNkajbSG1q8hJK6GmvJq++uJMPf0xAR5Epso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DQ8WrLzC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DQ8WrLzC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYwJv1024702
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=omOdrmaKbWC6K01sqoPSxrPU5Pd0mlJfrZIFvYcs6
	1g=; b=DQ8WrLzCSi9XFZ1vms8zyTcxX6kwY7gyy7+rIujN6HcTsAgCHVRuGoV9O
	lvLYguH5qIkAJuV6/MJSI1jbJuoK2D/XhWkwIvzmSWtko4FdzEg281Wkr7yfbHlv
	p7vWhuLuZ9GRnechtjyDS/sNSmkFI9xJCsm5CyiYWO0ki2qINAd+X1Bp2XiBscZG
	9oY/TTGRNPN98CQJLMeG7GVHjizOqFA7X27SqQAlc6FjTh7SCA0BypJtL9ohdOfz
	H5B9y2P8tX1fL1s4SG2V7fNnQCvDHnn4x1TpTUO5fROc5o/GU/VIi/rSUpMeewTK
	jJEOclK9IgYfrlLyee0lsq9hOfTuA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hsat5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:01:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PFuJFl011302
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:01:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy4sn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:01:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PG1tdi44040488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 16:01:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30CE92004F;
	Tue, 25 Aug 2026 16:01:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E08A20043;
	Tue, 25 Aug 2026 16:01:55 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.133.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 16:01:55 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 0/1] zcrypt crt and me fixes
Date: Tue, 25 Aug 2026 18:01:53 +0200
Message-ID: <20260825160154.106501-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzNiBTYWx0ZWRfX0ZFQcZgg447T
 wCeFJyvZ4rNAxq/h5NcV3JkH1pGLTd0vYQfsxk4R5OAuimSkew+wV6fI7OmtK8d+tKyqPllh7Of
 MOdg2ZLOLSznzbXx0GQh7yIc7gy4c8Y=
X-Proofpoint-GUID: PgK8XWzX2Zh2A2a7akGTzK3jzUPBiGxG
X-Proofpoint-ORIG-GUID: PgK8XWzX2Zh2A2a7akGTzK3jzUPBiGxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzNiBTYWx0ZWRfXzoG8yi3gV6cB
 fHSChCNU3M8JIUyE+5VrC3QDRvtHM4BdBVGAt1HolDLe8qFSrYcIJ4+yBOkcRj7tmu01Or+5vYT
 oIGTJmakpzIggzzqjdLYjhmAsv7ddQ1xuNYokHcfHcymk+Zy5I2igK5i9+2uTIKfl3HF7CRLEYP
 gEY2ZOmV6LUuG30r1U4dT0WPWJw4N9ZbCDu9K9P4YjRGWsJJDNT7JD0+SKDCL/kgSZkxx6MR4ml
 k02wx5zrBVArpl60BDDRr1Wa1WLVWjy5PuU5ar+T8ysoOjDk6UZ2ccpV5hsT+BOXxom1U+ZhMrZ
 +b5OW67bRc+26xW/xORNnKdezXkUULHAezjQt+WUuZiuCs3Pu4RR5TDQ5dDdp1FaBeWwI6a7YfI
 l6lSs3RWhOHkV3is+1boy7pvKZFrW5T8CSJGsgXU3CVC7t0iYgCQbv82ml3PWfCl1cLPSRb8tFi
 m5Qc2lKW9yWCf77q7OQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8dbc77 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=xCxzSRWVkvkmEhUwKioA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250136

Fixes related to type50 and type6 with RSA CRT and ME.

Changelog:
v0: Just one patch fixes an AI finding with padding when a CRT
    CPRB for CCA cards is constructed. Details see patch header.

Harald Freudenberger (1):
  s390/zcrypt: Fix uninitialized padding in CRT key structure

 drivers/s390/crypto/zcrypt_cca_key.h | 1 +
 1 file changed, 1 insertion(+)

--
2.43.0

