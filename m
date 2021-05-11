Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F44EC433ED
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 16:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A966117A
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhEKQhk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 May 2021 12:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230435AbhEKQhj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 May 2021 12:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620750992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa8ISZD+9VCaLFGh8Nx9yVUDD7ZejYAK3rK1NXQssoI=;
        b=aXFDw2djcUl1Zbd/b7quZOWe9BeFbV++BxTyFQsQ+qSTHzHx2csShDlGtn1V0/9xeAr2Aj
        qpGyGIgZ0jyUncLC1kD4Kimj48Q/JE+Azx7hk2nD39xZMFx9ppZL7bc66V/IWBajJtmcHk
        N5kwf8jrkiDZkzNij7obsMxkXuvmqUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-CX8DcdlfOQ6mrqGo36PzDA-1; Tue, 11 May 2021 12:36:30 -0400
X-MC-Unique: CX8DcdlfOQ6mrqGo36PzDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCB1801817;
        Tue, 11 May 2021 16:36:29 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C63F100164C;
        Tue, 11 May 2021 16:36:25 +0000 (UTC)
Date:   Tue, 11 May 2021 18:36:22 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 2/4] lib: s390x: sclp: Extend feature
 probing
Message-ID: <20210511183622.1251155d.cohuck@redhat.com>
In-Reply-To: <20210511174645.550c741d@ibm-vm>
References: <20210510150015.11119-1-frankja@linux.ibm.com>
        <20210510150015.11119-3-frankja@linux.ibm.com>
        <b0db681f-bfe3-5cf3-53f8-651bba04a5c5@redhat.com>
        <20210511164137.0bba2493@ibm-vm>
        <2f0284e1-b1e0-39d6-1fe0-3be808be1849@redhat.com>
        <20210511174645.550c741d@ibm-vm>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 11 May 2021 17:46:45 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> On Tue, 11 May 2021 17:38:04 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > On 11.05.21 16:41, Claudio Imbrenda wrote:  
> > > On Tue, 11 May 2021 13:43:36 +0200
> > > David Hildenbrand <david@redhat.com> wrote:
> > >     
> > >> On 10.05.21 17:00, Janosch Frank wrote:    
> > >>> Lets grab more of the feature bits from SCLP read info so we can
> > >>> use them in the cpumodel tests.
> > >>>
> > >>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > >>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > >>> ---
> > >>>    lib/s390x/sclp.c | 20 ++++++++++++++++++++
> > >>>    lib/s390x/sclp.h | 38 +++++++++++++++++++++++++++++++++++---
> > >>>    2 files changed, 55 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> > >>> index f11c2035..f25cfdb2 100644
> > >>> --- a/lib/s390x/sclp.c
> > >>> +++ b/lib/s390x/sclp.c
> > >>> @@ -129,6 +129,13 @@ CPUEntry *sclp_get_cpu_entries(void)
> > >>>    	return (CPUEntry *)(_read_info +
> > >>> read_info->offset_cpu); }
> > >>>    
> > >>> +static bool sclp_feat_check(int byte, int mask)
> > >>> +{
> > >>> +	uint8_t *rib = (uint8_t *)read_info;
> > >>> +
> > >>> +	return !!(rib[byte] & mask);
> > >>> +}    
> > >>
> > >> Instead of a mask, I'd just check for bit (offset) numbers within
> > >> the byte.
> > >>
> > >> static bool sclp_feat_check(int byte, int bit)
> > >> {
> > >> 	uint8_t *rib = (uint8_t *)read_info;
> > >>
> > >> 	return !!(rib[byte] & (0x80 >> bit));
> > >> }    
> > > 
> > > using a mask might be useful to check multiple facilities at the
> > > same time, but in that case the check should be    
> > 
> > IMHO checking with a mask here multiple facilities will be very error 
> > prone either way ... and we only have a single byte to check for.  
> 
> as I said, I do not have a strong opinion either way :)
> 
> 

If you need a tie breaker, I'd vote for bit over mask :)

