From: Philipp Rudo <prudo@linux.ibm.com>
Date: Mon, 28 May 2018 11:09:37 +0000
Subject: Re: [PATCH] kexec/s390: Add support for kexec_file_load
Message-Id: <20180528130937.76e32ce0@ThinkPad>
In-Reply-To: <20180522081104.calxgxzxel4fqh6j@verge.net.au>
References: <20180522081104.calxgxzxel4fqh6j@verge.net.au>
To: linux-s390@vger.kernel.org, kexec@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 22 May 2018 10:11:04 +0200
Simon Horman <horms@verge.net.au> wrote:

> On Mon, May 21, 2018 at 02:24:40PM +0800, Dave Young wrote:
> > On 05/16/18 at 02:27pm, Philipp Rudo wrote:  
> > > Since kernel 4.17-rc2 s390 supports the kexec_file_load system call. Add
> > > the new system call to kexec-tools and provide the -s (--kexec-file-syscall)
> > > option for s390 to support this new feature.
> > > 
> > > Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>  
> 
> ...
> 
> > Acked-by: Dave Young <dyoung@redhat.com>  
> 
> Thanks, applied.
> 

Sorry for the late answer, I had the last week off.
Nevertheless thanks to both of you.

Philipp
