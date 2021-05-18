Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C59C433ED
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 16:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF236113C
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 16:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350152AbhERQFl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 12:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344672AbhERQFk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 May 2021 12:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621353861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvhpwM9B7CK7kJ1xdIZJIHz3ygVOfl53rrG0Yt4bYqA=;
        b=G1I8xRcRqfjmbR76Hdwa3VrjCBEmQu/7Yn1wuuBnZP4bI3zANXVDsBHFFZnpUJclCrhWz6
        YNkoJQO5ugGLUR83OxXGkrh9lo3mwqusQnl/vMt8QQD6UTPgwm02N35lNJDoudwp0+pIij
        G/+qPdNk5vPUifPGDxZC1QqSfOBunyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-IwQiSyPUM-SHNa54cz5-nA-1; Tue, 18 May 2021 12:04:20 -0400
X-MC-Unique: IwQiSyPUM-SHNa54cz5-nA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26CE6800D55;
        Tue, 18 May 2021 16:04:19 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-74.ams2.redhat.com [10.36.113.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F00385DEAD;
        Tue, 18 May 2021 16:04:13 +0000 (UTC)
Date:   Tue, 18 May 2021 18:04:11 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, david@redhat.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/11] KVM: s390: pv: implement lazy destroy
Message-ID: <20210518180411.4abf837d.cohuck@redhat.com>
In-Reply-To: <20210518173624.13d043e3@ibm-vm>
References: <20210517200758.22593-1-imbrenda@linux.ibm.com>
        <20210518170537.58b32ffe.cohuck@redhat.com>
        <20210518173624.13d043e3@ibm-vm>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 18 May 2021 17:36:24 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> On Tue, 18 May 2021 17:05:37 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Mon, 17 May 2021 22:07:47 +0200
> > Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> > > This means that the same address space can have memory belonging to
> > > more than one protected guest, although only one will be running,
> > > the others will in fact not even have any CPUs.    
> > 
> > Are those set-aside-but-not-yet-cleaned-up pages still possibly
> > accessible in any way? I would assume that they only belong to the  
> 
> in case of reboot: yes, they are still in the address space of the
> guest, and can be swapped if needed
> 
> > 'zombie' guests, and any new or rebooted guest is a new entity that
> > needs to get new pages?  
> 
> the rebooted guest (normal or secure) will re-use the same pages of the
> old guest (before or after cleanup, which is the reason of patches 3
> and 4)

Took a look at those patches, makes sense.

> 
> the KVM guest is not affected in case of reboot, so the userspace
> address space is not touched.

'guest' is a bit ambiguous here -- do you mean the vm here, and the
actual guest above?

