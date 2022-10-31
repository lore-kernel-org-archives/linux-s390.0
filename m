Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEABFA3741
	for <linux-s390@archiver.kernel.org>; Mon, 31 Oct 2022 15:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJaP6c (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiJaP6b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 31 Oct 2022 11:58:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DD411C30
        for <linux-s390@vger.kernel.org>; Mon, 31 Oct 2022 08:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E462B8189E
        for <linux-s390@vger.kernel.org>; Mon, 31 Oct 2022 15:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E76C433D6;
        Mon, 31 Oct 2022 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667231908;
        bh=Tx/7MW3BKdWM7pb/4p2U84ZYortrpAKA47CQmhAuOK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBTMKfTXk2pW6vC9MbKvcWnN9HQAeMGjbE8ooZADJiZU66aB9/ep3jrjv5wKmcWKU
         1rrm4QCEp/T544C3zfV4KSQZOhXkYvNxLDQECVHacQ0CFLJo/vOWVOKAYLfm3Hnigf
         icSTEI9A1Ph5uFYauIAOn2AGueizb1P29zF8E2B3M6TY5rJCkp0jR6YQnhX5nJSXnD
         7IUXpcye9HjfZCbcPhlRtXiZgKDVTnHJVn5MTDniPS6tHdH5ndXLkcdf8Lx7MpIH2O
         72VuMvNG4LQguOBcoZlCgY7834NYOUI/tfA7GiQQdLSV4+pzgEgxUQjdK8ddlhLn+X
         MAGh1DW3ZaRfA==
Date:   Mon, 31 Oct 2022 08:58:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] scripts/min-tool-version.sh: raise minimum clang version
 to 15.0.0 for s390
Message-ID: <Y1/worpj0COQvC5V@dev-arch.thelio-3990X>
References: <20221031123456.3872220-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031123456.3872220-1-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 31, 2022 at 01:34:56PM +0100, Heiko Carstens wrote:
> Before version 14.0.0 llvm's integrated assembler may silently
> generate corrupted code on s390. See e.g. commit e9953b729b78
> ("s390/boot: workaround llvm IAS bug") for further details.
> 
> While there have been workarounds applied for all known existing
> locations, there is nothing that prevents that new code with
> problematic patterns will be added.
> 
> Therefore raise the minimum clang version to 15.0.0. Note that llvm
> commit e547b04d5b2c ("[SystemZ] Bugfix for symbolic displacements."),
> which is included in 15.0.0, fixes the broken code generation.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Seems like a reasonable thing to bump the minimum supported version
over.

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/min-tool-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index b6593eac5003..201bccfbc678 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -25,7 +25,7 @@ icc)
>  	;;
>  llvm)
>  	if [ "$SRCARCH" = s390 ]; then
> -		echo 14.0.0
> +		echo 15.0.0
>  	else
>  		echo 11.0.0
>  	fi
> -- 
> 2.34.1
> 
