Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85F397687;
	Thu,  2 Apr 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116943; cv=none; b=SQzt2gEBefIGkCclaBqZymyHw40PiTaIgl/GLOIoIbMEMjMCZJRGwhAfTOnuslFS+VxrslaMUMvLVJ/t9Y2LU1iOcZcL2hKAJmYbZqjHNqDLIROddpBIaxhw9f8aNKWAjouyktdiE85dYg09A/fKk0/+h7Uhm+YmisWnu+Jbqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116943; c=relaxed/simple;
	bh=44YzGD9+INr6lYgU4EyVr7swE3tPesdsDoU3uZywdQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/F5Cq9WNvGvysyDPEaqnz1Yf57+EmeOd1jYl/fjVpjMMmLhwBb+oQLdCzN8C+sFmpHIRluy6ysSTZWY/2CqcGYjOumMeHIgNaP1AXyYMy2HkLmGnAhSeuljNSx5JCA+aeh9ZQ95SQcB180ySLFx+9puzYDTu3iIaGGYZQrkKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p3P2poTm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p3P2poTm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631L6uEI033664;
	Thu, 2 Apr 2026 08:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0GAbzszF88x0mMt/C
	nZcmr8doij4un+qelMRZozVp9E=; b=p3P2poTmZdWvYX9AhkZtNlIgU5daDCLT+
	c8b5qSI6cRh8tLhHfce2lcVG7/rTq8ZMzMf6qjRJ/MMockhvIunNM4y1Wom1pjZY
	Ks8VqWf7/GCLzwJbbKY4kce/BNFMznz+RVkDBMzhq1SQCdZd5W/scgP9DnZsHx3a
	ROPMKfcsllKlhb0U1GH7INkdGof6zCLPOqoJpxlYgi1baoMW27uAMgKzCsxkBFem
	Grv07xDkZJrbMEzwFRNoIXoctr4fmgLvBunwkC46a7NE3u/U7xgtqJ20s3uAvODl
	V5W1jhQddnWTKpYM4x+Nz2TCPYFRsQ9YXbMnJD6BxaUmkc0sct26w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgu5t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6326noei013898;
	Thu, 2 Apr 2026 08:02:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttks4y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63282ENO44499310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 08:02:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4592004E;
	Thu,  2 Apr 2026 08:02:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F16C22004B;
	Thu,  2 Apr 2026 08:02:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 08:02:13 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2 2/3] perf config: Make symbol_conf::addr2line_disable_warn configurable
Date: Thu,  2 Apr 2026 10:01:58 +0200
Message-ID: <20260402080159.2028733-3-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402080159.2028733-1-tmricht@linux.ibm.com>
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2OCBTYWx0ZWRfX4hcipJQSr7JW
 Qk7veaW5GYugz3gvuhF4FpgRJjE9cGShi7lX5KJ0vO0+QC3W1TQ4JG80Z43UH8EYN7Sha/CQam4
 8GeG1Bdc82q9N+1Va6euqtHBcI0y3K725tYSb9bg2oJLrnT7CrBPR7yWMfrWf6h8oS93bZb5DQ3
 liamxSvyJWZsP7K5DBydq2qgewAbeFRxkh0MMl1w6uT7O7aUhW+Rl+reWPeRjGLyiZW1CAXVpXT
 OPJUN0KlKb6urbruJ19BRqQqFYetCaE93W3HW/x/MYa34ubIu9LFkfxaS228xhRtQK74AH8DPek
 VQGn6arh1OPjm5BwjAvd/OYtkuTOgUfCTYxEIEe4lVHKn6S0BC9Qa8NpTIDtw+rBIdG9kvnzOWg
 kzGwNnVVtK5nLsYbcyKwjJsmm6gC5J8cISPs6tI8uglNwR2f/GNU2AEYOT77dx9ne9W1QyNGgW2
 eZGDpX+9WdLd2BWIIiw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ce228b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=zTooWrBoGe05qeUdyokA:9
X-Proofpoint-GUID: LVteUDG1EqwzjHFfOkoikG30ErLkKJnt
X-Proofpoint-ORIG-GUID: iOmO77Werey5djHKHiYZzS6TSKXPw_uV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020068

Make symbol_conf::addr2line_disable_warn configurable by reading
the perfconfig file. Use section core and addr2line-disable-warn =
value.

Example:
 # perf config -l
 core.addr2line-timeout=500
 core.addr2line-disable-warn=1
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 0452fbc6c085..31541e03aab7 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -461,6 +461,9 @@ static int perf_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.addr2line-timeout"))
 		addr2line_timeout_ms = strtoul(value, NULL, 10);
 
+	if (!strcmp(var, "core.addr2line-disable-warn"))
+		symbol_conf.addr2line_disable_warn = strtoul(value, NULL, 10);
+
 	/* Add other config variables here. */
 	return 0;
 }
-- 
2.53.0

