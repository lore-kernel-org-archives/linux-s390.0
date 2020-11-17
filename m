Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgKQVN0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 Nov 2020 16:13:26 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E2C0613CF
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:13:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l11so1181641plt.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:13:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH seccomp v2 0/8] seccomp: add bitmap cache support on remaining arches and report cache in procfs
Date: Tue, 17 Nov 2020 13:11:13 -0800
Message-Id: <160564746555.1001899.9792418917631139658.b4-ty@chromium.org>
In-Reply-To: <cover.1605101222.git.yifeifz2@illinois.edu>
References: <cover.1605101222.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: containers@lists.linux-foundation.org, YiFei Zhu <zhuyifei1999@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Josep Torrellas <torrella@illinois.edu>, Jack Chen <jianyan2@illinois.edu>, Tobin Feldman-Fitzthum <tobin@ibm.com>, linux-riscv@lists.infradead.org, David Laight <David.Laight@aculab.com>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, Andrea Arcangeli <aarcange@redhat.com>, linux-sh@vger.kernel.org, Hubertus Franke <frankeh@us.ibm.com>, YiFei Zhu <yifeifz2@illinois.edu>, Tianyin Xu <tyxu@illinois.edu>, linux-parisc@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, linux-csky@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Giuseppe Scrivano <gscrivan@redhat.com>, linux-kernel@vger.kernel.org, Will Drewry <wad@chromium.org>, linux-s390@vger.kernel.org, Valentin Rothberg <vrothber@redhat.com>, linuxppc-dev@lists.ozlabs.org

On Wed, 11 Nov 2020 07:33:46 -0600, YiFei Zhu wrote:
> This patch series enables bitmap cache for the remaining arches with
> SECCOMP_FILTER, other than MIPS.
> 
> I was unable to find any of the arches having subarch-specific NR_syscalls
> macros, so generic NR_syscalls is used. SH's syscall_get_arch seems to
> only have the 32-bit subarch implementation. I'm not sure if this is
> expected.
> 
> [...]

Applied to for-next/seccomp, thanks!

I made a small tweak to the last patch to add more details to the per-ARCH
help text, and to drop the needless "depends on SECCOMP" (which "depends
on SECCOMP_FILTER" was already present).

I successfully build-tested on parisc, powerpc, riscv, s390, and
sh. xtensa doesn't build using the existing Debian cross-compiler, and
I can't make csky with clang work, but they look correct. *cross fingers*

[1/8] csky: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/ee7ce951028f
[2/8] parisc: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/7f049cc068a3
[3/8] powerpc: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/95f8ae2624a0
[4/8] riscv: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/8f9f0f44a37b
[5/8] s390: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/5897106c6902
[6/8] sh: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/75186111c257
[7/8] xtensa: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/4f408bc643aa
[8/8] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
      https://git.kernel.org/kees/c/49a6968cc78f

-- 
Kees Cook
