Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851116;
	b=U3o1M5Wdsuys6+YX09Yq5uNtQ3oZ6RV4B+MuYkolam9ncYd7so5BAXIQe18G9YZY6Dle
	 P8JAzOebGagb1T98gG4rS6CgnadRTfCcaJMX08eH+/Re+eIffEHc+AzmIHIShvCoQFf+G
	 u2yAfAmAqgbfhn2i2PLLfYxJAwdD6AZfIy/EbdxwQGKBn38vEN1HTNXPkKDiJLBLUZWFu
	 rd6XADRlWzM5BjllYoIE0oJbaJKOF9aeeJCcPkN7RXz5bGMaDNG7GGv2VSlkhA1gPzSKO
	 ZgWJmOOIS+lWFY5l4tjoWedtncaxLVQMfv2CBryeAPtUa1XkLnwbgp81wwKN4+x113A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851116;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=18gWwrcqzfIpEPC+DaRBeITRTy+VFLjptmj31952eMQ=;
	b=5nAdrtEoBRB9iOavNEN/lhZIkDz34kXfRK4PGDZuNIDp0ZXpZxx+zGLHY9A8DJEnITzn
	 OiRxXMjc7Of/phUpcy2tLiGsi/G8EpUOPn97WO9sHsf8kQFxORwekMwptJknsU+Txb4nE
	 Isw4D2PHWbO4IFbML4JGPD0iff8EySDyQFIWjKZw6DcibQ9ePn4rW2hfRmIjlzH/UD3R6
	 tuod1G7V1qXpxij5H6I2Uhleow7+OkzQ5YfTSyQhE3kEn3WZkyFAZNMsFKV9s+wcEcZgl
	 d6qbFIoPbH4h8M5RUQjKJEvP2sQd7A7rRzaLR/fQL3VdX4zmLC+NYLTk6vOxmUyewmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TZHtvrRR;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D487606A31C;
	Mon, 16 Nov 2026 17:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D487606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TZHtvrRR
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQLib3730411;
	Mon, 16 Nov 2026 17:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=18gWwrcqzfIpEPC+DaRBeITRTy+VFLjptmj31952e
	MQ=; b=TZHtvrRRUhK0r+/iDhik2PSUR1E0STlF3MUFzOXmWyEHdhaGfhhomFe9u
	5QsHOLELFzylE4eDC2gmTwXJobcGh+XpAFLBDC2mxFfZ9RsnvxWeS8isi6/0A0y2
	Aob+n7abNLbanXeRLjeZqkGuR8kijgwi64DFLppRLIRxBJsr+F/K3PDt/woF31wV
	ha9Cqcj9fTTkUGRHamlFyG2KNYCqe9PZH/pWIXbGXYJtz8AMzUhIVuY5EDa9Sxfb
	5NHK2tuv/gpFVH2FJLyStOXI9Lk3y6mBq63HV3qCu39BFFjthM742UH28K1CJlaT
	YvYmp5GVTKbIRJ/u3yG1HeVLr9T/g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2kxeny-1327
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:45:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCK2382350702;
	Mon, 16 Nov 2026 14:35:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bv9xf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZYw233030476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B98F92004D;
	Mon, 16 Nov 2026 14:35:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6169120043;
	Mon, 16 Nov 2026 14:35:34 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:34 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 00/15] s390/cert_store: Various fixes
Date: Mon, 16 Nov 2026 15:35:19 +0100
Message-ID: <20261116143534.158375-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afb4129 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Op9-hBDBUv0LBJ6GKawA:9
X-Proofpoint-GUID: 9kVLjyx0XeIy_bOF-5pKm2XrBvlbBgFS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX5chsOjdNVH+k
 sUO3FHRr2CK/Ds/yfsc3xwlO8qeFK91zTkI0Ylc871aInHF+ogzc3a1UML7uacYDa3jP7hnUhrV
 oyWSEGY6ANpxFc7NHQkbUD60sBeMpEs=
X-Proofpoint-ORIG-GUID: 9kVLjyx0XeIy_bOF-5pKm2XrBvlbBgFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX5c+HoK9sl/En
 4+2A2bck2EoxY8kUPckY3fVDSCo1duCe4OEOfuGBWBxsUyRZ/FPsN5YSqSyy3GAozNKfxAhmdiB
 4FV3GNfBoi4L1xT+G/uqpn2QAUmAEfHkZ/wBhwGLE29Nm3GxrZPafymT7FXDEqi+8ec4cRD5xtn
 2WczAEGm7Ajbm7lLs2l3+quAfrYWRsxxntjZ8lZJRUFzYSSHy7YoHvSPZBjpRIS2CFjPRQTyUZO
 qYAs/qYb06h3SuaQI3eO4nReJxzIzmlkA6jUd0PSZqYBxoVa6KGvpC9I6KEaMGfNysUaiNW5sKq
 8pDAT3d4lVqQG8dVIqGU0sMOIgBwnFwJG7xjybTX/kNWQ3j1otwIConD1EE7k2R+i3zc86TBEjA
 hWCb9qm5Ab+I2wBsG/8pnWoHuXRjeT0hA0TRAi1Go+zCpt9bEYE0HwSVCrM361jNmRF4ynxsVWe
 YyEQNP5KMVD4tROdUZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069

Hi Jarrko,

as already previously written here a patch series, including your patch, which
addresses various cert_store bugs. Patches are very fine grained. Also it
looks to me as if you addressed most / many of this with your patches already.

I guess the best way forward would be if you take those patches of this series
which address things not already fixed by you(?). Otherwise let me know how we
should proceed without causing too much churn.

Thanks,
Heiko

Heiko Carstens (14):
  s390/cert_store: Fix return code handling in invalidate_keyring_keys()
  s390/cert_store: Fix potential use-after-free in invalidate_keyring_keys()
  s390/cert_store: Check key_lookup() return code in invalidate_keyring_keys()
  s390/cert_store: Unlink before invalidate in invalidate_keyring_keys()
  s390/cert_store: Fix cs_keyring reference leak in fill_cs_keyring()
  s390/cert_store: Fix potential use-after-free caused by find_cs_keyring()
  s390/cert_store: Remove unnecessary static specifier in create_cs_keyring()
  s390/cert_store: Fix error handling of get_user_session_keyring()
  s390/cert_store: Fix keyring refcount handling in get_user_session_keyring()
  s390/cert_store: Do not search the process keyrings for the cert_store keyring
  s390/cert_store: Validate hash length in check_certificate_valid()
  s390/cert_store: Fix max_vcxe_length output in pr_dbf_vcssb()
  s390/cert_store: Fix out-of-bounds read in pr_dbf_vce()
  s390/cert_store: Initialize ism array in query_diag320_subcodes()

Jarkko Sakkinen (1):
  s390/cert_store: Hold keyring->sem while reading the keyring

 arch/s390/kernel/cert_store.c | 103 ++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 43 deletions(-)

-- 
2.56.1
