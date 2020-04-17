Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26644 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727911AbgDQGdv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 02:33:51 -0400
Received: by mail-wr1-f71.google.com with SMTP id i10so514822wrq.8
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 23:33:48 -0700 (PDT)
Date: Fri, 17 Apr 2020 02:33:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vhost: do not enable VHOST_MENU by default
Message-ID: <20200417022929-mutt-send-email-mst@kernel.org>
References: <20200415024356.23751-1-jasowang@redhat.com>
 <20200416185426-mutt-send-email-mst@kernel.org>
 <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, geert@linux-m68k.org, tsbogend@alpha.franken.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>

On Fri, Apr 17, 2020 at 11:12:14AM +0800, Jason Wang wrote:
> 
> On 2020/4/17 上午6:55, Michael S. Tsirkin wrote:
> > On Wed, Apr 15, 2020 at 10:43:56AM +0800, Jason Wang wrote:
> > > We try to keep the defconfig untouched after decoupling CONFIG_VHOST
> > > out of CONFIG_VIRTUALIZATION in commit 20c384f1ea1a
> > > ("vhost: refine vhost and vringh kconfig") by enabling VHOST_MENU by
> > > default. Then the defconfigs can keep enabling CONFIG_VHOST_NET
> > > without the caring of CONFIG_VHOST.
> > > 
> > > But this will leave a "CONFIG_VHOST_MENU=y" in all defconfigs and even
> > > for the ones that doesn't want vhost. So it actually shifts the
> > > burdens to the maintainers of all other to add "CONFIG_VHOST_MENU is
> > > not set". So this patch tries to enable CONFIG_VHOST explicitly in
> > > defconfigs that enables CONFIG_VHOST_NET and CONFIG_VHOST_VSOCK.
> > > 
> > > Acked-by: Christian Borntraeger<borntraeger@de.ibm.com>  (s390)
> > > Acked-by: Michael Ellerman<mpe@ellerman.id.au>  (powerpc)
> > > Cc: Thomas Bogendoerfer<tsbogend@alpha.franken.de>
> > > Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> > > Cc: Paul Mackerras<paulus@samba.org>
> > > Cc: Michael Ellerman<mpe@ellerman.id.au>
> > > Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
> > > Cc: Vasily Gorbik<gor@linux.ibm.com>
> > > Cc: Christian Borntraeger<borntraeger@de.ibm.com>
> > > Reported-by: Geert Uytterhoeven<geert@linux-m68k.org>
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > I rebased this on top of OABI fix since that
> > seems more orgent to fix.
> > Pushed to my vhost branch pls take a look and
> > if possible test.
> > Thanks!
> 
> 
> I test this patch by generating the defconfigs that wants vhost_net or
> vhost_vsock. All looks fine.
> 
> But having CONFIG_VHOST_DPN=y may end up with the similar situation that
> this patch want to address.
> Maybe we can let CONFIG_VHOST depends on !ARM || AEABI then add another
> menuconfig for VHOST_RING and do something similar?
> 
> Thanks

Sorry I don't understand. After this patch CONFIG_VHOST_DPN is just
an internal variable for the OABI fix. I kept it separate
so it's easy to revert for 5.8. Yes we could squash it into
VHOST directly but I don't see how that changes logic at all.

-- 
MST
