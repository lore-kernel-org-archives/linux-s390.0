Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DD3CC9F3;
	Thu,  9 Apr 2026 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740135; cv=none; b=Fbs3ZuFRNbaU8BKVZvkrSBmiwW5ObsH93hlquJQgN7ny2E3gUeYyTdIgaUu3YRuHUjwUXlAaW5Xn0ncOqC1pzUdh+8LaxoWvDa/PgbOrfg54V3oHFiGCLoB5dx7bGQZ6hQPFghMsBomaC3icI0LBagzIj1Z5rSTRmEVYH4c9oIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740135; c=relaxed/simple;
	bh=yvW6Q/2C0hWlA+2rbPyW+4fR5Uyu/aonoIEZfH7TF0U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JnJGVkZwcAcEHNABaqMOUb7vUp8pampu6lsFJaEbYvXf6vsXQ7KPdpz2BizI4Dwt5ohEruEjUZgoV3c2GoAJo2JQTl2KWsquN12GM97q9qmNjAHjMDIN+BDpVZniLNCRq7gq4AsvL2nNBH03s2wABFQFadm6OLx4E42xPjcczV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mssaQQc0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mssaQQc0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63971YtH1656683;
	Thu, 9 Apr 2026 13:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=b1qzyYbkLGFm5HR/Kqtb2MMTPOczP3DAHnMmn03rSfk=; b=mssaQQc0
	8/OCpjvADSWs1Ov/ygL8njRM2YzRB1yXBN54oxQowchRcOl6swvAshQxRsBOBchO
	ynZ10BNd2YQaNvK5hYzGZB5cKF0wHMgx4tmpy+UtEFEG7Upx31p3DOnhJpSlBDci
	0uBTofDdEcJRvOxy9iPlYn0FJswZf3g3YSXGmyFw4t7rIZateKVzuV2BZx43SzTG
	62dPWEDvmiNn5ZZV4FI8KZYBXYARj6d+b22O+eTxbhzPpV+2lebI67oRZM5csG6w
	nsMP5a/JYmFu/ONO99ZEdTaCQcAZv+xX+YsEwqeuKQGxPqDZBf/52i3aGX8zu60z
	2/wemDpKwaqTJw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fn2cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 13:08:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639CkUaG014361;
	Thu, 9 Apr 2026 13:08:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4upb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 13:08:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639D8ld430474516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 13:08:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B4820043;
	Thu,  9 Apr 2026 13:08:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF4AA20040;
	Thu,  9 Apr 2026 13:08:46 +0000 (GMT)
Received: from localhost (unknown [9.111.74.150])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Apr 2026 13:08:46 +0000 (GMT)
Date: Thu, 9 Apr 2026 15:08:45 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <ttd89ul@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDExNiBTYWx0ZWRfX3XGf2/pQz0R8
 mDKggQm9yvI+ys4jqQ+dXzdPOF7RbHVsFt5ttuimEVUbAtmwogUSy8xUa1v1rSOrykBaJk0901U
 62sg0aHAvm0vfg3GOnucMZfyJT4d65izVqXTbB1/1TIgJxJgLTyQYHBEtRPJCPzkg4bGhGU1P9G
 zfmvjXMdjT9f1nU0QVFeWchLxB1iIteiWCPa5egBhO3kxi1YVWG79lrCwtrJ4t25NCWhw0hFL1h
 AviYfRGh6MxNC0W3Lt+RYFH3n4rx1n8QUIrf9rQQOd8zGZIy1KgI4e5NVQzVHyLiW2nRXxgZVt3
 zdafUcu8Kz1+atxOm/auoUp8u9iKgubw35PfxTGOvoPa/5Wd2bQ31S+Z1WAASm6mzPSYXRBfTi8
 sOxxub/IXYBhg6hxYu5IpHIYPo9jOjL0zsJU6P02wumg/VtfaaaMk1hhIhndXFm2KiU18jX/tRP
 nOC6WFrJgY14CGfx09A==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d7a4e2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=gOZagzUxaop8oxifnJsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nd5bxcJf3zcRS2I22rIh841LYzpqXeIH
X-Proofpoint-GUID: 99aKgxKkItW7gndQkK9-h0N4_KCR7PKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090116

Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
non-preemptible") defers srcu_node tree allocation when called under
raw spinlock, putting SRCU through ~6 transitional grace periods
(SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
per-CPU pools directly - pools for not-online CPUs have no workers,
work accumulates, workqueue lockup detector fires.

Before 61bbcfb50514, GFP_ATOMIC allocation went straight to
SRCU_SIZE_BIG, the mask = ~0 path was never reached.

Affects systems with convert_to_big active (auto when nr_cpu_ids >= 128)
and possible CPUs > online CPUs. Hit on s390 LPAR (76 online, 400 possible),
where possible CPUs > online CPUs is the usual case.
Also reproducible on x86 KVM --smp 16,maxcpus=255 (CONFIG_NR_CPUS=256)
or simply -smp 1,maxcpus=2 with srcutree.convert_to_big=1
or --smp 16,maxcpus=64 with srcutree.big_cpu_lim=32 (CONFIG_NR_CPUS=64)

s390 log (76 online CPUs, 400 possible, all pools 76-399 stuck):

  BUG: workqueue lockup - pool cpus=76 node=0 flags=0x4 nice=0 stuck for 1842s!
  BUG: workqueue lockup - pool cpus=77 node=0 flags=0x4 nice=0 stuck for 1842s!
  ...
  BUG: workqueue lockup - pool cpus=399 node=0 flags=0x4 nice=0 stuck for 1842s!
  Showing busy workqueues and worker pools:
  workqueue rcu_gp: flags=0x108
    pwq 306: cpus=76 node=0 flags=0x4 nice=0 active=3 refcnt=4
      pending: 3*srcu_invoke_callbacks
    pwq 310: cpus=77 node=0 flags=0x4 nice=0 active=3 refcnt=4
      pending: 3*srcu_invoke_callbacks
    ...
    pwq 1598: cpus=399 node=0 flags=0x4 nice=0 active=3 refcnt=4
      pending: 3*srcu_invoke_callbacks

Not sure if replacing mask = ~0 with something derived from
cpu_online_mask would be racy in that context.

[1] https://lore.kernel.org/rcu/acRho9L4zA2MRuxc@tardis.local
[2] https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop
