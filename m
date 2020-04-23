Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbgDWOI0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 10:08:26 -0400
Date: Thu, 23 Apr 2020 16:08:17 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/protvirt: fix compilation issue
Message-ID: <20200423160817.2bc7b3fa@p-imbrenda>
In-Reply-To: <your-ad-here.call-01587646462-ext-4177@work.hours>
References: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
        <your-ad-here.call-01587646462-ext-4177@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, david@redhat.com, kbuild test robot <lkp@intel.com>, Philipp Rudo <prudo@linux.ibm.com>

On Thu, 23 Apr 2020 14:54:22 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Thu, Apr 23, 2020 at 02:01:14PM +0200, Claudio Imbrenda wrote:
> > The kernel fails to compile with
> > CONFIG_PROTECTED_VIRTUALIZATION_GUEST set but CONFIG_KVM unset.
> > 
> > This patch fixes the issue by making the needed variable always
> > available.  
> 
> This statement confuses me a bit.
> 
> It's worth to mention that both arch/s390/boot/uv.c (for the
> decompressor) and arch/s390/kernel/uv.c (for the main kernel) are only
> built when either CONFIG_PROTECTED_VIRTUALIZATION_GUEST or
> CONFIG_KVM is enabled.
> Both arch/s390/boot/Makefile and arch/s390/kernel/Makefile contain:
> obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST)
> $(CONFIG_PGSTE))   += uv.o
> 
> So this makes the variable available when
> CONFIG_PROTECTED_VIRTUALIZATION_GUEST or CONFIG_KVM (expressed via
> CONFIG_PGSTE) is enabled. Hence no need for extra conditions for
> variable declaration.

yes, "always available" when the file is compiled at all, obviously.

in fact, there are some probably useless ifdefs in that file too, but
this patch should only address the bug

> > Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware
> > interface for Ultravisor information") Reported-by: kbuild test
> > robot <lkp@intel.com> Reported-by: Philipp Rudo
> > <prudo@linux.ibm.com> Suggested-by: Philipp Rudo
> > <prudo@linux.ibm.com> CC: Vasily Gorbik <gor@linux.ibm.com>
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  arch/s390/boot/uv.c   | 2 --
> >  arch/s390/kernel/uv.c | 3 ++-
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> > index 8fde561f1d07..f887a479cdc7 100644
> > --- a/arch/s390/boot/uv.c
> > +++ b/arch/s390/boot/uv.c
> > @@ -7,9 +7,7 @@
> >  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> >  int __bootdata_preserved(prot_virt_guest);
> >  #endif
> > -#if IS_ENABLED(CONFIG_KVM)
> >  struct uv_info __bootdata_preserved(uv_info);
> > -#endif
> >  
> >  void uv_query_info(void)
> >  {
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index c86d654351d1..4c0677fc8904 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -23,10 +23,11 @@
> >  int __bootdata_preserved(prot_virt_guest);
> >  #endif
> >  
> > +struct uv_info __bootdata_preserved(uv_info);
> > +
> >  #if IS_ENABLED(CONFIG_KVM)
> >  int prot_virt_host;
> >  EXPORT_SYMBOL(prot_virt_host);
> > -struct uv_info __bootdata_preserved(uv_info);
> >  EXPORT_SYMBOL(uv_info);  
> 
> hm, EXPORT_SYMBOL(uv_info) is not needed without CONFIG_KVM and this
> saves 1 symbol export, but I'd still made EXPORT_SYMBOL follow the
> declaration immediately. Documentation/process/coding-style.rst
> mentions that only for function declarations though.

I was wondering the same regarding the export.

I don't have any strong opinions, so if anyone has a preference, speak
up and I can fix it.

> Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
