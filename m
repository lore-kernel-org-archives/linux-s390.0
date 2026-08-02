Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E42FE0F;
	Sun,  2 Aug 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680179; cv=none; b=nsUqgnx4+n4VZF0S5HJBPq86I79zzlhFiH1mKWLgqJJt8Q5jjxNpjjXZyXaQiwaaU6hY06A/OW7xqPuxcm/cSTiQ+MtpMJkcTdAvgnt92Q7OU6gNY7tmW8ckwPv7c8afcLK5Dl3yka/cDO34FrqRTz1eL6fHK/qo1AodvVX3uIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680179; c=relaxed/simple;
	bh=sbbyOP9tMKiHSFQ194MQdmlf/iTkRHJ8/X3c0ZUVoyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sLhxCKzcxrFlzBwJpDtG9MJYN4ApqqLOawd0v9kci+Hz6CvXuLCNxwN9RUQLzPN6JMK231f3s5Oon8Q0QQyx92cmFsD7iU28raFqwqFxND6urU7Du9tYgtgMVzZmgQOgTfwr8rm/SjFP89+0ChLGtsY+TZGL/Jg4EzV2kmMAjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B4KmpPrC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B4KmpPrC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672BJ9TG3139787;
	Sun, 2 Aug 2026 14:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=c78WYp77wDOTYpGt+uLFUo/8Zezmd7Ebqf1ULMo9u0U=; b=B4KmpPrC
	25AdavmXJBWNev9h9iIHrWPsGDTYSfp16gB5NHHQPhHDA8Ep7NySVORJu7eRcd3K
	AZmYybrG8YfW8zo5+i/QV75zUdtQrmBSHLblu3PyxGWhC6udRVYH7lzIklNvHxnc
	6mPlgfGa3R20ecVIZqmYS+wsU0d6moJcSdk95PnlYtBH7ITX03mAafcgkPQdBdHn
	uCq8Fjlk+Vz1pSjCFMin6ZcfoahgFzWlOnbnoX1Fxay2P7uAlL+xda0SusHZigO3
	w1qpUdV4vN4PCm203dYFMeOIIq34tPPqp6OSSKAHQocstqFSjoM29F6TTpT4byBM
	ORdEiZd/5e6NXw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hcrm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 14:16:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 672EBGbt003745;
	Sun, 2 Aug 2026 14:16:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvsrnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 14:16:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 672EGAoV30605740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Aug 2026 14:16:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFCEB20043;
	Sun,  2 Aug 2026 14:16:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9207E20040;
	Sun,  2 Aug 2026 14:16:10 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  2 Aug 2026 14:16:10 +0000 (GMT)
Date: Sun, 2 Aug 2026 16:16:09 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.2-rc6
Message-ID: <ttj5bmx@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyMiBTYWx0ZWRfX4TaUHJJ5wiAG
 7jNJC6KXGWuWIg7rZrHUtSj1APxcLDSYzZNWbx0yBBeTkIrLrMke207XYdl9WRci16iP704DDOy
 2evJIBLluvyvUQ7oSrCx+G4X3wVIhRk=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a6f512f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=mHTCgUG3VcuK1H-Q2J8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyMiBTYWx0ZWRfX9RJg9zlEzEwz
 QJn43eAqTP1OyifKSg4xND6s+BjPsbP2wt4HivNQGCRBFAsAXFBRBX2+ZPMjtSbN4w0jhYXy1Ql
 ok06rUqcKboWwSdxhf6KRUjpCl3KuQR7wnbgLxQVN7Fx20HQFMt3X0WsESISLtiK3l8rFT2Z9+2
 4VLcwA52U/WITNI4d4C8ROZHgTZcViLqRHlXJVkVbcMs+R3Tq4R56nE/v61hGHC7Yw3UJWfBViA
 zzGxMvhJywi1Aqo/hiK44fjf9Qf40ilfe1dsSOlhO4InqQJwTxVj5FxmOTMyOD/7z0SJQgPYO/S
 orWDn6xiIRNZ/I/jVNYOvErnRBrFFSm60DnjxAqtv9oReZ3OPFC+59IO5u1gfh/MvJdgJv2IcZf
 DIujrIBn7CPEPbi8yitPL8D1MGKp36/DdZGcurGUJcEKF/OTkSW+d3iue6QECtMSgflrDxpQhMk
 GRDckXWb0ZKK5KrX8IA==
X-Proofpoint-ORIG-GUID: HZunowu5D4pwCsYZZMBjrUOjbi5DGlCu
X-Proofpoint-GUID: HZunowu5D4pwCsYZZMBjrUOjbi5DGlCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020122

Hello Linus,

please pull s390 fixes for 7.2-rc6.

Thank you,
Vasily

The following changes since commit 49145bce539117db4b6e9e83c0e5ef528e361050:

  s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init() (2026-07-15 17:35:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-6

for you to fetch changes up to 01476391aecef36a3b789ee844357b22fbc90665:

  s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey() (2026-07-31 13:31:20 +0200)

----------------------------------------------------------------
s390 updates for 7.2-rc6

- Fix PCI MMIO write syscall falsely reporting success for mappings not
  valid for MMIO when MIO is unavailable by returning -EFAULT

- Fix CPRB parameter buffer overflows in zcrypt CCA AES cipher and ECC
  private key conversion by rejecting oversized key tokens

- Fix buffer overreads and length underflow in pkey and zcrypt CCA token
  validation by checking length fields against actual buffer sizes

- Fix out of bounds permission bitmap access in zcrypt EP11 admin CPRB
  filtering on custom device nodes by using AP_DOMAINS as the limit

- Fix speculative permission bitmap reads in zcrypt CCA and EP11 admin
  CPRB handling by sanitizing user controlled domain indexes

- Fix sensitive key material left in zcrypt CCA clear key import buffers
  by scrubbing CPRB and temporary buffers after use

----------------------------------------------------------------
Harald Freudenberger (4):
      s390/zcrypt: Fix buffer over-read in cca_cipher2protkey
      s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs
      s390/zcrypt: Close speculative mem read possibility
      s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()

Holger Dengler (2):
      s390/zcrypt: Validate length for CCA AES cipher key requests
      s390/zcrypt: Validate length for CCA ECC private key requests

Niklas Schnelle (1):
      s390/pci: Fix s390_pci_mmio_write syscall error return without MIO

 arch/s390/pci/pci_mmio.c             |  1 +
 drivers/s390/crypto/pkey_cca.c       | 15 ++----
 drivers/s390/crypto/zcrypt_api.c     |  4 +-
 drivers/s390/crypto/zcrypt_ccamisc.c | 89 +++++++++++++++++++++++++++++-------
 drivers/s390/crypto/zcrypt_ccamisc.h |  6 +--
 5 files changed, 85 insertions(+), 30 deletions(-)
