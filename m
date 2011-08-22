Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 22 Aug 2011 14:27:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] arch/s390/kernel/ipl.c: correct error detection check
Message-ID: <20110822122732.GA9280@osiris.boeblingen.de.ibm.com>
References: <1314013594-25651-1-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1314013594-25651-1-git-send-email-julia@diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, kernel-janitors@vger.kernel.org, linux390@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, sumsaha@gmail.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 22, 2011 at 01:46:34PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> reipl_fcp_kset was just initialized, so it appears that it should be tested
> instead of reipl_kset.
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> Reported-by: Suman Saha <sumsaha@gmail.com>

Applied. Thanks!
