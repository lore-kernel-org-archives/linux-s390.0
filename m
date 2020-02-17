Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728142AbgBQRGh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 12:06:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH4BWC000845
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:06:36 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dnsu8yu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:06:36 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:06:34 -0000
Date: Mon, 17 Feb 2020 18:06:27 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390: make 'install' not depend on vmlinux
References: <20200216144829.27023-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200216144829.27023-1-masahiroy@kernel.org>
Message-Id: <your-ad-here.call-01581959187-ext-6215@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 11:48:29PM +0900, Masahiro Yamada wrote:
> For the same reason as commit 19514fc665ff ("arm, kbuild: make "make
> install" not depend on vmlinux"), the install targets should never
> trigger the rebuild of the kernel.
> 
> The variable, CONFIGURE, is not set by anyone. Remove it as well.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
Applied, thanks
