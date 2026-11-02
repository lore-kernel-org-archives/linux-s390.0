Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614652;
	b=ZDREaC9Gfg/jitEChOEL76BLbd9a1cL0JUh6tICUrorWUhtvUc9o3Kuol1QKanYpiek0
	 dU4iKBWlpiX6vS2vh9fHmeuf3oEV3rHKB5FDQXtagkpOarhka3CBS6RrQFDouPqjtHLgQ
	 4EvApr5JGxg3MceXzxSZKrdf7ZxkA9larV2nfNbRS09nBY6mn31HIXeFuYp2GLVHh2HA4
	 pT2I+sJuEW97aK5e2EJ9rFYaJ9s9Eff9kpcc58jFC/4JvTVOnBvO1rT6NmKcz8M7n2pgD
	 8+7YK01fDmxkYXs/vrkRkIyZwS358vMeI7C/RJFnUKJU1b5Lp9XJiUB+/DbXc5zmOjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614652;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2F86aI5ohDf80izXsZxQxKJfZLJiR7e19DnwPOFk4m0=;
	b=wfV55ne7KHAl/nXkK8gxflKrx14w4sFVkDrVHDrpupuqdJAUO7gQNd0N+Em8AsfPuu4w
	 1LaYqIHcHxgCloIjpl6OGKqgb7hZdJATQGq6OHjCM86FqvxvSx5Yvc97aEHhIqe5uR4c1
	 z/DyV/mjnQP7UUkfhKc/51P2y87W8L+JXwYj3/Fk+CWfMAtsvMtUZge4ens+sNDK425DR
	 /wlyaYbwjSs+ibeLet7K3C+YXwhS9UriAu/r4Io1Dc6mtRuoW38MiU4VjwWbphq0vTAh9
	 UZJ+MnrZDaVwac5NzbkibmO/RfpFtGVrewPkUpP1xfrGk3RntuUfSWqYqA2eWFkI2JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rkhhkqbN;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CF606A326;
	Mon,  2 Nov 2026 10:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 805CF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rkhhkqbN
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29EJDA1334104;
	Mon, 2 Nov 2026 10:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2F86aI
	5ohDf80izXsZxQxKJfZLJiR7e19DnwPOFk4m0=; b=rkhhkqbNEthWur7HWcprqS
	XgNkeUuFFXLOyNXsXY6qGMEHuDSfSYYLgBVy+0zQnSumfw92EdvK2SFpKCMUuWtW
	SYBKGdKb0KWe2Ws4TKV0bVk4hd0C4MJ/bozlnC2Tn1z90o6Kj+vA1q2IqtR20RsL
	+8D/c4fC13fdxDcfWx35sKppm/9Sw72gjuZud9kSuZwTUowie5M2cMj433st3hXj
	mJMKZl2UpvBf81Uy/Q4RNImp7IIwk/lkjc961qy00ifsarszGNVY5iHwhW8/RkBi
	Z6lrKPoc7elWrbZuy1FO8MtPc/ZosxuqdmbdEmvzRIYtHMCd+xzju2bKaGYOhaHw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rcyxcj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 10:16:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29YxVt730389;
	Mon, 2 Nov 2026 10:16:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vdcfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 10:16:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2AGVrm38011336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 10:16:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8CA22007C;
	Mon,  2 Nov 2026 10:16:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FECC20077;
	Mon,  2 Nov 2026 10:16:30 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.80.131])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 10:16:30 +0000 (GMT)
Message-ID: <388636ac-4521-4523-bb5b-b6bc71591ff6@linux.ibm.com>
Date: Mon, 2 Nov 2026 11:16:30 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sched: decouple PREFERRED_CPU from PARAVIRT in
 Kconfig.preempt
To: Yury Norov <ynorov@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Yury Norov <yury.norov@gmail.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
        Mete Durlu <meted@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
        linux-s390@vger.kernel.org
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-2-ynorov@nvidia.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261101192203.6979-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KIKmBXBbZxQ0AgfSqcziIZ-8sh-ULZ7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX4b8mYsBsQI90
 Cds463mvoN7ipqKAPcMhRG9cv2cmJH7imu+pBNAKUzYHZ0l4QRzT6OtWfocplphprbRPPcKUhK/
 ewKqcPIRH7GGJrL7xKQ6XpJdqzz6TgjaSI2ivY9JJSH24KlUEbBGsMe1i/6f5ENqM879+1V5uPD
 sHhZ4aVMl3Pdx2HGeXnZi+d6SkpJ3e8JhVA1w8B3k3EXRQ2QR0Jqk7PjHrb+DTMkBbYibeR51hS
 VrEvAoc0qhDJfiKUG9iErQN23vYv4ulZFh2ZkIAD9qD868BkZG/JdGutezE7uDx0M6feE3lY0/p
 Q2/IrS40JQRVOvH/Tbt71zjIvhJ3L1/wcVe/5WSEHuFXw3yIITyGLzWEciPGhWv2r/PFqggQO8V
 KN7P2Zs3c+rVLq4CD8Uif+/PadLgHrZW2Z3Tv4UTrGYCQKnjwQ1MUZYQwaukbcXEphkvBg4eSxc
 fMN9UME+CtgYLDm7V1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX+121CA8UooYf
 y/fpWTXMJ/RyZzfqKMtOEDj2zgmYMzNR35/LU/M2zk1es7XQ8dDO6azVrWHx5Jiyb/KXWV8XJxR
 TWAIxg88JFalGqTloUcrvtjAqcF7tLw=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae86305 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=Oo2n8jX_zgt0tV1EdkUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BeEFtssz9nEvVgG4jeq4H4_xQzJd-ycM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020040



On 11/1/26 20:21, Yury Norov wrote:
> The IBM s390 doesn't enable PARAVIRT config for their hardware
> virtualized Logical Partitions (LPAR). However, the steal time is
> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
> is enabled.
> 
> Preferred cpumask doesn't rely on any feature gated by PARAVIRT config,
> and requires it to minimize the configuration space and runtime overhead,
> with the lack of non-paravirt user. Now that s390 wants to adopt preferred
> cpumask, there's no reason to keep it coupled to paravirt.
> 
> Make PREFERRED_CPU a user-configurable option, even if paravirtualization
> is not enabled, and drop PARAVIRT dependency on the steal governor.
> 
> Keep the default module selection conditional on PARAVIRT so other SMP
> configurations can opt in without enabling the governor by default.
> 
> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com/
> CC: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
> Can be applied independently from the rest of the series.
> 
>   drivers/virt/Kconfig   |  8 ++++++--
>   kernel/Kconfig.preempt | 12 ++++++++++--
>   2 files changed, 16 insertions(+), 4 deletions(-)

This is really useful to us, since even though s390 is nominally
paravirtualized, it does not technically benefit from defining
CONFIG_PARAVIRT. Specifically, steal time accounting happens by
computing a difference between wall time and CPU time, and not by
explicitly querying the hypervisor.

Thanks!

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]

