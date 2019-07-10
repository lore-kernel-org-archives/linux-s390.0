Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbfGJKpI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Jul 2019 06:45:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6AAfm4x043466
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2019 06:45:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tnegag2kh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2019 06:45:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 10 Jul 2019 11:45:05 +0100
Subject: Re: [PATCH] MAINTAINERS: update BPF JIT S390 maintainers
References: <patch.git-d365382dfc69.your-ad-here.call-01562755343-ext-3127@work.hours>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 10 Jul 2019 12:44:59 +0200
MIME-Version: 1.0
In-Reply-To: <patch.git-d365382dfc69.your-ad-here.call-01562755343-ext-3127@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <72bea03f-8100-d175-fffc-251c0d553b00@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>



On 10.07.19 12:43, Vasily Gorbik wrote:
> Ilya Leoshkevich is joining as s390 bpf maintainer. With his background
> as gcc developer he would be valuable for the team and community as a
> whole. Ilya, have fun!

> 
> Since there is now enough eyes on s390 bpf, relieve Christian Borntraeger,
> so that he could focus on his maintainer tasks for other components.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@e.ibm.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 558acf24ea1e..98e7411dfe56 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3066,9 +3066,9 @@ S:	Maintained
>  F:	arch/riscv/net/
>  
>  BPF JIT for S390
> +M:	Ilya Leoshkevich <iii@linux.ibm.com>
>  M:	Heiko Carstens <heiko.carstens@de.ibm.com>
>  M:	Vasily Gorbik <gor@linux.ibm.com>
> -M:	Christian Borntraeger <borntraeger@de.ibm.com>
>  L:	netdev@vger.kernel.org
>  L:	bpf@vger.kernel.org
>  S:	Maintained
> 
