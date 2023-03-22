Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CAC6FD1C
	for <linux-s390@archiver.kernel.org>; Wed, 22 Mar 2023 13:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCVNJW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCVNJV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Mar 2023 09:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08335370B
        for <linux-s390@vger.kernel.org>; Wed, 22 Mar 2023 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679490520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/qTj/CR/P8toNku1F2rSJCL567n91Rdrj6XCHder5E=;
        b=PDa+qHk4SB6nYvFxLgdU/okJbJtmelwhmf7f0MwafGt/8/qAZFoQr/zFJOX6cuyu2VQfqT
        fEmPofe7wz9lc9Unf5GCT0GMNee67ZDRBnHPofUPpXR711H1z1fuzvbe6X7dTopbStvb38
        FGF+0tCn0uc1m/EW/2aPggB9o4A41mc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-Z7xXSgRCMtSb20AOC-YEIA-1; Wed, 22 Mar 2023 09:08:39 -0400
X-MC-Unique: Z7xXSgRCMtSb20AOC-YEIA-1
Received: by mail-qv1-f71.google.com with SMTP id f3-20020a0cc303000000b005c9966620daso4661438qvi.4
        for <linux-s390@vger.kernel.org>; Wed, 22 Mar 2023 06:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490519; x=1682082519;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/qTj/CR/P8toNku1F2rSJCL567n91Rdrj6XCHder5E=;
        b=c0yVIKH2twtaN5z4XdkXR123g8k/bOesNshRJ5tLlfRgWsPkTBdY06CbL8DBHTfzX6
         r11O05IYGu+UKsgRsSvSBfFE6z0wzgFsQncH4FW2R4PjJMgnX2brvp/VfDMKDXbGroD/
         tsmOxtpWO/lu1bGlHJGQ4xmp+GHoZRhuaO5U53oprt5EcmdnZyo3o+t/873fRX/TZk1p
         /fIx2/cVh0b3AxLlpVMnh+/tZZViYSMT5WGu3qSQI2T/d/gFPgSXAe3hQ3c3IBshJAvy
         qHeX+HfsymVK0uvamUHQ6Dz2dgXvumyWJEQysHTZx/EknkUey6c6O5Z4RTPnmd2cNy04
         E/9Q==
X-Gm-Message-State: AO0yUKXJb5PT76GROkhCnjz6TpNuiXtYIVuFob7TAK2MBcgODfjiw070
        d6ZuM9z6c8VgD45/1iOC58WRv9u2k64dTzePxyN6g7dLiCMKfa1DVhdeh5zzwGwPSCqfy12u9sl
        8j5sSE9v+noIpNVfCtSh1Uw==
X-Received: by 2002:a05:622a:1ba6:b0:3bf:a3d0:9023 with SMTP id bp38-20020a05622a1ba600b003bfa3d09023mr9839487qtb.5.1679490518810;
        Wed, 22 Mar 2023 06:08:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set8BplPahQbCnWKiKMft+baibysjjTwWtI3aCzJY2m/60IP8OZzIl2kBLJuT+hOG6SbaWsA/rg==
X-Received: by 2002:a05:622a:1ba6:b0:3bf:a3d0:9023 with SMTP id bp38-20020a05622a1ba600b003bfa3d09023mr9839444qtb.5.1679490518441;
        Wed, 22 Mar 2023 06:08:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-168.dyn.eolo.it. [146.241.244.168])
        by smtp.gmail.com with ESMTPSA id f25-20020ac84659000000b003e37db253c6sm3765802qto.57.2023.03.22.06.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:08:38 -0700 (PDT)
Message-ID: <8f4bd9333117eda4c5ff324f92b969d9a6b57b65.camel@redhat.com>
Subject: Re: [PATCH net-next] net/smc: introduce shadow sockets for fallback
 connections
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kai Shen <KaiShen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, dsahern@kernel.org
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org
Date:   Wed, 22 Mar 2023 14:08:34 +0100
In-Reply-To: <20230321071959.87786-1-KaiShen@linux.alibaba.com>
References: <20230321071959.87786-1-KaiShen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2023-03-21 at 07:19 +0000, Kai Shen wrote:
> SMC-R performs not so well on fallback situations right now,
> especially on short link server fallback occasions. We are planning
> to make SMC-R widely used and handling this fallback performance
> issue is really crucial to us. Here we introduce a shadow socket
> method to try to relief this problem.
>=20
> Basicly, we use two more accept queues to hold incoming connections,
> one for fallback connections and the other for smc-r connections.
> We implement this method by using two more 'shadow' sockets and
> make the connection path of fallback connections almost the same as
> normal tcp connections.
>=20
> Now the SMC-R accept path is like:
>   1. incoming connection
>   2. schedule work to smc sock alloc, tcp accept and push to smc
>      acceptq
>   3. wake up user to accept
>=20
> When fallback happens on servers, the accepting path is the same
> which costs more than normal tcp accept path. In fallback
> situations, the step 2 above is not necessary and the smc sock is
> also not needed. So we use two more shadow sockets when one smc
> socket start listening. When new connection comes, we pop the req
> to the fallback socket acceptq or the non-fallback socket acceptq
> according to its syn_smc flag. As a result, when fallback happen we
> can graft the user socket with a normal tcp sock instead of a smc
> sock and get rid of the cost generated by step 2 and smc sock
> releasing.
>=20
>                +-----> non-fallback socket acceptq
>                |
> incoming req --+
>                |
>                +-----> fallback socket acceptq
>=20
> With the help of shadow socket, we gain similar performance as tcp
> connections on short link nginx server fallback occasions as what
> is illustrated below.

It looks like only the shadow sockets' receive queue is needed/used.

Have you considered instead adding 2 receive queues to smc_sock, and
implement a custom accept() variant fetching the accepted sockets from
there?

That will allow better encapsulating the changes into the smc code and
will avoid creating that 2 non-listening but almost listening sockets
which look quite strange.

Cheers,

Paolo

