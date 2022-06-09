Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E36C43334
	for <linux-s390@archiver.kernel.org>; Thu,  9 Jun 2022 11:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbiFILuL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbiFILuH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jun 2022 07:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 724CE20EEA5
        for <linux-s390@vger.kernel.org>; Thu,  9 Jun 2022 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654775404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuwhD3TtwqmPc3FtJmMtruEqS+FysyJ1M2ttopTd4UE=;
        b=ieQXaU+yNSYRRJ4d/O9w1oroTIbSrZjCYx3EYfDFflwmyJPDbnh27T6eEz+U2mBOIwz1gc
        igM8SduL/pUBD+LQOfyJIaBRKOJRhes4VOBTyKB6+FtUKbjO7EPHGFW/vQU1ueHN3vZtJ2
        CLPJORk9yHSj8XwW6eVoyHtkc/NxCSU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-njpUDfwVP3-wtPgfgFJwCw-1; Thu, 09 Jun 2022 07:49:55 -0400
X-MC-Unique: njpUDfwVP3-wtPgfgFJwCw-1
Received: by mail-qk1-f200.google.com with SMTP id bs17-20020a05620a471100b006a734d3910dso616728qkb.22
        for <linux-s390@vger.kernel.org>; Thu, 09 Jun 2022 04:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DuwhD3TtwqmPc3FtJmMtruEqS+FysyJ1M2ttopTd4UE=;
        b=L027W1WhADYivoC1CCAYdH1W2BtbLpXKAmnbs19nKldmSRAfpmaRj0sscYxyEm1vHs
         g65rHKNDLq34h92z7GMACSFKu/x762knQ+ceMR/58Tl3X/zjoG7l6EkCJOU7NnJ2PHWu
         SOwJ+DnXZLtdxygk0UBVvU+1ck+u5smCHrMvSz0FfYpSD0kl5+z/TYBueoDj/oTKiCMV
         JcImQh8oFarxV2Ew4WfZ5DO94zBSqyngTeb1pnPj2uwx71QfrUmBHp+7OKrr4V2owcwy
         jQ2xclo4GhUPCTPO3RKl2oOYWowkj3vF3/bw2OgnKL7FqVqMN2BaOgEseKnEjYxder8S
         gdrQ==
X-Gm-Message-State: AOAM533JzjGOxmkS0YOaSBQqAvoyDh9F2rft8rNMArvubdgUWbCwHJJs
        l8ecU5OIvaphLEBDd8uhz4/LyDH0gn9jFngP0y0UxaDE91xJeNkyzzYwp7iMywleRBbUO7U5P0V
        H8sCvfu7abVX/lCp1vS180Q==
X-Received: by 2002:a05:6214:761:b0:441:196:795e with SMTP id f1-20020a056214076100b004410196795emr83996403qvz.67.1654775395351;
        Thu, 09 Jun 2022 04:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiM6WZ7qFmx0s6PGdh/jWpyxlZoyVwejHGOyF0aVfaLqcBlYDNDG9DqxVM31JDDGzdiHNvxg==
X-Received: by 2002:a05:6214:761:b0:441:196:795e with SMTP id f1-20020a056214076100b004410196795emr83996374qvz.67.1654775395085;
        Thu, 09 Jun 2022 04:49:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b006a6ac4e7ab4sm12759648qko.112.2022.06.09.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:49:54 -0700 (PDT)
Message-ID: <b00ab3c4a12fb11ed95b2a4634e50e3cba10ec28.camel@redhat.com>
Subject: Re: [PATCH net-next] net: rename reference+tracking helpers
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        jreuter@yaina.de, razor@blackwall.org,
        Karsten Graul <kgraul@linux.ibm.com>, ivecera@redhat.com,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Xin Long <lucien.xin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Yajun Deng <yajun.deng@linux.dev>,
        Antoine Tenart <atenart@kernel.org>, richardsonnick@google.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-hams@vger.kernel.org, dev@openvswitch.org,
        linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Date:   Thu, 09 Jun 2022 13:49:48 +0200
In-Reply-To: <CANn89i+RCCXQDVVTB+hHasGmjdXwdm8CvkPQv3nYSLgr=MYmpA@mail.gmail.com>
References: <20220608043955.919359-1-kuba@kernel.org>
         <YqBdY0NzK9XJG7HC@nanopsycho> <20220608075827.2af7a35f@kernel.org>
         <f263209c-509c-5f6b-865c-cd5d38d29549@kernel.org>
         <CANn89i+RCCXQDVVTB+hHasGmjdXwdm8CvkPQv3nYSLgr=MYmpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2022-06-08 at 16:00 -0700, Eric Dumazet wrote:
> On Wed, Jun 8, 2022 at 3:58 PM David Ahern <dsahern@kernel.org> wrote:
> > 
> > On 6/8/22 8:58 AM, Jakub Kicinski wrote:
> > > IMO to encourage use of the track-capable API we could keep their names
> > > short and call the legacy functions __netdev_hold() as I mentioned or
> > > maybe netdev_hold_notrack().
> > 
> > I like that option. Similar to the old nla_parse functions that were
> > renamed with _deprecated - makes it easier to catch new uses.
> 
> I think we need to clearly document the needed conversions for future
> bugfix backports.
> 

To be on the same page: do you think we need something under
Documentation with this patch? or with the later dev_hold rename? or
did I misunderstood completely?

Thanks!

Paolo

