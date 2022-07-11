Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6614DC43334
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 17:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiGKRwL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiGKRv6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 13:51:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159C87B346
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 10:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ED3EB8111A
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 17:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41DBC34115;
        Mon, 11 Jul 2022 17:51:47 +0000 (UTC)
Date:   Mon, 11 Jul 2022 13:51:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] trace-cmd: fix writing of uncompressed size
Message-ID: <20220711135146.35e163b0@gandalf.local.home>
In-Reply-To: <20220711094340.2829115-1-svens@linux.ibm.com>
References: <20220711094340.2829115-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 11 Jul 2022 11:43:40 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> pointer in struct tracecmd_compression is 'unsigned long', which is 8 byte
> in size on most platforms, but the tep_read_number() call in the next line
> treats it as a 4 byte value. As there's no need for unsigned long change
> the type to unsigned int.
> 
> Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Hi Sven,

Can you resend and Cc linux-trace-devel@vger.kernel.org so that it gets
added to patchwork.

Thanks!

-- Steve


> ---
>  lib/trace-cmd/trace-compress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
> index a63295e..461de8d 100644
> --- a/lib/trace-cmd/trace-compress.c
> +++ b/lib/trace-cmd/trace-compress.c
> @@ -32,7 +32,7 @@ struct tracecmd_compression {
>  	int				fd;
>  	unsigned int			capacity;
>  	unsigned int			capacity_read;
> -	unsigned long			pointer;
> +	unsigned int			pointer;
>  	char				*buffer;
>  	struct compress_proto		*proto;
>  	struct tep_handle		*tep;

