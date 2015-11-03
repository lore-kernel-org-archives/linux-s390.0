From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Tue, 3 Nov 2015 09:14:29 +0100
Message-ID: <56386CE5.1040208@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
 <5631629B.2050505@de.ibm.com>
 <CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
 <20151030092548.7abd51e1.cornelia.huck@de.ibm.com>
 <CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
 <20151102121658.11aa3375.cornelia.huck@de.ibm.com>
 <CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 02.11.2015 um 21:23 schrieb Andy Lutomirski:
> On Mon, Nov 2, 2015 at 3:16 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>> On Fri, 30 Oct 2015 13:33:07 -0700
>> Andy Lutomirski <luto@amacapital.net> wrote:
>>
>>> On Fri, Oct 30, 2015 at 1:25 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>>>> On Thu, 29 Oct 2015 15:50:38 -0700
>>>> Andy Lutomirski <luto@amacapital.net> wrote:
>>>>
>>>>> Progress!  After getting that sort-of-working, I figured out what was
>>>>> wrong with my earlier command, and I got that working, too.  Now I
>>>>> get:
>>>>>
>>>>> qemu-system-s390x -fsdev
>>>>> local,id=virtfs1,path=/,security_model=none,readonly -device
>>>>> virtio-9p-ccw,fsdev=virtfs1,mount_tag=/dev/root -M s390-ccw-virtio
>>>>> -nodefaults -device sclpconsole,chardev=console -parallel none -net
>>>>> none -echr 1 -serial none -chardev stdio,id=console,signal=off,mux=on
>>>>> -serial chardev:console -mon chardev=console -vga none -display none
>>>>> -kernel arch/s390/boot/bzImage -append
>>>>> 'init=/home/luto/devel/virtme/virtme/guest/virtme-init
>>>>> psmouse.proto=exps "virtme_stty_con=rows 24 cols 150 iutf8"
>>>>> TERM=xterm-256color rootfstype=9p
>>>>> rootflags=ro,version=9p2000.L,trans=virtio,access=any
>>>>> raid=noautodetect debug'
>>>>
>>>> The commandline looks sane AFAICS.
>>>>
>>>> (...)
>>>>
>>>>> vrfy: device 0.0.0000: rc=0 pgroup=0 mpath=0 vpm=80
>>>>> virtio_ccw 0.0.0000: Failed to set online: -5
>>>>>
>>>>> ^^^ bad news!
>>>>
>>>> I'd like to see where in the onlining process this fails. Could you set
>>>> up qemu tracing for css_* and virtio_ccw_* (instructions in
>>>> qemu/docs/tracing.txt)?
>>>
>>> I have a file called events that contains:
>>>
>>> css_*
>>> virtio_ccw_*
>>>
>>> pointing -trace events= at it results in a trace-<pid> file that's 549
>>> bytes long and contains nothing.  Are wildcards not as well-supported
>>> as the docs suggest?
>>
>> Just tried it, seemed to work for me as expected. And as your messages
>> indicate, at least some of the css tracepoints are guaranteed to be
>> hit. Odd.
>>
>> Can you try the following sophisticated printf debug patch?
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index c033612..6a87bd6 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -308,6 +308,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr)
>>          sch->ccw_no_data_cnt++;
>>      }
>>
>> +    fprintf(stderr, "CH DBG: %s: cmd_code=%x\n", __func__, ccw.cmd_code);
>> +
>>      /* Look at the command. */
>>      switch (ccw.cmd_code) {
>>      case CCW_CMD_NOOP:
>> @@ -375,6 +377,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr)
>>          }
>>          break;
>>      }
>> +    fprintf(stderr, "CH DBG: %s: ret=%d\n", __func__, ret);
>>      sch->last_cmd = ccw;
>>      sch->last_cmd_valid = true;
>>      if (ret == 0) {
>>
>>
>>>> Which qemu version is this, btw.?
>>>>
>>>
>>> git from yesterday.
>>
>> Hm. Might be worth trying the s390-ccw-virtio-2.4 machine instead.
>>
> 
> No change.
> 
> With s390-ccw-virtio-2.4, I get:
> 
> Initializing cgroup subsys cpuset
> Initializing cgroup subsys cpu
> Initializing cgroup subsys cpuacct
> Linux version 4.3.0-rc7-00008-gff230d6ec6b2
> (luto@amaluto.corp.amacapital.net) (gcc version 5.1.1 20150618 (Red
> Hat Cross 5.1.1-3) (GCC) ) #344 SMP Fri Oct 30 13:16:13 PDT 2015
> setup: Linux is running under KVM in 64-bit mode
> setup: Max memory size: 128MB
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x000000007fffffff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> On node 0 totalpages: 32768
>   DMA zone: 512 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 32768 pages, LIFO batch:7
> PERCPU: Embedded 466 pages/cpu @0000000007605000 s1868032 r8192 d32512 u1908736
> pcpu-alloc: s1868032 r8192 d32512 u1908736 alloc=466*4096
> pcpu-alloc: [0] 0 [0] 1
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
> Kernel command line:
> init=/home/luto/devel/virtme/virtme/guest/virtme-init
> psmouse.proto=exps "virtme_stty_con=rows 45 cols 150 iutf8"
> TERM=xterm-256color rootfstype=9p
> rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
> ro debug
> PID hash table entries: 512 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Memory: 92520K/131072K available (8255K kernel code, 802K rwdata,


can you send your kernel config?
