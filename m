Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F142F39DE;
	Thu, 12 Feb 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900827; cv=none; b=lSWZ4WCqz7X/AhUYaCvyvu4EiXWO6JB8ucFmkf146fX+kzPDK0nUNLkgL79lAxYE/iLnzJZPGZq6NKVJosTPS4BWzzZE2Qp5sEmJIExekMf6HJKkT1F3F772MPf7R6jV7g0mHsui1RmRgRlJVbaLFx4NgxDRggEkBw7pZ0OIwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900827; c=relaxed/simple;
	bh=KcgzCkqEtNXky1CQfL+85yMQ2DEAeGtXazF+INdVsbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwC2/K1v53CZBSQ7DZcl0vA6Dc22HX+d5WBBaJ46Mujx3/sU97IHge0UvR8ptn5ejZp3gy3pdvqKa7Be+YWFe4pSidMMdzLKy84F7YyW38LhPXuI6ti0N39aMTAqWwnqpMEPm8ruHOAPFwNTc4LCI1SbZNL7WuuS/yAPKF5WOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mk3xUFtY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mk3xUFtY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C16A70235984;
	Thu, 12 Feb 2026 12:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MegMCZ0LCQEfaM4xRTMfYdN9TxUm7QTj4F5eT5dAn
	Tg=; b=mk3xUFtY+OwQb46Y443azD/ZdepLg60MGhWtk5+3iaimrSVSt9WMOZZvz
	KmIZGzMVY+Y3og5a7JucOQlpWm0jrwCUkSgmbxibZpkFJf9Gcf3yWXPSLD3y+yR6
	mx3hDcBJUNIEZBhpaHbjwToS0YbENSafDEshwo3Jt+u8G5sBhxSdc3WrIL1xqvlY
	urwHoR4psVgVuXkAeUZDPviV/c6gAtEvxAd8zQE4+mTGKdREZ4U9jNNMOsn+iIwX
	DeczwT26f8K4I46BFeyE2vU9wigOg8mr7YAjAhK68dQZijwGSzv3xHBVK+vbY2xr
	EbHHXlxmZU404aJguz9Ogx4YKdRXQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696up7bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 12:53:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C9E0TM012623;
	Thu, 12 Feb 2026 12:53:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kjb36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 12:53:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61CCrVsv23200080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 12:53:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92CB22004B;
	Thu, 12 Feb 2026 12:53:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 614FF20040;
	Thu, 12 Feb 2026 12:53:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 12:53:31 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        james.clark@linaro.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH linux-next] perf parse-events: Fix big-endian 'overwrite' by writing correct union member
Date: Thu, 12 Feb 2026 13:53:15 +0100
Message-ID: <20260212125315.777356-1-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698dcd51 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8
 a=UHkrvoB-SimJn0k8XG4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5NiBTYWx0ZWRfX7gCRaEN95BrE
 Oy04jluEwg/gdUBSI6BgLway4UNR4xNFWCr2Aae23waT60r4/+wEVpUklKABqqdJmaUON3WjIB+
 EHcbOxYtZcsnKruLczXaQ+TT0GIlrUoIGBHZRTV/xMFnE8atQ7GszeiHcJgrQ5RW7eL7/RCFWr0
 6fRVKr+GtMkHCbSJ5BeY0LRAOliItyjMjFqpHJi32e6aaQw00lZjLfZ/YWGDXHcZmDo6Ar6Uium
 A12AxHPMPdTi2N9SLx/T6g3WycUM08QO4qM/kDK9XeOv9sPb5j7QPSv7vPlEhbbbYsRA6baM9gj
 +gRGeIyUy2mSNAHffNo1jhuCzcCimyGVzDKalXnfPClXnH4QfZHDzHCMOTwYGG0jaTvmSAzVe0r
 HSpbzz6tthqAhdGJLdjmcFFQtehwya6oSq6W4xlxFBkylZd8C7g6zefVAOgKgbkvjeSu8zybtKf
 zQwdd9dHol2MO6rffww==
X-Proofpoint-ORIG-GUID: HEEoFUZaDDjFBv50EVXNyMNmC2dCrxYn
X-Proofpoint-GUID: Z79QE5XREdSB25nkZ2zdDh1mcnHOXbJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120096

The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
due to a NULL dereference when the backward mmap path isn't enabled.

Reproducer:
  # ./perf test -F 'Read backward ring buffer'
  Segmentation fault (core dumped)
  # uname -m
  s390x
  #

Root cause:
get_config_terms() stores into evsel_config_term::val.val (u64) while later
code reads boolean fields such as evsel_config_term::val.overwrite.
On big-endian the 1-byte boolean is left-aligned, so writing
evsel_config_term::val.val = 1 is read back as
evsel_config_term::val.overwrite = 0,
leaving backward mmap disabled and a NULL map being used.

Store values in the union member that matches the term type, e.g.:
  /* for OVERWRITE */
  new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
to fix this.

Impact:
Enables backward mmap on big-endian and prevents the crash.
No change on little-endian.

Output after:
 # ./perf test -Fv 44
 --- start ---
 Using CPUID IBM,9175,705,ME1,3.8,002f
 mmap size 1052672B
 mmap size 8192B
 ---- end ----
 44: Read backward ring buffer                         : Ok
 #

Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 49 +++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d4647ded340f..12fe5392c832 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1250,7 +1250,54 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 			}
 			new_term->free_str = true;
 		} else {
-			new_term->val.val = val;
+			switch (new_type) {
+			case EVSEL__CONFIG_TERM_PERIOD:
+				new_term->val.period = val;
+				break;
+			case EVSEL__CONFIG_TERM_FREQ:
+				new_term->val.freq = val;
+				break;
+			case EVSEL__CONFIG_TERM_TIME:
+				new_term->val.time = val;
+				break;
+			case EVSEL__CONFIG_TERM_STACK_USER:
+				new_term->val.stack_user = val;
+				break;
+			case EVSEL__CONFIG_TERM_INHERIT:
+				new_term->val.inherit = val;
+				break;
+			case EVSEL__CONFIG_TERM_OVERWRITE:
+				new_term->val.overwrite = val;
+				break;
+			case EVSEL__CONFIG_TERM_MAX_STACK:
+				new_term->val.max_stack = val;
+				break;
+			case EVSEL__CONFIG_TERM_MAX_EVENTS:
+				new_term->val.max_events = val;
+				break;
+			case EVSEL__CONFIG_TERM_PERCORE:
+				new_term->val.percore = val;
+				break;
+			case EVSEL__CONFIG_TERM_AUX_OUTPUT:
+				new_term->val.aux_output = val;
+				break;
+			case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
+				new_term->val.aux_sample_size = val;
+				break;
+			case EVSEL__CONFIG_TERM_CALLGRAPH:
+			case EVSEL__CONFIG_TERM_DRV_CFG:
+			case EVSEL__CONFIG_TERM_BRANCH:
+			case EVSEL__CONFIG_TERM_AUX_ACTION:
+			case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
+			case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
+			case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
+			case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
+			case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
+			case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
+			default:
+				new_term->val.val = val;
+				break;
+			}
 		}
 	}
 	return 0;
-- 
2.53.0

