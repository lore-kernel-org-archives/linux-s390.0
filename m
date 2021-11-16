Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45716C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 13:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C80461BFE
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 13:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhKPNnI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Nov 2021 08:43:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236795AbhKPNnI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Nov 2021 08:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637070011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVUfInF5ff7DFbS9kneFAxd/0FXJHhTH3/aRVwgi3TY=;
        b=KZ1PolRULsFqT7r67gir2CSkUeESp+k3xkOY1FhvLBTxpNpYYzepLAo56tTw9nwsfr0i2K
        ztqomsCoclybMJAcQqYUnLxkTymgrJuCwORTmwNRMKiqAqG6dD3L4z2Qcjh40LLIjxMNyB
        GJ6V9T1A7OcFhFQciWu68fxSI9U6+3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-gsLn0IaVP6SvJJsupkk3Kw-1; Tue, 16 Nov 2021 08:40:04 -0500
X-MC-Unique: gsLn0IaVP6SvJJsupkk3Kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83811804148;
        Tue, 16 Nov 2021 13:40:03 +0000 (UTC)
Received: from localhost (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D82AA101E692;
        Tue, 16 Nov 2021 13:39:49 +0000 (UTC)
Date:   Tue, 16 Nov 2021 21:39:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, prudo@redhat.com
Subject: Re: [PATCH v2 1/2] s390/kexec: check the return value of
 ipl_report_finish
Message-ID: <20211116133947.GE21646@MiWiFi-R3L-srv>
References: <20211116032557.14075-1-bhe@redhat.com>
 <YZOTO+37BbIwOpUK@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZOTO+37BbIwOpUK@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/16/21 at 12:17pm, Heiko Carstens wrote:
> On Tue, Nov 16, 2021 at 11:25:56AM +0800, Baoquan He wrote:
> > In function ipl_report_finish(), it could fail by memory allocation
> > failure, so check the return value to handle the case.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/s390/include/asm/ipl.h           | 2 +-
> >  arch/s390/kernel/ipl.c                | 6 ++++--
> >  arch/s390/kernel/machine_kexec_file.c | 5 ++++-
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
> > index 3f8ee257f9aa..864ab5d2890c 100644
> > --- a/arch/s390/include/asm/ipl.h
> > +++ b/arch/s390/include/asm/ipl.h
> > @@ -122,7 +122,7 @@ struct ipl_report_certificate {
> >  
> >  struct kexec_buf;
> >  struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib);
> > -void *ipl_report_finish(struct ipl_report *report);
> > +int ipl_report_finish(struct ipl_report *report, void **ipl_buf);
> >  int ipl_report_free(struct ipl_report *report);
> >  int ipl_report_add_component(struct ipl_report *report, struct kexec_buf *kbuf,
> >  			     unsigned char flags, unsigned short cert);
> > diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> > index e2cc35775b99..a0af0b23148d 100644
> > --- a/arch/s390/kernel/ipl.c
> > +++ b/arch/s390/kernel/ipl.c
> > @@ -2144,7 +2144,7 @@ struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib)
> >  	return report;
> >  }
> >  
> > -void *ipl_report_finish(struct ipl_report *report)
> > +int ipl_report_finish(struct ipl_report *report, void **ipl_buf)
> >  {
> >  	struct ipl_report_certificate *cert;
> >  	struct ipl_report_component *comp;
> > @@ -2195,7 +2195,9 @@ void *ipl_report_finish(struct ipl_report *report)
> >  	}
> >  
> >  	BUG_ON(ptr > buf + report->size);
> > -	return buf;
> > +	*ipl_buf = buf;
> > +
> > +	return 0;
> 
> This does not compile:
> 
>   CC      arch/s390/kernel/ipl.o
> arch/s390/kernel/ipl.c: In function ‘ipl_report_finish’:
> arch/s390/kernel/ipl.c:2159:24: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
>  2159 |                 return ERR_PTR(-ENOMEM);
>       |                        ^~~~~~~~~~~~~~~~

Oops, I forgot changing this place to "return -ENOMEM;". Thanks for
taking care of it with below patch.
> 
> Anyway, before we are going to have more iterations I just applied the
> patch below instead before applying your memory leak fix.
> 
> From 78e5f268d1be775354ab83c1e039dcfacaa5e258 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Tue, 16 Nov 2021 11:06:38 +0100
> Subject: s390/kexec: fix return code handling
> 
> kexec_file_add_ipl_report ignores that ipl_report_finish may fail and
> can return an error pointer instead of a valid pointer.
> Fix this and simplify by returning NULL in case of an error and let
> the only caller handle this case.
> 
> Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to next kernel")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c                | 3 ++-
>  arch/s390/kernel/machine_kexec_file.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index e2cc35775b99..5ad1dde23dc5 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -2156,7 +2156,7 @@ void *ipl_report_finish(struct ipl_report *report)
>  
>  	buf = vzalloc(report->size);
>  	if (!buf)
> -		return ERR_PTR(-ENOMEM);
> +		goto out;
>  	ptr = buf;
>  
>  	memcpy(ptr, report->ipib, report->ipib->hdr.len);
> @@ -2195,6 +2195,7 @@ void *ipl_report_finish(struct ipl_report *report)
>  	}
>  
>  	BUG_ON(ptr > buf + report->size);
> +out:
>  	return buf;
>  }
>  
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 528edff085d9..f0200b503f94 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -170,6 +170,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
>  	struct kexec_buf buf;
>  	unsigned long addr;
>  	void *ptr, *end;
> +	int ret;
>  
>  	buf.image = image;
>  
> @@ -199,7 +200,10 @@ static int kexec_file_add_ipl_report(struct kimage *image,
>  		ptr += len;
>  	}
>  
> +	ret = -ENOMEM;
>  	buf.buffer = ipl_report_finish(data->report);
> +	if (!buf.buffer)
> +		goto out;
>  	buf.bufsz = data->report->size;
>  	buf.memsz = buf.bufsz;
>  
> @@ -209,7 +213,9 @@ static int kexec_file_add_ipl_report(struct kimage *image,
>  		data->kernel_buf + offsetof(struct lowcore, ipl_parmblock_ptr);
>  	*lc_ipl_parmblock_ptr = (__u32)buf.mem;
>  
> -	return kexec_add_buffer(&buf);
> +	ret = kexec_add_buffer(&buf);
> +out:
> +	return ret;
>  }
>  
>  void *kexec_file_add_components(struct kimage *image,
> -- 
> 2.31.1
> 

