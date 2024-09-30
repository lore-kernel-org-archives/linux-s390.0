Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458318FDC6;
	Mon, 30 Sep 2024 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702449; cv=none; b=Uq4thWjr+Q/7zlZgjbQTLhiC26a2Cn19KeEdO4bQKJOBHYo2xtymxdDliY9mxn1lyaKNHq9ccXSfbLN1Hlb7c56r6XJDWqV4V9pTV6hv5nxOGsfNQzICo/F7ReJ008PZBzmG1zMFpDIvJYb2SpTTTAWE9tJ9PveU1rG7r2QBC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702449; c=relaxed/simple;
	bh=RSdPsuydLh/xReaS9IZvMjWPR7ZDsdMEg5HCkTbHtBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttnijA13lU4m8/RqIc2RZAEvdh6nrzGsn2YOJdFn/RVBkDtxmyHyIDy5eVsRcMUJJY/sfuNk5i8UTkT+K0hVOIKsIniLFS1oxNpax1pVRTAHkuJQ0lHnG7r2XkNJV1Tl4sFnN6nPB9KLjesPFkplkdeMMJHeL3zZZCme/HAoNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mh9KcWu2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mh9KcWu2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U4TLll028920;
	Mon, 30 Sep 2024 13:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=oFRca6SKIuBDfRBcze1cD09YpX
	QgjOZdZNuJc0SHdB0=; b=mh9KcWu2SQE5r0krl3yeWo0M8cEoeuT3crby8zB3Po
	1w2Wc659ac/ILhMZJ62h4gl0OwbFPaE8180zQZ1jk3EVuHZPPm59NRay8cbTolGG
	fFoxdPhiIV3bDEnEnix9ZMLvjPIAUOYHIKiA45w1YJVGUngmcQLj6LV7AUBVmA12
	dq11kps0kSfkQgT6n+1YO3N4/IlfA7YBj3468R/mATYcwCeo8K5FnPesYkp0db2Z
	yA9cHeICPj5fgOidGi2B7zP+Bo1Keq/UoDpmfD9PVU+fwy6QdkiutSRw9VHI7QXt
	dPi+L1sAqci4d0BPQiW7S+Ts5648DpzN0t22bCG3NbJg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87khr8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:20:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC3vR6013073;
	Mon, 30 Sep 2024 13:20:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6evq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:20:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDKgvW55640380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:20:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82C5E2004B;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F6220043;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 0/2] s390/uv: Provide Host-key-hashes in sysfs
Date: Mon, 30 Sep 2024 15:20:39 +0200
Message-ID: <20240930132042.2081982-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YjQWDd_nEZINU3aDyeV2p1QVPJK6ZhvF
X-Proofpoint-ORIG-GUID: YjQWDd_nEZINU3aDyeV2p1QVPJK6ZhvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=604 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

List the installed host keys in the sysfs if the machine supports the
Query Ultravisor Keys UVC.

As of now, two types of host keys are available:
The used/primary host key, and the backup hostkey both hastes are
available in a sysfs file.
For forwards compatibility an `all` file is also available that displays
the whole payload (15*32 bytes) and therefore future key hashes.

Steffen Eiden (2):
  s390/uv: Refactor uv-sysfs creation
  s390/uv: Provide host-key hashes in sysfs

 arch/s390/include/asm/uv.h |  16 ++++++
 arch/s390/kernel/uv.c      | 108 +++++++++++++++++++++++++++++++++----
 2 files changed, 114 insertions(+), 10 deletions(-)

-- 
2.43.0

