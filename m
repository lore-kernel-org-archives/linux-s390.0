Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E562E737E;
	Tue,  9 Jun 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011488; cv=none; b=UHSwYyjywbvsu58FXkY2hGdm+K7R4XRVPVDiuqFwNvGnDWQTc/gROlKSy8Hx4rmwxwTgqfIThEK/qmOhFW3/5FVFZfYvLU6wNN0vTT/Jtk/pRGWoDZ8/pyAiShwz7XbniOxod+cbVvYxCkhRLgJ/rnHlr0hMbrS04yM1aqajwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011488; c=relaxed/simple;
	bh=VrqOAjY93GMo9F1p2g5tJ5xb+OSduVfcfEgY6v87o/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9Gg0Lg4x1V8cDdxCFyur+k70w2kfLv7/Ob8N4NOnDR7qs1aTPCtjwFygTjLLs+W73wYDAOZC/ULKejVCbnP+YaKjfXoiwBUbPxAwwJcyQ4D1EZdyTJwE2ERe26oZ0LCKN0DKIc/ZNXQMAq5Ficlh7xvOJao9TEimdVAiB860PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dqH+g/er; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dqH+g/er"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6592psof2615075;
	Tue, 9 Jun 2026 13:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CNRMBC
	OZ3MgVIL2vx0clMfnmeNaJ1NlAwln8ChyAhGE=; b=dqH+g/erTodH4maOcsp/xi
	dNat13vNYbHmqgIzPhAZM1yNlzJ7VljwHL+YlKZ4HXZK3pHdruLXIxl0DrihJtgI
	Zl3NQTsqa3vieJEUAoRenEBi8ehskCGI8Rx52E9sQzQ6yLUXnwfRInO+5Y+iRqjA
	jhpB9C+kS8hCA6XL+xGykjEX5T1AIIkz/bih90IERWgfjl1x9lSy/kN2AOPD23xd
	az/kBnl5T3jP6F/tgJSC/ZM4MNPUwi0m/PK8s533NdEtlL3mvwGweWYoSaD0ZMua
	Lc5JzZAfZS8C3K1VZniygrHWENILI78Ngr+ffH1I1wHJhxVN/w1SHH6cf/l3DFyg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95ca7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659D4bxv019817;
	Tue, 9 Jun 2026 13:24:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjt45u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DOTPt18219368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:24:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DDA12004E;
	Tue,  9 Jun 2026 13:24:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D92D2004D;
	Tue,  9 Jun 2026 13:24:29 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:24:29 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 09 Jun 2026 15:24:25 +0200
Subject: [PATCH v2 5/5] s390/configs: Enable cpuidle driver on s390
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-idledriver-v2-5-21c2f581d11f@linux.ibm.com>
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
In-Reply-To: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a281412 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=IOilmRhWZAFgXRNZ7poA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gN7xBHzgPwylV2ntVFiUDe2QJv4ZhHZk
X-Proofpoint-GUID: gN7xBHzgPwylV2ntVFiUDe2QJv4ZhHZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfX0E/Vj19qKUdF
 lbsCRFlRV9pI92njLfVfXh71p/+HmNJtkrI6CBYYe6c/4efTWF9l50zeNCHe2cHopunRZ0UBMl3
 RJezj5EErPDZfzUxIjstERWms0vIURDPUk1y6fNOZEc60fiAfOe3BQC4jCtbRV9XmjOZAVryuDm
 EWLCJhZn0Exm5KxRf0kiUxwnk7Trh22BxKM/H11id+xlXpNULYZkQrkypjXvFhIo5xOYmT/SNe5
 dSDSQxXL6Rm7UiADgywBpSTXxL0W5VLpopK1DdoLlKOlmQWFF4wmtp6qVKg0z9ALRDAQ2XiYE1j
 CN7w/Ua1CZZL7R6HhMECwaykesofYa1kxT0zc7sXK/sV3HDXdjDp17qxpXtoBaHNDJwI7RRa9me
 V1K2QgmLyuwgBCnSEXMDuoXki67JanUZ1oEWTXIG0bp/R0GQHgmuGef+gSoERV5XjSgNFDIoXVZ
 p1WJLYCScAc2Trd8NgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090124

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

