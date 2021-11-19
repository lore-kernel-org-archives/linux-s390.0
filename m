Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8AEC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B0F61260
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhKSKol (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:44:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59886 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSKol (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Nov 2021 05:44:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9470B212CB;
        Fri, 19 Nov 2021 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637318498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEdjSkcmqgaAJi5NZaLQUL1ZPtQeDbsPBnmJqoG7GyY=;
        b=hnNBpFWw3qJyIJ7hHxIHxLiQDIj0zFoerwi5hKzkRQVU9YTH9VdoLiJiAwz8Yk88ywGLi6
        Lw70SQrqwr77sfoISW6jtmQDPLLQ2Zdapj0VN1UhaQJ01ocoMjc8ekWxtw/oBGaGl4WOSa
        yP1FevKDIKxxWoSFBOUKO7uN8Flp0ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637318498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEdjSkcmqgaAJi5NZaLQUL1ZPtQeDbsPBnmJqoG7GyY=;
        b=c7eokoxvgRpeHLPNoSsti1DkLyN/RLz/qm+Uo9WUiX9ui4DSbHkg8V768vczNg/VIUeskN
        +a3u1BK6qO6i81Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74DA213A8A;
        Fri, 19 Nov 2021 10:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KkzqG2J/l2GtFQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 19 Nov 2021 10:41:38 +0000
Message-ID: <9a4367c0-8141-f03c-e5a1-13483794d3e8@suse.cz>
Date:   Fri, 19 Nov 2021 11:41:38 +0100
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
 <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 1/1] mm/slub: fix endless "No data" printing for
 alloc/free_traces attribute
In-Reply-To: <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/17/21 20:39, Gerald Schaefer wrote:
> Reading from alloc/free_traces attribute in /sys/kernel/debug/slab/ results
> in an endless sequence of "No data". This is because slab_debugfs_start()
> does not check for a "past end of file" condition and return NULL.

I still have no idea how that endless sequence happens.
To get it, we would have to call slab_debugfs_show() repeatedly with such v
that *v == 0. Which should only happen with slab_debugfs_start() with *ppos
== 0. Which your patch won't change because you add a '*ppos > t->count'
condition, so *ppos has to be at least 1 to trigger this.

But yeah, AFAIK we should detect this in slab_debugfs_start() anyway.
But I think the condition should be something like below, because we are
past end of file already with *ppos == t->count. But if both are 0, we want
to proceed for the "No data" output.

// to show the No data
if (!*ppos && !t->count)
	return ppos;

if (*ppos >= t->count)
	return ppos;

return ppos;

> Fix it by adding such a check and return NULL.
> 
> Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
> Cc: <stable@vger.kernel.org> # v5.14+
> Reported-by: Steffen Maier <maier@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  mm/slub.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f7368bfffb7a..336609671bc2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6115,6 +6115,11 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>  
>  static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
>  {
> +	struct loc_track *t = seq->private;
> +
> +	if (*ppos > t->count)
> +		return NULL;
> +
>  	return ppos;
>  }
>  
> 

