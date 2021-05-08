Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF73C433B4
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188E8613EA
	for <linux-s390@archiver.kernel.org>; Sat,  8 May 2021 22:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhEHWtt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 8 May 2021 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhEHWtt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 May 2021 18:49:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F17C061574
        for <linux-s390@vger.kernel.org>; Sat,  8 May 2021 15:48:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x19so17952128lfa.2
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kA/KDUDO096vq2rEKxFXAZivI52axFruzSdRkQyvoI=;
        b=PWRMIeUKO0nmSZhexye/3YzAUVpInwAh7XXlaTHnWhlKIAuWvggExHJgbfmaYh9nR0
         DRNpc5CAKtPEke/TFa5iaD4eYxQPerPxY17lVXLaNXY4SEls6TLdUjya9c5Rt62dxKkG
         IgPGuzEDzfaGsPkyXdCfqJY1xki5yy39Ae+Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kA/KDUDO096vq2rEKxFXAZivI52axFruzSdRkQyvoI=;
        b=hmWymLKayZW61Q7LenAIBLqesOL7xBXQviCXQ+Ab8VoLaOLrt5/kbNHQud2m/So3y5
         WokGCVRYbgrNLnXMwtEOac5g9sPtD57kvcGGOhG4PNuOIxPg9OfeURjHFDftZTAoCmWG
         STNgELX0E6GGUVwqNO22uCVjWg5g7mXf5OfdjD36phlzYp4l+TE1QDc1OK/oGrASl3QP
         b//GQsmuSZJa3XrEhRCEc+/NCV1KvUGEP+llFqZi3z71uoAKHXbsW3JLIZ0/hIdAeIQR
         PjLX3HpygSB/rqlI0Tks2/RpHd3H6Oid7VkDiceqXRqzZTWpq6KrHvBIcsRTg+oS9YvU
         znUQ==
X-Gm-Message-State: AOAM530cwgcz7OIL84cugb73+o+y0uEG6Pz8/hlPtPt0qvwvDt0/Vji0
        9Y2ajbAlXSV97A1bUFUjn4UTqrMV6Ls/DqjGY9Y=
X-Google-Smtp-Source: ABdhPJzSKsjFMIlBceESxa6Ymcvg1gjOE8mJoZXUKwN279l88UzfXPBbFQAW1mQpc46d29cVAL+hXQ==
X-Received: by 2002:a05:6512:12d0:: with SMTP id p16mr11409812lfg.232.1620514125268;
        Sat, 08 May 2021 15:48:45 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a26sm1729857lfl.127.2021.05.08.15.48.45
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:48:45 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x2so17900360lff.10
        for <linux-s390@vger.kernel.org>; Sat, 08 May 2021 15:48:45 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr10896192lfr.201.1620514114222;
 Sat, 08 May 2021 15:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
 <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
In-Reply-To: <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:48:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbaLFNU3448HhUX7AZB1xxqTg=A8PLbzazQxR_ukyJsw@mail.gmail.com>
Message-ID: <CAHk-=wgbaLFNU3448HhUX7AZB1xxqTg=A8PLbzazQxR_ukyJsw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, May 8, 2021 at 3:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> static inline struct mount *real_mount(struct vfsmount *mnt)
> {
>         return container_of(mnt, struct mount, mnt);

Too subtle for me indeed.

           Linus
