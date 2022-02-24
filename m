Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0155C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 24 Feb 2022 08:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiBXI7Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiBXI7I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Feb 2022 03:59:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C62268345
        for <linux-s390@vger.kernel.org>; Thu, 24 Feb 2022 00:58:24 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-216-yFNLSyvJPDmN2lh--r6gzg-1; Thu, 24 Feb 2022 08:58:21 +0000
X-MC-Unique: yFNLSyvJPDmN2lh--r6gzg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 24 Feb 2022 08:58:20 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 24 Feb 2022 08:58:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2] usercopy: Check valid lifetime via stack depth
Thread-Topic: [PATCH v2] usercopy: Check valid lifetime via stack depth
Thread-Index: AQHYKUROaYEZJJ15GkKlMpPMpHZgQKyiZK3w
Date:   Thu, 24 Feb 2022 08:58:20 +0000
Message-ID: <85d42900efaa4fdb8c20de2147d938c7@AcuMS.aculab.com>
References: <20220224060342.1855457-1-keescook@chromium.org>
In-Reply-To: <20220224060342.1855457-1-keescook@chromium.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Kees Cook
> Sent: 24 February 2022 06:04
> 
> Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
> is not available (i.e. everything except x86 with FRAME_POINTER), check
> a stack object as being at least "current depth valid", in the sense
> that any object within the stack region but not between start-of-stack
> and current_stack_pointer should be considered unavailable (i.e. its
> lifetime is from a call no longer present on the stack).
> 
...
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index d0d268135d96..5d28725af95f 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -22,6 +22,30 @@
>  #include <asm/sections.h>
>  #include "slab.h"
> 
> +/*
> + * Only called if obj is within stack/stackend bounds. Determine if within
> + * current stack depth.
> + */
> +static inline int check_stack_object_depth(const void *obj,
> +					   unsigned long len)
> +{
> +#ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
> +#ifndef CONFIG_STACK_GROWSUP

Pointless negation

> +	const void * const high = stackend;
> +	const void * const low = (void *)current_stack_pointer;
> +#else
> +	const void * const high = (void *)current_stack_pointer;
> +	const void * const low = stack;
> +#endif
> +
> +	/* Reject: object not within current stack depth. */
> +	if (obj < low || high < obj + len)
> +		return BAD_STACK;
> +
> +#endif
> +	return GOOD_STACK;
> +}

If the comment at the top of the function is correct then
only a single test for the correct end of the buffer against
the current stack pointer is needed.
Something like:
#ifdef CONFIG_STACK_GROWSUP
	if ((void *)current_stack_pointer < obj + len)
		return BAD_STACK;
#else
	if (obj < (void *)current_stack_pointer)
		return BAD_STACK;
#endif
	return GOOD_STACK;

Although it may depend on exactly where the stack pointer
points to - especially for GROWSUP.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

