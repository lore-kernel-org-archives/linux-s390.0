Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A5C00140
	for <linux-s390@archiver.kernel.org>; Sat,  6 Aug 2022 01:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiHFBpI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Aug 2022 21:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiHFBpH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Aug 2022 21:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D225C69;
        Fri,  5 Aug 2022 18:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DB761534;
        Sat,  6 Aug 2022 01:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F9C433D6;
        Sat,  6 Aug 2022 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659750305;
        bh=KNDqgg8mIKARNFJ0Iq8jaByC8vx+ahamkXoPoyfikGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P3IwgrQ+6Lk5HuNYx2OKg6rlwGNfwSeTdGPRh7pVMhQxbLLxylKXxwDlYZJXFyvl4
         ZMIzAYl9di7xZbM/xObMzVVoIr5B+0mqKCVcLCpKRVvP2+HL7LqV4h0bEho4qHz4DG
         gSRBVrKndPh6oe06+UWWI7m0e0JKZ/CVXsUVyr2C1OpcjpS5FxgcSODRVYvk5F7oBh
         JEFmxDvsrnyNPYuLs93XSBVhNd81vybkIJuZwzodMamRzqMm5sDxNEtr/7NIq3ZCyg
         5GXr0swefv6QrQlvDxQXuE+8kSNJt0QKfXDC/3BIyl0hZ6ppXN9Lprywb7y21GOdaH
         HDeXivKXgJtYg==
Date:   Fri, 5 Aug 2022 18:45:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Subject: Re: [PATCH net v2] s390/qeth: cache link_info for ethtool
Message-ID: <20220805184504.7f6f2a4a@kernel.org>
In-Reply-To: <20220805155714.59609-1-wintera@linux.ibm.com>
References: <20220805155714.59609-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  5 Aug 2022 17:57:14 +0200 Alexandra Winter wrote:
> Since
> commit e6e771b3d897 ("s390/qeth: detach netdevice while card is offline")
> there was a timing window during recovery, that qeth_query_card_info could
> be sent to the card, even before it was ready for it, leading to a failing
> card recovery. There is evidence that this window was hit, as not all
> callers of get_link_ksettings() check for netif_device_present.
> 
> Use cached values in qeth_get_link_ksettings(), instead of calling
> qeth_query_card_info() and falling back to default values in case it
> fails. Link info is already updated when the card goes online, e.g. after
> STARTLAN (physical link up). Set the link info to default values, when the
> card goes offline or at STOPLAN (physical link down). A follow-on patch
> will improve values reported for link down.
> 
> Fixes: e6e771b3d897 ("s390/qeth: detach netdevice while card is offline")
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>

Ah, looks like you figured out what my confusion was and squashed 
the patches :) That works, too.
