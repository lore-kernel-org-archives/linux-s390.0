Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24019C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 15:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbiBWP6a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Feb 2022 10:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbiBWP6a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Feb 2022 10:58:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D0BD2CF;
        Wed, 23 Feb 2022 07:58:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E302B820CB;
        Wed, 23 Feb 2022 15:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C37C340E7;
        Wed, 23 Feb 2022 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645631879;
        bh=dSU3WtzpUD98nEOWYdE8NQwT4RAMWaALAJhA92a+OEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CV2+iDyXVjcH5VLXkvC0EUjFupUO0+HMmWPkAk5SIaOu+YFuioWg8s1qvuaPFjnaP
         pDaei6OrXwEw7M/bZrlZsfDqoagpel8f2rb4nTtbmgwRj873OW9ix/P7x6A2uw5F7R
         3CRzANk/ebwN4DS01fme21lBTAIwXfMqQlQ2OtzM=
Date:   Wed, 23 Feb 2022 16:57:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drivers/s390/char: Add Ultravisor io device
Message-ID: <YhZZhfokG+kWXSSF@kroah.com>
References: <20220223144830.44039-1-seiden@linux.ibm.com>
 <20220223144830.44039-2-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223144830.44039-2-seiden@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 23, 2022 at 09:48:28AM -0500, Steffen Eiden wrote:
> --- /dev/null
> +++ b/drivers/s390/char/uvdevice.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright IBM Corp. 2022
> + *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt ".\n"

Nit, this isn't needed as you do not have any pr_* calls that use it :)

thanks,

greg k-h
