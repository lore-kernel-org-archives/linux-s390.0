Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD2BC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29486120F
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhJELbz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 07:31:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3932 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhJELbz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 07:31:55 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNwJr1L2fz67N0s;
        Tue,  5 Oct 2021 19:26:36 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 13:30:02 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.008;
 Tue, 5 Oct 2021 13:30:02 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] s390: Fix strrchr() implementation
Thread-Topic: [PATCH] s390: Fix strrchr() implementation
Thread-Index: AQHXubpUeLbUtyZNSEm/g+efvuXaaqvEHweAgAAicsA=
Date:   Tue, 5 Oct 2021 11:30:02 +0000
Message-ID: <7eeccf08aed44453959763629852d58e@huawei.com>
References: <20211005072621.53500-1-roberto.sassu@huawei.com>
 <YVwzUbHcZkHQT0K4@osiris>
In-Reply-To: <YVwzUbHcZkHQT0K4@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> From: Heiko Carstens [mailto:hca@linux.ibm.com]
> Sent: Tuesday, October 5, 2021 1:13 PM
> On Tue, Oct 05, 2021 at 09:26:21AM +0200, Roberto Sassu wrote:
> > Access the string at len - 1 instead of len.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  arch/s390/lib/string.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
> > index cfcdf76d6a95..162a391788ad 100644
> > --- a/arch/s390/lib/string.c
> > +++ b/arch/s390/lib/string.c
> > @@ -261,12 +261,12 @@ char *strrchr(const char *s, int c)
> >  {
> >         size_t len = __strend(s) - s;
> >
> > -       if (len)
> > -	       do {
> > -		       if (s[len] == (char) c)
> > -			       return (char *) s + len;
> > -	       } while (--len > 0);
> > -       return NULL;
> > +	if (len)
> > +		do {
> > +			if (s[len - 1] == (char) c)
> > +				return (char *) s + len - 1;
> > +		} while (--len > 0);
> > +	return NULL;
> 
> You missed to tell what this is supposed to fix. The patch however is
> incorrect: the terminating null byte is considered part of the
> string. With your patch strrchr(somestring, 0) would not work
> correctly anymore.

Hi Heiko

yes, sorry. I didn't consider that.

> However our strrchr implementation is indeed broken, since for an
> empty string and searching for the null byte would incorrectly return
> NULL. Luckily there is not a single invocation in the kernel which
> doing that.

Ok. However, the main reason of this patch is that s[0] is not
evaluated, when len > 0. I will provide a new version of the patch.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua
