Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30E1E505
	for <linux-s390@vger.kernel.org>; Mon, 12 May 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070079; cv=none; b=pctzcKGqhlWdQuqBSr7w0te0Bds0uHfQuQQniErSZ7VXCts0sk/2RXnWCUVp3Hz0jSFRxxGyk9vD2jh9FCHAyPcGGTgzWyQ4SS+8JGM8iRwjLkkMbRMBUh+C4DdD/meE5HxJ9jpcjSwX96Bo2Hc/6gZO4bcGTaSLbM9RjDwJbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070079; c=relaxed/simple;
	bh=T8u4tpDPgdsG1Q7M3EmIMEtUdVEh7tv0NBVLmY8Ps2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/R+er6I4+S+2+9acNQWlJox5rsdFZ5UpxVAaADs7YwDiwOHrmDpccEOjHFE1Yb4JHVnn8d16+nCVaLfy8+yywNy3NF5lKUyjHVZrC4MpfH0C5bINmHAGxe/4yxSlNJNUfneqM5K0T2D9OKf0dYpzJ/kIzbyR+nWC1+VTEw29E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DBvBCPTB; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DBvBCPTB"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so36420956d6.2
        for <linux-s390@vger.kernel.org>; Mon, 12 May 2025 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747070075; x=1747674875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/ckDEypwx/ecrERWsbz3g8urzNFXJJrBw0I1vB7QGk=;
        b=DBvBCPTB1GO1yMt9daeDInJOVof/droRmgu0pBeOStYEAmpRM3ipNjrCLrzWito1/g
         c91eOLNbgw11A6Cy99oFnaNBWDyUID9P1uH8uE8mO0pipc46DMMKGt7MgK6tEgUaKJKP
         r0c38eRdwvURWx7THiQXujy4dKrNzz56gxwztF2gp7q+W8K/CeFMf4v9VOn/0/O+m8Cb
         XRbn/fm/5OnaJM7T5/dL3qlI2lq1HRMMZVrdkdfFnseBcoJkC3Hl4EdThi/yZUhSGenz
         svbQ7XwPwToLTTT/Mo+HFJGOVD8Que3Ue9b1c6SL12JSUATu0bFksqAIIpBO6OivrAKc
         58BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747070075; x=1747674875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/ckDEypwx/ecrERWsbz3g8urzNFXJJrBw0I1vB7QGk=;
        b=OV4YQbcolZ9EUK24OGc9OjW0wA4yZkqdemNwIeOYpq2ovllpbIc6Y0NaeaM//nQgw/
         vAaeyfu3ify+QvtgdccxwT9IOc7caYtQoBz+52M6PvnVfNw5faEAHfHFpEDKmDIMrKfN
         Mk1cJv+f5vAQn/wKr73nMlSac1VKWQ2vo50FiLJXAZ+2YHEHIf15J+WLpwEWrCBw3e5X
         OVx32lqgsesCJSeQcFzXeGboM0Ep5CsM2Awv5GcqTuL7dXI1sDOwdHNNPn27PI0Mwo1a
         Ti6mq2Pf8PGK5vJJUuDUMJdsz0KsCoGQ9pE5DcZIa7qM5ybS7JkF/slR9y16KSuWOR38
         11aA==
X-Forwarded-Encrypted: i=1; AJvYcCXpK721oMdekWPzRWoFlhfHXztcA7FreTlMqa2NgbIVkLxxaf9JuZhPZMsN/DqWNwMhss+Ok16luoB8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqu5QcAVQpSVihoRRBEbHrTPn+5W1OH2Z71hjtrMj89oX5KY8K
	29nCoNEqxUCIBZzPOFPfcouQ09a3BGXzRfnc0Js5o6Fz8K4/8XgOFAawQNKIn54=
X-Gm-Gg: ASbGncvyo+KWtqQjDK2Y02DtqJ5wwbhJb9v3rD8fDgDfSingZP/jVI9hWAXgZKTYxH+
	sbDWb0vX9f2BpCIVhna9lDf0TVKaWgOb3S0pzj7WIJUNfx1uycoTE6hmJYXFT0nr7kTU33HjF6u
	b/JDlixclur7RoVlt6RMXBAc2Vv+Oc5OhhbUo7L8iTKNdOYIIXRgr4do5mYWLdfSSj/+WpZAdnE
	lJd+DvrfDVnrm34QD4B7iXZpB5PDK8984Z0+T6s8ewZnYKnag1FMmXKiWFqO8jg3XhTqFQ6msNt
	Y8TFMczrpHLjDi8BOLArW1fC246Y4JPI8jAe5aGwnssnvoQz3Q==
X-Google-Smtp-Source: AGHT+IFu6k9V3NH5ND/iEeANw5G3l4Xwl02YCCtcV/XMDdPbDW3a7GeGy7SVWuSh149jGYVLpl/JEA==
X-Received: by 2002:ad4:5dcf:0:b0:6f5:46b0:7d11 with SMTP id 6a1803df08f44-6f6e48100a9mr241437306d6.36.1747070075105;
        Mon, 12 May 2025 10:14:35 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f6e3a472b3sm55106256d6.77.2025.05.12.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 10:14:34 -0700 (PDT)
Date: Mon, 12 May 2025 13:14:29 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
Message-ID: <20250512171429.GB615800@cmpxchg.org>
References: <87wmalyktd.fsf@linux.ibm.com>
 <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
 <A82049B8-B1B5-4234-BCFA-55779F76EDBB@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A82049B8-B1B5-4234-BCFA-55779F76EDBB@nvidia.com>

On Mon, May 12, 2025 at 12:35:39PM -0400, Zi Yan wrote:
> On 12 May 2025, at 12:16, Lorenzo Stoakes wrote:
> 
> > +cc Zi
> >
> > Hi Marc,
> >
> > I noticed this same bug as reported in [0], but only for a _very_ recent
> > patch series by Zi, which is only present in mm-new, which is the most
> > unstable mm branch right now :)
> >
> > So I wonder if related or a coincidence caused by something else?
> 
> Unless Marc's branch has my "make MIGRATE_ISOLATE a standalone bit" patchset,
> it should be caused by something else.
> 
> A bisect would be very helpful.
> 
> >
> > This is triggered by the mm self-test (in tools/testing/selftests/mm, you
> > can just make -jXX there) transhuge-stress, invoked as:
> >
> > $ sudo ./transhuge-stress -d 20
> >
> > The stack traces do look very different though so perhaps unrelated?
> 
> The warning is triggered, in the both cases, a pageblock with MIGRATE_UNMOVABLE(0)
> is moved to MIGRATE_RECLAIMABLE(2). The pageblock is supposed to have
> MIGRATE_RECLAIMABLE(2) before the movement.

The weird thing is that the warning is from expand(), when the broken
up chunks are put *back*. Marc, can you confirm that this is the only
warning in dmesg, and there aren't any before this one?

The request does the following:

  rmqueue_bulk()
    __rmqueue()
      __rmqueue_smallest()
        page_del_and_expand()
          __del_page_from_free_list()
            VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
                         "page type is %lu, passed migratetype is %d (nr=%d)\n",
                         get_pageblock_migratetype(page), migratetype, nr_pages);
         expand()
           __add_to_free_list()
             VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
                          "page type is %lu, passed migratetype is %d (nr=%d)\n",
                          get_pageblock_migratetype(page), migratetype, nr_pages);

So if only the second one triggers, but not the first one, it suggests
we have a buddy page consisting of two pageblocks of different types -
the first one reclaimable and the second unmovable. When we take the
headpage off, the type matches. When we put the remainder from the
tailblock back, it doesn't.
