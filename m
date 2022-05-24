Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6BCC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 24 May 2022 08:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiEXIuN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 May 2022 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiEXIuM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 May 2022 04:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52E073546
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653382209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdVfgoy4DMKIRrDCFm+NlF67nCZ7pRbEEsQazS020wI=;
        b=iJGpYN/hHHkyGZRbGjHCB5V2rwQvsk59YYlcAYPZTzhA7s4zel80Qw2Sc5/gEUOM1NCtFw
        s/2P6qqMVCeB51zU/erPylspVkd97kN0gQaoaYhtf93BOl24R1Q54MR7ZIh+33Qy/wngHf
        DfkmE3T+VdKkdW9uISI4sVNcd1f00cY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-O8Vwn51iO4WPIYnJ7ZMMUA-1; Tue, 24 May 2022 04:50:08 -0400
X-MC-Unique: O8Vwn51iO4WPIYnJ7ZMMUA-1
Received: by mail-wm1-f71.google.com with SMTP id o23-20020a05600c511700b0039747b0216fso1007117wms.0
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 01:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gdVfgoy4DMKIRrDCFm+NlF67nCZ7pRbEEsQazS020wI=;
        b=3oSCNuK7tI334Z66JB51Xd5F3YqXb4Y8QckVy5M6GQHTEyetJBS/XHWFINlo76kUFn
         Hem2l4u2+UPA5uKoaKHeSCwR4MrXtasMlyaKA/JzvXMPYxwdKFt5xupha/9ermDJZzed
         tNtfZ5WKGMlDA+omzse+sRLgCchc8szxAcmSxpdCIF5HEcceg2JhflCUCs3StH+Bg2+G
         kdXYlvGXXTDXiOEhXMvtdZdjVWtjGR7M4HjeP+2lr/6q+pQezqTUMk0LgJGftj2iCp1o
         AUpj40EcraMxIEWXj/r8HyWvYCvvhWmG8yaeoRet2fUg7OI0YXR97Nt9Nhxw3dN3HSxb
         O1xg==
X-Gm-Message-State: AOAM533QNWWh7jo9S5EpHOJ7rAeTc3FsVq977nvUXdU6EJF3BtOr9Adf
        qu7lcBNpMjwoZ5yNcSkOJqeE8SP99GHEHuIDYAghBZak80MT62unyRmic7IWKdOdMN3UNjwIquw
        Gl7SvEChxcMwUGq6FCW96nw==
X-Received: by 2002:a05:600c:4313:b0:397:26c9:dda1 with SMTP id p19-20020a05600c431300b0039726c9dda1mr2713408wme.184.1653382206479;
        Tue, 24 May 2022 01:50:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnlvbuROa+P4IBGkdAWKlHrWe7jd9IcsCGsLZeLRwKLCHZzMgVtKGw3WEXv9+5c7I00mtdCg==
X-Received: by 2002:a05:600c:4313:b0:397:26c9:dda1 with SMTP id p19-20020a05600c431300b0039726c9dda1mr2713392wme.184.1653382206260;
        Tue, 24 May 2022 01:50:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id u25-20020adfae59000000b0020d106c0386sm12277805wrd.89.2022.05.24.01.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:50:05 -0700 (PDT)
Message-ID: <3090d3059e3493af2b0d69961eaa8584834f7a1a.camel@redhat.com>
Subject: Re: [PATCH v2 net] Revert "net/smc: fix listen processing for
 SMC-Rv2"
From:   Paolo Abeni <pabeni@redhat.com>
To:     liuyacan@corp.netease.com
Cc:     davem@davemloft.net, edumazet@google.com, kgraul@linux.ibm.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        ubraun@linux.ibm.com
Date:   Tue, 24 May 2022 10:50:04 +0200
In-Reply-To: <20220523153110.474996-1-liuyacan@corp.netease.com>
References: <20220523150709.306731-1-liuyacan@corp.netease.com>
         <20220523153110.474996-1-liuyacan@corp.netease.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 2022-05-23 at 23:31 +0800, liuyacan@corp.netease.com wrote:
> From: liuyacan <liuyacan@corp.netease.com>
> 
> This reverts commit 5ec8b414b4381e8714731415fc221ef50a4e7b14.

It looks like the correct hash is
8c3b8dc5cc9bf6d273ebe18b16e2d6882bcfb36d

> 
> Some rollback issue will be fixed in other patches in the future.


Additionally please add an explicit Fixes tag, it will make stable team
life easier, thanks!

Paolo

