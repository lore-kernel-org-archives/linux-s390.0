Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214AEE7544A
	for <linux-s390@archiver.kernel.org>; Tue,  3 Oct 2023 10:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjJCKmP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Oct 2023 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjJCKmO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Oct 2023 06:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93935B4
        for <linux-s390@vger.kernel.org>; Tue,  3 Oct 2023 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696329690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEM5s9LjMr/YRPee+FNwgiSqc+ylSynZdt7LNsU3DA8=;
        b=DSLIzrKjcWZypmbh1z5xtD0OfVGSU0vrcSXfbrfUQ94MJnRfDv3lkeDdAgfFAbP7/ZN049
        2PQ4uEyQnJJwK8JvkW7HZui81i+ZlSGuGs/pxSkMsNwCvf6zsuuneXmC6WNtS21gDHDpb2
        lhoV/P2CoXwD5t/aXijmM2LBIJrpevA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-vrhKY99bPaeD0MVTBqnQ5A-1; Tue, 03 Oct 2023 06:41:29 -0400
X-MC-Unique: vrhKY99bPaeD0MVTBqnQ5A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae6afce33fso17928466b.0
        for <linux-s390@vger.kernel.org>; Tue, 03 Oct 2023 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696329688; x=1696934488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEM5s9LjMr/YRPee+FNwgiSqc+ylSynZdt7LNsU3DA8=;
        b=ayxVYt81GmVBjWgJR49qZ84UXmHOo8FGzAdALUoL+0+f7ha48fp1l3usGCmUxGI/t/
         XEeSDsFd1arqC9TfLxw1hOBTyAQC092w2T7pxlr092p13IVEkOxkzSgpdl6pwzFmRerQ
         diFwNBccMpYxAXQANu436NbtFcDMQRMRDu1kcrVXg2Ta3rcQ0WNOJ1GSIGvR6uwwMtk9
         ZKUXQTpuK3GIj+TBKIJVeoKbwE1T9MXd56b7Xtrybh0Vvh4ihhGiqE+J0zMQGLo/xZRu
         bT4a/WX+4iRk/gd/3hVZ/AXpubYUptEsUl2dc7My0OKCuO5DUuUVbPnWTdWneBD1jx6b
         X81A==
X-Gm-Message-State: AOJu0YwBldBPsDFjYmDrZCTUSNHJTIUFeWxtA1KAITJBNsdpJHnh2FIQ
        aBl1asjhVHJOheqeyp88DJcLbGrneeT19wtTt7d0PPuuXOalEzK4qBdc6+kL2ivlmU5DqPpeurL
        96Vu18699eHpOP17PE7EoAw==
X-Received: by 2002:a17:906:25d:b0:9b2:bf2d:6b65 with SMTP id 29-20020a170906025d00b009b2bf2d6b65mr13123545ejl.4.1696329688204;
        Tue, 03 Oct 2023 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTp4Yzu/cOAedVnFfUtha2zEKWPPeZzfa3qsmsNMKsBJ+r6YYEbp9xiJ3pmDMPdNIMRLIP9g==
X-Received: by 2002:a17:906:25d:b0:9b2:bf2d:6b65 with SMTP id 29-20020a170906025d00b009b2bf2d6b65mr13123529ejl.4.1696329687871;
        Tue, 03 Oct 2023 03:41:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906118a00b009a19701e7b5sm832863eja.96.2023.10.03.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:41:27 -0700 (PDT)
Message-ID: <6e5fb3e148ae1fb4a29561fe9d04235d8be6ab1f.camel@redhat.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
From:   Paolo Abeni <pabeni@redhat.com>
To:     dust.li@linux.alibaba.com,
        Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Oct 2023 12:41:25 +0200
In-Reply-To: <20230927034209.GE92403@linux.alibaba.com>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
         <20230927034209.GE92403@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2023-09-27 at 11:42 +0800, Dust Li wrote:
> On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> > If the netdevice is within a container and communicates externally
> > through network technologies like VXLAN, we won't be able to find
> > routing information in the init_net namespace. To address this issue,
>=20
> Thanks for your founding !
>=20
> I think this is a more generic problem, but not just related to VXLAN ?
> If we use SMC-R v2 and the netdevice is in a net namespace which is not
> init_net, we should always fail, right ? If so, I'd prefer this to be a b=
ugfix.

Re-stating the above to be on the same page: the patch should be re-
posted targeting the net tree, and including a suitable fixes tag.

@Dust Li: please correct me if I misread you.

Thanks,

Paolo

