Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95248C4743D
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770B761185
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 14:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhFHO7g (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:59:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26169 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhFHO7f (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 8 Jun 2021 10:59:35 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FztdJ6WHszBDj8;
        Tue,  8 Jun 2021 16:57:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rYF-J-sCzJxT; Tue,  8 Jun 2021 16:57:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FztdJ5XkGzBDj7;
        Tue,  8 Jun 2021 16:57:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A9A608B7BF;
        Tue,  8 Jun 2021 16:57:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Kq4BMwCmb5qz; Tue,  8 Jun 2021 16:57:40 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B2B78B7C0;
        Tue,  8 Jun 2021 16:57:39 +0200 (CEST)
Subject: Re: [PATCH v3 resend 01/15] mm: add setup_initial_init_mm() helper
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
 <20210608083418.137226-2-wangkefeng.wang@huawei.com>
 <CAFqt6zYmCQ=wxEjnOJ6fgJWYQyFajBuxWD=UT_D-WjWUS_4pcw@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <34f88fdc-1842-7954-bccc-0142a8d66eea@csgroup.eu>
Date:   Tue, 8 Jun 2021 16:57:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYmCQ=wxEjnOJ6fgJWYQyFajBuxWD=UT_D-WjWUS_4pcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Le 08/06/2021 à 16:53, Souptick Joarder a écrit :
> On Tue, Jun 8, 2021 at 1:56 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> Add setup_initial_init_mm() helper to setup kernel text,
>> data and brk.
>>
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-csky@vger.kernel.org
>> Cc: uclinux-h8-devel@lists.sourceforge.jp
>> Cc: linux-m68k@lists.linux-m68k.org
>> Cc: openrisc@lists.librecores.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: x86@kernel.org
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/mm.h | 3 +++
>>   mm/init-mm.c       | 9 +++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index c274f75efcf9..02aa057540b7 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -244,6 +244,9 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
>>
>>   #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
>>
>> +void setup_initial_init_mm(void *start_code, void *end_code,
>> +                          void *end_data, void *brk);
>> +
> 
> Gentle query -> is there any limitation to add inline functions in
> setup_arch() functions ?

Kefeng just followed comment from Mike I guess, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210604070633.32363-2-wangkefeng.wang@huawei.com/#2696253

Christophe

