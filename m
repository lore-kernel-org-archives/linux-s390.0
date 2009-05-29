From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 29 May 2009 08:38:35 +0000
Subject: Re: Problem with exit status auditing of execve syscall
Message-Id: <20090529083835.GA5301@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20090529005942.GA14017@suse.de>
References: <20090529005942.GA14017@suse.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 28, 2009 at 05:59:42PM -0700, Tony Jones wrote:
> Anyone have any idea on what is causing the following:
> 
> # auditctl -e 1
> # auditctl -a entry,always -S execve
> # /bin/true
> 
> Causes the following to be logged in /var/log/audit/audit.log
> 
> type=SYSCALL msg=audit(1243557456.840:32): arch=80000016 syscall=11 per=400000 success=yes exit=11 ...
> 
> Specific to S390 and the execve syscall. I looked through the arch code but 
> I'm not seeing why on the exec case the exit code contains the syscall#.
> 
> Above reproduced on 2.6.30-rc7-git2.

The return value of execve on success is not defined.

If it succeeds s390 does not return the return value of the system call.
Instead it returns whatever is contained in the current pt_regs structure
on the kernel stack that belongs to user space.
The pt_regs structure was changed by the load_binary handler that belongs
to the exec format of the executed file. If the ABI of an exec format would
require a special return value in r2 it wouldn't be good if we would
overwrite it with 0 on success of execve.

In any case, this isn't bug.
