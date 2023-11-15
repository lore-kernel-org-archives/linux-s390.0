Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EA3C54FB9
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 16:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjKOQ7k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 11:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjKOQ7f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 11:59:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25219D
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 08:59:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso10898133a12.3
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 08:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700067567; x=1700672367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ac4Ls6gftQvQgbcRf5XLhX5PwcgnIwraX4CtQN05HrE=;
        b=c/otK7ZXq42r+iv6kExzfk8YA4bN+BHQlske9x4EZXDAgTRD0M5c/tPntLVJ9rg7Nw
         S4wBip/UYBj3s8WniPukYpF/9Au8dgAwIyI3tBSCGAmCd4g6+9knfFWdEdrHXZ4W5pIF
         NO+8bblia9fHzhCENBFgpL/kWJ65UT3Mfg4EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067567; x=1700672367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ac4Ls6gftQvQgbcRf5XLhX5PwcgnIwraX4CtQN05HrE=;
        b=wDHHC03Kc/XXRzqXcQACuokjG7oz1pQ4N2SXZhoSvXaFF/S3u00YQdqLL8qtnxuITD
         HU+bs7NyIVoinzqWntdAh6JlAobO+4LL+GFF5rLr7r/lGh5qhA+gdMqN57pQnOU778vk
         4JkFlDqTa2SniJOq4hDVlvcvXv0qihx9u3BuVt821wIdV8wpyREwz2/xkCbO9rFN2kTB
         oZyNop3wNtnAdvrCRUMTTlAfgwJ0UxEaVhe3U4au7ePcZQvOdSQtM4ITEqgRUGwBt9q6
         Iqy/StuRT7Tf4jVNp+aT1wYKDsNqqjrjBwDw5f2N6lNRl1N5w9KTzCvD1xwUcDKJqw11
         JeUg==
X-Gm-Message-State: AOJu0YwIJE4CJRAyqFw+3M1T5HPhybthArod5a8FsqTyRkMLko1WQzw9
        2lBVjpI1RhNXTuWLJrNvtU5yBNtzgqZvDiyj8OqYZd2f
X-Google-Smtp-Source: AGHT+IHr9kBHEjewApwDTIkAjyQJvMgpWPG6tGJ9ueWGbdTRlJ8OSqcJvayNELi+bcO1CeCp/NUr6A==
X-Received: by 2002:a50:ed99:0:b0:53d:d799:641 with SMTP id h25-20020a50ed99000000b0053dd7990641mr10223567edr.26.1700067566912;
        Wed, 15 Nov 2023 08:59:26 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7d15a000000b0053dfd3519f4sm6599429edo.22.2023.11.15.08.59.26
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:59:26 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-32fdd0774d9so4406969f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 08:59:26 -0800 (PST)
X-Received: by 2002:a19:7119:0:b0:507:9787:6773 with SMTP id
 m25-20020a197119000000b0050797876773mr9107681lfc.36.1700067545585; Wed, 15
 Nov 2023 08:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
 <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com> <3936726.1700066370@warthog.procyon.org.uk>
In-Reply-To: <3936726.1700066370@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 11:58:48 -0500
X-Gmail-Original-Message-ID: <CAHk-=whEj_+oP0mwNr7eArnOzWf_380-+-6LD9RtQXVs29fYJQ@mail.gmail.com>
Message-ID: <CAHk-=whEj_+oP0mwNr7eArnOzWf_380-+-6LD9RtQXVs29fYJQ@mail.gmail.com>
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

On Wed, 15 Nov 2023 at 11:39, David Howells <dhowells@redhat.com> wrote:
>
> I was trying to make it possible to do these tests before starting userspace
> as there's a good chance that if the UBUF/IOVEC iterators don't work right
> then your system can't be booted.

Oh, I don't think that any unit test should bother to check for that
kind of catastrophic case.

If something is so broken that the kernel doesn't boot properly even
into some basic test infrastructure, then bisection will trivially
find where that breakage was introduced.

And if it's something as core as the iov iterators, it won't even get
past the initial developer unless it's some odd build system
interaction.

So extreme cases aren't even worth checking for. What's worth testing
is "the system boots and works, but I want to check the edge cases".

IOW, when it comes to things like user copies, it's things like
alignment, and the page fault edge cases with EFAULT in particular.
You can easily get the return value wrong for a user copy that ends up
with an unaligned fault at the end of the last mapped page. Everything
normal will still work fine, because nobody does something that odd.

But those are best handled as user mode tests.

           Linus
