Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6A363C64
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224438; cv=none; b=sZEWhGUojTpok1LKbqB0gFRw3BvmPW5HZ4UVmxKTstrDBDlGijHD0Lur2Ja6eHkbOSDKgQ7EPq1OkpnmTq+qICywLUSnF6rJt6iQn05Y8QKpTtIAHUo0Twky3ChGU0xMA1B0C49fZL1ODwEq3YhgorTwSaUBnn0p82/8DwVxX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224438; c=relaxed/simple;
	bh=qx6+PEQXAmICSGdozIv1kwAZSy7Jr2/fbNjvkRBGZnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTWz3LOsicvcSqiZi6yIeABoQqmvSuJTZvMR8XSG/GRzmTs7seahREnA3gGWrhJOxwJ7nUVyK/JbYmkHj9DGXAE8T+k26nwPaI/8asxjKajC5AJ7dTwkA1emD9N1IqrXwSVhfuf42rWFaallZeVNjEJlA49SNHxoHpAWC0add34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NK2Vm29k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NK2Vm29k"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmlH91858081
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vz6ciIYbw2FIVOHxxC/hPHJrg6WobTkE1ZBvu/2a/
	U4=; b=NK2Vm29kYX2AEC9oOnYLCf3DSyRiRN4xN/1HHZn1p3PPoPoxwypXvkuDJ
	WffiKAndwMvoyv3aLnYjZKBHdSM5C/sotWhWPJ0ZAvZh/VCb7F1aZStYAViw+t6a
	0jM9h1B99L9jyp51tBrt6am9FXMwgkNipCQBJNyO/eKpznCgvGGCM2VQcNOOxBxj
	fuBciXz9SMfIlUnrqR6gCGJMvUi3oCSz2cn5fdP+6GFTQY9GpNFFsX+k/g/teZZp
	4E9y06pFsVFU/ii7s6k1n/cVAxmZPqD/8MIIo5+NoLvkm1PRE1qVl8H34LbJN4Nk
	omZhBE1S2k6pEcPCdjVEpGnshwu/g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hq7d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJfCm012144
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg3ee6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:20:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEKVnN45744420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:20:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C2A20043;
	Tue, 23 Jun 2026 14:20:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 418F220040;
	Tue, 23 Jun 2026 14:20:31 +0000 (GMT)
Received: from ibm.com (unknown [9.111.10.197])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:31 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 0/1] pkey: Fix for PKEY_VERIFYPROTK ioctl
Date: Tue, 23 Jun 2026 16:20:30 +0200
Message-ID: <20260623142031.4053768-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CTY-xtH3gaGHo8p3fN9BSLbdgCGY9Lhy
X-Proofpoint-GUID: CTY-xtH3gaGHo8p3fN9BSLbdgCGY9Lhy
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a9634 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=9NpZT5uGZDCZsRst-LoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXw1AKzMlsphja
 YMvimboqNsCOQsLMkm5d2PG4CUCV6wZRFWS08GzQ4MwUEvEcu5fMSSWDQDnxDjiL4E4aTek6QJY
 nTjAlTs35pp5Te6FifPkDJjzUBOWBGDl7NcuGfpwn7F5Sb1r/DSNpIvIktlHQCHea7c2XEWfPm8
 oRZzTlYUmMccpQxw6ARbh1bmWeseAkRdbBvdygKqB514mAn5Vs3lx2Gsxmcqx1OptA/aGojB5N1
 DbSGvrCkJB6Rm78j9eBySe7pKuVNebTcx9iQTFgveG1TG2pZp5pq5Pt7ZAEqE4fGz1/w3iMe/DL
 y+igEFVuAoRRec0jGBGw0vm/D4gOIguqNgOjUmuCocvVi00rQ1BoarmJ1iKAZ1ezBrB7KQhouBI
 wtBF3x6mAWEwfIk63tqhNwwdLKvxacl3zoltuCN7KtZeA/KgNNTz3VHKezHYyOGhiUoOCNcHq53
 paYFNA/nynDVo/Y1klg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXzqerIvwUQT+f
 lEuj0G9kvjSKpM5X1jGUQfGWrICr4Tn6O9qPyLBGAyA11OHMbyet8ff5vfyA8B0Xcw61dJFV3FD
 J+36+TdmRB3eEi7234vC+TeJgwPaQcY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

The PKEY_VERIFYPROTK ioctl is used to verify protected key blobs. The
verification is mainly done y the called handler implementations. The
following patch 1/1 removes the (broken) length check in the generic API
code. The deep-inspection of the key blob is handler-specific.

The v1 of this series has fixed the length calculation for the keysize, so
that the correct keytype can be derived from it. But this is a violation of
the layering in pkey, where only the handlers should have a deep knowledge
of the key blobs. Therefore, v2 now removes the keysize calculation and the
keytype check, as it is always done by the handler.

The v2 has been rebased to the current master, as it adds a missing length
check for the ioctl request structure. This addresses one comment of the
Sashiko AI review.

Changes since v2:
- Re-phrase the commit message and summary line
- Pick R-b

Changes since v1:
- Remove the keytype check (instead of fix the length calculation)
- Add stable tag
- Rebase to current master

The patch applies to Linus' master branch.

Holger Dengler (1):
  pkey: Move keytype check from pkey api to handler

 drivers/s390/crypto/pkey_api.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)


base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
-- 
2.54.0

