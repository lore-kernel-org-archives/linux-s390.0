Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3335C3DA6F
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 12:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbjHYMOl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbjHYMOR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 08:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415EF1B2;
        Fri, 25 Aug 2023 05:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C643065A34;
        Fri, 25 Aug 2023 12:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA50C433C7;
        Fri, 25 Aug 2023 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965655;
        bh=DGoz6KzOTXVMSwQRtBgLEegG15niFTdOuyLpZpiEXgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xw3A8s/if7GcQL79HWZjwF3+iCpAoAFj7uaK+Z1bZEBoRwGQTW2BKQS9Dvv6LJF3a
         +tzhi47VXQRyMzdOpw6BVFtaB7PwgHNOft9Vq29YV8afO9gc33Is0VZwQSfRfpT0EQ
         wmVjx+s1ecUkRxqAmRDsG/SaW44iIziTSJl8tt94hwQBzBPw9QJlWXqdAI/zLzfjEX
         io2NeUHaNKf/dYPXzH1k8w2KinSHwwZX8dy0E5FjqxtXDFaJUDJB65xumF5nZN2XAs
         2nux1PxnSiQULS8V2vHCQJ42wrWleXYBUlFaezv24WVSgKpj45Scx2rC+SAYSMeFSN
         Fyr3rrhMy2TtA==
Date:   Fri, 25 Aug 2023 14:14:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/29] s390/dasd: Convert to bdev_open_by_path()
Message-ID: <20230825-wegfahren-wutentbrannt-d8e0b7aef344@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-14-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-14-jack@suse.cz>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:25PM +0200, Jan Kara wrote:
> Convert dasd to use bdev_open_by_path() and pass the handle around.
> 
> CC: linux-s390@vger.kernel.org
> CC: Christian Borntraeger <borntraeger@linux.ibm.com>
> CC: Sven Schnelle <svens@linux.ibm.com>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
