Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DFC120
	for <linux-s390@vger.kernel.org>; Mon, 12 May 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059499; cv=none; b=qPcOBmBHEykhg2HamSiCeGq6JqeeCBem7A0L3lgCvKbi4PgLyF/5iz8aTUU0P+OjiVaIh1OQw/5cheSfpiO9ewqV31wc4HvKvUIZae346jEM3GV80n6SoxfrVg9WB3fVkK1udxTRpKu0GScL9HcWRZzWJjL3G3uGd3myBti+ZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059499; c=relaxed/simple;
	bh=gGz9qz95CAGBsr3zXCYemdGZa3RyusigLisUKVH+dj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=djiSy+1VaYBG6lTOFxGlAqCRG5RL7HLeHN6X2LQwxQvZw0G4HU4zMwjxj8crPfGzJNe/bspi2RyUeWf52RIAoENmzAy4RAQg7X2YdKmA2j4Unx4zSZw3cbqid30B1FXeCvkcK00h6E+lSouEkJqOC7LnleYp2YEpjcODs7wGf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KR/IpJa+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KR/IpJa+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CAmfhb017610;
	Mon, 12 May 2025 14:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=MzfoLYf5XvPQl8k76ug7gZcpRfpWRKaH0Jh1tObU0Vg=; b=KR/IpJa+
	HgG7B/BV67YcCClkhwkSaW09pTxoP4hVrW9uXN5Z2PEcITYEzRk7wM2zZFI5u6Hk
	QuKFZR0OoDEpc9VmWVFXMN0zF5G47Nm4RRHiG8E/Sgshnb9jgD+pnGzWRbO4a+6L
	sswmflzfcggSe218YaQY4I1/XndybIDjAC2JbSNMenfns+EI53LKY2z4etUKxtbZ
	KlBw/spB3RQQqANAkhsLfGJfpo3f/3lEs1OJb1/4ZQZP4SaiqFhqbxQsq0nDXlZ8
	TGyn1ZuCgPKmsjL7V8dK9ZP1EUFsc0zROKedOpUSptWHNOPnZ5s7yqbdNOx6ATT0
	eHYyGl0X+upC2g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1k6ks38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:18:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CDvNlO027750;
	Mon, 12 May 2025 14:18:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1k6ks36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:18:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CD0qn7016919;
	Mon, 12 May 2025 14:18:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jhgyxf0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:18:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CEI8ca51446168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 14:18:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3D38200E1;
	Mon, 12 May 2025 14:18:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CD2200E4;
	Mon, 12 May 2025 14:18:07 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.111.69.243])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 May 2025 14:18:07 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: page type is 0, migratetype passed is 2 (nr=256)
Date: Mon, 12 May 2025 16:18:06 +0200
Message-ID: <87wmalyktd.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=68220323 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=I2MZz-Ba5tQky3FxEv8A:9
X-Proofpoint-GUID: RD_gR2uEW5xxcpj1kXqcQqPIKWCgQp4m
X-Proofpoint-ORIG-GUID: iB5hfnbfJp3zx9M4jTo2CIM0aNypsKDE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NyBTYWx0ZWRfX3CvQqUDoF/Y3 i8fM6vcS7EJmCbwjHlvemNW5P1Af3y2fz72pQO7vt5YDdf0lhM6wxXvIZeFmcvV5Z0BCTc/4jrn q6AluP+YCZzwN182WMBDM0opEz41E6i7CsKMUPKpUeDcU3L2VKxJAPgXasu4Lbn0FQ3/073ffgm
 h5ed7RXgdyms0GKLHBXjRwpRjX4L9s3Ts1qLourx7er9LlkinQMcHoG1mpDVNEGy5Dweg/RSKjq 9USUP/D9bK53LVhAvZ2obwTpXo0mHTyPBTgar2qHiB3HCyfYGyCtfYJ0/68ljYF1Yv6rZkRheIU 2veW0WXa9+VTjS9Jksq5ikG+GOD0u5Ar8abckLQl87VDDvf3PrCWAw2In5/DSW4vLSsiVRWczFt
 ULQsK54tYeou8tlGE6CzcFl5YMUloBiVs8hn2cyZLQ6lX+td0g3Ce4E6t4sDnET4ObiVjvKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120147

Hi all,

In a QEMU/KVM guest with 2 vCPUs, when running a test that
enables/disables a vCPU by writing 0 and 1 to the sysfs
`/sys/devices/system/cpu/cpu1/online` in a endless loop and doing some
`dd` operations (block size of 1MB) in the guest in parallel, I
sometimes see the kernel warning:

"page type is 0, migratetype passed is 2 (nr=256)"

The first time this happened was after the warning was added with commit
e0932b6c1f94 (mm: page_alloc: consolidate free page accounting").

Below is a "beautified" (via `decode_stacktrace.sh`) kernel stack trace
(note: it's a self-compiled kernel using the debug config + Linux
v6.15-rc5 + an unrelated patch on top):

```
[   31.079925] page type is 0, passed migratetype is 2 (nr=256)
[   31.079967] WARNING: CPU: 0 PID: 512 at mm/page_alloc.c:668 expand (mm/page_alloc.c:668 (discriminator 2) mm/page_alloc.c:1576 (discriminator 2))
[   31.079974] Modules linked in: essiv authenc dm_crypt encrypted_keys loop pkey_pckmo pkey diag288_wdt watchdog rng_core ghash_s390 prng aes_s390 des_s390 libdes vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock virtio_console vfio_ccw mdev vfio_iommu_type1 sha512_s390 sha256_s390 vfio sha1_s390 sha_common sch_fq_codel drm i2c_core drm_panel_orientation_quirks nfnetlink autofs4 ecdsa_generic ecc
[   31.080051] Hardware name: IBM 2964 NC9 702 (KVM/Linux)
[   31.080055] Krnl PSW : 0404f00180000000 000003339b22f52c expand (mm/page_alloc.c:668 (discriminator 10) mm/page_alloc.c:1576 (discriminator 10))
[   31.080064]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
[   31.080071] Krnl GPRS: 0000033380000004 0000000000000005 0000000000000030 00000333ffffffff
[   31.080075]            0000000000000005 0000033380000005 0000000000000100 0000000000000008
[   31.080080]            000003339cf5e290 00000229260c99d8 ffffffff00000008 000002a8827cc000
[   31.080084]            000003ffb7d50b58 0000000000000008 000003339b22f528 000002b39be17240
[ 31.080095] Krnl Code: 000003339b22f51c: c02000936173 larl %r2,000003339c49b802

Code starting with the faulting instruction
===========================================
[   31.080095]            000003339b22f522: c0e5ffe40e37        brasl   %r14,000003339aeb1190
[   31.080095]           #000003339b22f528: af000000            mc      0,0
[   31.080095]           >000003339b22f52c: a7f4ff49            brc     15,000003339b22f3be
[   31.080095]            000003339b22f530: b904002b            lgr     %r2,%r11
[   31.080095]            000003339b22f534: c03000933a81        larl    %r3,000003339c496a36
[   31.080095]            000003339b22f53a: c0e5fffdaad3        brasl   %r14,000003339b1e4ae0
[   31.080095]            000003339b22f540: af000000            mc      0,0
[   31.080123] Call Trace:
[   31.080126] expand (mm/page_alloc.c:668 (discriminator 10) mm/page_alloc.c:1576 (discriminator 10))
[   31.080132] expand (mm/page_alloc.c:668 (discriminator 2) mm/page_alloc.c:1576 (discriminator 2))
[   31.080137] rmqueue_bulk (mm/page_alloc.c:646 mm/page_alloc.c:1592 mm/page_alloc.c:1762 mm/page_alloc.c:2315 mm/page_alloc.c:2368)
[   31.080142] __rmqueue_pcplist (mm/page_alloc.c:3090)
[   31.080147] rmqueue.isra.0 (mm/page_alloc.c:3128 mm/page_alloc.c:3159)
[   31.080153] get_page_from_freelist (mm/page_alloc.c:3687)
[   31.080158] __alloc_frozen_pages_noprof (mm/page_alloc.c:4971 (discriminator 1))
[   31.080164] alloc_pages_mpol (mm/mempolicy.c:2303 (discriminator 1))
[   31.080170] alloc_frozen_pages_noprof (mm/mempolicy.c:2374)
[   31.080176] allocate_slab (mm/slub.c:2454 mm/slub.c:2618)
[   31.080182] ___slab_alloc (mm/slub.c:2672 mm/slub.c:3858)
[   31.080187] __slab_alloc.isra.0 (mm/slub.c:3948)
[   31.080193] kmem_cache_alloc_noprof (mm/slub.c:4023 mm/slub.c:4184 mm/slub.c:4203)
[   31.080199] alloc_buffer_head (fs/buffer.c:3033)
[   31.080204] folio_alloc_buffers (fs/buffer.c:938)
[   31.080212] create_empty_buffers (fs/buffer.c:1697)
[   31.080217] __block_write_begin_int (./include/linux/pagemap.h:1025 fs/buffer.c:2134)
[   31.080222] iomap_write_begin (fs/iomap/buffered-io.c:825)
[   31.080228] iomap_write_iter (fs/iomap/buffered-io.c:952)
[   31.080234] iomap_file_buffered_write (fs/iomap/buffered-io.c:1033 (discriminator 1))
[   31.080240] blkdev_write_iter (block/fops.c:690 block/fops.c:755)
[   31.080246] vfs_write (fs/read_write.c:592 (discriminator 1) fs/read_write.c:684 (discriminator 1) fs/read_write.c:664
 (discriminator 1))
[   31.080251] ksys_write (fs/read_write.c:737)
[   31.080257] __do_syscall (arch/s390/kernel/syscall.c:125 (discriminator 2))
[   31.080262] system_call (arch/s390/kernel/entry.S:263)
[   31.080268] INFO: lockdep is turned off.
[   31.080272] Last Breaking-Event-Address:
[   31.080275] __s390_indirect_jump_r14 (arch/s390/lib/expoline.S:12)
[   31.080284] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   31.080294] Hardware name: IBM 2964 NC9 702 (KVM/Linux)
[   31.080297] Call Trace:
[   31.080300] dump_stack_lvl (lib/dump_stack.c:122)
[   31.080305] panic (kernel/panic.c:372)
[   31.080310] check_panic_on_warn (kernel/panic.c:247)
[   31.080315] __warn (kernel/panic.c:751)
[   31.080321] report_bug (lib/bug.c:176 lib/bug.c:215)
[   31.080327] monitor_event_exception (arch/s390/kernel/traps.c:227 (discriminator 1))
[   31.080333] __do_pgm_check (./arch/s390/include/asm/irqflags.h:48 (discriminator 1) ./arch/s390/include/asm/irqflags.h:86 (discriminator 1) arch/s390/kernel/traps.c:347 (discriminator 1))
[   31.080338] pgm_check_handler (arch/s390/kernel/entry.S:334)
[   31.080344] expand (mm/page_alloc.c:668 (discriminator 10) mm/page_alloc.c:1576 (discriminator 10))
[   31.080349] expand (mm/page_alloc.c:668 (discriminator 2) mm/page_alloc.c:1576 (discriminator 2))
[   31.080353] rmqueue_bulk (mm/page_alloc.c:646 mm/page_alloc.c:1592 mm/page_alloc.c:1762 mm/page_alloc.c:2315 mm/page_a
lloc.c:2368)
[   31.080359] __rmqueue_pcplist (mm/page_alloc.c:3090)
[   31.080364] rmqueue.isra.0 (mm/page_alloc.c:3128 mm/page_alloc.c:3159)
[   31.080369] get_page_from_freelist (mm/page_alloc.c:3687)
[   31.080374] __alloc_frozen_pages_noprof (mm/page_alloc.c:4971 (discriminator 1))
[   31.080380] alloc_pages_mpol (mm/mempolicy.c:2303 (discriminator 1))
[   31.080385] alloc_frozen_pages_noprof (mm/mempolicy.c:2374)
[   31.080390] allocate_slab (mm/slub.c:2454 mm/slub.c:2618)
[   31.080396] ___slab_alloc (mm/slub.c:2672 mm/slub.c:3858)
[   31.080401] __slab_alloc.isra.0 (mm/slub.c:3948)
[   31.080407] kmem_cache_alloc_noprof (mm/slub.c:4023 mm/slub.c:4184 mm/slub.c:4203)
[   31.080412] alloc_buffer_head (fs/buffer.c:3033)
[   31.080417] folio_alloc_buffers (fs/buffer.c:938)
[   31.080422] create_empty_buffers (fs/buffer.c:1697)
[   31.080427] __block_write_begin_int (./include/linux/pagemap.h:1025 fs/buffer.c:2134)
[   31.080433] iomap_write_begin (fs/iomap/buffered-io.c:825)
[   31.080438] iomap_write_iter (fs/iomap/buffered-io.c:952)
[   31.080444] iomap_file_buffered_write (fs/iomap/buffered-io.c:1033 (discriminator 1))
[   31.080449] blkdev_write_iter (block/fops.c:690 block/fops.c:755)
[   31.080455] vfs_write (fs/read_write.c:592 (discriminator 1) fs/read_write.c:684 (discriminator 1) fs/read_write.c:664
 (discriminator 1))
[   31.080460] ksys_write (fs/read_write.c:737)
[   31.080465] __do_syscall (arch/s390/kernel/syscall.c:125 (discriminator 2))
[   31.080470] system_call (arch/s390/kernel/entry.S:263)
[   31.080476] INFO: lockdep is turned off.
```

Any ideas?

--
Thanks in advance,

 Marc
