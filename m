Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730334AbgDQJiq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Apr 2020 05:38:46 -0400
Received: by mail-wm1-f69.google.com with SMTP id c196so593294wmd.3
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 02:38:43 -0700 (PDT)
Date: Fri, 17 Apr 2020 05:38:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vhost: do not enable VHOST_MENU by default
Message-ID: <20200417053803-mutt-send-email-mst@kernel.org>
References: <20200416185426-mutt-send-email-mst@kernel.org>
 <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
 <20200417022929-mutt-send-email-mst@kernel.org>
 <4274625d-6feb-81b6-5b0a-695229e7c33d@redhat.com>
 <20200417042912-mutt-send-email-mst@kernel.org>
 <fdb555a6-4b8d-15b6-0849-3fe0e0786038@redhat.com>
 <20200417044230-mutt-send-email-mst@kernel.org>
 <73843240-3040-655d-baa9-683341ed4786@redhat.com>
 <20200417050029-mutt-send-email-mst@kernel.org>
 <ce8a18e5-3c74-73cc-57c5-10c40af838a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce8a18e5-3c74-73cc-57c5-10c40af838a3@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, geert@linux-m68k.org, tsbogend@alpha.franken.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>

On Fri, Apr 17, 2020 at 05:33:56PM +0800, Jason Wang wrote:
> 
> On 2020/4/17 下午5:01, Michael S. Tsirkin wrote:
> > > There could be some misunderstanding here. I thought it's somehow similar: a
> > > CONFIG_VHOST_MENU=y will be left in the defconfigs even if CONFIG_VHOST is
> > > not set.
> > > 
> > > Thanks
> > > 
> > BTW do entries with no prompt actually appear in defconfig?
> > 
> 
> Yes. I can see CONFIG_VHOST_DPN=y after make ARCH=m68k defconfig

You see it in .config right? So that's harmless right?

-- 
MST
