From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 31 Aug 2015 10:42:54 +0000
Subject: Re: Run s390 kernel as guest os on x86_64 with qemu
Message-Id: <20150831124254.43607d47.cornelia.huck@de.ibm.com>
In-Reply-To: <CAFPzW88aCvqGpE27vOcngJxTbMyvo7AT0PN4MOpKduNNHQxVxQ@mail.gmail.com>
References: <CAFPzW88aCvqGpE27vOcngJxTbMyvo7AT0PN4MOpKduNNHQxVxQ@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 29 Aug 2015 00:52:52 +0600
Alex ��geek <anotherworldofworld@gmail.com> wrote:

> Hello,
> 
> I've built Linux kernel for the s390x with defconfig configuration and

You need to make sure that CONFIG_S390_GUEST and the various virtio
options are enabled.

> trying to run it with qemu:
> 
> qemu-system-s390x -kernel ~/dev/linux/arch/s390/boot/bzImage
> -snapshot -serial stdio -m 1024 -initrd ~/initrd.gz
> 
> But I don't see anything after execution of the command.
> 
> Also I've tried to pass arch/s390/boot/image to -kernel but got the
> same effect. How can I run it and can I do it generally?

Running s390x guests on other architectures should work fine with
recent qemus. But there may be some pitfalls (instruction set level);
I'd advise you to head over to qemu-devel@nongnu.org (and check the
archives, I think there was some recent discussion), as the experts of
s390x-on-non-s390x are on that mailing list.

Good luck,
Cornelia
