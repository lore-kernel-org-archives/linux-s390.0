From: shuah <shuah@kernel.org>
Subject: Re: [PATCH v5 2/3] s390: Fix vDSO clock_getres()
Date: Thu, 30 May 2019 08:29:38 -0600
Message-ID: <dbcf69ff-1fe7-3a2e-5940-11fed052d45e@kernel.org>
References: <20190528120446.48911-1-vincenzo.frascino@arm.com>
 <20190528120446.48911-3-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190528120446.48911-3-vincenzo.frascino@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Shuah Khan <skhan@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, shuah <shuah@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 5/28/19 6:04 AM, Vincenzo Frascino wrote:
> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>      sec = 0;
>      ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the s390 vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
> Note: This patch is independent from the others in this series, hence it
> can be merged singularly by the s390 maintainers.
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
