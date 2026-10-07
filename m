Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B523F54A4;
	Wed,  7 Oct 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384295; cv=none; b=rtZfp6sPruQE2VgrD/RqGsrYg3W+e0C67TETPUsik01/MXShQOCY0wQ4A4b9Jshg6fhIVjyAyLGWvqVbXCkycGKWQCIdwcm7kM04L7fW3+Pn7BwF8IwYP2KSVnEvrQlXX5cSg7u4MHq5eMNuvP9pZ2YA0j4uGa825oJQILHpJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384295; c=relaxed/simple;
	bh=IaO0sEB2/gLfkTleDFEQK4E5yAMzvgvmlQJCsjdz4X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUcEWXhNzFtJ+BvK9RRiQkBadFi8ns2weBQoPVr4R9EKGQ4Ij67mRnrIks1WJvBv9JoOw+xL65LMnHYSFC755jncgDoAYdQZwi69CBPXF+bNLo19ZSWMWAgRXs4VPqMnI6iQZVRr5IB83aN8hOOx5z94IAhmc8QjK5vv+6eX3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHNMGaeg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHNMGaeg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZudY596972;
	Wed, 7 Oct 2026 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ybxBxT
	W/b9UGnnvaf11PygeEajkZnxqfAob0DPzPA6o=; b=HHNMGaegvwb/jZA1S/qMlx
	LZVh8AGURn1u1rbUjubxEJHQz5p4dzeVJvMJddHcREOSZrau0DrblKmNOsC8YbLV
	KTz7Hfbe3lqYLsqSOl0G0GlsZ6EJ78N4Q/x1IaMPjmagjm+ZyG1dU+IvZbDJEHrh
	FR24UnEmvgZvg4NTBbLerYo8AfCCcnuzGTP0LJFDrERA0YEEmZ+JVfHAPVMfEpbB
	Z6lqs682VUUVXPVdOtPNl0laeKeUF0B0zBMRIcqfqpMwOlfoNQsaUZhcsuiig195
	bNfbZPosJqsSAPa7fjFw/Cf4SAtGHBjcSR8xaPDziPCy8UAp+SJ0pIoeW9yqiHlg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrnyqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:43:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697Blf0Z1808496;
	Wed, 7 Oct 2026 14:43:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvy396-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:43:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Ehdwr31916698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 14:43:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D7E42004B;
	Wed,  7 Oct 2026 14:43:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC4DD20043;
	Wed,  7 Oct 2026 14:43:29 +0000 (GMT)
Received: from [9.39.25.200] (unknown [9.39.25.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 14:43:29 +0000 (GMT)
Message-ID: <61b01870-ddcf-4c4f-8604-dd63aa4a07a3@linux.ibm.com>
Date: Wed, 7 Oct 2026 20:13:28 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/13] powerpc/setup: Initialize sbm topology based
 on coregroup / NUMA topology
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mips@vger.kernel.org, loongarch@lists.linux.dev,
        driver-core@lists.linux.dev, Ritesh Harjani <ritesh.list@gmail.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-7-kprateek.nayak@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261001192849.74788-7-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX5FGpZUbb+JPz
 BHJgYCk2JcRqqYX6PtLJNa5oWRLui92CaJzh+kk+cJYYtsL9DvVbnTPi2oVWKb8TDyIAEm8hOmD
 FGKjQpoXlK7m115eLETI1vF9AYUCs7I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX5ukkGIuMRNwg
 S9ll+KBqsDVsWpue+RzZexXhXGs+9sGoeFG/u4Wu6A+E6OyYZ71mOCd2Q20F1QVNdakPxGjaiEy
 ptwMnYDKm7R4U/GUs542r3EdUul1gMA3IKyVQys8a23qWFelENdYgZzE7U1nhsl7s9LXYRVJLXR
 Cf8t5X+1SnkgPcoucNQXw7rjLGJMV3PnIVWcRpgyXhwijDKuAE4oXzod/WCNxBHA/TCBK2L4+9B
 MIHUbR8tauqQlD87KArJYmj1xACotXtqp6RYpywTrvxtDL8quiPu3o6vB0d4xcDiPDO9pLRoe+j
 kAYUZkV4YgDjJGVA8MLMbXqbS7EdU1t4JIxa18Mrkn1aVtvUx8mm+WbOGh+Ho6ngA3lu0E4s1Qf
 vv/arXwuAVmAiVz9rJU4Ed93Zp1NaXaqT6ZEpLDXvu717FtECJ5JGjAsWeBBNoLo+lFt/WM4tHi
 tyemFiieRzYpCge4Zfw==
X-Proofpoint-GUID: kbjAw6at_gYi9kpW5NW2eW_Z3iPlVUmR
X-Proofpoint-ORIG-GUID: RniLqba5eNFPG8ZKN9kokCpHs0UviAPN
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac65aa1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=ID6ng7r3AAAA:8
 a=zd2uoN0lAAAA:8 a=5-s5fGl8rxULNuXv-HYA:9 a=QEXdDO2ut3YA:10
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070058

Hi Prateek.

On 10/2/26 12:58 AM, K Prateek Nayak wrote:
> Initialize sparsebitmap (sbm) topology based on the coregroup
> information. Each coregorup gets its own sparsemask leaf.
> 
> pSeries and memory hotplug are interesting since a hotplug can place a
> newly added CPU on any online node. This requires special care to allow
> estimating bitmask size considering the worst case scenarios - each CPU
> onlined is on a separate node, and this is a new N_CPU node.
> 
> Platform may enforce a stricter standards for the CPUs being online and
> what nodes they can be mapped to but the current implementations makes
> no assumptions and considers each CPU can be onlined on a unique node.
> 

I think this suffers the same fate as structures which are allocated at boot
time such as runqueues.

So your fallback option of putting all the disabled into singleton node may be
sensible option. (If you are not doing that already)

But yhea, will see more into it, this changing node stuff is new for me too.
Also i need to read your patch series too :)

> pSeries systems that can hotplug CPUs (detected using smp_ops) use the
> NUMA topology instead for sbm initialization. arch_sbm_cpu_instance_id()
> on these systems use cpu_to_node() mappings to match CPUs to sbm
> instances.
> 
> XXX: This requires further optimizations to shorten sparsemask
> traversals by keeping the number of leaf nodes to a minimum. If there
> are nuances I'm not aware of, please reach out.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Tested on ppc64le_defconfig with:
> 
>    qemu-system-ppc64 \
>    -M pseries \
>    -cpu power10 \
>    -smp sockets=2,cores=2,threads=4 \
>    -m 10G -nographic \
>    -kernel vmlinux \
>    -append "root=/dev/ram sched_debug"
> 
> and also on ppce500 VM based on instructions in
> https://www.qemu.org/docs/master/system/ppc/ppce500.html
> ---
>   arch/powerpc/kernel/setup-common.c           | 88 ++++++++++++++++++++
>   arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 +++
>   2 files changed, 98 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 4afaba19b586..4b57ad553172 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -11,6 +11,7 @@
>   #include <linux/export.h>
>   #include <linux/panic_notifier.h>
>   #include <linux/string.h>
> +#include <linux/sbm.h>
>   #include <linux/sched.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
> @@ -602,6 +603,87 @@ static __init int add_pcspkr(void)
>   device_initcall(add_pcspkr);
>   #endif	/* CONFIG_PCSPKR_PLATFORM */
>   
> +int arch_sbm_cpu_instance_id(int cpu)
> +{
> +	/*
> +	 * In case of pSeries processors, sbm masks are
> +	 * grouped by nodes where the cpuhotplug
> +	 * operations can remove and re-add same logical
> +	 * CPUs on different nodes.
> +	 *
> +	 * See comment in pseries_cpu_hotplug_init().
> +	 */
> +	if (smp_ops->cpu_disable)
> +		return cpu_to_node(cpu);
> +
> +	return cpu_to_coregroup_id(cpu);
> +}
> +
> +static void __init setup_sbm_topology(void)
> +{
> +	int num_sbm_instances, max_threads_per_instance = 1;
> +	struct cpumask *cpu_sbm_setup_map;
> +	int i, *__node_thread_count;
> +	int disabled_cpus = 0;
> +
> +	cpu_sbm_setup_map = memblock_alloc_or_panic(cpumask_size(), __alignof__(long));
> +	__node_thread_count = memblock_alloc_or_panic(nr_cpu_ids * sizeof(int),
> +						      __alignof__(int));
> +
> +	memset(__node_thread_count, 0, nr_cpu_ids * sizeof(int));
> +	memset(cpu_sbm_setup_map, 0, cpumask_size());
> +
> +	for_each_possible_cpu(i) {
> +		bool found = false;
> +		int j;
> +
> +		if (!cpu_present(i)) {
> +			disabled_cpus += 1;
> +			continue;
> +		}
> +
> +		for_each_cpu(j, cpu_sbm_setup_map) {
> +			if (cpu_to_coregroup_id(i) == cpu_to_coregroup_id(j)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			cpumask_set_cpu(i, cpu_sbm_setup_map);
> +			__node_thread_count[i] = 1;
> +			continue;
> +		}
> +
> +		__node_thread_count[j] += 1;
> +		max_threads_per_instance = max(max_threads_per_instance,
> +					       __node_thread_count[j]);
> +	}
> +
> +	/*
> +	 * If CPUs are disabled, they may pop up on any online node.
> +	 *
> +	 * XXX: Any implementation nuances that can help this?
> +	 * pSeries says only online nodes can be extended.
> +	 */
> +	if (disabled_cpus) {
> +		num_sbm_instances = num_sbm_instances + disabled_cpus;
> +	} else {
> +		num_sbm_instances = cpumask_weight(cpu_sbm_setup_map);
> +	}
> +
> +	/*
> +	 * If disabled threads exists, assume the maximum threads per
> +	 * instance can extend by the number of disabled threads if they
> +	 * are all added to the same node.
> +	 */
> +	sbm_set_topology(num_sbm_instances,
> +			 max_threads_per_instance + disabled_cpus);
> +
> +	memblock_free(__node_thread_count, nr_cpu_ids * sizeof(int));
> +	memblock_free(cpu_sbm_setup_map, cpumask_size());
> +}
> +
>   static char ppc_hw_desc_buf[128] __initdata;
>   
>   struct seq_buf ppc_hw_desc __initdata = {
> @@ -1006,6 +1088,12 @@ void __init setup_arch(char **cmdline_p)
>   
>   	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
>   
> +	/*
> +	 * setup_arch() below can override topology for
> +	 * pSeries platforms as a result of hotplug nuances.
> +	 */
> +	setup_sbm_topology();
> +
>   	if (ppc_md.setup_arch)
>   		ppc_md.setup_arch();
>   
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index bc6926dbf148..7c1c1ac3efde 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -19,6 +19,7 @@
>   #include <linux/kernel.h>
>   #include <linux/interrupt.h>
>   #include <linux/delay.h>
> +#include <linux/sbm.h>
>   #include <linux/sched.h>	/* for idle_task_exit */
>   #include <linux/sched/hotplug.h>
>   #include <linux/cpu.h>
> @@ -870,6 +871,15 @@ void __init pseries_cpu_hotplug_init(void)
>   		return;
>   	}
>   
> +	/*
> +	 * find_cpu_id_range() only looks at online nodes.
> +	 *
> +	 * XXX: Is it possible for a CPU attached memory node to come
> +	 * online after this point? May need num_possbile_nodes() then
> +	 * unless there are platform nuances that can help optimize.
> +	 */
> +	sbm_set_topology(num_online_nodes(), num_possible_cpus());
> +
>   	smp_ops->cpu_offline_self = pseries_cpu_offline_self;
>   	smp_ops->cpu_disable = pseries_cpu_disable;
>   	smp_ops->cpu_die = pseries_cpu_die;

