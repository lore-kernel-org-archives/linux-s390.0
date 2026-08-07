Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4830C177;
	Fri,  7 Aug 2026 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125698; cv=none; b=N9keUN6/80WqsDFT3wdYU1ttDO4myZJ5HZZi65/Amkoh/99OlEvvobfS62ABcTZtk/mYHK9KNb9khFeH8e20wg/Zl1GqIymt2YZOvAqxYxbGGm95Z3t1SYgooxP6WuyRnN8IaNeS9qpBebotZpOxr9Gntd35vr0kX8RoKQEy7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125698; c=relaxed/simple;
	bh=Jy/aG8JNyK0pbZHhjsdQ02yt7Jf3d2lknbpyP3CDWII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a32feo4J/msoYh2Z1k+iUmgRYGc+gJGd9rLL9QcNSRn2PhLz6WwNLQShxRKrHgS4KXF51E6H32HUzbkv4/VG+yCdVQzBaJCmrA6ENlwW7urFgTK/I+U0L0Hu5hhZzU+gmMSAMdLzEbDB3nPfMhJPN+Oh2lliaSdeycvTYDB2MLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XfcA6amn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XfcA6amn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlcK02029460;
	Fri, 7 Aug 2026 18:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aMsF7rXBTN5m5QIlTaWt534D/Hf6sSTZlMmXrcB0j
	dU=; b=XfcA6amnYYGxYqp3oVYtI9kXlT3o4L821sSwRxgGnfQOWbeg/NQoHssc1
	ugAQkmMjhtrFdKVFsoHi6d/6W0b+S2V94/EbsY6MjJ/W8pa259daE13oShnSJAlQ
	0Fs5VkjC421gYBEL/BlRHXa/obwzO73DDFMobrbKdNboMbRCUfYUoMM5X1ro7/4t
	jEZBXMobdgo2AQiL2bozbVEPtsqeorq9B5XLQPoZkQQ39Mn7I9JPBZS8+iOU/zJW
	IfUHWHRcUvpwGi/EYYdQZH5RUbJWnkYso3bKtDqcMbkrqLvl0h46fBofLWmjTJAn
	sgAQ2g3tl5hh8MP/jzT8qA8yJq3RA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyw7qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:01:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HuJ4d030761;
	Fri, 7 Aug 2026 18:01:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r0w3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:01:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677I1UxC26804914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 18:01:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C8A58059;
	Fri,  7 Aug 2026 18:01:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9653758058;
	Fri,  7 Aug 2026 18:01:29 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.251.189])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 18:01:29 +0000 (GMT)
From: Ramesh Errabolu <ramesh@linux.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Subject: [PATCH v6 0/1] PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Fri,  7 Aug 2026 13:01:26 -0500
Message-ID: <20260807180127.62471-1-ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a761d7d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RLFbKyCAV2Q4rzo76dmsHbHSXqs=:19 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=hGJPMS5N2480-46kNHYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzOSBTYWx0ZWRfX063Lu8xQ8od2
 i0tKeG0bRGk6Ezk1EKVUyBbEWCcETQshuwXv8RRyck33H/OgdY6ZYCZRDkJa44yPtiqbcg6uU5w
 gDQBU/KDXns7EMLR18NHww1iVb9/u4o=
X-Proofpoint-ORIG-GUID: FPOYHyprT8aj4mGa8I9rlSJiP-_ULmrD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzOSBTYWx0ZWRfX9sUypsbjYeWc
 AA+D9MUTAFVv5zEywKNZZ/iFnD6GYXifsd0Wif9Z5IC3bCepLbT6gOlGEEIklQk0SgV54fdjod9
 aT64lJTAyw0Xf4kSkbXXYXPztuFoIzx25qpoH3AU1BOSQXYX4AsA6z6D5JOiS7LndHfTddU1p6Q
 3OeoJmVdPgYNgkyPw1dRx1zo9ZPo5OWrQGl064jVnmheJ/WJIsrj9fYQFtCs6jZUdiKQe9UrtoW
 /ksrPbsvqCxbrWXbYav3/iv91/lnYXtPmYnSBp4Ttv4ipb1pFIyrxVfpld83jW/7WZ8a3GdlUek
 Ha/JCh21MwynItBwewzOMIZNWIQbjVcP7QwKZQCBTJekuXRKULfRQdp859GkZuaDwxOde/NTWrh
 nKePaLk3NyxDizt5D6HtDGEiCAC22HCPHI1OdNH/UKIFirLCbBhPWe3dCA+VLTTM9K/VXMh8+Gz
 SoplucWvcWgp8MzmD6A==
X-Proofpoint-GUID: 6mdTSHA81at-nCniHipSvLLCwruskygS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070139

Hi all,

This patch adds support for synthesizing PCI hotplug slot
uevents via a sysfs attribute.

The patch has been rebased on top of the current upstream
development branch and addresses the feedback received
during previous review rounds. In particular, the unnecessary
".show = NULL" assignment noted during review has been removed.

The Reviewed-by and Tested-by tags from the previous revision
have been retained.

I'd appreciate any additional feedback. Please let me know
if further changes are needed.

Thanks,
Ramesh Errabolu

Changes in v6:
- Remove unnecessary .show = NULL as suggested by Bjorn Helgaas
- Rebase onto the latest upstream development branch

Ramesh Errabolu (1):
  PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events

 drivers/pci/hotplug/pci_hotplug_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.43.0

