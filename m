Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105D5C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D821060E05
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 08:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhJLIHF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:07:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27952 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234829AbhJLIHC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 04:07:02 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-26-lK0fUTS6Owec_tU20_b4LA-1; Tue, 12 Oct 2021 09:04:59 +0100
X-MC-Unique: lK0fUTS6Owec_tU20_b4LA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 12 Oct 2021 09:04:58 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 12 Oct 2021 09:04:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Heiko Carstens' <hca@linux.ibm.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: RE: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Thread-Topic: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Thread-Index: AQHXuV7g4EMrXsSepEuBh6r8/SzWaKvNfv3AgAANt4CAAX8zwA==
Date:   Tue, 12 Oct 2021 08:04:58 +0000
Message-ID: <985bbceb3ee046bbbee6199efcf7c90c@AcuMS.aculab.com>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
 <YVtksmjj1eGqw5GY@osiris> <c372092aecc243ad880ea9a5bdf7d080@AcuMS.aculab.com>
 <YWQNZb25R3SjsQAL@osiris>
In-Reply-To: <YWQNZb25R3SjsQAL@osiris>
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

From: Heiko Carstens
> Sent: 11 October 2021 11:10
> 
> On Mon, Oct 11, 2021 at 08:21:15AM +0000, David Laight wrote:
> > ...
> > > > +	 * This snprintf() call does two things:
> > > > +	 * - makes a NUL-terminated copy of the input string
> > > > +	 * - pads it with spaces
> > > > +	 */
> > > > +	snprintf(tmp, sizeof(tmp), "%s        ", name);
> > >
> > > I can't say I like code where I have to count spaces in order to
> > > verify if the code is actually correct.
> >
> > What it wrong with "%-8.8s" ?
> 
> There's nothing wrong with it, except lack of imagination on my side ;)
> Andy, care to to send a separate patch just for extmem.c?

Are any of the snprintf() versions actually correct at all?
The implication of the comment is that the input string might
not be NUL terminated - in which case it shouldn't be passed
to snprintf().
I don't think you can assume that the format processing doesn't
do a strlen() of any %s argument - even if a maximum field
width is given.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

