Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E7AC48BC2
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 05:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1456120F
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 05:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbhFGFuw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 01:50:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23881 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhFGFus (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 7 Jun 2021 01:50:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fz2Vc3ZsszB9cJ;
        Mon,  7 Jun 2021 07:48:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vyaOJDm2hiAi; Mon,  7 Jun 2021 07:48:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fz2Vc2XHVzB9Zm;
        Mon,  7 Jun 2021 07:48:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 436848B77F;
        Mon,  7 Jun 2021 07:48:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KgJWM97gaIvs; Mon,  7 Jun 2021 07:48:56 +0200 (CEST)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E86C38B763;
        Mon,  7 Jun 2021 07:48:55 +0200 (CEST)
Subject: Re: [PATCH v2 00/15] init_mm: cleanup ARCH's text/data/brk setup code
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <YL0+Jargm+y9aqx1@kernel.org>
 <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <006eb573-5a20-1ac7-6234-338d11346a08@csgroup.eu>
Date:   Mon, 7 Jun 2021 07:48:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Kefeng,

Le 07/06/2021 à 02:55, Kefeng Wang a écrit :
> 
> On 2021/6/7 5:29, Mike Rapoport wrote:
>> Hello Kefeng,
>>
>> On Fri, Jun 04, 2021 at 03:06:18PM +0800, Kefeng Wang wrote:
>>> Add setup_initial_init_mm() helper, then use it
>>> to cleanup the text, data and brk setup code.
>>>
>>> v2:
>>> - change argument from "char *" to "void *" setup_initial_init_mm()
>>>    suggested by Geert Uytterhoeven
>>> - use NULL instead of (void *)0 on h8300 and m68k
>>> - collect ACKs
>>>
>>> Cc: linux-snps-arc@lists.infradead.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-csky@vger.kernel.org
>>> Cc: uclinux-h8-devel@lists.sourceforge.jp
>>> Cc: linux-m68k@lists.linux-m68k.org
>>> Cc: openrisc@lists.librecores.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: linux-riscv@lists.infradead.org
>>> Cc: linux-sh@vger.kernel.org
>>> Cc: linux-s390@vger.kernel.org
>>> Kefeng Wang (15):
>>>    mm: add setup_initial_init_mm() helper
>>>    arc: convert to setup_initial_init_mm()
>>>    arm: convert to setup_initial_init_mm()
>>>    arm64: convert to setup_initial_init_mm()
>>>    csky: convert to setup_initial_init_mm()
>>>    h8300: convert to setup_initial_init_mm()
>>>    m68k: convert to setup_initial_init_mm()
>>>    nds32: convert to setup_initial_init_mm()
>>>    nios2: convert to setup_initial_init_mm()
>>>    openrisc: convert to setup_initial_init_mm()
>>>    powerpc: convert to setup_initial_init_mm()
>>>    riscv: convert to setup_initial_init_mm()
>>>    s390: convert to setup_initial_init_mm()
>>>    sh: convert to setup_initial_init_mm()
>>>    x86: convert to setup_initial_init_mm()
>> I might be missing something, but AFAIU the init_mm.start_code and other
>> fields are not used really early so the new setup_initial_init_mm()
>> function can be called in the generic code outside setup_arch(), e.g in
>> mm_init().
> 
> Hi Mike， each architecture has their own value, not the same, eg m68K and
> 
> h8300, also the name of the text/code/brk is different in some arch, so I keep
> 
> unchanged.

What you could do is to define a __weak function that architectures can override and call that 
function from mm_init() as suggested by Mike,

Something like:

void __weak setup_initial_init_mm(void)
{
	init_mm.start_code = (unsigned long)_stext;
	init_mm.end_code = (unsigned long)_etext;
	init_mm.end_data = (unsigned long)_edata;
	init_mm.brk = (unsigned long)_end;
}

Then only the few architecture that are different would override it.

I see a few archictectures are usigne PAGE_OFFSET to set .start_code, but it is likely that this is 
equivalent to _stext.

Christophe
