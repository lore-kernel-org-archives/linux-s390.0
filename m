Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD3C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 28 Feb 2022 06:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiB1Gkx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Feb 2022 01:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiB1Gks (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Feb 2022 01:40:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23BC63D1DA
        for <linux-s390@vger.kernel.org>; Sun, 27 Feb 2022 22:40:10 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-127-ln2z8qc2NY6O0etIBpyffg-1; Mon, 28 Feb 2022 06:40:07 +0000
X-MC-Unique: ln2z8qc2NY6O0etIBpyffg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 28 Feb 2022 06:40:04 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 28 Feb 2022 06:40:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'guoren@kernel.org'" <guoren@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "liush@allwinnertech.com" <liush@allwinnertech.com>,
        "wefu@redhat.com" <wefu@redhat.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "wangjunqiang@iscas.ac.cn" <wangjunqiang@iscas.ac.cn>,
        "hch@lst.de" <hch@lst.de>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH V7 03/20] compat: consolidate the compat_flock{,64}
 definition
Thread-Topic: [PATCH V7 03/20] compat: consolidate the compat_flock{,64}
 definition
Thread-Index: AQHYK/ctkLOBFN5NzkqkonsQCyvC26yogbZg
Date:   Mon, 28 Feb 2022 06:40:04 +0000
Message-ID: <b8e765910e274c0fb574ff23f88b881c@AcuMS.aculab.com>
References: <20220227162831.674483-1-guoren@kernel.org>
 <20220227162831.674483-4-guoren@kernel.org>
In-Reply-To: <20220227162831.674483-4-guoren@kernel.org>
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

From: guoren@kernel.org
> Sent: 27 February 2022 16:28
> 
> From: Christoph Hellwig <hch@lst.de>
> 
> Provide a single common definition for the compat_flock and
> compat_flock64 structures using the same tricks as for the native
> variants.  Another extra define is added for the packing required on
> x86.
...
> diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
...
>  /*
> - * IA32 uses 4 byte alignment for 64 bit quantities,
> - * so we need to pack this structure.
> + * IA32 uses 4 byte alignment for 64 bit quantities, so we need to pack the
> + * compat flock64 structure.
>   */
...
> +#define __ARCH_NEED_COMPAT_FLOCK64_PACKED
> 
>  struct compat_statfs {
>  	int		f_type;
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 1c758b0e0359..a0481fe6c5d5 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -258,6 +258,37 @@ struct compat_rlimit {
>  	compat_ulong_t	rlim_max;
>  };
> 
> +#ifdef __ARCH_NEED_COMPAT_FLOCK64_PACKED
> +#define __ARCH_COMPAT_FLOCK64_PACK	__attribute__((packed))
> +#else
> +#define __ARCH_COMPAT_FLOCK64_PACK
> +#endif
...
> +struct compat_flock64 {
> +	short		l_type;
> +	short		l_whence;
> +	compat_loff_t	l_start;
> +	compat_loff_t	l_len;
> +	compat_pid_t	l_pid;
> +#ifdef __ARCH_COMPAT_FLOCK64_PAD
> +	__ARCH_COMPAT_FLOCK64_PAD
> +#endif
> +} __ARCH_COMPAT_FLOCK64_PACK;
> +

Provided compat_loff_t are correctly defined with __aligned__(4)
marking the structure packed isn't needed.
I believe compat_u64 and compat_s64 both have aligned(4).
It is also wrong, consider:

struct foo {
	char x;
	struct compat_flock64 fl64;
};

There should be 3 bytes of padding after 'x'.
But you've removed it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

