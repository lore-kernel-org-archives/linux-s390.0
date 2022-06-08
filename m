Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56502C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  8 Jun 2022 23:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiFHXBM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiFHXBL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jun 2022 19:01:11 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F249CAC
        for <linux-s390@vger.kernel.org>; Wed,  8 Jun 2022 16:01:07 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-30c2f288f13so224405887b3.7
        for <linux-s390@vger.kernel.org>; Wed, 08 Jun 2022 16:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDmHaHfbP+V5NY5ockejgPMau+3mt71MxfGCliwuimo=;
        b=U5ZIepD986IE19Jdtz/JfQMpmGlOdj0Ma4qhBU6FvPG2yVumX/iIIxTkGWJvdARXmm
         crsUsGKAq+kZMs6Hsp0nX0/r6mck2nTRwjJ7WYltXAly8x2IeLGDEZSyxkyQ+CouzR+b
         GItTca7O9lML9JZiCZp9jl/ZrV9mXpgSAtsak14LlmxBcGt3919lfyPt1EtJt9+JsFq6
         6YCWY8yLavOYfz/nthcyHUBmrA4V3xKtIYPD7qH6NsA7jUdazC0A7h7D+2MgMR0wM2st
         fP/2jPgNzHEg2YS3QcplziHBkH2gfNGSQnrGm26XbAAvxK6HwQT9ZDG/CPFb8tzYzNSq
         zJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDmHaHfbP+V5NY5ockejgPMau+3mt71MxfGCliwuimo=;
        b=O0TMf3b01HderPRSHCoCDDEBivnzsdxzd5TFXj7jLSgfPa+ZUIEy3LN92BiSefsS7G
         Awfpq8pnel7gISbuv7iij3T6vmJ+coXljo3fWEyjeUy0ZZhVt3yWSeoaH/r5+kOirBJP
         L+qzujU9P112APPlNypUNF/9KajBun8sN2isQhKX/y704eRQG2+Vr1yfSoNvAQ9t3Jc5
         gr9VntY+K7R6i30RQpsGJU0x6BNXtFAxvvJn1g+QEgf6mnqKQoGMd4RLS1ebaJfwfZyj
         Isb7734v02l3oV+ZoUbAwuG94j5zQQulDuZZBGU8nxJwo3YP7hYq1v28F2EIiIla92Ga
         JwGA==
X-Gm-Message-State: AOAM530CzYk8hqG6rTM2SgBzRjP34ipKs2mAz/dGSW3OAgfhEyS5DLht
        CD/mRFkZG9ZBt3O7zElc789+E7ZZz9b2bj7K2OQepQ==
X-Google-Smtp-Source: ABdhPJwXPAtFJ3hcM0FYypq2XpNnECxN58WQ6asEspJUeRhsllm3ijXI6/gj4cz2GW5rMuEbXfKHAfOJyU3ee4JxYGY=
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr40028374ywa.47.1654729266114; Wed, 08
 Jun 2022 16:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220608043955.919359-1-kuba@kernel.org> <YqBdY0NzK9XJG7HC@nanopsycho>
 <20220608075827.2af7a35f@kernel.org> <f263209c-509c-5f6b-865c-cd5d38d29549@kernel.org>
In-Reply-To: <f263209c-509c-5f6b-865c-cd5d38d29549@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 8 Jun 2022 16:00:54 -0700
Message-ID: <CANn89i+RCCXQDVVTB+hHasGmjdXwdm8CvkPQv3nYSLgr=MYmpA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: rename reference+tracking helpers
To:     David Ahern <dsahern@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 8, 2022 at 3:58 PM David Ahern <dsahern@kernel.org> wrote:
>
> On 6/8/22 8:58 AM, Jakub Kicinski wrote:
> > IMO to encourage use of the track-capable API we could keep their names
> > short and call the legacy functions __netdev_hold() as I mentioned or
> > maybe netdev_hold_notrack().
>
> I like that option. Similar to the old nla_parse functions that were
> renamed with _deprecated - makes it easier to catch new uses.

I think we need to clearly document the needed conversions for future
bugfix backports.

Alternative would be to _backport_ the renaming for all stable versions ;)
