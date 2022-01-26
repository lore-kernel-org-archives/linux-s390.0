Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43177C2BA4C
	for <linux-s390@archiver.kernel.org>; Wed, 26 Jan 2022 15:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiAZP3S (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiAZP3S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Jan 2022 10:29:18 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA32C061747
        for <linux-s390@vger.kernel.org>; Wed, 26 Jan 2022 07:29:18 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c15so14896224qtv.1
        for <linux-s390@vger.kernel.org>; Wed, 26 Jan 2022 07:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=94JjWf2A/43cH5ClxjuEuaZiDW/s6CFdqrvtlWdjSgU=;
        b=WhNCJpaNuQaNIWufyFaNSPxgr0aEzT4bzWNo/OUXDQp7qwCMVUt79Fx8fJFjBJ00Xt
         tuaPva46Vtap2WuaMQxzq0F5kT8uROv68JH8d06LwHmu0LXg0kwNbYwQ9KRnwM9HGCKU
         OpKOS0DQHwJJv/N0cWhfpLDuvtmWZo7gLxf+aWfO8MQDKEOlkrVcRitptq31x6lwb8Jr
         fVDvKHz8FAXoU26wizTFR1+Ux6l2G/ziFORP4U4rm69E0MS5sbX7xtW7DeHwkAQN2Wzc
         UON9MSvA5Eofo+ALc/4a4+iZ6ymAtygjiPZa+1J4t3D4NwqiPCirHSmhaO11bUi3wfr9
         6gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=94JjWf2A/43cH5ClxjuEuaZiDW/s6CFdqrvtlWdjSgU=;
        b=tGcODIFL3qsC5Bl1gsQjqxvIJpIBZQgxnKqHapjiKzA1eRU5fpWtSLYLtlhoaibSTg
         xpLZmqeaTq89Fd13gV898kS8tQOdIWCGSERCJWDaDwNnB5hR6LTW4DAMmG3sd+6I9YtW
         Eo1pNv7lJZso7eXKH0rMIS5Jo9FHaoRjeg89P5PUeGqdz92L1t7PQl57fapHt3gVIt7Y
         SMX224n0YydQCopOlYSA+z3BvJV5EYdFljWylc5uK/E+6ODlfXvlWUv2i/sdIxCAcp4M
         owsSx4ooYqi3CAsAHVwDsddkv36a+1fsZ7RDoW96pbc+x07Y1UieDTlp74RzYyZaTaDh
         JiVQ==
X-Gm-Message-State: AOAM5328cntXkVlYvhx6I9jsy3mT6+qnhuqrXzglUT6DH2xkBpeN+7rx
        MGcswyz9yN7mmSonhh82yGSmQc762gv7hQ==
X-Google-Smtp-Source: ABdhPJy8QZgx5k0zaoJJs4SXlIGB55HnSc9nmDoDtSJDUcyJKC4GqbwJNLgLgbnoH2pUqfDvBRoffQ==
X-Received: by 2002:ac8:5dca:: with SMTP id e10mr3962546qtx.272.1643210957301;
        Wed, 26 Jan 2022 07:29:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l10sm11335305qkj.83.2022.01.26.07.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:29:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nCkEW-005Zci-3F; Wed, 26 Jan 2022 11:29:16 -0400
Date:   Wed, 26 Jan 2022 11:29:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tony Lu <tonylu@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, kuba@kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net/smc: Spread workload over multiple cores
Message-ID: <20220126152916.GO8034@ziepe.ca>
References: <20220126130140.66316-1-tonylu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126130140.66316-1-tonylu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jan 26, 2022 at 09:01:39PM +0800, Tony Lu wrote:
> Currently, SMC creates one CQ per IB device, and shares this cq among
> all the QPs of links. Meanwhile, this CQ is always binded to the first
> completion vector, the IRQ affinity of this vector binds to some CPU
> core.

As we said in the RFC discussion this should be updated to use the
proper core APIS, not re-implement them in a driver like this.

Jason
