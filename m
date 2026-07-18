Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6C125AA;
	Sat, 18 Jul 2026 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784418474; cv=none; b=EXye9dDEL6R1DK26szjejRFFk2CDnc5WY44fbscZJUGxxeinsSNgoDtszJrwVCb1SOcVPRgkRb/kWtrqUNFTvl7ELKuqpj7WuadhQlf0osGKxcbMGFSu+OM2zz07N2XomP0TkL8DyC2pEzWEE5Bi3K0tjur8PNnOtrHp2JGh+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784418474; c=relaxed/simple;
	bh=bi33VAnDh1YsDPygmHORau4k9zlQeBDAAJ2Nno+S528=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ewTXKpfL9jz0ZsGDQGJofzqpbRu0MbdIX3gaX1tR8PQzrSNTpqN+41aZUabTJ8U+cpzCE6HOnSsfSaFaQVh8xba/tLs6+pfGsTCD44IJDvQzuT0pZ7Df9RWk3JJdbP52FNMdBlZ0FiwtRdYX9VpRRZSFH9Quni8XXQPGJUVy5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U5u+xWVU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U5u+xWVU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66INC5vG1889696;
	Sat, 18 Jul 2026 23:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=YBW/lTR3BcT9TixlkqYUek+2iLI2Jq39CPdy2HvFUQc=; b=U5u+xWVU
	19X4IMEjKGW3BehhmXbF4gBdd38MZ0A9u7VUugAZWlENADiYvqwdl/E/TsRSYEE1
	BU7aMNdlsgF2lCrXBVA6cf2R/L7Zxv8KU9+3io0RI/k1Jq/eZOkkciRtfpYIdoSb
	2lbBM/kM3oIp0+K9POmpRgYhEvMCtGgbe9ZKXDBm7MvtzXcY/wkomGkDMgYv7ftq
	O1mfiwPwT4XlJ08Xaloo+JqFaxDmQvvmAfGKev8jj+C3jfo6YJMnyZVFDH10yGiq
	e9thFo/m5Su6ZMuSJbGE34ISIOuhK7rJhGSEiXZ6Qs7wsXgHAdDlOqMn2YSxeSLx
	y2x77uIiPR7AAA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jss2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jul 2026 23:47:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66INYawi025889;
	Sat, 18 Jul 2026 23:47:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyq6x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jul 2026 23:47:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66INllYY56099292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Jul 2026 23:47:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0425A20040;
	Sat, 18 Jul 2026 23:47:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC26C20043;
	Sat, 18 Jul 2026 23:47:46 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 18 Jul 2026 23:47:46 +0000 (GMT)
Date: Sun, 19 Jul 2026 01:47:45 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.2-rc4
Message-ID: <ttiea3l@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5c10a7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=6-hqe5jbB1Gv4S7O8j4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI0OSBTYWx0ZWRfXz1ISZ3gCNfrI
 OxGXk7uwPcWZL2bN+ua9twdJN+rnLIVCgEKiA87aFUsrHwb6vfD2WS6hpQxauHKQcY3ZOog7GjT
 KKQ0TkYxXyk1o8LWHiIYV2l3z7cSeNk1EnkxkjHtPnocVU+kGmeZ4rP6jpodXNwiQZ3Dcig2Ya7
 eKBW8i32ymRXz9vWyhrR0jzNjt7hw1DaPIeMRVqMVdnXipSESw/ZWEx5yZ7PexLI2n/UxUcKXmG
 qiizBfz/WXvuIb+Iy1lSRkNATWH+Lp8g/aoeoeGNXoV5qV4hJCpn9K3u4l3y9WcARVYo7moL3Gr
 UPPIfQiAais1VomH3cS7M6K7EKeni9BtV2NHMbLSuEiN4KFlO0aPdjw1nyexiiWmAzvifPPsBPk
 W7g0emrvQsRWLasSpMWrljcWyNXjqjn475ap06S5oYsLguGyozPztLvmYIk0PD5BO+ETpvyXnsX
 dFqJaFDCO6y8ezoII9g==
X-Proofpoint-ORIG-GUID: mFESuX5F1keps3974tLe3ckn1PhReLy-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI0OSBTYWx0ZWRfX2xQhwKjbxwne
 TJE/PuETxpmyavkK8n3rKxfTixJikgbnenQDUtZD3hGEGrPCW40fKVdX2C2zPVXvknb8uokL6ao
 AvbgdyOSqxhz9MLc+pMlvE7Z7jSr/R4=
X-Proofpoint-GUID: mFESuX5F1keps3974tLe3ckn1PhReLy-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180249

Hello Linus,

please pull s390 fixes for 7.2-rc4.

Thank you,
Vasily

The following changes since commit 7d5c2f679147859c1db97d9f66366ff16909abee:

  s390: Add build salt to the vDSO (2026-07-08 17:02:48 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-5

for you to fetch changes up to 49145bce539117db4b6e9e83c0e5ef528e361050:

  s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init() (2026-07-15 17:35:42 +0200)

----------------------------------------------------------------
s390 updates for 7.2-rc4

- Fix checksum lib on machines without the vector facility where the
  non-vector fallback made csum_partial() calculate the checksum from
  address 0 instead of the provided buffer

- Fix cpum_cf perf event initialization missing speculation barrier for
  user controlled event numbers used as generic event array indexes

----------------------------------------------------------------
Sumanth Korikkar (1):
      s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init()

Vasily Gorbik (1):
      s390/checksum: Fix csum_partial() without vector facility

 arch/s390/kernel/perf_cpum_cf.c | 3 +++
 arch/s390/lib/csum-partial.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
