Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1529B224;
	Thu,  2 Apr 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162117; cv=none; b=uweBsZo0evxkeAgvkTw4OSeOE54LY+625PrOwc4XCE8YvoDU4dSiowU0/XIryH2mBqQhs8x1lZaPDDBI7tThu0PfRr5lDFmT5/oUdEtNTYOHt4SU1azzqLicBgI0gaPoQZLG6Lcoap10duzrl9RYNaJpOlh2QNRJhUJZuBgVkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162117; c=relaxed/simple;
	bh=uiAFIRr6mHjLIRE3EwNKKCdKUkxBuUHvFc7GADEyjRU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g81N61OayICb72ND2K05FOZcOrYWs+Kf4jZ0ATJKafG4x3P0IEq5UrSseEi3e3s6Jv9nRIZ58l5wxFjdGM3qfkmGh4a8ADuqgpSGsgmjZ1nXFB0QWoXRhdNVbp3YXRgelXGwe2gDvqoSpk4zxWOfaheDdtrRgfCHCkRhBzeKfLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejnshABd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejnshABd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632Ea2l5354949;
	Thu, 2 Apr 2026 20:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9SUCXisxPEPCn/V6ZBbaiW9DjgU2
	NXGvJX7YbWMfJiI=; b=ejnshABduKvvo77h/mJ5dchtBGDYXQtaHCUpCGrv8DKR
	bV+fb5dwB4hkgPfj1+BWoeuGnRgLmGjg4WcLOrC1+Yx+II6kSUCmqXEAc/KIdSPy
	SWSE44nSw2qvb9eH2XYzJ0ug5i8kS6OtmM1+dKXuocD4vsZgOH+1spjRomfT+7DB
	phukDLQ1Pwr/sqVR1Q2Yz/Hrg6Dspn49k6aMPK+IWV0jIv3Qj7m4wGMEkM7l7bgN
	aawnbWGQ2na3Ncfpu6RIOiieibYVIOPmnDo9bLAqor2xPKrFNl+d/6xMWcdgdMmB
	NhCoO0N4FgRQrmxsngMFLwUzlO87Cv5s1ek53Qk3PA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgwraf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:35:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632H3bni008703;
	Thu, 2 Apr 2026 20:35:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11udgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:35:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KZ9cU24576566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:35:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4E0A58065;
	Thu,  2 Apr 2026 20:35:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2BB358056;
	Thu,  2 Apr 2026 20:35:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:35:06 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v6 0/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Date: Thu, 02 Apr 2026 22:34:57 +0200
Message-Id: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHSzmkC/23Q22oDIRAG4FcJXtegjuOhV32PUooabYRkt6zJk
 hL23auhB1n2RvjF75/BOylxyrGQ592dTHHOJY9DDeppR8LRDR+R5kPNRDCBzAqg13x4L6fxQiM
 g2pAwOGCkPv+cYsq3R9XrW83HXC7j9PVonnm73SiZOeUUNIrgdEjGwcspD9fbPvvzPozn1vuD5
 Aox6yKTSZqAeoXa9Fn8TeSMmQ6LimMSItRDa8m3MHSYY4ehYinBWGMxcO+3sPzHgusOy4rbn0W
 P1jtltzD+YsUk4x3GtrYGBipo6ZNa42VZvgGkB4vzzQEAAA==
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
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=uiAFIRr6mHjLIRE3EwNKKCdKUkxBuUHvFc7GADEyjRU=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDLPXfqxh+nydpZm1nuFT2bk7TU49KNNX1XqB9Oh/3sMX
 8QqiE0R6yhlYRDjYpAVU2RZ1OXst65giumeoP4OmDmsTCBDGLg4BWAiC88xMmyIv/Z6vuUtPp9P
 /sErp64oyvko0Ts7eNWVo/lnbI7LZvIx/PfYFBp2qfxtT3xFqUPEuxcdN/lnvvspfHSRxnLuD9O
 9b7MAAA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX8bxIb/FvA8NI
 EKWS8oyQvHSdXHtBvg0Ivq6Tnt6rOEqTL51unKzqDwLDTxyITpnMzz5U/hoLo8JXmIQKcV3EQXR
 yoR/fECN1R0fw341FtrPMiJcOX6OT7a7MmPSWDeNnyR6w4yuSy9CH4Iznlg2APiVwP3VC8NlIKt
 gWi26XOIfx9RKx9eequUIiKnDW0Brjpk9Inyoy6ac1qNRWp+cT5YWHjk8pfM20EfsgTA4OrKiaz
 fZT78jUEAtrmDPtAOTJuLPwVrcRkJCjiuT1At153YmE1a/Pw8m/JiswU6kyrVs+kLo10TlJhuCc
 r8sXlbF7T4gIO6EsfsVSwZjcRl3houAiqF3+CJ6Nnxjj4+zKQXQXBunc8jwXhERX1OakthGhAv6
 C8dotit7ilaSi6sUeQ6gORmjyyYNxHwsaKSSMM9AffBjk7/b0kmvCCmVlpbC9agQl7Tt/fWN6wm
 Ar9cFllADCh/46kOBEA==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ced300 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jVLf_0g3wJiVkyeFp14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XXTUWyvnoYydPdW6Q0btKx8sy1L6u-z8
X-Proofpoint-ORIG-GUID: BJHz1Qp9KoJA_8sHBFxTKpxOIpD17jgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020181

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

v5->v6:
- Add documentation cleanup patch before adding new slot attribute
- Link to v5: https://lore.kernel.org/r/20260401-uid_slot-v5-1-e73036c74bf6@linux.ibm.com

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
---
Niklas Schnelle (2):
      docs: s390/pci: Improve and update PCI documentation
      PCI: s390: Expose the UID as an arch specific PCI slot attribute

 Documentation/arch/s390/pci.rst | 146 +++++++++++++++++++++++++++-------------
 arch/s390/include/asm/pci.h     |   4 ++
 arch/s390/pci/pci_sysfs.c       |  20 ++++++
 drivers/pci/slot.c              |  13 +++-
 4 files changed, 137 insertions(+), 46 deletions(-)
---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle

