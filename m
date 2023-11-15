Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3ECC2BB3F
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 16:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjKOQNB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 11:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjKOQNA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 11:13:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AAFA
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 08:12:57 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9df8d0c2505so209832666b.0
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064775; x=1700669575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=Ovbb6ARypE707QeAyh4+0ef02Jamb9Gf8z3idJAnj/+GghTq65rlgndq1grUXzFnrG
         wGzqhUCvnfl5J8J4J10VvgQgI7AKl73b+xcWA5GvW+iAP70lg1ACscm2vFJbtq+cMi+8
         H5BM1EtUhIuJvW4dit1d98X9Ml7QMDD6+/d7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064775; x=1700669575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=Zd49ioedwm5L8EdW1gd89sNZYle81gOPByTz9urxSQQyPGHGkhuIoWzGizJclgg4Rf
         yy3W7UTNuj84+a2o4Z/LqWT1axsUx7byiy61XYFRfqMt/yLuCupmbTNfMwqKJ6PdwAgR
         IxzV2AqTnuqO5ShfkJ6PyANMjoP51oQ9JqkaJIVxq/NmLza8XneUDwzoOF0Zbrwo7FNU
         O4OSMNt4WxQNHot4ly5QvpSAwYVlkW39I2g9hdnfqGHlf5m4twj3pQCudS2YYDts/jcX
         K0aSu0JokCn7TTBRIpngS7KnT9yMjlTQzT9FFUSqRSMcxuITDn8lc9RkecXnZIrLkbzf
         3wuQ==
X-Gm-Message-State: AOJu0Yyx1VWzepTM/6N1zWBM4kPkmA230qP+g57H5DKBLfveE8rOjXuB
        Ii4GG0eBEvil8Agr+tOuiHXYYQMo4/HLbmSHGl3OeH59
X-Google-Smtp-Source: AGHT+IF6ksenQb0pbzRj7DUlV+1dNjLXh1WzwNwjvPqZvRca5d8o4lQFOBbz6Ik4Oeabn4plgFCjFg==
X-Received: by 2002:a17:906:5a5b:b0:9a5:9f3c:961e with SMTP id my27-20020a1709065a5b00b009a59f3c961emr5257823ejc.18.1700064775418;
        Wed, 15 Nov 2023 08:12:55 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ck20-20020a170906c45400b0099ce188be7fsm7216548ejb.3.2023.11.15.08.12.55
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:12:55 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so2046371a12.0
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 08:12:55 -0800 (PST)
X-Received: by 2002:aa7:da07:0:b0:542:ff1b:6c7a with SMTP id
 r7-20020aa7da07000000b00542ff1b6c7amr5958727eds.9.1700064753769; Wed, 15 Nov
 2023 08:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-6-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 11:12:17 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace
 VM for UBUF/IOVEC tests
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> This requires access to otherwise unexported core symbols: mm_alloc(),
> vm_area_alloc(), insert_vm_struct() arch_pick_mmap_layout() and
> anon_inode_getfile_secure(), which I've exported _GPL.
>
> [?] Would it be better if this were done in core and not in a module?

I'm not going to take this, even if it were to be sent to me through Christian.

I think the exports really show that this shouldn't be done. And yes,
doing it in core would avoid the exports, but would be even worse.

Those functions exist for setting up user space. You should be doing
this in user space.

I'm getting really fed up with the problems that ther KUnit tests
cause. We have a long history of self-inflicted pain due to "unit
testing", where it has caused stupid problems like just overflowing
the kernel stack etc.

This needs to stop. And this is where I'm putting my foot down. No
more KUnit tests that make up interfaces - or use interfaces - that
they have absolutely no place using.

From a quick look, what you were doing was checking that the patterns
you set up in user space came through ok. Dammit, what's wrong with
just using read()/write() on a pipe, or splice, or whatever. It will
test exactly the same iov_iter thing.

Kernel code should do things that can *only* be done in the kernel.
This is not it.

              Linus
