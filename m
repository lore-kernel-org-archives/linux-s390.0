From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Avoiding information leaks between users and between processes
 by default? [Was: : [PATCH 1/5] prctl: add PR_ISOLATE_BP process control]
Date: Wed, 24 Jan 2018 15:42:54 +0000
Message-ID: <20180124154254.318ddde4@alans-desktop>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
        <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
        <20180123170719.GA4154@isilmar-4.linta.de>
        <20180124072953.50851fec@mschwideX1>
        <20180124083705.GA14868@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124083705.GA14868@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org, thomas.lendacky@amd.com, dwmw@amazon.co.uk, ak@linux.intel.com, pavel@ucw.cz
List-ID: <linux-s390.vger.kernel.org>

On Wed, 24 Jan 2018 09:37:05 +0100
> To my understanding, Linux traditionally tried to aim for the security goal
> of avoiding information leaks *between* users[+], probably even between
> processes of the same user. It wasn't a guarantee, and there always were

Not between processes of the same user in general (see ptrace or use gdb).

> (and will be) information leaks -- and that is where additional safeguards
> such as seccomp come into play, which reduce the attack surface against

seccomp is irrelevant on many processors (see the Armageddon paper). You
can (given willing partners) transfer data into and out of a seccomp
process at quite a respectable rate depending upon your hardware features.

> I am a bit worried whether this is a sign for a shift in the security goals.
> I fully understand that there might be processes (e.g. some[?] kernel
> threads) and users (root) which you need to trust anyway, as they can

dumpable is actually very useful but only in a specific way. The question
if process A is dumpable by process B then there is no meaningful
protection between them and you don't need to do any work. Likewise if A
and B can dump each other and are both running on the same ht pair you
don't have to worry about them attacking one another. In all those cases
they can do it with ptrace already.

[There's a corner case here of using BPF filters to block ptrace]

Alan
