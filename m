Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931FCC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhKVPFh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 10:05:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60516 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhKVPFg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Nov 2021 10:05:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C34E218F0;
        Mon, 22 Nov 2021 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637593349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvPdialsrkJMgYvpdKiSnsfyGngxWmNa/ZN7M0ULl+o=;
        b=myZMIq0j4sZ8Deql43cZdR3zYzUiBJe7aU7qwq52RjOk8FOj7Ziu6j4xrZy1m93ceFQ0HX
        EOOZWxU53InTXg9jYpyBZzm41hUGJueDadyV6hYvrYbwx04BUzUGZJqWQp42MxN8O2pJg6
        NmojDb5uBHj/Y/Q7mmjRMVKuPlog1OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637593349;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvPdialsrkJMgYvpdKiSnsfyGngxWmNa/ZN7M0ULl+o=;
        b=G8bhMr7G6s/SNcLfl9NgCsVofulfiEKmZYKTougAofcsP4wv3IG8d/QkaqbmADtvZx03Nj
        KEZwMpDqNnK2tVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0CDD13B44;
        Mon, 22 Nov 2021 15:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Gn6OQSxm2HtBgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 22 Nov 2021 15:02:28 +0000
Message-ID: <b513bbcf-f1ea-cfa6-763a-003a60e51da5@suse.cz>
Date:   Mon, 22 Nov 2021 16:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
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
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 1/1] mm/slub: fix endless "No data" printing for
 alloc/free_traces attribute
In-Reply-To: <20211119205943.1ee5da0d@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/19/21 20:59, Gerald Schaefer wrote:
> On Fri, 19 Nov 2021 11:41:38 +0100
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 11/17/21 20:39, Gerald Schaefer wrote:
>> > Reading from alloc/free_traces attribute in /sys/kernel/debug/slab/ results
>> > in an endless sequence of "No data". This is because slab_debugfs_start()
>> > does not check for a "past end of file" condition and return NULL.
>> 
>> I still have no idea how that endless sequence happens.
>> To get it, we would have to call slab_debugfs_show() repeatedly with such v
>> that *v == 0. Which should only happen with slab_debugfs_start() with *ppos
>> == 0. Which your patch won't change because you add a '*ppos > t->count'
>> condition, so *ppos has to be at least 1 to trigger this.
> 
> Yes, very strange. After a closer look to fs/seq_file.c, especially
> seq_read_iter(), it seems that op->next will only be called when m->count == 0,
> at least in the first while(1) loop. Printing "No data\n" sets m->count
> to 8, so it will continue after Fill:, then call op->next, which returns NULL
> and breaks the second while(1) loop, and also calls op->stop. Then it returns
> from seq_read_iter(), only to be called again, and again, ...
> 
> Only when op->start returns NULL it will end it for good, probably
> because seq_read_iter() will then return 0 instead of 8.

Ah, thanks for investigating.

> Not sure if
> there is a better way to fix this than by adding a second "return NULL"
> to op->start, which feels a bit awkward and makes you wonder why the
> "return NULL" from op->next is not enough.

I think it's fine to require op->start to return NULL, even if it didn't
cause this infinite loop.

>> 
>> But yeah, AFAIK we should detect this in slab_debugfs_start() anyway.
>> But I think the condition should be something like below, because we are
>> past end of file already with *ppos == t->count. But if both are 0, we want
>> to proceed for the "No data" output.
> 
> Ah ok, I wasn't sure about the "t->count > 0" case, i.e. if the check for
> "*ppos > t->count" would still be correct there. So apparently it wouldn't,
> and we need two checks, like you suggested
> 
>> 
>> // to show the No data
>> if (!*ppos && !t->count)
>> 	return ppos;
>> 
>> if (*ppos >= t->count)
>> 	return ppos;
> 
> That should be return NULL here, right?

Doh, right.

>> 
>> return ppos;
>> 
> 
> Will send a new patch, unless I find a better way after investigating the
> endless seq_read_iter() calls mentioned above.
> Is there an easy way to test the "t->count > 0" case, i.e. what would need
> to be done to get some other reply than "No data"?

Hm the debugfs files alloc_tracess/free_traces for any cache with non-zero
objects (see /proc/slabinfo for that) should have t->count > 0. If the files
are created for a cache, it means the related SLAB_STORE_USER debugging was
enabled both during config and boot-time. If you see only a few caches with
alloc_tracess/free_traces (because they are from e.g. some test module that
adds SLAB_STORE_USER explicitly) and all happen to have 0 objects, boot with
slub_debug=U parameter and then all caches will have this enabled and many
will have >0 objects.
