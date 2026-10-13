Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091538E135;
	Tue, 13 Oct 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886494; cv=none; b=SJaOfAcCz8eTpg34g5XPntVXRgMGJR5Lw+/4HrgpGJvWqhffPiWYGd9EmvbrANJrMdIIo0XY8cY9OFHWFJNHzRvOB3W6UfyS3n+DHfejaNbGfU9cY3xppcB+bjuoBiBTE+flbw9zLtJ5HuiYR/z34SlG5JXXuYuk8rLl9EXBPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886494; c=relaxed/simple;
	bh=AV9vSOPVpYs8FOk1M3a7QQCkbAxknViqo+GrpJWIWnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQBR+szkaO3FPYNDshmjxjfmzy09LO8VloXKnsEF/Md+AQ2opDDaDFmUE7CflJtmm9gN7Xzy3Ibnj5sMyoSEmMj6l8Gml5P9kb3VYXGx2ppaurLczGjtg/KtNwZ0orlht6ArG6Krc0uE1QIdRAqiaYaiTYWA/CMwMc2lema2EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P/Lh0XMo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P/Lh0XMo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2F3GI1775867;
	Tue, 13 Oct 2026 10:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HBC19o
	TVnwVJK9cz9Z6gTP/0q3sl5mSYM70iPHlJcI0=; b=P/Lh0XMocFsfvaeR3zXL1B
	hNT1JM+DcsozXthMxVasX0SIJOs9HCSatjk+QFYa1x4XgP4Fr5qceIvWRkyFoZG8
	3Tq1t1yVuXvZkxxCbICsXGnbnL6zFGVMFytC+QKsd6OQp4CKpJFfV7IM5jRBH5n2
	WhAgOQotKlr0lIk/VrFBdeDj5o3axyrukSlaBvhvOJaaGJl9DSyh5WgXCVxmf9ey
	x+2pMfJ1PLo4IfYG0CmU05PPNBPXQVZOkk65/X5t3H7FBLYBN+hompALMVGB5ETj
	uQZsHWw/ib+I95WrgeptwwMQjVAa06kJ7vI/TYYGo0Os1k3ZUQOeECQcndfeQ8Xw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhw0rv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 10:14:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Ug3L1440297;
	Tue, 13 Oct 2026 10:14:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg118d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 10:14:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DAEGCB41681224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 10:14:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA5952004B;
	Tue, 13 Oct 2026 10:14:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5EB72004D;
	Tue, 13 Oct 2026 10:14:15 +0000 (GMT)
Received: from [9.87.128.189] (unknown [9.87.128.189])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 10:14:15 +0000 (GMT)
Message-ID: <4169abb8-6745-41a8-ab03-14f0ad08a118@linux.ibm.com>
Date: Tue, 13 Oct 2026 12:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/13] s390/topology: Initialize sbm topology
 during topology_init_early()
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
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
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-8-kprateek.nayak@amd.com>
 <bd5201d9-19bb-410e-8954-6c53a5aeb753@linux.ibm.com>
 <91a1bbf9-0409-408f-bedf-a5414be4d1a2@amd.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <91a1bbf9-0409-408f-bedf-a5414be4d1a2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX5CVPkR85gy/v
 f+XDycBlYjDcDnkBPagylMpeuB5l00dchHVlbYmI6sjKMYJitBON1FRUqYVGFZ/Cvvi4/NJRi7k
 dLx/lPdNrjXYd4JbKV0jz8albbxgAE6VrH6W2g/78YDt0cS7IwahLvAbW/epEccqZlvspdpObrV
 DUA7fhBIrQ61JvdI5I8vrgcL8JzOt93ndTJq0BtUnbx4g4T/RYHXCAB6ZScA9QitBQgU5B74ggW
 Lm2hp3kq7PdH0xsU4iw15nCPEt0v8n9DZmLThjE5ka+k4G1ONay3qmA+RBC1CEUDDP7A7oAPdVq
 PfP0oL7mMRGhpBXECcglexnxR0UTpY3ekbJso06xzrV6/Qo2XZA/4sISK2+sLJXCDjKRy+4MOii
 kUTWY275BiuoTjxxKcksKsh4z+Al83JP9xP70U+qwbSUVVYBAajVn4OeeMGLcM1Rk69Pi0698IB
 VTMCIX/ov18u6ryKNRg==
X-Proofpoint-GUID: rY5TYunTuczcuj_-lSR0cag8KryRH0hD
X-Proofpoint-ORIG-GUID: p5BFlEyDSpUpg5MlxGSsrMVUOuaVZFKu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX2W7jPYfE4QrM
 BeppqJgiXu7GMosRaD7zo0Ec6LefBxv5kEhHwX0b1INOt+lUbhJ4WwpetPyTuSeUw8CrUUK4Uqm
 2r+WwZNh2k8DAIi8Gb9RWlrrqeHSXOU=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ace047e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ID6ng7r3AAAA:8
 a=zd2uoN0lAAAA:8 a=ap9W0rVQlQxy6KeNSgcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130040

On 12/10/2026 04:20, K Prateek Nayak wrote:
> Hello Mete,
> 
> On 10/7/2026 3:49 PM, Mete Durlu wrote:
>> On 01/10/2026 21:28, K Prateek Nayak wrote:
>>> When the topology mode is TOPOLOGY_MODE_HW, topology_init_early()
>>> already parses the set of socket present on the system.
>>>
>>> Use the socket_info to configure the sparsebitmask (sbm) properties for
>>> the system - namely the number of sockets and maximum threads in a
>>> socket instance.
>>>
>>> arch_sbm_cpu_instance_id() traverses all socket instances to find
>>> a matching CPU which is not optimal but instance ID is only checked
>>> when the CPU is coming online. Since this is a rare event, the
>>> inefficiency is tolerable.
>>>
>>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> ---
>>> Build tested with LKP's s390 randconfig with QEMU cmdline:
>>>
>>>     qemu-system-s390x \
>>>     -cpu max \
>>>     -smp 2 \
>>>     -m 2048 \
>>>     -kernel ./arch/s390/boot/vmlinux  \
>>>     -append "console=ttyAMA0 earlycon ignore_loglevel log_buf_len=10M print_fatal_signals=1 LOGLEVEL=8 sched_debug" \
>>>     -nographic
>>>
>>> Note: Since ctop needs KVM acceleration to emulate TOPOLOGY_MODE_HW, the
>>> actual spasemask setting is only build tested at the moment.
>>>
>>> XXX: Any way around this using cross-compile and QEMU?
>>> ---
>>>    arch/s390/kernel/topology.c | 52 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 52 insertions(+)
>>>
>>> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
>>> index 1377c6f3f670..80dc51f5ce6f 100644
>>> --- a/arch/s390/kernel/topology.c
>>> +++ b/arch/s390/kernel/topology.c
>>> @@ -20,6 +20,7 @@
>>>    #include <linux/init.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/cpu.h>
>>> +#include <linux/sbm.h>
>>>    #include <linux/smp.h>
>>>    #include <linux/mm.h>
>>>    #include <linux/nodemask.h>
>>> @@ -561,6 +562,55 @@ static int __init detect_polarization(union topology_entry *tle)
>>>        return tl_core->pp != POLARIZATION_HRZ;
>>>    }
>>
>> topology_init_early() is called once during early boot and never again.
>> Considering that s390's topology can change during runtime this
>> implementation won't work as sbm won't be able to adapt.
>> On s390 max_threads_per_instance can change during runtime.
>>
>> Like sashiko pointed out, this approach also does not consider
>> any newly added cpus.
>>
>> IMHO, there is a slight redesign required so that smb_set_topology()
>> and smb_init() can be called each time a topology rebuild is necessary.
> 
> So based on my limited understanding, doesn't store_topology() populate
> the mask for the entire system on s390? Are you saying that can change
> or that stsi() may return a partial topology for only the online CPUs?

On s390 LPAR(logical partition) cpu topology can change during runtime.
Depending on the decisions made by the underlying hypervisor there
can be topology adjustments to find the optimal LPAR placement within
the physical machine.

To give a concrete example:
On an LPAR with 7 cores spanning 2 chips with the following topology;

CPU NODE DRAWER BOOK SOCKET CORE ONLINE ADDRESS
   0    0      0    0      0    0    yes 0
   1    0      0    0      0    0    yes 1
   2    0      0    0      0    1    yes 2
   3    0      0    0      0    1    yes 3
   4    0      0    0      0    2    yes 4
   5    0      0    0      0    2    yes 5
   6    0      0    0      0    3    yes 6
   7    0      0    0      0    3    yes 7
   8    0      0    0      1    4    yes 8
   9    0      0    0      1    4    yes 9
  10    0      0    0      1    5    yes 10
  11    0      0    0      1    5    yes 11
  12    0      0    0      1    6    yes 12
  13    0      0    0      1    6    yes 13

Initially max_threads_per_instance would be 8, right?
After a topology update from the hypervisor we can end up with
all cores placed in the same chip.

CPU NODE DRAWER BOOK SOCKET CORE ONLINE ADDRESS
   0    0      0    0      0    0    yes 0
   1    0      0    0      0    0    yes 1
   2    0      0    0      0    1    yes 2
   3    0      0    0      0    1    yes 3
   4    0      0    0      0    2    yes 4
   5    0      0    0      0    2    yes 5
   6    0      0    0      0    3    yes 6
   7    0      0    0      0    3    yes 7
   8    0      0    0      0    4    yes 8
   9    0      0    0      0    4    yes 9
  10    0      0    0      0    5    yes 10
  11    0      0    0      0    5    yes 11
  12    0      0    0      0    6    yes 12
  13    0      0    0      0    6    yes 13

According to the new topology max_threads_per_instance now
should be 14.

On top of that we support hotplugging in new CPUs which
means we can then get a new topology after adding a
completely new core. (QEMU supports feature [1])

CPU NODE DRAWER BOOK SOCKET CORE ONLINE ADDRESS
   0    0      0    0      0    0    yes 0
   1    0      0    0      0    0    yes 1
   2    0      0    0      0    1    yes 2
   3    0      0    0      0    1    yes 3
   4    0      0    0      0    2    yes 4
   5    0      0    0      0    2    yes 5
   6    0      0    0      0    3    yes 6
   7    0      0    0      0    3    yes 7
   8    0      0    0      0    4    yes 8
   9    0      0    0      0    4    yes 9
  10    0      0    0      0    5    yes 10
  11    0      0    0      0    5    yes 11
  12    0      0    0      0    6    yes 12
  13    0      0    0      0    6    yes 13
  14    0      0    0      0    7    yes 14
  15    0      0    0      0    7    yes 15

max_threads_per_instance should now be 16.

Considering these cases I asked for a redesign that
allows smb_set_topology() and smb_init() to be called
during topology_rebuild() operations.

Please correct me if I misunderstood a something
from your proposal.

[1] https://www.qemu.org/docs/master/system/s390x/cpu-topology.html

Thanks,
-Mete
