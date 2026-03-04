Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18365351C00;
	Wed,  4 Mar 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640855; cv=none; b=KsT9B5hslCl18NYeuxFYCgiOfkJ+fz3E/YpwZ9yxTcN/vcj5Go09wMufLCE/qYdyo8oe6NilLzVCJ857/Jz8T8Rh3zNvLiGc86ndR+HH9uQtnljMdCJ4J3igLyyRd79oe+7dZYaKN4+mjpc27pPg338QuW94AT6S1jlHjinkkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640855; c=relaxed/simple;
	bh=jUYsqUbBTjcTtHMEAoJPDMRxfX45isXwFxJEvxFKChI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FNzovsFkUsI4o1W5/gYxzamJ8Wty90fFSotUQ0towQlCT98D778wAf09VIj2IdxAwL0Nv4P1lJnffBpXakWaCgWIacUpWY/+QPgsXKvA4iF8H1HWLYvMuCamY3sVDXaNz8UD6fvjqwbES2LB89B2w/e74X/T9TXoF+2IZuAF6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kGe4jd2E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kGe4jd2E"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624CBOP32182589;
	Wed, 4 Mar 2026 16:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lvC/fH
	ZIPesCBpBSv77oK72V5IPhlFEFZ+lU/FGeokc=; b=kGe4jd2E3IGX9yqwTGjIdV
	MOnhOROToakevaScIJsky2uYkM5Iher9z32EaCSOneA/uNWewqPIGireUdG+wQkB
	j+7lu3LKjxi1C7X/rdjX3qJ7UiNBZVKV0taaeRSwZPBvv2VOjr6oP4KAS0TtjkIy
	e4Ea/pb3WWzANgjqJ3+KkCFSqhAHsZiYneltBzxqO71dqHJiWG70sS0cgIH8glMj
	VpSemtm9+HOinHNvDLzl7+9MDvX/Zz6K5OIORtx/2mMSx6RzQ5Vb4hZXpC1vL2s7
	2/UAu3P1UKsp/e1RKy05IFDjgdhQ5uCg2+YK8RZ6jWYIGoceNHc1DC0pCbUXq48A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd04j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 16:14:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624FVDOr010284;
	Wed, 4 Mar 2026 16:14:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k7a8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 16:14:03 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 624GE2Vq25428496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2026 16:14:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 185555805A;
	Wed,  4 Mar 2026 16:14:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FB8258054;
	Wed,  4 Mar 2026 16:14:00 +0000 (GMT)
Received: from [9.111.179.155] (unknown [9.111.179.155])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Mar 2026 16:14:00 +0000 (GMT)
Message-ID: <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
Date: Wed, 4 Mar 2026 17:13:56 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-next@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zC9x4veANVIF4J_uVU8jNCtQVteyNqVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEzMSBTYWx0ZWRfXyQOFK9iUISVf
 sFgL9uripwoMgyxujUM9cUyQoAHArkv5HWDCq2C/ltDJrNxZlRj6IoCQxV6g6kRXSLJn9OpUEA6
 4FzjkFEjFkXrXcFwr849dMaZAJ/vAIzzNxIDI4MCsAv4DlY2H0pwFQvRlO/O/TovU+cOGZ9Ss+G
 8IdijTwibg25xgQT2GjfzE3AnEU9lebjuNFM23TIWjORz1Q8aNB9oZzT3cVDdDZeMCKzCHk2s/2
 hJPFd4KDWtYNKScKm/EHoWtzzMlIV0hB6KfU5TASLmDWEMb/AYu2XtsYNIC7yeDttEVNnuGDvSr
 jXnOLFhWnzUrn03sO1IljrWYSgbqpfr5CO1uoBbriBJPbaaJS7p3Ll+ZMAEfON+LFnNUZu/VpeP
 JXkkeFa+SxnlKe2Y+JBZod/EYJd/wZVCUnskBKbLcCkih1k0bxdF0gCxpn9iT138Z+Z5GDnwqzi
 WOpPgmAjIyWZtcHcj/A==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a85a4c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=JVXcMsF-ji_pWr6hPH0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zC9x4veANVIF4J_uVU8jNCtQVteyNqVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040131

Sorry, forgot to Cc a few people.
Adding scheduler maintainers.

Thanks,
Mikhail Zaslonko

On 03-Mar-26 19:31, Mikhail Zaslonko wrote:
> Hello,
> 
> we have kernel-next boot hang on s390 starting next-20260302.
> 
> I bisected it in linux-next to:
> 
> c50f05bd3c4e ("Merge branch into tip/master: 'sched/hrtick'")
> 
> Good:
>   72a2ab46f045  
>   d50da4b5915f  (2nd parent: sched/hrtick branch)
> 
> Bad:
>   c50f05bd3c4e  (merge commit)
> 
> Environment:
>  - s390 under z/VM
>  - many CPUs defined (32+)
>  - boot hangs early with RCU stall (see boot log excerpt below)
> 
> 
> 
> [    0.953192] Freeing unused kernel image (initmem) memory: 2520K                                                     
> [    0.962509] Write protected read-only-after-init data: 188k                                                         
> [    0.962884] Checked W+X mappings: passed, no W+X pages found                                                        
> [    0.962888] Run /init as init process                                                                               
>  P+q6E616D65 \[   29.503589] systemd[1]: Inserted module 'autofs4'                                                     
>                                                                                                                        
> hangs here, no logs ...                                                                                                                       
>                                                                                                                        
> [   98.619693] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:                                                     
> [   98.619708] rcu:     4-...!: (1 GPs behind) idle=04a8/0/0x0 softirq=25/26 fqs=0 (false positive?)                   
> [   98.619715] rcu:     5-...!: (1 GPs behind) idle=04b8/0/0x0 softirq=25/26 fqs=0 (false positive?)                   
> [   98.619720] rcu:     6-...!: (1 GPs behind) idle=04a8/0/0x0 softirq=23/24 fqs=0 (false positive?)                   
> [   98.619724] rcu:     7-...!: (1 GPs behind) idle=04e8/0/0x0 softirq=28/29 fqs=0 (false positive?)                   
> [   98.619729] rcu:     8-...!: (1 GPs behind) idle=0568/0/0x0 softirq=27/28 fqs=0 (false positive?)                   
> [   98.619733] rcu:     9-...!: (1 GPs behind) idle=04e8/0/0x0 softirq=35/36 fqs=0 (false positive?)                   
> [   98.619737] rcu:     10-...!: (1 GPs behind) idle=0518/0/0x0 softirq=33/34 fqs=0 (false positive?)                  
> [   98.619742] rcu:     11-...!: (1 GPs behind) idle=0448/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
> [   98.619745] rcu:     12-...!: (1 GPs behind) idle=0488/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
> [   98.619749] rcu:     13-...!: (1 GPs behind) idle=04a8/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
> [   98.619753] rcu:     14-...!: (0 ticks this GP) idle=0498/0/0x0 softirq=26/26 fqs=0 (false positive?)               
> [   98.619758] rcu:     15-...!: (1 GPs behind) idle=0448/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
> [   98.619762] rcu:     16-...!: (1 GPs behind) idle=0458/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
> [   98.619766] rcu:     17-...!: (1 GPs behind) idle=0438/0/0x0 softirq=21/22 fqs=0 (false positive?)                  
> [   98.619770] rcu:     18-...!: (1 GPs behind) idle=03e8/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
> [   98.619774] rcu:     19-...!: (1 GPs behind) idle=0458/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
> [   98.619778] rcu:     20-...!: (1 GPs behind) idle=04b8/0/0x0 softirq=24/25 fqs=0 (false positive?)                  
> [   98.619782] rcu:     21-...!: (1 GPs behind) idle=04b8/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
> [   98.619786] rcu:     22-...!: (1 GPs behind) idle=04d8/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
> [   98.619790] rcu:     23-...!: (1 GPs behind) idle=0b68/0/0x0 softirq=29/30 fqs=0 (false positive?)                  
> [   98.619794] rcu:     24-...!: (1 GPs behind) idle=0508/0/0x0 softirq=25/26 fqs=0 (false positive?)                  
> [   98.619798] rcu:     25-...!: (1 GPs behind) idle=10c8/0/0x0 softirq=38/39 fqs=0 (false positive?)                  
> [   98.619802] rcu:     28-...!: (1 GPs behind) idle=0518/0/0x0 softirq=25/26 fqs=0 (false positive?)                  
> [   98.619806] rcu:     30-...!: (1 GPs behind) idle=0518/0/0x0 softirq=20/21 fqs=0 (false positive?)                  
> [   98.619810] rcu:     31-...!: (1 GPs behind) idle=0528/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
> [   98.619815] rcu:     (detected by 0, t=69116 jiffies, g=-1019, q=494 ncpus=32)                                      
> [   98.619818] Task dump for CPU 4:       
> [   98.619820] task:swapper/4       state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x0
> [   98.619825] Call Trace:                                                                                                               
> [   98.619828]  [<000001b02c9afd98>] 0x1b02c9afd98                                                                                       
> [   98.619834] Task dump for CPU 5:                                                                                                      
> [   98.619835] task:swapper/5       state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x0
> [   98.619838] Call Trace:                                                                                                               
> [   98.619839]  [<000001b02c9b7d98>] 0x1b02c9b7d98                                                                                       
> [   98.619841] Task dump for CPU 6:                                                                                                      
> 
> ...
>                                                                                                  
> [   98.619963] Task dump for CPU 31:                                                                                                                     
> [   98.619964] task:swapper/31      state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x00001000         
> [   98.619967] Call Trace:                                                                                                                               
> [   98.619967]  [<000001b02ca87d98>] 0x1b02ca87d98                                                                                                       
> [   98.619969] rcu: rcu_sched kthread timer wakeup didn't happen for 69113 jiffies! g-1019 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402                         
> [   98.620052] rcu:     Possible timer handling issue on cpu=3 timer-softirq=12                                                                          
> [   98.620055] rcu: rcu_sched kthread starved for 69116 jiffies! g-1019 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=3                                    
> [   98.620058] rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.                                                 
> [   98.620060] rcu: RCU grace-period kthread stack dump:                                                                                                 
> [   98.620062] task:rcu_sched       state:I stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000000                            
> [   98.620067] Call Trace:                                                                                                                               
> [   98.620068]  [<000002302d9d58ac>] __schedule+0x35c/0x850                                                                                              
> [   98.620077]  [<000002302d9d5ddc>] schedule+0x3c/0xc0                                                                                                  
> [   98.620080]  [<000002302d9de418>] schedule_timeout+0x88/0x120                                                                                         
> [   98.620084]  [<000002302cbfd29a>] rcu_gp_fqs_loop+0x69a/0x8a0                                                                                         
> [   98.620090]  [<000002302cc03426>] rcu_gp_kthread+0x2d6/0x340                                                                                          
> [   98.620093]  [<000002302cb82d18>] kthread+0x148/0x170                                                                                                 
> [   98.620098]  [<000002302cb01ffc>] __ret_from_fork+0x3c/0x240                                                                                          
> [   98.620103]  [<000002302d9dfb82>] ret_from_fork+0xa/0x30                                                                                              
> [   98.620106] rcu: Stack dump where RCU GP kthread last ran:                                                                                            
> [   98.620108] Task dump for CPU 3:                                                                                                                      
> [   98.620110] task:swapper/3       state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x00001000         
> [   98.620114] Call Trace:                                                                                                                                                 
> 
> 
> 
> 

