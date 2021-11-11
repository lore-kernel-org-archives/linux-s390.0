Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A825C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 11 Nov 2021 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1982861247
	for <linux-s390@archiver.kernel.org>; Thu, 11 Nov 2021 00:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhKKAZk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhKKAZj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Nov 2021 19:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636590171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TDJg+pdCtnM6lS7EJ41XYk+4Tr9XchJbfkF9Ihtrc4=;
        b=JESbBynMGS/wrOv2VzTg8izLXn8arp4Tj9NxKuorbi/CMjltu02l3l2EtYxNRrZ5JvyGTH
        BcS6Q9t6VdLo4no7HwyZkwFs42fwHWUJdZaFiGr0+Db2Ln+jSZJsQ3V7JtXY18nnmEHu05
        eGs3N0FMu6XOZmtZAVw4h2vu5uJIr2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-vE1OVwnqOBuMu1idqC9_lw-1; Wed, 10 Nov 2021 19:22:48 -0500
X-MC-Unique: vE1OVwnqOBuMu1idqC9_lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 381901006AA0;
        Thu, 11 Nov 2021 00:22:47 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF0AB608BA;
        Thu, 11 Nov 2021 00:22:36 +0000 (UTC)
Date:   Thu, 11 Nov 2021 08:22:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        dyoung@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH] s390/kexec: fix memory leak of ipl report buffer
Message-ID: <20211111002233.GA10944@MiWiFi-R3L-srv>
References: <20211029092635.14804-1-bhe@redhat.com>
 <20211029183132.20839ad0@rhtmp>
 <YYviwi3PVD11xcCs@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYviwi3PVD11xcCs@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/10/21 at 04:18pm, Heiko Carstens wrote:
> On Fri, Oct 29, 2021 at 06:31:32PM +0200, Philipp Rudo wrote:
> > Hi Baoquan,
> > 
> > On Fri, 29 Oct 2021 17:26:35 +0800
> > Baoquan He <bhe@redhat.com> wrote:
> > 
> > > A memory leak is reported by kmemleak scanning:
> ...
> > > The ipl report buffer is allocated via vmalloc, while has no chance to free
> > > if the kexe loading is unloaded. This will cause obvious memory leak
> > > when kexec/kdump kernel is reloaded, manually, or triggered, e.g by
> > > memory hotplug.
> > > 
> > > Here, add struct kimage_arch to s390 to pass out the ipl report buffer
> > > address, and introduce arch dependent function
> > > arch_kimage_file_post_load_cleanup() to free it when unloaded.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > 
> > other than a missing
> > 
> > Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to
> > next kernel")
> > 
> > the patch looks good to me.
> > 
> > Reviewed-by: Philipp Rudo <prudo@redhat.com>
> ...
> > >  	buf.buffer = ipl_report_finish(data->report);
> > >  	buf.bufsz = data->report->size;
> > >  	buf.memsz = buf.bufsz;
> > > +	image->arch.ipl_buf = buf.buffer;
> 
> This seems (still) to be incorrect: ipl_report_finish() may return
> -ENOMEN, but there is no error checking anywhere, as far as I can
> tell, which would make this:
> 
> > > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > > +{
> > > +	kvfree(image->arch.ipl_buf);
> > > +	image->arch.ipl_buf = NULL;
> > > +
> > > +	return kexec_image_post_load_cleanup_default(image);
> > > +}
> 
> most likely not do what we want. That is: if this code is reached at
> all in such a case. I'll check and might add a patch before this to
> fix this also.

Right, we should check the returned value firstly. Thanks a lot for
reivewing, Heiko. I will post v2 to add a patch to check the returned
value as you suggested, and also update this patch to add missing Fixes tag. 

