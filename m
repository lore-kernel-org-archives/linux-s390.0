Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511C29B228;
	Mon, 13 Jul 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963566; cv=none; b=hjNwokP/NbyOsKp13abfZHy4nb2nLWmvrLP0wvKqDX6JWH/AkJjAdHq107RYrO/uQIl316Pe9BlzeHI42mlP2kp99m/fU2dmai07ZeV9srY0fQr6co+4m7G8dtpHnRQwwM+9tgBeg3+TZtUl829TQn1FNzDxqq5BMIyBZUowh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963566; c=relaxed/simple;
	bh=6Eh5UokVWthIqkJZ7zuPwSbj9Oq0RkNBZXNR/P+E78w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlZLjb5zubqGYmU+jfBSJdFGXna+os8nEcQm7vRoKk5v7B94J+uG6QJpi3FADbfha+cIwxi5G5HS0eD/SQ5Pr7MXvOB7/aCrs5PDO9P6JvPWoy3U61J21U2vUh6jffePiNYWRgD/jDDN814UMpSonDXDbQaaEeoFwWIz/9OpbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Myb8yG3+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Myb8yG3+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEE1Z953699;
	Mon, 13 Jul 2026 17:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8U1E8EyPk/ERNXesavv63PsKkDPzS60G8Cl2t5F2G
	wo=; b=Myb8yG3+c4xxT1+NZBXw9N5ZFtv65givC3YWMeqgJ21v37DMoAQOggyYE
	DNee232CpnyMaGeeaK1hjEcfbgklc02P4e1orvNo+imiT88zKxwowb3z5EWjReA2
	Kq6skDuw3KqJ19l7sFxDgDtcN5jCQ22WtU1/dWyih+PxPt0SUKslev83p9GJS7/x
	u0clsKO283i2bGRZCHMW+vdDMY1FopInyWvVo1Z8CHez9zcnp6DqJ/B8gWbDDvGd
	S/9V/Aq2AdSUZzdU4vIgqEowxMtqovoCr4kVRZXL/qsRWF8ki1uvxiCjwNZW9dFg
	hQGNIY1NVFbTvBcEVQMcHcHdmjMPg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv332gcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DHOcZ1003366;
	Mon, 13 Jul 2026 17:26:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh6r8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DHQ2DN21168644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 17:26:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51E0D58051;
	Mon, 13 Jul 2026 17:26:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDEBF58060;
	Mon, 13 Jul 2026 17:26:01 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.24])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 17:26:01 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v1 0/5] KVM s390x PCI fixes
Date: Mon, 13 Jul 2026 10:25:55 -0700
Message-ID: <20260713172600.1284-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfXz4SHbEqMZlsh
 bJqslStpZ4e/edQQcGILSnYcEGXQt6mU/FcVhrq1fJA8bL0PGIF7TLaeK8dcfIwIpOZrtjW9NHa
 gScfMLCYVWoU2gVKV8BRBssIfjt4G3A=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a551fac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=AS5ghRNMvKoEADv8KEEA:9
X-Proofpoint-GUID: A9CecoMkXt2RBW5OfB6uLIDUZU38LBo9
X-Proofpoint-ORIG-GUID: A9CecoMkXt2RBW5OfB6uLIDUZU38LBo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfXxvZV8RE2l1iM
 ui5Ebpp0bJ5Q8SKwWFpxsmUcFTwPzK0gxjhv8A9MpUy6TOrWm1xrzU9Fyah+1EH2nLUYwbq/NB2
 6LPVShns2kX4jNh/bZ4Qn44twioeo4DznoQTEtqUHxe6uMWhOtc2nfvrW9slJ362tLxfOi+F2Ot
 MgnGpOLQWE+LqVApVLCn2mRsChc2pqWB+TCLgaqa6gSyL6+jOeWjcbH9m4LEJgMYiB6GZwbW5XT
 2fduFUXikiXSj3GrLl092hJ7Mikj3B8xYyhB8h7HL1iG7YYKrz3HbwuRnTS0Qdzg0vF2QVsNxlt
 6Dub+1hBlHtE0RQjpyIAUIcNm+VmpEDW6zcSHnoWpQBTKz3NnHRS682aFJGZCCESmycoXZQ2XrA
 gLVVu0MVXCaGmS54BseeHrXrAK8+hydmzzr3mKHGrpsZRp8mmxa2U2Y+70BPUYT/A2xR975Rlvk
 /w40QEJSHj2IP5+7aXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130178

Hi,

This series attempts to fixe the pre-existing issues[1] found by sashiko.

[1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/


Farhan Ali (5):
  KVM: s390: pci: Fix refcount leak in memory accounting functions
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
  KVM: s390: pci: Fix resource leak on IRQ registration failure
  KVM: s390: pci: Fix AIBV and AISB spanning multiple pages

 arch/s390/kvm/pci.c | 130 +++++++++++++++++++++++++++++++++++---------
 arch/s390/kvm/pci.h |   5 ++
 2 files changed, 109 insertions(+), 26 deletions(-)

-- 
2.43.0

