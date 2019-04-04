Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH RFC 0/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
References: <cover.1554396090.git.jpoimboe@redhat.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <ee83d3b8-d74a-dbeb-c838-0297b3c342c0@redhat.com>
Date: Thu, 4 Apr 2019 12:50:54 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1554396090.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404165054.iJV6ETT60vreD-Rl1FsxCk4pKUcybxmjvQFzn5MlZDs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On 04/04/2019 12:44 PM, Josh Poimboeuf wrote:
> Keeping track of the number of mitigations for all the CPU speculation
> bugs has become overwhelming for many users.  It's getting more and more
> complicated to decide which mitigations are needed for a given
> architecture.  Complicating matters is the fact that each arch tends to
> it own custom way to mitigate the same vulnerability.

... tends to "have its" own ... ?

-Longman
