Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42644 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727688AbgKCTC3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 14:02:29 -0500
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in
 inode_doinit_with_dentry()
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
        <20201009013630.6777-1-rentianyue@tj.kylinos.cn>
        <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
        <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
        <yt9dh7q64m8a.fsf@linux.ibm.com>
        <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
Date: Tue, 03 Nov 2020 20:02:11 +0100
In-Reply-To: <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
        (Paul Moore's message of "Tue, 3 Nov 2020 12:11:08 -0500")
Message-ID: <yt9dpn4u9scs.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: rentianyue@tj.kylinos.cn, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn, selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>, linux-s390@vger.kernel.org, hca@linux.ibm.com, borntraeger@de.ibm.com

Hi Paul,

Paul Moore <paul@paul-moore.com> writes:

> On Tue, Nov 3, 2020 at 8:14 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>>
>> > On Thu, Oct 8, 2020 at 9:37 PM <rentianyue@tj.kylinos.cn> wrote:
>> >> From: Tianyue Ren <rentianyue@kylinos.cn>
>> >>
>> >> Mark the inode security label as invalid if we cannot find
>> >> a dentry so that we will retry later rather than marking it
>> >> initialized with the unlabeled SID.
>> >>
>> >> Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
>> >> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
>> >> ---
>> >>  security/selinux/hooks.c | 19 ++++++++++++++++---
>> >>  1 file changed, 16 insertions(+), 3 deletions(-)
>> >
>> > Merged into selinux/next with some minor tweaks to the comments.
>> > Thanks for your help!
>>
>> This seems to break booting on s390:
>>
>> Welcome to Fedora 32 (Thirty Two)!
>>
>> [    1.434571] systemd[1]: Set hostname to <xxx.xxx>
>> [    1.436839] audit: type=1400 audit(1604408868.681:4): avc:  denied  { write } for  pid=1 comm="systemd" dev="cgroup2" ino=2 scontext=system_u:sys
>> tem_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0
>> [    1.436840] systemd[1]: Failed to create /init.scope control group: Permission denied
>> [    1.438039] systemd[1]: Failed to allocate manager object: Permission denied
>> [ [0;1;31m!!!!!! [0m] Failed to allocate manager object.
>> [    1.438281] systemd[1]: Freezing execution.
>>
>> Any ideas? If i revert 83370b31a915493231e5b9addc72e4bef69f8d31 from
>> linux-next-20201103 it works fine...
>
> Thanks for the report.
>
> Looking at this again, I'm thinking that setting the isec->initialized
> field outside of the spinlock is probably a bad idea.  My guess is
> that your system is racing on inode_doinit_with_dentry() and the
> initialized field is getting messed up.
>
> Any chance you could try the attached (completely untested) patch?

Thanks for the patch. Unfortunately it doesn't seem to change anything
for me. I can take a look into this tomorrow, but i don't know much
about the internals of selinux, so i'm not sure whether i'm of much help.

Regards
Sven
