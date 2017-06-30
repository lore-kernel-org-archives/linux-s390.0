From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 30 Jun 2017 13:42:23 +0000
Subject: Re: [CRIU] [PATCH v2 07/17] s390: Fix clone() syscall parameters for s390
Message-Id: <CAJwJo6ZPXMF_Z1ZZ1xuP-syYq+qH9Eu=yEAzPaNmWJ7VW_0Mgw@mail.gmail.com>
In-Reply-To: <20170629192445.55580-8-holzheu@linux.vnet.ibm.com>
References: <20170629192445.55580-8-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, openvz-criu@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2017-06-29 22:24 GMT+03:00 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> On s390 the first two paramters are swapped because we use
> the CONFIG_CLONE_BACKWARDS2 kernel config option.
>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>

> ---
>  criu/util.c          | 5 +++++
>  test/zdtm/lib/test.c | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/criu/util.c b/criu/util.c
> index db484f2..2adc613 100644
> --- a/criu/util.c
> +++ b/criu/util.c
> @@ -1427,5 +1427,10 @@ pid_t fork()
>          * Two last arguments are swapped on different archs,
>          * but we don't care as they are zero anyway.
>          */
> +#ifdef __s390x__
> +       /* See kernel/fork.c: CONFIG_CLONE_BACKWARDS2 */
> +       return (pid_t)syscall(__NR_clone, 0, SIGCHLD, NULL, 0, NULL);
> +#else
>         return (pid_t)syscall(__NR_clone, SIGCHLD, 0, 0, 0, 0);
> +#endif
>  }
> diff --git a/test/zdtm/lib/test.c b/test/zdtm/lib/test.c
> index 76357da..5f12083 100644
> --- a/test/zdtm/lib/test.c
> +++ b/test/zdtm/lib/test.c
> @@ -292,7 +292,12 @@ pid_t fork()
>          * Two last arguments are swapped on different archs,
>          * but we don't care as they are zero anyway.
>          */
> +#ifdef __s390x__
> +       /* See kernel/fork.c: CONFIG_CLONE_BACKWARDS2 */
> +       return (pid_t)syscall(__NR_clone, 0, SIGCHLD, NULL, 0, NULL);
> +#else
>         return (pid_t)syscall(__NR_clone, SIGCHLD, 0, 0, 0, 0);
> +#endif
>  }
>
>  int getpid()
> --
> 2.7.4
>
> _______________________________________________
> CRIU mailing list
> CRIU@openvz.org
> https://lists.openvz.org/mailman/listinfo/criu



-- 
             Dmitry
