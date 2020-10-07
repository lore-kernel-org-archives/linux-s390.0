Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519142259.102279-3-sth@linux.ibm.com>
 <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
 <20201007103936.GA24327@lst.de>
 <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
 <20201007120005.GA29788@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <e1e4afa1-faa2-aa19-a973-ee1286288802@de.ibm.com>
Date: Wed, 7 Oct 2020 14:09:18 +0200
MIME-Version: 1.0
In-Reply-To: <20201007120005.GA29788@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org

On 07.10.20 14:00, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 12:44:55PM +0200, Christian Borntraeger wrote:
>>
>>
>> On 07.10.20 12:39, Christoph Hellwig wrote:
>>> On Wed, Oct 07, 2020 at 11:34:17AM +0200, Christian Borntraeger wrote:
>>>>
>>>> On 19.05.20 16:22, Stefan Haberland wrote:
>>>>> The IBM partition parser requires device type specific information only
>>>>> available to the DASD driver to correctly register partitions. The
>>>>> current approach of using ioctl_by_bdev with a fake user space pointer
>>>>> is discouraged.
>>>>>
>>>>> Fix this by replacing IOCTL calls with direct in-kernel function calls.
>>>>>
>>>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>>>>> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
>>>>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>>>>
>>>> FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.
>>>
>>> What are the symptoms?
>>
>> During boot I normally have
> 
>> [    0.930231] virtio_blk virtio1: [vda] 5409180 4096-byte logical blocks (22.2 GB/20.6 GiB)
>> [    0.930233] vda: detected capacity change from 0 to 22156001280
>> [    0.932806]  vda:VOL1/  0X3333: vda1 vda2 vda3
>>
>> With this change, the last line is no longer there (if CONFIG_DASD=m) and this also 
>> reflects itself in /proc/partitions. The partitions are no longer detected.
> 
> Can you try this patch?


> 
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index d6e18df9c53c6d..d91cee558ce67a 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -305,8 +305,6 @@ int ibm_partition(struct parsed_partitions *state)
>  	if (!disk->fops->getgeo)
>  		goto out_exit;
>  	fn = symbol_get(dasd_biodasdinfo);
> -	if (!fn)
> -		goto out_exit;
>  	blocksize = bdev_logical_block_size(bdev);
>  	if (blocksize <= 0)
>  		goto out_symbol;
> @@ -326,7 +324,7 @@ int ibm_partition(struct parsed_partitions *state)
>  	geo->start = get_start_sect(bdev);
>  	if (disk->fops->getgeo(bdev, geo))
>  		goto out_freeall;
> -	if (fn(disk, info)) {
> +	if (!fn || fn(disk, info)) {
>  		kfree(info);
>  		info = NULL;
>  	}
> 

Unfortunately not. On insmodding virtio_blk I do get:
[    3.331256] vda: detected capacity change from 0 to 22156001280
[    3.332381] ------------[ cut here ]------------
[    3.332382] kernel BUG at kernel/module.c:1081!
[    3.332420] monitor event: 0040 ilc:2 [#1] SMP 
[    3.332422] Modules linked in: virtio_blk(+) kvm
[    3.332425] CPU: 0 PID: 136 Comm: insmod Not tainted 5.8.13+ #54
[    3.332425] Hardware name: IBM 3906 M04 704 (KVM/Linux)
[    3.332426] Krnl PSW : 0704c00180000000 0000000016cf4fc6 (__symbol_put+0x56/0x58)
[    3.332434]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[    3.332435] Krnl GPRS: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    3.332436]            0000000000000000 0000000000000018 0000000000000000 0000000000000098
[    3.332437]            0000000000000000 0000000000000001 0000000000000000 0000000004fd9180
[    3.332438]            000000001f70c000 0000000004fd9360 0000000016cf4fa2 000003e0000f7648
[    3.332445] Krnl Code: 0000000016cf4fb8: f0a8000407fe	srp	4(11,%r0),2046,8
[    3.332445]            0000000016cf4fbe: 47000700		bc	0,1792
[    3.332445]           #0000000016cf4fc2: af000000		mc	0,0
[    3.332445]           >0000000016cf4fc6: 0707		bcr	0,%r7
[    3.332445]            0000000016cf4fc8: c00400000000	brcl	0,0000000016cf4fc8
[    3.332445]            0000000016cf4fce: eb6ff0480024	stmg	%r6,%r15,72(%r15)
[    3.332445]            0000000016cf4fd4: b90400ef		lgr	%r14,%r15
[    3.332445]            0000000016cf4fd8: b90400b4		lgr	%r11,%r4
[    3.332454] Call Trace:
[    3.332456]  [<0000000016cf4fc6>] __symbol_put+0x56/0x58 
[    3.332458] ([<0000000016cf4fa2>] __symbol_put+0x32/0x58)
[    3.332462]  [<00000000171be268>] ibm_partition+0xa0/0xa28 
[    3.332464]  [<00000000171b952c>] blk_add_partitions+0x184/0x5b8 
[    3.332467]  [<0000000016f07e94>] bdev_disk_changed+0x8c/0x120 
[    3.332468]  [<0000000016f09872>] __blkdev_get+0x3fa/0x598 
[    3.332469]  [<0000000016f09a42>] blkdev_get+0x32/0x1c8 
[    3.332471]  [<00000000171b5ee4>] __device_add_disk+0x32c/0x510 
[    3.332473]  [<000003ff80068de0>] virtblk_probe+0x5f0/0xc30 [virtio_blk] 
[    3.332477]  [<00000000172cc110>] virtio_dev_probe+0x178/0x2a0 
[    3.332480]  [<000000001731cecc>] really_probe+0xf4/0x498 
[    3.332481]  [<000000001731da1a>] device_driver_attach+0xd2/0xd8 
[    3.332482]  [<000000001731dad8>] __driver_attach+0xb8/0x180 
[    3.332483]  [<000000001731a1e2>] bus_for_each_dev+0x82/0xb8 
[    3.332484]  [<000000001731bf66>] bus_add_driver+0x1fe/0x248 
[    3.332486]  [<000000001731e340>] driver_register+0xa0/0x168 
[    3.332487]  [<000003ff8006e068>] init+0x68/0x1000 [virtio_blk] 
[    3.332489]  [<0000000016bfc884>] do_one_initcall+0x3c/0x1f8 
[    3.332490]  [<0000000016cf6c98>] do_init_module+0x68/0x290 
[    3.332491]  [<0000000016cf9eec>] __do_sys_finit_module+0xa4/0xe8 
[    3.332494]  [<000000001766c760>] system_call+0xdc/0x2b0 
[    3.332495] Last Breaking-Event-Address:
[    3.332496]  [<0000000016cf4fa6>] __symbol_put+0x36/0x58
[    3.332498] ---[ end trace 4a4a7a5643aab422 ]---
