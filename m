Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA49C433F5
	for <linux-s390@archiver.kernel.org>; Mon,  6 Dec 2021 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhLFRhO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243019AbhLFRhN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Dec 2021 12:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638812024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4ercJW+nnO3nVFWXdpcqDrsk6DzFn5IXLVSmNB1y5U=;
        b=bZLu0BNXBi+5B3/IcJpsH0dCTNgSSM/4JJopszar4b+d9rEdCPWQ1nPDJhYkENPsznqSZW
        m26Dt7AQbJVFjhECKcKiFItN0Fzhkb9Qy0iOFpD8bq2YLpCR0dER5fq6va6SASl4PMWhux
        0AnkL/sOGby7ZHDYIoT9aPNJqWATR1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-7fyedwPTNIqigZ3OufbXaA-1; Mon, 06 Dec 2021 12:33:41 -0500
X-MC-Unique: 7fyedwPTNIqigZ3OufbXaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03F5B81EE61;
        Mon,  6 Dec 2021 17:33:40 +0000 (UTC)
Received: from rhtmp (unknown [10.39.194.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02C4860C13;
        Mon,  6 Dec 2021 17:33:38 +0000 (UTC)
Date:   Mon, 6 Dec 2021 18:33:37 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, egorenar@linux.ibm.com, ltao@redhat.com
Subject: Re: [PATCH] s390/kexec_file: fix error handling when applying
 relocations
Message-ID: <20211206183337.0aaf7d4c@rhtmp>
In-Reply-To: <Ya5Ex8WPeyiPwXl+@osiris>
References: <20211206112047.4746-1-prudo@redhat.com>
        <Ya5Ex8WPeyiPwXl+@osiris>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Heiko,

On Mon, 6 Dec 2021 18:13:43 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Mon, Dec 06, 2021 at 12:20:47PM +0100, Philipp Rudo wrote:
> > arch_kexec_apply_relocations_add currently ignores all errors returned
> > by arch_kexec_do_relocs. This means that every unknown relocation is
> > silently skipped causing unpredictable behavior while the relocated code
> > runs. Fix this by checking for errors and fail kexec_file_load if an
> > unknown relocation type is encountered.
> > 
> > The problem was found after gcc changed its behavior and used
> > R_390_PLT32DBL relocations for brasl instruction and relied on ld to
> > resolve the relocations in the final link in case direct calls are
> > possible. As the purgatory code is only linked partially (option -r)
> > ld didn't resolve the relocations leaving them for arch_kexec_do_relocs.
> > But arch_kexec_do_relocs doesn't know how to handle R_390_PLT32DBL
> > relocations so they were silently skipped. This ultimately caused an
> > endless loop in the purgatory as the brasl instructions kept branching
> > to itself.
> > 
> > Fixes: 71406883fd35 ("s390/kexec_file: Add kexec_file_load system call")
> > Reported-by: Tao Liu <ltao@redhat.com>
> > Signed-off-by: Philipp Rudo <prudo@redhat.com>
> > ---
> >  arch/s390/kernel/machine_kexec_file.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> > index 9975ad200d74..0e1d646207dc 100644
> > --- a/arch/s390/kernel/machine_kexec_file.c
> > +++ b/arch/s390/kernel/machine_kexec_file.c
> > @@ -292,6 +292,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >  {
> >  	Elf_Rela *relas;
> >  	int i, r_type;
> > +	int ret;
> >  
> >  	relas = (void *)pi->ehdr + relsec->sh_offset;
> >  
> > @@ -326,7 +327,9 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >  		addr = section->sh_addr + relas[i].r_offset;
> >  
> >  		r_type = ELF64_R_TYPE(relas[i].r_info);
> > -		arch_kexec_do_relocs(r_type, loc, val, addr);
> > +		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
> > +		if (ret)
> > +			return -EINVAL;  
> 
> I'd prefer if this would return -ENOEXEC, just to be consistent with
> x86. And _maybe_ it would also make sense to print an error message,
> including the failing relocation type?

sure, I'll update the return value to -ENOEXEC.

About the error message, I didn't add it on purpose as none of the
other error cases print one. For consistency I would add one for those
cases as well. Any objections?

Thanks
Philipp

