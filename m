Return-Path: <linux-kernel-owner+w=401wt.eu-S1759428AbYFYPhs@vger.kernel.org>
Date: Wed, 25 Jun 2008 17:15:44 +0200
From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [patch 07/21] Cleanup sclp printk messages.
Message-ID: <20080625151544.GA12945@wavehammer.waldi.eu.org>
References: <20080625143459.100139455@de.ibm.com> <20080625143613.141370129@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20080625143613.141370129@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jun 25, 2008 at 04:35:06PM +0200, Martin Schwidefsky wrote:
> +	if (finished_sccb != (u32) (addr_t) sclp_init_sccb)
> +		panic("sclp: unsolicited interrupt for buffer at 0x%x\n",
> +		      finished_sccb);

Does that really need to be a panic?

Bastian

-- 
Extreme feminine beauty is always disturbing.
		-- Spock, "The Cloud Minders", stardate 5818.4
