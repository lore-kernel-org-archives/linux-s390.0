Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C6CC433C1
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 02:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DD961930
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 02:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCVCvp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 21 Mar 2021 22:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCVCvR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 21 Mar 2021 22:51:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDCBC061574;
        Sun, 21 Mar 2021 19:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=FMpgnxzFsxg0dMVyuPcih862uGhRV6SXBMZLguwaDjQ=; b=elGbXKtesYq5x6uTK/R6zcCiSY
        ozddIiYq5Bx8WJElgyjDefIRoQaWKzQz+TMr6aViTVYGLW9mkPy/gTdO6hFFDVK0RgV7FPC7GIkFm
        3Ne/18iZylHjhUvg07pOViZJ2mT+uaW67rGrXupjQLKrWnsjapmWHwqMjipPQuy95mRD1uFQM2tRt
        fTD21tUNIjIddipRLsyBzai3DREmIfnn3f3HiWFIZ8fvUimx9VIEMRWMjuM8MIysXRtFgqP53eghP
        EYeIKi75d6p/WG9J9bhSCwqsQP6BKdcaKfgEW/AUB2+k2DmYCsjyOhTrAFxASNI0zBGlJpXbbNGku
        XbJ1weXg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOAet-00AjPY-TV; Mon, 22 Mar 2021 02:51:14 +0000
Subject: Re: [PATCH] s390: dasd: Mundane spelling fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, sth@linux.ibm.com,
        hoeppner@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210322023930.376358-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fcd8ebe8-d659-0724-64e7-594137654bc1@infradead.org>
Date:   Sun, 21 Mar 2021 19:51:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322023930.376358-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 3/21/21 7:39 PM, Bhaskar Chowdhury wrote:
> 
> s/Subssystem/Subsystem/ ......two different places
> s/reportet/reported/
> s/managemnet/management/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/s390/block/dasd_eckd.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
> index ca24a78a256e..73651211789f 100644
> --- a/drivers/s390/block/dasd_eckd.h
> +++ b/drivers/s390/block/dasd_eckd.h
> @@ -52,7 +52,7 @@
>  #define DASD_ECKD_CCW_RCD		 0xFA
>  #define DASD_ECKD_CCW_DSO		 0xF7
> 
> -/* Define Subssystem Function / Orders */
> +/* Define Subsystem Function / Orders */
>  #define DSO_ORDER_RAS			 0x81
> 
>  /*
> @@ -110,7 +110,7 @@
>  #define DASD_ECKD_PG_GROUPED		 0x10
> 
>  /*
> - * Size that is reportet for large volumes in the old 16-bit no_cyl field
> + * Size that is reported for large volumes in the old 16-bit no_cyl field
>   */
>  #define LV_COMPAT_CYL 0xFFFE
> 
> @@ -555,7 +555,7 @@ struct dasd_dso_ras_ext_range {
>  } __packed;
> 
>  /*
> - * Define Subsytem Operation - Release Allocated Space
> + * Define Subsystem Operation - Release Allocated Space
>   */
>  struct dasd_dso_ras_data {
>  	__u8 order;
> @@ -676,7 +676,7 @@ struct dasd_eckd_private {
>  	struct dasd_ext_pool_sum eps;
>  	u32 real_cyl;
> 
> -	/* alias managemnet */
> +	/* alias management */
>  	struct dasd_uid uid;
>  	struct alias_pav_group *pavgroup;
>  	struct alias_lcu *lcu;
> --


-- 
~Randy
