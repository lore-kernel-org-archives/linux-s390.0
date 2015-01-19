Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Jan 2015 13:15:28 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] [linux-next] s390: Dump check for CONFIG_ZFCPDUMP
Message-ID: <20150119121528.GA5151@osiris>
References: <1421400905.15194.15.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421400905.15194.15.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Valentin Rothberg <valentinrothberg@gmail.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 16, 2015 at 10:35:05AM +0100, Paul Bolle wrote:
> Commit 725908110a1f ("s390: add SMT support") added a check for
> CONFIG_ZFCPDUMP. But the Kconfig symbol ZFCPDUMP was removed in v3.16
> through commit bf28a5970de3 ("s390/dump: Remove CONFIG_ZFCPDUMP"). So
> this check will always evaluate to false. No one noticed probably
> because the code also checks for CONFIG_CRASH_DUMP which "also enables
> s390 zfcpdump".
> 
> Dump the unneeded check.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied, thanks.
