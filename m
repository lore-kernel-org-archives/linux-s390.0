Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2EB3C0A1B;
	Mon, 27 Jul 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142852; cv=none; b=LCGu7Jy+GAgTJ2kBDCcZamViijG0V6OtDjtytDqL2xwEX59QlFHL6TVZEKIZ7Sk6DnaY2BoX3exceEhSi+2WxMSkE7sA6xI6J9mlfH47AAtJqe+n/NVSo8BcEFq+R284P0iprC2vXs9ec5K4LZpltMMQolrmkcTukYfzQc+0Kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142852; c=relaxed/simple;
	bh=6cVuprLDtl3ilVcepOAYjav4ykI0HWjRiyekjic3Z4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RjPkfIBStS5eNQq4qxuTBIac9WXZXomeZR8KpOOq0Uh4oYbj6cO4jOTfndsNcOdWqgm4/fN0Gj4eYaMwllB8U046eVZmphHz4vyPPLSUBIlnyFA55ks5TocCZMUPH0OBo1sg1VFrbmKYocfnraXaNsOJ5LwQ/KOmtLqoBwaoIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=juvEA7iD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="juvEA7iD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7ljsi1520428;
	Mon, 27 Jul 2026 09:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=tJMpkeeiugFXjFO+Vy2jyQe4O2tl
	V6L6kGuUF6b3kHg=; b=juvEA7iDk6lJCuEU3IWB3X6rbBGh1vZYOD/SvlcyutAO
	psGbkLZeWRIjASKQhXnqg25yHyOpUiUxHfTTFx79QDdnf7+eo7OVexCwXB+5i+Ld
	p4WIVHXMjGDk2lJ4q6OTb9kgQ1EOfYkwTK3rqYI+EOwylLxdgbvH3Zo/EMBCPcVM
	3dQNZPJXjkSCAcb42IwY68hK/3IoBh3YHFsqiZANfSJK+3hBu88lTD0VMalBRYPj
	xr8t5crrfgyZPIbInJ5w40WDOFFszVvo1Iceptq+2Rhc8RyHqKpUyczTgKTZahEy
	ufy3Sad6h64lYifoF1KZyixJGxY70XeJebLqcxEduw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhxrry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8uJ5O016256;
	Mon, 27 Jul 2026 09:00:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg4f2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R90dXe47907122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:00:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8993B200F6;
	Mon, 27 Jul 2026 09:00:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F843200EB;
	Mon, 27 Jul 2026 09:00:39 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:00:39 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH 0/3] Introduce arch_do_panic
Date: Mon, 27 Jul 2026 10:58:47 +0200
Message-Id: <20260727-arch_do_panic-v1-0-ca1777547c38@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBNMQ7GrRMhgU85GRSGC6O5Jy
 7f4/4FGlanBMjxQ6eLGOXVM4wAhYjpJ8N4NSiojrZoF1hD9nn3BxEGgs4dxDlFrBb0plQ6+/9+
 6ve8Hmna30F8AAAA=
X-Change-ID: 20260724-arch_do_panic-a97f699aa332
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michael Holzheu <holzheu@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX6RCK5R2H9G4p
 BoxVmv3S1Xmb57xDGTj/BmtQEolkzriNPAgFL2xMfiY16kQSJ34YTTn+/+yL227Za9ONtkqmBCC
 b7ENeAMQRf4unN0to41TWPruGzt9pZI=
X-Proofpoint-GUID: qrBAY7BdEnBBWWOPe-QTpsZDVCmRbzdC
X-Proofpoint-ORIG-GUID: qrBAY7BdEnBBWWOPe-QTpsZDVCmRbzdC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX3Yq41Z1x/H2D
 9b+zdHsmC8jK4NUc4GfJ8uGuzYU9ZSySGHy2/tHzFbMQ7OfxBHyXHOBpT0SEqVQlnNwHZmL9G0t
 s9T2hs0EayKzMbDspsxxGeQ6h2A2hFznUcPEyXrfzUQl2aROGkg+kCeafB/6MNDj+dtqG7nHthM
 Tl7T91Bck6LP1wMbS43+n3TpsTZheN3kctLV+wyVzXRo/yJJAPvG1sIp88j0CIkiNHrZsnOSL9q
 gjuvtiGqDh2yu4PEV6V5UigybpaBUPbGnHludTdRez+XhU9/yBDPTFh9oHUCstY1HCeOWTfL/PK
 23camYvs2fhRYpRW8w/agaYsSKfN1fz5S8cSEYP02ttXoulvsgE0Z8vTaX2hTQqOCuxZf57FvzN
 P/guZ8eaxgFQAastBBEPXNjwHf9wzdp/NqTr0LCumWgGTP8WlEo5XgcwzACC+geHWW+k9LU3qgY
 u8TMMYli4iMBJUZ1mPQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a671e3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=mhgiN3pIpOqnq09bPUIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270086

Replace architecture-specific ifdef sections in vpanic() with a clean
arch_do_panic() hook. Currently s390 and sparc embed their panic
handlers directly in vpanic() using preprocessor conditionals, making
the common code path harder to maintain.

Introduce arch_do_panic() as an architecture extension point called at
the end of vpanic(). Architectures can use this hook to implement their
specific panic handling without polluting the generic panic code.

Move s390 panic handling from the panic_notifier chain to
arch_do_panic(). This corrects the execution order so that the
panic_timeout is properly evaluated before architecture-specific
actions. The previous notifier-based approach executed too early in the
panic sequence. 

Move sparc panic handling from ifdef blocks to arch_do_panic(). Remove
the preprocessor conditionals from vpanic() and place the Stop-A
enablement code in architecture-specific files where it belongs.

The cleanup reduces vpanic() complexity and establishes a pattern for other
architectures needing custom panic behavior.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
Mete Durlu (3):
      panic: Introduce arch_do_panic
      s390: Implement arch_do_panic
      sparc: Implement arch_do_panic

 arch/s390/include/asm/ipl.h    |  1 +
 arch/s390/include/asm/setup.h  |  3 +++
 arch/s390/kernel/ipl.c         | 15 +--------------
 arch/sparc/include/asm/setup.h |  4 +++-
 arch/sparc/kernel/setup.c      |  8 ++++++++
 kernel/panic.c                 | 18 ++++++------------
 6 files changed, 22 insertions(+), 27 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-arch_do_panic-a97f699aa332

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

