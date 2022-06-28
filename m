Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0802C43334
	for <linux-s390@archiver.kernel.org>; Tue, 28 Jun 2022 06:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiF1Gov (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Jun 2022 02:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiF1Gou (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jun 2022 02:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43F8F13DF6
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656398688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKKhmAVY6ZLU32yFo246MjjcA6QB3q+Asrc/tb9AagA=;
        b=FWCGJqg5msDnwZD0HXb37xFn4rZJnRa1NBrjulXChbQpXZ0+RvnfXDUaROncqdfjI8bReT
        8ePxKVow7na5aCdCDIWjgSqN/n6Gs4um23RAjAjYlztefRXrvcc5k+EE1UQMvfUPuaG4t9
        +SnZukzymjNxBQirLKq8bwd38Ecq2K4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-aqgf6hkhOga0d7-jHEq2QQ-1; Tue, 28 Jun 2022 02:44:46 -0400
X-MC-Unique: aqgf6hkhOga0d7-jHEq2QQ-1
Received: by mail-wr1-f72.google.com with SMTP id e5-20020adff345000000b0021b9f00e882so1498502wrp.6
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 23:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKKhmAVY6ZLU32yFo246MjjcA6QB3q+Asrc/tb9AagA=;
        b=AUyJvSDOXCDrWcxcldLkrhtEjEzKdHgf9DFqYIR02eIPsD/BjZuZYtEztFdjcbDDNH
         C/e8CTqrC8o8pbNCYHr0YSTEazE7a3iRW1L63wXpDdglhooEtwMrhe88egPWDEiCi+l7
         D89m2eraFoQMMWzvDFAxQ8PVEnYrRchDmwZonMACoOafBXemByejIUKIgJP8LkWHDiwh
         f2d6muvuDdI/5Pz/VCkgfqoPTrU/XCdW9UqPXGIeJX+7aMKqlFb/sn4x3fM9PQ5PbOrg
         krKs25zOJg3CxIr29YBBIQjTZPc0OXH3BAcztTz9UB+zfAb8VlqZKMzbM5D8/AtF/X5z
         1hiA==
X-Gm-Message-State: AJIora8UXgaVsmqO9ln6udsvjI6yg9YN/jU0nuiiOHkpTQNz1lrQ4mxc
        41xFLd0ZcYzHyZpoeiVY94cDOEzHOVq8hS8vkt1GpvVXjrNYAjPYcLDV766KPgNlAKdlmrANHrX
        kTfIWFvkvHAQFreAFnwwE2g==
X-Received: by 2002:a05:600c:4e90:b0:39c:7ec6:c7d2 with SMTP id f16-20020a05600c4e9000b0039c7ec6c7d2mr19756877wmq.140.1656398685548;
        Mon, 27 Jun 2022 23:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIze8DJsIvzB3CNFTFD7nxCkijrxeoiA7/FaJ3ir6OLO+Z+2vAtNLsCgnTCLoOO1PL/wj22A==
X-Received: by 2002:a05:600c:4e90:b0:39c:7ec6:c7d2 with SMTP id f16-20020a05600c4e9000b0039c7ec6c7d2mr19756849wmq.140.1656398685292;
        Mon, 27 Jun 2022 23:44:45 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b003a04962ad3esm9243219wms.31.2022.06.27.23.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:44:44 -0700 (PDT)
Date:   Tue, 28 Jun 2022 02:44:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220628023832-mutt-send-email-mst@kernel.org>
References: <20220624022622-mutt-send-email-mst@kernel.org>
 <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org>
 <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org>
 <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <20220628022035-mutt-send-email-mst@kernel.org>
 <CACGkMEt=go5qAH+P0to6yyE2dPhyfFmOQP0jfuj=57PmD7Y3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt=go5qAH+P0to6yyE2dPhyfFmOQP0jfuj=57PmD7Y3zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 28, 2022 at 02:32:19PM +0800, Jason Wang wrote:
> > Question is are there drivers which kick before they are ready
> > to handle callbacks?
> 
> Let me try to have a look at all the drivers to answer this.

One thing to note is that I consider hardening probe and
hardening remove separate features. I think that at this point
for secured guests it is prudent to outright block device
removal - we have been finding races in removal for years.
Note sure there's a flag for that but it's probably not too hard to add
e.g. to pci core.

-- 
MST

