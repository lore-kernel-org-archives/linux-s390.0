Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762A37C11E;
	Wed, 29 Apr 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482517; cv=none; b=cIKihdbvQHgR5UKKkE/+S8fYRKSQNFcvBFuKCrTc9Scf8wobk2+EPqarXWJtGu7oiFemvkXoDxB77iu3PJD1fa93JEGN6K313BM4LAERFKwdtyhcztW6LNw5eqwqolCDFxBcpfQD2HSOtbJ+fldNDlWQp+NQTfoW53R5+ACCms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482517; c=relaxed/simple;
	bh=3oEE8mNP1fEQHvH85BwJcjvdGL5CwHReWnc5xRPq/G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATZqSQC9Ri/tu+zMjMZxxW4+Mhelgur7UqwtMQ7wfmPz4c+73xSppN2ctnx3g3NO6ZKf1+mW40G56tVteqY7fn5xJzqJkKs33toxqwb0b9GbKXoMXHLOMXSrYhCzHPy4DIr0wQDi0gtOlC5sw4voQ9sBIsLZpbQZp5QcVSMYmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p74E8Agj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p74E8Agj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T6OPmR2209084;
	Wed, 29 Apr 2026 17:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HXOeVXJjFo1Ks1bxkaR7nsubNBjf5U
	Yt7dkN+4JM+kU=; b=p74E8Agjp+zGMrIXChJzwADXYLmezFDsZH/7YXWxaBt16d
	rL+HMDk4vgOpuV6lv4KmqaRYuhYRzQwJKVoWS+YptHHAOLI8M0SB9ZKji0sfKb9g
	2Wx+XXtPU9HOWJZSBrUzrNfo5nIPAl0KvDgPmwFfmgR47y4RJJTsohq+VruY6icI
	ktQDTyzN2ZqgKwKQQslg36UigndGQ8k23tfI1NZXA6L4BobQJ6LpMBeSKfZtmF/W
	AIa5+yf/YflYi8v2PA9i0llmHAJRFIH1c5qbelQ+WYbwziIGFHImSQy0eyGr3Jpk
	NdeIIDxjaUASq6o69DjrI6ldz/Ohoz4uLGZbRXvQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vj5gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:08:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TGrpF3004158;
	Wed, 29 Apr 2026 17:08:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gf473-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:08:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TH8PJR44892628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:08:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9D720043;
	Wed, 29 Apr 2026 17:08:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C0C120040;
	Wed, 29 Apr 2026 17:08:24 +0000 (GMT)
Received: from localhost (unknown [9.111.69.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 17:08:24 +0000 (GMT)
Date: Wed, 29 Apr 2026 19:08:23 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Boqun Feng <boqun@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, samir@linux.ibm.com
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <tte9m9z@ub.hpns>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
 <afIdFgDD9w2U6hZy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afIdFgDD9w2U6hZy@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f23b0e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fi_Fe_35YsKaL31AHi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9B7Hg_50AR7HtWBnkTGGl1c_S8YlFJGC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2OSBTYWx0ZWRfX7dSVmtUjjiLu
 xsnh/t5LnHrI3U41HANN4JuUE1fFzGqoSRqwypEXNtUVg1D8eqJRGR7x4NsFXaHQHQBaFjYTu4e
 mAxwH9yoldsHV3G06uBXfviR/RwjbKgyEyZ4vjhzdZKZWa831RXVrCqaLNGfqzUTdqzGQQQDjmZ
 mfKT1lRpqeKG7VcvxyviP6OIKkHVoq5dUrGd1Ss/7Sk+ZPZzZwcu/4zRYl7W35Wz0HT3ih1cCya
 bY3VviHvCdNpQJU3zFcDDjRix7f7ZrNDTk0Vsi56oz9BkZeBGAWR06VfodO/SunIrUycjEfLeXw
 o/ui8cFCa9Kh19PpZbljTOTsaqw69PbPtvAg6D56l4naP9WPZ3hwOmiCbxAtyfR3mYzYfhkGcOZ
 gIEock81cRs9bNQWUhs0Oud0PElC8U9VPitlSdYln3gHzWj1Yg/8mw3ZcHuULIWPvxX8NHb14B6
 7M5Nr3kG+j1JdkErDlw==
X-Proofpoint-GUID: rV8tch9Fprmqi3k_r7twl_k0HsWpkj1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290169

On Wed, Apr 29, 2026 at 08:30:38PM +0530, Srikar Dronamraju wrote:
> * Tejun Heo <tj@kernel.org> [2026-04-10 08:53:30]:
> > Hello,
> > 
> > > Seems that we (mostly Paul) have our own trick to track whether a CPU
> > > has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
> > > used it in his fix [1]. And I think it won't be that hard to copy it
> > > into workqueue and let queue_work_on() use it so that if the user queues
> > > a work on a never-onlined CPU, it can detect it (with a warning?) and do
> > > something?
> > 
> > The easiest way to do this is just creating the initial workers for all
> > possible pools. Please see below. However, the downside is that it's going
> > to create all workers for all possible cpus. This isn't a problem for
> > anybody else but these IBM mainframes often come up with a lot of possible
> > but not-yet-or-ever-online CPUs for capacity management, so the cost may not
> > be negligible on some configurations.
> > 
> > IBM folks, is that okay?
> 
> Even on PowerPC LPARS, its not uncommon to have possible cpus != online cpus
> at boot.  However your approach will work.
> 
> And Samir has already tested the same too and reported here
> https://lkml.kernel.org/r/1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com
> 
> > From: Tejun Heo <tj@kernel.org>
> > Subject: workqueue: Create workers for all possible CPUs on init
> > 
> > Per-CPU worker pools are initialized for every possible CPU during early boot,
> > but workqueue_init() only creates initial workers for online CPUs. On systems
> > where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
> > 400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
> > set but no workers. Any work item queued on such a CPU hangs indefinitely.
> > 
> > This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > non-preemptible") which made SRCU schedule callbacks on all possible CPUs
> > during size transitions, triggering workqueue lockup warnings for all
> > never-onlined CPUs.
> > 
> > Create workers for all possible CPUs during init, not just online ones. For
> > online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
> > worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
> > remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
> > execute on any CPU. When the CPU later comes online, rebind_workers() handles
> > the transition to associated operation as usual.
> > 
> 
> With these patch, if a CPU has been onlined once, it's should be ok to queue
> the work on that CPU even if its offline now.

That already seems to hold without this patch, what this patch newly
covers is queueing on CPUs that have never been online.

Do we actually need to create workers for every possible CPU at boot?
On the s390 LPAR in question (76 online / 400 possible) that's a few
hundred extra kthreads kept around for the life of the system.
That's probably the same on PowerPC.

Wouldn't Paul's SRCU-side fix [1] alone be enough here for PowerPC
as well? I retested it on s390 (76/400) and on x86 KVM with
--smp 16,maxcpus=255 and the lockup didn't reproduce in either case.

[1] https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop/
