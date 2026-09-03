Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5B38757D;
	Thu,  3 Sep 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420974; cv=none; b=KetQlz/DdrgjGwRSlyA3YLbksiLnJkaKXENgaqNodnFxpLoj1Styr60GlISckA+a9IvnbC7DsayfQsDXa9qOMlnBa0dKG54q0bf1PCEHrldnkVb56oGRvhwhAu7/Ngk9W0k1jFaCWB0NVUf4ZK9M+CD3bNJEtFlBzzJSuHg1z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420974; c=relaxed/simple;
	bh=nMOyK365D1TqbSwz41x50J/AGNeUcCkUe8D80ReXNwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIuQEZMtVmTE3KpUq18pRv6tILCouksNRh25VD+qDzgIGCnN40oPPNpi7pjwei3LNAw+ullP4PBlWD8L7onDeNlir11EyDtDzEL+sqA36OeAKISdOHLqXN+dYXwUNXnSVkY7+crMXM62f6mHZAVWPZZxWjD0YUoB+K7eEXMnSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TPUu3ty9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TPUu3ty9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361arH2186848;
	Thu, 3 Sep 2026 07:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pyUiU4XAaakmiPGWm4axo0nemtxAGv0TKkk7s1/gG
	w8=; b=TPUu3ty9atQN2txlSN9eHjRJF1bRs1F0Eu/KXchjRWPXbuIkH0OrpPzKR
	WyQdi5uDlPzBR+FAMsLRAZpgb9n5JGlkCHrPTnhE6IWKdEv8oolZUeNYdDDJ4o8y
	d8HPvxQzBoPIk9SuwJVpIrSEYr2rQbimbcK9R1PBHVB9UAAiNigl7lCatvxEn+qV
	t7LyyL55O0hXvCscynW/NP24AlpKduZ5NgOS4VfL+clw6Lz5fOylGX6mTV/Q6wzh
	ROkWLegzz2oKzimbyY357FEbPOdURep3v6gPtJDo2gN4tE30AwYfJTd0oMJTMiBI
	N1cIPmoKCcVV5gseg3EAe8uqvNMVQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq553ps5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 07:36:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6837QOJS017213;
	Thu, 3 Sep 2026 07:36:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyecxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 07:36:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6837Zwh242992118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 07:35:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA7D32004B;
	Thu,  3 Sep 2026 07:35:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF1D22004D;
	Thu,  3 Sep 2026 07:35:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 07:35:58 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Aaron Tomlin <atomlin@atomlin.com>
Subject: [PATCH v2] perf test: perf stat tests fails on s390
Date: Thu,  3 Sep 2026 09:35:53 +0200
Message-ID: <20260903073554.1300334-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NiBTYWx0ZWRfX03wCTyj11TbA
 HkoqlYcWMObpWAZQZsxS6FvdOyubRBg+5j86C+IvqRMoIF2iN9LEASwfIdvnz+RdyGHklSP2Nvq
 U7lz4Ri0eb5PsHsaT9cR92hkIux6XuL1O3caD8sHJ8rHWTwZjBeoYQUKu5h4tUjN9RlDHP5mv6p
 Qnl53v7QVIVwoIeuj4P6dy/0u/AmJWjk2tJCF0U27gtOkH5afRZd2cihmqfkuz32sCYGDmz6dAX
 g3HSNQeACOsWqm6c0u3DqrQ1CZ2Wt+ag/bykL1QtuuEtjdsOjM/qLTB/qpWwuqjvUbwSS2eU5mH
 2MlYYfLc6kRck4RVyIJm4HMbyvBOruq2fH3M9fTK6ig0XrxXdWoO1odKtM4cORo8luln9tzi9Sg
 eBbPGynUzE1xFC28or5qPHRw9mQKnmkF04nkuAT+eyb7aMsWktjgY6d+SFHmbtSLZvWCdemik4j
 BtdtKCTzB9W+AmT1o7A==
X-Proofpoint-ORIG-GUID: YdrjnTATnE8N1WvHSgah1E68hGkeNACj
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a992364 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=j-LfP5YGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gXY4od2GetYiyHjr92cA:9 a=pci6KG57UX3UzFLC8IW4:22
X-Proofpoint-GUID: MM4LKn-H531hMuOJXFo0arNxqgrnIpVc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NiBTYWx0ZWRfXzITRxBVc9kOB
 y16xFReAkSuqkA4Uzpn6mc67fC88hpa3IJN163+wKHB1oLicEduGDMhQOSUrIlCH20CVArcnp1I
 aM1q7E07LLvO/Bc6AzOFhlrq/aw7n6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030066

The test case 'perf stat tests' fails on s390 z/VM machines. The
root cause is the unsupported CPU measurement facility on z/VM.
Therefore the events cycles and instructions do not exist and
are unsupported. This cause the subtest
  Hide zero events stat test
to fail.

Output before:
 # perf test 116
 116: perf stat tests  : FAILED!

 === Test Summary ===
 Passed main tests : 0
 Passed subtests   : 0
 Skipped tests     : 0
 Failed tests      : 1
 List of failed tests:
  116: perf stat tests
 #

Output after:
 # ./perf test 116
 116: perf stat tests  : Ok

 === Test Summary ===
 Passed main tests : 1
 Passed subtests   : 0
 Skipped tests     : 0
 Failed tests      : 0
 #

Fixes: 64724095a33f ("perf stat: Add --hide-zero-events option to suppress zero-count events")
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/tests/shell/stat.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 298ce454b45a..1f5d4cc05807 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -583,6 +583,11 @@ test_hide_zero_events_stat() {
   # Check that --metric-only works with --hide-zero-events
   if ! perf stat --hide-zero-events --metric-only -e instructions,cycles true > "${stat_output}" 2>&1
   then
+    if grep -sq 'No supported events found' "${stat_output}"
+    then
+      echo "Hide zero events stat test [Skipped - events not supported]"
+      return
+    fi
     echo "Hide zero events stat test [Failed - metric-only command failed]"
     err=1
     return
-- 
2.55.0

