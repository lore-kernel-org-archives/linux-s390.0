Received: from cockroach.pear.relay.mailchannels.net (cockroach.pear.relay.mailchannels.net [23.83.216.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8325A651;
	Thu, 18 Sep 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.216.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221389; cv=pass; b=lKnol0AMUk30rbWa+5a8iqlFrUUEqVAISHVLlr+MXCorJll3ZT/Num/bEWySG2L1rLljel0WDLjlKW65phyQcQ7lDYlEx6L/uaiD8WarY0HU3/8kuHQyFbJumKb01xwmy0uopOA/lw+kqrjnFVMNFnas5VeC1cI7geUXXMLIzUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221389; c=relaxed/simple;
	bh=Cp4zdG5eM0HWXQevpyasWKxUqjl8UgD9X8WupT+EbPo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YyUNXBPsAFglvGKeCLrFWGofackPXsoSXcUVnRKohPElVzcV8nTqFxMNcDzvvRj6MWq50Ja5BVH6f9w8prWTFrdU2cKOByJSDDjp1wQlqBZsha86wIRrE85CPP9wKBo+mxFuuzAF9OIFeoqmMC4VP4dgHSNZHQePJa2lV+QRX5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=Qhv8mBXU; arc=pass smtp.client-ip=23.83.216.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="Qhv8mBXU"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E8C6D721400;
	Thu, 18 Sep 2025 18:10:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a308.dreamhost.com (100-110-156-141.trex-nlb.outbound.svc.cluster.local [100.110.156.141])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8B3B372114F;
	Thu, 18 Sep 2025 18:10:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1758219054; a=rsa-sha256;
	cv=none;
	b=6Uw2kG3J5yDjrWu2asDMTjCqENUgNOq/8FW85+tZFEpK+PoRxG4Aufl3YSSYg/VoTs/wk3
	Nre3xDk1byNWaechsvFUY7bhHSf3vgooZInk1P0YjqxK2boqKt5duGbklpxPsUWxAYkfRy
	DQo0JLJHbhR92CEsm7sJX0QZL1lmMt3jc9O1Bgg8v+zYEKe83VfcpCtL9kNfejMxB16Phl
	HoBLt4ozeGEIxouu2kceLXwGtgzM4wxLTcl8U+KKPa0EXUwTGxS/g3acDbKMrLsluD6HuL
	e+3uUMKz9zN7b+W7Xd8gGxgU16udZO50ID9fjB8q0l2peZxfr2T9RRyiVfbUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1758219054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vxziR2/s/e3N4yQXhZx/LndwgXceRToeiW89frogJ9s=;
	b=gkqDernnssV28eksTgHlJmPd9DKdFGA1IIZtp5Mon305qxoTG9rWgcAcfjEAjSYyMXD6jN
	D+L+Z9Di+vC9sF3BmgY07u84JDXxNMARFKBXy93CvHu+rj0oYI1PehgUvHWp8OrT244v6m
	SOSTAAXTJJpgWsGktc9EKwmk85NoUDHSIEodZmovoU0NLydCy5mL74fHQlbkLf/lFmPj2m
	hnAwlPRoVrRjQVm0qT3SQCNDe9hRmAE5ev71zvcI2oiQZfmexMdCA3mSuRp6GO0F1nQw69
	S/MMA4L+iyRhKctRfhKEFG3D6OLyR7ZpbBfJu9SWR4PqOwGmxEUvN4+KIg+YOg==
ARC-Authentication-Results: i=1;
	rspamd-54786f95c7-82zk7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Left: 65dd25cb5879f7ee_1758219054818_1595139523
X-MC-Loop-Signature: 1758219054818:660990001
X-MC-Ingress-Time: 1758219054818
Received: from pdx1-sub0-mail-a308.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.156.141 (trex/7.1.3);
	Thu, 18 Sep 2025 18:10:54 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a308.dreamhost.com (Postfix) with ESMTPSA id 4cSNwq2G6bz4j;
	Thu, 18 Sep 2025 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1758219054;
	bh=vxziR2/s/e3N4yQXhZx/LndwgXceRToeiW89frogJ9s=;
	h=Date:From:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=Qhv8mBXUwnZ4SRIqmQoiPIGK1pMFJ51QZF2epJXFATr5JNb+B5ZFlThgl9WHSxtig
	 ZKjEJtm4uOiF8mAEe10j2SyuLjy2W8CYtlC95qn2NemRa3RPlr/8SYIz+BZ5JMLgcy
	 VU4LdMJe5SvFxl+33ue1w9Ka9bL0FZyIIkGjCcKOR9MhMWOjJHc2tjqPUidllhpPGq
	 FSBJAe0G1sFuARPUoHSP14dFwM5dcPWoocu49KHV9Rc7lXHLf6mAzFeVXutu16nB3n
	 6eOqk+JKda2423m1ML3/ScvC4Hvje1JuS3SjDNhDzRzjEfO7/WM2YNYqOLrpgDza2K
	 s1aY/NqZU98fg==
Message-ID: <94023988-8498-4070-bdb7-6758dbe4b91d@landley.net>
Date: Thu, 18 Sep 2025 13:10:22 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@zohomail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Lennart Poettering <mzxreary@0pointer.de>,
 linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org,
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>,
 patches@lists.linux.dev
References: <20250912223937.3735076-1-safinaskar@zohomail.com>
 <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
 <CALCETrXHxOkHoS+0zhvc4cfpZqJ0wpfQUDnXW-A-qyQkqur-DQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALCETrXHxOkHoS+0zhvc4cfpZqJ0wpfQUDnXW-A-qyQkqur-DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/17/25 13:00, Andy Lutomirski wrote:
> On Mon, Sep 15, 2025 at 10:09 AM Rob Landley <rob@landley.net> wrote:
> 
>> While you're at it, could you fix static/builtin initramfs so PID 1 has
>> a valid stdin/stdout/stderr?
>>
>> A static initramfs won't create /dev/console if the embedded initramfs
>> image doesn't contain it, which a non-root build can't mknod, so the
>> kernel plumbing won't see it dev in the directory we point it at unless
>> we build with root access.
> 
> I have no current insight as to whether there's a kernel issue here,

They fixed the behavior in one codepath. They left it broken in the 
other codepath. The kernel's behavior is inconsistent.

Look:

$ mkdir sub; cc --static -xc - <<<'int main() {puts("hello\n");if 
(fork()) reboot(0x01234567); for(;;);}' -o sub/init
$ (cd sub; cpio -o -H newc <<<init | gzip) > sub.cpio.gz
$ make allnoconfig KCONFIG_ALLCONFIG=<(tr ' ' \\n <<<'PANIC_TIMEOUT=1 
RD_GZIP BINFMT_ELF BLK_DEV_INITRD EARLY_PRINTK 64BIT SERIAL_8250 
SERIAL_8250_CONSOLE UNWINDER_FRAME_POINTER' | sed 
's/^/CONFIG_/;/=/!s/$/=y/')
$ make -j $(nproc)
$ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -nographic -no-reboot 
-append console=ttyS0 -initrd sub.cpio.gz

You get a "hello" output near the end there. (You can add "quiet" to the 
-append but given that qemu can't NOT output its bios spam there's not 
much point.)

Now add INITRAMFS_SOURCE="sub" to the config and remove -initrd 
sub.cpio.gz from the qemu invocation:

$ make clean allnoconfig KCONFIG_ALLCONFIG=<(tr ' ' \\n 
<<<'PANIC_TIMEOUT=1 RD_GZIP BINFMT_ELF BLK_DEV_INITRD EARLY_PRINTK 64BIT 
SERIAL_8250 SERIAL_8250_CONSOLE UNWINDER_FRAME_POINTER 
INITRAMFS_SOURCE="sub"' | sed 's/^/CONFIG_/;/=/!s/$/=y/')
$ make -j $(nproc)
$ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -nographic -no-reboot 
-append 'console=ttyS0'

No "hello" output, but it DOES shut down cleanly instead of giving you a 
panic trace so you know it ran the init binary.

All that changed was statically linking the initramfs instead of feeding 
it in through the initrd mechanism: the kernel behaves differently in 
those two codepaths, as I explained in the message you replied to.

(The above instructions assume an x86-64 host toolchain, poke me if you 
want arm64 instead...)

> but why are you trying to put actual device nodes in an actual
> filesystem as part of a build process?

I'm not. Doing that would require root access on the build machine to 
mknod in "sub" directory above. I build new images WITHOUT root access 
on the host.

There used to be a way to feed a the kernel config a text file listing 
what to make in the cpio file instead of just pointing it at a 
directory, and my old Aboriginal Linux build used that mechanism 
(generating such a file by hand, borrowing the kernel infrastructure but 
driving it manually) 15 years ago:

https://landley.net/aboriginal/about.html

https://github.com/landley/aboriginal/blob/master/sources/functions.sh#L403

But kernel commit 469e87e89fd6 broke that mechanism because somebody 
dunning-krugered it away ("I don't understand why we need this therefore 
nobody needs it"). I had a patch to unbreak it for a while:

https://landley.net/bin/mkroot/0.8.10/linux-patches/0011-gen_init_cpio-regression.patch

But as with so many patches, lkml wasn't interested. (I mostly post them 
so when copyright trolls try to rattle sabers I can point to an lkml web 
archive entry that got ignored, and explain precisely HOW much bad PR 
they're in for when they proceed.)

And again: you ONLY need this for static initramfs. Dynamic initramfs 
has code create /dev/console (at boot time, not build time):

https://github.com/torvalds/linux/blob/v6.16/init/noinitramfs.c#L27

That code ONLY gets called for the external initrd loader, it does NOT 
get called when a static initramfs image built into the kernel has a 
runnable /init. This is an inconsistency in the kernel behavior, which 
is what I'm objecting to.

> It's extremely straightforward
> to emit devices nodes in cpio format, and IMO it's far *more*
> straightforward to do that than to make a whole directory, try to get
> all the modes right, and cpio it up.

You mean like commit 595a22acee26 from 2017?

> I wrote an absolutely trivial tool for this several years ago:
> 
> https://github.com/amluto/virtme/blob/master/virtme/cpiowriter.py

Let's see, I wrote the initramfs documentation in 2005:

https://lwn.net/Articles/157676/

Was already correcting kernel developers on how it actually worked 
(rather than theoretically worked) in 2006:

https://lkml.iu.edu/hypermail//linux/kernel/0603.2/2760.html

I added tmpfs support to it in 2013 (because nobody else had bothered 
for EIGHT YEARS):

https://lkml.iu.edu/hypermail/linux/kernel/1306.3/04204.html

I've maintained my own cpio implementation in toybox for over a decade:

https://github.com/landley/toybox/commit/a2d558151a63

The successor to aboriginal (above) is a 400 line bash script that 
builds a dozen archtectures that each boot to a shell prompt in qemu:

https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh
https://landley.net/bin/mkroot/latest/

With automated regression test infrastructure to boot them all under 
qemu and confirm that it runs, the clocks are set right, the network 
works, and it can read from -hda:

https://github.com/landley/toybox/blob/master/mkroot/testroot.sh

So yes I _can_ create my own bespoke C program to modify the file in 
arbitrary ways, I have my reasons not to do that, and have thought about 
them for a while now.

> it would be barely more complicated to strip the trailer off an cpio
> file from some other source, add some device nodes, and stick the
> trailer back on.

So you're unaware that the kernel accepts concatenated archives, and you 
can just cat together two cpio.gz files and they'll extract. (In gzip 
anyway, I haven't tested the other compression formats. That's why I 
needed to do https://github.com/landley/toybox/commit/dafb9211c777 and 
95a15d238120 by the way.)

The problem is there's no portable existing userspace tool to create a 
cpio archive from non-filesystem data. Partly because there WAS a 
mechanism built into the kernel... until that guy broke it in 2020. When 
I'm making a squashfs I've got the -p option (presumably modeled on what 
the kernel used to do before it broke), but the host cpio hasn't got a 
way to specify that and adding my own bespoke format to toybox... I'm 
still trying to get 
https://lists.gnu.org/archive/html/coreutils/2023-08/msg00009.html into 
coreutils. (Alas lkml isn't the only 30 year old community that's gotten 
stiff and hard of hearing.)

I could emit cpio contents with xxd -r from a HERE document hexdump or 
something to append to the generated file, but xxd isn't installed by 
default on debian and echo \x is WAY ugly, and "here's a giant hex dump 
you're not expected to understand" isn't really something I want to add 
to an otherwise understandable build. Writing, building, and running my 
own bespoke tool in C to do it isn't really an improvement over the hexdump.

The kernel ALMOST already does this. The code just needs to be 
refactored a bit, preferably so there aren't two codepaths each with 
half the testing.

> But it's also really, really, really easy to emit an
> entire, functioning cpio-formatted initramfs from plain user code with
> no filesystem manipulation at all.  This also makes that portion of
> the build reproducible, which is worth quite a bit IMO.

Sigh. When I started working on reproducible builds they weren't called 
that yet, but I don't think digging for more links would help here. I 
did do a rollup of what I'm trying to accomplish 5 years ago though 
http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html 
and long long ago, there was https://landley.net/aboriginal/history.html 
and...

Query: is your "plain user code" built with "cc"? Do you reliably have a 
"cc" link, or do you need to explicitly say "gcc" or "clang"? The kernel 
needs to do the latter for some reason, and my patch to GET to the 
kernel to at least _try_ "cc" before falling back to the others was 
explicitly rejected...

> --Andy

Rob
