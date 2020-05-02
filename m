Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.zx2c4.com ([192.95.5.64]:47671 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgEBVGE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 2 May 2020 17:06:04 -0400
MIME-Version: 1.0
References: <20200502182427.104383-1-ebiggers@kernel.org>
In-Reply-To: <20200502182427.104383-1-ebiggers@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 2 May 2020 15:05:46 -0600
Message-ID: <CAHmME9oPqWfTwTtawM-29Lqck-N-kYo4nGr1-4hCW975DhB0Uw@mail.gmail.com>
Subject: Re: [PATCH 0/7] sha1 library cleanup
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Paolo Abeni <pabeni@redhat.com>, mptcp@lists.01.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org

Thanks for this series. I like the general idea. I think it might make
sense, though, to separate things out into sha1.h and sha256.h. That
will be nice preparation work for when we eventually move obsolete
primitives into some <crypto/dangerous/> subdirectory.
