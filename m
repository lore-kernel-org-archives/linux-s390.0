From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Thu, 28 Aug 2014 20:29:49 +0200
Message-ID: <53FF751D.2040006__41539.0043556274$1409250618$gmane$org@de.ibm.com>
References: <cover.1409176034.git.luto@amacapital.net>
	<53FEDDF5.3030903@de.ibm.com>
	<CALCETrXxFJQsZyLmbrjYyXK6LKmRuBK=KMas2Db8vCVaBwe9yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrXxFJQsZyLmbrjYyXK6LKmRuBK=KMas2Db8vCVaBwe9yQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux390@de.ibm.com" <linux390@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On 28/08/14 20:06, Andy Lutomirski wrote:
[...]
>> block seems to work, with net a simple ping works, iperf causes this:
> 
> I neither see the bug, nor can I reproduce it on x86_64 on KVM.  I
> doubt that dma vs. non-dma is relevant.  I tried -net user a -net tap
> with iperf running in both directions.  I also tried switching
> virtio_pci into non-DMA-API mode.  No errors.
> 
> Is there any chance that you could instrument that BUG_ON to print n,
> i, in_sgs, out_sgs, total_sg, total_in, and total_out?  I assume this
> is some oddity with patch 1, but I'm mystified.

Yes, its triggered by patch 1.
> 
> Thanks,
> Andy
> 
>>
>> [    8.643981] ------------[ cut here ]------------
>> [    8.643986] kernel BUG at drivers/virtio/virtio_ring.c:245!
>> [    8.644036] illegal operation: 0001 [#1] SMP
>> [    8.644039] Modules linked in: virtio_net virtio_blk dm_multipath sunrpc
>> [    8.644046] CPU: 0 PID: 1291 Comm: iperf Not tainted 3.16.0+ #130
>> [    8.644048] task: 00000000018ee4c0 ti: 0000000022098000 task.ti: 0000000022098000
>> [    8.644051] Krnl PSW : 0704d00180000000 0000000000421618 (virtqueue_add_outbuf+0x2e4/0x340)
>> [    8.644066]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 EA:3
>> Krnl GPRS: 00000000299f8a80 0000000000000000 0000000000000001 000003d100000000
>> [    8.644070]            00000000004214de 0000000000000e2c 0000000000000001 0000000000000002
>> [    8.644072]            00000000299f8a40 0000000000000001 00000000299f8a40 0000000000000000
>> [    8.644074]            0000000028077608 00000000287ec000 0000000000421548 000000002209b7b0
>> [    8.644085] Krnl Code: 000000000042160a: d060a7a90000        trtr    1961(97,%r10),0
>>            0000000000421610: a7f4ff07           brc     15,42141e
>>           #0000000000421614: a7f40001           brc     15,421616
>>           >0000000000421618: a7c8fffb           lhi     %r12,-5
>>            000000000042161c: a7f4ff46           brc     15,4214a8
>>            0000000000421620: a7f40001           brc     15,421622
>>            0000000000421624: b9040021           lgr     %r2,%r1
>>            0000000000421628: c030001c3569       larl    %r3,7a80fa
>> [    8.644106] Call Trace:
>> [    8.644110] ([<00000000004214de>] virtqueue_add_outbuf+0x1aa/0x340)
>> [    8.644114]  [<000003ff80174466>] start_xmit+0x1e6/0x49c [virtio_net]
>> [    8.644119]  [<000000000050571a>] dev_hard_start_xmit+0x346/0x600
>> [    8.644123]  [<000000000052a43c>] sch_direct_xmit+0xe8/0x1e8
>> [    8.644126]  [<0000000000505be8>] __dev_queue_xmit+0x214/0x4ec
>> [    8.644131]  [<000000000054a476>] ip_finish_output+0x436/0x90c
>> [    8.644134]  [<000000000054b7c0>] ip_queue_xmit+0x170/0x3e8
>> [    8.644137]  [<00000000005636ca>] tcp_transmit_skb+0x462/0x984
>> [    8.644140]  [<0000000000564870>] tcp_write_xmit+0x220/0xd0c
>> [    8.644143]  [<00000000005653a2>] tcp_push_one+0x46/0x58
>> [    8.644145]  [<00000000005568b4>] tcp_sendmsg+0xb7c/0xc9c
>> [    8.644148]  [<00000000004e7514>] sock_aio_write+0x12c/0x158
>> [    8.644153]  [<000000000027033c>] do_sync_write+0x80/0xc8
>> [    8.644156]  [<0000000000271444>] vfs_write+0x144/0x1d8
>> [    8.644158]  [<000000000027192a>] SyS_write+0x62/0xd0
>> [    8.644163]  [<000000000062781c>] sysc_tracego+0x14/0x1a
>> [    8.644170]  [<000003fffd51203c>] 0x3fffd51203c
>> [    8.644171] Last Breaking-Event-Address:
>> [    8.644174]  [<0000000000421614>] virtqueue_add_outbuf+0x2e0/0x340
>>
> 
> 
> 
