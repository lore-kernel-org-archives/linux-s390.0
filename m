Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E594AEB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 14:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjFWOqh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFWOqb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 10:46:31 -0400
X-Greylist: delayed 25772 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 07:46:29 PDT
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB781BF7
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 07:46:28 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:46:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687531587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHvvf/bDESVtRUHz9Yj9cOg9EwzScFCVrw08rHloHBY=;
        b=Vxj+7cSKO04fpdl6eqxWrE7iDKjWn2sWylHPJa2DN6YBsj9wQbNZcLhuL0tsbSuKBUs1re
        /YiTAKWGAO50nhu+EIyJLBofsa9V5htBaDHIA6AZJvd45tOJGfXPV+sbLem1G9OBV7pgYg
        qM82k6vx+F6Qlr2uiFv6J5WNoM2OWkE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvmarm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 0/2] Rework LDFLAGS and link with
 noexecstack
Message-ID: <20230623-7e80827ee6c29678c4da2c3f@orel>
References: <20230623125416.481755-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623125416.481755-1-thuth@redhat.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 23, 2023 at 02:54:14PM +0200, Thomas Huth wrote:
> I noticed that the latest version of ld (in Fedora rawhide) emits
> a warning on x86 and s390x, complaining about missing .note.GNU-stack
> section that implies an executable stack. It can be silenced by
> linking with "-z noexecstack".
> 
> While trying to add this switch globally to the kvm-unit-tests, I
> had to discover that the common LDFLAGS are hardly used anywhere,
> so the first patch cleans up that problem first before adding the
> new flag in the second patch.
> 
> Thomas Huth (2):
>   Rework the common LDFLAGS to become more useful again
>   Link with "-z noexecstack" to avoid warning from newer versions of ld
> 
>  Makefile                | 2 +-
>  arm/Makefile.common     | 2 +-
>  powerpc/Makefile.common | 2 +-
>  s390x/Makefile          | 2 +-
>  x86/Makefile.common     | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 2.39.3
>

For the series

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
