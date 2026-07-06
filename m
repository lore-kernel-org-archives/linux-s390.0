Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5343890E7;
	Mon,  6 Jul 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368174; cv=none; b=IPSIdM7vXWnJr2mO7VmLQrmpQz4I/t7myW4/Hyz/bv7gqIqjiX0HPDYxVJGyZ2ltRAJw4gIyNKCRB4FRAnD4rgUxLMhfpt0VCPyzV6kXlAFwTsPC3F4tVuE850/4gcjOYqRouW31eI2dA+OoVmx27idMajzEaoRvnOsUNqz7NWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368174; c=relaxed/simple;
	bh=MHq/nmlRMljUht55ri9Frt+sy1XuD9GVO+Ev6VnnEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtG9L58UKVN8Y7DASgfxvrnMjRi8YoAOO5wDy8FVJSSA9LFVMW6GhD3Q6oXig06Siwwh2bluYT/IcAEGuFaFpdg2qiTMHJTCm+gBxMibW9ZfpFxA2lZ1JshVTQh0BAsvlyWROnAL3XwEFPReRaZVZ22WFjU+MYNJLGn94qZZGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DBY4SHCp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DBY4SHCp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FISmj4069750;
	Mon, 6 Jul 2026 20:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wrzP5vuFyJNSSOX8KvtlD+6jjt61nq8ejnSl7QzOz
	jc=; b=DBY4SHCpyeH0QLecUnKV2jeN4c2fgCjwWTLvBTV6mTNmD0uKQbGqCzHC0
	p8+zzZaJuJpNuGC64uTVNkCNQQxvQHS9FdHShQH9IZYqbwiqcdY1PLL+3jkozxdj
	DeziXRtsTXhGCbqiEqSxpaIGjN9GVcRrrPT8Nj8YMR9G2Y5O32VwdPSje6kD9XdV
	FGdD+YPsZXH9Snq/BFxq4TaVLaOg+MY47P5WVO9GKuOLsDnK4HuBqGNUKDuZs1PF
	c7XEwUJTsnYky4TytLfFMcoPwWLt5A5dhsSFQb4YaYmtaFL0/bB46SuXGSzYrV2S
	LKnYOJPv+/JETQozEZBjsMaLkI3zA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdkt8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 20:02:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666Jnc82029307;
	Mon, 6 Jul 2026 20:02:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xxqsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 20:02:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666K2kHm66585076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 20:02:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 881DD58056;
	Mon,  6 Jul 2026 20:02:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367A558052;
	Mon,  6 Jul 2026 20:02:46 +0000 (GMT)
Received: from IBM-GVXK264.atx-us.ibm.com (unknown [9.16.47.12])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 20:02:46 +0000 (GMT)
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
Subject: [PATCH v5 0/1] PCI: hotplug: Add support for synthesizing slot uevents
Date: Mon,  6 Jul 2026 15:02:43 -0500
Message-ID: <20260706200244.91130-1-ramesh@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4c09e8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RLFbKyCAV2Q4rzo76dmsHbHSXqs=:19 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=qJ4nAKIlUr9fPb390z0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwMCBTYWx0ZWRfX6gX/1ZYsg0T3
 pa/6NZXlFB6Vafe3ylz7SFovaiE/Uw3Iru64FkY25roxw4pRIo5gKRG29Nlf2+x8Zc7FE+JqsYC
 OaSgOxyqnHV7IAFkxXtD39C0eLEn4O4b+Ervn+bLND1c37KZo2Qso1CLDbO1lY6JM+MErGdTENo
 ZRpvDVpGO+P5LE23kOnSebBUKu/Cz+L3qEKZONokygsRmIyIYxzboNnNSY0GVLxi2Kt6l0mO4kC
 dYi5JrGKkkrK1E8MGKXz7TxA46BPr0XnidLsOXV4YvKUOA0QYRA15RuiJiRX3JbPDvRx9a4iE0S
 dRYxa+8fc3KXiSockYtFz/WF0hA8n6gtSbWWRv5ctL75070ztGE+5IjM8StRK12j888Ic1gmKXT
 HhN4U9rRutxpTs+NRxnxTjwIi+22Ybo54pZboA39MKj93C8IkD3K0iJ+ZxvLIhw3tfm8RC1e8Eq
 dhu9EOo3Nut5t/sR7AA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwMCBTYWx0ZWRfX2UVGmqAgm0LU
 Hu3xaf1hdsnaMushwPrQnsHHEvfwb2SMyii2TNtfmIz113oubgj7UOhbOSt7in953rSyiEhllwB
 ddAq/j94hoQP4MN0jVsv75McqeGeQUo=
X-Proofpoint-GUID: TBNYE1R0DgUpE77kLgt6NmTJnAjnCTi_
X-Proofpoint-ORIG-GUID: 5mCjjB430MUMqReNAWYjTldbkfgS2g2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060200

Hi all,

This patch adds support for synthesizing PCI hotplug slot uevents via a
sysfs attribute.

The patch has been rebased on top of the current upstream/devel branch
and includes the feedback received during previous review rounds. The
Reviewed-by and Tested-by tags from the previous revision have been
retained.

I'd appreciate feedback on the next steps in the review and merge
process. Please let me know if any further changes are needed.

Thanks,
Ramesh Errabolu

Ramesh Errabolu (1):
  PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events

 drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.43.0

