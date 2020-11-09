Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729694AbgKIHxF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 02:53:05 -0500
Subject: Re: [PATCH net 1/2] net/af_iucv: fix null pointer dereference on
 shutdown
References: <20201106125008.36478-1-jwi@linux.ibm.com>
 <20201106125008.36478-2-jwi@linux.ibm.com>
 <20201106085928.183e0c77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <b25101c7-e08d-81b2-a2da-99dfa476f66c@linux.ibm.com>
Date: Mon, 9 Nov 2020 09:52:48 +0200
MIME-Version: 1.0
In-Reply-To: <20201106085928.183e0c77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On 06.11.20 18:59, Jakub Kicinski wrote:
> On Fri,  6 Nov 2020 13:50:07 +0100 Julian Wiedmann wrote:
>> From: Ursula Braun <ubraun@linux.ibm.com>
>>
>> syzbot reported the following KASAN finding:
>>
>> BUG: KASAN: nullptr-dereference in iucv_send_ctrl+0x390/0x3f0 net/iucv/af_iucv.c:385
>> Read of size 2 at addr 000000000000021e by task syz-executor907/519
>>
>> CPU: 0 PID: 519 Comm: syz-executor907 Not tainted 5.9.0-syzkaller-07043-gbcf9877ad213 #0
>> Hardware name: IBM 3906 M04 701 (KVM/Linux)
>> Call Trace:
>>  [<00000000c576af60>] unwind_start arch/s390/include/asm/unwind.h:65 [inline]
>>  [<00000000c576af60>] show_stack+0x180/0x228 arch/s390/kernel/dumpstack.c:135
>>  [<00000000c9dcd1f8>] __dump_stack lib/dump_stack.c:77 [inline]
>>  [<00000000c9dcd1f8>] dump_stack+0x268/0x2f0 lib/dump_stack.c:118
>>  [<00000000c5fed016>] print_address_description.constprop.0+0x5e/0x218 mm/kasan/report.c:383
>>  [<00000000c5fec82a>] __kasan_report mm/kasan/report.c:517 [inline]
>>  [<00000000c5fec82a>] kasan_report+0x11a/0x168 mm/kasan/report.c:534
>>  [<00000000c98b5b60>] iucv_send_ctrl+0x390/0x3f0 net/iucv/af_iucv.c:385
>>  [<00000000c98b6262>] iucv_sock_shutdown+0x44a/0x4c0 net/iucv/af_iucv.c:1457
>>  [<00000000c89d3a54>] __sys_shutdown+0x12c/0x1c8 net/socket.c:2204
>>  [<00000000c89d3b70>] __do_sys_shutdown net/socket.c:2212 [inline]
>>  [<00000000c89d3b70>] __s390x_sys_shutdown+0x38/0x48 net/socket.c:2210
>>  [<00000000c9e36eac>] system_call+0xe0/0x28c arch/s390/kernel/entry.S:415
>>
>> There is nothing to shutdown if a connection has never been established.
>> Besides that iucv->hs_dev is not yet initialized if a socket is in
>> IUCV_OPEN state and iucv->path is not yet initialized if socket is in
>> IUCV_BOUND state.
>> So, just skip the shutdown calls for a socket in these states.
>>
>> Fixes: eac3731bd04c ("s390: Add AF_IUCV socket support")
>> Fixes: 82492a355fac ("af_iucv: add shutdown for HS transport")
>> Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
>> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
>> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> 
> Fixes tag: Fixes: eac3731bd04c ("s390: Add AF_IUCV socket support")
> Has these problem(s):
> 	- Subject does not match target commit subject
> 	  Just use
> 		git log -1 --format='Fixes: %h ("%s")'
> 

sigh... yes, that should have been
Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")

Thanks. Will fix up and get you a v2 shortly.
