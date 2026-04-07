Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170635BDBB;
	Tue,  7 Apr 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579257; cv=none; b=qJheqU2NfhIyp4tN0BF7dQLulU/gzgzcv3dvkfuUwEP2JFytQ826+g0+XxgZDMiBod7d1mOZ1esn0pkXKTIOPTTM3/Tfbn/VOf76ep7ZmXbj5BlGg3W2KnthJsDp9nOf6T0HZUJAlSC21jVGOTIXkDKhlYGaDXrwd7DGXxqPACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579257; c=relaxed/simple;
	bh=rqq5OWdEXYxnqSPU6S5oMsGbpyu/0MwWSo7BmzpXSIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVfjDwDzeSUawLoqMjBxSRN5Xr89SAfZDIuE++YOKZLvwW71Is7rEBMFn3seaf5Z/8Zc8X2xb0kNAxGDKoi5rmagWZmpJAqAFD8UJGtHIxIiHO0sGkmIR3DSVeAFWJ6m4rHES7njtzg2dlqI8qCI3e9Dk62QutitX4fsy7g1ZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tLvjGQOn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tLvjGQOn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DeQfZ2211626;
	Tue, 7 Apr 2026 16:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZZkC75U1+Oz09mfD7VnIfvw22QldeNfLMZm9xQgjl
	4w=; b=tLvjGQOnbe6fsN5GKnQid/Uviq+KYEBzuttQBf+uYUhLeKhMRJNDqdB32
	FyzLW9S19OvE7+ETn4JuhddPxMjR5eQCHVwE91ntj3sV4ew051VjIAgu5gCI78Bv
	PEH3tIfDoPK/Z8coGNoDK0fSdywZQj7De7fqnj/T9Xucq8pORJ9NlujrbUuCdtU7
	QtEomIpn4pPs8zbv4wDFhmN8pNYMs1Re2chOUmIyXZjNYENjFdQ2BJNbvnl3jdEI
	YcFTzBeNTg7v6WAg2QU4tRLBIoJKjVBmpLMArMR2b3ynTfMsULLBaWvH0++Kq2kB
	INRYTVrPocwk5QsoqqjAFY91SkdCQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hbpnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:27:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Eap8J014356;
	Tue, 7 Apr 2026 16:27:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4kxmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:27:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637GRRdJ28574250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 16:27:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4E120043;
	Tue,  7 Apr 2026 16:27:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B567420040;
	Tue,  7 Apr 2026 16:27:26 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.78])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 16:27:26 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 0/1] Subject: [GIT PULL v1 0/1] KVM: s390: One very last second fix
Date: Tue,  7 Apr 2026 18:27:25 +0200
Message-ID: <20260407162726.252141-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NiBTYWx0ZWRfX3dX/edcmH9RO
 hQyblZQT2U5e6SW6jgqv3BgueoFRtKdWbUGVaTAO48f1cNStXa5R6RmBSWSv2T4vL8UnOGOMbZf
 TgOoi/Qu9xkwzWevEiC3p1Y5PAnF0PTelxKMsi4f2FT/2Gi/CmepqxiwlZhWHzxVe2vc7AFbla+
 uhCdfFQUDTH61c7v6CSMvmw+mSIWd/rX/F9TzLA+ES6irgKHeqdPMC95AhRLZeXItPoQxSour3o
 /9zCUoPDSgQ1QwBI2Ry1Z4/a76JHExT2IKU9OUakJTQYY1hMt3jIF+quw57uimiqH11ribqwL1d
 7ohCpECK7768jsyvG7dxKYcRkMhZmahwmMMCXQ4haqcXbWeFt4/BZrjoM295ZgyokSb/4IRdpR2
 XBvV4zeS74NwxeNS+hCc22aL15c+Sz9Zp0ftu2n9hH6sOHQd37laTkViaqZYrV/FXTzNCwxW7Ev
 t4MBSzElxt7iMvde9vw==
X-Proofpoint-GUID: DQrSJ-CMMjOG11QgAg7YJ_cl4-hd2EM6
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d53076 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=EMiGlfBOy1kJDbtlQGgA:9
X-Proofpoint-ORIG-GUID: DQrSJ-CMMjOG11QgAg7YJ_cl4-hd2EM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070146

Ciao Paolo,

here is one very last moment fix for the gmap rewrite. It fixes an
issue that can happen when a partial invalidation happens during a
shadowing operation.


The following changes since commit bfe62a454542cfad3379f6ef5680b125f41e20f4:

  Merge tag 'soc-fixes-7.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2026-04-06 09:03:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-7.0-4

for you to fetch changes up to 3ffe5eb4a5f248c0d4b849f050af973396656f85:

  KVM: s390: vsie: Fix races with partial gmap invalidations (2026-04-07 18:20:58 +0200)

----------------------------------------------------------------
KVM: s390: One very last second fix

Fix one more gmap-rewrite issue: races with partial gmap invalidations.

----------------------------------------------------------------
Claudio Imbrenda (1):
      KVM: s390: vsie: Fix races with partial gmap invalidations

 arch/s390/kvm/gaccess.c | 9 +++++----
 arch/s390/kvm/gmap.c    | 3 +++
 arch/s390/kvm/gmap.h    | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)
