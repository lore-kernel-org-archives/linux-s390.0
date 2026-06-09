Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85B3E63AA;
	Tue,  9 Jun 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991565; cv=none; b=cP52Ns2GMaiZxKqpil5C7K1pnAaBfhQlp8QXU0Ek5VVarSFw5J5CVtx03/ZmtDA9O4liUywZfaJenmCvUJTvZdsb5DfnVabAUVmhWAil/D9CTO1d9+nxJh8NvHYQ7JZ+V2bXpA1dDVptlAsKHJ0H3D9W18DgXpHdKTHduRo9b2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991565; c=relaxed/simple;
	bh=VJrGNVcyR2xPZGEhQEkz0tel9CG6Wecu9+uiWw7GsnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQrDceXTiIwAvIHlJ2Odt4SRpBbdDXfPrS93oJKA68k4wg4JZ6wR5IVSh4MR3ZC7PKzeLX0gb3azUx82e1m+45sslFgh5BDG93HnM2kjbiRM+tLiUsStUKGSTVR+pAxJ6YOPcmn5bYWHQu6ZEXXwd47FBqL7uoxK6vlHpboNB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VTigm1Xh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VTigm1Xh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658H4hQr865974;
	Tue, 9 Jun 2026 07:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/ISPEprZWFNR+aVpg
	tTMZ+zbXJue2/RFAMBvR7fB2Wg=; b=VTigm1XhBEhVN2Zz/OmqVXPox7b0Hv1Sr
	AifvT742NJq/pqs4oSw/mGjTBEIUI4hzDX5W9Lrpr+uSGa3PlUzLMfT+1pAVP95s
	+iKBhGOOt98oTiBOynj5DB3WNXNXRHOOnd374mSTsp9t0TMid6eaPvUFPWsW9Ewa
	53Gf574vqUn5fLlkdtGJkTZprLrGBGBEtayH8Us1LUqJBbAeG49cxv11JuXVVtFz
	n6a6J+DNwv2JyvldZTb5K00g+wKm7O2O3lbKmPs78lbt0jw4ykA4sSDBySR//94/
	tAWSTdRLNqtrKYiiuwFYNA47IcuacCYKNj/ML8CHk+CKR0Kkfjd4Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6stt2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597nawV011584;
	Tue, 9 Jun 2026 07:52:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq15dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6597qWun30474834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 07:52:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DEB220040;
	Tue,  9 Jun 2026 07:52:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFCF32004B;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from lenovo-pc.ehn-de.ibm.com (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] s390/configs: Enable cpuidle driver on s390
Date: Tue,  9 Jun 2026 09:52:13 +0200
Message-ID: <20260609075213.31094-6-meted@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609075213.31094-1-meted@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sNOmNuBT-XZxd_CHDoGPnQW3sNncT2sH
X-Proofpoint-GUID: sNOmNuBT-XZxd_CHDoGPnQW3sNncT2sH
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a27c644 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=IOilmRhWZAFgXRNZ7poA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MSBTYWx0ZWRfX9/Pyp3cZ4MPG
 nZ5XZOpWFEV4PjETELeJN48xo/V97oqzlJMhkRYDXNBdyij/2aRNxfecu0SDIhG4dvQgQt8OSNC
 eWmboRBQv5OtSklacqCM7g4+AdAa1sP1X3rBoxuzBA+UQ5hIl1mUbe/4RsdMcKwZGUzK3azL7Bi
 pdP6qP40wzsnnAxB8eb7i8O2K+utpIv6JTH8vjOmLJ6w6mSrvMpOUttoGr+Amn06Foxmqm7lBw0
 OSxTfsQJwmX0Q4Wn8Qpt75KBL15mmgkfRrFmR0JajU6d1Lx/QR3Eb+w6y2sEgqBn3INUoDTqQPD
 PE2JbP3HbwJEgwEidPCRtj9BbCKgcpoZfk2eA/AOfiXIUhwcJcqjdQCoYJH7WC8RGOrbxQeHV1+
 IZYYAlkJjsT43TB1dm06I1fKip4Z3EXdoP8aoUO71SLEmmECFJHA2lcxLvsO88yPrtztCvZ/XbC
 AHzaPnj0FKACWm8JyGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090071

Enable cpuidle infrastructure, teo governor and s390 cpuidle driver by
default. They can be disabled via config options before compile or via
setting cpuidle.off kernel commandline option. When cpuidle.off=1 set,
given architecture's specific implementation is used as a fallback without
any governor or idle state support.

During runtime individual states of cpuidle driver can also be disabled
via sysfs attributes.

Ex:
echo 1 > /sys/devices/system/cpu<N>/cpuidle/state<M>/disable

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig | 2 ++
 arch/s390/configs/defconfig       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 730c90b4a876..39f2c56bd29d 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -29,6 +29,8 @@ CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_RDMA=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_HUGETLB=y
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_GOV_TEO=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index dd5fc1426c88..723ce48ce8d1 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -27,6 +27,8 @@ CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_RDMA=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_HUGETLB=y
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_GOV_TEO=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-- 
2.54.0

