From: Nathan Lynch <nathanl@austin.ibm.com>
Date: Wed, 11 Nov 2009 21:53:48 +0000
Subject: Re: [PATCH 1/1] implement s390 clone_with_pids syscall
Message-Id: <1257976428.7132.1465.camel@localhost.localdomain>
In-Reply-To: <20091111203739.GD8761@us.ibm.com>
References: <20091111203739.GD8761@us.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2009-11-11 at 14:37 -0600, Serge E. Hallyn wrote:
> Quoting Nathan Lynch (nathanl@austin.ibm.com):
> > Something I missed earlier is that the stack_size you are passing in
> > from user space is not actually the size of the stack.  It's adjusted to
> > account for arguments that have been placed at the end of the stack
> > region.  So stack_size becomes a value that you want the kernel to add
> > to stack_base to get the desired stack pointer value in the child --
> > it's not a size at all.  At this point we may as well communicate the
> > desired stack pointer value directly (which could be denoted by
> > stack_size == 0, or we could add another member to clone_args), or
> > rename stack_size to stack_offset or similar.
> 
> So do I understand correctly that the agreement (reached on irc) is
> to keep passing in a stack_size, but enforce that it ==0 for all but
> ia64?

That is the approach I prefer.
