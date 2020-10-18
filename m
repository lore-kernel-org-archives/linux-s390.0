Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
From: Colm MacCarthaigh <colmmacc@amazon.com>
Date: Sat, 17 Oct 2020 20:14:47 -0700
Message-ID: <6A556D58-04B7-4FC6-A7F9-138BD7E41731@amazon.com>
In-Reply-To: <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Jann Horn <jannh@google.com>, Willy Tarreau <w@1wt.eu>, "Catangiu, Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "Woodhouse, David" <dwmw@amazon.co.uk>, bonzini@gnu.org, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>



On 17 Oct 2020, at 6:24, Jason A. Donenfeld wrote:

> There are a few design goals of notifying userspace: it should be
> fast, because people who are using userspace RNGs are usually doing so
> in the first place to completely avoid syscall overhead for whatever
> high performance application they have - e.g. I recall conversations
> with Colm about his TLS implementation needing to make random IVs
> _really_ fast.

That’s our old friend TLS1.1 in CBC mode, which needs a random 
explicit IV for every record sent. Speed is still a reason at the 
margins in cases like that, but getrandom() is really fast. A stickier 
problem is that getrandom() is not certified for use with every 
compliance standard, and those often dictate precise use of some NIST 
DRBG or NRBG construction. That keeps people proliferating user-space 
RNGs even when speed isn’t as important.

> It should also happen as early as possible, with no
> race or as minimal as possible race window, so that userspace doesn't
> begin using old randomness and then switch over after the damage is
> already done.

+1 to this, and I’d add that anyone making VM snapshots that they plan 
to restore from multiple times really needs to think this through top to 
bottom. The system would likely need to be put in to some kind of 
quiescent state when the snapshot is taken.

> So, anyway, here are a few options with some pros and cons for the
> kernel notifying userspace that its RNG should reseed.
>
> 1. SIGRND - a new signal. Lol.
>
> 2. Userspace opens a file descriptor that it can epoll on. Pros are
> that many notification mechanisms already use this. Cons is that this
> requires syscall and might be more racy than we want. Another con is
> that this a new thing for userspace programs to do.

A library like OpenSSL or BoringSSL also has to account for running 
inside a chroot, which also makes this hard.

> Any thoughts on 4c? Is that utterly insane, or does that actually get
> us somewhere close to what we want?

I still like 4c, and as a user-space crypto-person, and a VM person, 
they have a lot of appeal. Alex and Adrian’s replies get into some of 
the sufficiency challenge. But for user-space libraries like the *SSLs, 
the JVMs, and other runtimes where RNGs show up, it could plug in easily 
enough.

-
Colm
