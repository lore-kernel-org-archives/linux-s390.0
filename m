Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C87438017;
	Thu, 13 Aug 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605958; cv=none; b=A9+JBZ3OxLkvIZeR/SoJg+p2j7j/fo4j4Qx9+jlVNWscrbAihDEZTPEnDOYoBOU+CajcAWs+fiYNjKLaDAnnSMZr4Illrs8P/oH4XuiPBcP9HM1nIuIfHX/CzQry5uqn58LmEAoSx7A44uFs4DwJpEqcZRq7Q7ikojKLc7sS5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605958; c=relaxed/simple;
	bh=0WxHWJLAuilOYV2/LW0sMoSOR0K7QIaoMvozOaopVNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKKeCc2EANWjklHzMnf3xM5P0zIinrf34Hw1WqwVD1PqBUzBqm/UUp8xPIqe+UkzDD7i0xJ0bjz/f/kOfCqCF9TVOtLz56N5z3iYtl5wOher6+mgh3ls71mMKxhGid3qyJPyV3sw3E9XW+4iYoqNSVgZEsf0GWQ7wW6sGE+SuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rF7Q9+aN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rF7Q9+aN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D6277h423076;
	Thu, 13 Aug 2026 07:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uRGNDW
	hr24TimW4oK5YLFACtLl2ev7T7RWig2O9sl8s=; b=rF7Q9+aNEYfUNGW3CmRqCX
	/W15JXvVtHm+rnfeBOn8uaurWG75bK2XdkVxRmwzIdrBTthB1HHFa6KF1+wSU8UW
	XHCF0qoli+TyLjk8ITDAynNKKRJB2lDndThbvJm09vtcn7efBAeGdsj4z8JJgZW6
	OscPQApmnwa0nrUy1iPMqVr8eWvRBnPnw487nN+8Y4kBLu431gFjRKEX0Ma8Msls
	KddFTZzrvKZk68+ynf4Jy9xAVtcy1f6Z0EcQt6ji3LtEMPeZQVR1sYxiECZBsazZ
	j3m1jIoU5TLFTbB3qhrleCmsbPjozxGNwHPD70peP9GMz9ejnR2MXyVfEpRgcXrg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23y5rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:25:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D6uSiN016615;
	Thu, 13 Aug 2026 07:25:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy9tx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:25:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D7PZpi24314540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:25:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5375758043;
	Thu, 13 Aug 2026 07:25:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96A465805E;
	Thu, 13 Aug 2026 07:25:28 +0000 (GMT)
Received: from [9.124.209.227] (unknown [9.124.209.227])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 07:25:28 +0000 (GMT)
Message-ID: <c03c979f-825e-4600-9aa1-38fc1036c013@linux.ibm.com>
Date: Thu, 13 Aug 2026 12:55:27 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: net/smc: fix clcsock and lgr/lnk races in
 smc_diag dump path
To: syzbot ci <syzbot+cia7ddf4f17dfab266@syzkaller.appspotmail.com>,
        alibuda@linux.alibaba.com, andrew@lunn.ch, davem@davemloft.net,
        dust.li@linux.alibaba.com, edumazet@google.com,
        guwen@linux.alibaba.com, horms@kernel.org, kuba@kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        pasic@linux.ibm.com, sidraya@linux.ibm.com, tonylu@linux.alibaba.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <6a75f37d.b50370da.49fe0.001c.GAE@google.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <6a75f37d.b50370da.49fe0.001c.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7d7172 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-ibLmwfWAAAA:8 a=Oh2cFVv5AAAA:8 a=-ztMTYQJyvQxDNS25zoA:9
 a=QEXdDO2ut3YA:10 a=A6MkUVyZPcTV1i89ro0M:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA0NyBTYWx0ZWRfX3LFa1D9Pk+Ut
 pKIP6OwpSXztx78uzh34BKc15FKpJ2Rsy3bJ+PNORjJFh8Yxo6CXqJSKLFppIX82ZXKSMLhiwTf
 WacmJH+m11f36DPDBd2Y9gHS5J2i/lwB1ui6OBXBrp2j3RYven83t71nOxU0sLo/lr5rOgMpXkk
 vo3sE3f2f3O8gYLxfHUw9XNC4SZrgLPPWmMzoru8yLSjXYoDRvABQXdVDttrszkmuNqrpDv19CU
 sWfYMwGhOooudl17XlG+paseSSY2d2M1WH9TpHsuUPvnF2WarnNQZWObBo5hpV6E5sB1N9e7/fd
 /nOwUHmf3CDf7QW0w37Xmxxi54jBVoPTMrb054LIu5SIZv7qcaDREO5C87lu3dpoIpAdVx70vDs
 UvgvqUBRkIyNQm2OIXoudlr5yxRMflyI0lKXR48yAVoCWTrq+dzJlUeCCqBm1lTLb5HjOmO/86x
 GMEgudyOy4oiwshSbyg==
X-Proofpoint-ORIG-GUID: ecrSSeiCrI6JpB4BjMy1hoDZ5x7Qi3vg
X-Proofpoint-GUID: 1l0aA0Et_vxTxcQjSMcc8oFukKNMbVaj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA0NyBTYWx0ZWRfX1prPcklBKVuX
 NQ7Eu2QIjqicjHYBPxqWZG1Fwdi0cpf/ce34ZpU600XdlqOsir1c3c3bMWNX4+UmR61khlOcLcq
 w3vlqorggATD2VN69DCZp0HM78zpjTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130047

On 07/08/26 8:32 pm, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v3] net/smc: fix clcsock and lgr/lnk races in smc_diag dump path
> https://lore.kernel.org/all/20260807081606.3200128-1-mjambigi@linux.ibm.com
> * [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag dump path
> 
> and found the following issue:
> WARNING in smc_diag_dump_proto
> 
> Full report is available here:
> https://ci.syzbot.org/series/ab0d12fd-741a-4a0f-9f49-e52b84e94f4a
> 
> ***
> 
> WARNING in smc_diag_dump_proto
> 
> tree:      net
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
> base:      594d905195024b228c962627ae5ae7c17bd582a4
> arch:      amd64
> compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> config:    https://ci.syzbot.org/builds/0c4d246f-d098-4afe-b6bc-0f0ad52f55f8/config
> syz repro: https://ci.syzbot.org/findings/fa5564b8-8db6-4f76-9d75-dbd796435d87/syz_repro
> 
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#0: syz.0.161/6326
> WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x12d8/0x1550 kernel/locking/mutex.c:821, CPU#0: syz.0.161/6326

I have fixed this syzbot issue by submitting a separate fix. I also
tested the fix by submitting the patch to syzbot & after that this issue
is not seen anymore. One can see the test details with a fixed patch in
below link. I'll send that patch separately to netdev shortly.

https://ci.syzbot.org/series/ab0d12fd-741a-4a0f-9f49-e52b84e94f4a

> Modules linked in:
> CPU: 0 UID: 0 PID: 6326 Comm: syz.0.161 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
> RIP: 0010:__mutex_lock+0x12df/0x1550 kernel/locking/mutex.c:821
> Code: de 57 90 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 47 02 00 00 83 3d 45 cc 83 04 00 75 13 48 8d 3d a8 1b 87 04 48 c7 c6 40 f7 ec 8b <67> 48 0f b9 3a 90 e9 75 ee ff ff 90 0f 0b 90 e9 48 f2 ff ff 90 0f
> RSP: 0018:ffffc900068c6e40 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff888170ffd940
> RDX: 0000000000000000 RSI: ffffffff8becf740 RDI: ffffffff905b2db0
> RBP: ffffc900068c6fd0 R08: ffffffff9057de43 R09: 1ffffffff20afbc8
> R10: dffffc0000000000 R11: fffffbfff20afbc9 R12: ffff8881b1006648
> R13: 0000000000000000 R14: 1ffff92000d18ddc R15: 0000000000000000
> FS:  00007f4dacd826c0(0000) GS:ffff88818d945000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000020000000e000 CR3: 0000000171350000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  smc_diag_msg_common_fill net/smc/smc_diag.c:50 [inline]
>  __smc_diag_dump net/smc/smc_diag.c:101 [inline]
>  smc_diag_dump_proto+0x6d2/0x2620 net/smc/smc_diag.c:255
>  smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:278
>  netlink_dump+0x711/0xee0 net/netlink/af_netlink.c:2331
>  __netlink_dump_start+0x589/0x7b0 net/netlink/af_netlink.c:2446
>  netlink_dump_start include/linux/netlink.h:341 [inline]
>  smc_diag_handler_dump+0x199/0x240 net/smc/smc_diag.c:293
>  sock_diag_rcv_msg+0x4b0/0x5f0 net/core/sock_diag.c:-1
>  netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
>  sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
>  __sock_sendmsg net/socket.c:790 [inline]
>  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
>  __sys_sendmsg net/socket.c:2770 [inline]
>  __do_sys_sendmsg net/socket.c:2775 [inline]
>  __se_sys_sendmsg net/socket.c:2773 [inline]
>  __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4dabf9e019
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4dacd82028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f4dac226090 RCX: 00007f4dabf9e019
> RDX: 0000000000000600 RSI: 0000200000000540 RDI: 0000000000000003
> RBP: 00007f4dac03500c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f4dac226128 R14: 00007f4dac226090 R15: 00007ffe0de8ec98
