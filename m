Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67017C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  7 Dec 2021 17:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhLGRWj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:22:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235660AbhLGRWi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Dec 2021 12:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638897546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYNdMSp2/bnC/tqj/M0RADUR7M1vytGWLh17FbECqTI=;
        b=CeT1usT7AQJ1lmctkRahbGNhKbpfs3saqIPI780Ml+LLdzMNCGCNifqhtcKsb7y6GwIY/B
        DJs2MSyHpsQ/6Cpnzy+MSg7SDiKPhRWiLKo6uicnOBuXON9wMfoLtWWuLbkKglMv7MYxSl
        ZlKueMAH9XoY/Iu+nWlXA23UTiDhyvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-ZqFqyxanOOSTzTmwBh9oiQ-1; Tue, 07 Dec 2021 12:19:03 -0500
X-MC-Unique: ZqFqyxanOOSTzTmwBh9oiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 634C010151EC;
        Tue,  7 Dec 2021 17:19:02 +0000 (UTC)
Received: from rhtmp (unknown [10.39.192.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC1B19D9D;
        Tue,  7 Dec 2021 17:18:57 +0000 (UTC)
Date:   Tue, 7 Dec 2021 18:18:55 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, egorenar@linux.ibm.com, ltao@redhat.com
Subject: Re: [PATCH v2 1/2] s390/kexec_file: print some more error messages
Message-ID: <20211207181855.521b7d94@rhtmp>
In-Reply-To: <Ya9988i7o788He/z@osiris>
References: <20211207125749.6998-1-prudo@redhat.com>
        <20211207125749.6998-2-prudo@redhat.com>
        <Ya9988i7o788He/z@osiris>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Heiko,

On Tue, 7 Dec 2021 16:29:55 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> Hi Philipp,
> 
> On Tue, Dec 07, 2021 at 01:57:48PM +0100, Philipp Rudo wrote:
> > Be kind and give some more information on what went wrong.
> > 
> > Signed-off-by: Philipp Rudo <prudo@redhat.com>  
> ...
> > @@ -304,15 +306,22 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >  		sym = (void *)pi->ehdr + symtab->sh_offset;
> >  		sym += ELF64_R_SYM(relas[i].r_info);
> >  
> > -		if (sym->st_shndx == SHN_UNDEF)
> > +		if (sym->st_shndx == SHN_UNDEF) {
> > +			pr_err("Undefined symbol\n");
> >  			return -ENOEXEC;
> > +		}
> >  
> > -		if (sym->st_shndx == SHN_COMMON)
> > +		if (sym->st_shndx == SHN_COMMON) {
> > +			pr_err("symbol in common section\n");
> >  			return -ENOEXEC;
> > +		}
> >  
> >  		if (sym->st_shndx >= pi->ehdr->e_shnum &&
> > -		    sym->st_shndx != SHN_ABS)
> > +		    sym->st_shndx != SHN_ABS) {
> > +			pr_err("Invalid section %d for symbol\n",
> > +			       sym->st_shndx);
> >  			return -ENOEXEC;  
> 
> So, if you add the additional error messages here, then I'd really
> like to see also the name of the symbol which is causing
> problems. Just like it is done on x86.
> Sorry for nitpicking :)

I actually dropped the name on purpose. At least for my work flow
knowing which check failed is more important as that already allows
me to search for, e.g. all undefined symbols as each of them can cause
trouble. Which symbol exactly triggered the check isn't that important.
In addition, the code to get a symbol name is rather ugly. At least
when you compare it to its usefulness.

But when you insist...

Philipp

P.S. To avoid an other round for that patch. Do you also want the two
     pr_debugs?

