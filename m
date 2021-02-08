Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhBHRtU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 8 Feb 2021 12:49:20 -0500
Date: Mon, 8 Feb 2021 09:48:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-Id: <20210208094838.74c7ca910a16f33aacacb4b0@linux-foundation.org>
In-Reply-To: <YCE3cjDNOvpeCCeA@ubuntu-x1>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
        <20210207144831.lsrm74ypbz7i37uz@box>
        <YCE3cjDNOvpeCCeA@ubuntu-x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>, Amir Goldstein <amir73il@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 07:06:58 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:

> On Sun, Feb 07, 2021 at 05:48:31PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Feb 05, 2021 at 05:06:20PM -0600, Seth Forshee wrote:
> > > This feature requires ino_t be 64-bits, which is true for every
> > > 64-bit architecture but s390, so prevent this option from being
> > > selected there.
> > 
> > Quick grep suggests the same for alpha. Am I wrong?
> 
> No, it appears you are right. Looks like my grep missed alpha somehow.
> 
> Andrew, do you prefer an additional patch or an updated version of the
> previous patch?

Doesn't matter much.  A second patch for Alpha would be best, I guess. 
Thanks.
