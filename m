Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170516114812.10660-10-hch@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-10-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 May 2017 21:43:34 +0200
Message-ID: <CAK8P3a0OSuU+0GU9fdwF7ShuctiwZ3L=5zDuD_-HCA=M2_yP-g@mail.gmail.com>
Subject: Re: [PATCH 9/9] timers: remove old timer initialization macros
Content-Type: text/plain; charset="UTF-8"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 16, 2017 at 1:48 PM, Christoph Hellwig <hch@lst.de> wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/timer.h | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 87afe52c8349..9c6694d3f66a 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -80,35 +80,19 @@ struct timer_list {
>         struct timer_list _name = INIT_TIMER(_func, _expires, _flags)
>
>  /*
> - * Don't use the macros below, use DECLARE_TIMER and INIT_TIMER with their
> + * Don't use the macro below, use DECLARE_TIMER and INIT_TIMER with their
>   * improved callback signature above.
>   */
> -#define __TIMER_INITIALIZER(_function, _expires, _data, _flags) { \
> +#define DEFINE_TIMER(_name, _function, _expires, _data)                \
> +       struct timer_list _name = {                             \
>                 .entry = { .next = TIMER_ENTRY_STATIC },        \
>                 .function = (_function),                        \
>                 .expires = (_expires),                          \
>                 .data = (_data),                                \
> -               .flags = (_flags),                              \
>                 __TIMER_LOCKDEP_MAP_INITIALIZER(                \
>                         __FILE__ ":" __stringify(__LINE__))     \
>         }

Not sure what to do about it, but I notice that the '_expires'
argument is completely
bogus, I don't see any way it could be used in a meaningful way, and the only
user that passes anything other than zero is arch/mips/mti-malta/malta-display.c
and that seems to be unintentional.

      Arnd
