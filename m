Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99443C047;
	Mon, 24 Aug 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582307; cv=none; b=VOpPCiLUOJ+lhF83O3tlQ76+tY+f9Q8I7NwR0aDkuJB9wuSBN44l+6izv/JbQEMBV3QPgNFLHxUv9ScJupT5LO36vi1HY/HGZ6lT5AaRLMjkKvmD89p14e9VUlNhs17IBq6MKWBRM3lP0m3XN+akOQXazFgdekabqVzLHG6rblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582307; c=relaxed/simple;
	bh=lWrLqsbjw4gdRWC1YHC5HUillwRX++Oo0TQMzPa5gmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFSlxIhlzXGhwaFY7hprQeRgIIzLnPA7DETT06xSiapiKoBzSMad5exKiR2FgjsLfo3bTVGlm95DihGmKbFdB2nVwJ0fw/14l4NiPo0+1keqyM+VTZuoRW4VZnE+wIJVaPtJZbeeytkElSseoRqmNwSQ5iaxB7cZqjyUAlr46pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lbd9eDEN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lbd9eDEN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1XZ6085114;
	Mon, 24 Aug 2026 14:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2rh5WgdRcKQgaMAYWNN6UkigXsZsDXKzYuzsOVwXu
	rQ=; b=lbd9eDENGg/sel+joLKiKzmpos9tQgCI8L1kf1356WVwDxC751/MrPgM7
	ZlyBng0QnM3NmTLDaw/ttT02q4FvPV2+lXtgt8mlre5B61SiraAkYetRJwFvcbdC
	J4VwMrLVBYcJTR9T9kq1NGNe/rgj/CLHiDvqSZirMWOr9TWiQHl2q97o2QDc7yBS
	xxBOcHXlRdZ05VOMfOg2dBDfI1EYfXTw0X4PYIxNjy1eeSBH3hsz2sbNFIgFO9oY
	v496c2xpHfypB/FQhhmpO4EVFw4tiXU3p32kNifTm5vRQ5t0Njw875oVfXM7vkb5
	b09J37vlmpk8oy++m4svSIheNJgIw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhytm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQJ3h030489;
	Mon, 24 Aug 2026 14:38:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgxfg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcFrb51642762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EE012004B;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F08020043;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com
Subject: [kvm-unit-tests GIT PULL 00/13] s390x: stflei test, fixes and sie lib rework 
Date: Mon, 24 Aug 2026 14:35:32 +0000
Message-ID: <20260824143740.291583-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qohMy1fBLsDMB2dfwIRB9u7daaUL6Kc7
X-Proofpoint-ORIG-GUID: qohMy1fBLsDMB2dfwIRB9u7daaUL6Kc7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXxnO7kBhWQvv1
 pwOockzsizAa/XzbgzY9Fp3+AQdTHtGU/U94nFaYsRFR7x2dEfJhaBt1qMqfgOslyHBI+vYCRTt
 88ndXaRnD3Eog8n+r0NsH160rJswwSL4jcweTulGgrqWd04WYLy+D4Hem+TsdKglcLwvhMqopLO
 EB85sbt3WzIa6ytQ9gWesrJbVR/Yf58rQDKwEfvWIL8tsJtchvAmTt8/tut9Kjpfj1Q41sZNXVL
 6eT5DFz/WLu5VKVgQZ+pxAW9RYpINEWXrmTwnxXpW780lToc8wBPWUyXb3BzazJfKm95AP4Hsw4
 Z2zrMIZYi4qLVR7gNt7Zld//XRvM8KniL8X2f6BxpuqKcvq8VccvdOkVVanKFhkGjUUUVGKAFzX
 tL1QXlM69xs8EfFFitWl3YA3U7ol/vr6WWFDdwF7SyVnN9dyO2f/C1SfoTccvdt0sOR3EBa+oQC
 QnFtxZ1xCrldEk7315A==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c575d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8 a=L7rIzAvtvG5meCXRt_cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX6WrrfUhfr3fQ
 m0OJ9xZ8SLJ6882sWHkGaEs3a5vDBNAQ5IS2zooHSsNziuMHReZT2iD1dx6CkHoxI1G4HdySTH9
 MMH34FvbgoRjF0KQv4OoS9b4jMDsptk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

We've finally accumulated enough patches for a pull/merge request:

    STFLE interpretation facility tests (Christoph & Nina)
    stsi 3.2.2 regression test (Christian)
    sie lib rework & fixes around test execution

Please pull/merge.

Thanks,
Janosch

Pull:
https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2026-08

Merge:
https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/88

Christian Borntraeger (1):
  s390x: stsi: regression test for the STSI 3.2.2 count clamp

Christoph Schlameuss (4):
  s390x: sclp: Remove unnecessary padding from struct sclp_facilities
  s390x: sclp: Check sclp byte before reading feature bits
  s390x: sclp: Use sclp_feat_check directly to read DIAG318 feature bit
  s390x: Add test for STFLE interpretive execution (format-2)

Janosch Frank (6):
  lib: s390x: Add function to get page root
  lib: s390x: sie: Allocate physical guest memory via memalign
  lib: s390x: sie: Memory rework
  lib: s390x: snippet: Add function to create a guest of specific length
  s390x: unittests: Reenable tcg for migration tests
  s390x: skey: Fence TCG protection checks

Nina Schoetterl-Glausch (2):
  s390x: snippets: Add reset_guest() to lib
  s390x: sclp: Add detection of alternate STFLE facilities

 lib/s390x/mmu.h     |  7 +++++
 lib/s390x/sclp.c    |  8 +++--
 lib/s390x/sclp.h    |  8 +++--
 lib/s390x/sie.c     | 22 +++++++++++--
 lib/s390x/sie.h     |  3 +-
 lib/s390x/snippet.h | 25 ++++++++++++---
 s390x/diag258.c     |  4 +--
 s390x/edat.c        |  5 +--
 s390x/mvpg-sie.c    |  4 +--
 s390x/pv-diags.c    |  2 +-
 s390x/pv-icptcode.c |  4 +--
 s390x/pv-ipl.c      |  2 +-
 s390x/sie-dat.c     |  4 +--
 s390x/sie.c         | 13 +++-----
 s390x/skey.c        | 15 ++++++---
 s390x/spec_ex-sie.c | 12 +++----
 s390x/stfle-sie.c   | 74 ++++++++++++++++++++++++++++++++++++++++---
 s390x/stsi.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++-
 s390x/unittests.cfg |  7 +----
 19 files changed, 237 insertions(+), 58 deletions(-)

-- 
2.53.0

