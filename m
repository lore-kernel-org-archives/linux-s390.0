Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DC3D1CB6;
	Mon,  4 May 2026 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897947; cv=none; b=VUlGnu6gVCKFi94FiH+2ucOXDwtth39ZGqCAvWT/WGqIFn/OQam0b4RGkIMeq+Q2foQx5+BoPd7XM2ukxHLjgmsGI6b2oiH4cpc6oahoppuz1aLYaYTv9SlfdXS3Svri/L5AFNJQbN9RhX/gVC77wW3hxeqT3rKKSpUqrBycoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897947; c=relaxed/simple;
	bh=zClYkEjuH+1o3s1tWHhRymivFJ4xIHgsujjp9KWR2/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cMzSfmbnky61tXXRM7YWAdiNJiN6SPVWUALaBRKQAuYKDSt2gj5iblDq9mL/BxGz/dbyS7QR2cPHGgCGgRPTsT+l5yKX/Uv2NdLCmm5njTYUTmoRDtqOYeNAhJCFA9KuPn3gp6w6nI/nMh26EXhA46S8weU7Nh9Fg5jumB6MbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STvLhzQJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STvLhzQJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Albik2197452;
	Mon, 4 May 2026 12:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=X/EqMnEIUCoNrn+IfIA+egTKhtM8AOXSpOvt0d40prc=; b=STvLhzQJ
	hHRyxBVGmhbzucIlzKecROZws/p131lSQ6G/u+eLePsXlNBpSgYXBLyyQtk8qU5K
	3wUZyVqn/V/fk5qhy3dSPM46A3oCYfpRLFknevS66mL+6vC4HyVmaOxRi85gYGC1
	0wYBNfEP56Te0bityvcnLul3TMvKyDnQ4/Uupkal2ZUjrbCTRnOVSfP3lA6XsZag
	ip1E7AZwqPt00y6PPNr3Yg/4i6R1dHHxXGBBk6nBUngEEyWa7odPOwnVJKwBdAh7
	n+QWQ3ZkRxJVvng6oRGL1xYU8AhLoIQbRDNtqC4XmPfRUBpldgezdo/6yZfLfqDS
	f7WGiXuVY+QWtA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w66qxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:31:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644COUsm018467;
	Mon, 4 May 2026 12:31:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq57fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:31:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644CVtPo33751348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 12:31:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0764120040;
	Mon,  4 May 2026 12:31:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F82D20043;
	Mon,  4 May 2026 12:31:54 +0000 (GMT)
Received: from localhost (unknown [9.111.75.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 May 2026 12:31:53 +0000 (GMT)
Date: Mon, 4 May 2026 14:31:52 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        John Stultz <jstultz@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes <joelagnelf@nvidia.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] sched/core: Don't steal a proxy-exec donor
Message-ID: <c00-01.ttedd70@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f891be cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=arff7jidZKLiyCVEszgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5JfeAvuwdl2gq8g0MwSguNjwO36Ti8ze
X-Proofpoint-GUID: PkVLviWoZbpKiLqcJfgF0_r_SpyfDAb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyOSBTYWx0ZWRfX3QyPfbZZmA6F
 SXXT5R7LPplpCdHtX/iNhk/6l/QLlZrFQA16z1X1AKBDZ+Z/S4hfmVrAiRW/zBjl3ZJGRkHmBq5
 IgsONo7pzzN7eBcDRQI/lvg4RrsZ+nUhEJ2xGFdpdepBF8pV9w0FBak99SrLIHvZ2rg7fNqrnH5
 CI5Nb99Yk1EQTm1Z5JcCt5nHXu0ynIPTjtWeOWhNhEIPG0Q5VNaJnaRGiZIp7nMXY5+Uyf8qO+j
 gC35kwVJo43ufle3qXYb8EIBhpwD3md3smvLMeutd7CLpQDiQuHleUPUiVjtR0C5AGjELb6/j3Q
 rbxh3EMNd27vU3sHO2ZlpXf8EzP9YPVHynZp7RqyX56Z59300RIVgSbudeYg2sUzcCignBKiKWy
 m/vpO2+aTOzz68vEcUu/ncFDtxMMhqlyl3MZHfHbWG4IxNdo7YDE/Ikd5dxyOH188Rv01rmZrU7
 1EgbkuWjMn/abBj+F7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040129

Since sched-core-2026-04-13 pull s390 hits the following splats with
defconfig. Running strace test suite "make -j$(nproc) check" on LPAR with
64 SMT-2 cores couple of times usually enough to trigger this. First
WARN in put_prev_entity() on a strace task. The next pick on the same
CPU typically WARNs again, and 60s later the system is in an rcu_sched stall

[  535.525203] WARNING: kernel/sched/fair.c:5788 at put_prev_entity+0xfe/0x170, CPU#26: grep/242219
[  535.525212] Modules linked in: mptcp_diag xfrm_user xfrm_algo tcp_diag crypto_user inet_diag netlink_diag algif_hash af_alg dm_service_time nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables zfcp scsi_transport_fc s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop dm_multipath drm_panel_orientation_quirks nfnetlink uvdevice diag288_wdt prng aes_s390 scsi_dh_rdac scsi_dh_emc scsi_dh_alua phmac_s390 paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey autofs4 ecdsa_generic ecc sha512 [last unloaded: trace_printk]
[  535.525268] CPU: 26 UID: 1001 PID: 242219 Comm: grep Not tainted 7.1.0-20260426.rc0.git0.897d54018cc9.300.fc43.s390x+git #1 PREEMPTLAZY 
[  535.525272] Hardware name: IBM 8561 T01 703 (LPAR)
[  535.525273] Krnl PSW : 0404e00180000000 0000033840f08482 (put_prev_entity+0x102/0x170)
[  535.525279]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[  535.525282] Krnl GPRS: 000000000000b8ee 0000000000000000 0000000000000000 0000000000000800
[  535.525284]            0000000000000000 0000007cafc9c400 0000033840f084f0 00000003e5512b68
[  535.525287]            00000003e5512b70 0000007cafc9c516 00000000dcd88400 00000001d3b8c900
[  535.525289]            0000000000000000 00000001d3b8c800 0000033840f08474 000002b84839fbe0
[  535.525297] Krnl Code: 0000033840f08474: e3b0a0580020	cg	%r11,88(%r10)
                          0000033840f0847a: a784ffa5		brc	8,0000033840f083c4
                         *0000033840f0847e: af000000		mc	0,0
                         >0000033840f08482: e548a0580000	mvghi	88(%r10),0
                          0000033840f08488: eb9ff0a00004	lmg	%r9,%r15,160(%r15)
                          0000033840f0848e: 07fe		bcr	15,%r14
                          0000033840f08490: 47000700		bc	0,1792
                          0000033840f08494: c0e5ffffeb86	brasl	%r14,0000033840f05ba0
[  535.525367] Call Trace:
[  535.525372]  [<0000033840f08482>] put_prev_entity+0x102/0x170 
[  535.525377] ([<0000033840f08474>] put_prev_entity+0xf4/0x170)
[  535.525381]  [<0000033840f0852a>] put_prev_task_fair+0x3a/0x60 
[  535.525385]  [<0000033840ef6e58>] pick_next_task+0x138/0xbd0 
[  535.525388]  [<0000033841d364d0>] __schedule+0x180/0x850 
[  535.525391]  [<0000033841d36bdc>] schedule+0x3c/0xc0 
[  535.525394]  [<0000033841d32d10>] irqentry_exit+0x1c0/0x610 
[  535.525397]  [<0000033841d32846>] do_ext_irq+0xe6/0x290 
[  535.525399]  [<0000033841d41576>] ext_int_handler+0xc6/0xf0 
[  535.525402] Last Breaking-Event-Address:
[  535.525403]  [<0000033840eff36a>] propagate_entity_load_avg+0x3a/0x490
[  535.525407] ---[ end trace 0000000000000000 ]---
[  535.525422] ------------[ cut here ]------------
[  535.525424] WARNING: kernel/sched/fair.c:7022 at hrtick_start_fair+0x6c/0x80, CPU#26: swapper/26/0
[  535.525428] Modules linked in: mptcp_diag xfrm_user xfrm_algo tcp_diag crypto_user inet_diag netlink_diag algif_hash af_alg dm_service_time nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables zfcp scsi_transport_fc s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop dm_multipath drm_panel_orientation_quirks nfnetlink uvdevice diag288_wdt prng aes_s390 scsi_dh_rdac scsi_dh_emc scsi_dh_alua phmac_s390 paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey autofs4 ecdsa_generic ecc sha512 [last unloaded: trace_printk]
[  535.525465] CPU: 26 UID: 0 PID: 0 Comm: swapper/26 Tainted: G        W           7.1.0-20260426.rc0.git0.897d54018cc9.300.fc43.s390x+git #1 PREEMPTLAZY 
[  535.525469] Tainted: [W]=WARN
[  535.525471] Hardware name: IBM 8561 T01 703 (LPAR)
[  535.525472] Krnl PSW : 0404e00180000000 0000033840ef9ac0 (hrtick_start_fair+0x70/0x80)
[  535.525476]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[  535.525479] Krnl GPRS: 0000007c00000001 00000003e5533800 00000003e5511800 00000001d3b8c800
[  535.525482]            00000000000000d8 00000338429cd038 0000033840f19860 00000003e5511800
[  535.525484]            00000001d3b8c800 000000000000003f 00000003e55127b0 00000001d3b8c948
[  535.525486]            0000000000000000 0000000081992400 0000033840f0876a 000002b840e5bc48
[  535.525492] Krnl Code: 0000033840ef9ab2: 47000700		bc	0,1792
                          0000033840ef9ab6: c0f4ffffd4dd	brcl	15,0000033840ef4470
                         *0000033840ef9abc: af000000		mc	0,0
                         >0000033840ef9ac0: a7f4ffdc		brc	15,0000033840ef9a78
                          0000033840ef9ac4: 0707		bcr	0,%r7
                          0000033840ef9ac6: 0707		bcr	0,%r7
                          0000033840ef9ac8: 0707		bcr	0,%r7
                          0000033840ef9aca: 0707		bcr	0,%r7
[  535.525505] Call Trace:
[  535.525507]  [<0000033840ef9ac0>] hrtick_start_fair+0x70/0x80 
[  535.525509] ([<0000033840f086fe>] set_next_task_fair+0x4e/0x230)
[  535.525513]  [<0000033840ef6e76>] pick_next_task+0x156/0xbd0 
[  535.525515]  [<0000033841d364d0>] __schedule+0x180/0x850 
[  535.525518]  [<0000033841d36d16>] schedule_idle+0x36/0x60 
[  535.525520]  [<0000033840f141ce>] do_idle+0x11e/0x160 
[  535.525523]  [<0000033840f143e0>] cpu_startup_entry+0x40/0x50 
[  535.525526]  [<0000033840e6f7c8>] smp_start_secondary+0x138/0x150 
[  535.525529]  [<0000033841d40f72>] restart_int_handler+0x72/0x88 
[  535.525532] Last Breaking-Event-Address:
[  535.525533]  [<0000033840ef9a72>] hrtick_start_fair+0x22/0x80
[  535.525536] ---[ end trace 0000000000000000 ]---
[  535.525549] ------------[ cut here ]------------
[  535.525550] WARNING: kernel/sched/sched.h:1769 at set_next_entity+0x35a/0x370, CPU#26: swapper/26/0
[  535.525555] Modules linked in: mptcp_diag xfrm_user xfrm_algo tcp_diag crypto_user inet_diag netlink_diag algif_hash af_alg dm_service_time nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables zfcp scsi_transport_fc s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop dm_multipath drm_panel_orientation_quirks nfnetlink uvdevice diag288_wdt prng aes_s390 scsi_dh_rdac scsi_dh_emc scsi_dh_alua phmac_s390 paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey autofs4 ecdsa_generic ecc sha512 [last unloaded: trace_printk]
[  535.525588] CPU: 26 UID: 0 PID: 0 Comm: swapper/26 Tainted: G        W           7.1.0-20260426.rc0.git0.897d54018cc9.300.fc43.s390x+git #1 PREEMPTLAZY 
[  535.525591] Tainted: [W]=WARN
[  535.525593] Hardware name: IBM 8561 T01 703 (LPAR)
[  535.525594] Krnl PSW : 0404d00180000000 0000033840f0395e (set_next_entity+0x35e/0x370)
[  535.525598]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[  535.525601] Krnl GPRS: 0000007caeee0479 07cafcf56a100000 0000000000000000 0000000000000000
[  535.525604]            00000003e5445800 0000000000e15d28 0000033840f19860 00000003e5511800
[  535.525606]            0000000000000001 0000000000000001 000000026ad0f400 00000001d3b8c900
[  535.525608]            0000000000000000 0000000081992400 0000033840f036f6 000002b840e5bc00
[  535.525613] Krnl Code: 0000033840f03952: b9e93090		sgrk	%r9,%r0,%r3
                          0000033840f03956: a7f4fee7		brc	15,0000033840f03724
                         *0000033840f0395a: af000000		mc	0,0
                         >0000033840f0395e: a7f4fedb		brc	15,0000033840f03714
                          0000033840f03962: 0707		bcr	0,%r7
                          0000033840f03964: 0707		bcr	0,%r7
                          0000033840f03966: 0707		bcr	0,%r7
                          0000033840f03968: 0707		bcr	0,%r7
[  535.525626] Call Trace:
[  535.525627]  [<0000033840f0395e>] set_next_entity+0x35e/0x370 
[  535.525630] ([<0000033840f036f6>] set_next_entity+0xf6/0x370)
[  535.525633]  [<0000033840f086fe>] set_next_task_fair+0x4e/0x230 
[  535.525636]  [<0000033840ef6e76>] pick_next_task+0x156/0xbd0 
[  535.525639]  [<0000033841d364d0>] __schedule+0x180/0x850 
[  535.525642]  [<0000033841d36d16>] schedule_idle+0x36/0x60 
[  535.525645]  [<0000033840f141ce>] do_idle+0x11e/0x160 
[  535.525647]  [<0000033840f143e0>] cpu_startup_entry+0x40/0x50 
[  535.525650]  [<0000033840e6f7c8>] smp_start_secondary+0x138/0x150 
[  535.525652]  [<0000033841d40f72>] restart_int_handler+0x72/0x88 
[  535.525655] Last Breaking-Event-Address:
[  535.525656]  [<0000033840f03710>] set_next_entity+0x110/0x370
[  535.525659] ---[ end trace 0000000000000000 ]---
[  535.528235] ------------[ cut here ]------------
[  535.528241] WARNING: kernel/sched/fair.c:5721 at set_next_entity+0x2c8/0x370, CPU#20: swapper/20/0
[  535.528248] Modules linked in: mptcp_diag xfrm_user xfrm_algo tcp_diag crypto_user inet_diag netlink_diag algif_hash af_alg dm_service_time nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables zfcp scsi_transport_fc s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop dm_multipath drm_panel_orientation_quirks nfnetlink uvdevice diag288_wdt prng aes_s390 scsi_dh_rdac scsi_dh_emc scsi_dh_alua phmac_s390 paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey autofs4 ecdsa_generic ecc sha512 [last unloaded: trace_printk]
[  535.528291] CPU: 20 UID: 0 PID: 0 Comm: swapper/20 Tainted: G        W           7.1.0-20260426.rc0.git0.897d54018cc9.300.fc43.s390x+git #1 PREEMPTLAZY 
[  535.528295] Tainted: [W]=WARN
[  535.528296] Hardware name: IBM 8561 T01 703 (LPAR)
[  535.528297] Krnl PSW : 0404e00180000000 0000033840f038cc (set_next_entity+0x2cc/0x370)
[  535.528302]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[  535.528305] Krnl GPRS: 0000007caff854b2 00000001d3b8c900 0000000082cec900 00000003e5445800
[  535.528308]            000000000000002e 00000000000f423f 0000033840f19860 00000003e5445800
[  535.528310]            00000001d3b8c900 000000804f18b648 000000026ad0f400 00000001d3b8c900
[  535.528312]            0000000000000000 000000008198c800 0000033840f03820 000002b840e2bc00
[  535.528319] Krnl Code: 0000033840f038be: e310a0580002	ltg	%r1,88(%r10)
                          0000033840f038c4: a784fece		brc	8,0000033840f03660
                         *0000033840f038c8: af000000		mc	0,0
                         >0000033840f038cc: a7f4feca		brc	15,0000033840f03660
                          0000033840f038d0: e310b4000002	ltg	%r1,1024(%r11)
                          0000033840f038d6: a784ff09		brc	8,0000033840f036e8
                          0000033840f038da: 4140b400		la	%r4,1024(%r11)
                          0000033840f038de: e330bf00ff71	lay	%r3,-256(%r11)
[  535.528334] Call Trace:
[  535.528336]  [<0000033840f038cc>] set_next_entity+0x2cc/0x370 
[  535.528339] ([<0000033840f037ac>] set_next_entity+0x1ac/0x370)
[  535.528342]  [<0000033840f086fe>] set_next_task_fair+0x4e/0x230 
[  535.528345]  [<0000033840ef6e76>] pick_next_task+0x156/0xbd0 
[  535.528348]  [<0000033841d364d0>] __schedule+0x180/0x850 
[  535.528351]  [<0000033841d36d16>] schedule_idle+0x36/0x60 
[  535.528354]  [<0000033840f141ce>] do_idle+0x11e/0x160 
[  535.528356]  [<0000033840f143e0>] cpu_startup_entry+0x40/0x50 
[  535.528359]  [<0000033840e6f7c8>] smp_start_secondary+0x138/0x150 
[  535.528362]  [<0000033841d40f72>] restart_int_handler+0x72/0x88 
[  535.528365] Last Breaking-Event-Address:
[  535.528366]  [<0000033840f0365c>] set_next_entity+0x5c/0x370
[  535.528369] ---[ end trace 0000000000000000 ]---
[  595.527130] rcu: INFO: rcu_sched self-detected stall on CPU
[  595.527142] rcu: 	7-...!: (47526 ticks this GP) idle=8f04/1/0x4000000000000000 softirq=56080/56080 fqs=0
[  595.527175] rcu: 	(t=60000 jiffies g=232693 q=6273 ncpus=32)
[  595.527177] rcu: rcu_sched kthread timer wakeup didn't happen for 59996 jiffies! g232693 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[  595.527180] rcu: 	Possible timer handling issue on cpu=28 timer-softirq=1957
[  595.527182] rcu: rcu_sched kthread starved for 60000 jiffies! g232693 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=28
[  595.527184] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
[  595.527186] rcu: RCU grace-period kthread stack dump:

Bisect pointed at commit e0ca8991b2de6 ("sched: Make class_schedulers
avoid pushing current, and get rid of proxy_tag_curr()"), of the
sched-core-2026-04-13 pull. But it only seems to make the corruption
trigger easier, reverting it doesn't help. Applying "Proxy Execution
fixes for v7.1-rc" [1] on top didn't help, nor did "Optimized Donor
Migration for Proxy Execution" [2].

The problem goes away when sched_proxy_exec=0 or nosmt is used.

Adding some debug code in deactivate_task() showed try_steal_cookie()
calling it on src->donor right before the warning. try_steal_cookie()
skips src->core_pick and src->curr but not src->donor.

[1] https://lore.kernel.org/all/20260427183848.698551-1-jstultz@google.com/
[2] https://lore.kernel.org/all/20260422230659.903191-1-jstultz@google.com/

The following patch resolves the issue in my tests. Please consider it
if it makes sense.

Vasily Gorbik (1):
  sched/core: Don't steal a proxy-exec donor

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.53.0
