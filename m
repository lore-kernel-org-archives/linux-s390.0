Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB4C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 13 Jul 2022 03:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiGMDy4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Jul 2022 23:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiGMDyy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Jul 2022 23:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE4D863E;
        Tue, 12 Jul 2022 20:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC1B1619D6;
        Wed, 13 Jul 2022 03:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AA0C3411E;
        Wed, 13 Jul 2022 03:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657684492;
        bh=gnBy6Ab9XgDFL3xiP37PoQYDOtaIzWpH+OVMx4jzRSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QZslAdHnOE8HFNa5YFPD3ChkV2qkUICCDW3HHhdmbSwBVulxsyWKaExEPGH33CHqA
         mGZU6oRGNalKCX8rGrHIhnDG9DIeJ+rJzFUvu1GrERQdM2mS1C430fYoSE7lQaNyKp
         xSEASO/SDE79EUBZHz++t8I+h4hPsx4CANsRJgwwRsCyF9M3D/4C4WcGnGFbDnSac5
         6lGyotKEFkwySe/C4kdlMfeSFy7ippMs3OzpCuTeKoMiPOWOH0kp6V6IGAk2ZRHkcv
         1NVXO1OVbSeqra3t9sUGE4bDYHyRonvIBkAEAvdh2iKevkUo/wsvlluY9grtDxyZWH
         IPg89h2zQD8Vw==
Date:   Tue, 12 Jul 2022 20:54:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net/smc: Allow virtually contiguous
 sndbufs or RMBs for SMC-R
Message-ID: <20220712205442.22a29fcd@kernel.org>
In-Reply-To: <1657626690-60367-6-git-send-email-guwen@linux.alibaba.com>
References: <1657626690-60367-1-git-send-email-guwen@linux.alibaba.com>
        <1657626690-60367-6-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 12 Jul 2022 19:51:29 +0800 Wen Gu wrote:
> net/smc: Allow virtually contiguous sndbufs or RMBs for SMC-R

This one does not build cleanly on 32bit.
