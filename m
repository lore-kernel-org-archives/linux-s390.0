Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952D2C0279;
	Fri, 12 Dec 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552511; cv=none; b=QaLdGdllL5G2e4YFrQA+fYxhrqoWf8WsLtSS9wQW/KVsDQviGGAhoaUEjMzfP9KXgUXCfbZW5wh4FcAdWoVb4rPS3ejygl1712djw89KHHxj7WbvYOwSvixROX57dZcC+vcpN106+DfNHSpNvr6GPRLlQiOb7kiGLKizIvrh3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552511; c=relaxed/simple;
	bh=TxWzYua5PdssB2Ru6FEh1hHVhiQixLz1xOB8IOlu0JI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M60xfFdywOlHOvNLeHp4XLJ/9pgtrMppTZ0POXEe+JYnA3p1JRcfq98DIHplJoxBB0hyOAZlHbV2GDRDt6lr4598eS8qUthL5JKsg/Hut74kV3oryyyet5L+Qz03KoxLuI2yDZJ8/fqruYjkbu6Aw4iZeoEMJj92phjKAUQC1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pdInoUIG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pdInoUIG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCF5AUY007030;
	Fri, 12 Dec 2025 15:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=mcQwWjLr/MnvhHz7LcGUnOqHwl3FdHGQcUVFCIvQXB8=; b=pdInoUIG
	hTFsAciQd8+muRqn7pgcU0IdDrzM4/p05I7gXq9Sv4YfzwX1Al2zIIT9DR3jD0jw
	gAXv2RIx3ZHeHkOrKKgMFho6sQewX65nFQ5aEJz4R7l1FFZV3k4ULQrT5Wt2GZDg
	A3v4oSrHWJU/AfqlqjKgQm3/EJgx2THNk1uoAkXFI+DnIJFq/VMBIz8oEd0QyTW1
	6RIQfEPY/A7RJSXacwj94MoidYV4PAhJnFh0HXQ4zQ+wzT8e1TYPKLfT9K2dctgF
	wfen99Dgudbft20aD9nxeh8gphtTQcPHXngoQNvmWW8P8DGKfEiEkI6Qsf+tyODL
	cDmnCyNO38GgpQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0ke2ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 15:15:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCEkvR2026836;
	Fri, 12 Dec 2025 15:15:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h1m96x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 15:15:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BCFExED52429124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 15:14:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1093720043;
	Fri, 12 Dec 2025 15:14:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D857120040;
	Fri, 12 Dec 2025 15:14:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Dec 2025 15:14:58 +0000 (GMT)
Date: Fri, 12 Dec 2025 16:14:57 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Marc Hartmayer <mhartmay@linux.ibm.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: change all pageblocks migrate type on
 coalescing
Message-ID: <20251212151457.3898073Add-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693c3175 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=BYGt3CUIH6UFlYqRJg4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: bZlwOoOYlYMno1f9809YkAnL220E54Ot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX3seQhtNlwR1x
 vwM2UsRLGmtrHSred9kyiBA/luTfhSW7wiPDsjhMR/Kz3Gr09GL00LrZoSOslyVHMyMHKrK0GFT
 ZAcEYcoGsbFaR2pXVGodfgLT7siRWtdDvJuWp36moQ5rG6ynWByIFZxyv7rJeWIDXBMIHqYyfkq
 81JdFRtlMjHaqd7shbQWFLupUTDfp2DW9owlzSTC2q+qpTwZ91ndlSolwSOiIPZiKvIZ8/6Ikba
 on7tV+ADnyhs6trzAVNcW3dlHQ1m3vcA1O7gUDjY5TQACdiIfbbpCtS0ediLJJCwPZb6bk3+YCp
 bGzgmyoUzJGZKrQuoYMzMVLK5HASnhKD863mZu5ubJBd/epcZTzeZrsqG+7WYXLtAayVKvxvLT0
 HMSgzE2ZBNDkPu5mlJ6mPlBXBSFt/A==
X-Proofpoint-GUID: bZlwOoOYlYMno1f9809YkAnL220E54Ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

When a page is freed it coalesces with a buddy into a higher
order page while possible. When the buddy page migrate type
differs, it is expected to be updated to match the one of the
page being freed.

However, only the first pageblock of the buddy page is updated,
while the rest of the pageblocks are left unchanged.

That causes warnings in later expand() and other code paths
(like below), since an inconsistency between migration type
of the list containing the page and the page-owned pageblocks
migration types is introduced.

The issue is first exposed with commit e0932b6c1f94 ("mm:
page_alloc: consolidate free page accounting"), where the
warnings were introduced, but it is observed in earlier
versions if similar warnings are added.

[  308.986589] ------------[ cut here ]------------
[  308.987227] page type is 0, passed migratetype is 1 (nr=256)
[  308.987275] WARNING: CPU: 1 PID: 5224 at mm/page_alloc.c:812 expand+0x23c/0x270
[  308.987293] Modules linked in: algif_hash(E) af_alg(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) s390_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) drm(E) i2c_core(E) drm_panel_orientation_quirks(E) loop(E) nfnetlink(E) vsock_loopback(E) vmw_vsock_virtio_transport_common(E) vsock(E) ctcm(E) fsm(E) diag288_wdt(E) watchdog(E) zfcp(E) scsi_transport_fc(E) ghash_s390(E) prng(E) aes_s390(E) des_generic(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha_common(E) paes_s390(E) crypto_engine(E) pkey_cca(E) pkey_ep11(E) zcrypt(E) rng_core(E) pkey_pckmo(E) pkey(E) autofs4(E)
[  308.987439] Unloaded tainted modules: hmac_s390(E):2
[  308.987650] CPU: 1 UID: 0 PID: 5224 Comm: mempig_verify Kdump: loaded Tainted: G            E       6.18.0-gcc-bpf-debug #431 PREEMPT
[  308.987657] Tainted: [E]=UNSIGNED_MODULE
[  308.987661] Hardware name: IBM 3906 M04 704 (z/VM 7.3.0)
[  308.987666] Krnl PSW : 0404f00180000000 00000349976fa600 (expand+0x240/0x270)
[  308.987676]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
[  308.987682] Krnl GPRS: 0000034980000004 0000000000000005 0000000000000030 000003499a0e6d88
[  308.987688]            0000000000000005 0000034980000005 000002be803ac000 0000023efe6c8300
[  308.987692]            0000000000000008 0000034998d57290 000002be00000100 0000023e00000008
[  308.987696]            0000000000000000 0000000000000000 00000349976fa5fc 000002c99b1eb6f0
[  308.987708] Krnl Code: 00000349976fa5f0: c020008a02f2	larl	%r2,000003499883abd4
                          00000349976fa5f6: c0e5ffe3f4b5	brasl	%r14,0000034997378f60
                         #00000349976fa5fc: af000000		mc	0,0
                         >00000349976fa600: a7f4ff4c		brc	15,00000349976fa498
                          00000349976fa604: b9040026		lgr	%r2,%r6
                          00000349976fa608: c0300088317f	larl	%r3,0000034998800906
                          00000349976fa60e: c0e5fffdb6e1	brasl	%r14,00000349976b13d0
                          00000349976fa614: af000000		mc	0,0
[  308.987734] Call Trace:
[  308.987738]  [<00000349976fa600>] expand+0x240/0x270
[  308.987744] ([<00000349976fa5fc>] expand+0x23c/0x270)
[  308.987749]  [<00000349976ff95e>] rmqueue_bulk+0x71e/0x940
[  308.987754]  [<00000349976ffd7e>] __rmqueue_pcplist+0x1fe/0x2a0
[  308.987759]  [<0000034997700966>] rmqueue.isra.0+0xb46/0xf40
[  308.987763]  [<0000034997703ec8>] get_page_from_freelist+0x198/0x8d0
[  308.987768]  [<0000034997706fa8>] __alloc_frozen_pages_noprof+0x198/0x400
[  308.987774]  [<00000349977536f8>] alloc_pages_mpol+0xb8/0x220
[  308.987781]  [<0000034997753bf6>] folio_alloc_mpol_noprof+0x26/0xc0
[  308.987786]  [<0000034997753e4c>] vma_alloc_folio_noprof+0x6c/0xa0
[  308.987791]  [<0000034997775b22>] vma_alloc_anon_folio_pmd+0x42/0x240
[  308.987799]  [<000003499777bfea>] __do_huge_pmd_anonymous_page+0x3a/0x210
[  308.987804]  [<00000349976cb08e>] __handle_mm_fault+0x4de/0x500
[  308.987809]  [<00000349976cb14c>] handle_mm_fault+0x9c/0x3a0
[  308.987813]  [<000003499734d70e>] do_exception+0x1de/0x540
[  308.987822]  [<0000034998387390>] __do_pgm_check+0x130/0x220
[  308.987830]  [<000003499839a934>] pgm_check_handler+0x114/0x160
[  308.987838] 3 locks held by mempig_verify/5224:
[  308.987842]  #0: 0000023ea44c1e08 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0xb2/0x2a0
[  308.987859]  #1: 0000023ee4d41b18 (&pcp->lock){+.+.}-{2:2}, at: rmqueue.isra.0+0xad6/0xf40
[  308.987871]  #2: 0000023efe6c8998 (&zone->lock){..-.}-{2:2}, at: rmqueue_bulk+0x5a/0x940
[  308.987886] Last Breaking-Event-Address:
[  308.987890]  [<0000034997379096>] __warn_printk+0x136/0x140
[  308.987897] irq event stamp: 52330356
[  308.987901] hardirqs last  enabled at (52330355): [<000003499838742e>] __do_pgm_check+0x1ce/0x220
[  308.987907] hardirqs last disabled at (52330356): [<000003499839932e>] _raw_spin_lock_irqsave+0x9e/0xe0
[  308.987913] softirqs last  enabled at (52329882): [<0000034997383786>] handle_softirqs+0x2c6/0x530
[  308.987922] softirqs last disabled at (52329859): [<0000034997382f86>] __irq_exit_rcu+0x126/0x140
[  308.987929] ---[ end trace 0000000000000000 ]---
[  308.987936] ------------[ cut here ]------------
[  308.987940] page type is 0, passed migratetype is 1 (nr=256)
[  308.987951] WARNING: CPU: 1 PID: 5224 at mm/page_alloc.c:860 __del_page_from_free_list+0x1be/0x1e0
[  308.987960] Modules linked in: algif_hash(E) af_alg(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) s390_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) drm(E) i2c_core(E) drm_panel_orientation_quirks(E) loop(E) nfnetlink(E) vsock_loopback(E) vmw_vsock_virtio_transport_common(E) vsock(E) ctcm(E) fsm(E) diag288_wdt(E) watchdog(E) zfcp(E) scsi_transport_fc(E) ghash_s390(E) prng(E) aes_s390(E) des_generic(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha_common(E) paes_s390(E) crypto_engine(E) pkey_cca(E) pkey_ep11(E) zcrypt(E) rng_core(E) pkey_pckmo(E) pkey(E) autofs4(E)
[  308.988070] Unloaded tainted modules: hmac_s390(E):2
[  308.988087] CPU: 1 UID: 0 PID: 5224 Comm: mempig_verify Kdump: loaded Tainted: G        W   E       6.18.0-gcc-bpf-debug #431 PREEMPT
[  308.988095] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[  308.988100] Hardware name: IBM 3906 M04 704 (z/VM 7.3.0)
[  308.988105] Krnl PSW : 0404f00180000000 00000349976f9e32 (__del_page_from_free_list+0x1c2/0x1e0)
[  308.988118]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
[  308.988127] Krnl GPRS: 0000034980000004 0000000000000005 0000000000000030 000003499a0e6d88
[  308.988133]            0000000000000005 0000034980000005 0000034998d57290 0000023efe6c8300
[  308.988139]            0000000000000001 0000000000000008 000002be00000100 000002be803ac000
[  308.988144]            0000000000000000 0000000000000001 00000349976f9e2e 000002c99b1eb728
[  308.988153] Krnl Code: 00000349976f9e22: c020008a06d9	larl	%r2,000003499883abd4
                          00000349976f9e28: c0e5ffe3f89c	brasl	%r14,0000034997378f60
                         #00000349976f9e2e: af000000		mc	0,0
                         >00000349976f9e32: a7f4ff4e		brc	15,00000349976f9cce
                          00000349976f9e36: b904002b		lgr	%r2,%r11
                          00000349976f9e3a: c030008a06e7	larl	%r3,000003499883ac08
                          00000349976f9e40: c0e5fffdbac8	brasl	%r14,00000349976b13d0
                          00000349976f9e46: af000000		mc	0,0
[  308.988184] Call Trace:
[  308.988188]  [<00000349976f9e32>] __del_page_from_free_list+0x1c2/0x1e0
[  308.988195] ([<00000349976f9e2e>] __del_page_from_free_list+0x1be/0x1e0)
[  308.988202]  [<00000349976ff946>] rmqueue_bulk+0x706/0x940
[  308.988208]  [<00000349976ffd7e>] __rmqueue_pcplist+0x1fe/0x2a0
[  308.988214]  [<0000034997700966>] rmqueue.isra.0+0xb46/0xf40
[  308.988221]  [<0000034997703ec8>] get_page_from_freelist+0x198/0x8d0
[  308.988227]  [<0000034997706fa8>] __alloc_frozen_pages_noprof+0x198/0x400
[  308.988233]  [<00000349977536f8>] alloc_pages_mpol+0xb8/0x220
[  308.988240]  [<0000034997753bf6>] folio_alloc_mpol_noprof+0x26/0xc0
[  308.988247]  [<0000034997753e4c>] vma_alloc_folio_noprof+0x6c/0xa0
[  308.988253]  [<0000034997775b22>] vma_alloc_anon_folio_pmd+0x42/0x240
[  308.988260]  [<000003499777bfea>] __do_huge_pmd_anonymous_page+0x3a/0x210
[  308.988267]  [<00000349976cb08e>] __handle_mm_fault+0x4de/0x500
[  308.988273]  [<00000349976cb14c>] handle_mm_fault+0x9c/0x3a0
[  308.988279]  [<000003499734d70e>] do_exception+0x1de/0x540
[  308.988286]  [<0000034998387390>] __do_pgm_check+0x130/0x220
[  308.988293]  [<000003499839a934>] pgm_check_handler+0x114/0x160
[  308.988300] 3 locks held by mempig_verify/5224:
[  308.988305]  #0: 0000023ea44c1e08 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0xb2/0x2a0
[  308.988322]  #1: 0000023ee4d41b18 (&pcp->lock){+.+.}-{2:2}, at: rmqueue.isra.0+0xad6/0xf40
[  308.988334]  #2: 0000023efe6c8998 (&zone->lock){..-.}-{2:2}, at: rmqueue_bulk+0x5a/0x940
[  308.988346] Last Breaking-Event-Address:
[  308.988350]  [<0000034997379096>] __warn_printk+0x136/0x140
[  308.988356] irq event stamp: 52330356
[  308.988360] hardirqs last  enabled at (52330355): [<000003499838742e>] __do_pgm_check+0x1ce/0x220
[  308.988366] hardirqs last disabled at (52330356): [<000003499839932e>] _raw_spin_lock_irqsave+0x9e/0xe0
[  308.988373] softirqs last  enabled at (52329882): [<0000034997383786>] handle_softirqs+0x2c6/0x530
[  308.988380] softirqs last disabled at (52329859): [<0000034997382f86>] __irq_exit_rcu+0x126/0x140
[  308.988388] ---[ end trace 0000000000000000 ]---

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Closes: https://lore.kernel.org/linux-mm/87wmalyktd.fsf@linux.ibm.com/
Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/page_alloc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ed82ee55e66a..6e644f2744c2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -913,6 +913,17 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 			NULL) != NULL;
 }
 
+static void change_pageblock_range(struct page *pageblock_page,
+				   int start_order, int migratetype)
+{
+	int nr_pageblocks = 1 << (start_order - pageblock_order);
+
+	while (nr_pageblocks--) {
+		set_pageblock_migratetype(pageblock_page, migratetype);
+		pageblock_page += pageblock_nr_pages;
+	}
+}
+
 /*
  * Freeing function for a buddy system allocator.
  *
@@ -999,7 +1010,7 @@ static inline void __free_one_page(struct page *page,
 			 * expand() down the line puts the sub-blocks
 			 * on the right freelists.
 			 */
-			set_pageblock_migratetype(buddy, migratetype);
+			change_pageblock_range(buddy, order, migratetype);
 		}
 
 		combined_pfn = buddy_pfn & pfn;
@@ -2146,17 +2157,6 @@ bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *pag
 
 #endif /* CONFIG_MEMORY_ISOLATION */
 
-static void change_pageblock_range(struct page *pageblock_page,
-					int start_order, int migratetype)
-{
-	int nr_pageblocks = 1 << (start_order - pageblock_order);
-
-	while (nr_pageblocks--) {
-		set_pageblock_migratetype(pageblock_page, migratetype);
-		pageblock_page += pageblock_nr_pages;
-	}
-}
-
 static inline bool boost_watermark(struct zone *zone)
 {
 	unsigned long max_boost;
-- 
2.51.0

