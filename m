Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGEM16 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 5 Jul 2019 08:27:58 -0400
Date: Fri, 5 Jul 2019 14:27:53 +0200
From: Vasily Gorbik <gor@kernel.org>
Subject: Re: [PATCH 2/3] docs: s390: unify and update s390dbf kdocs at debug.c
Message-ID: <your-ad-here.call-01562329673-ext-3862@work.hours>
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
 <1562149189-1417-3-git-send-email-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562149189-1417-3-git-send-email-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-doc@vger.kernel.org, linux-s390@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:19:48PM +0200, Steffen Maier wrote:
> For non-static-inlines, debug.c already had non-compliant function
> header docs. So move the pure prototype kdocs of
> ("s390: include/asm/debug.h add kerneldoc markups")
> from debug.h to debug.c and merge them with the old function docs.
> Also, I had the impression that kdoc typically is at the implementation
> in the compile unit rather than at the prototype in the header file.
> 
> While at it, update the short kdoc description to distinguish the
> different functions. And a few more consistency cleanups.
> 
> Added a new kdoc for debug_set_critical() since debug.h comments it
> as part of the API.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> ---
>  Documentation/s390/s390dbf.rst |   1 +
>  arch/s390/include/asm/debug.h  | 112 ++++++-----------------------------------
>  arch/s390/kernel/debug.c       | 105 +++++++++++++++++++++++++++++++-------
>  3 files changed, 102 insertions(+), 116 deletions(-)
> 
Applied with "permisions->permissions" and couple of whitespaces removed, thanks.
