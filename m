From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 2/2] KVM: s390: use cookies for ioeventfd
Date: Wed, 3 Jul 2013 18:33:25 +0200
Message-ID: <20130703183325.2d483df8@gondolin>
References: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com>
	<1372861854-23043-3-git-send-email-cornelia.huck@de.ibm.com>
	<51D443A0.9040703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <51D443A0.9040703@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 03 Jul 2013 17:30:40 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il 03/07/2013 16:30, Cornelia Huck ha scritto:
> > +	/*
> > +	 * Return cookie in gpr 2, but don't overwrite the register if the
> > +	 * diagnose will be handled by userspace.
> > +	 */
> > +	if (ret != -EOPNOTSUPP)
> > +		vcpu->run->s.regs.gprs[2] = ret;
> 
> I think this should now be "if (ret >= 0)".

Hm, we don't want to kill gpr 2's old contents if userspace will do
something, which means -EOPNOTSUPP.

> 
> >  	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
> 
> The comment is now obsolete.

s/kvm_io_bus_write/kvm_io_bus_write_cookie/ ? Otherwise, this is still
true.

> 
> >  	return ret < 0 ? ret : 0;
> 
> Otherwise looks good, thanks!
> 
> Paolo
> 
