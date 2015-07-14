Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Jul 2015 20:10:16 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150714201016.161e4f39@holzheu>
In-Reply-To: <20150714140920.GA10792@redhat.com>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
	<20150710105413.04e1db00@holzheu>
	<20150710090322.GA5138@dhcp-128-21.nay.redhat.com>
	<20150710111406.279dba14@holzheu>
	<20150714140920.GA10792@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Minfei Huang <mnfhuang@gmail.com>, ebiederm@xmission.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 14 Jul 2015 10:09:20 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Jul 10, 2015 at 11:14:06AM +0200, Michael Holzheu wrote:
> 
> [..]
> > What about the following patch:
> > ---
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 7a36fdc..7837c4e 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1236,10 +1236,68 @@ int kexec_load_disabled;
> >  
> >  static DEFINE_MUTEX(kexec_mutex);
> >  
> > +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> 

[snip]

> > +
> > +failure_unmap_mem:
> 
> I don't like this tag "failure_unmap_mem". We are calling this both
> in success path as well as failure path. So why not simply call it "out".

Since the code is better readable now, I'm fine with "out" :-)

> 
> > +	if (flags & KEXEC_ON_CRASH)
> > +		crash_unmap_reserved_pages();
> > +	kimage_free(image);
> 
> Now kimage_free() is called with kexec_mutex held. Previously that was
> not the case. I hope that's not a problem.

Yes, I noticed that. But also in the original code there is already
one spot where kimage_free() is called under lock:

        /*
         * In case of crash, new kernel gets loaded in reserved region. It is
         * same memory where old crash kernel might be loaded. Free any
         * current crash dump kernel before we corrupt it.
         */
        if (flags & KEXEC_FILE_ON_CRASH)
                kimage_free(xchg(&kexec_crash_image, NULL));

Therefore I thought it should be ok.

Michael
