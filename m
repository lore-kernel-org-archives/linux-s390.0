Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGOtO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 7 Feb 2021 09:49:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC7C061756
        for <linux-s390@vger.kernel.org>; Sun,  7 Feb 2021 06:48:33 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a17so13603536ljq.2
        for <linux-s390@vger.kernel.org>; Sun, 07 Feb 2021 06:48:33 -0800 (PST)
Date: Sun, 7 Feb 2021 17:48:31 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-ID: <20210207144831.lsrm74ypbz7i37uz@box>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205230620.518245-1-seth.forshee@canonical.com>
List-ID: <linux-s390.vger.kernel.org>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>, Amir Goldstein <amir73il@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:06:20PM -0600, Seth Forshee wrote:
> This feature requires ino_t be 64-bits, which is true for every
> 64-bit architecture but s390, so prevent this option from being
> selected there.

Quick grep suggests the same for alpha. Am I wrong?

-- 
 Kirill A. Shutemov
