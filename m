Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgD3KWY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 06:22:24 -0400
Date: Thu, 30 Apr 2020 12:22:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390: ptrace: hard-code "s390x" instead of UTS_MACHINE
Message-ID: <your-ad-here.call-01588242134-ext-2784@work.hours>
References: <20200413013113.8529-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413013113.8529-1-masahiroy@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:31:13AM +0900, Masahiro Yamada wrote:
> s390 uses the UTS_MACHINE defined arch/s390/Makefile as follows:
> 
>   UTS_MACHINE     := s390x
> 
> We do not need to pass the fixed string from the command line.
> Hard-code user_regset_view::name, like many other architectures do.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/kernel/Makefile | 5 -----
>  arch/s390/kernel/ptrace.c | 2 +-
>  2 files changed, 1 insertion(+), 6 deletions(-)

Yes, since we don't have 31-bit kernel build support for s390 anymore
this makes sense.
Applied, thanks.
