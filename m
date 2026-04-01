Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5D3D1CB5;
	Wed,  1 Apr 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056360; cv=none; b=URwK84LXBUQhrcRACiqinAJKYtBMCnYnPNvj4SPseUSt1f0fAmc9/1Ehj8NNgQq4Nuuypx4z94pMHu+iyWK0gHxde+q99UvG68OM3gwIef9vKTsa8JATJG/ctxrCto+pHih9MQW4EL/As4FwuPCSVh1P7qT4W+SRgb6iydhUr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056360; c=relaxed/simple;
	bh=rhpkbqx+lMWUZT6suzdYAt+M1HYlpLs/8zWcx99V8R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJ99w7xSKs32I4ewv2V00tdGocO8HexwSuBpdkr6DyRzBmUMscAfN6C3vZ8BHxRnLWHKNc0kxHohqkHtoCzdR7gTdjeZo/I1At46sl4lbXvBo0/gc3kxbpw94WLl7gKjOTX/v4sCEJd0pIDlLrh/HZDI7HuNjSyMcS5qzjQUTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/Wmp35o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/Wmp35o"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319dYB54097773;
	Wed, 1 Apr 2026 15:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=41a5MtL9QpYIkItZN0T6zElhAukBt6P/ZUsU/+FSG
	wM=; b=C/Wmp35oAI3rwIQ0nKlTfv89jqC47Dk8IkXEd7ToW8EWK9RBcMcEf4tan
	FuvTNyVkM9hn3LMaaEQDXPlijojTJHZRHA32MTr5AfGOWmmvCHF5f/qsdJ1nH7v8
	A0noG7z5SlHDp9YcZF+ggpanAis1u75WI8VOiInx7/5Ur+/zEEGCvo/d8ezwxe93
	WZBD4a6JeFRjKU3vF/wwnN7lwuEasXpEMPxcyyl6vPBke4l2lbOnJCLFfKlwnlmX
	KDX4kEo/UMjAIEwQBXrfT0akrem27tsLEfADcO8l1DLc+piZMl8fyAweN1E6/mH3
	o0vXeF1rtepcXKJENQzIa1ey86GnQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnrsu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631BXE5o013936;
	Wed, 1 Apr 2026 15:12:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkp2da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631FCO2O58720636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 15:12:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB6B32004B;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A191220040;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 87EFBE0670; Wed, 01 Apr 2026 17:12:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/4] KVM: s390: Permit ESA mode guests in VSIE
Date: Wed,  1 Apr 2026 17:12:17 +0200
Message-ID: <20260401151221.2272408-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gm5JzPB0qncwVKv-a0LMXarNIXaOHVkx
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cd35de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=iRV8YTZLPvMDbpBK1P4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfX5zBazpIgGFbb
 SeHjxgycZ9GMZoGXoxlM02fw1VacTjjhOOsNK041ZbREckqutvKTS+Foug7CGOMATC5KSi8onuJ
 4Bo9x0SICVaFV7/uXHiMDgRmBWd3BQzhAO/VMDweisGg0awuBoblM1awUaBwlGzb0i1Twk1PR8T
 TGPLtzEhGDhaCV4ewXMrGLqLj4t4lCIv/3qPgGB6t8b0dYN3YWPap6Wu2EWb+YRDPYBwwNIZJDT
 ojm62x58XujDBJJSPi18L42Qksji0/HU4ApcE8PKNFjAU+I2FR20LeBrnnVGvM/yqi6Ot5pfnb9
 2IZn3O3pA+gPes/hmTFhp12ixQ6qS3fcoiL97mK48AD0lxkJB0qcIF88dujMuiY88n0fo11kZOy
 jVVwq9zxvPfJUtqiqx1owbuXAWJeuQccdi0MD/C3A+kR8aRx0a28s2E5Rh/p2iYU5zgoIb7+oHq
 MKcjqaUwh8U56JtYjjw==
X-Proofpoint-ORIG-GUID: gm5JzPB0qncwVKv-a0LMXarNIXaOHVkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010138

Hi Hendrik, Janosch, et al,

As promised here's a quick update to the ESA/VSIE series,
addressing the small comments raised in v1.

v1->v2:
 - [CB] Remove ECB_TE in this scenario
 - [JF] Simplify initialization of newflags
 - [JF] Include "_MASK_" in names of prefix mask definitions
v1: https://lore.kernel.org/linux-s390/20260401020915.1339228-1-farman@li=
nux.ibm.com/

Eric Farman (3):
  KVM: s390: vsie: Allow non-zarch guests
  KVM: s390: vsie: Disable some bits when in ESA mode
  KVM: s390: vsie: Accommodate ESA prefix pages

Hendrik Brueckner (1):
  KVM: s390: Add KVM capability for ESA mode guests

 Documentation/virt/kvm/api.rst         |  8 +++++++
 arch/s390/include/asm/kvm_host.h       |  1 +
 arch/s390/include/asm/kvm_host_types.h |  3 +--
 arch/s390/kvm/kvm-s390.c               |  6 ++++++
 arch/s390/kvm/kvm-s390.h               |  5 ++++-
 arch/s390/kvm/vsie.c                   | 29 ++++++++++++++++++++++----
 include/uapi/linux/kvm.h               |  1 +
 7 files changed, 46 insertions(+), 7 deletions(-)

--=20
2.51.0

