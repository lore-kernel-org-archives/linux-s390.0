Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5E1C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 25 Nov 2021 22:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhKYWG4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:06:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52936 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbhKYWE4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Nov 2021 17:04:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B4AC21958;
        Thu, 25 Nov 2021 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637877703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhGyyEy5L8WgdyokDEpWTRx8+YBeehBixiH5tCcNl20=;
        b=vDucD2lk//nadMAhVmhbTapYwQZW3ZrItRdCfN0xUXBcsnTWOTfgo/kJDk7ctX/NpNfDqo
        iZRWzJu6JZ3Btp3IA+Deetob3e8+EQJpG/n84m9KJL1JZQDXXEMvoUqz5Jaq76wOQyEJBP
        ncIcyEWbIwsOxBFsaq4BJaVqX9B8QsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637877703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhGyyEy5L8WgdyokDEpWTRx8+YBeehBixiH5tCcNl20=;
        b=UWX+LSYN552ZDT36jWj7VzJFEvX+VgOjIbAMMP4qVurg/P7X/gfd7ZxsQL3luXfb1vkwIW
        f6tCeZiy9Na/k6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5181013F95;
        Thu, 25 Nov 2021 22:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MiHxEscHoGHbUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Nov 2021 22:01:43 +0000
Message-ID: <7c909b82-8e1c-a8ce-516d-e3aa9bc2fd81@suse.cz>
Date:   Thu, 25 Nov 2021 23:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 1/1] mm/slub: fix endless "No data" printing for
 alloc/free_traces attribute
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
 <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
 <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
 <20211119205943.1ee5da0d@thinkpad>
 <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
 <20211122211400.41bf64cf@thinkpad> <20211122213330.66b7893e@thinkpad>
 <a081d544-41f0-29ab-6d46-1afa382af8be@suse.cz>
 <20211125171310.0fd27afa@thinkpad> <20211125211249.23a84729@thinkpad>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211125211249.23a84729@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/25/21 21:12, Gerald Schaefer wrote:
> On Thu, 25 Nov 2021 17:13:10 +0100
> Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> 
>> On Tue, 23 Nov 2021 15:19:49 +0100
>> Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>>> On 11/22/21 21:33, Gerald Schaefer wrote:
>>>> On Mon, 22 Nov 2021 21:14:00 +0100
>>>> Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
>>>>
>>>> [...]
>>>>>
>>>>> Thanks. While testing this properly, yet another bug showed up. The idx
>>>>> in op->show remains 0 in all iterations, so I always see the same line
>>>>> printed t->count times (or infinitely, ATM). Not sure if this only shows
>>>>> on s390 due to endianness, but the reason is this:
>>>>>
>>>>>   unsigned int idx = *(unsigned int *)v;
>>>
>>> Uh, good catch. I was actually looking suspiciously at how we cast signed to
>>> unsigned, but didn't occur to me that shortening together with endiannes is
>>> the problem.
>>>
>>>>>
>>>>> IIUC, void *v is always the same as loff_t *ppos, and therefore idx also
>>>>> should be *ppos. De-referencing the loff_t * with an unsigned int * only
>>>>> gives the upper 32 bit half of the 64 bit value, which remains 0.
>>>>>
>>>>> This would be fixed e.g. with
>>>>>
>>>>>   unsigned int idx = (unsigned int) *(loff_t *) v;
>>>
>>> With all this experience I'm now inclined to rather follow more the example
>>> in Documentation/filesystems/seq_file.rst and don't pass around the pointer
>>> that we got as ppos in slab_debugfs_start(), and that seq_file.c points to
>>> m->index.
>>>
>>> In that example an own value is kmalloced:
>>>
>>> loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
>>>
>>> while we could just make this a field of loc_track?
>>
>> Yes, following the example sounds good, and it would also make proper use
>> of *v in op->next, which might make the code more readable. It also looks
>> like it already does exactly what is needed here, i.e. have a simple
>> iterator that just counts the lines.
>>
>> I don't think the iterator needs to be saved in loc_track. IIUC, it is
>> already passed around like in the example, and can then be simply compared
>> to t->count, similar to the existing code.

Saving it the loc_track doesn't preclude using the pointer that's being
passed around. It however avoids the extra kmalloc and turns out it
should also solve the return NULL from op->next() issue you describe below?

>> This is what I'm currently testing, and it seems to work fine. Will send
>> a new patch, if there are no objections:
> 
> Oh well, I have one objection, returning NULL from op->next will be
> passed to op->stop, and then it will not free the allocated value.
> 
> The example is elegantly avoiding this, by not returning NULL anywhere,
> and also not stopping. Sigh.
> 
> Maybe not return NULL in op->next, but only from op->start, and only
> when no allocation was made or it was freed already? Or free it only/
> already in op->next, when returning NULL?

From these two probably the "free in op->next". But still inclined to
store it in loc_track.
Why does the API need to be so awkward...


