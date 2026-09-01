Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA69396B96;
	Tue,  1 Sep 2026 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272758; cv=none; b=GLEeD+3NqavSBCJcUfEVwWKljDubpA7Ko8lnNRkRaCrLgDtl/gM/IW8oDg+RujWxGa+STmT3EsAxtACPfgSXdvJ1VO9R8+jqi0jwCU93wjx14dhHFW5asFPMnlv4CBWAqtKJkdoXw/dPfZm+TgZOEoCgLEHp6aZqLOoJIfsyhi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272758; c=relaxed/simple;
	bh=OetrBdaUkNoh+YpnlDM2CQCFPDRKFd8H0r2sfWirlhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBw12YDnaHgCbaRuf/CN1aHJcsF26PEFXzn0wv9VRCsL8mXPd8NmmtmaU+ni/7JojTFT+TQWk5VJzt7uOpz++DA/0sBWKemXePQEEYfqIWyZV4Yi79Kp81pbOtQ6obNTL8PbHygn9A9iqdxBNMsFFegxhxBENsuPKMJSWqm34QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J9mIYh/y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J9mIYh/y"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DW75J1212497;
	Tue, 1 Sep 2026 14:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aynttLdqPdDBOMkin/svfzy3txJbFRgGJoMRuB/NI
	qM=; b=J9mIYh/ye/0xZUXkojq+4l7qF8G+JmOE7UG8kSS/6pf3He489n7XXRMYl
	x6FQE7f8fkmD8va/j5AcsyC+7OQoU6xCWEs8GY3E4frazQNutqVuh9nTJihk3MWJ
	VDondMStRD8csvE1hxDkI9haMh/X1eVOeJCy1atV7Kr86KPxvZ0IR8lNy76UPLyY
	3hzUKQY35A928PnymZvCisWABQ8Grlf+4mPXGRRGL1pjdDld2KCT4m6SS/1WR85h
	tov1UhtnrlkB3wsKxEinjMpYFnbhpgcFczG8P+Gt+X1zSDuKhjHGGDT+nw/cAlY5
	nGW6n+En5dxe+ZNJCyzeejDmzxV9w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhrcpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EBgZZ008556;
	Tue, 1 Sep 2026 14:25:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hc3dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EPpxd50987450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:25:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3670D2004B;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F58C20049;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH 0/2] lib: s390x: Add more snippet macros
Date: Tue,  1 Sep 2026 14:20:24 +0000
Message-ID: <20260901142538.42553-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mvG0V-j_rWD6b8_8hJK4deQCvxLbdq6j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfXx399FIaJBnU2
 e1Kb1uHrYFTOoFS+I8Q6th1agfTadULWSHK9af7piFkrOUiZ8WaYd2Avw9der75Juy8sF9smHe7
 H6kVuCO1xEsQdWQWpv4AiZ/hmyvV1II/6ddFAqR8FLictF4+x60YSm7odF/R30RSVAYWNi/hqYn
 RillvSnhjRIcq/lrqSDBULY8Q4esdzm69Z/z+GuiGfRRBJzLf80UcPu8B9Vo4px4dylcAOgZBLs
 ywwx7B+WvCcexv4pG+wrmZA0xVQNWYkfINLZMQzxb+tqHOY/xKNHS9hhOSP+/7UbhFM3HhVlQ4Q
 /FjxTv2tVV+AoXE/pwz/4CsLpZ9PaPy7dmqR2vh0C6vc3OwwYvXMgLAk3zMXs/cSoNBqrvDIDGY
 rf1l3kytvv+W0DqOf7o1BR1tl80U0xbp82du6CQF8KUpS0rdfq6qQD8sldxJZmcivZxjHUJq8m7
 jscItABj2aXWB6T4OYA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96e073 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=hwsu-SaitElJ0EtvLaoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX5NDWokJF0ypY
 ijM98fvdvMq6JBh0+pFVIwezbFLuQVKAyq/o1fjLJlrlkfmXaJAko5wrhijtuGryHjwjq7w1sF3
 uBlqIv/mGcMJixmYbNEsOac3vbm46DA=
X-Proofpoint-ORIG-GUID: mvG0V-j_rWD6b8_8hJK4deQCvxLbdq6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010124

I'm trying to make things easier for developers (and me) before adding
arm64 support. The upcoming code will add arch arguments to the
macrosso that we won't have to duplicate them.

Janosch Frank (2):
  lib: s390x: snippet: Add snippet declaration macro
  lib: s390x: snippet: Add setup macro

 lib/s390x/snippet.h | 27 +++++++++++++++++
 s390x/mvpg-sie.c    |  3 +-
 s390x/pv-diags.c    | 33 ++++-----------------
 s390x/pv-edat1.c    | 12 ++------
 s390x/pv-icptcode.c | 72 +++++++++------------------------------------
 s390x/pv-ipl.c      | 12 ++------
 s390x/sie-dat.c     |  3 +-
 s390x/spec_ex-sie.c | 10 ++-----
 s390x/stfle-sie.c   |  7 ++---
 9 files changed, 58 insertions(+), 121 deletions(-)

-- 
2.53.0

