Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28AB672;
	Sat, 15 Feb 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638884; cv=none; b=JW/8tUsEGXKq7R+5ltGnNmNulVs3ox557FYfoLDzM6tu6vcam9XiEtAntIGYJh5/RTlN9QKYPOHrErrn0g7XnFWYSG8Tc6ZZQmA895EwDs6fKhVPo66JG00n8OQSqbbMD8OqyWyzXS8Idhn9nv01PTST30VEpTO7nCRN4CrNFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638884; c=relaxed/simple;
	bh=2AKGxYVPIAM+l2qG4staRqXMuWUgBxHOeZQb8f3VM0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sqvkHvV7hOIA0JtvyhEgyb34633izdC/z54Lj0qIlGx4MrHFi0m42mlNmtkzB6qlYbxQxabno3zr3Qpr5nQ9ADXHS1+Nrjp55UN0eIRpdnxhIWCdAZyfDql0eTw98HDo/jggAkiHfb7UHyhPSEYc3PlsLJdyfwSFPueFcoPXPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dOyhy/Kp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dOyhy/Kp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51FGDq8p011119;
	Sat, 15 Feb 2025 17:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=JQql3gZk0qgX9xHEkE+nIvCugZHS
	5eNWyvY8wF7gd1k=; b=dOyhy/KpLmd+16n192pc/9W5H7CD8PUiF55tDpnU59OI
	vIK23P40BJLMruD/5e3qY+cUBggVJ/jrsN9CW6MOeBS1U1kr76VT5J38AEUfjugV
	n3LLDokblBy+Fv+Ra5wxCUeethuQwaahxoyMo0eZ/uUeCkDJonnnRBp/TxiqIx7E
	kkAmujsbLG9r5ixGEy3WFn9ibt3/VxBAkbMVuMuB1L/D4gbQWpvUJH/AyI2cMqrg
	HBQgZ9AyaW09Zbm9yf7WHiBBeU6+qa8ckzsDrYI03Hvsnxi2lQtaD3/owyK30RUA
	UmvlFPfs3RHhYDbLR0/s2skXsUTHcLuFTLMT7MJosQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44tje7jkfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2025 17:01:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51FGOsYW011642;
	Sat, 15 Feb 2025 17:01:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktkgs3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2025 17:01:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51FH1Gt721102872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 17:01:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7824020043;
	Sat, 15 Feb 2025 17:01:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1678D20040;
	Sat, 15 Feb 2025 17:01:16 +0000 (GMT)
Received: from localhost (unknown [9.171.86.41])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 15 Feb 2025 17:01:16 +0000 (GMT)
Date: Sat, 15 Feb 2025 18:01:14 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.14-rc3
Message-ID: <your-ad-here.call-01739638874-ext-6275@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dXbFTc0DbvqCEc6545pU07m0ZZcQqMS2
X-Proofpoint-ORIG-GUID: dXbFTc0DbvqCEc6545pU07m0ZZcQqMS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0
 mlxlogscore=482 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502150146

Hello Linus,

please pull s390 fixes for 6.14-rc3.

Thank you,
Vasily

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-4

for you to fetch changes up to 2844ddbd540fc84d7571cca65d6c43088e4d6952:

  s390/pci: Fix handling of isolated VFs (2025-02-11 19:35:08 +0100)

----------------------------------------------------------------
s390 updates for 6.14-rc3

- Fix isolated VFs handling by verifying that a VF’s parent PF is
  locally owned before registering it in an existing PCI domain

- Disable arch_test_bit() optimization for PROFILE_ALL_BRANCHES to
  workaround gcc failure in handling __builtin_constant_p() in this case

- Fix CHPID "configure" attribute caching in CIO by not updating the
  cache when SCLP returns no data, ensuring consistent sysfs output

- Remove CONFIG_LSM from default configs and rely on defaults, which
  enables BPF LSM hook

----------------------------------------------------------------
Heiko Carstens (1):
      s390/bitops: Disable arch_test_bit() optimization for PROFILE_ALL_BRANCHES

Ilya Leoshkevich (1):
      s390/configs: Remove CONFIG_LSM

Niklas Schnelle (2):
      s390/pci: Pull search for parent PF out of zpci_iov_setup_virtfn()
      s390/pci: Fix handling of isolated VFs

Peter Oberparleiter (1):
      s390/cio: Fix CHPID "configure" attribute caching

 arch/s390/configs/debug_defconfig    |  1 -
 arch/s390/configs/defconfig          |  1 -
 arch/s390/configs/zfcpdump_defconfig |  1 -
 arch/s390/include/asm/bitops.h       |  6 +++-
 arch/s390/pci/pci_bus.c              | 20 +++++++++++++
 arch/s390/pci/pci_iov.c              | 56 +++++++++++++++++++++++++++---------
 arch/s390/pci/pci_iov.h              |  7 +++++
 drivers/s390/cio/chp.c               |  3 +-
 8 files changed, 76 insertions(+), 19 deletions(-)
