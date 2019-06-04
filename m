Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbfFDOyh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 10:54:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54EbDTc050951
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 10:54:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swt7gsw59-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 10:54:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 4 Jun 2019 15:54:34 +0100
Date: Tue, 4 Jun 2019 16:54:29 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: fix unrecognized __aligned() in uapi header
References: <20190604082947.26328-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190604082947.26328-1-yamada.masahiro@socionext.com>
Message-Id: <20190604145429.GE5774@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 05:29:47PM +0900, Masahiro Yamada wrote:
> __aligned() is a shorthand that is only available in the kernel space
> because it is defined in include/linux/compiler_attributes.h, which is
> not exported to the user space.
> 
> Detected by compile-testing exported headers.
> 
> ./usr/include/asm/runtime_instr.h:60:37: error: expected declaration specifiers or ‘...’ before numeric constant
>  } __attribute__((packed)) __aligned(8);
>                                      ^
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/include/uapi/asm/runtime_instr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
