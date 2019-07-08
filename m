Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728827AbfGHTQM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jul 2019 15:16:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68JBqvT094068
        for <linux-s390@vger.kernel.org>; Mon, 8 Jul 2019 15:16:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tma953k34-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 15:16:11 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 8 Jul 2019 20:16:09 +0100
Subject: Re: linux-next: Tree for Jul 8 --> bootup failure on s390x (bisected)
References: <20190708224238.60bd0aff@canb.auug.org.au>
 <0be7464d-f8ed-0567-b0ff-a6d31ecfd7a8@de.ibm.com>
 <20190708180657.GV17978@ZenIV.linux.org.uk>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 8 Jul 2019 21:16:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190708180657.GV17978@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <90645322-01ca-248c-b53d-9bb103223d1b@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 08.07.19 20:06, Al Viro wrote:
> On Mon, Jul 08, 2019 at 06:52:14PM +0200, Christian Borntraeger wrote:
> 
>> smp: Brought up 1 node, 1 CPU
>> Unable to handle kernel pointer dereference in virtual kernel address space
>> Failing address: 000000003a070000 TEID: 000000003a070407
>> Fault in home space mode while using kernel ASCE.
>> AS:000000003a780007 R3:000000007ffd0007 S:000000007ffd4800 P:000000003a07021d 
>> Oops: 0004 ilc:2 [#1] SMP 
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5-00101-gcb8f0b366109 #14
>> Hardware name: IBM 2964 NC9 712 (KVM/Linux)
>> Krnl PSW : 0704e00180000000 000000003974b580 (shmem_parse_monolithic+0x88/0x100)
>>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>> Krnl GPRS: 0000000000000000 000000000000003d 000000003a07040e 000000000000003d
>>            000000003a07040f 000000000000006d 0000000000000001 0000000000000000
>>            000000007f7c1c00 0000000000000000 000000003a07040a 0000000000000000
>>            000000007f7e4000 000000003a190d78 000000003974b56c 000003e00031fd38
>> Krnl Code: 000000003974b574: b920002a		cgr	%r2,%r10
>>            000000003974b578: a784001b		brc	8,3974b5ae
>>           #000000003974b57c: 41402001		la	%r4,1(%r2)
>>           >000000003974b580: 92002000		mvi	0(%r2),0
>>            000000003974b584: a7090000		lghi	%r0,0
>>            000000003974b588: b9040014		lgr	%r1,%r4
>>            000000003974b58c: b25e0001		srst	%r0,%r1
>>            000000003974b590: a714fffe		brc	1,3974b58c
>> Call Trace:
>> ([<000003e00031fd80>] 0x3e00031fd80)
>>  [<0000000039811662>] vfs_kern_mount.part.0+0x9a/0xc8 
>>  [<000000003a302fc0>] devtmpfs_init+0x38/0x140 
>>  [<000000003a302e0a>] driver_init+0x22/0x60 
>>  [<000000003a2beff8>] kernel_init_freeable+0x298/0x4f0 
>>  [<0000000039e7b53a>] kernel_init+0x22/0x148 
>>  [<0000000039e87b70>] ret_from_fork+0x30/0x34 
>>  [<0000000039e87b74>] kernel_thread_starter+0x0/0xc 
>> INFO: lockdep is turned off.
>> [...]
> 
> Oh, fuck...  OK, I understand what's going on; sorry, my fault.  Could you
> verify that the following helps?

Yes, it does. 



> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 52312c665a38..30d0523014e0 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -431,9 +431,10 @@ static int devtmpfsd(void *p)
>   */
>  int __init devtmpfs_init(void)
>  {
> +	char opts[] = "mode=0755";
>  	int err;
>  
> -	mnt = vfs_kern_mount(&internal_fs_type, 0, "devtmpfs", "mode=0755");
> +	mnt = vfs_kern_mount(&internal_fs_type, 0, "devtmpfs", opts);
>  	if (IS_ERR(mnt)) {
>  		printk(KERN_ERR "devtmpfs: unable to create devtmpfs %ld\n",
>  				PTR_ERR(mnt));
> 
