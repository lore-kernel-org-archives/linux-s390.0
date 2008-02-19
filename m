Return-Path: <linux-kernel-owner+w=401wt.eu-S1758931AbYBSPOP@vger.kernel.org>
Date: Tue, 19 Feb 2008 16:13:55 +0100
From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [patch 07/13] Initialize per cpu lowcores on cpu hotplug.
Message-ID: <20080219151355.GA24547@wavehammer.waldi.eu.org>
References: <20080219144047.587547541@de.ibm.com> <20080219144504.392301782@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20080219144504.392301782@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 19, 2008 at 03:40:54PM +0100, Martin Schwidefsky wrote:
> +	/*
> +	 * Only need to copy the first 512 bytes from address 0. But since
> +	 * the compiler emits a warning if src == NULL for memcpy use copy_page
> +	 * instead. Copies more than needed but this code is not performance
> +	 * critical.
> +	 */
> +	copy_page(lowcore, &S390_lowcore);

Boah, workaround alert. Why do you not fix the compiler?

Bastian

-- 
We fight only when there is no other choice.  We prefer the ways of
peaceful contact.
		-- Kirk, "Spectre of the Gun", stardate 4385.3
