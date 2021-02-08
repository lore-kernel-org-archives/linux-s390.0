Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54957 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBHNHn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Feb 2021 08:07:43 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l96Fo-0001E1-74
        for linux-s390@vger.kernel.org; Mon, 08 Feb 2021 13:07:00 +0000
Received: by mail-ot1-f69.google.com with SMTP id z2so8412697otk.1
        for <linux-s390@vger.kernel.org>; Mon, 08 Feb 2021 05:07:00 -0800 (PST)
Date: Mon, 8 Feb 2021 07:06:58 -0600
From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-ID: <YCE3cjDNOvpeCCeA@ubuntu-x1>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
 <20210207144831.lsrm74ypbz7i37uz@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207144831.lsrm74ypbz7i37uz@box>
List-ID: <linux-s390.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>, Amir Goldstein <amir73il@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 05:48:31PM +0300, Kirill A. Shutemov wrote:
> On Fri, Feb 05, 2021 at 05:06:20PM -0600, Seth Forshee wrote:
> > This feature requires ino_t be 64-bits, which is true for every
> > 64-bit architecture but s390, so prevent this option from being
> > selected there.
> 
> Quick grep suggests the same for alpha. Am I wrong?

No, it appears you are right. Looks like my grep missed alpha somehow.

Andrew, do you prefer an additional patch or an updated version of the
previous patch?
