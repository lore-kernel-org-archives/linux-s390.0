Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996B3C73D9;
	Wed,  7 Oct 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351896; cv=none; b=jEmObrmCiWoN7X4YHIzLQsj9kgXyY3mC1g1CFh389fFqv9n/fdezKBg3rHo6QyHMbCw4lRykolsGT+1tSOcaviF1WlUiQB87xdYyJO2Ptvpquc9kHZW5VLHb401ZFb77RQlR2pI1omgfnt589HDT7BI38mjn18RImN5cKm3KbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351896; c=relaxed/simple;
	bh=J/2Onj7V0dCNt1OC5RVVVBIM5Bm0bM1Pvp7qNP3PQ7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLqVQVXtHm9CF8jPJa+22t2CFdHFkyVESun7ppAWCzFhPelAXhOaycCaRgD7pmtfcg1rpUBqIbhqc1ayRUuVrj+vZQFP/UnIZn+erChgFgr08CftbXxEbZpjET0cqK4z7nOKz6xV561tKHbANwY/uWqxtRLeuQJNGqUH+01iozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lg9gZRDv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lg9gZRDv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974aRBi1409397;
	Wed, 7 Oct 2026 05:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v7L/Is
	haQTpFkZXyxWFqEsTIV8AsMHyaRbeSGHo8YfA=; b=Lg9gZRDv/AHcQhkK/ClVn8
	F7Z087kOG8Oqv6jFqCO1Y29YjeCsU0/Vw+AGbjUO/rdEfzmGEf7Oe0uvkcqX2x/A
	dYe0tQ7/oBLop+5HaqG5vnGDLubnYIgjSWBloU8AHWuWVuTsSZWzTWBPgLT0v+6T
	Of4tkObUBhrHZDhmS5D/RGbKgEdpQQSdEZbub841mF6ZfUOJJOiQzjg1HGr5zZis
	qXZmS7tJYBFc3qpXPifsMHYoCleyno+zTpYsIUIZ39Ei1LFayBILCYG77FUpx39R
	z1Po0XMCA/LyfcaPx5UfdNSwd/SoBe7q7zQsXPir93A6CDms6uLbJB1yexP6aWfw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4ju8ym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 05:43:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6974WZAa1376982;
	Wed, 7 Oct 2026 05:43:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dh4tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 05:43:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6975hdCp53346648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 05:43:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 091E120043;
	Wed,  7 Oct 2026 05:43:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44B6E20040;
	Wed,  7 Oct 2026 05:43:24 +0000 (GMT)
Received: from [9.39.25.200] (unknown [9.39.25.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 05:43:23 +0000 (GMT)
Message-ID: <bebd59dc-9932-41fe-9fa6-4d2cc8d15080@linux.ibm.com>
Date: Wed, 7 Oct 2026 11:13:22 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/13] lib/sbm: Introduce helpers for architectures
 to configure LLC properties
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, driver-core@lists.linux.dev,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-2-kprateek.nayak@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261001192849.74788-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vXOs2a9YsPxXPDWlk_fQyGt8XKTYkFF0
X-Proofpoint-GUID: 2WtIRldL-8sD5UVml5UoIOzm4QtQsPt2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfX4mmsO4sZrzgh
 Mnz82Xsy9mtTsApcqK0EAgEkzT4QpnInFmT6PSo9P+6m7GNW3kllHyAFrEHvN8jteYJUtvpuHQj
 El1nV5BdZCUVdPS8R8bOCCO0l8cdcDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfXz5bhW5BOP3yo
 AXAKxpdMGdB9WPsPxUav3ccKlkRMSPMiL1DdhZ/aaocq9pBD5owUvsjp7UwsLADW+LfHCXgHXOV
 ICGHlnq44UE3Wn3keBJD7fz/SzRvqaVtLPF6iUY5SeMSpB/xn1nSNa9jbZSH45cW99+vJoKuWQv
 MCGXoYLJ+vbML8Yo03KebUPu3SEePbQlxMlqfB0nBozsITzDNYz4sab2NN13tJLUE6QaCKS5XOB
 lqR1d167/luKGtIMXXtHrSvyP4QyawZIixwl88x3raFUxxSqX45J1mrcbPY/3gmp8yvqgx/hKVE
 itpSyPUNRseZXLG5uA+3p8F8CA7g9XihfRSltNw4fYtBqPV7qtzIUT+bo3QR5kBBxf3ZxMPexG6
 Q4gjmHEvySzZMPerQ11VZS0GwUj1hSAI9DhooY2dnKV5223VIfs4ozYNRv1VhGSZpk8+kfNaL0K
 Kt0sBNcLkTQefrFM9OQ==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac5dc10 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=zd2uoN0lAAAA:8
 a=H_lJn1gU1r1qM_BORgYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070022

Hi Prateek.

I ran the series on 320 CPU power11 system today.
hackbench shows high regression across the different number of groups and
it is more severe at lower number of groups. I haven't run anything else yet.

I haven't taken a look at the patches yet. Post your talk today will try to
go through and see if i can spot something.

On 10/2/26 12:58 AM, K Prateek Nayak wrote:
> Subsequent commits will add arch/ hooks to configure the sparsebitmask
> (sbm) topology - number of sbm instance and the maximum CPUs that a
> single instance can represent.
> 
> Introduce sbm_set_topology() that helps architectures configure the sbm
> topology. Also add arch_sbm_cpu_instance_id() which will be used to map
> CPUs to the sbm instances during init to keep CPUs on the same instance
> on the same sbm leaf.
> 
> Individual arch/ users will be added one at a time in the subsequent
> commits.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   include/linux/sbm.h |  8 ++++++++
>   lib/Makefile        |  2 +-
>   lib/sbm.c           | 27 +++++++++++++++++++++++++++
>   3 files changed, 36 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/sbm.h
>   create mode 100644 lib/sbm.c
> 
> diff --git a/include/linux/sbm.h b/include/linux/sbm.h
> new file mode 100644
> index 000000000000..adac12ed233a
> --- /dev/null
> +++ b/include/linux/sbm.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SBM_H
> +#define _LINUX_SBM_H
> +
> +int arch_sbm_cpu_instance_id(int cpu);
> +void sbm_set_topology(int num_instances, int max_threads_per_instance);
> +
> +#endif /* _LINUX_SBM_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index dfab958327c5..7776330f5b25 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -40,7 +40,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>   	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>   	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>   	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o objpool.o iomem_copy.o sys_info.o
> +	 buildid.o objpool.o iomem_copy.o sys_info.o sbm.o
>   
>   lib-$(CONFIG_UNION_FIND) += union_find.o
>   lib-$(CONFIG_PRINTK) += dump_stack.o
> diff --git a/lib/sbm.c b/lib/sbm.c
> new file mode 100644
> index 000000000000..82280e3306de
> --- /dev/null
> +++ b/lib/sbm.c
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/sbm.h>
> +#include <linux/init.h>
> +#include <linux/printk.h>
> +
> +static int sbm_max_threads_per_instance = -1;
> +static int sbm_num_instance = -1;
> +
> +/*
> + * In absence of an arch definition, consider all CPUs to
> + * belong to the same sbm instance.
> + */
> +int __weak arch_sbm_cpu_instance_id(int cpu)
> +{
> +	return 0;
> +}
> +
> +void __init sbm_set_topology(int num_instances, int max_threads_per_instance)
> +{
> +	sbm_max_threads_per_instance = max_threads_per_instance;
> +	sbm_num_instance = num_instances;
> +
> +	pr_info("sbm topology set to %d instance(s) with a maximum of %d thread(s) per instance\n",
> +		sbm_num_instance,
> +		sbm_max_threads_per_instance);
> +}

nit: Stray empty line at the end.

> +


