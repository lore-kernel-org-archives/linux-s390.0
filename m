Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1799C636D4
	for <linux-s390@archiver.kernel.org>; Wed, 15 Feb 2023 08:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjBOIeb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Feb 2023 03:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBOIea (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Feb 2023 03:34:30 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A72D15A
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 00:34:28 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4a263c4ddbaso251344767b3.0
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ0Tbl1JRT8TpgT4ciKif/L2O/2dnKFAn9OEhwx1LKY=;
        b=dnoSQwsXcuOdAmTUN4n1Z54s5MXVwmWD46iY4LYXeF8GleCpym/rek4aZ46EJGOCC2
         tpJxYjOaaZo3I3Yg0xJXhInDJvR3VZjVDroIeQkfef44/m6IcE4SQj6pbzu9T7hZLJCl
         ctkZXBBVNfcSoaL0yIEc/LtxOg4wLolJ5BdMo63+PjZvA523LQEYrWJNEXij7EkoyZPX
         PdNVwOi4S2Lc3ftHXMg/DA5Cq6CQ25vtps2uDSvPMnUTLQ20DMT+osd0CRtv3JYBd2nw
         rNjNv44Kdjf0F5BzTp3GnjT003QXTijAcb4Ecw8D/Otv0QXnzBtX3UB9pj/T8HXGonvO
         SruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZ0Tbl1JRT8TpgT4ciKif/L2O/2dnKFAn9OEhwx1LKY=;
        b=6ZW680/6ovD8a08oCW1p+7bt/LkGS8colvVNIXsSBtzuJhKxMcSrgRQtcXm+zR8m6M
         tGjhsFYoBnVp0QKghsAPS8tDQ0NOdkm1Nxag6h70A6qjUue0FiXeb9eWfrR0Bf0O/Mi2
         ByaIsrZ8deTL688iz8l9xStJLEYDW2A+7jd3p8NjC5z+A1BVzU8LjtZO+5k1k0VSJn8Z
         6YSt6gCzAtatW89nl8dVFbzcsie46w9D6yo4Ba5gZ0YEV700VbFacREJndkdhhVBbZ93
         4wk/ZxbprQEbmh+wn4gyQXcfyUeUQ6LMohKMUS/52tGr0Y4/afF/MVXesK2YQKlawGXc
         XXFg==
X-Gm-Message-State: AO0yUKWxRaDhQ/RWgkR4LBdyNZRiDyFRKP8686Qii8g5iFXnxKoR/RFR
        kjm1iwtD7HtdEZGL31Z9XLFCUvFypZcb2flEjoTjCw==
X-Google-Smtp-Source: AK7set8ljnu+GwuUQ4bAj4hFoVW4I2+uuhh7kwq1uoEl9VQWYBAHdwy47c4ncQV8gkQG7WYcehVwSf5DBTwi77UFuEo=
X-Received: by 2002:a25:ad93:0:b0:8bd:d8e7:aace with SMTP id
 z19-20020a25ad93000000b008bdd8e7aacemr173772ybi.549.1676450067211; Wed, 15
 Feb 2023 00:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20230214041410.6295-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230214041410.6295-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Feb 2023 09:34:16 +0100
Message-ID: <CANn89iLq+_0ooWU52Y8cqk=JyrYo89_4TKW4BQ3P0+naYr+z_w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: no longer support SOCK_REFCNT_DEBUG feature
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     kuniyu@amazon.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org,
        matthieu.baerts@tessares.net, willemdebruijn.kernel@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sctp@vger.kernel.org, mptcp@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Feb 14, 2023 at 5:15 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Commit e48c414ee61f ("[INET]: Generalise the TCP sock ID lookup routines")
> commented out the definition of SOCK_REFCNT_DEBUG in 2005 and later another
> commit 463c84b97f24 ("[NET]: Introduce inet_connection_sock") removed it.
> Since we could track all of them through bpf and kprobe related tools
> and the feature could print loads of information which might not be
> that helpful even under a little bit pressure, the whole feature which
> has been inactive for many years is no longer supported.
>
> Link: https://lore.kernel.org/lkml/20230211065153.54116-1-kerneljasonxing@gmail.com/
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
