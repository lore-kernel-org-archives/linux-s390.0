Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE0408017;
	Thu, 30 Jul 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403441; cv=none; b=epUDogZzfSOW0xyIhBueA1sutJlN9y1dWRs4bcSjGY1O0Ua9GzsS5JBKAGDt3mSAtxpB3KbWTf7PcS6N3kSv21eHcjEQOPOfep8MpV/tI0qVr9iKrbWLG2AMeG8ZGAC2wwCskONbucrqEWY20WHc2xgrM6jPZiTmJOV2xGL1g00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403441; c=relaxed/simple;
	bh=j/ocrtk3beNxJlloX+0AhUOBExIU5CzkaGYE27uAGXw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eVEKmiEqZqEcE+U2UJ3Hm3J9hZ8FXf0PqDZi81Y9dX9Uok7Qiy7RSvFfnTKWuo+9wubqG1rmglP3O2gq/xaBOWfSc+e+jysmL/FBKmAWi/V/VoxQKOuj+dwdQCe0uwI8RprtF38GzFVrR5Qh/9GegJVKcmshA6YY3g27bk+8Veg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mIE/W8V0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mIE/W8V0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6luYi2316259;
	Thu, 30 Jul 2026 09:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Hft1guSSoSLzyoo8M92hwX23LRKO
	X0045xd9EnS05kE=; b=mIE/W8V0XAThQSmFuhXKrZPPIdBhQT+P5vNL7f0PewCR
	69bwPVm2Qqv9OyRcIQHglRoXegYnfkOra5kBC9MSK5UvrDPN2BjhQGcvr+3vOCii
	k53ZX45BeiOEcfJ3opDAswf7bih6c6Hadqb04NuqMIZ9yWgu3a1vtnY+k8jMF8sh
	JD7CHlJnqqrxeCFJ7CGcY2kbj9sS7R0BoJowjLesS30uOtrioo9ypugXe9UrYsuJ
	NkRmiknH1dzcL8XohrU3gwhjDD+t1yr0br8JTZUECcF1jw+lA9yqgz+WMNDYYHOn
	SxKqam7HkPI7xmLPAqqhphVFDzLH0D6CtAL7A2NfKA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd64xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U9BHOm011933;
	Thu, 30 Jul 2026 09:23:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwasfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U9NbEA29426052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 09:23:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B13420043;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6732D20040;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v3 0/3] Introduce arch_do_panic
Date: Thu, 30 Jul 2026 11:23:26 +0200
Message-Id: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33M0QqDIBiG4VsJj2eYZv/a0e5jjDCz9cPS0E0a0
 b3Pgp10sMP3g+9ZSDAeTSCXbCHeRAzobApxyogelH0Yil1qwhmvGPCSKq+HpnPNpCxqqmroq7p
 WSghO0mfypsd592731AOGl/OfnY/Ftv4kOEixoIxqVQCALEGL8/WJ9j3n2I65diPZtMj/CjwJp
 eFSm5ZJBvIorOv6BX5k8h/wAAAA
X-Change-ID: 20260724-arch_do_panic-a97f699aa332
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mzcJZ3rqLM7VyUvO_wn6EOSKLNeEXYBZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfX7pLIfTb9+iQZ
 w+Zr6tbbIVtFX1avPrALyCacZ6bxLL0LPKmxxcj6BRNSDFqNEeUvVgtOEjL2p343NY5+CBFsd5+
 VcwYrJIhxsLETOxLwqIec39C0AGRU/s=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b181e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=QqAA-BmPgylke00IapoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfX2PW43TIEKcsF
 reavYMzw7ylpFsukCGhkWZsxIFVS3Ow/EWsFc768XRaIEVB2T/IkPE71ACgMDGTi7TrNufWfszW
 ZzZf2tkP6x/YTK82+chxUAE8Ln384W+VyRxAOOLbdw0hT5Z+EFouvST43XzrCN3e9hTbUrBRlLy
 EpZg+qifdK9Krc+9ohWwRDhOtbAKXLyu2kM20QaYp3Mp3BqusqOSyerD+Fk04kWihiVmFa8vF35
 8jDxE8G5jmtnnopaQNTH/U1IzreUxMW9xqR+E+JAg2LTfjJA4lmsxa0CM0riZYv2Q39q/BMvPYQ
 ez04LzrGfvSh8ehZEXdsA0g9uJxcMbQdDF4Q2HCENjrrZjA5Ao3V4TFdI4OMmAgwS98P0Rdc04u
 OR/gQZkMu6GJO/YLMuoH5NA1/lhygU+vAfDnSAFW4XC8S5DKqf5Pz4KxUobRlQCDg9HXw9ziJ9j
 WxsYES/d69u0rMbGLWg==
X-Proofpoint-GUID: mzcJZ3rqLM7VyUvO_wn6EOSKLNeEXYBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300068

Changes in v3:
- Use __weak functions instead of symbol override via ifdef
- Patch 2: Better explain what is fixed (Bradley Morgan)
- Add statements about print order changes (Bradley Morgan)
- Patch 2: Add a pr_warn() to notify user about on_panic and
  panic_timeout relationship if they try to assign a trigger to
  on_panic action while panic_timeout is set to a value other than 0
  (Bradley Morgan)

Changes in v2 - Address Sashiko findings;
- Patch 2: Remove unused leftover code
- Patch 2: Mention panic_timeout and shutdown_actions relationship for
  s390 in commit message
- Patch 3: Use bug.h instead of setup.h to pass around arch_do_panic
  implementation of sparc

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
actions. Reordering also allows more information to be printed during
panic a for s390. sys_info(), kmsg_dump_desc(), etc... are now
reachable.

Move sparc panic handling from ifdef blocks to arch_do_panic(). Remove
the preprocessor conditionals from vpanic() and place the Stop-A
enablement code in architecture-specific files where it belongs.
Stop-A enablement markers are now printed after "end Kernel panic"
line.

The cleanup reduces vpanic() complexity and establishes a pattern for other
architectures needing custom panic behavior.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
Mete Durlu (3):
      panic: Introduce arch_do_panic
      s390: Implement arch_do_panic
      sparc: Implement arch_do_panic

 arch/s390/kernel/ipl.c    | 19 +++++--------------
 arch/sparc/kernel/setup.c |  8 ++++++++
 include/linux/panic.h     |  2 ++
 kernel/panic.c            | 15 +++------------
 4 files changed, 18 insertions(+), 26 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-arch_do_panic-a97f699aa332

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

