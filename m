From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Fri, 30 Oct 2015 09:25:48 +0100
Message-ID: <20151030092548.7abd51e1.cornelia.huck@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
	<CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
	<5631629B.2050505@de.ibm.com>
	<CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 29 Oct 2015 15:50:38 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> Progress!  After getting that sort-of-working, I figured out what was
> wrong with my earlier command, and I got that working, too.  Now I
> get:
> 
> qemu-system-s390x -fsdev
> local,id=virtfs1,path=/,security_model=none,readonly -device
> virtio-9p-ccw,fsdev=virtfs1,mount_tag=/dev/root -M s390-ccw-virtio
> -nodefaults -device sclpconsole,chardev=console -parallel none -net
> none -echr 1 -serial none -chardev stdio,id=console,signal=off,mux=on
> -serial chardev:console -mon chardev=console -vga none -display none
> -kernel arch/s390/boot/bzImage -append
> 'init=/home/luto/devel/virtme/virtme/guest/virtme-init
> psmouse.proto=exps "virtme_stty_con=rows 24 cols 150 iutf8"
> TERM=xterm-256color rootfstype=9p
> rootflags=ro,version=9p2000.L,trans=virtio,access=any
> raid=noautodetect debug'

The commandline looks sane AFAICS.

(...)

> vrfy: device 0.0.0000: rc=0 pgroup=0 mpath=0 vpm=80
> virtio_ccw 0.0.0000: Failed to set online: -5
> 
> ^^^ bad news!

I'd like to see where in the onlining process this fails. Could you set
up qemu tracing for css_* and virtio_ccw_* (instructions in
qemu/docs/tracing.txt)?

Which qemu version is this, btw.?
