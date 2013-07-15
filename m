From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 2/2] KVM: s390: use cookies for ioeventfd
Date: Mon, 15 Jul 2013 09:56:27 +0200
Message-ID: <20130715095627.229565e7@gondolin>
References: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com>
	<1372861854-23043-3-git-send-email-cornelia.huck@de.ibm.com>
	<51D443A0.9040703@redhat.com>
	<20130703183325.2d483df8@gondolin>
	<51D51C28.7040306@redhat.com>
	<20130714092516.GC4063@redhat.com>
	<20130714101959.GD4063@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130714101959.GD4063@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 14 Jul 2013 13:19:59 +0300
Gleb Natapov <gleb@redhat.com> wrote:

> On Sun, Jul 14, 2013 at 12:25:16PM +0300, Gleb Natapov wrote:

> > 1/2 broke x86. QEMU prints "Invalid read from memory region kvm-pic" and
> > guest hangs. Looks like IO is forwarded to userspace instead of in kernel device
> > for some reason. Un-applying for now.
> > 
> OK, stupid typo. Will amend the commit instead of dropping.
> 

Thanks for fixing.

> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6cde6fa..a86735d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2942,7 +2942,7 @@ static int __kvm_io_bus_read(struct kvm_io_bus *bus, struct kvm_io_range *range,
>  		return -EOPNOTSUPP;
> 
>  	while (idx < bus->dev_count &&
> -		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
> +		kvm_io_bus_sort_cmp(range, &bus->range[idx]) == 0) {
>  		if (!kvm_iodevice_read(bus->range[idx].dev, range->addr,
>  				       range->len, val))
>  			return idx;
> --
> 			Gleb.
> 
