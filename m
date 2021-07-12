Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37673C07E99
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jul 2021 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C92361186
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jul 2021 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhGLQki (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233633AbhGLQkh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Jul 2021 12:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626107868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmsrfUJqVuzKIhoeVB1ab8GPQvYJh20rCkMxoqwgccc=;
        b=iLcJaA84nFVoUH12X/mg1M6/IB6BEiXGRP/w/SUBVbTkpxA1Bor1X9vtVmqhoZHD5q7y3g
        DnKzkMIY+aeqW8xkd8KdGpqgJD/NqLLkoseE88HuP12mqCAhv/ZPdCPC9VswQ8nYFCAUI4
        9YbKCKZ36D/zW3dwNOMitmWpJaLc2II=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Bm3rfurYP7-JKhTqh7YSow-1; Mon, 12 Jul 2021 12:37:47 -0400
X-MC-Unique: Bm3rfurYP7-JKhTqh7YSow-1
Received: by mail-il1-f199.google.com with SMTP id g9-20020a92cda90000b029020cc3319a86so2530029ild.18
        for <linux-s390@vger.kernel.org>; Mon, 12 Jul 2021 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmsrfUJqVuzKIhoeVB1ab8GPQvYJh20rCkMxoqwgccc=;
        b=RvtbHET0wlBZZ3trZndWLzSPgl/6mVDAOtv2+KWqID8v8KRGdswrk2sghr0ntnb+15
         yuyvRS2W0Ytu9oeA+sEiR7nMVbDACZbjJb2+ZylB7zQdYfEJOAOnBKQV9KO+ibsXFCQx
         qvE02DqIXPa2/eu6+PzFHqxtECAvrxotOregueeDoYSD9Dv3GpMw7F+EtmHrg2NJ8vZ8
         nRs++ZCKZ9/KQwR1UteX4lscTxYVJPuK/tt0iElKAmNlXE82nEk9n60V+oOOkC2VXsC/
         diH7TWtMFW6k0gcPopo4S/lWBZGQDBsN2wIF4uTzys3Qy0UQjWgIiSfllJ0iZxIOg9z3
         wABw==
X-Gm-Message-State: AOAM5301QadU/a8sQO/gRKs+th2yvFlOQmAohHoTSSqMNBhGrNQig9VE
        GbEyptxviYjW04jZrCinvVbcyTp/dXkeyCnAbFiQ7XHxmwA2xHrcM00dTyDSXZ/UTimIA5W8NbJ
        7qUGjP5EnsG6P2vmIee+Wxw==
X-Received: by 2002:a92:7a12:: with SMTP id v18mr11239787ilc.27.1626107866875;
        Mon, 12 Jul 2021 09:37:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVBVoWaMr/V5Gyw1JMvoSpF+iBmSnxs3Lb0dTzJIaWKLxJccOVfvstXhDuQpUmyCOaoGc3Jw==
X-Received: by 2002:a92:7a12:: with SMTP id v18mr11239751ilc.27.1626107866573;
        Mon, 12 Jul 2021 09:37:46 -0700 (PDT)
Received: from gator ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id y13sm7797842ioa.51.2021.07.12.09.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:37:46 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:37:44 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     thuth@redhat.com, pbonzini@redhat.com, lvivier@redhat.com,
        kvm-ppc@vger.kernel.org, david@redhat.com, frankja@linux.ibm.com,
        cohuck@redhat.com, imbrenda@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, andre.przywara@arm.com,
        maz@kernel.org, vivek.gautam@arm.com
Subject: Re: [kvm-unit-tests RFC PATCH 2/5] scripts: Rename run_qemu_status
 -> run_test_status
Message-ID: <20210712163744.5qj3jddg4j6abuq4@gator>
References: <20210702163122.96110-1-alexandru.elisei@arm.com>
 <20210702163122.96110-3-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702163122.96110-3-alexandru.elisei@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 02, 2021 at 05:31:19PM +0100, Alexandru Elisei wrote:
> kvm-unit-tests will get support for running tests automatically under
> kvmtool, rename the function to make it more generic.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  scripts/arch-run.bash | 2 +-
>  powerpc/run           | 2 +-
>  s390x/run             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 5997e384019b..8ceed53ed7f8 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -69,7 +69,7 @@ run_qemu ()
>  	return $ret
>  }
>  
> -run_qemu_status ()
> +run_test_status ()
>  {
>  	local stdout ret
>  
> diff --git a/powerpc/run b/powerpc/run
> index 597ab96ed8a8..312576006504 100755
> --- a/powerpc/run
> +++ b/powerpc/run
> @@ -31,4 +31,4 @@ command="$(migration_cmd) $(timeout_cmd) $command"
>  # to fixup the fixup below by parsing the true exit code from the output.
>  # The second fixup is also a FIXME, because once we add chr-testdev
>  # support for powerpc, we won't need the second fixup.
> -run_qemu_status $command "$@"
> +run_test_status $command "$@"
> diff --git a/s390x/run b/s390x/run
> index c615caa1b772..5a4bb3bda805 100755
> --- a/s390x/run
> +++ b/s390x/run
> @@ -28,4 +28,4 @@ command+=" -kernel"
>  command="$(timeout_cmd) $command"
>  
>  # We return the exit code via stdout, not via the QEMU return code
> -run_qemu_status $command "$@"
> +run_test_status $command "$@"
> -- 
> 2.32.0
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

