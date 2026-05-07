Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D42370D6B;
	Thu,  7 May 2026 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184532; cv=none; b=JM6Qod1zCwgDKrQTTfFs4cRJfKAq2o6KBvSYnD2+m5lfeMD3aelZUBXZvzk2en1a8aFvl0pMkVrziLXimJPHTn+jKN9YtwCvdQoOAxrs76xF9d14yOJplHOR9T0mgMB4/emCidLL4JaGMiHVEjfgVqn1UawvwzoLqxB6na+WNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184532; c=relaxed/simple;
	bh=dT2bHaH5mZDm4/4kojy9HRXWWhKz8YrU85VkYW9j46w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzUpPHd/m2gWfPQZq+Az7yihd4kFqgjApoZcERjxneSZcN73URs6ZTp/BGu6PqeLpOEVJDyOdLNF8q/iZkXcvY2BA498USaUMhln+eppCezdqpU6XqAm2MCc9udv9QgTW/uuXCL1aPPcRpbvLug42MlvFv9Z726/rnVysxL9AnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MoQgqs7X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MoQgqs7X"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BBFg63390293;
	Thu, 7 May 2026 20:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KSrCAQnFrN3OA5DqH1BAOpZgEQhrSGDU7Pv58L9wR
	nY=; b=MoQgqs7XnsuP+Y65A0xhfpC2PzfcRfVq0KNJ9v6QdE9Qn4p471muul0Jo
	/uhyZtaiDQCHrDDCHQw1ImOCaVrdoQ4yWUit5iL/ZLs1NBQtAGP06McHvSkb2gJm
	la4fEpPJFiXF9WZPN3AiSpPFHRY7CZPa95UI9D3225wQ74LNdaRomrhOjUydg96z
	1YZse86WaNYmCLv/jOlV5OJ3gsd0HknBFTTjM8MKCErrUbCORV1AYFj0u+pDcAc/
	H89IaRzztpR0N4jFZi5osHk7UiCKwZYUw3ddnNE7NkM+AN/WmyaitJJs2BJJ2p+x
	O1ChYKIZaDyVCxL14zAewa2EEChaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxyhf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647Jsgvn029587;
	Thu, 7 May 2026 20:08:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hdauw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647K8gD451642692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 20:08:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2607220065;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 021A42004E;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  7 May 2026 20:08:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id DBD26E05E2; Thu, 07 May 2026 22:08:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/3] KVM: s390: Toggle operation exception for userspace
Date: Thu,  7 May 2026 22:08:33 +0200
Message-ID: <20260507200836.3500368-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIwMyBTYWx0ZWRfXw6gbhhuLgyhM
 Df+sdYAt4IkqoUxA+J75cebnh48vQl6W8+e1gOUdRHJe5VxuLsniS8zgXDbD86PNe7M/Mr3v/b3
 1XGfCzcI50z3uTubPbzXLZYhML0vek9UNrVJURvSrhR65SWMpMYF560qWkwLdmwDRoEXeGEJzoc
 4gkiCr9hdM6I05L6ujH2WLTyFXi5li99fql6HYxO55l/tzcHCJa0LRyBGTdk4FHZ4MbJrTBI4hn
 FncxYf0klyGQHz6LI43amTXpSNCqc+ht+VcHl8ZE5phlrBQAqJdT7/xQljXyWPWIc8NAtKM0XMW
 OYdtzZJgcR7GEn/50wcBr0BH62ci4xkQQg6kb+Hv61oCTCdErYtmozsX9ti5FptDw1pv7P8johH
 FjPoA7Lew8jd5CAwV4wWuqtK6W5yBz8lT1QY4cX9JlilqZNn5lhf8IcpfqKg0cYJtgX76WnnCjk
 oTmkR3A7jKT2d4F0KPQ==
X-Proofpoint-ORIG-GUID: xSGdPjub5CwAjABIPH_r5I5zxqpn42nO
X-Proofpoint-GUID: xSGdPjub5CwAjABIPH_r5I5zxqpn42nO
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fcf14e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=UtfnOWSt_DJjTBG_1EUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070203

Claudio, et al,

Here's an update to the USER_OPEREXEC patch I'd sent the other day.
Besides the addition of Claudio's r-b (thank you!), Patch 1 is identical.

Patch 2 contains a couple of new selftests. As it stands, they all run
with patch 1 applied, but I put the failing test at the end for if
Patch 1 is missing.

Patch 3 is unrelated, but is a minor typo I stumbled on yesterday while
looking at this. It seems small enough that a second `git send-email`
command seems unnecessary. :)

Eric Farman (3):
  KVM: s390: Toggle operation exception for userspace
  KVM: s390: selftests: Extended user_operexec tests
  KVM: s390: Fix typo in UCONTROL documentation

 Documentation/virt/kvm/api.rst                |   2 +-
 arch/s390/kvm/kvm-s390.c                      |   3 +-
 .../selftests/kvm/include/s390/facility.h     |   6 +
 .../selftests/kvm/s390/user_operexec.c        | 110 ++++++++++++++++++
 4 files changed, 119 insertions(+), 2 deletions(-)

--=20
2.51.0

