From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: kvm-io: support cookies
Date: Wed, 03 Jul 2013 11:21:23 +0200
Message-ID: <51D3ED13.2020408@redhat.com>
References: <1372841780-29645-1-git-send-email-cornelia.huck@de.ibm.com> <1372841780-29645-2-git-send-email-cornelia.huck@de.ibm.com> <51D3E96E.5080405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <51D3E96E.5080405@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 03/07/2013 11:05, Paolo Bonzini ha scritto:
> Nice idea, though I don't really like the duplication between
> kvm_io_bus_write and kvm_io_bus_write_cookie.
> 
> Can you make kvm_io_bus_write, and perhaps kvm_io_bus_read too, return
> the cookie, and return -EINVAL here if the cookie is garbage?

On second though---no need to return -EINVAL, you can just pass the
cookie by value and tail-call kvm_io_bus_write.  Whatever makes the s390
code look nicer.

Paolo

> (Unfortunately, most callers of kvm_io_bus_read/write expect them to
> never return a value that is >= 0, but there aren't many so it's easily
> solved).
