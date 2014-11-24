From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
Date: Mon, 24 Nov 2014 13:30:58 +0000
Message-ID: <15567.1416835858@warthog.procyon.org.uk>
References: <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
Content-ID: <15470.1416835748.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, paulmck@linux.vnet.ibm.com, mingo@kernel.org, torvalds@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-ID: <linux-s390.vger.kernel.org>

Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> +#define get_scalar_volatile_pointer(x) ({ \
> +	typeof(x) *__p = &(x); \
> +	volatile typeof(x) *__vp = __p; \
> +	(void)(long)*__p; __vp; })
> +#define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))

Might this cause two loads from memory under some conditions?  Once for the
fourth line and once for the fifth?

(Apologies if this has already been discussed)

David
