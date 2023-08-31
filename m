Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A1C83F32
	for <linux-s390@archiver.kernel.org>; Thu, 31 Aug 2023 12:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbjHaMgZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbjHaMgY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 31 Aug 2023 08:36:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227E1A4;
        Thu, 31 Aug 2023 05:36:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A7DB768BEB; Thu, 31 Aug 2023 14:36:19 +0200 (CEST)
Date:   Thu, 31 Aug 2023 14:36:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: sb->s_fs_info freeing fixes
Message-ID: <20230831123619.GB11156@lst.de>
References: <20230831053157.256319-1-hch@lst.de> <20230831-dazulernen-gepflanzt-8a64056bf362@brauner> <20230831-tiefbau-freuden-3e8225acc81d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831-tiefbau-freuden-3e8225acc81d@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 31, 2023 at 12:29:11PM +0200, Christian Brauner wrote:
> "Since ramfs/devpts uses get_tree_nodev() it doesn't rely on
> sb->s_fs_info. So there's no use after free risk as with other
> filesystems.
> 
> But there's no need to deviate from the standard cleanup logic and cause
> reviewers to verify whether that is safe or not."
> 
> and similar for the other two:
> 
> "Since hypfs/selinuxfs uses get_tree_single() it doesn't rely on
> sb->s_fs_info. So there's no use after free risk as with other
> filesystems.
> 
> But there's no need to deviate from the standard cleanup logic and cause
> reviewers to verify whether that is safe or not."
> 
> If that is good enough for people then I can grab it.

Fine with me.  And yes, I'd rather not have private data freed before
SB_ACTIVE is cleared even if it is fine right now.  It's just a bug
waiting to happen.
