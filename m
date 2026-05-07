Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA854654;
	Thu,  7 May 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150544; cv=none; b=AvjfVmjfTyHWUxyLyDx0xajnmGfs1KbesLZh+nYPaOMUwTmVHA6qArtrKaQ9XkI2PwOoMMVnSSNJNbHaI6B5UIJS3zSwBJ1OeS1CCafRxp53QqqHEoBjQcyL3j8V26O+dyTZBk/g0LgAEk5lk26LLhDbtmliy7na4oUXOkJh0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150544; c=relaxed/simple;
	bh=kJUMUZiBpvzagROkm05lz/r80RFHagofkUXqUC2rXUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WyZl7JKsIApQZ4iT0v9WLSAxIsRdvI34QzBkX+n3ukTyRx5ixD/OKT7oM2T2dPQfREdFJrznMMAckF7QEMYqWYc+rxTO6DmlY20HCYavX87d558UjzAeFPf8OuHCErPOYtsM0jT0o9UtfSlFR/0gT6cUfhsmaVoY2sEnjl+LOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JcyXVY+f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JcyXVY+f"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MgfDG2100626;
	Thu, 7 May 2026 10:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=JhCZHZvwCHP6ls2tfZAQWZt6By9iu9il76xwr5ouOR4=; b=JcyXVY+f
	81uqAFG3prNTsj1nV/fx2McqdUR+BHWxmt7yo68IoE2Ok+EXUhShm9qdBV7aiAL0
	RuiB5h+zC6tCTemzosDm2CKBq7sF5DRJBS+5ck+Ihv9pnJRa7Ny/gCn52Wzd+X5n
	ESEDGtmqVqhf+QQF+LhvUqsTmSNh7zUGG2wwYUX/9L41sYtAe1XEFXPmxoeBn8Zk
	zgL+Pry9Xkon3AIpjoKOfTkVP6WEKFZp/PybrE1VbUgAot/qeE0q9drX8HxFzu+N
	8QBnMxBytofMv58t1kvDd3txX28hKmhi5c09/E6GnC1tqHB28jj4DBkCGSsZvgfb
	5itJjBqc12bz6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4wm57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:42:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647A9XWu027857;
	Thu, 7 May 2026 10:41:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3haqfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:41:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647Afund48824784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 10:41:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F088A2004B;
	Thu,  7 May 2026 10:41:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E858820043;
	Thu,  7 May 2026 10:41:54 +0000 (GMT)
Received: from localhost (unknown [9.111.2.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 10:41:54 +0000 (GMT)
Date: Thu, 7 May 2026 12:41:53 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        John Stultz <jstultz@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] sched/core: Fix proxy-exec/core-sched interactions
Message-ID: <c00-02.v2.ttenwd4@ub.hpns>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwNSBTYWx0ZWRfX8xufrn6tzlP7
 XaUX9hB4FPFSDJ0Yu2lIRCbQRoMBnFiCqvV7tSjqdD2ZqbSdMHDZuijc7Xhoyty2zDzhLE9OcIt
 8CfJbli81zyEVD0fzKLg7fXXVNuh7iWDHKSMJYtvkGHe0s0ibHsqj9rpGKTzff+E0udq0W/At/M
 mTRWdByL/WTjKivI0fbKld4hj3J16J65Uv87myI+YnVRWAnMGkymtxhV0bshYYVBM1RqETN5Svr
 Ce+DuRuxDKdsvlVWe0W0tVxtKC54GTelSrHTHVGNvVLopjQtucP26/Ku27P2QOlz3U7f0Esnu5Q
 5IlGiymLeFvvA8H4uFurv2omOBDdytLDF8u8QV/uSEYqJBvX4cm/J6lQYSwNEjw6bJSAUpzQZw9
 ewSQ2LCNgqGk5Fy4nsLDh2aR9fwfr27fnIPjfy4Bqx1WQXQHUM08aAtAZ188KJxPG9yKXcUlliq
 A/kP7W2mYXPIuZn7qEw==
X-Proofpoint-ORIG-GUID: cALCtpedMx_LxvQOX912QXhZbDLoCcI6
X-Proofpoint-GUID: tIqeH9rfTCDy5i30OgLi0ZzomEY0a9bi
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fc6c79 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=pOT9IFjXwo1vt1gKBJoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070105

v1 [1] consisted of a fix for a scheduler corruption where
try_steal_cookie() could migrate a proxy-exec donor away from the source
rq while that rq still used it as the active scheduling context.

Prateek pointed out [2] a separate proxy-exec/core-sched issue: after
pick_next_task() selects a core cookie compatible donor, find_proxy_task()
can replace the execution context with a mutex owner with a different
cookie.

This v2 keeps the donor steal fix as patch 1 and adds patch 2 to reject
mismatched final proxy owners.

The v1 reported the issue reproduced on s390 LPAR, but it seems to be
easily reproducible with strace test suite "make -j$(nproc) check" on
any system with SMT, CONFIG_SCHED_CORE=y and CONFIG_SCHED_PROXY_EXEC=y
enabled, e.g. on x86 KVM with -smp cpus=16,sockets=1,cores=8,threads=2:

[  283.181298] WARNING: kernel/sched/fair.c:5788 at put_prev_entity+0x4f/0x90, CPU#2: unshare-report-/27895
[  283.185230] Modules linked in:
[  283.186480] CPU: 2 UID: 0 PID: 27895 Comm: unshare-report- Not tainted 7.1.0-rc2-00076-g74fe02ce122a #26 PREEMPT(full)
[  283.190699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[  283.194482] RIP: 0010:put_prev_entity+0x4f/0x90
[  283.196591] Code: fd ff ff 80 7b 58 00 74 e0 66 90 48 89 de 48 89 ef e8 85 a9 ff ff 31 d2 48 89 de 48 89 ef e8 d8 d6 ff ff 48 39 5d 58 74 c6 90 <0f> 0b 90 48 c7 45 58 00 00 00 00 5b 5d e9 7f cb 31 01 48 83 bb b8
[  283.205157] RSP: 0018:ffffc90009177af0 EFLAGS: 00010006
[  283.207443] RAX: 0000000000000000 RBX: ffff888102de8080 RCX: 000000000004f800
[  283.210442] RDX: 0000000000000000 RSI: 0000000000027c00 RDI: 00000041dd7d5860
[  283.213528] RBP: ffff888116cb2200 R08: ffff888116fe8080 R09: 0000000000000002
[  283.216766] R10: 0000000005bf08d6 R11: 00000000000002b7 R12: ffff8881192da4a0
[  283.219872] R13: ffff88813a3ec801 R14: 0000000000000001 R15: ffff88813a3ec800
[  283.222777] FS:  00007f6b5ca21780(0000) GS:ffff8881b628c000(0000) knlGS:0000000000000000
[  283.226171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  283.228493] CR2: 000000001319e358 CR3: 000000001f322000 CR4: 00000000000006f0
[  283.231951] Call Trace:
[  283.233137]  <TASK>
[  283.234066]  put_prev_task_fair+0x1d/0x40
[  283.235943]  __schedule+0x1165/0x28d0
[  283.237599]  ? __resched_curr+0x372/0x3a0
[  283.239413]  ? detach_task+0xc1/0xd0
[  283.241015]  ? lockdep_hardirqs_on_prepare+0xd7/0x190
[  283.243170]  ? trace_hardirqs_on+0x18/0x100
[  283.244852]  preempt_schedule+0x2e/0x50
[  283.246707]  preempt_schedule_thunk+0x16/0x30
[  283.248680]  ? _raw_spin_unlock_irqrestore+0x3f/0x50
[  283.251012]  __mutex_unlock_slowpath+0x2d9/0x3d0
[  283.253196]  pcpu_alloc_noprof+0x3e6/0xbd0
[  283.255187]  alloc_vfsmnt+0xd7/0x1e0
[  283.256651]  clone_mnt+0x1e/0x280
[  283.258061]  copy_tree+0x127/0x420
[  283.259449]  copy_mnt_ns+0x13f/0x520
[  283.260926]  create_new_namespaces+0x54/0x2e0
[  283.262974]  unshare_nsproxy_namespaces+0x7e/0xb0
[  283.265317]  ksys_unshare+0x196/0x550
[  283.267097]  __x64_sys_unshare+0xd/0x20
[  283.268876]  do_syscall_64+0xf3/0x6a0
[  283.270611]  ? exc_page_fault+0xfa/0x240
[  283.272329]  ? __irq_exit_rcu+0x3c/0x100
[  283.274006]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  283.276085] RIP: 0033:0x7f6b5cb1730d
[  283.277509] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 5a 0f 00 f7 d8 64 89 01 48
[  283.285484] RSP: 002b:00007ffef4e305d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
[  283.288741] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f6b5cb1730d
[  283.291711] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000020000
[  283.294664] RBP: 0000000000000000 R08: 0000000000000000 R09: 3230345b3a737475
[  283.298149] R10: 000000000000eefe R11: 0000000000000246 R12: 00000000000000f0
[  283.301268] R13: 0000000000000001 R14: 00007f6b5cd53000 R15: 0000000000404df0
[  283.304570]  </TASK>
[  283.305583] irq event stamp: 2018
[  283.307085] hardirqs last  enabled at (2017): [<ffffffff8269777f>] _raw_spin_unlock_irqrestore+0x3f/0x50
[  283.311026] hardirqs last disabled at (2018): [<ffffffff82689aff>] __schedule+0x13df/0x28d0
[  283.314726] softirqs last  enabled at (2008): [<ffffffff81324f40>] __irq_exit_rcu+0xc0/0x100
[  283.318427] softirqs last disabled at (2001): [<ffffffff81324f40>] __irq_exit_rcu+0xc0/0x100
[  283.321920] ---[ end trace 0000000000000000 ]---
[  283.323878] BUG: kernel NULL pointer dereference, address: 0000000000000059
[  283.326033] #PF: supervisor read access in kernel mode
[  283.327357] #PF: error_code(0x0000) - not-present page
[  283.328698] PGD 800000000a8c5067 P4D 800000000a8c5067 PUD 12879067 PMD 0
[  283.329491] Oops: Oops: 0000 [#1] SMP PTI
[  283.329796] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Tainted: G        W           7.1.0-rc2-00076-g74fe02ce122a #26 PREEMPT(full)
[  283.331183] Tainted: [W]=WARN
[  283.331468] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[  283.332346] RIP: 0010:pick_task_fair+0x2d/0xb0
[  283.332735] Code: fa 8b 97 10 01 00 00 85 d2 0f 84 92 00 00 00 53 48 89 fb 48 83 ec 08 48 8d bb 00 01 00 00 eb 21 be 01 00 00 00 e8 13 8b ff ff <80> 78 59 00 75 3d 48 85 c0 74 48 48 8b b8 b8 00 00 00 48 85 ff 74
[  283.334364] RSP: 0018:ffffc900000b7e20 EFLAGS: 00010086
[  283.334992] RAX: 0000000000000000 RBX: ffff88813a5ec800 RCX: 041dd83271100000
[  283.335731] RDX: 0000000000000000 RSI: 0000000000200000 RDI: ffff888116cb2200
[  283.336404] RBP: ffffc900000b7f20 R08: 041dd83271100000 R09: 0000000000200000
[  283.337852] R10: 00000005252d41b2 R11: 0000000000000001 R12: 0000000000000002
[  283.338802] R13: ffff888025c18000 R14: 0000000000000003 R15: ffffffff84160800
[  283.339827] FS:  0000000000000000(0000) GS:ffff8881b628c000(0000) knlGS:0000000000000000
[  283.341158] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  283.342502] CR2: 0000000000000059 CR3: 000000001f322000 CR4: 00000000000006f0
[  283.345455] Call Trace:
[  283.347033]  <TASK>
[  283.348350]  __schedule+0xc65/0x28d0
[  283.349703]  ? tick_nohz_idle_exit+0x66/0x160
[  283.350882]  ? do_idle+0x17c/0x2b0
[  283.351454]  schedule_idle+0x1d/0x40
[  283.352017]  cpu_startup_entry+0x24/0x30
[  283.352594]  start_secondary+0xf8/0x100
[  283.353272]  common_startup_64+0x13e/0x148
[  283.353840]  </TASK>

Tested with strace test suite as well as hackbench and stress-ng on s390 and x86.

v1-v2:
- added a fix to prevent proxy-exec of unmatched cookie lock owners

[1] https://lore.kernel.org/all/c00-01.ttedd70@ub.hpns/
[2] https://lore.kernel.org/all/10282ce9-f4ae-498f-9b57-f4e1e61fffbc@amd.com/

Vasily Gorbik (2):
  sched/core: Don't steal a proxy-exec donor
  sched/core: Don't proxy-exec unmatched cookie lock owners

 kernel/sched/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.53.0
