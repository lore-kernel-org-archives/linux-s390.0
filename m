Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B6374A0A;
	Wed, 10 Jun 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095731; cv=none; b=WoiL46aGSfgxKOE5hcdf3tKYK8fwPrLfpmMMUkB+pJC2VWLpqRSMmgOjb5amu9Yv+0YuS6py6inQ0coBmoZGPbgwQWOfeS5fDSM1nkfktcrjnvCq3PaNCAdf8cOIYWnm5pUzaPDXtv5O3mnsuD9lrXF1hiz5krJuuNPUz3qH2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095731; c=relaxed/simple;
	bh=/V9xKQTRSzBiLWjpdX7EIZ0QQnnt5ENDyk/ptFHwkkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FbndJWteov3YVgDGHp/82nMo73t4zJDWGm778gtko/Uf4spomTwasrNd/spJyvHhqA6JDa879REhKhZgVNe/iflw4I0mEsugUaxqpyzK/zRukSB7kqW/QFShyu9eZd1h8PAgh8Iz9FSWOyBVH1ePNB6s/96dMn5ymkq9kRNKoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AFYhbNki; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFYhbNki"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AA6dSD3945916;
	Wed, 10 Jun 2026 12:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=Ian2Q0Qeno/9qnfuBIjfz8+lE/cOshQQPX9TQEbKfV4=; b=AFYhbNki
	M2QqhIuY8etzddfd2uUER9HG42TghTQu15TkkV8mAFUo2DY0GjgI5Yx0VBAmpxy1
	7/OifXwZkWhkIYdt0e7JmCrlrHp98Q0GPuG01ljA1epgSLnI/ysXKosdVH1ad/4F
	rUGp5Qr0abO7R3OGGBZPpjLup4EVp5Pkwtd+VeJR0X58wbKm8dAw2Cc7dwIO66xb
	l5/SoS9XH7MCOna8PGAd9dh6jMY0nwm7LcDlAigf9fDijPiDdVb/8wq62gdsPdio
	4na7WbP2LEXwQzGLxPpYYB3sOh3WoVcRvOOCxs1EASo/FrimVnIcMx0WmYLayP3m
	0pt5yRXauDjeDw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t0msw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 12:48:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ACYr3L027746;
	Wed, 10 Jun 2026 12:48:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych6j5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 12:48:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AClui114746094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 12:47:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 490B92004E;
	Wed, 10 Jun 2026 12:47:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01F3620043;
	Wed, 10 Jun 2026 12:47:56 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 12:47:55 +0000 (GMT)
Date: Wed, 10 Jun 2026 14:47:54 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        John Stultz <jstultz@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: linux-next crashes in scheduler on s390
Message-ID: <17e75ff4-cf90-4772-9965-92a7235ca806-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fmp0kQuc78SGuh2jQkNieesPO5Q9B8N0
X-Proofpoint-GUID: DYDLtftXSp_VpIfu4fVDVqed5lkAw0vA
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a295d01 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=7taQQwSReRbAgFppUDUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEyMSBTYWx0ZWRfX/PKVE87W84S6
 FoxNhd5jHTObGTwXu+JAkJWmYbyTXjKGbHqnbGEgmXDrbl5RslWysAWreOE8Qy5Cz4dt6DHKI/Z
 G1S88txn+7UDDmPCbszQZIGSHehdEMSIkqDhPgUs+q3i1/ZIyqt+DjIAGvSmUPqrqbhG/fM87bf
 fQr8rPZhCqfPZVF0WaxigSrlsa/Wrce+aBM9h/528UUzUDwdvdJjhzSia7vzwl6FBkyODP7SezD
 F5qsSYRXlKTJL5nOltxhqFuJeDXgQUuT5BTcy+JtdiNQyi4Rkhfcx2vnLpeGJxhvmxHaLhcwWVz
 JwEVjqst1sIjuanLztY0UgpkVdtOWFbCWhtk+bVw8Uzx/1ni365vQmloqZejrk/jvioEwkQTnA7
 dwlP8jcvV+4mZ4p5PdJDEYMIsFe0+CKNV6iauscqyKIOJYYatstkVq8327R8HYkqNSskkFSgzuq
 COcT1MoznzT06uaWbCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100121

Hi All,

Since about June 1st we're getting strace test suite (make -j$(nproc) check)
crashes on s390 in linux-next. Those are pretty easy to reproduce, but I
have not been able to nail it down to the particular commit/merge.

I am going to bisect it, but since we are approaching v7.1 release, any
hint would be greatly appreciated!

[ 2425.124912] ------------[ cut here ]------------
[ 2425.124926] WARNING: kernel/sched/sched.h:1792 at set_next_task_idle+0xd2/0x150, CPU#7: strace/893382
[ 2425.124937] Modules linked in: mptcp_diag xfrm_user xfrm_algo crypto_user tcp_diag inet_diag netlink_diag tls quota_v2 quota_tree tun overlay nls_iso8859_1 nls_cp437 exfat vfat fat loop sctp udp_tunnel ip6_udp_tunnel nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core drm_panel_orientation_quirks dm_service_time diag288_wdt prng aes_s390 dm_mirror dm_region_hash dm_log zfcp scsi_transport_fc pkey_cca pkey_ep11 zcrypt pa
es_s390 phmac_s390 rng_core pkey_pckmo pkey scsi_dh_rdac crypto_engine scsi_dh_alua scsi_dh_emc dm_multipath autofs4 ecdsa_generic ecc sha512
[ 2425.125058] CPU: 7 UID: 1001 PID: 893382 Comm: strace Tainted: G        W           7.1.0-20260607.rc6.git0.6e845bcb78c9.300.fc44.s390x+next #1 PREEMPTLAZY
[ 2425.125065] Tainted: [W]=WARN
[ 2425.125068] Hardware name: IBM 3906 M03 703 (LPAR)
[ 2425.125071] Krnl PSW : 0404d00180000000 000003bf4c78da26 (set_next_task_idle+0xd6/0x150)
[ 2425.125080]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[ 2425.125085] Krnl GPRS: 0000000000000000 0000000000000154 0000000000000154 000003bf4e7baba8
[ 2425.125090]            0000000000000000 0000000000000154 000003bf00000000 000003bf4e2d9038
[ 2425.125093]            0000000081778000 000003bf4e7a5a00 0000000081778000 00000003ac6dba00
[ 2425.125097]            0000000000000000 0000000000000000 000003bf4c78d980 0000033f5137bac0
[ 2425.125108] Krnl Code: 000003bf4c78da18: e55dbf200001        clfhsi  3872(%r11),1
[ 2425.125108]            000003bf4c78da1e: a724ffb9            brc     2,000003bf4c78d990
[ 2425.125108]           *000003bf4c78da22: af000000            mc      0,0
[ 2425.125108]           >000003bf4c78da26: a7f4ffb5            brc     15,000003bf4c78d990
[ 2425.126081]  [<000003bf4c764f16>] prepare_task_switch+0x216/0x230
[ 2425.126087]  [<000003bf4d61b9b4>] __schedule+0x254/0x8d0
[ 2425.126091]  [<000003bf4d61c06c>] schedule+0x3c/0xc0
[ 2425.126095]  [<000003bf4c72b40c>] do_wait+0x6c/0x190
[ 2425.126100]  [<000003bf4c72b9da>] kernel_wait4+0xaa/0x150
[ 2425.126105]  [<000003bf4c72bafe>] __do_sys_wait4+0x7e/0x90
[ 2425.126110]  [<000003bf4d6173d0>] __do_syscall+0x150/0x590
[ 2425.126114]  [<000003bf4d6264b2>] system_call+0x72/0x90
[ 2425.126119] Last Breaking-Event-Address:
[ 2425.126121]  [<000003bf4c764d36>] prepare_task_switch+0x36/0x230
[ 2425.126127] ---[ end trace 0000000000000000 ]---

[ 1569.523962] ------------[ cut here ]------------
[ 1569.523974] WARNING: kernel/sched/core.c:6388 at pick_next_task+0xb82/0xbf0, CPU#7: swapper/7/0
[ 1569.523986] Modules linked in: mptcp_diag xfrm_user xfrm_algo tcp_diag crypto_user inet_diag netlink_diag nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ip
f_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables s390_trng vfio_ccw mdev ea
dm_sch vfio_iommu_type1 vfio sch_fq_codel drm i2c_core drm_panel_orientation_quirks dm_service_time uvdevice diag288_wdt prng aes_s390 dm_mirror dm_region_hash dm_log zfcp scsi_transpo
c pkey_cca pkey_ep11 zcrypt paes_s390 phmac_s390 rng_core pkey_pckmo scsi_dh_alua pkey scsi_dh_emc crypto_engine scsi_dh_rdac dm_mul
tipath autofs4 ecdsa_generic ecc sha512
[ 1569.524037] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G        W           7.1.0-20260607.rc6.git0.6e845bcb78c9.300.fc44.s390x+next #1 PREEMPTLAZY
[ 1569.524042] Tainted: [W]=WARN
[ 1569.524043] Hardware name: IBM 3931 A01 701 (LPAR)
[ 1569.524045] Krnl PSW : 0404c00180000000 0000027673df72a6 (pick_next_task+0xb86/0xbf0)
[ 1569.524050]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[ 1569.524053] Krnl GPRS: 00000000000002ed 0000027600000190 0000000000000190 0000027675e4abb0
[ 1569.524056]            0000000000000000 00000004e04c1a00 0000027600000002 00000004e04c1a00
[ 1569.524058]            0000000000000000 00000004e04e3a00 00000004e04e3a00 0000000000000190
[ 1569.524060]            0000000000000000 00000004000002ed 0000027673df6cd2 000001f673cc3c98
[ 1569.524069] Krnl Code: 0000027673df7298: ec56fcb6ff7e        cij     %r5,-1,6,0000027673df6c04
[ 1569.524069]            0000027673df729e: a7f4ff84            brc     15,0000027673df71a6
[ 1569.524069]           *0000027673df72a2: af000000            mc      0,0
[ 1569.524069]           >0000027673df72a6: a7f4fdef            brc     15,0000027673df6e84
[ 1569.524069]            0000027673df72aa: b9040087            lgr     %r8,%r7
[ 1569.524069]            0000027673df72ae: a7f4fb3c            brc     15,0000027673df6926
[ 1569.524069]            0000027673df72b2: af000000            mc      0,0
[ 1569.524069]            0000027673df72b6: a7f4ff2c            brc     15,0000027673df710e
[ 1569.524200] Call Trace:
[ 1569.524202]  [<0000027673df72a6>] pick_next_task+0xb86/0xbf0
[ 1569.524206] ([<0000027673df6b5e>] pick_next_task+0x43e/0xbf0)
[ 1569.524210]  [<0000027674cab926>] __schedule+0x1c6/0x8d0
[ 1569.524214]  [<0000027674cac1a6>] schedule_idle+0x36/0x60
[ 1569.524216]  [<0000027673e22f04>] do_idle+0x124/0x1a0
[ 1569.524221]  [<0000027673e23170>] cpu_startup_entry+0x40/0x50
[ 1569.524225]  [<0000027673d76994>] smp_start_secondary+0x144/0x160
[ 1569.524230]  [<0000027674cb688a>] restart_int_handler+0x72/0x88
[ 1569.524235] Last Breaking-Event-Address:
[ 1569.524236]  [<0000027673df6e80>] pick_next_task+0x760/0xbf0
[ 1569.524240] ---[ end trace 0000000000000000 ]---

[ 3533.502832] ------------[ cut here ]------------
[ 3533.502837] WARNING: kernel/sched/fair.c:7656 at hrtick_start_fair+0x6e/0x80, CPU#20: strace/2964820
[ 3533.502847] Modules linked in: mptcp_diag xfrm_user xfrm_algo tcp_diag crypto_user inet_diag netlink_diag tls quota_v2 quota_tree tun overlay nls_iso8859_1 nls_cp437 exfat vfat fat
 sctp udp_tunnel ip6_udp_tunnel algif_hash af_alg smc_diag smc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mlx5_ib ib_uverbs_support ib_core mlx5_vdpa vdpa vringh vhost_iotlb nf_tables mlx5_core s390_trng vfio_ccw mdev vfio_iommu_type1 eadm_
vfio sch_fq_codel drm i2c_core drm_panel_orientation_quirks dm_service_time uvdevice diag288_wdt hmac_s390 prng aes_s390 dm_mirror dm_region_hash dm_log zfcp scsi_transport_fc pkey_cca
y_ep11 zcrypt paes_s390 phmac_s390 rng_core pkey_pckmo pkey scsi_dh_alua scsi_dh_rdac scsi_dh_emc crypto_engine dm_multipath autofs4 ecdsa_generic ecc sha512 [last unloaded: trace_prin

[ 3533.502908] CPU: 20 UID: 1001 PID: 2964820 Comm: strace Tainted: G        W           7.1.0-20260607.rc6.git0.6e845bcb78c9.300.fc44.s390x+next #1 PREEMPTLAZY
[ 3533.502912] Tainted: [W]=WARN
[ 3533.502914] Hardware name: IBM 9175 ME1 701 (LPAR)
[ 3533.502915] Krnl PSW : 0404e00180000000 0000033a5a572be2 (hrtick_start_fair+0x72/0x80)
[ 3533.502921]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[ 3533.502924] Krnl GPRS: 00000000000000ff 00000003e4c9fa00 00000003e4c7da00 000000012cb72400
[ 3533.502926]            00000000000000a8 0000033a5c0d5038 00000003e4c7e9b0 00000003e4c7da00
[ 3533.502928]            000000012cb72400 0000033a5c0d6090 0000000300000014 000000012cb72548
[ 3533.502930]            0000000000000000 00000c0700000001 0000033a5a57f640 000002ba61a33a98
[ 3533.502938] Krnl Code: 0000033a5a572bd4: 47000700                bc      0,1792
                          0000033a5a572bd8: c0f4ffff7c64    brcl    15,0000033a5a5624a0
                         *0000033a5a572bde: af000000                mc      0,0
                         >0000033a5a572be2: a7f4ffdc                brc     15,0000033a5a572b9a
                          0000033a5a572be6: 0707            bcr     0,%r7
                          0000033a5a572be8: 0707            bcr     0,%r7
                          0000033a5a572bea: 0707            bcr     0,%r7
                          0000033a5a572bec: 0707            bcr     0,%r7
[ 3533.502985] Call Trace:
[ 3533.502988]  [<0000033a5a572be2>] hrtick_start_fair+0x72/0x80
[ 3533.502991] ([<0000033a5a57f4ae>] set_next_task_fair+0x12e/0x5d0)
[ 3533.502995]  [<0000033a5a56284c>] pick_next_task+0x12c/0xbf0
[ 3533.503001]  [<0000033a5b417926>] __schedule+0x1c6/0x8d0
[ 3533.503004]  [<0000033a5b41806c>] schedule+0x3c/0xc0
[ 3533.503006]  [<0000033a5a52740c>] do_wait+0x6c/0x190
[ 3533.503012]  [<0000033a5a5279da>] kernel_wait4+0xaa/0x150
[ 3533.503014]  [<0000033a5a527afe>] __do_sys_wait4+0x7e/0x90
[ 3533.503017]  [<0000033a5b4133cc>] __do_syscall+0x14c/0x590
[ 3533.503022]  [<0000033a5b4224b2>] system_call+0x72/0x90
[ 3533.503025] Last Breaking-Event-Address:
[ 3533.503026]  [<0000033a5a572b94>] hrtick_start_fair+0x24/0x80
[ 3533.503030] ---[ end trace 0000000000000000 ]---

Thanks!
