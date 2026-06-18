Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8F3F483C;
	Thu, 18 Jun 2026 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784081; cv=none; b=Ak3xv1LEonw3qTZdm5LmaZ++B2oFy5DW44lH78xg3VxlcGwdoyMHGlp5lZYMTphliTDdthbjurpHJJlWaMXnrvlqeJPEHvJIpuisU/GJZBjdKrNSw8xyM1vJEOpQcCN/0GtpD4LW4QXH8XYhVbLK7aNqN+ZmD55RgBXO7UKmkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784081; c=relaxed/simple;
	bh=fdBmw70s3kUMBVdD1OgmpTx3I3PJuookdTDXjmw4JhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+/iCbNz1nc9an1GrI7MnnGfztwTtF0Kby0vMzErxEwxhNBXT5jRqJ+oa/1thsAvL7X8o0XfhIpATAb8KEfjEunFddkMTOzIkHSjY2qMLGDBoPcldW4Ssx+WL8yo5hQnwCDTbprOOLVSOdCEEGmDa0m6nJcJyYMl9NAfW/J95Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tOZYAkL9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tOZYAkL9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IBIXRp3163459;
	Thu, 18 Jun 2026 12:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S9tp1+
	tZ/h+q+pntemom4CWeZzb+/Loq3zzbPve1seA=; b=tOZYAkL9gY+p9pP87B3eTj
	0iWgSJcBcLaGD+XR5R9I4Y5i3ntTf1aWoN4vl/V/Wxlha75Tx0IzPFWyG9FpMFKG
	fow51X75qk7fvs7zg51ZJJRTIz/BZIJQQUpa6rWA3FW1gEQzquQHFKMfbX+VoP52
	ib+gR1H4O3OmHeZE6Xkno2Uvcxt0fyPypZ3uuLt2AvyLoLHnAHiYGtcjAOKjr0AV
	nj/so2vkaoAogHUQ8Ivc3B2xQWcHVUts1JmWTATynPq71peX+Gg5zB5LSiIA5Y6P
	YwIVvb3WHveTApnS5YtYAJgtnQPLLnQxVW8svlcW0z+MbNY117o7xKsGkQ+yRbvw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx7td7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBngEZ011349;
	Thu, 18 Jun 2026 12:00:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172bhhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IC0naH21955028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 12:00:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FA1B20040;
	Thu, 18 Jun 2026 12:00:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7CBC20043;
	Thu, 18 Jun 2026 12:00:48 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.73.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 12:00:48 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 18 Jun 2026 14:00:19 +0200
Subject: [PATCH v3 5/5] s390/configs: Enable cpuidle driver on s390
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-idledriver-v3-5-684061eecbcb@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
In-Reply-To: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
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
X-Proofpoint-GUID: cu_PEPS5gl0jdGqf1b0SZZkqDKNQFJ-D
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a33ddf6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=IOilmRhWZAFgXRNZ7poA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX/fnaFkZeP2Mz
 8IDfxDprwq1CQhclpNmgbzAoIbijZhQSF1MO/sEheEnM4EB2tWvxLRxR6YeL00REDQQH8S+op6d
 ewavzjkM5hhcKHDVHshYP2njnra1Ng8=
X-Proofpoint-ORIG-GUID: cu_PEPS5gl0jdGqf1b0SZZkqDKNQFJ-D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX8+Com29q9ITg
 s37r4abVWZYXUfbcFZQRGEAypSySf1lZg9PX2QYxeHO6bITBSAszpspL8Wn+CBYXwmDWAdcJULW
 zQt5msa1v+QWxEX4OsMIa1A10C7gj6ekfY1Ev2jM0kvoQAe185rq5Mje0sJDOFNg/K8LilrXBdS
 a7Ha8WP4siU8y5tpOjkpdIWfvLUqEipsbmwGQeygkpvkdqkiW0WU5Am91lafvk7zqNBY1sZRJZH
 mgl5Lqj45ohBvWA6IA4EfFA96cD1WdKjIMUiNO0Jqm8DQkmlZ4DDGalWQVI3cfhKOmcurVD3Kno
 xKXXdMlMRFUgHtlZZTdXMugp92yDZ2z2tPrCqbWJsi9orIA6KFFFLCwJ4omuGBm4Eh+F2ZVA0u6
 VtesUJjsbFpRTmkpCPuWZnVNG4ZaE01ubmYj/pjClLlnaWnsL1QIuRbyZZEtaf4WQVOpsf8U1Un
 OgzM8MnUPKGvmDTQyqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180110

Enable cpuidle infrastructure, idle governor and s390 cpuidle driver by
default. They can be disabled via config options before compile or via
setting cpuidle.off kernel commandline option. When cpuidle.off=1 set,
given architecture's specific implementation is used as a fallback without
any governor or idle state support.

During runtime individual states of cpuidle driver can also be disabled
via sysfs attributes.

Ex:
echo 1 > /sys/devices/system/cpu<N>/cpuidle/state<M>/disable

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
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

