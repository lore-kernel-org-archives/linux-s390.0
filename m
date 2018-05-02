From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Wed, 02 May 2018 11:54:58 +0000
Subject: Re: [man-pages PATCH v2 3/4] s390_sthyi.2: some minor additions
Message-Id: <8ecf0082-43c3-713c-9462-dc3951d5211e@gmail.com>
In-Reply-To: <20180414164346.GA15273@asgard.redhat.com>
References: <20180414164346.GA15273@asgard.redhat.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Eugene,

On 04/14/2018 06:43 PM, Eugene Syromyatnikov wrote:
> * man2/s390_sthyi.2 (.SH DESCRIPTION): Document the size of the
> resp_buffer when function_code is 0.
> (.SH NOTES): Document various aspects of the current implementation (the
> lifted requirement for the response buffer alignment, the presence of in-kernel
> cache), add description for the documentation URL.
> 
> Co-Authored-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>

Thanks. Patch applied.

Cheers,

Michael


> ---
>  man2/s390_sthyi.2 | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/man2/s390_sthyi.2 b/man2/s390_sthyi.2
> index fb77195..d13aace 100644
> --- a/man2/s390_sthyi.2
> +++ b/man2/s390_sthyi.2
> @@ -53,6 +53,9 @@ capacity information.
>  The
>  .I resp_buffer
>  argument specifies the address of a response buffer.
> +When the
> +.I function_code
> +is 0, it has to be one page (4K) in size.
>  If the system call returns 0,
>  the response buffer will be filled with CPU capacity information.
>  Otherwise, the response buffer's content is unchanged.
> @@ -126,6 +129,14 @@ to call it.
>  .PP
>  For details of the STHYI instruction, see
>  .UR https://www.ibm.com\:/support\:/knowledgecenter\:/SSB27U_6.3.0\:/com.ibm.zvm.v630.hcpb4\:/hcpb4sth.htm
> +the documentation page
>  .UE .
> +.PP
> +When the system call interface is used, the response buffer doesn't
> +have to fulfill alignment requirements described in the STHYI
> +instruction definition.
> +.PP
> +The kernel caches the response (for up to one second, as of Linux 4.16).
> +Subsequent system call invocations may return the cached response.
>  .SH SEE ALSO
>  .BR syscall (2)
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
