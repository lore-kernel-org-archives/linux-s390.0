Return-Path: <akpm@linux-foundation.org>
Date: Wed, 24 Oct 2007 16:33:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] taskstats scaled time cleanup
Message-Id: <20071024163305.14b9bfba.akpm@linux-foundation.org>
In-Reply-To: <8789.1193208897@neuling.org>
References: <8789.1193208897@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com, balbir@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 24 Oct 2007 16:54:57 +1000
Michael Neuling <mikey@neuling.org> wrote:

> +/* Estimate the scaled cputime by scaling the real cputime based on
> + * the last scaled to real ratio */
> +static inline cputime_t cputime_to_scaled(const cputime_t ct)
> +{
> +	if (cpu_has_feature(CPU_FTR_SPURR) &&
> +	    per_cpu(cputime_last_delta, smp_processor_id()))
> +		return ct *
> +			per_cpu(cputime_scaled_last_delta, smp_processor_id())/
> +			per_cpu(cputime_last_delta, smp_processor_id());
> +	return ct;
> +}

This looks far too large to be inlined.
