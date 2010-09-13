From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Mon, 13 Sep 2010 09:41:13 +0200
Message-ID: <20100913094113.3c0ee732@mschwide.boeblingen.de.ibm.com>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
	<72A751CE-3F46-4D98-9FAF-BA1C1A95B6EE@suse.de>
	<4C8C96BB.2010804@redhat.com>
	<201009131305.58893.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <201009131305.58893.rusty@rustcorp.com.au>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Sep 2010 13:05:57 +0930
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Sun, 12 Sep 2010 06:30:43 pm Avi Kivity wrote:
> >   On 09/12/2010 02:42 AM, Alexander Graf wrote:
> > > On 24.08.2010, at 15:48, Alexander Graf wrote:
> > >
> > >> The one big missing feature in s390-virtio was hotplugging. This is no more.
> > >> This patch implements hotplug add support, so you can on the fly add new devices
> > >> in the guest.
> > >>
> > >> Keep in mind that this needs a patch for qemu to actually leverage the
> > >> functionality.
> > >>
> > >> Signed-off-by: Alexander Graf<agraf@suse.de>
> > > ping (on the patch set)?
> > >
> > 
> > Actually Marcelo applied it.  But the natural place for it is Rusty's 
> > virtio tree.  Rusty, if you want to take it, let me know and I'll drop 
> > it from kvm.git.
> 
> I thought it would be in the s390 tree, which is why I didn't take it...
> 
> But I'm *always* happy to let do the work!

I didn't pick them up after I saw that Marcelo took them. If others want
to do the work, be my guest..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
