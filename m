Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E981B2183;
	Wed,  4 Dec 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311365; cv=none; b=elW3pNo1kIw2M70viUhUYQ94NJDYHqMDBWb1iqAroiV5EVtt8d190nB60ZeJuS6cWTczXq8LE0+dNqh6lCOxSWbO/Mi1IHY3c77mjGn3zw4GBlci0co9oGyMl8G/TXx01ips7+A+HMNjFD1reFGQ+u9SSFZsp+I2hLnPR+j3dmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311365; c=relaxed/simple;
	bh=9d/ORHNg1wahJ2ReZ3N3CrEOxHe+jLThSxHWdKfob68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBAmMrwLRVdObqjAO+a8h3aZSQ5t1QKX5t1fZ9FADbOsh6lVJoLdAKlWFG2c23BKQedO2jSuy6WPaMbqVU60jNveIX3NvKLwXfHeOr4+owv1ub0+gRaMzv7O13OF45Dpiv+sz0I3MSDdEGS5aeSAwkMqM2PwDVPcDh0kb55ghYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ei10aPZ0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ei10aPZ0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B45bkis002005;
	Wed, 4 Dec 2024 11:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8TXxPCu7CbB/wPbZa
	hVtAWP9y7IfzK6UIQ0ThrYc1FU=; b=ei10aPZ0W0EFNt4f5FDC7rDqcNZXS9d28
	LN+C3t6zjjtLQyEX+OnungMDRQCgdgDyejRGtRx57LK06HsLk0sAI4A4XRk49Op5
	op67h3mE1r1lxePPagj/i4p6OmthsWwawJVGkzl6vwUZTr7eIuAVRDBpdy6kMKOO
	oy1oxVjHR8IYwLQEhDN/x2WLjgh3MDetZYiqUVPncqjlBD0Kf3hkg51hu2qwsSQj
	+WxQaeAlAPAE2V7u/l+y3UWxGbTsnUcU34eeW9xovJmny6XuQFN+BVwAVTgVm4OH
	P0MGXWRBhtjT/76pYV1J6JLG4HDP2Fhiee2vo6zqC9EdZYCbr3Fsg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4pqba4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:21:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B4BLvqT025901;
	Wed, 4 Dec 2024 11:21:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4pqba2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:21:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B47PMD1005218;
	Wed, 4 Dec 2024 11:21:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxk981-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:21:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4BLqqN33751558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 11:21:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B9620040;
	Wed,  4 Dec 2024 11:21:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 222D320043;
	Wed,  4 Dec 2024 11:21:52 +0000 (GMT)
Received: from IBM-PW0CRK36.ibm.com (unknown [9.171.34.7])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 11:21:52 +0000 (GMT)
From: Tobias Huschle <huschle@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sshegde@linux.ibm.com
Subject: [RFC PATCH 2/2] s390/topology: Add initial implementation for selection of parked CPUs
Date: Wed,  4 Dec 2024 12:21:49 +0100
Message-Id: <20241204112149.25872-3-huschle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204112149.25872-1-huschle@linux.ibm.com>
References: <20241204112149.25872-1-huschle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ai3BELS_AXObsiID58AEPu0QlJwGpV0y
X-Proofpoint-ORIG-GUID: keLr_KqCpiQ-luBGJMQ9oUvmxrqS6eqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=929 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412040086

In this simplified example, vertical low CPUs are parked generally. 
This will later be adjusted by making the parked state dependent 
on the overall utilization on the underlying hypervisor.

Vertical lows are always bound to the highest CPU IDs. This implies that
the three types of vertically polarized CPUs are always clustered by ID.
This has the following implications:
- There can be scheduler domains consisting of only vertical highs
- There can be scheduler domains consisting of only vertical lows

Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
---
 arch/s390/include/asm/topology.h | 3 +++
 arch/s390/kernel/topology.c      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/topology.h
index cef06bffad80..e86afeccde35 100644
--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -99,6 +99,9 @@ static inline int numa_node_id(void)
 
 #endif /* CONFIG_NUMA */
 
+#define arch_cpu_parked cpu_parked
+int cpu_parked(int cpu);
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_S390_TOPOLOGY_H */
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 4f9c301a705b..1032b65da574 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -299,6 +299,11 @@ void store_topology(struct sysinfo_15_1_x *info)
 	stsi(info, 15, 1, topology_mnest_limit());
 }
 
+int cpu_parked(int cpu)
+{
+	return smp_cpu_get_polarization(cpu) == POLARIZATION_VL;
+}
+
 static void __arch_update_dedicated_flag(void *arg)
 {
 	if (topology_cpu_dedicated(smp_processor_id()))
-- 
2.34.1

