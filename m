From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Wed, 02 May 2018 11:49:00 +0000
Subject: Re: [man-pages PATCH v2 1/4] s390_runtime_instr.2: add a note about runtime_instr.h availability
Message-Id: <767c0019-1a06-4357-90c3-14a3a771c95e@gmail.com>
In-Reply-To: <20180414164337.GA15097@asgard.redhat.com>
References: <20180414164337.GA15097@asgard.redhat.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Eugene,

On 04/14/2018 06:43 PM, Eugene Syromyatnikov wrote:
> * man2/s390_runtime_instr.2 (.SH NOTES): Note the version of the Linux
> kernel since which asm/runtime_inster.h header is available.
> 
> Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>

Thanks. Patch applied.

Cheers,

Michael


> ---
>  man2/s390_runtime_instr.2 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/man2/s390_runtime_instr.2 b/man2/s390_runtime_instr.2
> index 18c2c07..9ef293f 100644
> --- a/man2/s390_runtime_instr.2
> +++ b/man2/s390_runtime_instr.2
> @@ -85,6 +85,10 @@ The run-time instrumentation facility is available beginning with System z EC12.
>  Glibc does not provide a wrapper for this system call, use
>  .BR syscall (2)
>  to call it.
> +.PP
> +The header
> +.B asm/runtime_instr.h
> +is available since Linux 4.16.
>  .SH SEE ALSO
>  .BR syscall (2),
>  .BR signal (7)
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
