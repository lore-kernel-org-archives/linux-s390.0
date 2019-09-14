Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727801AbfINKR6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 14 Sep 2019 06:17:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8EAHMKA142324
        for <linux-s390@vger.kernel.org>; Sat, 14 Sep 2019 06:17:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v0ugt3eja-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 14 Sep 2019 06:17:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 14 Sep 2019 11:17:55 +0100
Date: Sat, 14 Sep 2019 12:17:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove pointless drivers-y in drivers/s390/Makefile
References: <20190912052354.24829-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912052354.24829-1-yamada.masahiro@socionext.com>
Message-Id: <20190914101749.GA4059@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 02:23:54PM +0900, Masahiro Yamada wrote:
> This is unused.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/s390/Makefile | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.
