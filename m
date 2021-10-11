Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE74EC4332F
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DF660ED4
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 08:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhJKIXe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:23:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:45209 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234995AbhJKIXY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Oct 2021 04:23:24 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-50-sSIC6RlSOQyzXfRCKztwiQ-1; Mon, 11 Oct 2021 09:21:18 +0100
X-MC-Unique: sSIC6RlSOQyzXfRCKztwiQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 11 Oct 2021 09:21:16 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 11 Oct 2021 09:21:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Heiko Carstens' <hca@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: RE: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Thread-Topic: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Thread-Index: AQHXuV7g4EMrXsSepEuBh6r8/SzWaKvNfv3A
Date:   Mon, 11 Oct 2021 08:21:15 +0000
Message-ID: <c372092aecc243ad880ea9a5bdf7d080@AcuMS.aculab.com>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
 <YVtksmjj1eGqw5GY@osiris>
In-Reply-To: <YVtksmjj1eGqw5GY@osiris>
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

...
> > +	 * This snprintf() call does two things:
> > +	 * - makes a NUL-terminated copy of the input string
> > +	 * - pads it with spaces
> > +	 */
> > +	snprintf(tmp, sizeof(tmp), "%s        ", name);
> 
> I can't say I like code where I have to count spaces in order to
> verify if the code is actually correct.

What it wrong with "%-8.8s" ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

