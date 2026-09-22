Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9555C1DF;
	Tue, 22 Sep 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091451; cv=none; b=IEEEYHRA2YREoex159nw9uJ0hLZdYR161zwJS/H5qFHsN5UwGMR9I0Ms9+0GqwQ9IwVLLpfcUBOSZGMuGn/by9131WtNofxn2YuvMoQkn6sJyDNm4mqwULWwB0M6vB/b8DySIvInrrv1SQVttJKEhsVNFvmf9j5biS0/zzxX4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091451; c=relaxed/simple;
	bh=q2QfQvAOLHd4afuvZld9/jIQw9gIeKdin67gd2Ex0hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXBeSaKUdCHVeYSvDvskJWp8/KvucZoyzOhdVdQal6ToXicodLhLTQA/f2wGyyTlTfp3y88QoVOeDiYM0fDvu/pQarzUJjHkyctXh2gsVaCutMiEmn6FW39vTUPsdnCHRjTQivfgz4EuDBccOd8yn8GnQ0YxdCryKhgbfGTrecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DAknCw/h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DAknCw/h"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MF5XaE780343;
	Tue, 22 Sep 2026 15:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OCm3ro
	EYozAezczHpGeNcF1S13oV+Cjc2G+ycS75wa0=; b=DAknCw/hkTC1hU+92fcGXw
	rwTUBReFDau7yKjA0nWC5XJG/j7BvDMRTisEXwe41Un7amgEbHlM+TpFoAcs04aR
	V9H4jDiariu/ZiFmxfyAZTpekYWRABmVF+pTbvmj7pRF7Wh3aJsc29lq7SU4+wmu
	UorDc07jtkULoo44XtYqoKxSnFtlDsIO4z5c93v/P4BWL4Jykel2U1C9quRZbCY/
	VrG42NVF+z4HB4k64STxIkLnvBE4R7iKDhwZm1hqjws4hPUxhqp1oxBUoYU/z3B3
	nSiq4YfVqU2Gx8lOB4jn0Bi2LE/s4W4NpKNxhRWge+1mrDv9SaylAgC4tNWn09tQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv6bdw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 15:37:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MElasH2965400;
	Tue, 22 Sep 2026 15:37:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjtdm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 15:37:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MFbFJU50594152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 15:37:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E662820043;
	Tue, 22 Sep 2026 15:37:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B2420040;
	Tue, 22 Sep 2026 15:37:14 +0000 (GMT)
Received: from [9.111.22.84] (unknown [9.111.22.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 15:37:14 +0000 (GMT)
Message-ID: <dc01ef2f-3ed9-4b25-ae5f-1bd317df27cb@linux.ibm.com>
Date: Tue, 22 Sep 2026 17:37:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] s390: More this_cpu_*() changes
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260921155806.2447506-1-hca@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6S3gsGywxpjOubl5YlqYT1VEntfNj09c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX9wYK9s2Ubhyo
 Wi+5Re6iB+Xgxy7uuOqUc7fzz+dnG0w4TdQ4OavOAAOREcg255d5+yfvwE62B8imaGH4OLinVgu
 3IIJn1zFlQuhVabHjMLmFQIdjuu470M=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2a0af cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=s7ObvvvYnUrjyN0Krc8A:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 6S3gsGywxpjOubl5YlqYT1VEntfNj09c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX6E80gNfZXN2h
 lgugKO6eKafQFl21wj4jdB241EcsI+xdIGUHb3hhyCOG9zrDim7dVQEPXGSlSO0kRRCoOY1mcrx
 0zybM9cMF/0MnaCSp0QWGAbyiNlJOYBvMfUukNxKUOwhlITGgEODayYgWLKfLmwXvD1HRNVTFdm
 UPpoRTRsrIGEz1UvBKRkM3F5mHA+Ha1pK8vxCNW7YuwjtfCbLRcmm1Ac1rkfcuZ8Wb5JYu4omgu
 5PsM9d2H8Ucuu70Cp6m6ICeNuAWNIEjdQZZbnQ4f7fuxva7jRY5yKR/QHRgUwW9aPmUnRHAM+Ox
 g9DavEg/DHiHyajz9WFH1KT7kobaNb56pLJp+g+FIeXYsrINJ3npiX487LinmussskzkO1CxgfC
 B6f7/YpkB/4lGN/3BsU0qmSrVip74ZUdjiWxynxaCD4gC2jJMJs2Xh2IxO/vhKL9N9MK7YmwRID
 HA+p/bHRJr0hYYgn8UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220227

On 21/09/2026 17:57, Heiko Carstens wrote:
[..snip..]
> v1:
> Most of this is only about cleaning up the percpu code after preemptible
> this_cpu_*() operations have been implemented. The first ten patches are
> all more or less trivial cleanup patches trying to make the code shorter
> and more readable.
> 
> The only non-trivial patch is the last one, which converts s390's
> this_cpu_*() operations to use a similar scheme like Mark Rutland
> provided it for arm64 [1]. This allows to simplify the irq entry and exit
> path, however at the cost of slightly worse code for this_cpu_*()
> operations.
> 
> The simplified irq entry and exit code seems to be worth it. Usable
> performance numbers are not available yet, however I don't expect big
> difference to before.
> 
> [1] https://lore.kernel.org/all/20260904161758.376504-1-mark.rutland@arm.com/
> 
> Thanks,
> Heiko
> 
> Heiko Carstens (11):
>    s390/percpu: Fix comment typo
>    s390/percpu: Add sanity check to GEN_MVIY macro
>    s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
>    s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
>    s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
>    s390/percpu: Rename inline assembly symbolic names
>    s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
>    s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
>    s390/percpu: Use percpu code section for this_cpu_xchg()
>    s390/percpu: Use percpu code section for this_cpu_cmpxchg()
>    s390/percpu: Rework to simplify percpu_entry() and percpu_exit()
> 
>   arch/s390/include/asm/entry-percpu.h |  71 ++----
>   arch/s390/include/asm/lowcore.h      |   5 +-
>   arch/s390/include/asm/percpu.h       | 354 +++++++++++++++++----------
>   arch/s390/kernel/irq.c               |  10 +-
>   arch/s390/kernel/nmi.c               |   4 +-
>   arch/s390/kernel/traps.c             |   4 +-
>   6 files changed, 248 insertions(+), 200 deletions(-)
> 

Hi all,

I did some benchmarking for this patch series.

Used a shared LPAR with 24 CPUs (12 cores w SMT2).

Base commit: f0100363d8c3 ("Merge tag 'xfs-fixes-7.3-rc5' of
gitolite.kernel.org:/pub/scm/fs/xfs/xfs-linux")

Some of the benchmark runs show +-5% standard deviation which can
be attributed to s390 being a virtualized system. Each run has been
repeated five times to circumvent the effects of standard deviation.
(In the odd case where baseline has -5% and patched run has +5%
deviation, the comparison can show ~+10% improvements which is highly
misleading).

Overall, the benchmarks do not show any real difference between baseline
and patched kernels;

1-) Hackbench
========================================================================
Repeated hackbench runs with different group and fd count combinations;
[1, 2, 4, 8]

$ hackbench -T -p -l $loops -g $g -f $f

no real difference.

2-) Stress-ng
========================================================================
Repeated stress-ng runs with range of stressors: [6, $(nproc)]

# 3d matrix operations
$ stress-ng --matrix-3d $cpu --matrix-3d-method mult --timeout 10

# repeated mmap() and munmap() operations and also writing to the
# allocated memory.
$ stress-ng --vm $cpu --vm-bytes 128M --timeout 10

# starts workers that each fork off 32 child processes. Each child
# tries to allocate some memory. Child processes use madvise and memset
# to produce VM activity.
$ stress-ng --mmapfork $cpu --mmapfork-bytes 128M --timeout 10

no real difference.

3-) Openblas Benchmark
========================================================================
Repeated matrix operations with different size of 3d matrices.

$ make -j$(nproc) \
         USE_OPENMP=1 \
         NUM_THREADS=$(nproc)\
         NOFORTRAN=1 > /dev/null 2>&1

$ make -C benchmark sgemm.goto \
         USE_OPENMP=1 \
         NUM_THREADS=$(nproc) \
         NOFORTRAN=1 > /dev/null 2>&1

$ OPENBLAS_LOOPS=50 sgemm.goto

no real difference between runs.

4-) Compiling kernel
========================================================================
Linux kernel compilation

$ make clean
$ make mrproper
$ make defconfig
$ time make -j$(nproc)

no real difference between runs.
