From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 01 Sep 2008 09:11:03 +0000
Subject: Re: [PATCH] s390: use sys_pause for 31bit pause entry point
Message-Id: <1220260263.20063.6.camel@localhost>
In-Reply-To: <20080901030225.GA10514@lst.de>
References: <20080901030225.GA10514@lst.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-09-01 at 05:02 +0200, Christoph Hellwig wrote:
> sys32_pause is a useless copy of the generic sys_pause.                         
> 
> (and it's certainly not there for old sparc32 binaries..)

Added to the git390 queue. Thanks Christoph.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
