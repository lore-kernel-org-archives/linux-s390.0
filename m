Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32F3D5255;
	Wed, 15 Apr 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243158; cv=none; b=bc24MWR9CCDCjdxxPF2yfkObbTvHAtzuI9jvnf72/5yAu4oEvqWqdKO56ia1Wr0HavrJ4u9Fm1D38yulAJPE80ircZ2zgra1M3KLBLa1XHpTy1LAhFE4Pzcx01enHT/z1loB6638KbDyMcfBwQfs+DeiYyD0GreJRngnbZK66Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243158; c=relaxed/simple;
	bh=EP6RMEMUmeVOV0ELjMYb6YkkvrsZU73iDPQT8+6WJDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2PAqeWuPpQ3nptDPmaMObj2p94PHXv9VUgcobuhij3IAjztrM9h4TGWcUDV5tHLJxlBGVLH84r1KgNmrPYorOcGJt1s6VlvAu+/c+qtAsivoLV6h9El62ujWdiuxwTRkI6H521GuQjAi4g7WcnAqpyq6nD/7ZhIjqfxJPbwTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IA1MgCQW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IA1MgCQW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F2x99j1804500;
	Wed, 15 Apr 2026 08:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ywUBwE7pWttTkKrHMSVm3b2a1AQX/dT9c3TncdcSd
	KE=; b=IA1MgCQWz8lorDnQNSg2zRgAUEQe92ZIEteVEONNlXiMz8O04q+6cioPb
	fncjtG91yTQGLRNFTSGfjmYYuuHrfptLntE78t+uhxnnEaE9qkqv4YeCiFuCORXn
	VQVnjBCorDaZRypfFYqtj7NF3r+cXQUl2HFnNU4JCJSqITUh0e9wLpuH0SYKqn6F
	q1XFCZQN2zHrPZfQzyDgDARwXSHI587gWbrSPIzEqAzD/zKY6jE5q9i7sBjdMPTn
	bCxSTAMrPak1WFG1kFipCIwTY6pqs2diAnFqPVDEsv+FDkGKK5iNspSTffwrziu3
	/AzfojGoyQlNCNUGt+ZnU9Uutek+w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k6q5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F3ZEel004569;
	Wed, 15 Apr 2026 08:52:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kdb51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F8qVst50332030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:52:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 682622004B;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E8220040;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 0/5] s390x: Cleanup virtualization library
Date: Wed, 15 Apr 2026 08:45:40 +0000
Message-ID: <20260415085145.91197-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zrL1m-cD_kpcQTbhBDKnBIjUlJS3rPuz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MCBTYWx0ZWRfX7ueHxLxge3kr
 CisOiJ/ujAFl2uaeFhJvqvHlM1Lwv9naGGBGGy14Z8TIv41CwjuN7gLlUbEaKxSBWJpbnuUtVL5
 zEKNKLSB/Xl5n22D3OoXyse5XMr6P70tDmPdI4NArYRpNeN10/7+XdX2Ng0Qfy9H/coxGzVEHxL
 cvRqfyDGGl2kcRo9+G70YIdpnST5IvsdxsqU2R+TCTOstX7qdjXJ0ZIE3ONcYAa4zWuCXeBpCei
 YACZ0bOcRWLldDNbOKEzgeiFdJ3HpFcPPXXsHIIN/pXqjo018olFCgF9f0+fwcVa1PddA2rhe/g
 TyEPb1Ol8cE7dR2AK8QrUXH04UTDbZX7qz2zcS0nH6eFXo+bdmBjLQA9+85/YOMxPVTjaYWD8VR
 r++rIBfFGQq/MZAXqSHN0eDRFDRVmF5w0y6kKgHBXDWtb2IKqew3qhN5PLdXsoycxTD6NED2AaE
 u3ETebbVsfBehrFr20Q==
X-Proofpoint-ORIG-GUID: zrL1m-cD_kpcQTbhBDKnBIjUlJS3rPuz
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69df51d3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=z0a_xg6OEB49L0uGEeoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150080

In order to support sae virtualization we need to cleanup the library
a bit and make it more flexible when it comes to guest creation and
allocation.

Janosch Frank (5):
  lib: s390x: Add function to get page root
  lib: s390x: sie: Allocate physical guest memory via memalign
  lib: s390x: sie: Free guest memory on destroy
  lib: s390x: snippet: Add function to create a guest of specific length
  lib: s390x: Remove kvm s390 prefix from sie control block

 lib/s390x/asm/sie-arch.h |  2 +-
 lib/s390x/interrupt.c    |  4 ++--
 lib/s390x/mmu.h          |  7 +++++++
 lib/s390x/sie-icpt.c     |  2 +-
 lib/s390x/sie-icpt.h     |  2 +-
 lib/s390x/sie.c          |  7 +++++--
 lib/s390x/sie.h          |  4 ++--
 lib/s390x/snippet.h      | 18 ++++++++++++++----
 s390x/diag258.c          |  4 ++--
 s390x/edat.c             |  5 +++--
 s390x/mvpg-sie.c         |  2 +-
 s390x/pv-edat1.c         |  4 ++--
 s390x/sie-dat.c          |  2 +-
 s390x/skey.c             |  7 +++----
 14 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.51.0

