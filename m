Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu> <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com> <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu> <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu> <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com> <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
In-Reply-To: <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
From: Jann Horn <jannh@google.com>
Date: Sun, 18 Oct 2020 04:08:04 +0200
Message-ID: <CAG48ez0JYK2_tk0DuEgKY2y0d38N+O5HJrH2je7RRk6o7XBixA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Graf <graf@amazon.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Willy Tarreau <w@1wt.eu>, Colm MacCarthaigh <colmmacc@amazon.com>, "Catangiu, Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, bonzini@gnu.org, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

On Sat, Oct 17, 2020 at 8:09 PM Alexander Graf <graf@amazon.de> wrote:
> There are applications way beyond that though. What do you do with
> applications that already consumed randomness? For example a cached pool
> of SSL keys. Or a higher level language primitive that consumes
> randomness and caches its seed somewhere in an internal data structure.

For deterministic protection, those would also have to poll some
memory location that tells them whether the VmGenID changed:

1. between reading entropy from their RNG pool and using it
2. between collecting data from external sources (user input, clock,
...) and encrypting it

and synchronously shoot down the connection if a change happened. If
e.g. an application inside the VM has an AES-GCM-encrypted TLS
connection and, directly after the VM is restored, triggers an
application-level timeout that sends some fixed message across the
connection, then the TLS library must guarantee that either the VM was
already committed to sending exactly that message before the VM was
forked or the message will be blocked. If we don't do that, an
attacker who captures both a single packet from the forked VM and
traffic from the old VM can decrypt the next message from the old VM
after the fork (because AES-GCM is like AES-CTR plus an authenticator,
and CTR means that when keystream reuse occurs and one of the
plaintexts is known, the attacker can simply recover the other
plaintext using XOR).

(Or maybe, in disaster failover environments, TLS 1.3 servers could
get away with rekeying the connection instead of shooting it down? Ask
your resident friendly cryptographer whether that would be secure, I
am not one.)

I don't think a mechanism based around asynchronously telling the
application and waiting for it to confirm the rotation at a later
point is going to cut it; we should have some hard semantics on when
an application needs to poll this value.

> Or even worse: your system's host ssh key.

Mmmh... I think I normally would not want a VM to reset its host ssh
key after merely restoring a snapshot though? And more importantly,
Microsoft's docs say that they also change the VmGenID on disaster
failover. I think you very much wouldn't want your server to lose its
host key every time disaster failover happens. On the other hand,
after importing a public VM image, it might be a good idea.

I guess you could push that responsibility on the user, by adding an
option to the sshd_config that tells OpenSSH whether the host key
should be rotated on an ID change or not... but that still would not
be particularly pretty.

Ideally we would have the host tell us what type of events happened to
the VM, or something like that... or maybe even get the host VM
management software to ask the user whether they're importing a public
image... I really feel like with Microsoft's current protocol, we
don't get enough information to figure out what we should do about
private long-term authentication keys.
