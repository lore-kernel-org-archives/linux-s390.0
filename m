Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B2265609;
	Mon, 18 Aug 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535166; cv=none; b=Z/Or/0oW78BFxHlc2x0EiMUU1+mMhlccr1gJVnlDdJ8kKtT0a9WuPivGoESKFrhrQitxhT8lXMkKay6Y6PwgEGaXCzIVpBLhvizIrLfL3lonkZRrP9cA1d38mg1yhhmetmXRmO6GnDpFx39bsv4gstv5yZkon/MIbo9TzrVHn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535166; c=relaxed/simple;
	bh=IYNw/Mt3VRKskEZVruQwzOyOO8N+aX/C3o/r503fbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEAw9V9pEhQpC1rudTMbuBAMdFLDyYm9zP6+FISddSH1zpKdsNfNVhgpZkZOMBVZ9XkHuLo44Y8+uXdudUo7Z8k3uq+am0F4H47uuS1pWbfmCwXaMOBxcMDgMlZvZd1EgNplpPPGnwtLM9If5tSb3o9//4j5A8vjQGaha7sARLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=elRkxDAc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="elRkxDAc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBAPPw024356;
	Mon, 18 Aug 2025 16:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=R2J8minbyc0pri7w8vlrXNn+dDlIo5btiJgX6/Qc+
	BI=; b=elRkxDAcv9N989+xGVXLS3egVUzJQ7/e8sedaCJr9CrYksmBg3zaJvKxb
	MKRg5BXChyxkekTuC2M/dYxhbDErkZ9WYK4gGXNpzz2uPCA1QZ3/kVRKkex7mM17
	aBug5vRtQZ+4u3LcURZoEvfDhp7nOiQWFAevDLHb8PqOhKQiF5qInAO1RQkLyo7a
	7Y4ISJY9dNifok2X42ymz7ya7WWZ4tzaKXpLcZ5UuO0d3KRrIc9xDGkIpzbztmCu
	VYtdKPMvusItYTkfdPxCgof2+Bg5yqQnV4QJSZsz9Cjqz540LuWoqflyCs7q5iDu
	kgJtSgO0RyceMpSzZdxNDPtH8xvpQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge3t6xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57IGdGvN013935;
	Mon, 18 Aug 2025 16:39:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge3t6xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEnhPd014728;
	Mon, 18 Aug 2025 16:39:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k5tmpje6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:39:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57IGdDfu31851052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 16:39:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9893A20043;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DC2920040;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Aug 2025 16:39:13 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 40A66E05D2; Mon, 18 Aug 2025 18:39:13 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Daniel Axtens <dja@axtens.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/2] mm/kasan: fix vmalloc shadow memory population issues
Date: Mon, 18 Aug 2025 18:39:11 +0200
Message-ID: <cover.1755528662.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FcM3xI+6 c=1 sm=1 tr=0 ts=68a35734 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=njq2mmYMnVxNw-6NPcsA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: rdIg7Bn1EV5ou23bmQ4mIkst8l_YFpvM
X-Proofpoint-ORIG-GUID: 5LRYwOzw2RvagFJR-QQA6Mi1gd4gE_am
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMSBTYWx0ZWRfX5onC88oUqhQC
 H6CqLLxjSkAUfiIeGXxUzZmW5PLQk++823B6wyrqoe4HgPmhWNK2EOjUVWLk/TTapXScABqO+Jh
 rXRgSexP136YlBSgmB+kKvvRXejCprjmuR1XiP7JEv6M6ZL+2xzUn5bu7LbMaWzkX2abRJGlece
 HtTSuJ3j/VayB9lBqYPVaHFDuELwDJwwmJtJIrxwWPR29J8laq0lAGfjyLnxBVhUx6WITxS4r4T
 tHcMI1YSERl3rJfkKs6O/E9fg3RDykGV+KEe4Ff7w+kk56ZH1hCCoLoKdBWk0D9EcXe5kZ0CcVz
 4+3oZE+2dZ67MGMAYfPx+qWai042aU5mHpKE92tRYVEC53rUeRf5/1R0wGlXNvwIDvJ6Qej7QIl
 YclZM7WR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160011

Hi All,

While working on the lazy MMU mode enablement for s390 I hit pretty
curious issues in the kasan code.

The first is related to a custom kasan-based sanitizer aimed at catching
invalid accesses to PTEs and is inspired by [1] conversation. The kasan
complains on valid PTE accesses, while the shadow memory is reported as
unpoisoned:

[  102.783993] ==================================================================
[  102.784008] BUG: KASAN: out-of-bounds in set_pte_range+0x36c/0x390
[  102.784016] Read of size 8 at addr 0000780084cf9608 by task vmalloc_test/0/5542
[  102.784019] 
[  102.784040] CPU: 1 UID: 0 PID: 5542 Comm: vmalloc_test/0 Kdump: loaded Tainted: G           OE       6.16.0-gcc-ipte-kasan-11657-gb2d930c4950e #340 PREEMPT 
[  102.784047] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  102.784049] Hardware name: IBM 8561 T01 703 (LPAR)
[  102.784052] Call Trace:
[  102.784054]  [<00007fffe0147ac0>] dump_stack_lvl+0xe8/0x140 
[  102.784059]  [<00007fffe0112484>] print_address_description.constprop.0+0x34/0x2d0 
[  102.784066]  [<00007fffe011282c>] print_report+0x10c/0x1f8 
[  102.784071]  [<00007fffe090785a>] kasan_report+0xfa/0x220 
[  102.784078]  [<00007fffe01d3dec>] set_pte_range+0x36c/0x390 
[  102.784083]  [<00007fffe01d41c2>] leave_ipte_batch+0x3b2/0xb10 
[  102.784088]  [<00007fffe07d3650>] apply_to_pte_range+0x2f0/0x4e0 
[  102.784094]  [<00007fffe07e62e4>] apply_to_pmd_range+0x194/0x3e0 
[  102.784099]  [<00007fffe07e820e>] __apply_to_page_range+0x2fe/0x7a0 
[  102.784104]  [<00007fffe07e86d8>] apply_to_page_range+0x28/0x40 
[  102.784109]  [<00007fffe090a3ec>] __kasan_populate_vmalloc+0xec/0x310 
[  102.784114]  [<00007fffe090aa36>] kasan_populate_vmalloc+0x96/0x130 
[  102.784118]  [<00007fffe0833a04>] alloc_vmap_area+0x3d4/0xf30 
[  102.784123]  [<00007fffe083a8ba>] __get_vm_area_node+0x1aa/0x4c0 
[  102.784127]  [<00007fffe083c4f6>] __vmalloc_node_range_noprof+0x126/0x4e0 
[  102.784131]  [<00007fffe083c980>] __vmalloc_node_noprof+0xd0/0x110 
[  102.784135]  [<00007fffe083ca32>] vmalloc_noprof+0x32/0x40 
[  102.784139]  [<00007fff608aa336>] fix_size_alloc_test+0x66/0x150 [test_vmalloc] 
[  102.784147]  [<00007fff608aa710>] test_func+0x2f0/0x430 [test_vmalloc] 
[  102.784153]  [<00007fffe02841f8>] kthread+0x3f8/0x7a0 
[  102.784159]  [<00007fffe014d8b4>] __ret_from_fork+0xd4/0x7d0 
[  102.784164]  [<00007fffe299c00a>] ret_from_fork+0xa/0x30 
[  102.784173] no locks held by vmalloc_test/0/5542.
[  102.784176] 
[  102.784178] The buggy address belongs to the physical page:
[  102.784186] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x84cf9
[  102.784198] flags: 0x3ffff00000000000(node=0|zone=1|lastcpupid=0x1ffff)
[  102.784212] page_type: f2(table)
[  102.784225] raw: 3ffff00000000000 0000000000000000 0000000000000122 0000000000000000
[  102.784234] raw: 0000000000000000 0000000000000000 f200000000000001 0000000000000000
[  102.784248] page dumped because: kasan: bad access detected
[  102.784250] 
[  102.784252] Memory state around the buggy address:
[  102.784260]  0000780084cf9500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  102.784274]  0000780084cf9580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  102.784277] >0000780084cf9600: fd 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  102.784290]                          ^
[  102.784293]  0000780084cf9680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  102.784303]  0000780084cf9700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  102.784306] ==================================================================

The second issue hits when the custom sanitizer above is not implemented,
but the kasan itself is still active:

[ 1554.438028] Unable to handle kernel pointer dereference in virtual kernel address space
[ 1554.438065] Failing address: 001c0ff0066f0000 TEID: 001c0ff0066f0403
[ 1554.438076] Fault in home space mode while using kernel ASCE.
[ 1554.438103] AS:00000000059d400b R2:0000000ffec5c00b R3:00000000c6c9c007 S:0000000314470001 P:00000000d0ab413d 
[ 1554.438158] Oops: 0011 ilc:2 [#1]SMP 
[ 1554.438175] Modules linked in: test_vmalloc(E+) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) sunrpc(E) pkey_pckmo(E) uvdevice(E) s390_trng(E) rng_core(E) eadm_sch(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) drm(E) loop(E) i2c_core(E) drm_panel_orientation_quirks(E) nfnetlink(E) ctcm(E) fsm(E) zfcp(E) scsi_transport_fc(E) diag288_wdt(E) watchdog(E) ghash_s390(E) prng(E) aes_s390(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha512_s390(E) sha1_s390(E) sha_common(E) pkey(E) autofs4(E)
[ 1554.438319] Unloaded tainted modules: pkey_uv(E):1 hmac_s390(E):2
[ 1554.438354] CPU: 1 UID: 0 PID: 1715 Comm: vmalloc_test/0 Kdump: loaded Tainted: G            E       6.16.0-gcc-ipte-kasan-11657-gb2d930c4950e #350 PREEMPT 
[ 1554.438368] Tainted: [E]=UNSIGNED_MODULE
[ 1554.438374] Hardware name: IBM 8561 T01 703 (LPAR)
[ 1554.438381] Krnl PSW : 0704e00180000000 00007fffe1d3d6ae (memset+0x5e/0x98)
[ 1554.438396]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[ 1554.438409] Krnl GPRS: 0000000000000001 001c0ff0066f0000 001c0ff0066f0000 00000000000000f8
[ 1554.438418]            00000000000009fe 0000000000000009 0000000000000000 0000000000000002
[ 1554.438426]            0000000000005000 000078031ae655c8 00000feffdcf9f59 0000780258672a20
[ 1554.438433]            0000780243153500 00007f8033780000 00007fffe083a510 00007f7fee7cfa00
[ 1554.438452] Krnl Code: 00007fffe1d3d6a0: eb540008000c	srlg	%r5,%r4,8
           00007fffe1d3d6a6: b9020055		ltgr	%r5,%r5
          #00007fffe1d3d6aa: a784000b		brc	8,00007fffe1d3d6c0
          >00007fffe1d3d6ae: 42301000		stc	%r3,0(%r1)
           00007fffe1d3d6b2: d2fe10011000	mvc	1(255,%r1),0(%r1)
           00007fffe1d3d6b8: 41101100		la	%r1,256(%r1)
           00007fffe1d3d6bc: a757fff9		brctg	%r5,00007fffe1d3d6ae
           00007fffe1d3d6c0: 42301000		stc	%r3,0(%r1)
[ 1554.438539] Call Trace:
[ 1554.438545]  [<00007fffe1d3d6ae>] memset+0x5e/0x98 
[ 1554.438552] ([<00007fffe083a510>] remove_vm_area+0x220/0x400)
[ 1554.438562]  [<00007fffe083a9d6>] vfree.part.0+0x26/0x810 
[ 1554.438569]  [<00007fff6073bd50>] fix_align_alloc_test+0x50/0x90 [test_vmalloc] 
[ 1554.438583]  [<00007fff6073c73a>] test_func+0x46a/0x6c0 [test_vmalloc] 
[ 1554.438593]  [<00007fffe0283ac8>] kthread+0x3f8/0x7a0 
[ 1554.438603]  [<00007fffe014d8b4>] __ret_from_fork+0xd4/0x7d0 
[ 1554.438613]  [<00007fffe299ac0a>] ret_from_fork+0xa/0x30 
[ 1554.438622] INFO: lockdep is turned off.
[ 1554.438627] Last Breaking-Event-Address:
[ 1554.438632]  [<00007fffe1d3d65c>] memset+0xc/0x98
[ 1554.438644] Kernel panic - not syncing: Fatal exception: panic_on_oops

This series fixes the above issues and is a pre-requisite for the s390
lazy MMU mode implementation.

test_vmalloc was used to stress-test the fixes.

1. https://lore.kernel.org/linux-mm/5b0609c9-95ee-4e48-bb6d-98f57c5d2c31@arm.com/

Thanks!

Alexander Gordeev (2):
  mm/kasan: fix vmalloc shadow memory (de-)population races
  mm/kasan: avoid lazy MMU mode hazards

 mm/kasan/shadow.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.48.1

