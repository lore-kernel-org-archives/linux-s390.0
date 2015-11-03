From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Tue, 3 Nov 2015 09:54:58 -0800
Message-ID: <CALCETrW-4WGGorDmW1jb8NJ6uCj5w6M57eHtaJ0Bm8GOMBSJUQ@mail.gmail.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
 <5631629B.2050505@de.ibm.com> <CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
 <20151030092548.7abd51e1.cornelia.huck@de.ibm.com> <CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
 <20151102121658.11aa3375.cornelia.huck@de.ibm.com> <CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
 <56386CE5.1040208@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ce0f2cba94e0523a69816
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <56386CE5.1040208@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

--001a113ce0f2cba94e0523a69816
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 3, 2015 at 12:14 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Am 02.11.2015 um 21:23 schrieb Andy Lutomirski:
>> On Mon, Nov 2, 2015 at 3:16 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>>> On Fri, 30 Oct 2015 13:33:07 -0700
>>> Andy Lutomirski <luto@amacapital.net> wrote:
>>>
>>>> On Fri, Oct 30, 2015 at 1:25 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>>>>> On Thu, 29 Oct 2015 15:50:38 -0700
>>>>> Andy Lutomirski <luto@amacapital.net> wrote:
>>>>>
>>>>>> Progress!  After getting that sort-of-working, I figured out what was
>>>>>> wrong with my earlier command, and I got that working, too.  Now I
>>>>>> get:
>>>>>>
>>>>>> qemu-system-s390x -fsdev
>>>>>> local,id=virtfs1,path=/,security_model=none,readonly -device
>>>>>> virtio-9p-ccw,fsdev=virtfs1,mount_tag=/dev/root -M s390-ccw-virtio
>>>>>> -nodefaults -device sclpconsole,chardev=console -parallel none -net
>>>>>> none -echr 1 -serial none -chardev stdio,id=console,signal=off,mux=on
>>>>>> -serial chardev:console -mon chardev=console -vga none -display none
>>>>>> -kernel arch/s390/boot/bzImage -append
>>>>>> 'init=/home/luto/devel/virtme/virtme/guest/virtme-init
>>>>>> psmouse.proto=exps "virtme_stty_con=rows 24 cols 150 iutf8"
>>>>>> TERM=xterm-256color rootfstype=9p
>>>>>> rootflags=ro,version=9p2000.L,trans=virtio,access=any
>>>>>> raid=noautodetect debug'
>>>>>
>>>>> The commandline looks sane AFAICS.
>>>>>
>>>>> (...)
>>>>>
>>>>>> vrfy: device 0.0.0000: rc=0 pgroup=0 mpath=0 vpm=80
>>>>>> virtio_ccw 0.0.0000: Failed to set online: -5
>>>>>>
>>>>>> ^^^ bad news!
>>>>>
>>>>> I'd like to see where in the onlining process this fails. Could you set
>>>>> up qemu tracing for css_* and virtio_ccw_* (instructions in
>>>>> qemu/docs/tracing.txt)?
>>>>
>>>> I have a file called events that contains:
>>>>
>>>> css_*
>>>> virtio_ccw_*
>>>>
>>>> pointing -trace events= at it results in a trace-<pid> file that's 549
>>>> bytes long and contains nothing.  Are wildcards not as well-supported
>>>> as the docs suggest?
>>>
>>> Just tried it, seemed to work for me as expected. And as your messages
>>> indicate, at least some of the css tracepoints are guaranteed to be
>>> hit. Odd.
>>>
>>> Can you try the following sophisticated printf debug patch?
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index c033612..6a87bd6 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -308,6 +308,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr)
>>>          sch->ccw_no_data_cnt++;
>>>      }
>>>
>>> +    fprintf(stderr, "CH DBG: %s: cmd_code=%x\n", __func__, ccw.cmd_code);
>>> +
>>>      /* Look at the command. */
>>>      switch (ccw.cmd_code) {
>>>      case CCW_CMD_NOOP:
>>> @@ -375,6 +377,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr)
>>>          }
>>>          break;
>>>      }
>>> +    fprintf(stderr, "CH DBG: %s: ret=%d\n", __func__, ret);
>>>      sch->last_cmd = ccw;
>>>      sch->last_cmd_valid = true;
>>>      if (ret == 0) {
>>>
>>>
>>>>> Which qemu version is this, btw.?
>>>>>
>>>>
>>>> git from yesterday.
>>>
>>> Hm. Might be worth trying the s390-ccw-virtio-2.4 machine instead.
>>>
>>
>> No change.
>>
>> With s390-ccw-virtio-2.4, I get:
>>
>> Initializing cgroup subsys cpuset
>> Initializing cgroup subsys cpu
>> Initializing cgroup subsys cpuacct
>> Linux version 4.3.0-rc7-00008-gff230d6ec6b2
>> (luto@amaluto.corp.amacapital.net) (gcc version 5.1.1 20150618 (Red
>> Hat Cross 5.1.1-3) (GCC) ) #344 SMP Fri Oct 30 13:16:13 PDT 2015
>> setup: Linux is running under KVM in 64-bit mode
>> setup: Max memory size: 128MB
>> Zone ranges:
>>   DMA      [mem 0x0000000000000000-0x000000007fffffff]
>>   Normal   empty
>> Movable zone start for each node
>> Early memory node ranges
>>   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
>> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
>> On node 0 totalpages: 32768
>>   DMA zone: 512 pages used for memmap
>>   DMA zone: 0 pages reserved
>>   DMA zone: 32768 pages, LIFO batch:7
>> PERCPU: Embedded 466 pages/cpu @0000000007605000 s1868032 r8192 d32512 u1908736
>> pcpu-alloc: s1868032 r8192 d32512 u1908736 alloc=466*4096
>> pcpu-alloc: [0] 0 [0] 1
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
>> Kernel command line:
>> init=/home/luto/devel/virtme/virtme/guest/virtme-init
>> psmouse.proto=exps "virtme_stty_con=rows 45 cols 150 iutf8"
>> TERM=xterm-256color rootfstype=9p
>> rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
>> ro debug
>> PID hash table entries: 512 (order: 0, 4096 bytes)
>> Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
>> Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
>> Memory: 92520K/131072K available (8255K kernel code, 802K rwdata,
>
>
> can you send your kernel config?
>

Attached.

A failing command looks like:

qemu-system-s390x -fsdev
local,id=virtfs1,path=/,security_model=none,readonly -device
virtio-9p-ccw,fsdev=virtfs1,mount_tag=/dev/root -M s390-ccw-virtio
-nodefaults -device sclpconsole,chardev=console -parallel none -net
none -echr 1 -serial none -chardev stdio,id=console,signal=off,mux=on
-serial chardev:console -mon chardev=console -vga none -display none
-kernel arch/s390/boot/bzImage -append
'init=/home/luto/devel/virtme/virtme/guest/virtme-init
psmouse.proto=exps "virtme_stty_con=rows 24 cols 80 iutf8"
TERM=xterm-256color rootfstype=9p
rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
ro debug'

I'm testing that from an x86_64 host, so this is TCG and not KVM.

--Andy

--001a113ce0f2cba94e0523a69816
Content-Type: application/x-xz; name="s390-config.xz"
Content-Disposition: attachment; filename="s390-config.xz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_igjo1tni0

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
--001a113ce0f2cba94e0523a69816--
