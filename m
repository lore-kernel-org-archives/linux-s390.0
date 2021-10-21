Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CE1C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 21 Oct 2021 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294CC60FD8
	for <linux-s390@archiver.kernel.org>; Thu, 21 Oct 2021 16:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhJUQT7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhJUQT6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Oct 2021 12:19:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF034C061348
        for <linux-s390@vger.kernel.org>; Thu, 21 Oct 2021 09:17:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d9so1089837pfl.6
        for <linux-s390@vger.kernel.org>; Thu, 21 Oct 2021 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1qArqukqC04HeUCYKid9OyPBNl7BXFoMkpeHaeZAIfE=;
        b=SHGLjN129sDYsXEBOsuAe2uP97qJsPaTNPpHcXnbmGFyxoRGDwinnb1n91ZKRtwq0T
         /0qtzTcOqWpoPeP/6byc/5SC7lY+NYraLtivcQxalcJ2dEXztutjP3B98tUY6U3ef9sn
         44aXRzM7rk3gagysuq2S3rcmAKD0sRkUoCjWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1qArqukqC04HeUCYKid9OyPBNl7BXFoMkpeHaeZAIfE=;
        b=KFwCCbSzGnyECP+7IZC0+swHsytgNW8qihKJkSDt6OZsjUHFk23+iKl+bmq6ZNaCiB
         tU04UzRVbeC8yh5nDBlWLp3f+FLQfL286ygTULyUWzQlNCkLk9UIFCAqarqCsED8RjeH
         kbqRH/c1a6xCqck43/l67jnsw+0pk5kQmPBoyOhE05zX3/yLsa74wct5I0upJzGaYEx+
         iH7q+IR3Ya7MVsipeTXVjBhVi84+SYSty/T9B+G01rjQ9AOUXRI/0kZn/9lGQ/3urZco
         F7YvlboPQ/WWWuwclafQFddPF0p9bgth8SwiX4KkPXTEWTOAefYBD8WavDpOymDyzguV
         ktpQ==
X-Gm-Message-State: AOAM533AcyEcHG5NH5a+nClnq62UuMb+sMAHQm9hGJVsDS0e1Hmty5JT
        GkGHTsVyCccahQ+NIZTEn+Pgpw==
X-Google-Smtp-Source: ABdhPJxhDUv0mfKcvT4mC7bIBo7ygrswSSyc5PmTDnjtOjwpsfgOMJolqsotzki3s0E2t66fUJIsWQ==
X-Received: by 2002:a63:d94b:: with SMTP id e11mr5038268pgj.295.1634833062183;
        Thu, 21 Oct 2021 09:17:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8sm7153670pfn.45.2021.10.21.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:17:41 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:17:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 11/20] signal/s390: Use force_sigsegv in
 default_trap_handler
Message-ID: <202110210917.FEED0F8@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-11-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-11-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:57PM -0500, Eric W. Biederman wrote:
> Reading the history it is unclear why default_trap_handler calls
> do_exit.  It is not even menthioned in the commit where the change
> happened.  My best guess is that because it is unknown why the
> exception happened it was desired to guarantee the process never
> returned to userspace.
> 
> Using do_exit(SIGSEGV) has the problem that it will only terminate one
> thread of a process, leaving the process in an undefined state.
> 
> Use force_sigsegv(SIGSEGV) instead which effectively has the same
> behavior except that is uses the ordinary signal mechanism and
> terminates all threads of a process and is generally well defined.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
