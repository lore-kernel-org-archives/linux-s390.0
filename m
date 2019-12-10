Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:48137 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfLJOji (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Dec 2019 09:39:38 -0500
Subject: Re: [PATCH v2 2/4] kasan: use MAX_PTRS_PER_* for early shadow
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-3-dja@axtens.net>
 <a31459ee-2019-2f7b-0dc1-235374579508@gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5d1ec6e3-777e-9f23-ea8f-50361a29302f@c-s.fr>
Date: Tue, 10 Dec 2019 15:39:34 +0100
MIME-Version: 1.0
In-Reply-To: <a31459ee-2019-2f7b-0dc1-235374579508@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Balbir Singh <bsingharora@gmail.com>, Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com



Le 10/12/2019 à 10:36, Balbir Singh a écrit :
> 
> 
> On 10/12/19 3:47 pm, Daniel Axtens wrote:
>> This helps with powerpc support, and should have no effect on
>> anything else.
>>
>> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> If you follow the recommendations by Christophe and I, you don't need this patch

I guess you mean Patch 1 (the one adding the const to all arches) is not 
needed. Of course this one (Patch 2) is needed as it is the one that 
changes kasan.h to use const table size instead of impossible variable 
table size.

And that would also fix the problem reported by the kbuild test robot.

Christophe
