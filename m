Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A86C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2961B61B1E
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 09:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhKSJqM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:46:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55758 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhKSJqM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Nov 2021 04:46:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D512A212CC;
        Fri, 19 Nov 2021 09:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637314989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VX3PGrE+25kT7jUiLyGbGWn7NLwxIdCLfX6UOewXBmE=;
        b=E2In/Fm7l/NySQZPBXGCz+1MVCMUBys0KjhqF42c3F/eagxa54Evufx67NQuEjNJ8rpvlW
        jIaDJ9NOb+CzINbWZcODY11QpM+Sks7nxkDw86XK2ZA/McC6WHuqZlg1qx2GWiazdOLN4a
        lC8ud/jObIQ4aoD7vO903PSs8nnYzHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637314989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VX3PGrE+25kT7jUiLyGbGWn7NLwxIdCLfX6UOewXBmE=;
        b=uKGznVZ3f3rOSyuiO2MEoW3cDiSChGoZU5on37c4gMRmp9H3zmFFLLCoMAl7Of/p4yHVSv
        FRDMeOLz4nvkreCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA5C913A5E;
        Fri, 19 Nov 2021 09:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YG86KK1xl2HNeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 19 Nov 2021 09:43:09 +0000
Message-ID: <48b1acd4-21fe-2d6c-ba68-a95cef86d176@suse.cz>
Date:   Fri, 19 Nov 2021 10:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 0/1] mm/slub: endless "No data" printing for
 alloc/free_traces attribute
In-Reply-To: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/17/21 20:39, Gerald Schaefer wrote:
> Steffen reported endless printing of "No data" when reading from
> alloc/free_traces attribute in /sys/kernel/debug/slab/, at least on
> s390, but I don't see how this could be arch-specific.
> 
> I must admit that I am completely confused by the seq_file interface

Me too, everytime I have to deal with it I relearn it.

> in general, but even more so from this specific implementation.

Right.

> First I suspected a bug in slab_debugfs_next(), because of its very
> weird usage of the *v parameter, which seems totally useless, but not
> responsible for this bug. Still, out of curiosity, does anybody have a
> clue why it is done this way, and not e.g. like this?
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f7368bfffb7a..0b1832b16f5b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6105,10 +6105,9 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>  {
>         struct loc_track *t = seq->private;
> 
> -       v = ppos;
>         ++*ppos;
>         if (*ppos <= t->count)
> -               return v;
> +               return ppos;
> 
>         return NULL;
>  }

Yeah that should work and make it a bit less confusing.

> 
> Anyway, NULL is returned for the "*ppos > t->count" case, as described
> in Documentation/filesystems/seq_file.rst, for "if the sequence is
> complete", so that should be ok, but still very confusing. Unfortunately,
> the documentation does not seem to explain that *v parameter at all, or
> I missed it, but in this case here it seems to be simply ignored and
> misused w/o any need.
> 
> The documentation does mention that "in most cases the start() function
> should check for a "past end of file" condition and return NULL if need
> be". So I just added a similar check to slab_debugfs_start() and return
> NULL for "*ppos > t->count", which apparently fixed the bug. "No data"
> is now only printed once, like it was before commit 64dd68497be7
> ("mm: slub: move sysfs slab alloc/free interfaces to debugfs").
> 
> However, since I obviously do not really understand the seq_file
> documentation, and also not the alloc/free_traces stuff in general,
> that fix might be wrong or incomplete. Comments are welcome.
> 
> Gerald Schaefer (1):
>   mm/slub: fix endless "No data" printing for alloc/free_traces
>     attribute
> 
>  mm/slub.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

