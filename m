Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B3495518
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813823; cv=none; b=u4xQMYEp1/IGp9keQElH6gAFE9LF6brcziVvqGQkVL6M/Jaq9hASy5QearEKvrf88VFELKQGBtKy7e+TRt6MZpwx+7OO1mHzbWV0Q8ZsYR8nIaNJ/qFaP9x75k3i4kuzmQDNs7C73WXdNrWRPhSH3Xc1JTVFOvlvy4XaMTrO1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813823; c=relaxed/simple;
	bh=wA/swGMOWuhDXWYqhwXy5inrAGmrk/0a50gBsgDa1h0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dAqAcCGc5VyC8pEQyc3xrR1dwLCWpBQIt6yoneU/wk4lSL7BX5F++q0XeeSCuevJrE1M1Mr0IApRQyMiEgyfG4m0/ODG91aFHLCyN/NbHWj9Tjbkt18y3faW232/UnfHPM1BchHu23LHuHJgQI2SooOltEEOfoiPIFvCdVRff/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O+oXo32u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O+oXo32u"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBixI1210610
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=4oxxWhICXBuK32WQAMdLCOHVKQlS
	qcteX6E09oo9znk=; b=O+oXo32uOSIfeEgBsUZvEd3kkO9uncgEjQJ29qPcYB0e
	uqcJ/BtfcGcfHcnM27CJWXlXZEBL4ALHWJmDm0BTE4yzFK78RdySZiLUlYcduO+P
	Fpu1VRU5q8hFe2+xPtNAaCnAWTzL2UDQaE1Sp5IGNABXj//OXpeRW/I3OloK8VgI
	DPW2iOsAN0ePiLXUXXJ816Vjy2mece0StI1Uxqc7AjYlTRDuzWr1DP+oUkr+REd4
	LDSzLiP/ND6GYFNz8L8tOBySAr3COejtSxWlaJTyT2HJRvfChCe1a+xmsTYwTUTM
	o3kKkXodaKiLrto/7OoOha2HFPb/oCYJqclrnbLfJw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aqrwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:36:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYbc9021349
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:36:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcay4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:36:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDapjN47382900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:36:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9952004B;
	Thu, 23 Jul 2026 13:36:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 261DF20040;
	Thu, 23 Jul 2026 13:36:51 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.15.158])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:36:51 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 23 Jul 2026 15:36:43 +0200
Subject: [PATCH] s390/smp: Reflect (de)configured CPUs to cpu_enabled_mask
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-enabled_cpus-v1-1-3a2cbdc374b0@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyND3dS8xKSc1JT45ILSYl0TI7NUU2NTA7NkMwMloJaCotS0zAqwcdG
 xtbUAQ5UrG14AAAA=
X-Change-ID: 20260721-enabled_cpus-426e53506c60
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sq-avPOzWux5SgPeSc730i3JvE7hHDeY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzMCBTYWx0ZWRfX+FHFJMf7QDzc
 2vupALJL3PJSnP9Tg5MJqHFkLdjk0/1qVAmGpM/jt84Mong3/DUsGmpNmHG3hJ8uGYLpBALEzmY
 RzRYugeAbsZX+hxyLiV9qNzgsPHVK5I=
X-Proofpoint-GUID: sq-avPOzWux5SgPeSc730i3JvE7hHDeY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzMCBTYWx0ZWRfX0VLjjTPu7NPS
 Cyu1B2PB9S29oek9aZCcj5jp80VdOTlh+N/pUO5ypyOMsraIMUoN6U4oiqZb7yVkeo4jCtZBYWP
 Askcmi8Uqa2LU12ajmXmn7lPKIdE5L61kLoYfHsK/5okXxNXCM97ie/jBXVWgplYrQUnaGUx7+J
 PlIBpAEa5yUUaHCjBUymtkD3N49SrsTC3YDHANfyxMLdrsDeAB4nt/4N7S9UQHO8Q43Vx57RR/v
 JJjfO4ZtiTWFByPetHRw+kc5k0WDFf3/FxrZdU7XQW6H+WI69xatI48Lh5o0+OXzu+w1KkG9B6g
 aFk3O7F1NixGZ/hFmkG8+uWGWfM3V/rlV9hXTJlOvkiE61JJ2BhTc36wAMR0eJkGaVsNQBJQgoJ
 t+BXJT9jShfQlUmBy7bUkpVeYZNse06jGVyXJYzGS9w5eKmab6U/6FaUvhaGUpoDVcLlYuEAhep
 c5LmoAJPwpQ+NMoBDVw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a6218f8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=iX68x9PPo-yUIqnrTLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230130

On s390, CPUs can be in a state where it is not possible to hotplug
them online before certain prequisite steps. For example the CPUs which
get introduced during runtime of a system can posses a "deconfigured"
state which prevents them from being hotplugged online before they get
configured. Another case is when users set the configured state of CPUs
themselves via "chcpu" or sysfs attributes.

On s390 available CPUs are being registered as new devices via
smp_add_core() either during boot or after a CPU rescan (for newly added
CPUs during runtime). Registered CPUs are marked as enabled without
considering the configure states. Add necessary checks to smp_add_core()
and userspace configure attribute handler. Reflect the configured CPUs
to cpu_enabled_mask to correctly represent which CPUs can be hotplugged
online.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
4e1a7df45480 ("cpumask: Add enabled cpumask for present CPUs that can
be brought online") introduces a new cpumask to signify which CPUs can
be hotplugged online at a given time.

Originally the concept is introduced to reflect CPUs which are being
kept offline by firmware decisions. For s390 the configure state of the
CPUs matches this concept. CPUs can assume configured or deconfigured
state. When a CPU is in deconfigured state, it cannot be brought online
util it is back in configured state.
 
On s390 available CPUs are being registered as new devices via
smp_add_core() either during boot or after a CPU rescan (for newly added
CPUs during runtime). Registered CPUs are marked as enabled without
considering the configure states. Add necessary checks to smp_add_core()
and userspace configure attribute handler. Reflect the configured CPUs
to cpu_enabled_mask to correctly represent which CPUs can be hotplugged
online.
---
 arch/s390/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0ba7f89b8161..e0c9480c7bd2 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1039,6 +1039,7 @@ static ssize_t cpu_configure_store(struct device *dev,
 			per_cpu(pcpu_devices, cpu + i).state = CPU_STATE_STANDBY;
 			smp_cpu_set_polarization(cpu + i,
 						 POLARIZATION_UNKNOWN);
+			set_cpu_enabled(cpu + i, false);
 		}
 		topology_expect_change();
 		break;
@@ -1054,6 +1055,7 @@ static ssize_t cpu_configure_store(struct device *dev,
 			per_cpu(pcpu_devices, cpu + i).state = CPU_STATE_CONFIGURED;
 			smp_cpu_set_polarization(cpu + i,
 						 POLARIZATION_UNKNOWN);
+			set_cpu_enabled(cpu + i, true);
 		}
 		topology_expect_change();
 		break;
@@ -1091,6 +1093,7 @@ bool arch_cpu_is_hotpluggable(int cpu)
 
 int arch_register_cpu(int cpu)
 {
+	struct pcpu *pcpu = per_cpu_ptr(&pcpu_devices, cpu);
 	struct cpu *c = per_cpu_ptr(&cpu_devices, cpu);
 	int rc;
 
@@ -1104,6 +1107,8 @@ int arch_register_cpu(int cpu)
 	rc = topology_cpu_init(c);
 	if (rc)
 		goto out_topology;
+	if (pcpu->state != CPU_STATE_CONFIGURED)
+		set_cpu_enabled(cpu, false);
 	return 0;
 
 out_topology:

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260721-enabled_cpus-426e53506c60

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

