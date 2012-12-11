From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] s390: I/O interrupt and machine check
 injection.
Date: Tue, 11 Dec 2012 13:17:30 +0100
Message-ID: <20121211131730.3afb0809@BR9GNB5Z>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-4-git-send-email-cornelia.huck@de.ibm.com>
	<82610216-94CA-44E8-B3CE-EB94886CECFC@suse.de>
	<20121210112726.0697bc4f@BR9GNB5Z>
	<1355185588.21015.1@driftwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1355185588.21015.1@driftwood>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Rob Landley <rob@landley.net>
Cc: Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 10 Dec 2012 18:26:28 -0600
Rob Landley <rob@landley.net> wrote:

> What do you actually use to run Linux under this target? There are some  
> leads at
> http://virtuallyfun.superglobalmegacorp.com/?p=1206 which more or less  
> leads to
> http://ftp.nl.debian.org/debian/dists/Debian6.0.6/main/installer-s390/current/images/generic/  
> but I dunno what qemu command line would go along with those files...
> 
> Any hints?

The easiest way is probably to use an existing Linux/390 installation
on a disk attached to your system and an external monolithic kernel
containing the virtio-ccw guest support patches and the virtio drivers:

s390x-softmmu/qemu-system-s390x -machine s390-ccw -m 1024 -smp 2 -enable-kvm -kernel /path/to/your/kernel -drive file=/dev/sda,if=none,media=disk,id=drive-virtio-disk0 -device virtio-blk-ccw,devno=fe.0.0815,drive=drive-virtio-disk0,id=virtio-disk0 -append "root=/dev/vda1" -nographic
