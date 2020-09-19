Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgISWxo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 19 Sep 2020 18:53:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65337C0613CE
        for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2020 15:53:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so5159103pjh.5
        for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2020 15:53:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Mime-Version: 1.0 (1.0)
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20200919224122.GJ3421308@ZenIV.linux.org.uk>
Date: Sat, 19 Sep 2020 15:53:40 -0700
Message-Id: <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
References: <20200919224122.GJ3421308@ZenIV.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org



> On Sep 19, 2020, at 3:41 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> =EF=BB=BFOn Sat, Sep 19, 2020 at 03:23:54PM -0700, Andy Lutomirski wrote:
>>=20
>>>> On Sep 19, 2020, at 3:09 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>=20
>>> =EF=BB=BFOn Fri, Sep 18, 2020 at 05:16:15PM +0200, Christoph Hellwig wro=
te:
>>>>> On Fri, Sep 18, 2020 at 02:58:22PM +0100, Al Viro wrote:
>>>>> Said that, why not provide a variant that would take an explicit
>>>>> "is it compat" argument and use it there?  And have the normal
>>>>> one pass in_compat_syscall() to that...
>>>>=20
>>>> That would help to not introduce a regression with this series yes.
>>>> But it wouldn't fix existing bugs when io_uring is used to access
>>>> read or write methods that use in_compat_syscall().  One example that
>>>> I recently ran into is drivers/scsi/sg.c.
>>>=20
>>> So screw such read/write methods - don't use them with io_uring.
>>> That, BTW, is one of the reasons I'm sceptical about burying the
>>> decisions deep into the callchain - we don't _want_ different
>>> data layouts on read/write depending upon the 32bit vs. 64bit
>>> caller, let alone the pointer-chasing garbage that is /dev/sg.
>>=20
>> Well, we could remove in_compat_syscall(), etc and instead have an implic=
it parameter in DEFINE_SYSCALL.  Then everything would have to be explicit. =
 This would probably be a win, although it could be quite a bit of work.
>=20
> It would not be a win - most of the syscalls don't give a damn
> about 32bit vs. 64bit...

Any reasonable implementation would optimize it out for syscalls that don=E2=
=80=99t care.  Or it could be explicit:

DEFINE_MULTIARCH_SYSCALL(...)=
