Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86397C072A2
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjKOQkt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjKOQkY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 11:40:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC751FED
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700066396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCpNMTIKyOeROsc7/RWOAvMZhqSI0z3duXfnje8m3KQ=;
        b=YL+XnhK/zX5yeaOBX/zZ95Z/c7pB1fLKh64GHmJZ7xUDXknJjndVgb78S8MOg48F549mAN
        0wgM9MWPY6aDGR50ZwBLAxd/iNE0lPQk3M5HXx6ji5ifulEkGsvcjkTi86/GRujlc9jdeB
        kVlgLd5mIkejXayQx7D6AmXWK4yEI50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-UdDnholkMuG4DRRASuNUrQ-1; Wed, 15 Nov 2023 11:39:50 -0500
X-MC-Unique: UdDnholkMuG4DRRASuNUrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6F20101B04B;
        Wed, 15 Nov 2023 16:39:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0B85492BE8;
        Wed, 15 Nov 2023 16:39:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
References: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com> <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace VM for UBUF/IOVEC tests
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3936725.1700066370.1@warthog.procyon.org.uk>
Date:   Wed, 15 Nov 2023 16:39:30 +0000
Message-ID: <3936726.1700066370@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> From a quick look, what you were doing was checking that the patterns
> you set up in user space came through ok. Dammit, what's wrong with
> just using read()/write() on a pipe, or splice, or whatever. It will
> test exactly the same iov_iter thing.

I was trying to make it possible to do these tests before starting userspace
as there's a good chance that if the UBUF/IOVEC iterators don't work right
then your system can't be booted.

Anyway, if I drop patches 5, 6, 7 and 10 (ie. the ones doing stuff with UBUF
and IOVEC-type iterators), would you be okay with the rest?

David

