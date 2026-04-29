Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDDC364E85;
	Wed, 29 Apr 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474856; cv=none; b=HESkNuTx3k5tCJU/RsmLD7jigrloS2H2hHA+2pStJ3fJnkYnWxgS9lOm/mvbQpdcrqp6FzEWCO1iELELxcq9jA+yQapdKVqwrH6G+qrwWE19jd5oAoc9Mt5PjaZ+/CAWTSRruf7yY9pCn1GsR/hYSkoUDwbcA5cKNWZ7pVYe/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474856; c=relaxed/simple;
	bh=PsnQmdFOF06eb5uwm+B3cvoTGp4usELwQCFcdHOG4Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxSTsu3Ih3YGKnBr7KBQ9ydDOLKze1NKCrRNhQGs2zYq1ixlVYPker9PZqxUpb1SoK2uvmjcW1Z8T5WsbFGtsKhwm9BXa2OdkT47nmCUvP6yZRjeh4oiSSR3V2wskSmAao6mV2SIal7daEUDhTD9VXlfQ7fCicMFWMYAdwOsFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R6chvxTr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R6chvxTr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TES64p741194;
	Wed, 29 Apr 2026 15:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=b+efzKWVkcg/0oXO+Y5k8
	ZuTV/b4eDvCevcXVKOm77E=; b=R6chvxTraWiP5T+ZyDemqe+/Ewucih2FjUdfT
	BmsvcHNxjgDuVG0vc58IuUO4hjG8eEgV+pDSdLF7C/8e4h7zrdHI7uoW9l71380t
	mBsgV/y+OaPrx1cDH45kcD0Q4yC8zgSMe+FpM2cOMBJSZze+cTqHNKjf9zjiR4pt
	F16YxNsVmfCe+5zipAV0jknb8QZJ4U00BGMKKVoWwh1kcjeo+m+Zo3dbCNWkn7nq
	nW/izvqxKDdo3EgKbu+9E8WZ+Byz3Rb8YPd9hcbn8Xu3h/pKrk9mJvzX7zCzqZmF
	K14zLkUc8b4hnD+hMHpI2stLa6RHNNuGjvmUNoc663lD0arLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rb3qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 15:00:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TEcqe0030618;
	Wed, 29 Apr 2026 15:00:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avxve9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 15:00:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TF0fjq51970480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 15:00:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1FFE2004B;
	Wed, 29 Apr 2026 15:00:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE8920040;
	Wed, 29 Apr 2026 15:00:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 29 Apr 2026 15:00:39 +0000 (GMT)
Date: Wed, 29 Apr 2026 20:30:38 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, samir@linux.ibm.com
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <afIdFgDD9w2U6hZy@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <adlHKowvhn8AGXCc@slm.duckdns.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rzA6Xk_e6USVLQboiTyyaOq9OtNgCXN-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE1MCBTYWx0ZWRfXwc3zGgKQUFdB
 daEdHY/zhpypmFOO2SnAIQGCpu2Efn5AXAC9lNMuNn/Tj/HSDrPH/25Yk/gJUgWdl1EHyqKhPw8
 xKXFH7D06yrrWDZWkJ1kJgJh21WIm9LwlmuDnKQ+8sKkKIzBz7zK8T7U92gBjKFqIU39NLYjIFD
 joNae4JfJrRPJR47qLIK1bTC6c1Jtbjzv13rA/G/Xfn2Xv7ASZp2+ZuBMxqJeuD1eYp42bXbeON
 LOR0/BWy6m848sNOj0mGoEQy4nzn2dLCL9EJ4SxGzf6oZsag+54cCARkcGj41RwTQL+qN3sQhTV
 Lj7PtpD10t7U0XJmcoMDNngRwYTx0KO474T4J/yRcmtF+3RgIBm8Jk2mupgz/02if71yINaoPsY
 L6LkvHr5rC3sJOdl2wsk5aFMyKyA9AZQ/xUoQCPbKBVZMIPLEWxDk2u6E7yejxcOPb7oiAIY/iO
 dsIYm2yEPI1yJzv8pdg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f21d1f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6F5vfELAUXNlVjrrbYMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: DIeQi4eV4DF70V8l2l_cfgzeJj43tawp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290150

* Tejun Heo <tj@kernel.org> [2026-04-10 08:53:30]:

Hi Tejun,

[ copying Samir Mulani to this thread ]

> Hello,
> 
> > Seems that we (mostly Paul) have our own trick to track whether a CPU
> > has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
> > used it in his fix [1]. And I think it won't be that hard to copy it
> > into workqueue and let queue_work_on() use it so that if the user queues
> > a work on a never-onlined CPU, it can detect it (with a warning?) and do
> > something?
> 
> The easiest way to do this is just creating the initial workers for all
> possible pools. Please see below. However, the downside is that it's going
> to create all workers for all possible cpus. This isn't a problem for
> anybody else but these IBM mainframes often come up with a lot of possible
> but not-yet-or-ever-online CPUs for capacity management, so the cost may not
> be negligible on some configurations.
> 
> IBM folks, is that okay?

Even on PowerPC LPARS, its not uncommon to have possible cpus != online cpus
at boot.  However your approach will work.

And Samir has already tested the same too and reported here
https://lkml.kernel.org/r/1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com

> 
> Also, why do you need to queue work items on an offline CPU? Do they
> actually have to be per-cpu? Can you get away with using an unbound
> workqueue?
> 
> Thanks.
> 
> From: Tejun Heo <tj@kernel.org>
> Subject: workqueue: Create workers for all possible CPUs on init
> 
> Per-CPU worker pools are initialized for every possible CPU during early boot,
> but workqueue_init() only creates initial workers for online CPUs. On systems
> where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
> 400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
> set but no workers. Any work item queued on such a CPU hangs indefinitely.
> 
> This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> non-preemptible") which made SRCU schedule callbacks on all possible CPUs
> during size transitions, triggering workqueue lockup warnings for all
> never-onlined CPUs.
> 
> Create workers for all possible CPUs during init, not just online ones. For
> online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
> worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
> remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
> execute on any CPU. When the CPU later comes online, rebind_workers() handles
> the transition to associated operation as usual.
> 

With these patch, if a CPU has been onlined once, it's should be ok to queue
the work on that CPU even if its offline now.

> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>

> ---
>  kernel/workqueue.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -8068,9 +8068,10 @@ void __init workqueue_init(void)
>  		for_each_bh_worker_pool(pool, cpu)
>  			BUG_ON(!create_worker(pool));
> 
> -	for_each_online_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
>  		for_each_cpu_worker_pool(pool, cpu) {
> -			pool->flags &= ~POOL_DISASSOCIATED;
> +			if (cpu_online(cpu))
> +				pool->flags &= ~POOL_DISASSOCIATED;
>  			BUG_ON(!create_worker(pool));
>  		}
>  	}
> -- 
> tejun

-- 
Thanks and Regards
Srikar Dronamraju
