Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu> <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com> <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu> <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu> <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
In-Reply-To: <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 17 Oct 2020 15:24:08 +0200
Message-ID: <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Willy Tarreau <w@1wt.eu>, Colm MacCarthaigh <colmmacc@amazon.com>, "Catangiu, Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "Woodhouse, David" <dwmw@amazon.co.uk>, bonzini@gnu.org, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>

After discussing this offline with Jann a bit, I have a few general
comments on the design of this.

First, the UUID communicated by the hypervisor should be consumed by
the kernel -- added as another input to the rng -- and then userspace
should be notified that it should reseed any userspace RNGs that it
may have, without actually communicating that UUID to userspace. IOW,
I agree with Jann there. Then, it's the functioning of this
notification mechanism to userspace that is interesting to me.

There are a few design goals of notifying userspace: it should be
fast, because people who are using userspace RNGs are usually doing so
in the first place to completely avoid syscall overhead for whatever
high performance application they have - e.g. I recall conversations
with Colm about his TLS implementation needing to make random IVs
_really_ fast. It should also happen as early as possible, with no
race or as minimal as possible race window, so that userspace doesn't
begin using old randomness and then switch over after the damage is
already done.

I'm also not wedded to using Microsoft's proprietary hypervisor design
for this. If we come up with a better interface, I don't think it's
asking too much to implement that and reasonably expect for Microsoft
to catch up. Maybe someone here will find that controversial, but
whatever -- discussing ideal designs does not seem out of place or
inappropriate for how we usually approach things in the kernel, and a
closed source hypervisor coming along shouldn't disrupt that.

So, anyway, here are a few options with some pros and cons for the
kernel notifying userspace that its RNG should reseed.

1. SIGRND - a new signal. Lol.

2. Userspace opens a file descriptor that it can epoll on. Pros are
that many notification mechanisms already use this. Cons is that this
requires syscall and might be more racy than we want. Another con is
that this a new thing for userspace programs to do.

3. We stick an atomic counter in the vDSO, Jann's suggestion. Pros are
that this is extremely fast, and also simple to use and implement.
There are enough sequence points in typical crypto programs that
checking to see whether this counter has changed before doing whatever
operation seems easy enough. Cons are that typically we've been
conservative about adding things to the vDSO, and this is also a new
thing for userspace programs to do.

4. We already have a mechanism for this kind of thing, because the
same issue comes up when fork()ing. The solution was MADV_WIPEONFORK,
where userspace marks a page to be zeroed when forking, for the
purposes of the RNG being notified when its world gets split in two.
This is basically the same thing as we're discussing here with guest
snapshots, except it's on the system level rather than the process
level, and a system has many processes. But the problem space is still
almost the same, and we could simply reuse that same mechanism. There
are a few implementation strategies for that:

4a. We mess with the PTEs of all processes' pages that are
MADV_WIPEONFORK, like fork does now, when the hypervisor notifies us
to do so. Then we wind up reusing the already existing logic for
userspace RNGs. Cons might be that this usually requires semaphores,
and we're in irq context, so we'd have to hoist to a workqueue, which
means either more wake up latency, or a larger race window.

4b. We just memzero all processes' pages that are MADV_WIPEONFORK,
when the hypervisor notifies us to do so. Then we wind up reusing the
already existing logic for userspace RNGs.

4c. The guest kernel maintains an array of physical addresses that are
MADV_WIPEONFORK. The hypervisor knows about this array and its
location through whatever protocol, and before resuming a
moved/snapshotted/duplicated VM, it takes the responsibility for
memzeroing this memory. The huge pro here would be that this
eliminates all races, and reduces complexity quite a bit, because the
hypervisor can perfectly synchronize its bringup (and SMP bringup)
with this, and it can even optimize things like on-disk memory
snapshots to simply not write out those pages to disk.

A 4c-like approach seems like it'd be a lot of bang for the buck -- we
reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
userspace API to deal with, and it'd be race free, and eliminate a lot
of kernel complexity.

But 4b and 3 don't seem too bad either.

Any thoughts on 4c? Is that utterly insane, or does that actually get
us somewhere close to what we want?

Jason
