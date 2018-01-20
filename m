From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Sat, 20 Jan 2018 12:23:49 +0000
Subject: Re: [man-pages PATCH 5/5] man2: describe s390_guarded_storage s390-specific system call
Message-Id: <20180120122349.GE6287@osiris>
In-Reply-To: <20180114185643.GA23919@asgard.redhat.com>
References: <20180114185643.GA23919@asgard.redhat.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jan 14, 2018 at 07:56:43PM +0100, Eugene Syromyatnikov wrote:
> ---
>  man2/s390_guarded_storage.2 | 150 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 man2/s390_guarded_storage.2
> 
> diff --git a/man2/s390_guarded_storage.2 b/man2/s390_guarded_storage.2
> +.B GS_ENABLE
> +Enable the guarded storage facility for the current task.
> +The initial content of the guarded storage control block will be all zeros.
> +After the enalement, the user space code can use the "Load Guarded Storage

enablement

> +.SH ERRORS
> +.TP
> +.B EFAULT
> +.I command
> +was
> +.BR GS_SET_BC_CB
> +and the copying of the guarded storage control block structure pointed by the
> +.I gs_cb
> +argument has failed.
> +.TP
> +.B EINVAL
> +The value of
> +.I command
> +is not recognised.

Maybe: "The value specified for command is not a valid command." ?

> +.B EOPNOTSUPP
> +The guarded storage is not supported by the hardware.

"The guarded storage facility is not available."

Thanks for providing the man page!
