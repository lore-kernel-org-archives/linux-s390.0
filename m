Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178521D3E2;
	Thu,  8 May 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746703171; cv=none; b=U3sPQLNAhJUcC23Nl8jTICBvWbB7C1OtcFMUelVFeSxzf/KRXW1r4ID86nYXE/sUlDGXRW/Buo1eak3WR4tyWSbMxmKzLxSRSV5JTrMajB56cNjjJGUU8rZmsUh5BOFD5icjYZhIIJBuNWcI2Ijzdn/ENSGCmeWHMK5nmucAtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746703171; c=relaxed/simple;
	bh=9DZuRCk2UmqT6nZhU37zM48I87ccmhLurXBFbkIfIJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NL/AKEEFgXFxfcCEHSgPq2g0TciABA6BJMlfviBBy/WzIwt88cuBpzJTBlY1H24m3rnLNhoScE378V/a4clmnXmmO+wfK/8wzp8psALGjMFcmU+bDsYKgGZxQc5l3+T322hNSEe8Y0gqvLsmbuouEywuvloYgzo4TS0YUFX5uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BWgqMnYP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BWgqMnYP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548AiceU007322;
	Thu, 8 May 2025 11:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=flmZG3XdsNKG5JaJlHsVhMf6zjYlR9YiXjzwenM1vFI=; b=BWgqMnYP
	8Ss/pPOmLjKW6iYj2t7NA5GofU1H3bb6j7bftt5D5h7ICGnV1bxJ5SnAXl5ny/4a
	5ywZX4NPgLKYnCPRVE1Ncn0MeETGoRGPlwx1W4nV1YZMP/CgpKxeTtCkBw/yFlPR
	qVEvG1DXvANrDVfx++Q020BRifwkzh0w4W16S7BN0FfJiXuy9isrJ2SQ8a32WI2f
	O0+Xl/Uh84HVYmI2H4CP/Z1Rqpco4D90jiAnq0H9caf4zpTKuWdFX9AV3h5X+YxX
	33PLoR2wcNp3mFw2NPxXeMDOEQgjUTtiKCF0gDCDyBnise4SP3R5fSaz1zAQSUZk
	qhTnKHnMstSe+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ghg2aksr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:19:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548AWdX8014167;
	Thu, 8 May 2025 11:19:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkw8af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:19:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548BJNDJ40043000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 11:19:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 537B320043;
	Thu,  8 May 2025 11:19:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2576520040;
	Thu,  8 May 2025 11:19:23 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 May 2025 11:19:23 +0000 (GMT)
Date: Thu, 8 May 2025 13:19:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.15-rc6
Message-ID: <20250508111920.8929B8c-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NvejrbkKM-UwMkwZEujRxAojN8ifk2Ok
X-Authority-Analysis: v=2.4 cv=VJLdn8PX c=1 sm=1 tr=0 ts=681c9340 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=smB1mK5zkJfcGVX_D5UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfX6JzaPyPiz1VE tBrIHscMNFF5NZ/1PZISWAvje86SEBIPA2zsou9tQrOd8FzyanfQ9CwryQxfQZubirrJ60QkkXT 1Lq/XDzYjwVSSAFfIuIwOLDu+cVuWvjPVDzS7ICI7G0nwsuO/ihHHXvHcEkUvSc48ZvX4s8bENU
 FDwy0nNPVSOb049o4EqrbjEHyj78+Uq8Wdwxzsbbxb98UZrSNAVcBvmF0HqhLADqkcXiVsE5q0Q qLYKi24NjEZ2MGXE6iF2HD2wqP7QkuJGWGViOVCKg/3v9tLxfgxbHgHd9nJkycOLHdR/wdKHFrD EBubxGOCV0nvzTEDmJGxWkMsgT3+DY47BW1v5E4JFzgBd7nR+JYpVgBufYhyKDlp7gON0ReawTn
 rmos450v1qdEXdToPLon2m/XpDtzVmDBYjq6KX8FUFJISRr/RDzWbFY3gtHisHInY5k5fH1Q
X-Proofpoint-ORIG-GUID: NvejrbkKM-UwMkwZEujRxAojN8ifk2Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=831 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080094

Hi Linus,

please pull s390 fixes for 6.15-rc6.

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-4

for you to fetch changes up to 05a2538f2b48500cf4e8a0a0ce76623cc5bafcf1:

  s390/pci: Fix duplicate pci_dev_put() in disable_slot() when PF has child VFs (2025-05-07 13:35:05 +0200)

----------------------------------------------------------------
s390 fixes for 6.15-rc6

- Fix potential use-after-free bug and missing error handling in PCI code

- Fix dcssblk build error

- Fix last breaking event handling in case of stack corruption to
  allow for better error reporting

- Update defconfigs

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/dcssblk: Fix build error with CONFIG_DAX=m and CONFIG_DCSSBLK=y

Heiko Carstens (2):
      s390/entry: Fix last breaking event handling in case of stack corruption
      s390: Update defconfigs

Konstantin Shkolnyy (2):
      s390/configs: Enable VDPA on Nvidia ConnectX-6 network card
      s390/configs: Enable options required for TC flow offload

Niklas Schnelle (2):
      s390/pci: Fix missing check for zpci_create_device() error return
      s390/pci: Fix duplicate pci_dev_put() in disable_slot() when PF has child VFs

 arch/s390/configs/debug_defconfig    | 28 +++++++++++++++++++---------
 arch/s390/configs/defconfig          | 24 +++++++++++++++++-------
 arch/s390/configs/zfcpdump_defconfig |  1 -
 arch/s390/kernel/entry.S             |  3 ++-
 arch/s390/pci/pci_clp.c              |  2 ++
 drivers/pci/hotplug/s390_pci_hpc.c   |  1 -
 drivers/s390/block/Kconfig           |  3 +--
 7 files changed, 41 insertions(+), 21 deletions(-)
