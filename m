Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914811E9078;
	Tue, 15 Oct 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992388; cv=none; b=qQvFJQZSYGedJQld6tqQ5ffj8gnyPJXgmbSwKSsN1Q6dPys+wPX/OJXaIZkljwFCLeTHtijNCz05lg+JPVqTRyfVLWvLyua/pxyhftV9U3n6rzXkq+ZAmiXM1bXBmdqK1fInAirNQpAdyyRyAMQjXqoLVQYCYaxRFUA3+vX1zAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992388; c=relaxed/simple;
	bh=gQqdXQ2J1PoTP9aWhFNa7muRxUtDQXAKCylURmoV1/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVW8Kqu5NcgZolUG2y8FOEG57/r9rH/qphpnP6zrzHVkJHVBLzeUzpwo4AIA1NRkix1aKRLB759ahf2y3o7B9hsexZygG1YJr+EgQk05jGqWRJdC3hf//geM4AFfkfKGT/jnZ0kvDSWIjx7XG9/UhXoup9Zn4pfjFOFEe5K/C/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsNdsbRK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsNdsbRK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAqBRU014260;
	Tue, 15 Oct 2024 11:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WnHdtTw/R44vIE6j//c43L8mfMVlmhKrmZe2QWXsa
	Vg=; b=KsNdsbRKqbY8950uR/hXcpt3Pf2zg8pD1jZRkSO87NcjAlAKIYLn8SsQi
	kw6RuEf5Oenrx4s/oH++JIeUfBqTBDoHtlYNfLJe2TcmgZ0VfoE2Iy9AYenJIREB
	Qpz4PAdFrgjs8QekOXYHtsdCrM1y/pO2RyKxUDDU+Ph6uv/aR2lHIwbnnJNYUAZO
	+25BiZht3UxtP04pzeZSJPEURgD2S4mHA26T/CudByicXljIBIHF7pIYQgW+VTP1
	Z/KARHMC8/gan67Gla6M6tuj52bhoZzqy6ipcSh31H2Rot3yV41vvqDd5pdJHn9a
	P0vAAFG5tIW+SGW7sUJRoblPBf9qg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q0gg7n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:39:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAsGEZ002473;
	Tue, 15 Oct 2024 11:39:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emkjdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:39:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBdeqf39846348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:39:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C72F2004B;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F8F20040;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 0/2] s390/uv: Provide host-key hashes in sysfs
Date: Tue, 15 Oct 2024 13:39:38 +0200
Message-ID: <20241015113940.3088249-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ksv0WLPP3A9_qspHcWv4WzR0kcsKiL2M
X-Proofpoint-GUID: Ksv0WLPP3A9_qspHcWv4WzR0kcsKiL2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=718
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150078

List the installed host-keys in the sysfs if the machine supports the
Query Ultravisor Keys UVC.

As of now, two types of host-keys are available:
The used/primary host key, and the backup host-key both hastes are
available in a sysfs file.
For forwards compatibility an `all` file is also available that displays
the whole payload (15*32 bytes) and therefore future key hashes.

Sice v2:
	* add rb from Janosch (& fix nits)
	* slightly refactor sysfs directory creation (Heiko)

Since v1:
	* add r-b's from Janoch & Christoph
	* fix minor issues (Janosch)
	* remove an unnecessary UVC availability-check in uv_query_keys
		-> remove Christoph's r-b from patch 2

Steffen Eiden (2):
  s390/uv: Refactor uv-sysfs creation
  s390/uv: Provide host-key hashes in sysfs

 arch/s390/include/asm/uv.h |  17 ++++++
 arch/s390/kernel/uv.c      | 103 +++++++++++++++++++++++++++++++++----
 2 files changed, 110 insertions(+), 10 deletions(-)

-- 
2.43.0

