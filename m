From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 02 May 2017 11:02:55 +0000
Subject: Re: ftrace breaks with modules disabled.
Message-Id: <20170502110255.GA4373@osiris>
In-Reply-To: <CAOS_Y6SgJEHxM8LewKgXXDD3TT4FzxW1Gtb2swZ2Yp8mF_e=rw@mail.gmail.com>
References: <CAOS_Y6SgJEHxM8LewKgXXDD3TT4FzxW1Gtb2swZ2Yp8mF_e=rw@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 01, 2017 at 04:47:23PM -0500, Rob Landley wrote:
> arch/s390/built-in.o: In function `ftrace_plt_init':
> arch/s390/kernel/ftrace.o:(.init.text+0x34cc): undefined reference to
> `module_alloc'
> 
> Need a .config or is that enough?

The patch below will fix that. Thanks for reporting!
