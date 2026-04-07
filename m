Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5539B96A;
	Tue,  7 Apr 2026 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556783; cv=none; b=Z340C8d9zii0ZmFkATAwS1jj4wUmmTL4iY7CKRH3fOaWuCLphpG9KFqBGsn9rgYDu00OwjU/9BlGzIUez+lwlT63wX+r0/0rFBNu4THkxMuGx9hDgPOMUEy3Cn6P0Rx6keOYAIQfJPMy2klEE+KEwY9YIu3rCky1RSitQppLTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556783; c=relaxed/simple;
	bh=xMPDe5yarCr8rtAtA/og41ZgZ1Wq8HJO0LpEXG4QDQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ja5FlFWavtPx35tm+3LARuqwM1yr2SNZ8sqDh5hTJw902Xm1hv1l/sp6HVZlTwP4o8X3u4BHEWKNcRmmvOPrDqlNdF+GFLfQFRkz6UoSF53BqgnVSIlvzySzs8L22L5v8FazVkabuY1xIENdTdjDNQaFfpPrdEKIP7yLq0e95tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ng2GJWFs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ng2GJWFs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmEwN2316372;
	Tue, 7 Apr 2026 10:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=xTGtqdgffUwPNDG0eIqe82vPJHv+
	sVwRqcemU78j4bM=; b=ng2GJWFstj3w5X/6RwOXXPUvL5bZvBPgBoVbtN2FcUZU
	umt+hkm9w/OvXtZzo2NE+uz4Y9DEJjxm0qndkAukTM4VPaiBHC9foAzcvACzUdSK
	YBPKphH4TQuNjTT+5y9Mc4CbApwMWI3w+jvXN05SiQMBWkx5LcIeUYE2UqJOMHvU
	sTiH7xCalGX+NW/oG44AyDbIhAHbYWEG0pW4/DkqykXu4OgAxP7p303Tc9KBRjfJ
	yA2WZxdlAKvd2wCQmEBDHGvZ4YfLAf5PTvaw+CEMW8FCeEWTvsxvWSvbmEpL0zDb
	qu2Td/Z3/ld+7PqWE8dbsC+IxVaMPaHFKUbrkeig6w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ftbxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:12:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63793c2b026642;
	Tue, 7 Apr 2026 10:12:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7t2fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:12:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637ACrjQ64028994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:12:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CCD358043;
	Tue,  7 Apr 2026 10:12:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34EDC58080;
	Tue,  7 Apr 2026 10:12:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:12:50 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v7 0/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Date: Tue, 07 Apr 2026 12:12:32 +0200
Message-Id: <20260407-uid_slot-v7-0-e50f7976124e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDY1GkC/23Q3YrDIBAF4FcpXq9l1BmNvdr3WJaiRrdCmyxJG
 1pK3n1N2R/p5kYY8Ttn8M7GOOQ4st3mzoY45TH3XRnMy4aFg+s+Is9tmZkESWCl4pfc7sdjf+Z
 REdmQKDgFrDz/HGLK10fU23uZD3k898PtkTyJ5XYlZBJccGVIBmdCapx6Pebuct1mf9qG/rTkf
 iN8QmBdBEzYBDJPaGmf5G+jAGgqLAuOScpQDmNQrGFVYUEVVgUjqsY2loLwfg3jH5bCVBgLXv4
 serLeabuG6QdrQBAVpmVto0DpYNAnvYZ1jWWFNQfeUnTgBLat/9c8z/MXOELn/goCAAA=
X-Change-ID: 20250923-uid_slot-e3559cf5ca30
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=xMPDe5yarCr8rtAtA/og41ZgZ1Wq8HJO0LpEXG4QDQk=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKv3Ji1ZEKm6p7ntZ91nkUe+nbVy6P3Z5Fh6RP2S4szL
 SMEc7JCO0pZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjIdUZGht+PF+neme8WVi0o
 OSUtgrMrSO2PSb5V7rbVZz7f2lCzhZeR4V+s19Zp0+ZWbJmwyie25SnLt1YD+ffx72PrLTeL9XT
 MZgAA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d4d8a7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jVLf_0g3wJiVkyeFp14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: O-ORLQeHeb-ymCG8d7KvfqnZyOf8627S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5MCBTYWx0ZWRfX5ViD6Bs3ZpSU
 eCbuOFYjPm5sYwVyIkjSos4bh8EqQH5M1f3GCuGaZ1Hl4JYs7Dl+/K81nm+ezbfPVX/Yj1YjaCq
 FR5tzDMXByjsu4YCzpc17x89+IhLlZI8OUr0FSKT+4Itxvx/4mQA4WZP+tm0z7n7UD9yTmrySkK
 d+fZe8CWpstwhGoWCAXyAcQihnDXwdI0y6ZwKCgYhsdWnPHeD4OGNDgdlec1VF89Ko5wa4CpFR/
 mSdwMQcNTwdqCKLfbzd3tWwV9O3Svg3/CK9ozIy6xJP0G1ZHFkh4ROndKapGyl6V42mn2/ahA1R
 kQi8yEqjTt0qyLFgJMOdSxZcVgyARk5eRD0iMq6v9n8XOHIXRXNOnhnE6PfGwToalxW+oK1rP23
 kiBiAQRbLMzf+osGdcMap9X4frq1RfjVl6i3+jMYelOV6dMvN2F59qBWCdhRTTTqHZc0wm530DQ
 It6Kn1yyQINxnb004CQ==
X-Proofpoint-GUID: cKHMFh9Ch_c3p7P_QksklsyN6_383IQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070090

Hi all,

Add a mechanism for architecture specific attributes on
PCI slots in order to add the user-defined ID (UID) as an s390 specific
PCI slot attribute. First though improve some issues with the s390 specific
documentation of PCI sysfs attributes noticed during development. 

Also note, I considered adding the UID as a generic slot index attribute
analogous to the PCI device index attribute (SMBIOS index / s390 UID)
but decided against it as this seems rather s390 specific and having
it named UID makes things easier for users and aligns with the existing
separate uid device attribute.

Thanks,
Niklas

v6->v7:
- Incorporate doc suggestions from Randy Dunlap
- Add R-b, T-b and A-b
- Rebase on v7.0-rc7
- Link to v6: https://lore.kernel.org/r/20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com
v5->v6:
- Add documentation cleanup patch before adding new slot attribute
- Link to v5: https://lore.kernel.org/r/20260401-uid_slot-v5-1-e73036c74bf6@linux.ibm.com

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
---

---
Niklas Schnelle (2):
      docs: s390/pci: Improve and update PCI documentation
      PCI: s390: Expose the UID as an arch specific PCI slot attribute

 Documentation/arch/s390/pci.rst | 151 +++++++++++++++++++++++++++-------------
 arch/s390/include/asm/pci.h     |   4 ++
 arch/s390/pci/pci_sysfs.c       |  20 ++++++
 drivers/pci/slot.c              |  13 +++-
 4 files changed, 140 insertions(+), 48 deletions(-)
---
base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle

