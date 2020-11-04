Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbgKDHCK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Nov 2020 02:02:10 -0500
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in
 inode_doinit_with_dentry()
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
        <20201009013630.6777-1-rentianyue@tj.kylinos.cn>
        <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
        <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
        <yt9dh7q64m8a.fsf@linux.ibm.com>
        <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
        <yt9dpn4u9scs.fsf@linux.ibm.com>
        <CAHC9VhRxm=YR1yBy8fnWPXRZ48pq4MA4b26YAtqAJORJZD61wg@mail.gmail.com>
Date: Wed, 04 Nov 2020 08:01:46 +0100
In-Reply-To: <CAHC9VhRxm=YR1yBy8fnWPXRZ48pq4MA4b26YAtqAJORJZD61wg@mail.gmail.com>
        (Paul Moore's message of "Tue, 3 Nov 2020 21:42:35 -0500")
Message-ID: <yt9dpn4twqp1.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: rentianyue@tj.kylinos.cn, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn, selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>, linux-s390@vger.kernel.org, hca@linux.ibm.com, borntraeger@de.ibm.com

Hi Paul,

Paul Moore <paul@paul-moore.com> writes:

> On Tue, Nov 3, 2020 at 2:02 PM Sven Schnelle <svens@linux.ibm.com> wrote:
>> Thanks for the patch. Unfortunately it doesn't seem to change anything
>> for me. I can take a look into this tomorrow, but i don't know much
>> about the internals of selinux, so i'm not sure whether i'm of much help.
>
> I'm sorry that patch didn't work out.  I just spent some more time
> looking at the code+patch and the only other thing that I can see is
> that if we mark the isec invalid, we don't bother setting the
> isec->sid value to whatever default we may have already found.  In a
> perfect world this shouldn't matter, but if for whatever reason the
> kernel can't revalidate the inode's label when it tries later it will
> fallback to that default isec->sid.
>
> I'm sorry to ask this again, but would you be able to test the attached patch?

This patch fixes the issue. So it looks like your assumption is right.

Thanks
Sven
