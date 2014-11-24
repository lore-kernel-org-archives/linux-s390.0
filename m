From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
Date: Mon, 24 Nov 2014 09:30:43 -0800
Message-ID: <CA+55aFyhFfB52HCpnDeg0pbR-0=t=hsVjOACwnmMEQ=fhvaO2Q@mail.gmail.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
	<1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
	<15567.1416835858@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <15567.1416835858@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 24, 2014 at 5:30 AM, David Howells <dhowells@redhat.com> wrote:
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> +#define get_scalar_volatile_pointer(x) ({ \
>> +     typeof(x) *__p = &(x); \
>> +     volatile typeof(x) *__vp = __p; \
>> +     (void)(long)*__p; __vp; })
>> +#define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))
>
> Might this cause two loads from memory under some conditions?  Once for the
> fourth line and once for the fifth?

Hmm. Since the fourth line isn't volatile, I'd expect gcc to optimize
it away. But you're right, it might be safer to make sure the "test
type" part is something like

   (void)sizeof((long)*__p)

instead - the "sizeof()" means that it will never actually get
evaluated, but the type-checking of casting *__p to (long) will still
catch the case of *__p being some non-scalar type that cannot be cast.

                   Linus
