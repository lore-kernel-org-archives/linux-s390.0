From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH 0/3] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 27 Aug 2014 13:50:08 -0400
Message-ID: <53FE1A50.3050408@codeaurora.org>
References: <cover.1409087794.git.luto@amacapital.net>
	<CAJSP0QUcXQ+JV0wys2Mr-+OsFKt=hTGbUxNqfpk-JuyULiQABQ@mail.gmail.com>
	<CALCETrUWR8p7XSiTALd19LL4mTgkXu_XEewobouz6Jbkb4KjLw@mail.gmail.com>
	<20140827154537.GB18900@redhat.com>
	<CALCETrVUg3fCQS0rjOD1BbauXHfnydPyP3mNMeiGu4NqBgLK6A@mail.gmail.com>
	<53FE03C3.90309@codeaurora.org>
	<CALCETrWcMO_zkNEuXBeqSAt6FSvUaFve+_5JC-rk5vObvBZWSg@mail.gmail.com>
	<53FE16C2.4010104@codeaurora.org>
	<CALCETrUGka4jpDUKkQwATYOe-FwOwprom8yEBtWR0w0y-nrdZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUGka4jpDUKkQwATYOe-FwOwprom8yEBtWR0w0y-nrdZw@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On 08/27/2014 01:37 PM, Andy Lutomirski wrote:
> On Wed, Aug 27, 2014 at 10:34 AM, Christopher Covington
> <cov@codeaurora.org> wrote:
>> On 08/27/2014 12:19 PM, Andy Lutomirski wrote:
>>> On Wed, Aug 27, 2014 at 9:13 AM, Christopher Covington
>>> <cov@codeaurora.org> wrote:
>>
>> Virtme looks interesting. If it's any use, here is my modest QEMU command line
>> collection.
>>
>> $dir/bin/x86_64-linux-gnu/qemu-system-x86_64 \
>>   -m 1024 \
>>   -kernel $dir/boot/x86_64-linux-gnu/bzImage-x86_64 \
>>   -append 'root=/dev/root init=/sbin/x86_64-linux-gnu/init rootfstype=9p
>> rootflags=trans=virtio,version=9p2000.L ro console=ttyS0' \
>>   -serial stdio \
>>   -fsdev local,id=root,path=$dir,security_model=none \
>>   -device virtio-9p-pci,fsdev=root,mount_tag=/dev/root \
>>   -monitor none
> 
> This is similar to what virtme does, except that virtme will give you
> a much more functional system at the cost of a small fraction of a
> second of additional boot time.  And virtme sometimes supports modules
> :)
> 
>>
>> $dir/bin/x86_64-linux-gnu/qemu-system-arm \
>>   -M virt \
>>   -cpu cortex-a15 \
>>   -m 1024 \
>>   -kernel $dir/boot/arm-linux-gnueabihf/Image \
>>   -append 'root=/dev/root init=/sbin/arm-linux-gnueabihf/init rootfstype=9p
>> rootflags=trans=virtio,version=9p2000.L ro console=ttyAMA0' \
>>   -serial stdio \
>>   -fsdev local,id=root,path=$dir,security_model=none \
>>   -device virtio-9p-device,fsdev=root,mount_tag=/dev/root \
>>   -monitor none
> 
> Can you give me some hints as to how to configure a kernel for this?
> I tried to get anything other than versatilepb working and gave up.

I think you can just use vexpress_defconfig. If you want to from there you can
unselect CONFIG_ARCH_VEXPRESS and set CONFIG_ARCH_VIRT=y, but I don't think
that's strictly necessary.

>> $dir/bin/x86_64-linux-gnu/qemu-system-aarch64 \
>>   -M virt \
>>   -cpu cortex-a57 \
>>   -m 1024 \
>>   -kernel $dir/boot/aarch64-linux-gnu/Image \
>>   -append 'root=/dev/root init=/sbin/aarch64-linux-gnu/init rootfstype=9p
>> rootflags=trans=virtio,version=9p2000.L ro console=ttyAMA0' \
>>   -serial stdio \
>>   -fsdev local,id=root,path=$dir,security_model=none \
>>   -device virtio-9p-device,fsdev=root,mount_tag=/dev/root -monitor none
>>
> 
> Ooh, thanks!  I'll add support for this to virtme.

Cheers,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
