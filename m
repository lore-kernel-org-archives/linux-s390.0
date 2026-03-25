Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78C330B0E;
	Wed, 25 Mar 2026 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440409; cv=none; b=eJyHt48wG4SAQnKCmBo+PuplOzMiFszQvJzwIGevJtUx0j6pEwBz5BMP4Edf3rGnRFNTQi+rKQSDfQ8xDnp7lnOq4COtQA2FY20jQf+YgMRs3xUYkFxvQK+5SQx6XgCZNkLc2G6AfHjmjsseh+38Ig7/kBEUzVVPijYzPEC2IYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440409; c=relaxed/simple;
	bh=Phojv8xa88+dfb7WbhdA2HRQTRwjKmMaMbD/DrbmijU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0ibP4C4IR39s16dntkVVQEI5BaP4zlkwdliri7ooeaQQn/JVZ2JsuxDKRDwItRzNCkkN1IXFCBIK0D3XjfqfhUOo/45wFQf2W0eWGl9Zu2kxUbflYJyscKaZr9ps7pGJDZVg/JfgIuvVOEdMpPDMyK+MpU0uMn1ms9UqntH3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MFP39t5s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MFP39t5s"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ONqHit2777768;
	Wed, 25 Mar 2026 12:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=biSVFnSqK6ZzQ5nO5D0FUnG1jS2nF84gDgSaFfCYL
	9Y=; b=MFP39t5sBawq7DkwUHf5ZJSlp61K6HKzTiWI3WS2L7yHAILQlA24KtGdJ
	rRumw6cNnHe4UMPa+K2oUNz5nuKVdxQdxFFj+AiF/giG01LbrIcEa7BfAU4htfdx
	CN0RgCkl8yE9AySkwKx0DhXT8x4WTan4rDA6J4iMI2LZyyoz6avv8RFFnDKiQBPK
	yxYzwG45av6CrHQ0SwUZ88rbFuTNLx2bgIfPtkonFVDZmffXCTIBxjfzFXyQQfec
	UEQ4Jl6wVRqrct2I4+AzDJrzVDQiN1OmU2zr1W/+pd/n1+7KUlx5lorw74WJTz/g
	qBgoZ4GmVodCMjiYzaUWuwtRM69pg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa08tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PATmDE005991;
	Wed, 25 Mar 2026 12:06:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ypgwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PC6enK28377454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 12:06:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258422004E;
	Wed, 25 Mar 2026 12:06:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3C572004B;
	Wed, 25 Mar 2026 12:06:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 12:06:39 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
Subject: [PATCH 0/3] perf addr2line: Rework disable_add2line_warn
Date: Wed, 25 Mar 2026 13:06:23 +0100
Message-ID: <20260325120627.1841175-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FcZ29mXjYcqB3mGbuenG4eIEee2qYtFo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NCBTYWx0ZWRfX2zVUoaWvh1e+
 IimTSg2HCC+CKFKHx8E2pZrKZ1zr/m4o+Fwf7j2uzvuH5VaQvMZH6FvrcVUv/4QmkXR4pnMZZEo
 uRhaUCcamtyj3sm3ceUZxBeoRSX+l2lUdmH7s4Kd8On91YXBwBILxTBXMZSl/B5yvPZ4A8wZtxY
 fgzrG9WOKT6jwAusFLabJ2vpszR79UnlXtAV2a0GjZ63tHf8bw66l5kDrLorPzNwl85APQ+xzRZ
 hplORQEG20G3EtBIMgJ/zqvCIFjyE7ynYrh/rI+gB0krorGTIHKVgA9R2o9VkkpA0BkP8CWqYdS
 fPd5L8cObE40YoG9/1omdvZv7cjuHVMNgEdo8Ik8D7obSS48SfwmdK9mZyHuVBwy8qElyhdS/8p
 LCk8+IVDlDJ9sMY0/mhyl95z3pJmLj3kYAMW0+B6NCid+bjC6lFAN6QpXTQ9CWQ/pcxL0CjXkr6
 g6i7P1dAV3zBank/Iqg==
X-Proofpoint-GUID: u8lPum-mGpggvSJHMvPYyhqlDxwjavUA
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c3cfd5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=1fk0JtzURXIa7KAGPxYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250084

Introduce configurable addr2line_disable_warn entry in the .perfconfig
file. Clean up addr2line configuration.

Patch 1:
   Rename disable_add2line_warn to addr2line_disable_warn (with 'r')
   and start name with prefix addr2line_ to make it consistent with
   other addr2line_xxx configuration parameters.
Patch 2:
   Enable symbol_conf::addr2line_disable_warn set via config file.
Patch 3:
   Remove global variable addr2line_timeout_ms and make it a member
   of struct::symbol_conf.

Thomas Richter (3):
  perf config: Rename symbol_conf::disable_add2line_warn
  perf config: Make symbol_conf::addr2line_disable_warn configurable
  perf addr2line: Remove global variable addr2line_timeout_ms

 tools/perf/builtin-diff.c     |  4 ++--
 tools/perf/util/addr2line.c   | 20 ++++++++++----------
 tools/perf/util/addr2line.h   |  2 --
 tools/perf/util/block-info.c  |  2 +-
 tools/perf/util/config.c      |  6 ++++--
 tools/perf/util/libbfd.c      |  2 +-
 tools/perf/util/symbol_conf.h |  3 ++-
 7 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.53.0

