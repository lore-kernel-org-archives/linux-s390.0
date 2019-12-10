Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:12029 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfLJGk6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Dec 2019 01:40:58 -0500
Subject: Re: [PATCH v2 3/4] kasan: Document support on 32-bit powerpc
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-4-dja@axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8b64ce35-01df-3c0f-2695-40633c324331@c-s.fr>
Date: Tue, 10 Dec 2019 07:40:55 +0100
MIME-Version: 1.0
In-Reply-To: <20191210044714.27265-4-dja@axtens.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com



Le 10/12/2019 à 05:47, Daniel Axtens a écrit :
> KASAN is supported on 32-bit powerpc and the docs should reflect this.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   Documentation/dev-tools/kasan.rst |  3 ++-
>   Documentation/powerpc/kasan.txt   | 12 ++++++++++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/powerpc/kasan.txt
> 

Christophe
