From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Wed, 31 Jan 2018 09:33:06 +0000
Subject: Re: [man-pages PATCH 2/5] s390_runtime_instr.2: document the removal of the second argument
Message-Id: <CACGkJdueeAu9Xj3NqxgUE5Bmhwj1CDcwUWGZcHioy=KitiAv2g@mail.gmail.com>
In-Reply-To: <CACGkJdu7cLwe5UUtg_Gk5G=UrVxjWvDTOwL-LEn1w1wsUsMhMw@mail.gmail.com>
References: <CACGkJdu7cLwe5UUtg_Gk5G=UrVxjWvDTOwL-LEn1w1wsUsMhMw@mail.gmail.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 31, 2018 at 7:20 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Mon, Jan 22, 2018 at 01:16:25PM +0000, Eugene Syromyatnikov wrote:
>> On Sat, Jan 20, 2018 at 11:41 AM, Heiko Carstens
>> <heiko.carstens@de.ibm.com> wrote:
>> > If you now document the above people will start using the system call with
>> > only one parameter which isn't backwards compatible.
>> >
>> > I'd rather add the second parameter again to the system call so that code
>> > stays backwards compatible.
>>
>> Well, it ought to be documented somehow, especially if the syscall
>> parameter will be added back, as there could be situation where
>> application gets successful return code for the call non-zero value of
>> the second argument and gets no signals as it is the one of the kernel
>> releases where this parameter was removed. I can update the patch to
>> reflect this once the patch that returns the second argument reaches
>> the kernel tree.
>
> So, I think something like the below should be ok:
>
> From 6c7e2113c62fbb95662fba03f7fa298f4b737c1f Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Wed, 31 Jan 2018 08:15:31 +0100
> Subject: [PATCH] s390_runtime_instr.2: document signum argument behavior
>  change
>
> Document that the signum argument is ignored in newer kernels, but
> that user space should pass a valid real-time signal number for
> backwards compatibility.
>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  man2/s390_runtime_instr.2 | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/man2/s390_runtime_instr.2 b/man2/s390_runtime_instr.2
> index 18c2c0763eed..d5790e10f222 100644
> --- a/man2/s390_runtime_instr.2
> +++ b/man2/s390_runtime_instr.2
> @@ -47,10 +47,9 @@ argument controls whether run-time instrumentation is started
>  .PP
>  The
>  .IR signum
> -argument specifies the number of a real-time signal.
> -The real-time signal is sent to the thread if the run-time instrumentation
> -buffer is full or if the run-time-instrumentation-halted interrupt
> -occurred.
> +argument specifies the number of a real-time signal. This argument has no
> +effect, since support for signalling was never used and kernel support was
> +removed.
>  .SH RETURN VALUE
>  On success,
>  .BR s390_runtime_instr ()
> @@ -67,9 +66,16 @@ is set to one of the error codes listed below.
>  .B EINVAL
>  The value specified in
>  .IR command
> -is not a valid command or the value specified in
> +is not a valid command.
> +.TP
> +.B EINVAL
> +The value specified in
>  .IR signum
> -is not a real-time signal number.
> +is not a real-time signal number. With Linux 4.4 and newer kernel versions,
> +the
> +.IR signum
> +argument has no effect, so that an invalid signal number will not result in an
> +error.
>  .TP
>  .B ENOMEM
>  Allocating memory for the run-time instrumentation control block failed.
> @@ -85,6 +91,12 @@ The run-time instrumentation facility is available beginning with System z EC12.
>  Glibc does not provide a wrapper for this system call, use
>  .BR syscall (2)
>  to call it.
> +.PP
> +Support for signalling was removed with Linux 4.4. With Linux 4.4
> +also the check if
> +.IR signum
> +is a valid real-time signal was removed. For backwards compatibility with old
> +kernels it is recommended to pass a valid real-time signal number.
>  .SH SEE ALSO
>  .BR syscall (2),
>  .BR signal (7)
> --
> 2.13.5
>

Acked-by: Eugene Syromyatnikov <evgsyr@gmail.com>

-- 
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}
