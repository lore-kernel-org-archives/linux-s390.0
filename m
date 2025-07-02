Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E22D661A;
	Wed,  2 Jul 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465735; cv=none; b=QYFJuGBT6sC6TqrSQHYlC+3whL5m6Jf26QGd7ntrzKxVIo18o/2P7cKEeNu32w6ero/f7j89BNUYVHv1yxmXwHpdXgyUgKldf7nAzCX9f5E9yKiogQpnRkkXoV5S0LQcF0LvA9QQFTlF1B4BpPfI7FvfvO+uGjUIlDyYffX2Fi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465735; c=relaxed/simple;
	bh=MkniHqRw9b3MaQ+mcWhZbTFhUvqpVB25nxYyo5HQKj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Znf3Z/rQjmnI97losEGtosTyrNCYmGLFFGB1j/L4+rKzLiC3oVbhMMNgnfvmMnVeB+FpwYRvoc8PFYc0L7KBDxIgw66dpK0sdfiEiTZp1VmP2V/RSp3FBswfRnTHD4NDBz/k3ScU8RzeWu950U6Vx1joTkR7ObVLuLhn2a7keF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tJo7WgSG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tJo7WgSG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BhBdC013840;
	Wed, 2 Jul 2025 14:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=N80s6nuGaOh/KQRu5TjyRxgHd2kV+QHDetxMISGXa3E=; b=tJo7WgSG
	ENC/RPYaIwM+gz3nuz6vzHFXI8EyXg458FXGQgTYIZ3pBhe2OB4zyL8kzayoDFk2
	OX4GsKFGMOYBXYY6tYjPVSgV5xA8iu3ykjtMokJX5wCB7Ck4HKE9GKsVnA4fcMYQ
	jzvBT+V9NOGQo0gXJ1A6WD8ey2vT6VabATuTTmeRhULYwoVlZ7qMkHopdVGIGObr
	8uFzWOfNiXlEgFtzjgx6qRhyw4lseg74xktV6Tii0xwRT7L17Y6PeUvJKiEHH/cF
	m2GVVwG1+v+fhK/ZWK1TMrv3BffxeoD38NeUXtqdNyZfwW986DrE79fpBX+xtuZn
	NA4vMbq0PfoFJw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tte15h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 14:15:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562BkRXt021430;
	Wed, 2 Jul 2025 14:15:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3fm4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 14:15:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562EFQSC57999752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 14:15:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1DAF2004B;
	Wed,  2 Jul 2025 14:15:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C610420043;
	Wed,  2 Jul 2025 14:15:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Jul 2025 14:15:26 +0000 (GMT)
Date: Wed, 2 Jul 2025 16:15:25 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.16-rc5
Message-ID: <02f08dcb-fcdf-45a9-a598-c252018153cf@agordeev.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m-xxCBSHblO8UGPY3FbQT-y3s-tW8khw
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68653f03 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=mer6NMo88nUfkAoASwYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: m-xxCBSHblO8UGPY3FbQT-y3s-tW8khw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExMiBTYWx0ZWRfX88NMjP5dUccm Hhg6lQmFs97UIzherdukCzoCV7hlyCjzm17TAtkTLLy1uixF3TrYqP80ZXWNpdOth7mbIvLlYUD oFHofn0xlzySxOiV1+TtQRyokrPW5Ob67tceN7q49EGemVt46nkvoLClkFPUEespU6it6qw5EMv
 K9JzxlxFbp1efi8f94FELirmiop+w9NyHe7BukxUb+5vl+6EmYOxCQUJSDNqrxTsCtWnK4AD2b2 PSimiOuE+3Q2EVtIPuV5wXFj3Zl5uPM+dAgncxtGOWl2IBb8V7wm7/MKO54Ob0jO75ShgkgoybZ f9XCRJJQMAzTukg7DR38iKfQ7Ham9ycShpo7TO70ArcGXuqSAS1WBjZT2g7K6Wmo03T8vXGwf9s
 7evNTTjtvEIFy+GafacDE46zWGamNwAqI2BrmGz6OWAbnryyOwXkY+AUGYR7FHXVj3fD8bCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=685
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020112

Hi Linus,

please pull s390 fixes for 6.16-rc5.

Thanks,
Alexander


The following changes since commit 7f8073cfb04a97842fe891ca50dad60afd1e3121:

  s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth() (2025-06-17 18:15:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-4

for you to fetch changes up to 62355f1f87b8c7f8785a8dd3cd5ca6e5b513566a:

  s390/pci: Allow automatic recovery with minimal driver support (2025-06-28 18:59:00 +0200)

----------------------------------------------------------------
s390 fixes for 6.16-rc5

- Fix PCI error recovery and bring it in line with AER/EEH

----------------------------------------------------------------
Niklas Schnelle (3):
      s390/pci: Fix stale function handles in error handling
      s390/pci: Do not try re-enabling load/store if device is disabled
      s390/pci: Allow automatic recovery with minimal driver support

 arch/s390/pci/pci_event.c | 59 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 15 deletions(-)
