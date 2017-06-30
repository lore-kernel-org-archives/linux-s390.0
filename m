From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 30 Jun 2017 13:03:12 +0000
Subject: Re: [CRIU] [PATCH v2 05/17] s390:criu: Enable s390 in criu
Message-Id: <CAJwJo6Ycx3555x4aXENVZOEJ1NaXFs-w+2Dw0L9D1YM4ArosgA@mail.gmail.com>
In-Reply-To: <20170629192445.55580-6-holzheu@linux.vnet.ibm.com>
References: <20170629192445.55580-6-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, openvz-criu@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2017-06-29 22:24 GMT+03:00 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> Add s390 parts to common code files.
>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>

...
> @@ -202,17 +208,24 @@ err_oob:
>         return -EFAULT;
>  }
>
> +/* On s390x Hash_t is 64 bit */
> +#ifdef __s390x__
> +typedef unsigned long Hash_t;
> +#else
> +typedef Word_t Hash_t;
> +#endif

Just for prettifying a bit, may we move it to platform-depended
Elf types definitions to criu/include/util-vdso.h?
Just a preference, may be left if it looks better for you as-is.

-- 
             Dmitry
