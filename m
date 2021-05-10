Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8658BC433B4
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5169D61448
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEJQRU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 May 2021 12:17:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42380 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhEJQRS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 May 2021 12:17:18 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lg8Zi-003wZY-PY; Mon, 10 May 2021 10:16:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lg8Zg-0006F8-2L; Mon, 10 May 2021 10:16:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210508122530.1971-1-justin.he@arm.com>
        <20210508122530.1971-2-justin.he@arm.com>
        <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
        <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
        <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
        <YJdG8LhKBoFayOc+@zeniv-ca.linux.org.uk>
Date:   Mon, 10 May 2021 11:16:00 -0500
In-Reply-To: <YJdG8LhKBoFayOc+@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Sun, 9 May 2021 02:20:32 +0000")
Message-ID: <m18s4mzhrz.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lg8Zg-0006F8-2L;;;mid=<m18s4mzhrz.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/yBPTimQoWRMQi9KZ501san+bfHriGOc0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
>
> Another thing that keeps bugging me about prepend_path() is the
> set of return values.  I mean, 0/1/2/3/-ENAMETOOLONG, and all
> except 0 are unlikely?  Might as well make that 0/1/2/3/-1, if
> not an outright 0/1/2/3/4.  And prepend() could return bool, while
> we are at it (true - success, false - overflow)...

I remember seeing that the different callers of prepend_path treated
those different cases differently.

But now that I look again the return value 3 (escaped) gets lumped
together with 2(detached).


On second look it appears that the two patterns that we actually have
are basically:

char *__d_path(const struct path *path,
	       const struct path *root,
	       char *buf, int buflen)
{
	error = prepend_path(path, root, &res, &buflen);

	if (error < 0)
		return ERR_PTR(error);
	if (error > 0)
		return NULL;
	return res;
}

char *d_absolute_path(const struct path *path,
	       char *buf, int buflen)
{
	error = prepend_path(path, &root, &res, &buflen);

	if (error > 1)
		error = -EINVAL;
	if (error < 0)
		return ERR_PTR(error);
	return res;
}

With d_absolute_path deciding that return value 1 absolute is not an
error.

That does look like there is plenty of room to refactor and make things
clearer.


Eric




