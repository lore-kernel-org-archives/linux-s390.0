Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731083AbfJIOua (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 10:50:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x99EmUFT124745
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 10:50:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhf376svk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 10:50:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 9 Oct 2019 15:50:26 +0100
Subject: Re: [RFC v2 0/1] s390/purgatory: Make sure we fail the build if
 purgatory has missing symbols
References: <20191008085421.11011-1-hdegoede@redhat.com>
 <20191009113917.47ef6eda@laptop-ibm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 9 Oct 2019 16:50:22 +0200
MIME-Version: 1.0
In-Reply-To: <20191009113917.47ef6eda@laptop-ibm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ee1e9da7-2f5a-8651-78ba-15398c4ceab6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, Ingo Molnar <mingo@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 09.10.19 11:39, Philipp Rudo wrote:
> Hi Hans,
> 
> also adding Ingo on Cc.
> 
> I tested you patch on s390 and it does what it's supposed to do. The build now
> fails with 
> 
>   LD      arch/s390/purgatory/purgatory.chk
> arch/s390/purgatory/purgatory: In function `sha256_update':
> (.text+0x3bc2): undefined reference to `memzero_explicit'
> /home/prudo/git/linux/linux/arch/s390/purgatory/Makefile:38: recipe for target 'arch/s390/purgatory/purgatory.chk' failed
> make[3]: *** [arch/s390/purgatory/purgatory.chk] Error 1
> 
> After applying Arvid's memzero_explizit fix ("[PATCH] lib/string: make
> memzero_explicit inline instead of external") as well the build works again.
> 
> My only problem is how to uptream your patch. Just adding it to our branch
> would cause a (intentional) build breakage until Ingo's branch is merged.
> 
> @Vasliy & Ingo: Can you please find a solution for this.


I talked quickly to Vasily. The best solution is likely to carry that
patch in the tree that contains the fix. Ingo, can you carry the s390
patch in your tip tree as well?

With my s390 co-maintainer hat on:

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Please also consider Philipps mail as "Tested-by:"
