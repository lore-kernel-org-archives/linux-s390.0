Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F192C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 08:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607226120D
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 08:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhJEIUd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:20:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:35781 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233174AbhJEIUd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 Oct 2021 04:20:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="248943315"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="248943315"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 01:18:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="589267458"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 01:18:41 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mXfeo-008pR6-6c;
        Tue, 05 Oct 2021 11:18:38 +0300
Date:   Tue, 5 Oct 2021 11:18:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Message-ID: <YVwKXn1Nqwk+Ahsx@smile.fi.intel.com>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
 <YVtksmjj1eGqw5GY@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVtksmjj1eGqw5GY@osiris>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04, 2021 at 10:31:46PM +0200, Heiko Carstens wrote:
> On Fri, Oct 01, 2021 at 04:02:01PM +0300, Andy Shevchenko wrote:

...

> > +	/* Segment name is limited by 8 characters + NUL */
> > +	char tmp[8 + 1];
> >  	int i;
> >  
> > -	for (i = 0; i < 8; i++) {
> > -		if (name[i] == '\0')
> > -			break;
> > -		dcss_name[i] = toupper(name[i]);
> > -	}
> > -	for (; i < 8; i++)
> > -		dcss_name[i] = ' ';
> > +	/*
> > +	 * This snprintf() call does two things:
> > +	 * - makes a NUL-terminated copy of the input string
> > +	 * - pads it with spaces
> > +	 */
> > +	snprintf(tmp, sizeof(tmp), "%s        ", name);
> 
> I can't say I like code where I have to count spaces in order to
> verify if the code is actually correct.

I understand your point, but have any idea how to make it differently
and not ugly at the same time?

> > +	string_upper(dcss_name, tmp);

...

> >  static struct dcss_segment *
> >  segment_by_name (char *name)
> >  {
> > -	char dcss_name[9];
> > +	char dcss_name[8];
> 
> string_upper will copy the terminating NUL-byte. By reducing the size
> of dcss_name to 8 bytes this will result in stack corruption.

Nope. Even in the original code this additional byte is left unused.

-- 
With Best Regards,
Andy Shevchenko


