Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C1330327;
	Mon, 26 Jan 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422733; cv=none; b=lqyg9FOANEguz4aZQCrLK0aR0nE1ZDmpKcC1i86etbKLM1IWAsP35/RoB2yTqReQgMn/WUfnkK6cAMKjXiIVcobITeejGba7V7Fk0jgSJX34kJQ3/75O/RgpRzywQ26Q+yRd4P0qfbHSPBun2/G85IXUEXoYWyNYWxJzThaNgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422733; c=relaxed/simple;
	bh=Ucmve+dluwtbj64/JNEJDhr/8sDAs37zDDHqIbQQZHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6AsLN+O37OnON605FGzyv7+0iWxpLciuqKKtck/GXNSNQwqxGrAHAyiydRl93aJspt7GZRnnotsOHNxoJa538XcZXJwHtMfF/IYEgoIVu81MsO9A1WEOt30Ni793Kcjsz0+ZfTS/pVJSJwg9J4USKryZoh2lrM+/7nzXUh1SHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dWWpu+o1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dWWpu+o1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60PDP21P021571;
	Mon, 26 Jan 2026 10:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2qjptHA0YmxDPIgJHXhmwBovQ8WntJd8SiYn0/Dpr
	q8=; b=dWWpu+o1xH4/2suz8Gn0MqbQyTLYzeSz5BLuffjifaIx2FW0/3Q5xVYwn
	Eazu/t/XZKJNjCBpARXT/kjSDBx18VJSVrjN6zvbiFm8Q+eIbikusB6LnYoKGheO
	co7wKOMAmHptnlayg4UPk1z67MWH2WEx/tPhnWUqzGrBLT95xBCE5sLCevYDGDvB
	XpK8RY6jb6P3gZxkSgbK3co/GC1/kcZ21+HNU0B3l3kHdTf6QgLATNZ6Coqvclkk
	PBbFazRCAFZ5NrVH6j/1IatjA7w1tse4OcJDZLPvhnfD08HnLa15U1stWW0Mhl17
	fCskIsH7Kvda06odsrgehPa9zkYSg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7fg30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 10:18:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QAGaHx025557;
	Mon, 26 Jan 2026 10:18:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7fg2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 10:18:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60Q5oc88019630;
	Mon, 26 Jan 2026 10:18:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dmv67k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 10:18:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60QAIb8l61669794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 10:18:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCE332004F;
	Mon, 26 Jan 2026 10:18:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2702004E;
	Mon, 26 Jan 2026 10:18:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jan 2026 10:18:37 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH linux-next] perf test: Fix test perf evlist for z/VM s390x
Date: Mon, 26 Jan 2026 11:18:23 +0100
Message-ID: <20260126101823.2090077-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lcn6XM0tDV287h4KNVlgvwpqvVKko1Z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA4OCBTYWx0ZWRfX5EmYOGKpqBkm
 2WeOwJDngoAOv4Y5i5oyUrQQEY9rGtAklme+yBaFP4+3sXazqMc70CtYdsiKG6ph7Cie+1z/T4e
 YeKh4uAu5MF0zKrtHxTDxkP5aqpj1oJaedpZ7+bn7lDHGQ742FfoB5hPjkIyhpEQ6bocZzlV8z6
 CbTqGtEuiFT49pvvW83QEiWTrycB20LOT3olO4qi8lmxhS9DHCn92Glu9Zw4UtjRzWlIkYedDl/
 KZ/oJoz9ne1ow5IdXQtLQt+ACfB4KTgvNzYKDC91UqeFwHF3/e66C02XbSAGmO4hhQ1B6WSaqeY
 O7ir0MExb6M0yH8aiq5rRZqdUvdqSE4soOsPTmNp26m93q3m3AKyxOtH1J4GFJmCQ3InNFV+Ewh
 b8sVUKup6fz/pVwNX1vT57U9vjsXXZswisyDkcmS040TW4rrkWT9eDZKaIxKa8MRygf1KQliKA8
 d4/xC1qSVjpEgfBgz9w==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=69773f84 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=wtJ5Ps83P7bbEB45bnAA:9
X-Proofpoint-ORIG-GUID: 44tDskLyFHCKiXVPU9L22Dosj6seD7AJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260088

Perf test case 'perf evlist tests' fails on z/VM machines on s390.

The failure is causes by event cycles. This event is not available
on virtualized machines like z/VM on s390.
Change to software event cpu-clock to fix this.

    Output before:
      # ./perf test 78
      79: perf evlist tests              : FAILED!
      #

    Output after:
      # ./perf test 78
      79: perf evlist tests              : Ok
      #

Fixes: b04d2b919912 ("perf test: Fix test case perf evlist tests for s390x")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Jan Polensky <japo@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/evlist.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/evlist.sh
index 5632be391710..8a22f4171c07 100755
--- a/tools/perf/tests/shell/evlist.sh
+++ b/tools/perf/tests/shell/evlist.sh
@@ -21,13 +21,13 @@ trap trap_cleanup EXIT TERM INT
 
 test_evlist_simple() {
 	echo "Simple evlist test"
-	if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null
+	if ! perf record -e cpu-clock -o "${perfdata}" true 2> /dev/null
 	then
 		echo "Simple evlist [Failed record]"
 		err=1
 		return
 	fi
-	if ! perf evlist -i "${perfdata}" | grep -q "cycles"
+	if ! perf evlist -i "${perfdata}" | grep -q "cpu-clock"
 	then
 		echo "Simple evlist [Failed to list event]"
 		err=1
-- 
2.52.0

