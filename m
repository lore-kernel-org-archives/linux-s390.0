Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D81DB95E;
	Mon, 15 Sep 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970328; cv=pass; b=TaHoy7FM9H+JbvPh1P7i7OrFqGYnU/pQZAUIyify54dv22CbuCl0Ljir/a51acKu0guNwYg30+xSzVdspurZeCVibf57xQH5YUUaf9AIQvU+aSLpPSpteObi14TSSlHv8i4ZEmndqs/3zukbcaVskfucfAC0yeYPbJGovCfQ26U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970328; c=relaxed/simple;
	bh=XM3XKQ5jJB/NRmfxGIRymJW83Dn38opP9h7KE9Mh1Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvGCr5n6CAU8qzaHRbAUSIASqxrFtq2P3CtIJguKOX5sL35uDOxifnDq7UZombbGm9Q2bJ1aTa+zGgMaK7Nk8BPhjf1lI6/LNCo0q5yXkV1zVBX0IXd/HKqNh+6iotAVM8dBBzzV0/dYiGGBj+CLjAu4d9QAd7aCuRK4q/KC8Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=hn99im0l; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="hn99im0l"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 15EBC42842;
	Mon, 15 Sep 2025 21:05:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (trex-blue-8.trex.outbound.svc.cluster.local [100.107.107.75])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7E9D242908;
	Mon, 15 Sep 2025 21:05:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757970319; a=rsa-sha256;
	cv=none;
	b=qGBCJqaBawMZAnONrTbFig1eEnp5gacr3aYcpOcD1dDYTPsX6nwhYplfBMd7L0of/gIXmz
	CagYaFNMPE0NNJoiF0V5loCpFMdLuyQwGab/xvbCX8rXH0GS1PIdqH6DjpP+f8WwmbM0N8
	mYL9aZ2QF9IHZ0LVo440g3RFDJ8NJuM/8PAsrlSQGj16xWQYeTlOhwHjBoExgtm5DyoBvW
	mr8Su8vrD4NuqYozfOAFSpN5dS68NBUQooAGJEy59qbAAhIPLBPSosxNPJFAnd+GtmiTwY
	cx8vGounvXOoq60QBUmHQJ4cf2B6TZBr6D9ZFvmbYaqP1lc2d+CjYCTyv9WKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757970319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uCpj1HrCG/lIFPmsjCJyYsttI0Vr58GFZK2WKDkB6bM=;
	b=70vv5qujaEA0nfpQrZIgWxkp+vtSGh+5xVsC3Y371S62PkzP+TW02KeCvWjUptfbbpaydh
	Gn9o8lLcjPc0L4aRKWgy24Jj6IfN40pkoLFXP4Z/8m5nUMqPxmx1LRyuqtXhq72d6f+4+J
	X8un2bAB1Eqc97KOQk0vNZ6v3Shubz7p+jutJB9RpWdW3m5X+Y5MMfNvCCKxchbWLIQsaY
	31guqGOn+VBDhFTevmEeayAJucpCgnUb6ibi+vf0GrjW+GRSU/5eaEDiSPhGnUz/oCyD4K
	njJ0vBOfYQ/tPzTgqSpJ4W2IDYO234JylLULDxm479e96TF5xBxtQVqNHTZcmw==
ARC-Authentication-Results: i=1;
	rspamd-76d5d85dd7-lnwpr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Society-Army: 531e81e06c13dcf7_1757970319753_132072418
X-MC-Loop-Signature: 1757970319753:1485129479
X-MC-Ingress-Time: 1757970319753
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.107.75 (trex/7.1.3);
	Mon, 15 Sep 2025 21:05:19 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4cQcxR2ZPnzFr;
	Mon, 15 Sep 2025 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1757970319;
	bh=uCpj1HrCG/lIFPmsjCJyYsttI0Vr58GFZK2WKDkB6bM=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=hn99im0llKSPW8E4jU23jnYGHjKkBB42PZKG9Y5nexC8X6GV18Ye+xjEO0dI68API
	 P0iIc1uUspgFQAEvTZJLAiGacD/gPQaqYVm1QWE0N/6QokQnP06W1bW8XwSoYhszK+
	 lhn3ZJav0Djh8uCO1T1JTFZ2nxRyoQNIwSBLc+tBT4L5AJvvFnEk/puQX4fjV81Sze
	 CQbiCBjHhliP+rleng7xNOeK8VpGNGP6Px4E+lL1g37CD4cYE8Qe9KRdlQRN3asHoO
	 TI/V5yxrsCSuRB+QTSU/G3DsOoX+FIakqvSZS3fVzb5U3KSBT5DjgaaVyyrqpLaA73
	 VR4ur/x6Wjb7g==
Message-ID: <8f595eec-e85e-4c1f-acb0-5069a01c1012@landley.net>
Date: Mon, 15 Sep 2025 16:05:14 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 17/62] doc: modernize
 Documentation/filesystems/ramfs-rootfs-initramfs.rst
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-18-safinaskar@gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250913003842.41944-18-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 19:37, Askar Safin wrote:
> Update it to reflect initrd removal.
> 
> Also I specified that error reports should
> go to linux-doc@vger.kernel.org , because
> Rob Landley said that he keeps getting
> reports about this document and is unable
> to fix them

Do you think emailing a list I could forward stuff to will improve matters?

I find the community an elaborate bureaucracy unresponsive to hobbyists. 
Documentation/process/submitting-patches.rst being a 934 line document 
with a bibliography, plus a 24 step checklist not counting the a) b) c) 
subsections are just symptoms. The real problem is following those is 
not sufficient to navigate said bureaucracy.

>   What is ramfs?
>   --------------
>   
> @@ -101,9 +103,9 @@ archive is extracted into it, the kernel will fall through to the older code
>   to locate and mount a root partition, then exec some variant of /sbin/init
>   out of that.
>   
> -All this differs from the old initrd in several ways:
> +All this differs from the old initrd (removed in 2025) in several ways:

Why keep the section when you removed the old mechanism? You took away 
their choices, you don't need to sell them on it.

(Unless you're trying to sell them on using a current linux kernel 
rather than 2.6 or bsd or qnx or something. But if they _do_ remove 32 
bit support, or stick a rust dependency in the base build, I suspect 
that ship has sailed...)

> -  - The old initrd was always a separate file, while the initramfs archive is
> +  - The old initrd was always a separate file, while the initramfs archive can be
>       linked into the linux kernel image.  (The directory ``linux-*/usr`` is
>       devoted to generating this archive during the build.)
>   
> @@ -137,7 +139,7 @@ Populating initramfs:
>   
>   The 2.6 kernel build process always creates a gzipped cpio format initramfs
>   archive and links it into the resulting kernel binary.  By default, this
> -archive is empty (consuming 134 bytes on x86).
> +archive is nearly empty (consuming 134 bytes on x86).

Those two lines you just touched contradict each other.

For historical reference, commit c33df4eaaf41 in 2007 added a second 
codepath to special case NOT having an initramfs, for some reason. 
That's how static linked cpio in the kernel image and external initrd= 
loaded cpio from the bootloader wound up having different behavior.

The init/noinitramfs.c file does init/mkdir("/dev") and 
init_mknod("/dev/console") because calling the syscall_blah() functions 
directly was considered icky so they created gratuitous wrappers to do 
it for you instead, because that's cleaner somehow. (Presumably the same 
logic as C++ having get and set methods that perform a simple assignment 
and return a value. Because YOU can't be trusted to touch MY code.)

Note that ONLY init/noinitramfs.c creates /dev/console. You'd THINK the 
logical thing to do would be to detect failure of the filp_open() in 
console_on_rootfs() and do the mkdir/mknod there and retry (since that's 
__init code too), but no...

My VERY vague recollection from back in the dark ages is if you didn't 
specify any INITRAMFS_SOURCE in kconfig then gen_init_cpio got called 
with no arguments and spit out a "usage" section that got interpreted as 
scripts/gen_initramfs_list.sh output, back when the plumbing ignored 
lines it didn't understand but there was an "example: a simple 
initramfs" section in the usage with "dir /dev" and "nod /dev/console" 
lines that created a cpio archive with /dev/console in it which would 
get statically linked in as a "default", and code reached out and used 
this because it was there without understanding WHY it was there. So it 
initially worked by coincidence, and rather than make it explicit they 
went "two codepaths, half the testing!" and thus...

Anyway, that's why the 130+ byte archive was there. It wasn't actually 
empty, even when initramfs was disabled.

One of the "cleanups that didn't actually fix it" was 
https://github.com/mpe/linux-fullhistory/commit/2bd3a997befc if you want 
to dig into the history yourself. I wrote my docs in 2005 and that was 
2010 so "somewhere in there"...

> -If the kernel has initrd support enabled, an external cpio.gz archive can also
> -be passed into a 2.6 kernel in place of an initrd.  In this case, the kernel
> -will autodetect the type (initramfs, not initrd) and extract the external cpio
> +If the kernel has CONFIG_BLK_DEV_INITRD enabled, an external cpio.gz archive can also

You renamed that symbol, then even you use the old name here.

> +be passed into a 2.6 kernel.  In this case, the kernel will extract the external cpio
>   archive into rootfs before trying to run /init.
>   
> -This has the memory efficiency advantages of initramfs (no ramdisk block
> -device) but the separate packaging of initrd (which is nice if you have
> +This is nice if you have
>   non-GPL code you'd like to run from initramfs, without conflating it with
> -the GPL licensed Linux kernel binary).
> +the GPL licensed Linux kernel binary.

IANAL: Whether or not this qualifies as "mere aggregation" had yet to go 
to court last I heard.

Which is basically why 
https://hackmd.io/@starnight/Load_Firmware_Files_Later_in_Linux_Kernel 
was so screwed up in the first place: the logical thing to do would be 
put the firmware in a static initramfs and have the module 
initialization happen after initramfs was populated... BUT LICENSING! We 
must have a much more complicated implementation because license. I 
believe I suggested passing said initramfs in via the initrd mechanism 
so it remains a separate file until boot time, and was ignored. *shrug* 
The usual...

>   It can also be used to supplement the kernel's built-in initramfs image.  The
>   files in the external archive will overwrite any conflicting files in
> @@ -278,7 +278,7 @@ User Mode Linux, like so::
>     EOF
>     gcc -static hello.c -o init
>     echo init | cpio -o -H newc | gzip > test.cpio.gz
> -  # Testing external initramfs using the initrd loading mechanism.
> +  # Testing external initramfs.

Does grub not still call it "initrd"?

>     qemu -kernel /boot/vmlinuz -initrd test.cpio.gz /dev/zero

A) they added -hda so you don't have to give it a dummy /dev/zero anymore.

B) there's no longer a "qemu" defaulting to the current architecture, 
you have to explicitly specify qemu-system-blah unless you create the 
symlink yourself by hand. This was considered an "improvement" by IBM 
bureaucrats. (Not a regression, a "feature". Oh well...)

C) to be honest I'd just point people at mkroot for examples these days, 
but I'm biased. (It smells like me.)

Rob
