From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Thu, 28 Aug 2014 11:06:54 -0700
Message-ID: <CALCETrXxFJQsZyLmbrjYyXK6LKmRuBK=KMas2Db8vCVaBwe9yQ@mail.gmail.com>
References: <cover.1409176034.git.luto@amacapital.net>
	<53FEDDF5.3030903@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53FEDDF5.3030903@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux390@de.ibm.com" <linux390@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 28, 2014 at 12:44 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 27/08/14 23:50, Andy Lutomirski wrote:
>> This fixes virtio on Xen guests as well as on any other platform
>> that uses virtio_pci on which physical addresses don't match bus
>> addresses.
>>
>> This can be tested with:
>>
>>     virtme-run --xen xen --kimg arch/x86/boot/bzImage --console
>>
>> using virtme from here:
>>
>>     https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git
>>
>> Without these patches, the guest hangs forever.  With these patches,
>> everything works.
>>
>> This should be safe on all platforms that I'm aware of.  That
>> doesn't mean that there isn't anything that I missed.
>>
>> Changes from v1:
>>  - Using the DMA API is optional now.  It would be nice to improve the
>>    DMA API to the point that it could be used unconditionally, but s390
>>    proves that we're not there yet.
>>  - Includes patch 4, which fixes DMA debugging warnings from virtio_net.
>>
>> Andy Lutomirski (4):
>>   virtio_ring: Remove sg_next indirection
>>   virtio_ring: Support DMA APIs if requested
>>   virtio_pci: Use the DMA API for virtqueues
>>   virtio_net: Stop doing DMA from the stack
>>
>>  drivers/lguest/lguest_device.c         |   3 +-
>>  drivers/misc/mic/card/mic_virtio.c     |   2 +-
>>  drivers/net/virtio_net.c               |  53 +++++---
>>  drivers/remoteproc/remoteproc_virtio.c |   4 +-
>>  drivers/s390/kvm/kvm_virtio.c          |   2 +-
>>  drivers/s390/kvm/virtio_ccw.c          |   4 +-
>>  drivers/virtio/virtio_mmio.c           |   5 +-
>>  drivers/virtio/virtio_pci.c            |  35 ++++--
>>  drivers/virtio/virtio_ring.c           | 219 ++++++++++++++++++++++++++-------
>>  include/linux/virtio_ring.h            |   1 +
>>  tools/virtio/linux/virtio.h            |   1 +
>>  tools/virtio/virtio_test.c             |   2 +-
>>  tools/virtio/vringh_test.c             |   3 +-
>>  13 files changed, 253 insertions(+), 81 deletions(-)
>>
>
> Patches were applied on top of 3.16.
>
> block seems to work, with net a simple ping works, iperf causes this:

I neither see the bug, nor can I reproduce it on x86_64 on KVM.  I
doubt that dma vs. non-dma is relevant.  I tried -net user a -net tap
with iperf running in both directions.  I also tried switching
virtio_pci into non-DMA-API mode.  No errors.

Is there any chance that you could instrument that BUG_ON to print n,
i, in_sgs, out_sgs, total_sg, total_in, and total_out?  I assume this
is some oddity with patch 1, but I'm mystified.

Thanks,
Andy

>
> [    8.643981] ------------[ cut here ]------------
> [    8.643986] kernel BUG at drivers/virtio/virtio_ring.c:245!
> [    8.644036] illegal operation: 0001 [#1] SMP
> [    8.644039] Modules linked in: virtio_net virtio_blk dm_multipath sunrpc
> [    8.644046] CPU: 0 PID: 1291 Comm: iperf Not tainted 3.16.0+ #130
> [    8.644048] task: 00000000018ee4c0 ti: 0000000022098000 task.ti: 0000000022098000
> [    8.644051] Krnl PSW : 0704d00180000000 0000000000421618 (virtqueue_add_outbuf+0x2e4/0x340)
> [    8.644066]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 EA:3
> Krnl GPRS: 00000000299f8a80 0000000000000000 0000000000000001 000003d100000000
> [    8.644070]            00000000004214de 0000000000000e2c 0000000000000001 0000000000000002
> [    8.644072]            00000000299f8a40 0000000000000001 00000000299f8a40 0000000000000000
> [    8.644074]            0000000028077608 00000000287ec000 0000000000421548 000000002209b7b0
> [    8.644085] Krnl Code: 000000000042160a: d060a7a90000        trtr    1961(97,%r10),0
>            0000000000421610: a7f4ff07           brc     15,42141e
>           #0000000000421614: a7f40001           brc     15,421616
>           >0000000000421618: a7c8fffb           lhi     %r12,-5
>            000000000042161c: a7f4ff46           brc     15,4214a8
>            0000000000421620: a7f40001           brc     15,421622
>            0000000000421624: b9040021           lgr     %r2,%r1
>            0000000000421628: c030001c3569       larl    %r3,7a80fa
> [    8.644106] Call Trace:
> [    8.644110] ([<00000000004214de>] virtqueue_add_outbuf+0x1aa/0x340)
> [    8.644114]  [<000003ff80174466>] start_xmit+0x1e6/0x49c [virtio_net]
> [    8.644119]  [<000000000050571a>] dev_hard_start_xmit+0x346/0x600
> [    8.644123]  [<000000000052a43c>] sch_direct_xmit+0xe8/0x1e8
> [    8.644126]  [<0000000000505be8>] __dev_queue_xmit+0x214/0x4ec
> [    8.644131]  [<000000000054a476>] ip_finish_output+0x436/0x90c
> [    8.644134]  [<000000000054b7c0>] ip_queue_xmit+0x170/0x3e8
> [    8.644137]  [<00000000005636ca>] tcp_transmit_skb+0x462/0x984
> [    8.644140]  [<0000000000564870>] tcp_write_xmit+0x220/0xd0c
> [    8.644143]  [<00000000005653a2>] tcp_push_one+0x46/0x58
> [    8.644145]  [<00000000005568b4>] tcp_sendmsg+0xb7c/0xc9c
> [    8.644148]  [<00000000004e7514>] sock_aio_write+0x12c/0x158
> [    8.644153]  [<000000000027033c>] do_sync_write+0x80/0xc8
> [    8.644156]  [<0000000000271444>] vfs_write+0x144/0x1d8
> [    8.644158]  [<000000000027192a>] SyS_write+0x62/0xd0
> [    8.644163]  [<000000000062781c>] sysc_tracego+0x14/0x1a
> [    8.644170]  [<000003fffd51203c>] 0x3fffd51203c
> [    8.644171] Last Breaking-Event-Address:
> [    8.644174]  [<0000000000421614>] virtqueue_add_outbuf+0x2e0/0x340
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
