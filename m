Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D42EB64D8
	for <linux-s390@archiver.kernel.org>; Thu, 22 Jun 2023 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjFVRwC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjFVRv7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Jun 2023 13:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E68212E;
        Thu, 22 Jun 2023 10:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52E8618C7;
        Thu, 22 Jun 2023 17:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39581C433C0;
        Thu, 22 Jun 2023 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687456296;
        bh=ykRuz7LngeYf9k4H2/jZLkTOCoPE7zE6YA8bvgO+lec=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rKxrOmmxHMcoy5l/unX04R1ELvvouH2P3KFssr+UcL8TNHmwXRNpcr7EVFVurbcuA
         SriPObJSunG99QDrKJjCtg7pWHhsP08GLwrIz/CmGtcnC7o5Gwlufhpuik9g3IWW/N
         7hY2DCYjoM3DM7g2lsNJ1sBA66QUM6PTYp4nxdyOkhX85WN+k1G55ETfqvsW9vhnbt
         kudzhAOrgq+i3O3Fy/XQ7AbLPON3BgLObSajhYtm76VDZdWxt0x9MZpSfPK5UqeBTf
         fuPAylPVDeuR/P+oynbezTmSScG1QrlhRgGkfv54IUWIPhE6BZexuvXtG/1TAjWxzv
         +6NEuqr0Vf/iQ==
Message-ID: <468a895b93b83ed6369ea95519f832998a89d76f.camel@kernel.org>
Subject: Re: [PATCH 03/79] s390: switch to new ctime accessors
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jun 2023 13:51:33 -0400
In-Reply-To: <ZJSGVjryWEjbeW1U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230621144507.55591-1-jlayton@kernel.org>
         <20230621144735.55953-1-jlayton@kernel.org>
         <20230621144735.55953-2-jlayton@kernel.org>
         <ZJSGVjryWEjbeW1U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 2023-06-22 at 19:35 +0200, Alexander Gordeev wrote:
> On Wed, Jun 21, 2023 at 10:45:16AM -0400, Jeff Layton wrote:
>=20
> Hi Jeff,
> > In later patches, we're going to change how the ctime.tv_nsec field is
> > utilized. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  arch/s390/hypfs/inode.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> > index ee919bfc8186..30fa336ec63e 100644
> > --- a/arch/s390/hypfs/inode.c
> > +++ b/arch/s390/hypfs/inode.c
> > @@ -53,7 +53,7 @@ static void hypfs_update_update(struct super_block *s=
b)
> >  	struct inode *inode =3D d_inode(sb_info->update_file);
> > =20
> >  	sb_info->last_update =3D ktime_get_seconds();
> > -	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time=
(inode);
> > +	inode->i_atime =3D inode->i_mtime =3D inode_ctime_set_current(inode);
> >  }
> > =20
> >  /* directory tree removal functions */
> > @@ -101,7 +101,7 @@ static struct inode *hypfs_make_inode(struct super_=
block *sb, umode_t mode)
> >  		ret->i_mode =3D mode;
> >  		ret->i_uid =3D hypfs_info->uid;
> >  		ret->i_gid =3D hypfs_info->gid;
> > -		ret->i_atime =3D ret->i_mtime =3D ret->i_ctime =3D current_time(ret)=
;
> > +		ret->i_atime =3D ret->i_mtime =3D inode_ctime_set_current(ret);
> >  		if (S_ISDIR(mode))
> >  			set_nlink(ret, 2);
> >  	}
>=20
> I guess, inode_set_ctime() called from inode_ctime_set_current()
> updates i_ctime and is part of some other series?
>=20

No, that gets added in patch #1 of this series.

You should have gotten cc'ed on that one, though the postings to vger
mailing lists of patches 1, 2, and 79 bounced because the mail header
length on those was >8k.

--=20
Jeff Layton <jlayton@kernel.org>
