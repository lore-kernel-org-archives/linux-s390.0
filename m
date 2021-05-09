Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80174C433B4
	for <linux-s390@archiver.kernel.org>; Sun,  9 May 2021 22:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A8C61107
	for <linux-s390@archiver.kernel.org>; Sun,  9 May 2021 22:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhEIW7k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 9 May 2021 18:59:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59514 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEIW7k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 9 May 2021 18:59:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lfsNX-00Bfev-Eb; Sun, 09 May 2021 16:58:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lfsNW-0007E1-CE; Sun, 09 May 2021 16:58:27 -0600
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210508122530.1971-1-justin.he@arm.com>
        <20210508122530.1971-2-justin.he@arm.com>
        <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
        <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
        <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
        <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
        <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
        <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
        <YJcbkJxrFAheQ5yO@zeniv-ca.linux.org.uk>
Date:   Sun, 09 May 2021 17:58:22 -0500
In-Reply-To: <YJcbkJxrFAheQ5yO@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Sat, 8 May 2021 23:15:28 +0000")
Message-ID: <m1r1ifzf8x.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lfsNW-0007E1-CE;;;mid=<m1r1ifzf8x.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19tSme8j0LKpThFXtoRB35Tb0qwDIZQAOo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sat, May 08, 2021 at 10:46:23PM +0000, Al Viro wrote:
>> On Sat, May 08, 2021 at 03:17:44PM -0700, Linus Torvalds wrote:
>> > On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> > >
>> > > On Sat, May 08, 2021 at 01:39:45PM -0700, Linus Torvalds wrote:
>> > >
>> > > > +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)
>> > >
>> > > If anything, s/path/dentry/, since vfsmnt here will be equal to &mnt->mnt all along.
>> > 
>> > Too subtle for me.
>> > 
>> > And is it? Because mnt is from
>> > 
>> >      mnt = real_mount(path->mnt);
>> > 
>> > earlier, while vfsmount is plain "path->mnt".
>> 
>> static inline struct mount *real_mount(struct vfsmount *mnt)
>> {
>>         return container_of(mnt, struct mount, mnt);
>> }
>
> Basically, struct vfsmount instances are always embedded into struct mount ones.
> All information about the mount tree is in the latter (and is visible only if
> you manage to include fs/mount.h); here we want to walk towards root, so...
>
> Rationale: a lot places use struct vfsmount pointers, but they've no need to
> access all that stuff.  So struct vfsmount got trimmed down, with most of the
> things that used to be there migrating into the containing structure.
>
> [Christian Browner Cc'd]
> BTW, WTF do we have struct mount.user_ns and struct vfsmount.mnt_userns?
> Can they ever be different?  Christian?

I presume you are asking about struct mnt_namespace.user_ns and
struct vfsmount.mnt_userns.

That must the idmapped mounts work.

In short mnt_namespace.user_ns is the user namespace that owns
the mount namespace.

vfsmount.mnt_userns functionally could be reduced to just some struct
uid_gid_map structures hanging off the vfsmount.  It's purpose is
to add a generic translation of uids and gids on from the filesystem
view to the what we want to show userspace.

That code could probably benefit from some refactoring so it is clearer,
and some serious fixes.  I reported it earlier but it looks like there
is some real breakage in chown if you use idmapped mounts.

Eric
