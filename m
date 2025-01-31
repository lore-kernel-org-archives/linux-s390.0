Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0D1B423F;
	Fri, 31 Jan 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319314; cv=none; b=YsNIYJv0j3ck3BfXOuCuCMNqAVwsYs5r7HVKfJnbtWcJKoyHnsaaqL/k8bKiFrTwDvkniwgOlXgqMT7mqiiaBmK6Hd6uVyFtoF2Fvf2cPW0Nq6wqIQKyCthk+KR/5VeeW2RmcwNzJ/TKM5hstLq+s3Oo4tMDMyXhw7FngWqQGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319314; c=relaxed/simple;
	bh=Ngn+x8n4rSzMDa4wvTm2K4/vqa/gKvM4HYdaqrX6lUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVO73eKjkF1ls0Zc9UKVC4n9zeOwKMR7Hl9dv3GGXqUO6DR1+nNppo20lHFGXHshWuvYWPllpHFF8HVDsjsRmoEuCkGPN/hcdUYe/7emg2U1iHy8WImMqrZk2VTSg7HVQWA8KHlVSESI6XNyA1qCtZV0C8Zu8k31yzBxCkP8nS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bEZwpGVW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bEZwpGVW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OMvx021899;
	Fri, 31 Jan 2025 10:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JoJ3ONbSXjxLwrAbvzPcLxFgL2I7LrPSZ3omA2BJc
	qY=; b=bEZwpGVWAaO/o0CFBIRiqtHF/vGGjtGdPtk+kDHPSd+b2/xvmmLKfyD6u
	OzBV2PDjHAkmYICW83SQEhhO4lKHIey09tYca1kSyCV/9J7Fa+ESKcM/wu5RjaOr
	YhutLosROnpsBoZIf779GkKHDty81cVg47d6cCeBLXqttz4Tb6MpA7J+6NHG97+G
	Xz3pCoH6HNzGBq02+vKUkrs+LgAlkdlNW/z3HunCS0e3HL5oNQb7Pl72+S/pdvLW
	Os03Nls2AZZFSClK3fDbj5U4rk4X1gosgkuFCiz5hY+ivpa5882149VLCtDZaaA4
	iUzYDDuo9+FwD1skF5PGRXHLBiL/g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gnby9qwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:28:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V8C3ot017213;
	Fri, 31 Jan 2025 10:28:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gfayb3w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:28:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VASJW246793206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 10:28:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E7982004F;
	Fri, 31 Jan 2025 10:28:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6C7F2004D;
	Fri, 31 Jan 2025 10:28:18 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 10:28:18 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, linux-s390@vger.kernel.org,
        james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH 0/2 v3] perf test: perf record tests (114) changes
Date: Fri, 31 Jan 2025 11:27:54 +0100
Message-ID: <20250131102756.4185235-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nJ1lRXxB3AQiatglAv5QQdLXkrY0pEoG
X-Proofpoint-GUID: nJ1lRXxB3AQiatglAv5QQdLXkrY0pEoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=799 clxscore=1011
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310075

Change event intructions to cycles for subtests
 - precise_max attribute
 - Basic leader sampling
as event instructions can not be used for sampling on s390.

Thomas Richter (2):
  perf test: Fix perf test 114 perf record test subtest precise_max
  perf test: Change event in perf test 114 perf record test subtest
    test_leader_sampling

 tools/perf/tests/shell/record.sh | 53 ++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 19 deletions(-)

-- 
2.48.1

