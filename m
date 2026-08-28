Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED746D578;
	Fri, 28 Aug 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925673; cv=none; b=WjdfpsMysYsCdfOwULUlVHd+0cVEDcSYq94QjEnEF/zcyoqx62yYhj0kwfK5vELK1KWEPgrdzQtoMRb0fdKsWj4LUUOrgPhgRfgf8qTucNmgOh8BSENW0UAqOM+yXsXA539SiUTJX+Fos7/E2Kznu2pfLeghfuIk5S2xJm9SyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925673; c=relaxed/simple;
	bh=C7Hhcg+WCX7x6g++PHHhdNtHD9wenpuZa0J1TNXlJOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkW2r2lgHAI1vsOu63HXmYsbQdC6JcKReiz/rqFHvaFmc5Zrxw4FARy0Y0fLmSf1Alu2yBP1GagAu34hGxT1cPMuAq0GCoL1e5/7Al4vEYZLKtsetmVuS8V4NPoJz9O0uY1gamP9o/m9u+NmPvYYX4mkuB4T6BdWdh1xcu7vpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oub9InCq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oub9InCq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVWur2133131;
	Fri, 28 Aug 2026 14:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lxKD2FeGoDVDWfvTfNnZ2K621ZoTuiERMxQSsLeHp
	Nc=; b=oub9InCqj1t92LrFPWXfdDNiNYpdXvF9oGK35WB31Z21OGdF3XCJTHU3+
	3bsF8JhVZnhVGM1iEjUw/Zc8U9KKzpXFdjY2kAxWxVKODSXnqAVSZ5eqqaGVwJg7
	Rty2W6lcrGLUpR3ZPXa+KxizFienXc6t2P+p6mI6BmKmeD5gM3LY+NgIYb68D4pc
	nT32znxx+1TQfycNe1/liJiHOZqtITSUQeo917jLH3W6n5OPkttNYFoejxkODy7L
	sY0WyLZMFuvBoIgEh1onITgg1SVVxHqWb8lWilx3LnyD7tqYlhLQr/Z8e+ijEOMr
	0BhvbwLEPtWCkJwbh81CFo8AklZEQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5cpak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 14:01:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SDuGpi005550;
	Fri, 28 Aug 2026 14:01:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyp89r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 14:01:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SE10Ii43843994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 14:01:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DA412004E;
	Fri, 28 Aug 2026 14:01:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C92C820043;
	Fri, 28 Aug 2026 14:00:59 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.26.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 14:00:59 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/2] s390: Warn if kernel command line contains non-printable EBCDIC
Date: Fri, 28 Aug 2026 15:59:33 +0200
Message-ID: <20260828140057.1728173-1-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfX5u6sQeuqQW8I
 uqkQEdDzcKjxhqg8DHoPPmKA4U2hJM6KGqdeAKzuL97k0DSKvSit7vT4bsOqS4+NgYOe4htcS1z
 jOIrk8pppQsx79Z2Ev1PNNCCDFbx/B2c9yYh5S2qHh4dnB1xWmvn9xo31+8Nf3pCQ76Cp7sDMKP
 nUQX/v47IPzhpDrFfh4+QgxF2WpeCwGejm9UImowbrYhUwO/Pivv5iNr4tR6YQJWGQk2WhDfhC0
 ayMd7+oZU+OOY8MzvBxnPrzxbYYIjD8HTbI169Eb4GsO2Dsjmu6KkMbFkjbr//Ad2/UKZRnbPb8
 2l889wVFZYiTcLXYTNasqybL7mBt37g8EhTNuyuntNDNAxChad31CDATOrtdRXH4CKTOkQeLuqf
 +jlDKRtHc3RFKwspNn0JnoQ92YwhSg==
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a9194a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_2ywUkym6YunK0CUMMUA:9
X-Proofpoint-GUID: GIjjYS2ltIeknfH_15s61sWNWLW1UIqj
X-Proofpoint-ORIG-GUID: qWXWXpM3dvVnE3HOKarbLu0pkfAZXHND
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfX79ZLWWao2mbf
 smOu7WtOuq86DnOHHK1wR/k1CRrLh+bjOebrr1V6XEFQGbO2NbVBnoTo+ZiSMg3S/rCvLaJJHvV
 bIfQ89Bz0aHwCQ9zjS7O7d+7eweI4bk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608280117

v2: https://lore.kernel.org/all/20260826150702.949956-1-iii@linux.ibm.com/
v2 -> v3: Check whether source EBCDIC characters are printable
          (David, Heiko).

v1: https://lore.kernel.org/all/20260825150840.537653-1-iii@linux.ibm.com/
v1 -> v2: Account for newlines (Heiko).
          Minor stylistic improvements: inline int i, bool return type,
          comment modality.

Hi,

This series adds a warning for unintentional EBCDIC -> ASCII kernel
command line translations. Patch 1 adds EBCDIC character classes.
Patch 2 uses them for determining whether the command line is
printable.

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390/ebcdic: Add character classes for the invariant subset of EBCDIC
  s390: Warn if kernel command line contains non-printable EBCDIC
    characters

 arch/s390/boot/ipl_parm.c      | 13 ++++++++++-
 arch/s390/include/asm/ebcdic.h |  5 +++++
 arch/s390/kernel/ebcdic.c      | 40 +++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.55.0

