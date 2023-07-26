Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78637C0015E
	for <linux-s390@archiver.kernel.org>; Wed, 26 Jul 2023 15:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjGZPUv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGZPUu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Jul 2023 11:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9069FC
        for <linux-s390@vger.kernel.org>; Wed, 26 Jul 2023 08:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C8E61B5F
        for <linux-s390@vger.kernel.org>; Wed, 26 Jul 2023 15:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FACAC433C7;
        Wed, 26 Jul 2023 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384848;
        bh=UdgWQHT8/s2AG2mcOfNXgTwTRgWauYx2U4y1nq4YyAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUI+B47D/Odi7XdBtjy2w6689y9FvJog5OzG7fLSM/FLrsldiuvepF+uZY+HNafDR
         3q04VyHxXwwpPhqZWAHzomPExZMz0/bo49T1yJIe12cec4Z8lIL/aHRaJGGBeK1DS5
         ucEhBLrJbLC4RSiK+VmlK1x13T8kI16CxrY9hbJN8pd7faRDPrYFIZatlTeD5zGpyx
         Lh49Bstq/xTAVnJOc1r7B21FKBEOxg98hbcTvZ26bbeeBhK5h7t265jYBBzF16HETF
         i777p7L3vyNkGi65EIiEiQXb7gAEOCBI7zot68E6ZDfMG3jfCE1g0W1K/2PmUyPDtb
         20QmPp5uuHIEQ==
Date:   Wed, 26 Jul 2023 08:20:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/ftrace: use la instead of aghik in
 return_to_handler()
Message-ID: <20230726152046.GA3828563@dev-arch.thelio-3990X>
References: <20230726061834.1300984-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726061834.1300984-1-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 26, 2023 at 08:18:34AM +0200, Heiko Carstens wrote:
> Nathan Chancellor reported the following build error when compiling the
> kernel with CONFIG_MARCH_Z10=y:
> 
>   arch/s390/kernel/mcount.S: Assembler messages:
>   arch/s390/kernel/mcount.S:140: Error: Unrecognized opcode: `aghik'
> 
> The aghik instruction is only available since z196. Use the la instruction
> instead which is available for all machines.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20230725211105.GA224840@dev-arch.thelio-3990X
> Fixes: 1256e70a082a ("s390/ftrace: enable HAVE_FUNCTION_GRAPH_RETVAL")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> ---
>  arch/s390/kernel/mcount.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> index d2596e0df6fa..71c5fa05e7f1 100644
> --- a/arch/s390/kernel/mcount.S
> +++ b/arch/s390/kernel/mcount.S
> @@ -137,7 +137,7 @@ SYM_FUNC_START(return_to_handler)
>  	lgr	%r1,%r15
>  	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
>  	stg	%r1,__SF_BACKCHAIN(%r15)
> -	aghik	%r3,%r15,STACK_FRAME_OVERHEAD
> +	la	%r3,STACK_FRAME_OVERHEAD(%r15)
>  	stg	%r1,__FGRAPH_RET_FP(%r3)
>  	stg	%r2,__FGRAPH_RET_GPR2(%r3)
>  	lgr	%r2,%r3
> -- 
> 2.39.2
> 
