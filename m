Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FA1D0E08;
	Wed,  2 Oct 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885066; cv=none; b=dXtJy3+ZxHYX3lyymip0BtN5s4rpFJrxaXO1xT11XcJ1X1beMPFI4dqHcnv2/BHkAyGMovh2ISF4P872M2FI4H2XPYXZtc9PoAOg1aqm0MwzUlVCzeopuwDrnfPrANWainLwEu5UAzdMw9Kx6SYhoIicct/paY/3/HqZ8yMbnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885066; c=relaxed/simple;
	bh=goCeIwE/K6fvry7QHqVlNK4qO0s3mpegDJuob/o0llc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7ydLJ9+wgUF/Hur1pTcnAqbklEg1zFRbxVm8iAHnbr7uXUwio2HphrcUrqf7biJ0AeKPPILGdsBgxxVcu7COLkNi9mFGM3yMQLO5/pPlCKcjMdmbVqwRRjoPz7T1vuyynkAuBRX/i1zN07eVsdKENnKSfYWpEEp1PSPw7cq5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HJWUaIb3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HJWUaIb3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FlsMF029034;
	Wed, 2 Oct 2024 16:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=/zxPmFu793D67n31PimDYS6Nw9
	Bt7up1i0oSVuEZuqk=; b=HJWUaIb3QgOngUSyKl5WLnOzysLRvEgM5NCly/nXiG
	kLCYv4YKR5bKq/o7xbpRmsJvjg7UfTfovGAgQkcXtno5LJlu+yHDoic9btJVBMf1
	rwN+2UQbwjTCTGkpgUQjpqnG4c1hmlhyUri3C8/Kh7XvOew8KTyAt/hGyrCFhpgF
	MHI/5RPxhdiLa58PjVkefRS39Wu6LjJVDMuwa+/6VS5eqhdp5Ua+GIlbN92rSmPs
	rCQbmRjr3+2otPsePcQOHY2lt9087KRR2+G3I7Pw/Z6EZNTmjHdPzptLlueMjIW+
	K+I2H3ncBAj8yiHrHhg8raSY+qTf4YCU7mEloz4uDCiA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42194n82wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:04:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492D1tqZ017866;
	Wed, 2 Oct 2024 16:04:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4n37ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:04:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G4JMw57016628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:04:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3700B20049;
	Wed,  2 Oct 2024 16:04:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E076520040;
	Wed,  2 Oct 2024 16:04:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:04:18 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 0/2] s390/uv: Provide host-key hashes in sysfs
Date: Wed,  2 Oct 2024 18:04:16 +0200
Message-ID: <20241002160418.2424889-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _RjeZUIgioQZdofT9ZdWNM8SJHKV4HPe
X-Proofpoint-GUID: _RjeZUIgioQZdofT9ZdWNM8SJHKV4HPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=643 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020114

List the installed host-keys in the sysfs if the machine supports the
Query Ultravisor Keys UVC.

As of now, two types of host-keys are available:
The used/primary host key, and the backup host-key both hastes are
available in a sysfs file.
For forwards compatibility an `all` file is also available that displays
the whole payload (15*32 bytes) and therefore future key hashes.

Since v1:
	* added r-b's from Janoch & Christoph
	* fixed minor issues (Janosch)
	* removed an unnecessary UVC availability-check in uv_query_keys
		-> removed Christoph's r-b from patch 2

Steffen Eiden (2):
  s390/uv: Refactor uv-sysfs creation
  s390/uv: Provide host-key hashes in sysfs

 arch/s390/include/asm/uv.h |  16 ++++++
 arch/s390/kernel/uv.c      | 105 +++++++++++++++++++++++++++++++++----
 2 files changed, 111 insertions(+), 10 deletions(-)

-- 
2.43.0

