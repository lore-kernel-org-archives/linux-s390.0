Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52AFC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 10 Mar 2022 20:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiCJUYd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiCJUYc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 15:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A390AECB34
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 12:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646943809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bH4/6OdCxrtunb44tPOYHwdgjcfhX0Qz09OdOxJro7A=;
        b=ZQvbwiz7SvhOr6l1qQUOy+XpVWV7lwS2CjhhfmLNj/riHgVEfFVmGPzy1WlF9HTR/Wgxkh
        BV7IgCXbWtDZOZ9PpJgLjjmUwJnc3V8kIBOcKVl7m48f9GDlyVisjsm7aLNjLpctjzkOjO
        DUDZlzUhkN4kBba99xbyG3vOSd8l6kc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-FZA8n2X3PmC3IArPDR3B5g-1; Thu, 10 Mar 2022 15:23:28 -0500
X-MC-Unique: FZA8n2X3PmC3IArPDR3B5g-1
Received: by mail-wr1-f72.google.com with SMTP id q14-20020adfea0e000000b002036c16c6daso2077615wrm.8
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 12:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bH4/6OdCxrtunb44tPOYHwdgjcfhX0Qz09OdOxJro7A=;
        b=pIWrfNGaIg2uuQxQ6JdXd+SROe9i6BIJiFaBe4hU2JHgAGRXE45zPBeqf+xGgbNT1v
         zAEpE5SU/FNiaiGm/WxZsXtsR0Bdq3gDzFNHru+gWSl25yOrbS2InTN160Q6F7Tp5j84
         ItICIw1BpOXeNGEi8C36ciA5gcJ1HPCcuwLRHfxkyvJzt3x1WCMWx7YsnhnyW4BmPDZn
         zOet1XrolUSlsPDmd5lLHq9/ZZJOxRjLzlksF4q+nyjyEKTIMGX14nR5+Asg3/JMM9XR
         cpZHKqwKBmFv4+JbzRSAs6c/Y/mAJW7Ghx2YXGn97Fppe4XWZIhMbsZhO7QuxxKBfTgZ
         e9xQ==
X-Gm-Message-State: AOAM532pToi71NeCNq3VMLLsJo9Xzqbnf//Te2q5NvReivcKudJ1zpK4
        xafWZVKXYG/pFg7bmS/QwLTpXZJCZaSms51IJkiiL46Ok5jx58Em4TKovuqpO8B1qKa1sZGINmZ
        l/nb7loew4Dq7vZxyuoZDRuiXM7VTFeuHGnAfpQ==
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id q10-20020a1ce90a000000b00381504eb57dmr13019515wmc.177.1646943806970;
        Thu, 10 Mar 2022 12:23:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw16FQLbDeS9B5CsJlBEVWqDdzz2Nkgq70FzZQX/iF5ZEZCXMvb6pDLIp/taw7qbW1c3cqimkE7lh0EQM6JeRk=
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id
 q10-20020a1ce90a000000b00381504eb57dmr13019507wmc.177.1646943806851; Thu, 10
 Mar 2022 12:23:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
 <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
 <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com> <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
In-Reply-To: <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 10 Mar 2022 21:23:15 +0100
Message-ID: <CAHc6FU4pH_OKppo0n772JoDtXy=pmhApSSjN7emv4D=sdCSzWQ@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Mar 10, 2022 at 8:56 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> It's out as commit fe673d3f5bf1 ("mm: gup: make
> fault_in_safe_writeable() use fixup_user_fault()") now.

Thanks!

Andreas

