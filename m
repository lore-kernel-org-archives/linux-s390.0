Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766644734E2;
	Wed,  7 Oct 2026 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368448; cv=none; b=aiFcoR1siB8K98D3FnnYIdxWecaWMloZySPMgnpICxn2wmesu5iRGC5pHvwYdY4iG50TaAjLMaNZg2semfiHeqj1YPL6LWbzqFADvdYtH3FccRJXrJFecfHTYDPNLHKnOrM6sw8BBM7wpn+NjMXBm78/0O2G26GPJfyfbpE8kfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368448; c=relaxed/simple;
	bh=oHOJ6V3AzctG/+9MGXJ3TR6/jLfcvNp5QEjrWq9t0v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuVikIch8e6tlDfxjHNK/Dnofg8klDBvgV6ENdSDi7leC936AXmkUcyIR0jTijaF93zOjqPlJjxhoR+NVwjiJujxEbLQyViHa1S3OojwAe9RGH+TamrhLT9gBEXPuShFXBRvfmA+q+N7DaZ/v5ekBPaAQYpyOZfDMuD1MuYNJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GSgrkL4l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GSgrkL4l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69785tAo2036290;
	Wed, 7 Oct 2026 10:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YY+zk0
	nU+A0l4J58B95lMyurynE62aQZxet1k0dyhyM=; b=GSgrkL4lWrvc6pmaE8+y72
	3rpOyQcQeaVotBo7WrK/DrqQfjwXJ5TllkjGaYOdB4XPQ4RLqVpuUv0K/WIVCAS4
	tQleEDKfRPZuE6Y6ATBMqDnfi/oKfczpmPseqIvTNJV/M0NADUh0L5gsgoMpjh8Y
	PdwpaUOB/h/NiFWwq2ttDRgTIntSkTJ9xNm255OvEzwJ5smyoRjI/XsgtrRsloqX
	0Yel3xPiwqa7Mx2/nisA8+LH8eUdeQSvLRXRm5WiOrb63ISvkF0bVkjPq7lvWEix
	QaKbmYWjHR0vwU0KVT4K9+suPp+m60MLIZj0AC3zJy0IF4vyMBcyXUsMoNu+F1CQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74vwqv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 10:19:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6977lV5s317050;
	Wed, 7 Oct 2026 10:19:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3ts2yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 10:19:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697AJqSW48431502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 10:19:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA0BF2005A;
	Wed,  7 Oct 2026 10:19:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E54D20040;
	Wed,  7 Oct 2026 10:19:52 +0000 (GMT)
Received: from [9.111.61.139] (unknown [9.111.61.139])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 10:19:51 +0000 (GMT)
Message-ID: <bd5201d9-19bb-410e-8954-6c53a5aeb753@linux.ibm.com>
Date: Wed, 7 Oct 2026 12:19:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/13] s390/topology: Initialize sbm topology
 during topology_init_early()
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, driver-core@lists.linux.dev,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-8-kprateek.nayak@amd.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20261001192849.74788-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ffY6TLKTpffrTfFwXFbRf4wLqXGAb6-j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX5YvUepf/U6OC
 FaGTWFpY1HrJave3vicTixr+fQ++9GqfU+3Zs3xMBvOA7U18g4ewllijqqjZRqTNSafqGvYfSI2
 wa/wcMb0rojmjOsrymp/srPPFUVCpHo=
X-Proofpoint-GUID: Tbz9hU4FADE_uXqR6VBUuc00GL4SXDgo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX00U2nwqsffsr
 JT1pX+wU2mYPlMFpB5UhX49I2QLaW5KljBowrcfIidPfJZKyN4kjMviAR0tjoJkpFtkF41hfR9F
 zHKylZ85W09CAFxl4I4ZwkQ3ueJld+uJTg1Cf6nvaHLesQoDB8D3fyDo7MoGFk0MU8QFYUVAdSu
 rk3wneyhGtd1rYsppgxJdu0ZSVI5aajd3Mw4ENg1EKDyProGlZnJHzWvmSW+25C8XbWCGdDaf80
 NTOYWtoXZVr86oeSKRXt+xAjChyINKVjCo0RF6l3mnXf1LxrLO1es0XbzuO/AFx6CyoEG1PHzpF
 kEZ4pNc1nIWQYG8GltklzFwzSwCVVZ72cr5pbYOPMAm36ByfzqkjvyVFUTWrpPMgjV0wRc3eZl/
 zqwbfDUzbowD3vBO5g8qeQ2jwDePDt5xS9f1lNMq5FJN0/U52QHOTKwggp6lmJ5oVq9w6kkzyLG
 yVMV1dy1jBmPwuMLWfw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac61ccf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zd2uoN0lAAAA:8
 a=Ljveq5rUL1csS5QuFncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070040

On 01/10/2026 21:28, K Prateek Nayak wrote:
> When the topology mode is TOPOLOGY_MODE_HW, topology_init_early()
> already parses the set of socket present on the system.
> 
> Use the socket_info to configure the sparsebitmask (sbm) properties for
> the system - namely the number of sockets and maximum threads in a
> socket instance.
> 
> arch_sbm_cpu_instance_id() traverses all socket instances to find
> a matching CPU which is not optimal but instance ID is only checked
> when the CPU is coming online. Since this is a rare event, the
> inefficiency is tolerable.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Build tested with LKP's s390 randconfig with QEMU cmdline:
> 
>    qemu-system-s390x \
>    -cpu max \
>    -smp 2 \
>    -m 2048 \
>    -kernel ./arch/s390/boot/vmlinux  \
>    -append "console=ttyAMA0 earlycon ignore_loglevel log_buf_len=10M print_fatal_signals=1 LOGLEVEL=8 sched_debug" \
>    -nographic
> 
> Note: Since ctop needs KVM acceleration to emulate TOPOLOGY_MODE_HW, the
> actual spasemask setting is only build tested at the moment.
> 
> XXX: Any way around this using cross-compile and QEMU?
> ---
>   arch/s390/kernel/topology.c | 52 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 1377c6f3f670..80dc51f5ce6f 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -20,6 +20,7 @@
>   #include <linux/init.h>
>   #include <linux/slab.h>
>   #include <linux/cpu.h>
> +#include <linux/sbm.h>
>   #include <linux/smp.h>
>   #include <linux/mm.h>
>   #include <linux/nodemask.h>
> @@ -561,6 +562,55 @@ static int __init detect_polarization(union topology_entry *tle)
>   	return tl_core->pp != POLARIZATION_HRZ;
>   }

topology_init_early() is called once during early boot and never again.
Considering that s390's topology can change during runtime this
implementation won't work as sbm won't be able to adapt.
On s390 max_threads_per_instance can change during runtime.

Like sashiko pointed out, this approach also does not consider
any newly added cpus.

IMHO, there is a slight redesign required so that smb_set_topology()
and smb_init() can be called each time a topology rebuild is necessary.
