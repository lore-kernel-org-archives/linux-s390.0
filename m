Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfGKNw5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Jul 2019 09:52:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BDl79b054640
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2019 09:52:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp5a13h95-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2019 09:52:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 11 Jul 2019 14:52:54 +0100
Date: Thu, 11 Jul 2019 15:52:48 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/zcrypt: remove the exporting of
 ap_query_configuration
References: <20190709122507.11158-1-efremov@linux.com>
 <a71450e5-892c-3841-22d6-9f5c7b2d4ca4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a71450e5-892c-3841-22d6-9f5c7b2d4ca4@linux.ibm.com>
Message-Id: <your-ad-here.call-01562853168-ext-7276@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Denis Efremov <efremov@linux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 08:44:53AM +0200, Harald Freudenberger wrote:
> On 09.07.19 14:25, Denis Efremov wrote:
> > The function ap_query_configuration is declared static and marked
> > EXPORT_SYMBOL, which is at best an odd combination. Because the
> > function is not used outside of the drivers/s390/crypto/ap_bus.c
> > file it is defined in, this commit removes the EXPORT_SYMBOL() marking.
> >
> > Fixes: f1b0a4343c41 ("s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.")
> > Fixes: 050349b5b71d ("s390/zcrypt: externalize AP config info query")
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > ---
> >  drivers/s390/crypto/ap_bus.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> > index b9fc502c58c2..379e43b79006 100644
> > --- a/drivers/s390/crypto/ap_bus.c
> > +++ b/drivers/s390/crypto/ap_bus.c
> > @@ -208,7 +208,6 @@ static inline int ap_query_configuration(struct ap_config_info *info)
> >  		return -EINVAL;
> >  	return ap_qci(info);
> >  }
> > -EXPORT_SYMBOL(ap_query_configuration);
> >  
> >  /**
> >   * ap_init_configuration(): Allocate and query configuration array.
> This function was exported a while ago for KVM code. However, never used.
> So removing the export is the right thing. Thanks Denis
> 
> Heiko/Vasily will you pick this patch please?
> 
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> 

Applied, thanks.
