Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29138C61DA3
	for <linux-s390@archiver.kernel.org>; Tue, 21 Feb 2023 23:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBUXPr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Feb 2023 18:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBUXPq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Feb 2023 18:15:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4EE32509
        for <linux-s390@vger.kernel.org>; Tue, 21 Feb 2023 15:15:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x10so22697766edd.13
        for <linux-s390@vger.kernel.org>; Tue, 21 Feb 2023 15:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwmMRkor2ICDU/OK7QN1tiyRmzvZfLkymfVZOFR0Txw=;
        b=On8KMYCHBj7beUSOs4dQTtqFd/Fca9WgkVURKorBOGYVnhfD6hPKLkY6qp5oH7/qQN
         aB5hboA7zlLK6rE0UKyZEj/fEZX6e/WjRpkK5TJwK8OckIXjDcI4qk47gXQADMcTYBqz
         I+M7RQJ8AwVKOxx/Gb5cEZrJluRPBAlUhZXhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwmMRkor2ICDU/OK7QN1tiyRmzvZfLkymfVZOFR0Txw=;
        b=I+cwV0qAidduILyLkCWlWbOq5pppXk2Q3O9DrGXjaHprEk6jEI4rdxRhzeOwEcDHSz
         BnAl0bjb+ajaL6LScL/Mwb1uORYjxGGwhNsnwe4GXfx099bco1rlXeAQP1ajnV6yn7Ed
         /y2TmwSyjLEdlgKRLJkzoW9uCaiaLZIhCyFsal35dhsZtk6XunEFmMgmH5tvrGB7oV4i
         mY0e4uM7KsgLpqWa1FzilW8O8C3XPLvEqrsAhFTHQZ73M+gGfT3acnm5R/p2/JmlmnBU
         HbpZYm9RP7faUJNypKf13lc5kZjJho45WDw/gvihe6w54dJi5qQQpqDkj6lDbYUIdjHS
         cGkg==
X-Gm-Message-State: AO0yUKULVCpnwcV8ZfjU5nq/08mhDlhFP77PXHMxIx/PLdA4O5yBbx66
        QhWuV6BUEtqC+GHol2nf6GHL/xf7HKzbNl4EOvo=
X-Google-Smtp-Source: AK7set/spTZy3kRpKhcHn/ftgbt4CgDfp8qXISCWG9oCALY0Som1ORolqiJxqkDFRrr+N5kzsnP63A==
X-Received: by 2002:a17:906:468b:b0:8dd:76d5:a82 with SMTP id a11-20020a170906468b00b008dd76d50a82mr4291408ejr.47.1677021327112;
        Tue, 21 Feb 2023 15:15:27 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id bk7-20020a170906b0c700b008cd37aff603sm3748903ejb.164.2023.02.21.15.15.26
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 15:15:26 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id eg37so19697825edb.12
        for <linux-s390@vger.kernel.org>; Tue, 21 Feb 2023 15:15:26 -0800 (PST)
X-Received: by 2002:a50:f694:0:b0:4ad:6d57:4e16 with SMTP id
 d20-20020a50f694000000b004ad6d574e16mr2955162edn.5.1677021326111; Tue, 21 Feb
 2023 15:15:26 -0800 (PST)
MIME-Version: 1.0
References: <Y/NhOcWmhpYRPnK0@osiris>
In-Reply-To: <Y/NhOcWmhpYRPnK0@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2023 15:15:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimQi=gL-Pd7kMd-ruwjLUCK82e3wJ7sisvT3cfHrx-JQ@mail.gmail.com>
Message-ID: <CAHk-=wimQi=gL-Pd7kMd-ruwjLUCK82e3wJ7sisvT3cfHrx-JQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 6.3 merge window
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 20, 2023 at 4:02 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Also the shortstat when merging will look slightly different to the one
> generated with 'git request-pull' below, since I merged our fixes branch
> twice to avoid merge conflicts.

Please don't do that unless the merge conflicts are really nasty - and
when you do, please *explain* it.

Looking at those two merges, I

 (a) see no sign of complex conflicts (the conflict diff is completely
empty for both of them)

 (b) see zero explanation for why the merge exists at all

Please consider merges to be real commits (they are!) and needing all
the same commit messages explaining them that normal commits have
(they do!).

In fact, exactly because merges don't have any obvious code in them,
they probably need *more* of an explanation than a commit where the
diff might be in itself somewhat self-documenting.

               Linus
