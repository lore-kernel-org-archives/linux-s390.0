Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A82C43334
	for <linux-s390@archiver.kernel.org>; Thu, 23 Jun 2022 15:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiFWPow (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiFWPow (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Jun 2022 11:44:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A9236B6A;
        Thu, 23 Jun 2022 08:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDD49B82435;
        Thu, 23 Jun 2022 15:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39956C3411B;
        Thu, 23 Jun 2022 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655999088;
        bh=E/PWTSDjWAEtShzaTXlO2ocUe9kuMzdsrUobTKa3QUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0aZZhsAqPnPW8NoqNs5vPFs+OSvJMQ10fhAh6psx+vyxETEOge7pEWQcF+xDHZmB
         G+tvZnyTLz2HutznxlAeM72u1enfJiWm45rmztBw8uHXKbS1cs4BA4cNPoInE7aqV7
         gCIsfQ0tdDv6sikaY+jIaJyF7PNJ/aZ1PlOkr9aY=
Date:   Thu, 23 Jun 2022 17:44:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     stable@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: please consider for stable: "s390/mm: use non-quiescing sske for
 KVM switch to keyed guest"
Message-ID: <YrSKbXdkSJ0UfBul@kroah.com>
References: <20220623151520.73354-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623151520.73354-1-borntraeger@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 23, 2022 at 05:15:20PM +0200, Christian Borntraeger wrote:
> stable team, please consider
> commit 3ae11dbcfac906a8c3a480e98660a823130dc16a
> It will noticeable reduce system overhead when this happens on multiple CPUs.
> 
> ----snip----
> commit 3ae11dbcfac906a8c3a480e98660a823130dc16a
>     s390/mm: use non-quiescing sske for KVM switch to keyed guest
>     
>     The switch to a keyed guest does not require a classic sske as the other
>     guest CPUs are not accessing the key before the switch is complete.
>     By using the NQ SSKE things are faster especially with multiple guests.
> 
>     
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Suggested-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Link: https://lore.kernel.org/r/20220530092706.11637-3-borntraeger@linux.ibm.com
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 697df02362af..4909dcd762e8 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -748,7 +748,7 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>  	pgste_val(pgste) |= PGSTE_GR_BIT | PGSTE_GC_BIT;
>  	ptev = pte_val(*ptep);
>  	if (!(ptev & _PAGE_INVALID) && (ptev & _PAGE_WRITE))
> -		page_set_storage_key(ptev & PAGE_MASK, PAGE_DEFAULT_KEY, 1);
> +		page_set_storage_key(ptev & PAGE_MASK, PAGE_DEFAULT_KEY, 0);
>  	pgste_set_unlock(ptep, pgste);
>  	preempt_enable();
>  }

Now queued up to all stable branches (as you didn't mention
otherwise...)

thanks,

greg k-h
