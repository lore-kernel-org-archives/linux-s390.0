From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 03 Jun 2015 12:27:37 +0000
Subject: Re: [PATCH] s390 keyboard: Avoid off-by-one when using strnlen_user()
Message-Id: <20150603122737.GA22721@osiris>
In-Reply-To: <20150603084742.GD13054@quack.suse.cz>
References: <20150603084742.GD13054@quack.suse.cz>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jun 03, 2015 at 10:47:42AM +0200, Jan Kara wrote:
> On Wed 03-06-15 09:50:30, Martin Schwidefsky wrote:
> > On Tue,  2 Jun 2015 17:07:33 +0200
> > Jan Kara <jack@suse.cz> wrote:
> > 
> > > strnlen_user() returns the length of the string including terminating 0.
> > > So avoid counting it again and unnecessarily reducing maximum string
> > > size by 1.
> > > 
> > > CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
[...]
> > 
> > The simplification with the string length is nice but removing
> > the explicit NUL termination is imho a mistake. Who guarantees
> > you that the string in user space is still the same after the
> > initial strnlen_user? It might have changed before the
> > copy_from_user call and then we end up with an unterminated
> > string in the kernel. Not good.
> Ah, that's a good point. Thanks for catching this. But it would deserve
> a comment in the code. Attached is an updated patch.

Nice ;) I applied your updated patch instead.

Thanks!
