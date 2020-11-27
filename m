Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
 <CAG48ez2VAu6oARGVZ+muDK9_6_38KVUTJf7utz5Nn=AsmN17nA@mail.gmail.com>
 <CAG48ez13ZAAOVmA89PRKRqr9UezV2_bj8Q6_6sSPzcqfzbsuQQ@mail.gmail.com> <e4acbcdb-7ee4-5dfb-ffbf-19eb49cef9c6@amazon.com>
In-Reply-To: <e4acbcdb-7ee4-5dfb-ffbf-19eb49cef9c6@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 27 Nov 2020 21:20:19 +0100
Message-ID: <CAG48ez2akv0pGSt084sNHtESbjJNXpx=Ko86JEsyZM24+5zLqw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc: "Graf (AWS), Alexander" <graf@amazon.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, linux-s390 <linux-s390@vger.kernel.org>, "areber@redhat.com" <areber@redhat.com>, Pavel Emelyanov <ovzxemul@gmail.com>, Andrey Vagin <avagin@gmail.com>, Mike Rapoport <rppt@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>

On Fri, Nov 27, 2020 at 8:04 PM Catangiu, Adrian Costin
<acatan@amazon.com> wrote:
> On 27/11/2020 20:22, Jann Horn wrote:
> > On Fri, Nov 20, 2020 at 11:29 PM Jann Horn <jannh@google.com> wrote:
> >> On Mon, Nov 16, 2020 at 4:35 PM Catangiu, Adrian Costin
> >> <acatan@amazon.com> wrote:
> >>> This patch is a driver that exposes a monotonic incremental Virtual
> >>> Machine Generation u32 counter via a char-dev FS interface that
> >>> provides sync and async VmGen counter updates notifications. It also
> >>> provides VmGen counter retrieval and confirmation mechanisms.
> >>>
> >>> The hw provided UUID is not exposed to userspace, it is internally
> >>> used by the driver to keep accounting for the exposed VmGen counter.
> >>> The counter starts from zero when the driver is initialized and
> >>> monotonically increments every time the hw UUID changes (the VM
> >>> generation changes).
> >>>
> >>> On each hw UUID change, the new hypervisor-provided UUID is also fed
> >>> to the kernel RNG.
> >> As for v1:
> >>
> >> Is there a reasonable usecase for the "confirmation" mechanism? It
> >> doesn't seem very useful to me.
>
> I think it adds value in complex scenarios with multiple users of the
> mechanism, potentially at varying layers of the stack, different
> processes and/or runtime libraries.
>
> The driver offers a natural place to handle minimal orchestration
> support and offer visibility in system-wide status.
>
> A high-level service that trusts all system components to properly use
> the confirmation mechanism can actually block and wait patiently for the
> system to adjust to the new world. Even if it doesn't trust all
> components it can still do a best-effort, timeout block.

What concrete action would that high-level service be able to take
after waiting for such an event?

My model of the vmgenid mechanism is that RNGs and cryptographic
libraries that use it need to be fundamentally written such that it is
guaranteed that a VM fork can not cause the same random number /
counter / ... to be reused for two different cryptographic operations
in a way visible to an attacker. This means that e.g. TLS libraries
need to, between accepting unencrypted input and sending out encrypted
data, check whether the vmgenid changed since the connection was set
up, and if a vmgenid change occurred, kill the connection.

Can you give a concrete example of a usecase where the vmgenid
mechanism is used securely and the confirmation mechanism is necessary
as part of that?

> >> How do you envision integrating this with libraries that have to work
> >> in restrictive seccomp sandboxes? If this was in the vDSO, that would
> >> be much easier.
>
> Since this mechanism targets all of userspace stack, the usecase greatly
> vary. I doubt we can have a single silver bullet interface.
>
> For example, the mmap interface targets user space RNGs, where as fast
> and as race free as possible is key. But there also higher level
> applications that don't manage their own memory or don't have access to
> low-level primitives so they can't use the mmap or even vDSO interfaces.
> That's what the rest of the logic is there for, the read+poll interface
> and all of the orchestration logic.

Are you saying that, because people might not want to write proper
bindings for this interface while also being unwilling to take the
performance hit of calling read() in every place where they would have
to do so to be fully correct, you want to build a "best-effort"
mechanism that is deliberately designed to allow some cryptographic
state reuse in a limited time window?

> Like you correctly point out, there are also scenarios like tight
> seccomp jails where even the FS interfaces is inaccessible. For cases
> like this and others, I believe we will have to work incrementally to
> build up the interface diversity to cater to all the user scenarios
> diversity.

It would be much nicer if we could have one simple interface that lets
everyone correctly do what they need to, though...
