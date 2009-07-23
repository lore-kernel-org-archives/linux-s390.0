From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2009 09:50:11 +0000
Subject: Re: [Fwd: [Bug] 2.6.30 kernel stack trace with 'fsfuzzer ext3' on
Message-Id: <20090723095003.GA5029@linux.vnet.ibm.com>
In-Reply-To: <20090722095000.GA19072@duck.suse.cz>
References: <20090722095000.GA19072@duck.suse.cz>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* Jan Kara <jack@suse.cz> [2009-07-22 11:50:00]:

> On Wed 22-07-09 10:42:52, Nageswara R Sastry wrote:
> > Hi Jan,
> >
> > >My first guess would be that journal superblock was corrupted by
> > >fsfuzzer so that the journal had less than 32 blocks and the warning
> > >triggered. That being said, we might use more sanity checks when loading
> > >journal superblock because currently it just blindly consumes what's on
> > >disk. We can't do too much since we don't know anything about the
> > >filesystem structure but we can do at least something. I'll write a
> > >patch for that in a moment...
> >
> > Any updates on this. Thanks!!
>   I have a patch queued for this in my patch queue and will ask Linus for
> merging it probably tomorrow. Similar JBD2 fix is in the Ted's patch queue
> also waiting for being merged. I'm also attaching the fix for your
> convenience.

Thanks, the patch fixes the warning.

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.cz>
> SUSE Labs, CR

> From 7447a668a3860b66b3c9db86fdea91e355ba59ac Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 15 Jul 2009 20:36:08 +0200
> Subject: [PATCH 1/5] jbd: Fail to load a journal if it is too short
> 
> Due to on disk corruption, it can happen that journal is too short. Fail
> to load it in such case so that we don't oops somewhere later.
> 
  Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/jbd/journal.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
> index 737f724..94a64a1 100644
> --- a/fs/jbd/journal.c
> +++ b/fs/jbd/journal.c
> @@ -848,6 +848,12 @@ static int journal_reset(journal_t *journal)
> 
>  	first = be32_to_cpu(sb->s_first);
>  	last = be32_to_cpu(sb->s_maxlen);
> +	if (first + JFS_MIN_JOURNAL_BLOCKS > last + 1) {
> +		printk(KERN_ERR "JBD: Journal too short (blocks %lu-%lu).\n",
> +		       first, last);
> +		journal_fail_superblock(journal);
> +		return -EINVAL;
> +	}
> 
>  	journal->j_first = first;
>  	journal->j_last = last;
> -- 
> 1.6.0.2
> 

			
					Kamalesh
