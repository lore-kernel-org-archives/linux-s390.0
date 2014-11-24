From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
Date: Mon, 24 Nov 2014 10:35:39 -0800
Message-ID: <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
	<1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
	<15567.1416835858@warthog.procyon.org.uk>
	<CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 24, 2014 at 10:02 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> If the goal is to catch non-scalar users, the following is shorter:
> #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))

Me likey. It probably works well in practice, although I think

 - the "(typeof(x))0)" seems unnecessary and wrong. Why not just "0"?
The typeof is not just longer, but it is incorrect for pointer types
(you can add 0 to a pointer, but you cannot add two pointers together)

 - it does mean that the resulting type ends up being upgraded to
"int", for the usual C type reasons.

Note that the "upgraded to 'int'" is true with or without the
"(typeof(x))0". If you add two 'char' values, the addition is still
done in 'int'.

Maybe you *meant* that typeof to fix the second problem, like so:

  (typeof(x)) (0 + *(volatile typeof(x) *)&(x))

Hmm? That casts the result of the addition, not the zero.

             Linus
