Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72903C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 14:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhKWOW7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 09:22:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45388 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhKWOW7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 09:22:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 536B11FD5A;
        Tue, 23 Nov 2021 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637677190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kT7jdM+og8nQEQoacDI77ABxFW0VRbd3Wzpd4VwME0M=;
        b=EnRMQ/Ec1yNfADLNtI/e6Y3z3IxcXg0IlLoT78VavXjKHvLn908XX8AFy5qTPFIpYYOAHS
        RT0y2lqkykSpRleP51OOjh6gFXjBFFp30ptphkNjJ4q6jwSEC5PDWU367WgqUdAScKU9YY
        dCweo+WpfhRghtfceXsIVuE99T9VmkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637677190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kT7jdM+og8nQEQoacDI77ABxFW0VRbd3Wzpd4VwME0M=;
        b=m3gdUeGt6diN9yaVg7VrHFdgwYl5CzpHxIotjSTv+00nrq+ERL5J41gZpNlicLF4E98OiC
        1fSzqpuC7lwXUZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35DE613E11;
        Tue, 23 Nov 2021 14:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P9x4DIb4nGF7KAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Nov 2021 14:19:50 +0000
Message-ID: <a081d544-41f0-29ab-6d46-1afa382af8be@suse.cz>
Date:   Tue, 23 Nov 2021 15:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
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
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 1/1] mm/slub: fix endless "No data" printing for
 alloc/free_traces attribute
In-Reply-To: <20211122213330.66b7893e@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/22/21 21:33, Gerald Schaefer wrote:
> On Mon, 22 Nov 2021 21:14:00 +0100
> Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> 
> [...]
>> 
>> Thanks. While testing this properly, yet another bug showed up. The idx
>> in op->show remains 0 in all iterations, so I always see the same line
>> printed t->count times (or infinitely, ATM). Not sure if this only shows
>> on s390 due to endianness, but the reason is this:
>> 
>>   unsigned int idx = *(unsigned int *)v;

Uh, good catch. I was actually looking suspiciously at how we cast signed to
unsigned, but didn't occur to me that shortening together with endiannes is
the problem.

>> 
>> IIUC, void *v is always the same as loff_t *ppos, and therefore idx also
>> should be *ppos. De-referencing the loff_t * with an unsigned int * only
>> gives the upper 32 bit half of the 64 bit value, which remains 0.
>> 
>> This would be fixed e.g. with
>> 
>>   unsigned int idx = (unsigned int) *(loff_t *) v;

With all this experience I'm now inclined to rather follow more the example
in Documentation/filesystems/seq_file.rst and don't pass around the pointer
that we got as ppos in slab_debugfs_start(), and that seq_file.c points to
m->index.

In that example an own value is kmalloced:

loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);

while we could just make this a field of loc_track?


>> With this fixed, my original patch actually also works for t->count > 0,
>> because then op->show would return w/o printing anything when idx reaches
>> t->count. For t->count > 0, it would even work w/o any extra checks in
>> op->start because of that, only "No data" would be printed infinitely.
> 
> Oh, no, that would actually also fix the "No data" part, as op->show
> will then also return w/o printing in the next iteration, so that op->next
> would correctly end it all.
> 
> This could also explain why it might all have worked fine on x86 (haven't
> verified), and really only showed on big-endian s390.
> 
> Hmm, now I'm not so sure anymore if we really want the additional
> checks and return NULL in op->start, just to make it "double safe".

I guess we don't.

>> 
>> It probably still makes sense to make this explicit in op->start, by
>> checking separately for !*ppos && !t->count, and returning NULL for
>> *ppos >= t->count, as you suggested.
>> 
>> I think I will also make idx an unsigned long again, like it was before
>> commit 64dd68497be7, and similar to t->count. Not sure if it needs to
>> be, and with proper casting unsigned int is also possible, but why
>> change it?
> 

