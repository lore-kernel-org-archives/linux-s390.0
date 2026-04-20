Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151A38A718;
	Mon, 20 Apr 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674987; cv=none; b=hR5YOedLwMORmpP2Wvl6USHiXtXWe3HNThQQOuYpapY1FotkDcgbRzomiqnn941hZh2GJdqpy+v68Kz+6oW/aYht/d6YK9pkwe+8PoHaUt4tpvgxfjrhRnSONt3Eh3tvCP5UDnh42nGeJZiA4C80xgTsK/jjk6vVRrsZU378zAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674987; c=relaxed/simple;
	bh=Y3lR5KNuyy1EF7Sc29npCYKeohMI4aw55lPebp4t46k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPrb3cC3N6ngJXLnR4c/f28Kc8kCiS1gnWgYhGkx26/aS5/pWFNO6yG86jkNklTQ9rXd8CGeN17hjRoofBF5WgitTpkHkftjWf/PaJSAHDi1n9NwVH7BecMcZdUJ0fw+c6mA1keGBp28XMVtz9cpyj5hDRAfHdLnlD+2Sv4Lyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CpEnxl3W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CpEnxl3W"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JIJwfF2672875;
	Mon, 20 Apr 2026 08:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=V5yhVFLt89bq0joR15iNrwzH95vhCYO++kH744E4E
	uk=; b=CpEnxl3WPp9b8wPRJYusK7tf5NjEzR4sUqTj//LobNYERyqNJSkzWYnk4
	AkeR6POU9WgP6dkqMQY/87osBp7XstFo+c7kgZldgWoYRw0M9VMoWhtRWxOzIA70
	aysJfPj+a3nUZ+Xbpcl7M6+mlwlK+E+thdvDishW699XCXF4JacK5iGznrJAV7xq
	90ewTxUAJn07xW6EB5FJpYeElIekIMwiZTYacu9mA+nS6NwDmI37ToEyOnlqs8cM
	ONTZTWYeEBsaMl9x+MC8zyPDMKjoYUlDeDEAjyC5BPJX4bJsTC7LAYew0GPONFc6
	QzNmbuFBK/36nCzFykYfxjR0dnz0w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6eap1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K8ZOmg012605;
	Mon, 20 Apr 2026 08:49:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvm4rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K8ne4249086834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:49:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C027A20040;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 983672004E;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH v2 0/4] s390x: Cleanup virtualization library
Date: Mon, 20 Apr 2026 08:44:21 +0000
Message-ID: <20260420084933.251244-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e5e8a9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=i1egRVeOCA4yOCXTAOoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NCBTYWx0ZWRfXwljWGQPFsWZk
 kBZQYstQ+WQ1EOBQAkhdtCCtJs8YZOHwuv4TYj0avqFdr0tnRJyaOfs4GkIJApKbI42EnCZDpfM
 598S6eCEFXtWBnll9sU+U36FixgcXIfDlsairLHFuCXKYw07mVKzCRBztdVxDv3hFiXY7j2sUhX
 rO7LiT0rFq9/q6kwmAGQWIsvSzCYujgXFF9QkrgWz+qUIj3j7ZrNsSyU6CWZObf6tt+ic+MUbck
 /PGoCfLU8L3N7VhGKcr3k7eMKDHJorITQRcDNiKcyogKpdoitYhUtLxN0ccRtplfwW7KB9zsuYI
 maUcuCcmPiRvFKF8zi+8zWms+fv/EtzZuFrs9aoUY4F/qz+6E6PjV8ITbGYzqyfmlw+DreZwZpJ
 fN3ZCWKBtUPWU0sHN1K6ru9FIuua33OG4AsKtPTSk0dIkEDWjW3snqb+zsBWsrMzs8warenkAVP
 j4rdDKYSzNzAi+2YnLA==
X-Proofpoint-GUID: GyG8t871XrJqkZPRc3AUSGuwRXv5O1cD
X-Proofpoint-ORIG-GUID: GyG8t871XrJqkZPRc3AUSGuwRXv5O1cD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200084

In order to support sae virtualization we need to cleanup the library
a bit and make it more flexible when it comes to guest creation and
allocation.

v2:
 - Renamed get_page_root() to get_primary_page_root()
 - Reworked patch 3 into a general sie memory improvement patch
 - Removed the sie struct rename patch

Janosch Frank (4):
  lib: s390x: Add function to get page root
  lib: s390x: sie: Allocate physical guest memory via memalign
  lib: s390x: sie: Memory rework
  lib: s390x: snippet: Add function to create a guest of specific length

 lib/s390x/mmu.h     |  7 ++++
 lib/s390x/sie.c     | 89 ++++++++++++++++++++++++---------------------
 lib/s390x/sie.h     |  2 +-
 lib/s390x/snippet.h | 19 ++++++++--
 s390x/diag258.c     |  4 +-
 s390x/edat.c        |  5 ++-
 s390x/mvpg-sie.c    |  4 +-
 s390x/pv-diags.c    |  2 +-
 s390x/pv-edat1.c    |  9 ++---
 s390x/pv-icptcode.c |  4 +-
 s390x/pv-ipl.c      |  2 +-
 s390x/sie-dat.c     |  4 +-
 s390x/sie.c         | 13 ++-----
 s390x/skey.c        |  7 ++--
 s390x/spec_ex-sie.c |  2 +
 s390x/stfle-sie.c   |  2 +
 16 files changed, 97 insertions(+), 78 deletions(-)

-- 
2.51.0

