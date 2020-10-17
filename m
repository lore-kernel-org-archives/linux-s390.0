Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
From: Colm MacCarthaigh <colmmacc@amazon.com>
Date: Fri, 16 Oct 2020 22:29:14 -0700
Message-ID: <FF2CCC35-87DD-4311-A3CF-4943B29DBEE3@amazon.com>
In-Reply-To: <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Willy Tarreau <w@1wt.eu>, "Catangiu, Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>, Jason Donenfeld <Jason@zx2c4.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "Woodhouse, David" <dwmw@amazon.co.uk>, bonzini@gnu.org, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>



On 16 Oct 2020, at 22:01, Jann Horn wrote:
>
> On Sat, Oct 17, 2020 at 6:34 AM Colm MacCarthaigh 
> <colmmacc@amazon.com> wrote:
>> For user-space, even a single bit would do. We added 
>> MADVISE_WIPEONFORK
>> so that userspace libraries can detect fork()/clone() robustly, for 
>> the
>> same reasons. It just wipes a page as the indicator, which is
>> effectively a single-bit signal, and it works well. On the user-space
>> side of this, I’m keen to find a solution like that that we can use
>> fairly easily inside of portable libraries and applications. The 
>> “have
>> I forked” checks do end up in hot paths, so it’s nice if they can 
>> be
>> CPU cache friendly. Comparing a whole 128-bit value wouldn’t be my
>> favorite.
>
> I'm pretty sure a single bit is not enough if you want to have a
> single page, shared across the entire system, that stores the VM
> forking state; you need a counter for that.

You’re right. WIPEONFORK is more like a single-bit per use. If it’s 
something system wide then a counter is better.

> So the RNG state after mixing in the new VM Generation ID would
> contain 128 bits of secret entropy not known to anyone else, including
> people with access to the VM image.
>
> Now, 128 bits of cryptographically random data aren't _optimal_; I
> think something on the order of 256 bits would be nicer from a
> theoretical standpoint. But in practice I think we'll be good with the
> 128 bits we're getting (since the number of users who fork a VM image
> is probably not going to be so large that worst-case collision
> probabilities matter).

This reminds me on key/IV usage limits for AES encryption, where the 
same birthday bounds apply, and even though 256-bits would be better, we 
routinely make 128-bit birthday bounds work for massively scalable 
systems.

>> The kernel would need to use the change as a trigger to
>> measure some entropy (e.g. interrupts and RDRAND, or whatever). Our 
>> just
>> define the machine contract as “this has to be unique random data 
>> and
>> if it’s not unique, or if it’s pubic, you’re toast”.
>
> As far as I can tell from Microsoft's spec, that is a guarantee we're
> already getting.

Neat.

-
Colm
