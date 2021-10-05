Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A01C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 12:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE2761166
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 12:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhJEMLi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 08:11:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:52866 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233808AbhJEMLi (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 Oct 2021 08:11:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225662756"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225662756"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="589332377"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:09:45 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mXjGR-008sGX-11;
        Tue, 05 Oct 2021 15:09:43 +0300
Date:   Tue, 5 Oct 2021 15:09:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Message-ID: <YVxAh+0SeLEgh85e@smile.fi.intel.com>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
 <YVtksmjj1eGqw5GY@osiris>
 <YVwKXn1Nqwk+Ahsx@smile.fi.intel.com>
 <YVwSxGyx45gs2+ZW@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVwSxGyx45gs2+ZW@osiris>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05, 2021 at 10:54:28AM +0200, Heiko Carstens wrote:
> On Tue, Oct 05, 2021 at 11:18:38AM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 04, 2021 at 10:31:46PM +0200, Heiko Carstens wrote:
> > > On Fri, Oct 01, 2021 at 04:02:01PM +0300, Andy Shevchenko wrote:

...

> > > > +	char tmp[8 + 1];
> > > >  	int i;
> > > >  
> > > > -	for (i = 0; i < 8; i++) {
> > > > -		if (name[i] == '\0')
> > > > -			break;
> > > > -		dcss_name[i] = toupper(name[i]);
> > > > -	}
> > > > -	for (; i < 8; i++)
> > > > -		dcss_name[i] = ' ';
> > > > +	/*
> > > > +	 * This snprintf() call does two things:
> > > > +	 * - makes a NUL-terminated copy of the input string
> > > > +	 * - pads it with spaces
> > > > +	 */
> > > > +	snprintf(tmp, sizeof(tmp), "%s        ", name);
> > > 
> > > I can't say I like code where I have to count spaces in order to
> > > verify if the code is actually correct.
> > 
> > I understand your point, but have any idea how to make it differently
> > and not ugly at the same time?
> 
> Don't know. You could use strncopy+strlen+memset (with space
> character). After all I'm not very convinced that the resulting code
> buys us anything compared to the current variant.

Yup, so let's convert only the first part then.

...

> > > > -	char dcss_name[9];
> > > > +	char dcss_name[8];
> > > 
> > > string_upper will copy the terminating NUL-byte. By reducing the size
> > > of dcss_name to 8 bytes this will result in stack corruption.
> > 
> > Nope. Even in the original code this additional byte is left unused.
> 
> I'm talking about the new code, not the old code: If "name" points to
> a NUL terminated eight chararacter string, then the new code will use
> snprintf to copy it 1:1 to tmp, and the subsequent string_upper() will
> copy the string (upper cased) to dcss_name, now including the NUL
> terminating byte, which won't fit into dcss_name.
> Am I missing something here?

Ah, indeed, although it's rather bug in the implementation of above.
But original code has it not in use.

-- 
With Best Regards,
Andy Shevchenko


