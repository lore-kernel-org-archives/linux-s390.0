Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 5 Jul 2019 14:28:38 +0200
From: Vasily Gorbik <gor@kernel.org>
Subject: Re: [PATCH 0/3] docs: s390: restore content and update s390dbf.rst
Message-ID: <your-ad-here.call-01562329718-ext-2264@work.hours>
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-doc@vger.kernel.org, linux-s390@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:19:46PM +0200, Steffen Maier wrote:
> This is based on top of the 3 s390 patches Heiko already queued on our
> s390 features branch.
> [("Re: [PATCH v3 00/33] Convert files to ReST - part 1")
>  https://www.spinics.net/lists/linux-doc/msg66137.html
>  https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/Documentation/s390?h=features]
> 
> If I was not mistaken, some documentation was accidentally lost
> and patch 1 restores it.
> 
> After having looked closer, I came up with patches 2 and 3.
> Rendered successfully on a current Fedora 30 and it looks good:
> $ make SPHINXDIRS="s390" htmldocs
> 
> Steffen Maier (3):
>   docs: s390: restore important non-kdoc parts of s390dbf.rst
>   docs: s390: unify and update s390dbf kdocs at debug.c
>   docs: s390: s390dbf: typos and formatting, update crash command
> 
>  Documentation/s390/s390dbf.rst | 390 +++++++++++++++++++++++++++++++++++++++--
>  arch/s390/include/asm/debug.h  | 112 ++----------
>  arch/s390/kernel/debug.c       | 105 +++++++++--
>  3 files changed, 473 insertions(+), 134 deletions(-)
> 
> -- 
> 1.8.3.1
> 
Applied, thanks.
