Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgGMQmB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Jul 2020 12:42:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D903C061794
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2020 09:42:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p3so6272796pgh.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2020 09:42:01 -0700 (PDT)
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 13 Jul 2020 09:41:49 -0700
Message-ID: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
Subject: linux plumbers + clang + s390 virtualized testing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>

Hi Vasily and Heiko,
We were very excited to see your patches going by for enabling Clang
support for s390.  Since then, we've added s390 builds to our
continuous integration setup.

We've been running into a few issues with doing virtualized boot tests
of our kernels on s390.

I was curious if you'll both be attending Linux plumbers conf?  If we
carve out time for an s390+clang talk, would this be of interest to
you to attend?
-- 
Thanks,
~Nick Desaulniers
