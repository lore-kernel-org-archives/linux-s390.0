Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED9C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD3E61214
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 02:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhKSCiw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhKSCiw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Nov 2021 21:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637289351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvEXdVSQ33CYfJdfTY3g6zxywCtQTaTt9SO8R6Pches=;
        b=NThtaWTyzy9ATWseeNmFiaLpbKPl/NDPZJ5EDXxNKa2Wh2MHqAfCTobCBtYGBlVR4XY6ga
        9Cj+TCI20rcWRz2WpkId+cKibu7H4Yn6XnkOon8sMZ5xokjpHxUpHZ+5tS0XI3LOuz8UMH
        d6feFm1TcMSqS10pjrSBlRJgQ8KVGic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-2xHzU_kSMDGKuKU8EZrWyg-1; Thu, 18 Nov 2021 21:35:48 -0500
X-MC-Unique: 2xHzU_kSMDGKuKU8EZrWyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B43E18125C6;
        Fri, 19 Nov 2021 02:35:46 +0000 (UTC)
Received: from localhost (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E53CC100763D;
        Fri, 19 Nov 2021 02:35:33 +0000 (UTC)
Date:   Fri, 19 Nov 2021 10:35:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, prudo@redhat.com
Subject: Re: [PATCH v2 2/2] s390/kexec: fix kmemleak
Message-ID: <20211119023531.GB12774@MiWiFi-R3L-srv>
References: <20211116032557.14075-2-bhe@redhat.com>
 <202111180539.e7kmpOSP-lkp@intel.com>
 <20211118071327.GF21646@MiWiFi-R3L-srv>
 <YZYUi9XMyjtpGmAQ@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZYUi9XMyjtpGmAQ@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/18/21 at 09:53am, Heiko Carstens wrote:
> On Thu, Nov 18, 2021 at 03:13:27PM +0800, Baoquan He wrote:
> > On 11/18/21 at 05:46am, kernel test robot wrote:
> > >    arch/s390/kernel/machine_kexec_file.c: In function 'arch_kimage_file_post_load_cleanup':
> > > >> arch/s390/kernel/machine_kexec_file.c:332:9: error: implicit declaration of function 'kvfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
> > >      332 |         kvfree(image->arch.ipl_buf);
> > >          |         ^~~~~~
> > >          |         vfree
> > 
> > OK, kvfree is not wrong, seems vfree is more appropriate since it's
> > clear the ipl_buf is allocated with zvalloc() in ipl_report_finish().
> > 
> > Hi Heiko,
> > 
> > Could you help modify the code in your tree or append below patch to
> > mute the lkp complaint? Sorry for the inconvenience.
> ...
> >  arch/s390/kernel/machine_kexec_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> > index 7f51837e9bc2..351a7ff69a43 100644
> > --- a/arch/s390/kernel/machine_kexec_file.c
> > +++ b/arch/s390/kernel/machine_kexec_file.c
> > @@ -329,7 +329,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >  
> >  int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >  {
> > -	kvfree(image->arch.ipl_buf);
> > +	vfree(image->arch.ipl_buf);
> 
> The problem reported above indicates that slab.h was not
> included. With your patch, while it fixes the problem for this
> particular configuration, this requires vmalloc.h to be included.

Indeed, thanks.

> 
> I'll merge your patch and add the missing include as well.
> 

