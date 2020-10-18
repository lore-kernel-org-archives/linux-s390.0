Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 18 Oct 2020 11:59:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201018115524-mutt-send-email-mst@kernel.org>
References: <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <20201018114625-mutt-send-email-mst@kernel.org>
 <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>, Willy Tarreau <w@1wt.eu>, Colm MacCarthaigh <colmmacc@amazon.com>, "Catangiu, Adrian Costin" <acatan@amazon.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "Woodhouse, David" <dwmw@amazon.co.uk>, bonzini@gnu.org, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>

On Sun, Oct 18, 2020 at 08:54:36AM -0700, Andy Lutomirski wrote:
> On Sun, Oct 18, 2020 at 8:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> > > 4c. The guest kernel maintains an array of physical addresses that are
> > > MADV_WIPEONFORK. The hypervisor knows about this array and its
> > > location through whatever protocol, and before resuming a
> > > moved/snapshotted/duplicated VM, it takes the responsibility for
> > > memzeroing this memory. The huge pro here would be that this
> > > eliminates all races, and reduces complexity quite a bit, because the
> > > hypervisor can perfectly synchronize its bringup (and SMP bringup)
> > > with this, and it can even optimize things like on-disk memory
> > > snapshots to simply not write out those pages to disk.
> > >
> > > A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> > > reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> > > userspace API to deal with, and it'd be race free, and eliminate a lot
> > > of kernel complexity.
> >
> > Clearly this has a chance to break applications, right?
> > If there's an app that uses this as a non-system-calls way
> > to find out whether there was a fork, it will break
> > when wipe triggers without a fork ...
> > For example, imagine:
> >
> > MADV_WIPEONFORK
> > copy secret data to MADV_DONTFORK
> > fork
> >
> >
> > used to work, with this change it gets 0s instead of the secret data.
> >
> >
> > I am also not sure it's wise to expose each guest process
> > to the hypervisor like this. E.g. each process needs a
> > guest physical address of its own then. This is a finite resource.
> >
> >
> > The mmap interface proposed here is somewhat baroque, but it is
> > certainly simple to implement ...
> 
> Wipe of fork/vmgenid/whatever could end up being much more problematic
> than it naively appears -- it could be wiped in the middle of a read.
> Either the API needs to handle this cleanly, or we need something more
> aggressive like signal-on-fork.
> 
> --Andy


Right, it's not on fork, it's actually when process is snapshotted.

If we assume it's CRIU we care about, then I
wonder what's wrong with something like
MADV_CHANGEONPTRACE_SEIZE
and basically say it's X bytes which change the value...


-- 
MST
