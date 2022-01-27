Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C0EC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 27 Jan 2022 17:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbiA0RJY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244300AbiA0RJX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Jan 2022 12:09:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED91C061747
        for <linux-s390@vger.kernel.org>; Thu, 27 Jan 2022 09:09:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ka4so7183900ejc.11
        for <linux-s390@vger.kernel.org>; Thu, 27 Jan 2022 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZPHRE+C/v2gNlL2a7HeYHesyem4JYDq+ldUsKhvfG1s=;
        b=IHyD5WRqTbUmmWI8+vLcD4Kp6ngG/OB8pKAAOgJJT1cqDAgmMAfMCxRRMAjkCmbCmK
         BGW8YA0lugwhkzVlFTO+ZBSANh7Rtbu1d9XfrtjZmy4gfSme3QuwU4TEleL/YwPSrcp5
         ZA/xcOCNd+GC4oEr2beUZ/SzDzx2NHWjjJ+L5hDd557MIIvVO3hsY77c1JOrxkVPCgzg
         fWznPX0556UbEpR11kbtVVLOavD+Dxs9DAkSv5y+PJdPT2u4by8g1fMtwxIu0jeB+px+
         XphWUOdxCfFgWr697LXR41+ykxk6Mk03fkb5J4J6wRut4+5OalmuFrReeeune1W/bJXT
         dCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZPHRE+C/v2gNlL2a7HeYHesyem4JYDq+ldUsKhvfG1s=;
        b=l0OHwYqGpUbA4dKVCImadb0XB9a31OUnzR9oFBIACI7s/pNFtutGFKT/8fMRwxCkgK
         nADeMFYJ8XbQ2ltBUHmt6yD2Hx0V0HJ5z0SCOP5sHv23bzkGrLGinu3RdufsfsAL+odh
         muRM57Kk9O57wm9w+ieMFlG71zx+fl34B5fIVBr1njV/fizPDkb5MSMRefOIclZA5mra
         T/4wiAhQLVmKAdbf/o7lEgIIvcPkzx/ou0T22HFZMo/3PcZNfnnVsURuzgJi8AP9mdIE
         D+msLhHlSp44OWIGfE2hAwSSHVDghQ9wyXWBpuqrl6rKaRjLrifzmySmbdorFNLoWOzl
         r9hg==
X-Gm-Message-State: AOAM533lwNGJSFSOBxAMBZm0EdOuL28aIAceUR2TwhqXHcPDNWUd2sjH
        2g3yxAJAgugph6pXwccydk0tMw==
X-Google-Smtp-Source: ABdhPJw3UvX1SmRdPOm2ASisWcPsdzNnny+A9/yUDLRkyoFTSQ5UbF9BZr6ucKYXwfZqvt8dVzT5mw==
X-Received: by 2002:a17:906:b116:: with SMTP id u22mr3667402ejy.427.1643303361918;
        Thu, 27 Jan 2022 09:09:21 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fe1f:d9d6:8db5:a255? ([2a02:578:8593:1200:fe1f:d9d6:8db5:a255])
        by smtp.gmail.com with ESMTPSA id c1sm8927832ejs.29.2022.01.27.09.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 09:09:21 -0800 (PST)
Message-ID: <1825f5e8-6d13-a317-4a96-f4a4fcf07409@tessares.net>
Date:   Thu, 27 Jan 2022 18:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net-next 3/3] net/smc: Fallback when handshake workqueue
 congested
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1643284658.git.alibuda@linux.alibaba.com>
 <ed4781cde8e3b9812d4a46ce676294a812c80e8f.1643284658.git.alibuda@linux.alibaba.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ed4781cde8e3b9812d4a46ce676294a812c80e8f.1643284658.git.alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

(+cc MPTCP ML)

On 27/01/2022 13:08, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch intends to provide a mechanism to allow automatic fallback to
> TCP according to the pressure of SMC handshake process. At present,
> frequent visits will cause the incoming connections to be backlogged in
> SMC handshake queue, raise the connections established time. Which is
> quite unacceptable for those applications who base on short lived
> connections.

(...)

> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index 1ab3c5a..1903927 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -19,3 +19,15 @@ config SMC_DIAG
>  	  smcss.
>  
>  	  if unsure, say Y.
> +
> +if MPTCP

After having read the code and the commit message, it is not clear to me
 why this new feature requires to have MPTCP enabled. May you share some
explanations about that please?

> +
> +config SMC_AUTO_FALLBACK
> +	bool "SMC: automatic fallback to TCP"
> +	default y
> +	help
> +	  Allow automatic fallback to TCP accroding to the pressure of SMC-R
> +	  handshake process.
> +
> +	  If that's not what you except or unsure, say N.
> +endif

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
