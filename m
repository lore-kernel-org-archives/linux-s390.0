Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719C8C83F01
	for <linux-s390@archiver.kernel.org>; Thu, 31 Aug 2023 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346392AbjHaOtu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 31 Aug 2023 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbjHaOtt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 31 Aug 2023 10:49:49 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D41B1
        for <linux-s390@vger.kernel.org>; Thu, 31 Aug 2023 07:49:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5921a962adfso10500287b3.1
        for <linux-s390@vger.kernel.org>; Thu, 31 Aug 2023 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693493385; x=1694098185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/APbOv9kn/U7e/ns21d/zj9IRn9BxSLxyOC3Vac5jA=;
        b=Vfz0ZFK/PLoBG8Ua4HRwpeqPHR9nJCpDvOdN5aCNcjoZg34oZODvP8he1wMWrYYQp1
         IKvvq3iIqlpgsCjbDPRzoaOxFkO71T4o/WQdb/al2nq6wxvHyXPjwD5pdOkg7C1y2796
         y7xW3e6L/7asru9qiy5oZrkKoqq8zBRLe16fjrUsVSbGt8UqhweloxOz0GEqioxotiAR
         blsaKRVeV2+/pplVzCbiGZzqntp+cJIw7BGmcLYx3AH2UZgdOwhmkUXzupbIKFli9xIv
         Bsc8S2ng3Nnp0JgL1NKC90fVtmOqXiPs99hiOY/h3CfotODKATLhtqGIesWlArW3AJrE
         AXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493385; x=1694098185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/APbOv9kn/U7e/ns21d/zj9IRn9BxSLxyOC3Vac5jA=;
        b=cUV7x2ja33nqxeanYX/GCo+9A2b1zJNo8gkOTeTCd4X0mJuIauuoqmnLI7lJVcu+sO
         QVDHF+KgfsPHyHZU2BuCAUv+qfTNGQamhPXZ0oLN0JMCwPwaxnEKulIpASvr3prtdppj
         vs0XTDQ5AVh73ISDa2fHTLQYUYO968/bEQ/Z49+uir7ufLtWXKrd6XEBxTXuQLrgw3HF
         GKyn48IFuBPsl5/7vc1MfGwrDjC/g8qYr3BdvlkJTMHIQdwewvHBRckDCcSdl0CbYA90
         OS33k1Y2L/ZY9K8Q34BzqWoBCWBw+OYKXvS6wnO9qbQQ2woLbOj0carb7J/8QgYLRW2q
         uWFA==
X-Gm-Message-State: AOJu0YypZwClr90o/acb/JTIOFSc7smZjEVy9LDrKDrnBLFgjVHH/1MJ
        +JFkabIeHR9RtY3TsFqZwj5mYXvbTfntRNqMGgoe
X-Google-Smtp-Source: AGHT+IE/2fXLwQ9H7wEmtmgLdkuJ4AeHMRse2N+C6r3s29gq3FRpbwQgKSdFooDdXmNPdgn6h1+zBKFcbTffYssmlJI=
X-Received: by 2002:a81:a153:0:b0:57a:6bf0:2100 with SMTP id
 y80-20020a81a153000000b0057a6bf02100mr5764469ywg.1.1693493385129; Thu, 31 Aug
 2023 07:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230831053157.256319-1-hch@lst.de> <20230831-dazulernen-gepflanzt-8a64056bf362@brauner>
 <20230831-tiefbau-freuden-3e8225acc81d@brauner> <20230831123619.GB11156@lst.de>
 <20230831-wohlig-lehrveranstaltung-7c27e05dc9ae@brauner> <CAHC9VhQOpy=rLNmirT7afkEdf5_PRnLVsdPJQvxqaF0G4JrCgQ@mail.gmail.com>
 <20230831143947.GA16365@lst.de>
In-Reply-To: <20230831143947.GA16365@lst.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Aug 2023 10:49:34 -0400
Message-ID: <CAHC9VhSn7Vt7KgNE9UZvfNSD2y8_HVXy96sco=jET+7LhxQUfg@mail.gmail.com>
Subject: Re: sb->s_fs_info freeing fixes
To:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 31, 2023 at 10:39=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> On Thu, Aug 31, 2023 at 10:38:09AM -0400, Paul Moore wrote:
> > No need to change anything in this case, but in the future if there
> > are no patch dependency or ordering issues can you let me take the
> > SELinux patches via the SELinux tree?  It helps prevent merge
> > conflicts during the next merge window and quiets the daily automated
> > checks I have in place to detect SELinux changes outside of the
> > SELinux tree.
>
> Even if this goes into the next merge window we'd need it in the vfs
> tree as it is preparation for other work on VFS interfaces.

That's fine, I would consider that part of the "patch dependency" case
I mentioned above.

My motivation for commenting on this is that I've seen a few recent
cases where some other subsystems have been quick to merge SELinux,
etc. patches and I just wanted to ask that some consideration be made
as it causes us (me) some level of pain.  If there is a good reason
for it, that's fine, being a maintainer is a life of pain ;) but if it
is simply to just get the patch merged into an upstream tree a day or
two earlier I would please ask you to exercise patience and let it be
merged via the appropriate tree.

--=20
paul-moore.com
