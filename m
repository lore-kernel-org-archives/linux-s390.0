Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372DC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 21 Apr 2022 08:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386471AbiDUINF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386500AbiDUIMn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Apr 2022 04:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49886DA9
        for <linux-s390@vger.kernel.org>; Thu, 21 Apr 2022 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650528593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5mkp6RgcSobuU7TrowdyzROdlgIwSdHC604GfrT0MY=;
        b=XqADFnvMV1d4VAhOFkM/AyTvFwFbwu3ollVd7T0tqJyNbEeAm4oWpYTfMtusAfepEFbQ++
        j7BHjk1T6OZYfdt8eGhYLcdIIqhOToGnJxeWakGRo14JmF8PR0PdNBrYijrsXt/CQ8YoAB
        kx76NfD1/ctLVpXezbAPhvuOAMl6wzY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-ZEjYV34dNa-mqccqYs5pNA-1; Thu, 21 Apr 2022 04:09:52 -0400
X-MC-Unique: ZEjYV34dNa-mqccqYs5pNA-1
Received: by mail-qk1-f198.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so2842725qkb.16
        for <linux-s390@vger.kernel.org>; Thu, 21 Apr 2022 01:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=p5mkp6RgcSobuU7TrowdyzROdlgIwSdHC604GfrT0MY=;
        b=VUwJ39NeRnSLjmZS1RT7dWdqOs8+YY4EmbE06SEIZQt9JAJg8eDG0bnYHLx93Y+7ZE
         3hD1b+uTBtjyk+SmcdZEH0QKwbArgA0z+nsU9TeSZAAuvGu1H1iw4YuDueUivvYAIb6s
         EmZkRZb39XN65bTT4FWuHcwbx0/mf+gNj773Ci4Aygfc3CiiardhmCG50+PsEkbj8kJ9
         PktocAuy3khb8z/y7JUEPHKEtzFb5dRswwH8nKHgbhT20i8eTLDEtjm9kIaZxrQZQ9XN
         IBl4lyRI5y/JUzN9ne4ZdfhpmA4CjRZqfFcvSe8qHWZVeoA11WtuiAtp9bPe83appd1L
         t0gw==
X-Gm-Message-State: AOAM5315W3fFSzs2p/jYGgPvfo2CQMcGyvHuQvcNfOntEltc7aYjp4Og
        j1NUtKuL5rh3tiIvOmCZ+dV4+jpjqxJWeAR+pPMoYFou0idZNw7WQsZNsRow9+BPCIGyqQ6szoE
        cu/n45bXWVe6UVsOxpeF7lg==
X-Received: by 2002:ac8:5d8e:0:b0:2f1:fbc6:ae89 with SMTP id d14-20020ac85d8e000000b002f1fbc6ae89mr13320681qtx.647.1650528591618;
        Thu, 21 Apr 2022 01:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSWl/IdeBjalShp/k7O4K9i4aFpme9ARCm4osm7hX2EifpK6owbeUtv7Nf9MMUd0R2II36pw==
X-Received: by 2002:ac8:5d8e:0:b0:2f1:fbc6:ae89 with SMTP id d14-20020ac85d8e000000b002f1fbc6ae89mr13320674qtx.647.1650528591406;
        Thu, 21 Apr 2022 01:09:51 -0700 (PDT)
Received: from gerbillo.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id c131-20020a379a89000000b0069c903625absm2686220qke.102.2022.04.21.01.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:09:50 -0700 (PDT)
Message-ID: <a3596a37f72d6df35a6de4e0cf912d2f6d434bbc.camel@redhat.com>
Subject: Re: [PATCH] net/smc: sync err info when TCP connection is refused
From:   Paolo Abeni <pabeni@redhat.com>
To:     yacanliu@163.com, kgraul@linux.ibm.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyacan <liuyacan@corp.netease.com>
Date:   Thu, 21 Apr 2022 10:09:48 +0200
In-Reply-To: <20220417123307.1094747-1-yacanliu@163.com>
References: <20220417123307.1094747-1-yacanliu@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, 2022-04-17 at 20:33 +0800, yacanliu@163.com wrote:
> From: liuyacan <liuyacan@corp.netease.com>
> 
> In the current implementation, when TCP initiates a connection
> to an unavailable [ip,port], ECONNREFUSED will be stored in the
> TCP socket, but SMC will not. However, some apps (like curl) use
> getsockopt(,,SO_ERROR,,) to get the error information, which makes
> them miss the error message and behave strangely.
> 
> Signed-off-by: liuyacan <liuyacan@corp.netease.com>

Could you please formally re-submit for -net (inclusing NET into the
patch subj) with a suitable 'fixes' tag? You can retain the already
collected reviewed/ack-by tags.

Thanks!

Paolo

