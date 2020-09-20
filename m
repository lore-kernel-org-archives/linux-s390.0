Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITPzp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 20 Sep 2020 11:55:45 -0400
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: William Kucharski <kucharsk@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Date: Sun, 20 Sep 2020 09:55:40 -0600
Message-Id: <76A432F3-4532-42A4-900E-16C0AC2D21D8@gmail.com>
References: <20200920151510.GS32101@casper.infradead.org>
In-Reply-To: <20200920151510.GS32101@casper.infradead.org>
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

I really like that as it=E2=80=99s self-documenting and anyone debugging it c=
an see what is actually being used at a glance.

> On Sep 20, 2020, at 09:15, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 18, 2020 at 02:45:25PM +0200, Christoph Hellwig wrote=
:
>> Add a flag to force processing a syscall as a compat syscall.  This is
>> required so that in_compat_syscall() works for I/O submitted by io_uring
>> helper threads on behalf of compat syscalls.
>=20
> Al doesn't like this much, but my suggestion is to introduce two new
> opcodes -- IORING_OP_READV32 and IORING_OP_WRITEV32.  The compat code
> can translate IORING_OP_READV to IORING_OP_READV32 and then the core
> code can know what that user pointer is pointing to.
