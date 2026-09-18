Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770403D3D18;
	Fri, 18 Sep 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743145; cv=none; b=fP9CQFdJWoJjRUjbe9sW61zH5EMaWD0wvgoCyLPTeNzOzsiEro+cRx7LYIt0pDqF0+XAn0+aEpMVLq1G3/Bd1ZY6cUDp9NRPuO14C6AzknyJOKFB4nLcgC5kNGmfokwHiKMseniikfCVHwZMNUbhqqUu1Z6neH8GRMvK4otHSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743145; c=relaxed/simple;
	bh=ZUS4Rt9Ulh1BtKnfnvSM6fZYI2e27Id65l3CaHQRwRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1DqBzHWJrRe6koSekJgToBKSkrVVsfC/ZC3pJl8oFCWEd3Yuyqn9Hfei/PR4TfjDq9eSvxc52Y0pwxMI/I5nf7PWGzjDzibqDXVSjxC7qhb2/gfyqLrEg7iIESdn+3gGxoAJMCUbvCVgYRVD+9KHUIehrNoj7kIGAgo/NF2MBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YjbHyEEw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YjbHyEEw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVmg31394124;
	Fri, 18 Sep 2026 14:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kzXsOjzQlzYJxLubOtll4Q274VQG+A5hN+K1izuHs
	KU=; b=YjbHyEEwlVAY5lNIlvtqSnLsgvr1AG0Ohdtx2Dh89WOPMu2txt1r/PWcW
	s5wVwyUVhRmj9Hkbw69aqPrWhbCD3FZWwIIP7T8+iHEahnRpN6bCEW4rxzq6JhZR
	Eg5qClstBNUxAv/Tqp8XF8NOj7uLDDO62qWkFigcaEJAkzO5PA8dCtQgdZeuGw0T
	z01fZS6nwbpJoi0ZRsGQDCYfmnBN8s3/fb+ItKSyVY8Pd7I7u8F5U71eXyV1KuoO
	fhv0Qh0pIr8Q+ccXVyHNGHu4XAgR2h7luhCHLy9A3pEqWN220olAZvZtR7sDUZzu
	kbnIeXhiMI479IfDqkDcJZfFVtGzQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5grbh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 14:51:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNxqc739495;
	Fri, 18 Sep 2026 14:51:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q8j4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 14:51:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IEprI139780670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 14:51:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 966DA2004D;
	Fri, 18 Sep 2026 14:51:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 658C820043;
	Fri, 18 Sep 2026 14:51:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 18 Sep 2026 14:51:53 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 42364160D6F; Fri, 18 Sep 2026 16:51:53 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH] Documentation: Add missing KVM s390 crypto attributes
Date: Fri, 18 Sep 2026 16:51:51 +0200
Message-ID: <20260918145151.2116991-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: O2fzhYu2FJRur6clFrYwVjak_BMcpHBT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIwNyBTYWx0ZWRfX/qA8POljyuM+
 lMjHEYTAtJB4P8lfb+8Qnvat7B8GfOHVWfl24YJ694heoLatr5e8PzK9MPDIC7Z3e09xft8MNIT
 PPDqyV/pigVOBBk96slPMwDdQQLlhqc=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad5015 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=I0NS5xvgDdluT5zVreoA:9
X-Proofpoint-ORIG-GUID: QrMUBs7GeTC9YuqjkOj4oyE4kOtCB2dg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIwNyBTYWx0ZWRfX2nZDx7+3kHhl
 AdY08J8uh6JdKwGPOQ9IWEIZUJAcE+wregdc9dXhdqSEv7iJRxq1quVmW5ODWCUN4owITjMjikd
 GhGZdBp8RGGySI54+NoeOAO9YU1UsmynYqU/F2bsvXeCEc6jhp4KRjcIv1+snJj7e+d45ySC+1O
 ZtWbRelj0IN1UHzifH2OCr/bxMW/DdkeDew+xMAJZjnHTvsCAED29xyCv1610zV+Qqa0OKP7rwj
 aWiSRIb/reWLGXdqp+BTxGMkPb3cTPPKds/s37f9g+Ep7uQlUWRZzUKqZtkS3yYNnWEjiAEBk6B
 E/n8UaBnapfUCxyzNNoS8njsrhlIIjhxxzhNXUjwIUOYFcSmGI2FfCKhJRwL/gcU0cjREouV75r
 O93jMm/i2v8xiGaQ/MBlClzItHAhbQ7ZBttGXwa61KXHsUlTYs7Z/3yoHkB1c7Lhah41JuaTo24
 MaGvZdXyJfisKJFUmqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180207

Device attributes to enable/disable the AP interpretive execution
support for crypto were added to KVM several years ago, but they
weren't added to the documentation itself.

Fixes: 37940fb0b6a2 ("KVM: s390: device attrs to enable/disable AP interp=
retation")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 Documentation/virt/kvm/devices/vm.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/k=
vm/devices/vm.rst
index a4d39fa1b083..78e63eb9994e 100644
--- a/Documentation/virt/kvm/devices/vm.rst
+++ b/Documentation/virt/kvm/devices/vm.rst
@@ -280,6 +280,24 @@ Allows user space to disable dea key wrapping, clear=
ing the wrapping key.
 :Parameters: none
 :Returns:    0
=20
+4.5. ATTRIBUTE: KVM_S390_VM_CRYPTO_ENABLE_APIE (w/o)
+-------------------------------------------------------
+
+Allows user space to enable AP interpretive execution.
+
+:Parameters: none
+:Returns:    0 for success
+	     -EOPNOTSUPP if AP instructions not available for guest
+
+4.6. ATTRIBUTE: KVM_S390_VM_CRYPTO_DISABLE_APIE (w/o)
+-------------------------------------------------------
+
+Allows user space to disable AP interpretive execution.
+
+:Parameters: none
+:Returns:    0 for success
+	     -EOPNOTSUPP if AP instructions not available for guest
+
 5. GROUP: KVM_S390_VM_MIGRATION
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.53.0

