Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Apr 2017 21:42:11 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/1] perf/urgent annotate s390 fix
Message-ID: <20170411194211.GA14431@gmail.com>
References: <20170411160344.1081-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411160344.1081-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> The following changes since commit a01851faab4b485e94c2ceaa1d0208a8d16ce367:
> 
>   Merge tag 'perf-urgent-for-mingo-4.11-20170317' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-03-17 15:13:28 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.11-20170411
> 
> for you to fetch changes up to 3c1a427954399fd1bda1ee7e1b356f47b61cee74:
> 
>   perf annotate s390: Fix perf annotate error -95 (4.10 regression) (2017-04-07 12:33:10 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent annotate fix for s390:
> 
> - The move to support cross arch annotation introduced per arch
>   initialization requirements, fullfill them for s/390 (Christian Borntraeger)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       perf annotate s390: Fix perf annotate error -95 (4.10 regression)
> 
>  tools/perf/util/annotate.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Pulled, thanks Arnaldo!

	Ingo
