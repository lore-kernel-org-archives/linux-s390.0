From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 16 Jun 2017 11:09:18 +0000
Subject: Re: Garbage results for system time from getrusage on 4.11
Message-Id: <20170616110918.GA19736@osiris>
In-Reply-To: <87zida3gyf.fsf@oldenburg.str.redhat.com>
References: <87zida3gyf.fsf@oldenburg.str.redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jun 14, 2017 at 02:13:28PM +0200, Florian Weimer wrote:
> Occasionally, when using the ���time��� bash built-in, I get bogus output,
> like this:
> 
> real    0m34.671s
> user    0m24.755s
> sys     .+(.0*-)m,/.222s
> 
> real    0m23.049s
> user    0m15.599s
> sys     153122387m27.677s
> 
> This is not corruption caused by concurrently running programs, it's
> actually what bash prints, as shown by strace:

...

> I see this with kernel-4.11.0-2.fc26.s390x from Fedora.  This could be a
> regression because I have never noticed it before when running the glibc
> testsuite under earlier kernels.

Thank you for the bug report. This should have been fixed with git commit
07a63cbe8bcb ("s390/cputime: fix incorrect system time"). This has only
been recently merged and is marked for stable kernel backports. With that
fix it seems to work.

commit 07a63cbe8bcb6ba72fb989dcab1ec55ec6c36c7e
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Tue May 2 13:36:00 2017 +0200

    s390/cputime: fix incorrect system time

    git commit c5328901aa1db134 "[S390] entry[64].S improvements" removed
    the update of the exit_timer lowcore field from the critical section
    cleanup of the .Lsysc_restore/.Lsysc_done and .Lio_restore/.Lio_done
    blocks. If the PSW is updated by the critical section cleanup to point to
    user space again, the interrupt entry code will do a vtime calculation
    after the cleanup completed with an exit_timer value which has *not* been
    updated. Due to this incorrect system time deltas are calculated.

    If an interrupt occured with an old PSW between .Lsysc_restore/.Lsysc_done
    or .Lio_restore/.Lio_done update __LC_EXIT_TIMER with the system entry
    time of the interrupt.

    Cc: stable@vger.kernel.org # 3.3+
    Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
