Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97474CA788;
	Tue, 22 Sep 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071154; cv=none; b=SUHAFzIrXON0doJUULu0Sj1OzxSqhRGLRHZF68DURNoBfHvhEZxWI5YvsxBbAje14xQqPi6Cbp1KQm0s/DANLfQAmZUun8Z7ypCyd4LM4aJWrQBz0UIr+RlYenYFb+xdVG82QSfugnTEWHxfOMKXK+2Y6KyZPuLUd/TKyRYBwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071154; c=relaxed/simple;
	bh=aLXPD8hVMIScBAnEh43GfC45jExj6MoT8dMYJjWZlGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1+Cf/htAcTVxwucBVjbEJof0kJDm/3tbbZRzpzdN5sqJzlMfGmnPkWNOWNIrtwWYRW88/clzwOmPj8VA9o3HKh/LNIPhs4tcvtMuD8YKALTfnhxVwVF7zAcB6BvTOItUEcH9mCYHrTAtPWtZkMTyQ1lpp5Y7gQUJOzRkSrsnG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lBm86aCm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lBm86aCm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05TNS2788789;
	Tue, 22 Sep 2026 09:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sGLFyAHdL94XDk5oOmuqYngBVWiAbRh8fzBfKRwPd
	Co=; b=lBm86aCmWzr/QibPcym6904SpjwrOlUq2t39tKycgqAhhknyBySIDlqOO
	C1bhRc4/YM7nylel2TGYnrk9i9pYX97tu0SdIXTDoo95k4LJpxWL3lLFgq5tvDsp
	cGoHrtubRM9KPCEl7KbZFBdaT5Td7v3k6gNdBVDcLpia0lJ+iS73N0F1G/A2reR5
	EMN4jUm4fGzH/GpD6t2oo1AsBjn3ByFdA1W3Kna/mzT0G0cpCn93uabZXHfJvI8q
	ojgh3AKB5b7q13C414jVwSEDpXyv7xjkuKh/LuJF1DZpnRk/OG8cg16rLglVlDwv
	gMQwLirloWYHZMAbbAGtnXO0Oibeg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1cuk0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 09:59:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5WfkA764401;
	Tue, 22 Sep 2026 09:59:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkbu69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 09:59:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M9x5T349873272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 09:59:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C6C420043;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 620B420040;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v2 0/2] s390/sclp: Resize for sclp-vt220 console
Date: Tue, 22 Sep 2026 11:59:01 +0200
Message-ID: <20260922095903.1595794-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6bFN56IF64EeK1vK9U3Ml9VanMWa_hBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfX61/8PIwOatWl
 Bt6OtKDd5FsLDSc7Gz/neP9yra8XmFQ8HQLxgcQ8CSS7AuhRbqz5T920pBg1UUk9f6LGO5KBHHu
 CgO2D8ji9nWFzTxj7xSH/MW5L3n9O3gKabavAxgK/bynmTh3pOUJuMWEhj5IwbtA5PGNQWzicZH
 n6y+X4mPVrmjAJXfqKzb5C58GrFVvVAQWk28SDMPtsw33zazPYf42bysds9Z/Pd4mLD5M2jR4jM
 IogCSp3DsyZxR6NqFHj6VOvwZtBIOkDeBwoaNQdTkVOzZ088t3IsFZ3JktrmIEdBLMP2YbhVuNR
 w6XJDiw4RwqviB1DFS6cQNqvkVBSFPpCXu99onCShY8/zPkfLKTfFsppSI2nTHy47lEL2Booi3Z
 XMTrdxQCzcqzbMdH8gGttPy2ScHSYi3on8gqMAyfjyAfWsWYalArsbeoGFAsYvvR2K10KrjgJB8
 6c1mqqf7RuNkycK7Wtg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2516e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=GzOeRJ5xjq7qDkULuJkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfX/E7C2W5xUDJT
 FxDc7wbrDfODC7WdPFa7QHEVUr6NTH0huPLIuicLXFO0SS3oBZO7mIiEInUuLWhdDGm0ctDcWbf
 WZf5O9fs6YPUBz1LJhTd/xGVmLd3NRM=
X-Proofpoint-GUID: DC5dbDe0rkdBusav8aCxcrHa9EL4gLYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220138

This patch-set implements resize event handling for the sclp-vt220
console and refactors some of the surrounding code.

---
v2:
- don't set the initial winsize asynchronously
- validate sclp buffer length

Testing:
- Tested on QEMU: commit 38879a667f with the following patches applied:
    [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
    [PATCH v7 00/12] virtio-console: notify about the terminal size
    (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)
 - Tested on linux-next (commit c1f49dea2b8f)

Maximilian Immanuel Brandtner (2):
  s390/sclp: Introduce dedicated sclp-vt220 event buffer type
  s390/sclp: Implement resize for sclp-vt220 console

 drivers/s390/char/sclp_vt220.c | 85 ++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 13 deletions(-)

-- 
2.54.0

