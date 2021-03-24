Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B8C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 24 Mar 2021 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2EE619F3
	for <linux-s390@archiver.kernel.org>; Wed, 24 Mar 2021 16:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhCXQi7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236399AbhCXQiv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Mar 2021 12:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616603930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZF8HRT5IrNOvQL6Pz8F1OKHc43im4d3pUJ9N+IN8ny4=;
        b=IRSko5ts/nOBfLmpHJfzdhK5FVjGSBVFVLB8n8cP4375quXz86tjAs5LwMXRRmKJxXpuYM
        u3dEVjUBtcyV3fOaOkycJ1tP4zEXJjsbLP/VPll7sxA7PrQVwMjWlkRQO1A3bBtNxso2+i
        a8Kr5kTKN5GvWIs8t65vie//yZwIUok=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-VVXprUV_OJyUaa6Ykkoi2A-1; Wed, 24 Mar 2021 12:38:47 -0400
X-MC-Unique: VVXprUV_OJyUaa6Ykkoi2A-1
Received: by mail-wr1-f69.google.com with SMTP id e9so738105wrg.6
        for <linux-s390@vger.kernel.org>; Wed, 24 Mar 2021 09:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZF8HRT5IrNOvQL6Pz8F1OKHc43im4d3pUJ9N+IN8ny4=;
        b=bAW95b28lg3VAd38tRhZTo4E5TcHQA0ehzoguwtOQEwzerV+LXpq9rpqCDrnBC1eAx
         SVNlnaFYb8UVXVRjC8FhliVhCLdrRjDBpJ+fORvFfrbyrr20gluEZ4yjsphKIgFq+Pbi
         kHZn051Uz8ikgym4OTiQEe7IfPfyqpm6ELUhJVML1gZ8oCJ2lizaxFTk89pwSdaIYGyK
         O1z7lMCX+JMcHjIuv3+4r8ObOHcK3HyWXK5KJqlhinD2azSBOkRvoYFmTZe6WgtzJzzV
         zxMe7v8ob0lRS/doUxygOeBdNy+8hoW3QMZay0vuP7p1kvpAGKL9Q7IKVrXNdeACbM9V
         WPZA==
X-Gm-Message-State: AOAM532bYzK12VtifliixL7P0SMdFWKjM0OySKbE0G8F4Fyy9eV7ayej
        /2c3Mt1gDzjpheuCZtUf/D5aeCoAPIAwysFLzIYJiY74uLoR8xe1znmRWvfgNplBTIxdBgTh1ce
        kzDFFfdKApjYsJPqAp+dTFg==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr4478197wrn.174.1616603926343;
        Wed, 24 Mar 2021 09:38:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNX1S2tQyoRha/DwjTPN7h2LrSBGyzP5oxKR2eeHPyyIYZd4C89Eg+f14Opdl72aBTlPS3FQ==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr4478163wrn.174.1616603926203;
        Wed, 24 Mar 2021 09:38:46 -0700 (PDT)
Received: from redhat.com (bzq-79-183-252-180.red.bezeqint.net. [79.183.252.180])
        by smtp.gmail.com with ESMTPSA id c8sm4151618wrd.55.2021.03.24.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 09:38:45 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:38:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "jannh@google.com" <jannh@google.com>, "w@1wt.eu" <w@1wt.eu>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "areber@redhat.com" <areber@redhat.com>,
        "ovzxemul@gmail.com" <ovzxemul@gmail.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "ptikhomirov@virtuozzo.com" <ptikhomirov@virtuozzo.com>,
        "gil@azul.com" <gil@azul.com>,
        "asmehra@redhat.com" <asmehra@redhat.com>,
        "dgunigun@redhat.com" <dgunigun@redhat.com>,
        "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>,
        "oridgar@gmail.com" <oridgar@gmail.com>,
        "ghammer@redhat.com" <ghammer@redhat.com>
Subject: Re: [PATCH v8] drivers/misc: sysgenid: add system generation id
 driver
Message-ID: <20210324123756-mutt-send-email-mst@kernel.org>
References: <1615213083-29869-1-git-send-email-acatan@amazon.com>
 <YEY2b1QU5RxozL0r@kroah.com>
 <a61c976f-b362-bb60-50a5-04073360e702@amazon.com>
 <YFnlZQZOasOwxUDn@kroah.com>
 <E6E517FF-A37C-427C-B16F-066A965B8F42@amazon.com>
 <YFoYwq/RadewiE8I@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFoYwq/RadewiE8I@kroah.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 23, 2021 at 05:35:14PM +0100, Greg KH wrote:
> On Tue, Mar 23, 2021 at 04:10:27PM +0000, Catangiu, Adrian Costin wrote:
> > Hi Greg,
> > 
> > After your previous reply on this thread we started considering to provide this interface and framework/functionality through a userspace service instead of a kernel interface.
> > The latest iteration on this evolving patch-set doesn’t have strong reasons for living in the kernel anymore - the only objectively strong advantage would be easier driving of ecosystem integration; but I am not sure that's a good enough reason to create a new kernel interface.
> > 
> > I am now looking into adding this through Systemd. Either as a pluggable service or maybe even a systemd builtin offering.
> > 
> > What are your thoughts on it?
> 
> I'll gladly drop this patch if it's not needed in the kernel, thanks for
> letting me know.
> 
> greg k-h

Systemd sounds good to me too.

-- 
MST

