From: Paul Moore <pmoore@redhat.com>
Date: Wed, 11 Nov 2015 01:05:27 +0000
Subject: Re: [PATCH] arch: update s390/s390x system call tables
Message-Id: <1517038.OukBcdHVGW@sifl>
In-Reply-To: <1447071339-36522-2-git-send-email-heiko.carstens@de.ibm.com>
References: <1447071339-36522-2-git-send-email-heiko.carstens@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Monday, November 09, 2015 01:15:39 PM Heiko Carstens wrote:
> s390 and s390x gained quite a few new system calls:
> - numa related system calls
> - the separated socket system calls
> - two more s390 specific pci mmio system calls
> 
> All architectures got the new membarrier and userfaultfd system calls.
> 
> This patch updates the s390 specific system call tables and updates other
> architectures where needed.
> 
> Also remove some extra whitespace from the s390 specific system call tables.
> 
> Both 'make check' and './regression -T live' still work for s390 and s390x
> after this update.

Thanks for the patch, I'm still reviewing it so it's not yet merged (got 
tangled up in some other 4.3 related updates) but I didn't want you to think I 
was ignoring you.

-- 
paul moore
security @ redhat
