Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0451267712;
	Tue,  6 May 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542084; cv=none; b=DKU2iKQQGFBKEqhMpLFJqhdrUdjgXYndAQMX1T1rwiuc+b7O+nZolmTuIk5UwMH7pLzXWBAlXtdKW6bNFuvqh/RcXAcjhcaDfcwDhYjb0ngx8lRdcwT4LOmHEIWlszrRdaPE8qc3f97mpFmMGlfqFXs9ULMSC7x9G+QAru9YStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542084; c=relaxed/simple;
	bh=C7UAk61HJn4yuWR4WO5suuNfPfxO2YQNOSkxmkEfqoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UH8+kd35uvb25RXNu+LNxWqIyYCXV4/XEHb5O1EGfTNAI2Dcpr1sr9BtSKappv1J1wWJSJXpI8nq94pTcEjzkPdFE4o4dwbDHSt9xeyQJfPOCOekjcAs+AFp9gh66kp79jSVHhfEVt1SnRhBT3FG9b9RKkUa1po/LezxucPXcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jGVKoTB0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jGVKoTB0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5465hctQ009102;
	Tue, 6 May 2025 14:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=P1HEbEXaAXq6YjuhmpzawJS6s779+xGQD/mE8k/wk
	Yc=; b=jGVKoTB0jJ+iskoCzQWUqc5ckMyZxGDO2DghGSFtkSYHw+4XdSXnPC/RT
	qBXe2pdlxu2lrkgm+ArKQuznnNkw1iedF0SqLfbsBNcMRxdQX1A1StOn9XOG3lzi
	XDRr/eJ76ur/AZqtT1LsMmH+lzvrW/+J7Sn+jTiSbYKQwiAxteFeaztUWL82suWQ
	eWZNXQG9vsD4tYf620EfYIkOsfO06ebjSFQ/IzlMgNhbykQeUtZdxWgz7c5zQ+M6
	XvY3lUMnzuOIprnGMHerigC87spBVLqZ4DwE7oxuCKoZhnpk2hh/tF6FgLdHRIuw
	jqzyYYCYEj/RxcIIMxjqWuvXnoZWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy2bu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:34:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 546ERFuS013894;
	Tue, 6 May 2025 14:34:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy2bu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:34:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546CD0jU001324;
	Tue, 6 May 2025 14:34:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftc3fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:34:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 546EYYca49152342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 14:34:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5606A20063;
	Tue,  6 May 2025 14:34:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4093F2004D;
	Tue,  6 May 2025 14:34:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 May 2025 14:34:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id EEB42E0573; Tue, 06 May 2025 16:34:33 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v4 0/1] kasan: Avoid sleepable page allocation from atomic context
Date: Tue,  6 May 2025 16:34:32 +0200
Message-ID: <cover.1746541531.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uFqZjkkvfkCALI169ewjM_NkFtZSpoRq
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=681a1dfd cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=RptFD5b0m2ehXSuSLUwA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: dBOwxq5Zu-yxd8jD8_HyA_Y2Cf6w-Cu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzNiBTYWx0ZWRfX71srGyKBBmvi ba7S880O+LNEdssjIk/4mYZeG0wY5Qa4MKBUEWBVYgIeyaXov7YR4pLNodzFXJkOUH+OwOrdzRM 33eM2XbzElWntFcpijFtHEmjJ/hXZfo2r6LwuuuNlACnVT9z+Z6/ZOEIRAcHHK77DTCA2gQjVYm
 5Rv4eSHKVedmiyyQVhxL4vnGYTCQfmItzru/4Q5dmB/6rpthiiuKux8rAd4bmEjnkxAtrsS9CUG BsYaspcRCPfeQ7PBx6rOQqCBxBi1mSCtDusSOBo4xf/DPi8A1HHxd/55RMSRHI781jalCs/vvOn WpUVOdPylq1Jbn91TIpKpiLd8tM7msv9QeaWoPJMaUAPx4EhkoZlxiwVoHRpSFI+k26IXbtXBnf
 I7xr0Bn2kb+9GMKg0sYaoB92/QU1O+ndXd1Ubd8jFH4loUIB+3FzDVbGyEkqyNvR5v5uaibM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=529
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060136

Hi All,

Chages since v3:
- pfn_to_virt() changed to page_to_virt() due to compile error

Chages since v2:
- page allocation moved out of the atomic context

Chages since v1:
- Fixes: and -stable tags added to the patch description

Thanks!

Alexander Gordeev (1):
  kasan: Avoid sleepable page allocation from atomic context

 mm/kasan/shadow.c | 63 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 16 deletions(-)

-- 
2.45.2

