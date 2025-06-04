Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7351C5A;
	Wed,  4 Jun 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037979; cv=none; b=V2ld+Urus/qpl+77CM6ZXPn9Qj09V2CirKiTPQ0KB3EOnsY8WvSSk+IUrQUrubeLcslHX9FybC6R/0GuaX19TSSs4xXemc/XyGz+sGXuAOm/XomaPTib+5wAZaob2EiIdpPl28AkJP7M0RG8paHYKCHkcdwKrBRnEBtWRX9M8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037979; c=relaxed/simple;
	bh=I6sL62JAME8PuBznmWoXj2evmjXHuLP9SMdB6dehbgI=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=kLMznImv2ilmmS6KbhzJUTHDrAHnLUIfnHQcFrNoTULDv7vx+lsRDmvf/9ozT/FRucX1PVCau6BzLLd3sNurT4pQvBIHklyU4vUGWptEwdoRhHCc1NZ+AitU9pdu8pANPJf3cd0Y3/Qa2p6ccuCPx8bPFpSWMK6Nmn/zf5hNa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DXuoEABQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DXuoEABQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5543sUQp030432;
	Wed, 4 Jun 2025 11:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hIlQ/KIJ02fO0J/hYZXUTFNWtCW7
	DG2pHnTn7+6lA3Q=; b=DXuoEABQzSWUIXSurrxmBtm5BZqMr6PLWTpS768HEuxl
	gigIORlNsldXk1IymuXILyPmT2Oh5GFsMe1zr0ns4//pZ6+KYL1qG6450pPmcn+v
	aIj6lJsDUGgFTGECSpdhG65ZAUbxkBIGSd1f4CJ3TV2Z5fB5B3te8sMuGdlHpCBj
	pvvUR9ga7AvnZ4Z6YuAuIBiqoJd/W1vS+lEgfbl75dVBtn4RySLsw9Gt+8gijvON
	WVYSMq03h/nIwaJOJKSfgyj9Ui3Yci5n8YAUUPYHWHRV83i3bjekHe+vgH4W9NjM
	M6K8Lpw2MtUEKUMecvviGQ4G2MTcNCxM/2/m89feFQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyt96f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 11:52:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5547Yuq1024914;
	Wed, 4 Jun 2025 11:52:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmfdty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 11:52:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 554BqnsA32637476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Jun 2025 11:52:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B10358055;
	Wed,  4 Jun 2025 11:52:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8BB58043;
	Wed,  4 Jun 2025 11:52:48 +0000 (GMT)
Received: from [9.155.201.157] (unknown [9.155.201.157])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Jun 2025 11:52:48 +0000 (GMT)
Message-ID: <43bcc782-4aa5-4957-a5ab-73184da29147@linux.ibm.com>
Date: Wed, 4 Jun 2025 13:52:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: kernel/sched/core: WARNING when migrating to an offline CPU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mJaq6_nwYl33KVsGYYe8y7G2DkhSwqSX
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=68403393 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=CEzOr5Ttf5qj40zooyEA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: mJaq6_nwYl33KVsGYYe8y7G2DkhSwqSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA4OCBTYWx0ZWRfXy4uwYFLe6tum DY4Nbe1vAhc6U6CL86cOD+IEO8uTyNaMI3+yhKd26mG/DT71hQHC7PLa8xSHY3seXpcGfkmww6N o7OPPwKdBriLhrHFc8SWkiLkOrNO7JXIXZ4rQouFeQYWZ18ENSL65if6/x/GUuQjMwQ2LCfUv2P
 sziGWrAOC9vpoZSYMxe50U3iT3UfSvB6NmM8u9Gr/+3/jAG7qpOI2IRaVZKy0Y554pogOKy5SNv o4HDUybuelpwBeGQiCVz9jX66HF1D72a52y0CiiPyNnYoncrBg86yL4vw5uDHAnNvwKDuSC0JTP hOKvXjQoCyLTVCvIzxJfcSVfx0GVIHiCFbdzxsCt16hBRtglOavzAX18DgVTgxOzT4Hw3FbXTLe
 RzB0R1g2qwVAfM0E16readJR4SWng3UOE78JAfMflIuJK6/9Gr3e2qdd5kJYX4NdZXv4xoHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 mlxlogscore=450 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040088

Hi Peter,

This WARN_ON has been introduced by you a while ago:
https://lore.kernel.org/all/20170907150614.094206976@infradead.org/

It seems we had a hit on s390 recently followed by a kernel panic while running stress tests on Fedora42 with the latest kernel.
Not sure we can reproduce it easily since the stress workload varies each time.

[248217.530550] ------------[ cut here ]------------
[248217.530560] WARNING: CPU: 76 PID: 469721 at kernel/sched/core.c:3334 set_task_cpu+0x1e2/0x200
[248217.530567] Modules linked in: algif_hash af_alg nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mlx5_ib ib_uverbs ib_core mlx5_vdpa vdpa vringh vhost_iotlb ip_set nf_tables mlx5_core s390_trng vfio_ccw mdev eadm_sch vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop configfs drm_panel_orientation_quirks nfnetlink ctcm fsm zfcp scsi_transport_fc uvdevice diag288_wdt hmac_s390 ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey autofs4 ecdsa_generic ecc
[248217.530624] CPU: 76 UID: 0 PID: 469721 Comm: stress-ng-timer Not tainted 6.16.0-20250526.rc0.git4.b871b0f876d9.63.fc42.s390x #1 NONE
[248217.530629] Hardware name: IBM 9175 ME1 701 (LPAR)
[248217.530631] Krnl PSW : 0404c00180000000 00000289d49b07f6 (set_task_cpu+0x1e6/0x200)
[248217.530636]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[248217.530639] Krnl GPRS: 0000000000000000 0000000000000000 00000289d62cdd28 000000000000000a
[248217.530642]            00000289d62e8e50 00000289d62ca198 000000fbffffffff 0000000000000001
[248217.530644]            7d48be6d37ef83d1 001f522f9b4dfbe0 000000000000000a 000000e88736a300
[248217.530647]            000003ffa65acfa8 000000fb00000000 00000209e8f6fcb8 00000209e8f6fc70
[248217.530654] Krnl Code: 00000289d49b07ea: af000000           mc      0,0
                           00000289d49b07ee: a7f4ff32           brc     15,00000289d49b0652
                          #00000289d49b07f2: af000000           mc      0,0
                          >00000289d49b07f6: bf13b678           icm     %r1,3,1656(%r11)
                           00000289d49b07fa: a784ff43           brc     8,00000289d49b0680
                           00000289d49b07fe: af000000           mc      0,0
                           00000289d49b0802: a7f4ff3f           brc     15,00000289d49b0680
                           00000289d49b0806: 0707               bcr     0,%r7
[248217.530794] Call Trace:
[248217.530798]  [<00000289d49b07f6>] set_task_cpu+0x1e6/0x200
[248217.530803] ([<00000289d49d0f7e>] dequeue_task_dl+0x14e/0x1a0)
[248217.530806]  [<00000289d49cc48c>] push_dl_task+0x1ac/0x220
[248217.530808]  [<00000289d49cdba8>] dl_task_timer+0x178/0x1d0
[248217.530811]  [<00000289d4a355ea>] __hrtimer_run_queues+0x17a/0x2e0
[248217.530814]  [<00000289d4a36820>] hrtimer_interrupt+0x130/0x2a0
[248217.530817]  [<00000289d49177f2>] do_IRQ+0x42/0x70
[248217.530820]  [<00000289d491795a>] do_irq_async+0x5a/0x80
[248217.530823]  [<00000289d5709dcc>] do_ext_irq+0xac/0x170
[248217.530827]  [<00000289d5715e9a>] ext_int_handler+0xc2/0xe8
[248217.530830]  [<00000289d4bc8380>] __rseq_handle_notify_resume+0x60/0x170
[248217.530834]  [<00000289d491353c>] arch_do_signal_or_restart+0x1ac/0x320
[248217.530836]  [<00000289d570a0d2>] syscall_exit_to_user_mode+0x122/0x230
[248217.530840]  [<00000289d5709a9a>] __do_syscall+0x14a/0x250
[248217.530843]  [<00000289d57157ce>] system_call+0x6e/0x90
[248217.530845] Last Breaking-Event-Address:
[248217.530846]  [<00000289d49b0674>] set_task_cpu+0x64/0x200
[248217.530851] ---[ end trace 0000000000000000 ]---
[248217.902560] Fallback order for Node 0: 0
[248217.902563] Built 1 zonelists, mobility grouping on.  Total pages: 279779194
[248217.902568] Policy zone: Normal
[248220.564502] fixpoint divide exception: 0009 ilc:2 [#1]SMP
[248220.564511] Modules linked in: algif_hash af_alg nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mlx5_ib ib_uverbs ib_core mlx5_vdpa vdpa vringh vhost_iotlb ip_set nf_tables mlx5_core s390_trng vfio_ccw mdev eadm_sch vfio_iommu_type1 vfio sch_fq_codel drm i2c_core loop configfs drm_panel_orientation_quirks nfnetlink ctcm fsm zfcp scsi_transport_fc uvdevice diag288_wdt hmac_s390 ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey autofs4 ecdsa_generic ecc
[248220.564558] CPU: 10 UID: 0 PID: 809915 Comm: stress-ng-cpu-s Tainted: G        W           6.16.0-20250526.rc0.git4.b871b0f876d9.63.fc42.s390x #1 NONE
[248220.564562] Tainted: [W]=WARN
[248220.564563] Hardware name: IBM 9175 ME1 701 (LPAR)
[248220.564564] Krnl PSW : 0404e00180000000 00000289d49cb02a (task_non_contending+0x13a/0x340)
[248220.564569]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[248220.564571] Krnl GPRS: 0000000000000001 0000000000000030 0000000000000000 00000000000001a1
[248220.564573]            00000000000001a0 0000000000006666 0000000000006666 00000289d670c1e0
[248220.564575]            00000289d5c92da8 00000289d62e7d38 000000fb00000000 000000e88736a630
[248220.564576]            000003ff97a2cfa8 0000020900000047 00000289d49cb022 00000209ec89fc50
[248220.564582] Krnl Code: 00000289d49cb01c: c0e5ffffeef2       brasl   %r14,00000289d49c8e00
                           00000289d49cb022: b9140056           lgfr    %r5,%r6
                          #00000289d49cb026: b90d0042           dsgr    %r4,%r2
                          >00000289d49cb02a: e32070f80004       lg      %r2,248(%r7)
                           00000289d49cb030: c4a800c80ab0       lgrl    %r10,00000289d62cc590
                           00000289d49cb036: b9090026           sgr     %r2,%r6
                           00000289d49cb03a: e32070f80024       stg     %r2,248(%r7)
                           00000289d49cb040: c42800c81264       lgrl    %r2,00000289d62cd508
[248220.564630] Call Trace:
[248220.564633]  [<00000289d49cb02a>] task_non_contending+0x13a/0x340
[248220.564637] ([<00000289d49cb022>] task_non_contending+0x132/0x340)
[248220.564640]  [<00000289d49cb35e>] switched_from_dl+0x12e/0x180
[248220.564643]  [<00000289d49acf44>] check_class_changed+0x44/0xa0
[248220.564646]  [<00000289d49d315e>] __sched_setscheduler+0x30e/0x990
[248220.564648]  [<00000289d49d38dc>] sched_setscheduler+0x7c/0x90
[248220.564650]  [<00000289d49d395a>] do_sched_setscheduler+0x6a/0x130
[248220.564652]  [<00000289d49d3c2c>] __s390x_sys_sched_setscheduler+0x3c/0x60
[248220.564654]  [<00000289d5709a86>] __do_syscall+0x136/0x250
[248220.564657]  [<00000289d57157ce>] system_call+0x6e/0x90
[248220.564661] Last Breaking-Event-Address:
[248220.564661]  [<00000289d49c8ea2>] dl_bw_cpus+0xa2/0xd0
[248220.564666] Kernel panic - not syncing: Fatal exception: panic_on_oops


Thanks,
Mikhail
