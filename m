Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354E1A9F97
	for <linux-s390@vger.kernel.org>; Sun,  9 Aug 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299945; cv=none; b=mw7tZqQsMmh/Ptu4DfrDPAJnatSParF0vJLpisi6ib1gK2SHADiyOdaHWLl+0gwxQAlm//Fbt3jQWF447kLNs09hOGaUvqHBikg/oTtKKGCS9mWU0gpmfjwOs1w5kHobByBe2uGW1+oGNlOD+dIVs0mpduxa/ms1nwXdDYEIr7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299945; c=relaxed/simple;
	bh=62lN2DgeyR12dBQsLDdtFGk7jpcvtn7nB+j4wZx4zo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myEq8J9jIUdU36bH5uaSRFSpjgShLajwjG628AQloRkAminUzmZlKcfxyA1eRb+jUvs4VtNoswmP9QrIM+e2ckjkNVDsTgR8yYEfsgAXIdi7hobtQMf1H38CagNfrRIIK6gP94wDFBb1nHnfY28EnrGmbhIY/w1QOnySyDQ8wuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHY3zUd+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHY3zUd+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679FWrUX3278736
	for <linux-s390@vger.kernel.org>; Sun, 9 Aug 2026 18:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gW5R5urZ1j1pYXHYmsQcdaS7/1WsCS
	kl4NTupJtk2vM=; b=kHY3zUd+XFSDv8gvRDGXHFwwoZmfpRltHsCPNO4t44hFJ8
	6YfgkoLjOET70Qa+uw1rtJRaSjbEKgPKqMPDJT4cd38mJDto06NOjyhoKySRmOVj
	J69JgFUICZUQR0YIwVuTV99e0kV7Jz99vzPwJjzD2i6GbLutn5db3i/9jMAfj0Bz
	zb0yTp/H9oNBeofGyHiNKYo2iIk0mIVG+wWm3tcjOwROlBCDgf/0w8hp6EXsGaHx
	NHXYl5L8WBUDMSz/MeoBTtr2oFyaa9KBRU4Q4xvHh/VzWQqN4cbv3gZRGtZr9DuX
	JPy35hVOklOjt4ixAM8C/hh2BDFy1O+rUBMVrBJA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq94whs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 09 Aug 2026 18:25:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679IBgF9012695
	for <linux-s390@vger.kernel.org>; Sun, 9 Aug 2026 18:25:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vt55b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 09 Aug 2026 18:25:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679IPcVE31654636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 18:25:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66B2220043;
	Sun,  9 Aug 2026 18:25:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C6A20040;
	Sun,  9 Aug 2026 18:25:38 +0000 (GMT)
Received: from osiris (unknown [9.111.66.119])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  9 Aug 2026 18:25:38 +0000 (GMT)
Date: Sun, 9 Aug 2026 20:25:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete
Message-ID: <20260809182536.21067B5a-hca@linux.ibm.com>
References: <20260806131131.2073914-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131131.2073914-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pDaQ-NPWI9uCGNNUMS-NKZUjhEIRB19n
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a78c627 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=6wzjyjoEdssgrETwuKgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2MyBTYWx0ZWRfXxsoQuScbP+mo
 1Ny9nMmV+0vocJ0OoYW6suus2do/paJVQdGtCRlO0IApjHI8cVY+0j3QRLgeFIekxjSuFlRXDjt
 iCwZLKE/TJPZeKgPFsGCoTTe2oteyKhO/kyinjGx3yv6Gfu0ZHlp2ADGmEh0SQyyPOqWIPKCQpY
 nwoKb3XYsxteGASApacrmoPMSGU4f8HRJtWQHKFsdUphZOgIwpVDa1u3ErPqNcEX+tW0iv54+p7
 ICnEKl1qNMQytEKjkq3wbrpKzD1xMLhUT0cawyjPASQzgByGR0c6gDyID3Iy1cuR7GEX3/tRicP
 fmJgCdFLc+rLxHUR0KKuHQLDY5ZI0gMjzQNUcsS5GYSfLU3p1DFWSbld1A5nrkxhs6EMO9ke6Ov
 lUmJo9SZEtd0bT1DjlbMG6Z9dgl4O77KP2kjZDH8ojfoaEi8aPmrZWRHvYbVl+ohPjNik0cHvuI
 vansD0tzjK8p31z+ugQ==
X-Proofpoint-ORIG-GUID: pDaQ-NPWI9uCGNNUMS-NKZUjhEIRB19n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2MyBTYWx0ZWRfX+sP3QNmPsaBd
 pFxQrPNCHRda6xnwTK7mQks+6PtLbFHPQEou5HxPnTMaj6CuECsoFZYnHvh8Fy6CpQywhnfWIXr
 78FAgpeFwAecJgiZc8Mbk/afYT91GRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090163

On Thu, Aug 06, 2026 at 03:11:31PM +0200, Thomas Richter wrote:
> The command 'perf stat -e cycles -- <command>' crashes the kernel
> when CPUs are hotplug added during that run.
> 
> Root cause is the allocation of struct cpu_cf_events at first
> event initialization. The allocation is dynamic and the first
> event that has task context creates such a structure for
> each online CPU. This is not sufficient. CPUs may be offline
> during event creation and can be set online during the
> perf run time. For example commands
...
> The issue arises only in per-task context when the CPUMF facility is
> used and the scheduler picks a random CPU for such a process to run on.
> The scheduler enables the CPUMF infrastructure via PMU callback
> functions pmu::add() and pmu::del().
> Now count all per-task processes currently running and active.
> When a CPU is hotplug added, check for running per-task context
> processes. If one or more are active, install the CPUMF infrastructure
> on that new CPU.  This ensures the infrastructure is available when
> new CPU is selected to run the per-task context process.

Wouldn't it be easier to add another cpu hotplug handler which is called while
the new / going cpu is offline? That is allocating and freeing of per-cpu data
structures is done on a different CPU. It looks like this would solve also a
couple of the other Sashiko reports about life time.

_Something_ like the below. Completely untested and might be completely
broken, however the implementation looks much simpler, and you don't need to
sprinkle NULL checks everywhere.

---
 arch/s390/kernel/perf_cpum_cf.c | 40 +++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 2076ac22e2c4..c88ca94b9ec4 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -110,6 +110,7 @@ struct cpu_cf_ptr {
 
 static struct cpu_cf_root {		/* Anchor to per CPU data */
 	refcount_t refcnt;		/* Overall active events */
+	refcount_t syswide_refcnt;	/* System wide active events */
 	struct cpu_cf_ptr __percpu *cfptr;
 } cpu_cf_root;
 
@@ -293,6 +294,7 @@ static int cpum_cf_alloc(int cpu)
 	if (cpu == -1) {
 		if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
 			return -ENOMEM;
+		cpus_read_lock();
 		for_each_online_cpu(cpu) {
 			rc = cpum_cf_alloc_cpu(cpu);
 			if (rc) {
@@ -302,6 +304,9 @@ static int cpum_cf_alloc(int cpu)
 			}
 			cpumask_set_cpu(cpu, mask);
 		}
+		if (!rc)
+			refcount_inc(&cpu_cf_root.syswide_refcnt);
+		cpus_read_unlock();
 		free_cpumask_var(mask);
 	} else {
 		rc = cpum_cf_alloc_cpu(cpu);
@@ -312,8 +317,11 @@ static int cpum_cf_alloc(int cpu)
 static void cpum_cf_free(int cpu)
 {
 	if (cpu == -1) {
+		cpus_read_lock();
+		refcount_dec(&cpu_cf_root.syswide_refcnt);
 		for_each_online_cpu(cpu)
 			cpum_cf_free_cpu(cpu);
+		cpus_read_unlock();
 	} else {
 		cpum_cf_free_cpu(cpu);
 	}
@@ -1089,6 +1097,22 @@ static refcount_t cfset_opencnt = REFCOUNT_INIT(0);	/* Access count */
  */
 static DEFINE_MUTEX(cfset_ctrset_mutex);
 
+static int cpum_cf_prepare_cpu(unsigned int cpu)
+{
+	int rc = 0;
+
+	if (refcount_read(&cpu_cf_root.syswide_refcnt))
+		rc = cpum_cf_alloc_cpu(cpu);
+	return rc;
+}
+
+static int cpum_cf_dead_cpu(unsigned int cpu)
+{
+	if (refcount_read(&cpu_cf_root.syswide_refcnt))
+		cpum_cf_free_cpu(cpu);
+	return 0;
+}
+
 /*
  * CPU hotplug handles only /dev/hwctr device.
  * For perf_event_open() the CPU hotplug handling is done on kernel common
@@ -1183,7 +1207,7 @@ static void cpumf_measurement_alert(struct ext_code ext_code,
 static int cfset_init(void);
 static int __init cpumf_pmu_init(void)
 {
-	int rc;
+	int state, rc;
 
 	/* Extract counter measurement facility information */
 	if (!cpum_cf_avail() || qctri(&cpumf_ctr_info))
@@ -1225,11 +1249,23 @@ static int __init cpumf_pmu_init(void)
 		cfset_init();
 	}
 
+	rc = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN,
+			       "perf/s390/cf:prepare",
+			       cpum_cf_prepare_cpu, cpum_cf_dead_cpu);
+	if (rc < 0)
+		goto out3;
+	state = rc;
 	rc = cpuhp_setup_state(CPUHP_AP_PERF_S390_CF_ONLINE,
 			       "perf/s390/cf:online",
 			       cpum_cf_online_cpu, cpum_cf_offline_cpu);
-	return rc;
+	if (rc < 0)
+		goto out4;
+	return 0;
 
+out4:
+	cpuhp_remove_state(state);
+out3:
+	perf_pmu_unregister(&cpumf_pmu);
 out2:
 	debug_unregister_view(cf_dbg, &debug_sprintf_view);
 	debug_unregister(cf_dbg);
-- 
2.53.0

