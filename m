Return-Path: <linux-kernel-owner+w=401wt.eu-S934110AbZHWURo@vger.kernel.org>
Date: Sun, 23 Aug 2009 22:15:26 +0200
From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [GIT PULL] s390 patches for v2.6.31-rc7
Message-ID: <20090823201526.GA30461@wavehammer.waldi.eu.org>
References: <20090823213714.11757b14@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20090823213714.11757b14@skybase>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Aug 23, 2009 at 09:37:14PM +0200, Martin Schwidefsky wrote:
> +static void __init set_preferred_console(void)
> +{
> +	if (MACHINE_IS_KVM) {
> +		add_preferred_console("hvc", 0, NULL);
> +		s390_virtio_console_init();
> +		return;
> +	}

Why this early return instead of else if as all options are mutually
exclusive? Also why do you init the virtio console here instead of an
console_initcall?

Bastian

-- 
Four thousand throats may be cut in one night by a running man.
		-- Klingon Soldier, "Day of the Dove", stardate unknown
