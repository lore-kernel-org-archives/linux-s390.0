Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43E3A782C;
	Tue,  7 Apr 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556529; cv=none; b=XQEvLZxIHpEltcm//5ZktLcK+OngkuRSNf0yZgSho6rE8yXHjbSVjw95osFbMGiyz2H3upexTY/FWzxsecSpNK1hfzY5530rFowtKCf76ITcFD/v2GPPJvMk1tI/Wu7bp62xn5NlBXInh/pTNP/Vgkalm/iPGEeH/Z9O+SANUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556529; c=relaxed/simple;
	bh=y+wZHBBuv6OmfiTwBCTB3dAha9ht1zMg+gczz4B6fPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9AwmWCnLZ2JP1+HIFn9RKSasowoPQ/tQVMjqqWRhg5Yhf3ix2ZLpxDxGq0fLNJTVEVWswbc0hb0zYK5+AxXnd8D9UMZxTDQqmKB5VjOvPNZTp7jNoTWWPlux8vyuBNdpoEcSN6rNikyOObHfGDRbtMHQWdbvrzUqWjYUa9w5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GEH2B004; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GEH2B004"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmV2J2297920;
	Tue, 7 Apr 2026 10:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RxyVhq+W7hWkFSDwfkR0t/Tq/UCVOwz98937dArA2
	hU=; b=GEH2B004aiJPQaeP8HAcAUDgeu94gfJ/z0TmskVYvOK/yDOykjoRbjlQv
	RTA+iw5gZqxDEnDLPyUTn6pi29lXYKS0cUBq+lwcjZutfcA6uSRVkD1Rt2ZvBeKS
	eD8SLGmmpQFKnMmRqFU1oKD5R3vPQwDLEhoz5gsUcL8zNqIq5PQSAI72HitD4Ffl
	gHcNOWe2jAXWXbxYFcyFVTPTR4LEQdMzngfr/TxTJ7jC/0S9F6XdivIXRdWVxMLM
	5VGQ/MPdwIOorZiugh1Nem4PTsPEocpyMXw6U0i8WPiQVDr4rjzZcbMG3d8nG4rS
	LPwFQ38nNIj9Kr9faMo31KLJfvJhQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ft4cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:08:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6379Jbbu014378;
	Tue, 7 Apr 2026 10:08:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4j1mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:08:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637A8e0g30933348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:08:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE4C200A6;
	Tue,  7 Apr 2026 10:08:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E23B200A5;
	Tue,  7 Apr 2026 10:08:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:08:40 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
Subject: [PATCH v3 0/3] perf addr2line: Rework disable_add2line_warn
Date: Tue,  7 Apr 2026 12:08:32 +0200
Message-ID: <20260407100835.3488645-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4d7ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=1fk0JtzURXIa7KAGPxYA:9
X-Proofpoint-ORIG-GUID: 0FlshzK9u5kpuanYps__oVhr_lucivPp
X-Proofpoint-GUID: 0FlshzK9u5kpuanYps__oVhr_lucivPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5MCBTYWx0ZWRfX7JQynuZiDbzR
 TUqONJ1EHyzLSmZ83GYLbbW3FnZ2VX0BIkeQMds8gqFRuOehUqI/nfCH1OZNN7jypATdDgZCuVv
 1MAGaHGkFNOM6mUGo4I8LZGh3/cyGM5y4Z1jxAwxKLuAqzD1YxzijqOAKvvMww1nXi1p7dJ6lF8
 nEWozO0XqmBPT3K9PUXJRkUPWbWGoRtJzcxWCauftVR7PoR9wg2OppiBJyDoSoGccu9MOEfgFQR
 9yQN16T92LsO5gdLr0I4ffNQEFLPtfa3Rhwamq67l90lkPKyOWQazvPcj3ImiQag7KKwGHe9YoH
 6xmEyuxnGQq8wH+6f8u2F5jnN7ByyTb0Czf03JlasfU4O//GWOJSXoPRvsSUUymFQsCED+M1vwJ
 vJ/ID/mdZCr2FN+mniviSiQYlbOEWT3Ekfzm+DXjDNdvVgmdwJDHQ4zEZ1oFpj5DsCzzwet+LtZ
 sbDQ3A9mahqIh3zQfvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070090

Introduce configurable addr2line_disable_warn entry in the .perfconfig
file. Clean up addr2line configuration.

V2 --> V3: Added comments from Kim Namhyung
           - Use perf_config_bool() to read addr2line-disable-warn
	     value
	   - Move perfconfig.txt update to proper patch file.
	   - Fix invalid default value in documentation.
V1 --> V2: Update perf-config documentation.

Patch 1:
   Rename disable_add2line_warn to addr2line_disable_warn (with 'r')
   and start name with prefix addr2line_ to make it consistent with
   other addr2line_xxx configuration parameters.
Patch 2:
   Enable symbol_conf::addr2line_disable_warn set via config file.
Patch 3:
   Remove global variable addr2line_timeout_ms and make it a member

Thomas Richter (3):
  perf config: Rename symbol_conf::disable_add2line_warn
  perf config: Make symbol_conf::addr2line_disable_warn configurable
  perf addr2line: Remove global variable addr2line_timeout_ms

 tools/perf/Documentation/perf-config.txt |  6 ++++++
 tools/perf/builtin-diff.c                |  4 ++--
 tools/perf/util/addr2line.c              | 20 ++++++++++----------
 tools/perf/util/addr2line.h              |  2 --
 tools/perf/util/block-info.c             |  2 +-
 tools/perf/util/config.c                 |  6 ++++--
 tools/perf/util/libbfd.c                 |  2 +-
 tools/perf/util/symbol_conf.h            |  3 ++-
 8 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.53.0

