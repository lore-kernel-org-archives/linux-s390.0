Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B676C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 10:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6653C6103D
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 10:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbhIGK0r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233661AbhIGK0r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Sep 2021 06:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631010341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkR6zwo7S5sLkEP3Hl3y8Gt+KIK6HBJlddNqv1cks4k=;
        b=KBHttgF5/bbEe4wr9H6hH+OepnCx9FO0TxpZy9EbaMoAkMGDQqti1sPESY5tNYrn+C7qxb
        74LrblGKqPYpUxtjrfgmdYUdHFNKoyCS0qtAA2h5Jyb5mSMB2bTVoT83b7h9vyviYSpxcD
        vjVOJ3OoIuTRcGyKk+tycYJw86pwFSw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-inANqYSvM0-vYK4uy6C6kw-1; Tue, 07 Sep 2021 06:25:39 -0400
X-MC-Unique: inANqYSvM0-vYK4uy6C6kw-1
Received: by mail-wr1-f71.google.com with SMTP id m16-20020a056000181000b0015964e4ae48so1960318wrh.14
        for <linux-s390@vger.kernel.org>; Tue, 07 Sep 2021 03:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YkR6zwo7S5sLkEP3Hl3y8Gt+KIK6HBJlddNqv1cks4k=;
        b=oTpCCmVOr4+LyMlRL0b6vQEdaDPMDB3T5l9Ng9ACmJEfKMM9IehEh/NjNFPWEBC+bc
         +BQwkIdVJV7SfuPa0kJcyQfjyfTj/N6o8hGRPa4AXFOTtuBhR8u9vhomU+DlkXRUAmK5
         8aja6TyVhoUOvgfemyb0/Y5QdrSifrhs3FO5iSLckLdTwLuer3OCiGWBqQAKN9udFBan
         jr+9ApwaDXfycQqesNLr/ezfSsC5k9ZMQ4UigyTj4ihtvxjNzat4j3S2b3rhn/7FiqbQ
         3rSDwaymggpDu5hm5WuvSr3F7sxZWwoweENrNt7W4YDTYS91acSL0CTwdzzV8YK5DAoA
         /q2Q==
X-Gm-Message-State: AOAM530AHF+0rLQwXVb2DHSsDT/ZghWiDidU6Ioh9jpeQboJL1+vKXAy
        D3GqfzwKx0+O9ZWBC/MbpJ3uIVxylLo7tXU+jm1LZyeP0Y5VWGl9E/Wk7IxqRPjAIkIvCTkCT7+
        Mz9U/pVtfUgy4Qp1OF82V1w==
X-Received: by 2002:a5d:6486:: with SMTP id o6mr17366333wri.193.1631010338753;
        Tue, 07 Sep 2021 03:25:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSuexDTec5nPjCkxud+p5tgz5pAvum9LG2zR+d+af/JuudrOVT+AYs0JNtNTuoPUbk+lGqwQ==
X-Received: by 2002:a5d:6486:: with SMTP id o6mr17366315wri.193.1631010338595;
        Tue, 07 Sep 2021 03:25:38 -0700 (PDT)
Received: from gator (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t11sm2252710wmi.23.2021.09.07.03.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:25:38 -0700 (PDT)
Date:   Tue, 7 Sep 2021 12:25:36 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     thuth@redhat.com, pbonzini@redhat.com, lvivier@redhat.com,
        kvm-ppc@vger.kernel.org, david@redhat.com, frankja@linux.ibm.com,
        cohuck@redhat.com, imbrenda@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, andre.przywara@arm.com,
        maz@kernel.org, vivek.gautam@arm.com
Subject: Re: [kvm-unit-tests RFC PATCH 5/5] configure: Ignore --erratatxt
 when --target=kvmtool
Message-ID: <20210907102536.jhycvnazlmj7qyto@gator>
References: <20210702163122.96110-1-alexandru.elisei@arm.com>
 <20210702163122.96110-6-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702163122.96110-6-alexandru.elisei@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 02, 2021 at 05:31:22PM +0100, Alexandru Elisei wrote:
> kvmtool runs a test using the -f/--firmware argument, which doesn't load an
> initrd, making specifying an errata file useless. Instead, configure forces
> all erratas to be enabled via the CONFIG_ERRATA_FORCE define in
> lib/config.h.
> 
> Forbid the --erratatxt option when kvm-unit-tests is configured for kvmtool
> and let the user know that all erratas are enabled by default.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> I'm not sure if printing an error is too strong here and a simple warning would
> suffice. Suggestions welcome!
> 
>  configure | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/configure b/configure
> index 395c809c9c02..acd288239f80 100755
> --- a/configure
> +++ b/configure
> @@ -24,7 +24,8 @@ u32_long=
>  wa_divide=
>  target=
>  errata_force=0
> -erratatxt="$srcdir/errata.txt"
> +erratatxt_default="$srcdir/errata.txt"
> +erratatxt="_NO_FILE_4Uhere_"
>  host_key_document=
>  page_size=
>  earlycon=
> @@ -50,7 +51,8 @@ usage() {
>  	                           enable or disable the generation of a default environ when
>  	                           no environ is provided by the user (enabled by default)
>  	    --erratatxt=FILE       specify a file to use instead of errata.txt. Use
> -	                           '--erratatxt=' to ensure no file is used.
> +	                           '--erratatxt=' to ensure no file is used. This option is
> +	                           invalid for arm/arm64 when target=kvmtool.

Do we need to always specifiy arm/arm64 when talking about target=kvmtool?
How much more effort would an x86 kvmtool target be to add?

>  	    --host-key-document=HOST_KEY_DOCUMENT
>  	                           Specify the machine-specific host-key document for creating
>  	                           a PVM image with 'genprotimg' (s390x only)
> @@ -147,11 +149,6 @@ if [ -n "$host_key_document" ] && [ ! -f "$host_key_document" ]; then
>      exit 1
>  fi
>  
> -if [ "$erratatxt" ] && [ ! -f "$erratatxt" ]; then
> -    echo "erratatxt: $erratatxt does not exist or is not a regular file"
> -    exit 1
> -fi
> -
>  arch_name=$arch
>  [ "$arch" = "aarch64" ] && arch="arm64"
>  [ "$arch_name" = "arm64" ] && arch_name="aarch64"
> @@ -184,6 +181,21 @@ else
>      fi
>  fi
>  
> +if [ "$target" = "kvmtool" ]; then
> +    if [ "$erratatxt" ] && [ "$erratatxt" != "_NO_FILE_4Uhere_" ]; then
> +        echo "--erratatxt is not supported for target=kvmtool (all erratas enabled by default)"
> +        usage
> +    fi
> +else
> +    if [ "$erratatxt" = "_NO_FILE_4Uhere_" ]; then
> +        erratatxt=$erratatxt_default
> +    fi
> +    if [ "$erratatxt" ] && [ ! -f "$erratatxt" ]; then
> +        echo "erratatxt: $erratatxt does not exist or is not a regular file"
> +        exit 1
> +    fi
> +fi

switch

> +
>  [ -z "$processor" ] && processor="$arch"
>  
>  if [ "$processor" = "arm64" ]; then
> -- 
> 2.32.0
>

Otherwise looks good to me.

Thanks,
drew 

