From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/8] s390: Add channel I/O instructions.
Date: Tue, 11 Dec 2012 13:53:51 +0100
Message-ID: <20121211135351.2e79daa6@BR9GNB5Z>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-5-git-send-email-cornelia.huck@de.ibm.com>
	<7024DD5C-C290-48C8-A1F2-8C8831011D1C@suse.de>
	<20121210101805.6f4645cd@BR9GNB5Z>
	<F6B1809B-676A-44CB-A054-B86BF0D537DA@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <F6B1809B-676A-44CB-A054-B86BF0D537DA@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 11 Dec 2012 11:18:44 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 10.12.2012, at 10:18, Cornelia Huck wrote:
> 
> > On Mon, 10 Dec 2012 10:00:16 +0100
> > Alexander Graf <agraf@suse.de> wrote:
> > 
> >> 
> >> 
> >> On 07.12.2012, at 13:50, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> >>> +/* Special handling for the prefix page. */
> >>> +static void *s390_get_address(CPUS390XState *env, ram_addr_t guest_addr)
> >>> +{
> >>> +    if (guest_addr < 8192) {
> >>> +        guest_addr += env->psa;
> >>> +    } else if ((env->psa <= guest_addr) && (guest_addr < env->psa + 8192)) {
> >>> +        guest_addr -= env->psa;
> >>> +    }
> >>> +
> >>> +    return qemu_get_ram_ptr(guest_addr);
> >> 
> >> Do we actually need this?
> > 
> > Yes. I've seen failures for I/O instructions using the lowcore (which
> > the Linux kernel likes to do).
> 
> Then we want an s390 generic function that does this, not an io specific one though, right? Also qemu_get_ram_ptr is a no-go, as it doesn't do boundary checks.

Oh, wasn't aware of that.

> 
> So what we really want is something like s390_cpu_physical_memory_map(env, ...) with a special case on the lowcore.

Let's see how this works out.

> >>> +    addr = ipb >> 28;
> >>> +    if (addr > 0) {
> >>> +        addr = env->regs[addr];
> >>> +    }
> >>> +    addr += (ipb & 0xfff0000) >> 16;
> >> 
> >> This adds the upper bits twice. Are you sire that's correct?
> > 
> > If addr was 0, it doesn't. If addr was > 0 before, we grabbed the
> > address from the corresponding register and want to add to it.
> 
> This is a very confusing way of writing what you're trying to express then :). How about
> 
> hwaddr addr = 0;
> 
> reg = ipb >> 28;
> if (reg) {
>     addr = env->regs[reg];
> }
> addr += (ipb >> 16) & 0xfff0;

I've moved this to a helper function anyway - but this looks a bit more
readable, yes.
